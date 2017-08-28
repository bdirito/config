;;; FILE: .emacs (with a period as the first character of the filename)
;;;
;;; This is a small emacs initialization file. You may use and modify
;;; this file as you like. For a Linux system, put .emacs in your own home
;;; directory. For Windows 95, put .emacs in c:\.emacs.

(modify-frame-parameters nil '((wait-for-wm . nil)))

;;; default font
(set-default-font "Source Code Pro Light-11")

;; melpha
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; auto reverts files when changed on disk
(global-auto-revert-mode)
(auto-revert-mode)

;; ido support
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-create-new-buffer 'always)

(load-theme 'deeper-blue t)

;; allows you to open files in an existing emacs session from a shell
;(server-start)
(setq load-path (cons "/usr/share/emacs/site-lisp" load-path))
;(setq load-path (cons "/usr/share/emacs/site-lisp/ocaml-mode" load-path))


;(setq load-path (cons "~/.emacs.d/themes" load-path))
(setq load-path (cons "~/.emacs.d/lisp" load-path))
;(setq load-path (cons "~/.emacs.d/ocaml-mode" load-path))
;(load-library "camldebug")
;(load-library "php-mode")
;(load-library "python-mode")
;(load-library "ruby-mode")
;(load-library "color-theme")
;(load-library "color-theme-library")
;(load "~/.emacs.d/haskell-mode/haskell-site-file")
(setq inhibit-splash-screen t)
(show-paren-mode 1)
;(require 'erlang-start)

;hunspell
(if (file-exists-p "/usr/bin/hunspell")
    (progn
      (setq ispell-program-name "hunspell")
      (setq ispell-dictionary "american"
            ispell-extra-args '("-a" "-i" "utf-8" "-d" "en_US")
            ispell-silently-savep t
            )))




; jdee
;(load-file (expand-file-name "/usr/share/emacs/site-lisp/cedet-common/cedet.el"))
;(require 'jde)

(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-selection-value)


;Add cmake listfile names to the mode list.
(autoload 'cmake-mode "cmake-mode.el" t)


;; turn off tool bar, menu bar, scroll bar
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode -1)

(setq scroll-step 1)
(setq-default scroll-step 1)

;; Tab shit
(setq toggle-tabs nil)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq standard-indent 4)

;; don't trucate shiz
(setq truncate-partial-width-windows nil)
(setq truncate-lines nil)

(autoload 'csharp-mode "csharp-mode"
"Major mode for editing C# code." t)
(setq auto-mode-alist (cons '( "\\.cs\\'" . csharp-mode ) auto-mode-alist ))
(setq auto-mode-alist (cons '( "\\.ml[iyl]?$" . caml-mode ) auto-mode-alist ))
;(if window-system (require 'caml-font))

;; ack
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)
; ubuntu only
(setq ack-executable (executable-find "ack-grep"))
(setq ack-prompt-for-directory t)

;; see your selections
(setq-default transient-mark-mode t)

;;; Cy's sytax highlighting
;;(require 'font-lock)
;; Turn on font-lock in all modes that support it
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode t))
(setq font-lock-maximum-decoration t)


;;; Michael's Preferences                  *** -------------------------------
(setq kill-whole-line t)                   ;;; Killing line also deletes \n
(setq next-line-add-newlines nil)          ;;; Down arrow won't add \n at end
(setq require-final-newline t)             ;;; Put \n at end of last line
(setq make-backup-files nil)               ;;; Don't make backup files
(setq line-number-mode t)                  ;;; Put line number in display
(setq default-major-mode 'text-mode)       ;;; New buffers are text mode
;(setq fill-column 80)                      ;;; Text lines limit to 80 chars
;(add-hook 'text-mode-hook 'turn-on-auto-fill); Line limit on in text mode
                                           ;;; -------------------------------

;;; Michael's
;;; Function
;;; Definitions:        *** --------------------------------------------------
;;;  indent-all         ;;; Indents buffer (use fset because of indent-region)
;;;  open-new-line      ;;; Open a new line after the current line
;;;  c-return           ;;; In c: indent & open indented new line
;;;  java-return        ;;; In java: indent & open indented new line
;;;  prolog-return      ;;; In prolog: indent & open indented new line
;;;  scheme-return      ;;; In scheme: indent & open indented new line
;;;  delete-whole-line  ;;; Delete all of a line
;;;  join-lines         ;;; Join this line with the next line
;;;  front              ;;; Move cursor to front of buffer
;;;  quit               ;;; Save files and quit emacs
;;;  exchange-mp        ;;; Exchange the cursor with the region's mark
;;;  split              ;;; Split window, move to other window, open new file
;;;                     *** --------------------------------------------------
(fset 'indent-all "\C-xh\C-[\C-\\")
(defun open-new-line( ) (interactive) (end-of-line) (newline-and-indent))
(defun c-return( ) (interactive) (c-indent-line) (newline-and-indent))
(defun java-return( ) (interactive) (c-indent-line) (newline-and-indent))
(defun prolog-return( ) (interactive) (prolog-indent-line) (newline-and-indent))
;;;(defun scheme-return( ) (interactive) (scheme-indent-line) (newline-and-indent))
(defun delete-whole-line( ) (interactive) (beginning-of-line) (kill-line))
(defun join-lines( ) (interactive) (end-of-line) (kill-line))
(defun front( ) (interactive) (beginning-of-buffer))
(defun quit( ) (interactive) (save-buffers-kill-emacs))
(defun exchange-mp( ) (interactive) (exchange-point-and-mark))
(defun split( ) (interactive)
    (split-window-vertically)
    (other-window 1)
)
(defun kill-something( ) (interactive)
    (if (and mark-active transient-mark-mode)
        (kill-region (point) (mark))
        (delete-backward-char 1)
    )
)
(defun to-tab-or-not-to-tab( ) (interactive)
  (if (not toggle-tabs)
      (setq-default indent-tabs-mode t tab-width 4 toggle-tabs 1)
      (setq-default indent-tabs-mode nil toggle-tabs nil)
  )
)

;;; Some key bindings                      *** ------------------------------
(global-set-key [8]  'delete-backward-char);;; Ctrl-h = Backspace
;(global-set-key [11] 'delete-whole-line)   ;;; Ctrl-k = Kill whole line
;;; Home, end, del keys                    *** --------------------------
(global-set-key [delete] 'delete-char) ;;; Delete = Delete char before cursor
(global-set-key [kp-delete] 'delete-char);; Delete = Delete char before cursor
;(global-set-key [delete]  'kill-something) ;;; Delete = Delete region or char
;(global-set-key [kp-delete] 'kill-something);; Delete = Delete region or char
(global-set-key [home] 'beginning-of-line) ;;; Home = Beginning of line
(global-set-key [kp-home] 'beginning-of-line); Home = Beginning of line
(global-set-key [kp-end] 'end-of-line)     ;;; End = End of line
(global-set-key [end] 'end-of-line)        ;;; End = End of line
(global-set-key [f1] 'help-command)        ;;; F1 = Help
(global-set-key [C-home] 'front)           ;;; Ctrl-Home = Front of buffer
(global-set-key [C-kp-home] 'front)        ;;; Ctrl-Home = Front of buffer
(global-set-key [C-kp-end] 'end-of-buffer) ;;; Ctrl-End = End of buffer
(global-set-key [C-end] 'end-of-buffer)    ;;; Ctrl End = End of buffer
;;; Keypad keys from VT-100                *** ------------------------------
(global-set-key "\M-[M" 'scroll-down)      ;;; PgUp = scroll-down
(global-set-key "\M-[H\M-[2J" 'scroll-up)  ;;; PgDn = scroll-up
(global-set-key "\M-[H\M-[H"               ;;; Home Home = start of line
'beginning-of-line)                     ;;;    (note: that's Home twice!)
(global-set-key "\M-[K" 'end-of-line)      ;;; End = end of line
(global-set-key "\M-[L" 'overwrite-mode)   ;;; Insert = toggle overwrite
(global-set-key "\M-OA" 'previous-line)    ;;; Up arrow = previous line
(global-set-key "\M-OB" 'next-line)        ;;; Down arrow = next line
(global-set-key "\M-OC" 'forward-char)     ;;; Right arrow = forward char
(global-set-key "\M-OD" 'backward-char)    ;;; Left arrow = backward char
(global-set-key "\e\e[H" 'front)           ;;; Esc Home = front of file
(global-set-key "\e\e[K" 'end-of-buffer)   ;;; Esc End = end of file
(global-set-key "\M-g" 'goto-line)         ;;; alt-g = goto line
(global-set-key (kbd "\e\el") 'compile)    ;;; Esc Esc l = compile
(global-set-key (kbd "\M-c") 'compile)     ;;; alt-c = compile
(global-set-key (kbd "\e\et") 'to-tab-or-not-to-tab)
(global-set-key "\M-n" 'next-error)        ;;; alt-n = goto next error
(global-set-key "\M-p" 'previous-error)    ;;; alt-p = goto previous error
(global-set-key "\C-c#" 'comment-region)     ;;; ctrl-x # comment region
(global-set-key "\C-c3" 'uncomment-region)     ;;; ctrl-x # comment region

;;; ------------------------------



;;; Michael's special actions upon entering various editing modes
;;; c-mode
(add-hook 'c-mode-hook
'(lambda()
        (local-set-key [13] 'c-return)        ;;; RET with automatic indent
        (local-set-key "\ep" 'indent-all)     ;;; esc-p pretty-prints file
        (c-set-style "bsd")                   ;;; Kernihan & Richie's style
        (setq c-basic-offset 4)               ;;; 4 spaces for indentations
        (c-set-offset 'substatement-open 0)   ;;; No indent for open bracket
    )
)
;;; c++-mode
(add-hook 'c++-mode-hook
   '(lambda()
        (local-set-key [13] 'c-return)        ;;; RET with automatic indent
        (local-set-key "\ep" 'indent-all)     ;;; esc-p pretty-prints file
        (c-set-style "bsd")                   ;;; Kernihan & Richie's style
        (setq c-basic-offset 4)               ;;; 4 spaces for indentations
        (c-set-offset 'substatement-open 0)   ;;; No indent for open bracket
    )
)
;;; jde-mode
(add-hook 'jde-mode-hook
   '(lambda()
        (local-set-key [13] 'java-return)     ;;; RET with automatic indent
        (local-set-key "\ep" 'indent-all)     ;;; esc-p pretty-prints file
        (c-set-style "k&r")                   ;;; Kernihan & Richie's style
        (setq java-basic-offset 4)            ;;; 4 spaces for indentations
        (c-set-offset 'substatement-open 0)   ;;; No indent for open bracket
    )
)
;;; java-mode
(add-hook 'java-mode-hook
   '(lambda()
        (local-set-key [13] 'java-return)     ;;; RET with automatic indent
        (local-set-key "\ep" 'indent-all)     ;;; esc-p pretty-prints file
;        (c-set-style "k&r")                   ;;; Kernihan & Richie's style
        (setq c-basic-offset 4)            ;;; 4 spaces for indentations
        (c-set-offset 'substatement-open 0)   ;;; No indent for open bracket
    )
)

;;; csharp-mode
(add-hook 'csharp-mode-hook
   '(lambda()
        (local-set-key "\ep" 'indent-all)     ;;; esc-p pretty-prints file
        (setq c-basic-offset 4)            ;;; 4 spaces for indentations
    )
)

;;; prolog-mode
(add-hook 'prolog-mode-hook
   '(lambda()
      (local-set-key [13] 'prolog-return)   ;;; RET with automatic indent
        (local-set-key "\ep" 'indent-all)     ;;; esc-p pretty-prints file
    )
)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)

;(add-hook 'python-mode-hook 'jedi:setup)
;(setq jedi:complete-on-dot t)

;;; scheme-mode
;;; This mode is not entirely to my liking because I prefer to place
;;; the closing parenthesis on a line of its own, lined up under its
;;; corresponding closing parenthesis. The modification of this mode
;;; to support that programming style is on my to-do list.
;;(add-hook 'scheme-mode-hook
;;  '(lambda()
;;        (local-set-key [13] 'scheme-return)   ;;; RET with automatic indent
;        (local-set-key "\ep" 'indent-all)      ;;; esc-p pretty-prints file
;        (setq lisp-indent-offset 4)           ;;; 4 spaces for indentation
;    )
;)


;;; Michael's connections between editing modes and file names:
;;; Files ending in .h or .template should be edited in c++-mode.
;;; Emacs already knows what to do with .c and .scm files.
;;; I haven't yet found a good mode for bison/flex files, so I just use
;;; indented-text-mode (where a TAB indents a line the same as last line).
(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.template$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cxx$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cpp$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cc$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.java$" . java-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("\\.pl$" . prolog-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.y$" . indented-text-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.lex$" . indented-text-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.sql$" . indented-text-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))

;;; From John Gillett's emacs file
;;; ---------------------------------------------------------------
;;; The following lines allow C-j to cause emacs to cycle among its
;;; buffers.  (This is a hack, but it seems to work.)
(defun jg-last (list)
  "returns last element of a list"
  (while (> (length list) 1)
    (setq list (cdr list)))
  (car list))

(defun jg-buffer-ring ()
  "switches among buffers on buffer list, killing the following
annoying buffers if they are encountered:
  *Completions*
  *Deletions*
  *Buffer List*
  *Help*
  *Minibuf-0*
  *Minibuf-1*
  *Minibuf-2*
  *scratch*
"
  (interactive)
  (setq loop t)
  (while loop
    (switch-to-buffer (jg-last (buffer-list)))
    (if (or (equal (buffer-name) "*Completions*")
            (equal (buffer-name) " *Deletions*")
            (equal (buffer-name) "*Messages*")
            (equal (buffer-name) "*Buffer List*")
            (equal (buffer-name) "*Help*")
            (equal (buffer-name) " *Minibuf-0*")
            (equal (buffer-name) " *Minibuf-1*")
            (equal (buffer-name) " *Minibuf-2*")
            ;; length test below prevents infinite loop: I kill buffer
            ;; *scratch*, emacs restarts it, repeat
            (and
             (> (length (buffer-list)) 2)
             (equal (buffer-name) "*scratch*"))
            )
        (kill-buffer (buffer-name))
      (setq loop nil))))

(global-set-key "\C-l" 'jg-buffer-ring)


;;; Uncomment the next two lines if you are in Windows and want ctrl-x ctrl-f
;;; to open the usual Windows file dialog box. You'll also have to copy
;;; www.cs.colorado.edu/~main/emacs/dlgopen.elc to \app\emacs\site-lisp and
;;; copy www.cs.colorado.edu/~main/emacs/getfiles.exe to \windows\command.
;;; (load "dlgopen")
;;; (global-set-key "\C-x\C-f" 'dlgopen-open-files)


;; color scheme
;(require 'color-theme)
;(if window-system
;    (color-theme-gnome2)
;    (color-theme-hober))
;    (font-lock-comment-delimiter-face ((t (:foreground "medium orchid"))))
;    (set-foreground-color "Wheat")
    ;(set-background-color "Black")
;  (set-cursor-color "Orchid")
;  (set-face-foreground 'font-lock-function-name-face "spring green")
;  (set-face-foreground 'font-lock-type-face "goldenrod"))

;Alex Schroeder's color stuff
(defun egoge-wash-out-colour (colour &optional degree)
  "Return a colour string specifying a washed-out version of COLOUR."
  (let ((basec (color-values
        (face-attribute 'default :foreground)))
    (col (color-values colour))
    (list nil))
    (unless degree (setq degree 2))
    (while col
      (push (/ (/ (+ (pop col)
             (* degree (pop basec)))
          (1+ degree))
           256)
        list))
    (apply 'format "#%02x%02x%02x" (nreverse list))))

(defun egoge-wash-out-face (face &optional degree)
  "Make the foreground colour of FACE appear a bit more pale."
  (let ((colour (face-attribute face :foreground)))
    (unless (eq colour 'unspecified)
      (set-face-attribute face nil
              :foreground (egoge-wash-out-colour colour degree)))))

(defun egoge-find-faces (regexp)
  "Return a list of all faces whose names match REGEXP."
  (delq nil
    (mapcar (lambda (face)
          (and (string-match regexp
                     (symbol-name face))
               face))
        (face-list))))

(defun egoge-wash-out-fontlock-faces (&optional degree)
  (mapc (lambda (elt)
      (egoge-wash-out-face elt degree))
    (delq 'font-lock-warning-face
          (egoge-find-faces "^font-lock"))))

;; change this for the default
(when (> (length (defined-colors)) 16)
  (egoge-wash-out-fontlock-faces 0))


;; saves emacs sessions
;; http://www.dotemacs.de/dotfiles/DaveGallucci.emacs.html
;; =====================================================================
;; =====================================================================
;; Saving Emacs Sessions - Useful when you have a bunch of source
;; files open and you don't want to go and manually open each one,
;; especially when they are in various directories. Page 377 of the
;; GNU Emacs Manual says: "The first time you save the state of the
;; Emacs session, you must do it manually, with the command M-x
;; desktop-save. Once you have dome that, exiting Emacs will save the
;; state again -- not only the present Emacs session, but also
;; subsequent sessions. You can also save the state at any time,
;; without exiting Emacs, by typing M-x desktop-save again.
;; =====================================================================
(load "desktop")
(desktop-load-default)
;(desktop-read)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f0a99f53cbf7b004ba0c1760aa14fd70f2eabafe4e62a2b3cf5cabae8203113b" "0e121ff9bef6937edad8dfcff7d88ac9219b5b4f1570fd1702e546a80dba0832" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "64581032564feda2b5f2cf389018b4b9906d98293d84d84142d90d7986032d33" "255104c2f5c857498231bc7efbd374026e4ad43547d6fdb4c08be95bc9c871bd" "72407995e2f9932fda3347e44e8c3f29879c5ed88da71f06ba4887b0596959a4" "ad9fc392386f4859d28fe4ef3803585b51557838dbc072762117adad37e83585" "49eea2857afb24808915643b1b5bd093eefb35424c758f502e98a03d0d3df4b1" "4eaad15465961fd26ef9eef3bee2f630a71d8a4b5b0a588dc851135302f69b16" "9dae95cdbed1505d45322ef8b5aa90ccb6cb59e0ff26fef0b8f411dfc416c552" "ed5af4af1d148dc4e0e79e4215c85e7ed21488d63303ddde27880ea91112b07e" "2b5aa66b7d5be41b18cc67f3286ae664134b95ccc4a86c9339c886dfd736132d" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(ecb-options-version "2.32")
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(load-home-init-file t t)
 '(package-selected-packages
   (quote
    (yaml-mode ack tide typescript-mode whitespace-cleanup-mode web-mode nyan-mode js2-mode jinja2-mode coffee-mode))))
 '(show-paren-mode t)
 '(tool-bar-mode nil)



;; http://www.dotemacs.de/dotfiles/SteveDodd.emacs.html
;; (Copied from:
;; INTELLIMOUSE SETUP
;; . Wheel forward/backwards scrolls by 10 lines
;; . Shift + wheel forward/backwards scrolls by 1 line
;;   (change mwheel-scroll-amount to change these defaults).
;; . Bind control + wheel scroll to undo
;; . Set wheel action focus to follow mouse pointer NOT cursor. (Change
;;   mwheel-follow-mouse to "nil" to get wheel to only act on the window
;;   containing the text cursor.
;;
;; * Please see the copyright notice below for original copyright stuff.
;;   I have made a few small changes to the code, such as the undo binding to
;;   the wheel, contact me at sdodd@udnergrad.math.uwaterloo.ca for the
;;   original code, or the maintainer below.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mwheel.el --- Mouse support for MS intelli-mouse type mice
;; Copyright (C) 1998, Free Software Foundation, Inc.
;; Maintainer: William M. Perry <wmperry@cs.indiana.edu>
;; Keywords: mouse
;; This file is part of XEmacs.
;; XEmacs is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;; XEmacs is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; You should have received a copy of the GNU General Public License
;; along with XEmacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.
;; Synched up with: Not synched.
;; Commentary:
;; Code:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'custom)
(require 'cl)
(defconst mwheel-running-xemacs (string-match "XEmacs" (emacs-version)))
(defcustom mwheel-scroll-amount '(10 . 1)
  "Amount to scroll windows by when spinning the mouse wheel.
This is actually a cons cell, where the first item is the amount to scroll
on a normal wheel event, and the second is the amount to scroll when the
wheel is moved with the shift key depressed.
This should be the number of lines to scroll, or `nil' for near
full screen.
A near full screen is `next-screen-context-lines' less than a full screen."
  :group 'mouse
  :type '(cons
          (choice :tag "Normal"
                  (const :tag "Full screen" :value nil)
                  (integer :tag "Specific # of lines"))
          (choice :tag "Shifted"
                  (const :tag "Full screen" :value nil)
                  (integer :tag "Specific # of lines"))))

;; Change to nil to only scroll the window the cursor is in (not the pointer)
(defcustom mwheel-follow-mouse 1
  "Whether the mouse wheel should scroll the window that the mouse is over.
This can be slightly disconcerting, but some people may prefer it."
  :group 'mouse
  :type 'boolean)

(if (not (fboundp 'event-button))
    (defun mwheel-event-button (event)
      (let ((x (symbol-name (event-basic-type event))))
        (if (not (string-match "^mouse-\\([0-9]+\\)" x))
            (error "Not a button event: %S" event))
        (string-to-int (substring x (match-beginning 1) (match-end 1)))))
  (fset 'mwheel-event-button 'event-button))

(if (not (fboundp 'event-window))
    (defun mwheel-event-window (event)
      (posn-window (event-start event)))
  (fset 'mwheel-event-window 'event-window))

(defun mwheel-scroll (event)
  (interactive "e")
  (let ((curwin (if mwheel-follow-mouse
                    (prog1
                        (selected-window)
                      (select-window (mwheel-event-window event)))))
        (amt (if (memq 'shift (event-modifiers event))
                 (cdr mwheel-scroll-amount)
               (car mwheel-scroll-amount))))
    (case (mwheel-event-button event)
      (4 (scroll-down amt))
      (5 (scroll-up amt))
      (otherwise (error "Bad binding in mwheel-scroll")))
    (if curwin (select-window curwin))))

(defun mwheel-undo (event)
  (interactive "e")
  (let ((curwin (if mwheel-follow-mouse
                    (prog1
                        (selected-window)
                      (select-window (mwheel-event-window event)))))
        )
    (case (mwheel-event-button event)
      (4 (undo))
      (5 (undo))
      (otherwise (error "Bad binding in mwheel-scroll")))
    (if curwin (select-window curwin))))

(define-key global-map
  (if mwheel-running-xemacs 'button4 [mouse-4]) 'mwheel-scroll)
(define-key global-map
  (if mwheel-running-xemacs 'button5 [mouse-5])  'mwheel-scroll)
(define-key global-map
  (if mwheel-running-xemacs [(shift button4)] [S-mouse-4]) 'mwheel-scroll)
(define-key global-map
  (if mwheel-running-xemacs [(shift button5)] [S-mouse-5]) 'mwheel-scroll)
(define-key global-map
  (if mwheel-running-xemacs [(control button4)] [C-mouse-4]) 'mwheel-undo)
(define-key global-map
  (if mwheel-running-xemacs [(control button5)] [C-mouse-5]) 'mwheel-undo)
(provide 'mwheel)


;;; cmake mode

;; cmake mode
(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))

;; bdirito changes

;; python-mode style indents for coffee-mode 'C-c <' vs 'C-c C-<'
(defvar coffee-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c <") 'coffee-indent-shift-left)
    (define-key map (kbd "C-c >") 'coffee-indent-shift-right)
    map)
  "Customizations for coffee-mode.")
;; yaml hooks
(defun indent-rigidly-n (n)
  "Indent the region, or otherwise the current line, by N spaces."
  (let* ((use-region (and transient-mark-mode mark-active))
         (rstart (if use-region (region-beginning) (point-at-bol)))
         (rend   (if use-region (region-end)       (point-at-eol)))
         (deactivate-mark "irrelevant")) ; avoid deactivating mark
    (indent-rigidly rstart rend n)))
(defvar yaml-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c <") (lambda() (interactive) (indent-rigidly-n -2)))
    (define-key map (kbd "C-c >") (lambda() (interactive) (indent-rigidly-n 2)))
    map)
  "Customizations for yaml-mode.")

(global-whitespace-cleanup-mode)
(setq whitespace-cleanup-mode-only-if-initially-clean nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
