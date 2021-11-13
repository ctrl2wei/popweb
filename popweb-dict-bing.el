;;; popweb-dict-bing.el --- Bing dict plugin for popweb

;; Filename: popweb-dict-bing.el
;; Description: Bing dict plugin for popweb
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2021, Andy Stewart, all rights reserved.
;; Created: 2021-11-13 23:11:15
;; Version: 0.1
;; Last-Updated: 2021-11-13 23:11:15
;;           By: Andy Stewart
;; URL: https://www.github.org/manateelazycat/popweb-dict-bing
;; Keywords:
;; Compatibility: GNU Emacs 29.0.50
;;
;; Features that might be required by this library:
;;
;;
;;

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; Bing dict plugin for popweb
;;

;;; Installation:
;;
;; Put popweb-dict-bing.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'popweb-dict-bing)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET popweb-dict-bing RET
;;

;;; Change log:
;;
;; 2021/11/13
;;      * First released.
;;

;;; Acknowledgements:
;;
;;
;;

;;; TODO
;;
;;
;;

;;; Require
(require 'popweb)

;;; Code:

(defvar popweb-dict-bing-visible-p nil)

(defun popweb-dict-bing-translate (info)
  (let* ((position (popweb-get-cursor-coordinate))
         (x (car position))
         (y (cdr position))
         (offset 30)
         (width 0.3)
         (height 0.5)
         (url (format "https://www.bing.com/dict/search?q=%s" (nth 0 info)))
         (js-code "window.scrollTo(0, 0); document.getElementsByTagName('html')[0].style.visibility = 'hidden'; document.getElementsByClassName('lf_area')[0].style.visibility = 'visible'; document.getElementsByTagName('header')[0].style.display = 'none'; document.getElementsByClassName('contentPadding')[0].style.padding = '10px';"))
    (popweb-call-async "pop_web_window" x y offset width height url js-code)
    (run-with-timer 1 nil '(lambda () (setq popweb-dict-bing-visible-p t)))))

(defun popweb-dict-bing (&optional word)
  (interactive)
  (popweb-call 'popweb-dict-bing-translate (list (or word (popweb-prompt-input)))))

(defun popweb-dict-bing-hide-after-move ()
  (when popweb-dict-bing-visible-p
    (popweb-call-async "hide_web_window")
    (setq popweb-dict-bing-visible-p nil)))

(add-hook 'post-command-hook 'popweb-dict-bing-hide-after-move)

(provide 'popweb-dict-bing)

;;; popweb-dict-bing.el ends here
