;;; evil-better-visual-move.el --- gj and gk visual line mode fix  -*- lexical-binding: t; -*-

;; Copyright (C) 2018 Patrick Nuckolls

;; Author:  <nuckollsp at gmail.com>
;; Version: 0.1
;; Package-Requires: ((evil "1.2.13"))
;; Keywords: evil, vim, motion

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Provides `evil-better-visual-move/next-line' and
;; `evil-better-visual-move/previous-line', which act like
;; `evil-next-visual-line' and `evil-previous-visual-line'
;; unless in visual line or visual block mode, in which case
;; they act as `evil-next-line' and `evil-previous-line'.
;;
;; Also provides `evil-better-visual-move/on', which bind
;; j and

;;; Code:

(require 'evil)
(require 'evil-macros)

;;;###autoload
(evil-define-motion evil-better-visual-move/next-line (count)
  "Wrapper for `evil-next-visual-line' ignores the visual in visual-line mode"
  :type line
  (if (or (not evil-visual-state-minor-mode) (eq (evil-visual-type) 'inclusive))
      (evil-next-visual-line count)
    (evil-next-line count)))

;;;###autoload
(evil-define-motion evil-better-visual-move/previous-line (count)
  "Wrapper for `evil-previous-visual-line' ignores the visual in visual-line mode"
  :type line
  (if (or (not evil-visual-state-minor-mode) (eq (evil-visual-type) 'inclusive))
      (evil-previous-visual-line count)
    (evil-previous-line count)))

;;;###autoload
(defun evil-better-visual-move/on ()
  (interactive)
  (define-key evil-operator-state-map "j" #'evil-better-visual-move/next-line)
  (define-key evil-normal-state-map "j" #'evil-better-visual-move/next-line)
  (define-key evil-visual-state-map "j" #'evil-better-visual-move/next-line)
  (define-key evil-operator-state-map "k" #'evil-better-visual-move/previous-line)
  (define-key evil-normal-state-map "k" #'evil-better-visual-move/previous-line)
  (define-key evil-visual-state-map "k" #'evil-better-visual-move/previous-line)
  )

(provide 'evil-better-visual-move)
;;; evil-better-visual-move.el ends here
