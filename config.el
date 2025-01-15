;; Make Org mode work with files ending in .org

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "IosevkaTerm Nerd Font" :size 12 :weight 'regular)
     doom-variable-pitch-font (font-spec :family "Overpass" :size 12 :weight 'regular))


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-roam-directory "~/org/")

(setq debug-on-error t)

;;;;Org mode configuration
;; Enable Org mode
;; (require 'org)
;; (require 'org-fragtog)
;; (require 'org-appear)

(use-package! org-fragtog
  :after org
  :config
  (setq org-fragtog-preview-delay 0.3))  ; Adjust delay to your preference

(use-package! org-appear
  :after org
  )

(use-package! org-roam
  :after org
  :init
  :config
  (map! "C-c n l" #'org-roam-buffer-toggle
         "C-c n f" #'org-roam-node-find
         "C-c n g" #'org-roam-graph
         "C-c n i" #'org-roam-node-insert
         "C-c n c" #'org-roam-capture
         ;; Dailies
         "C-c n j" #'org-roam-dailies-capture-today)
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol)
  )

(after! org
  ;; Configure LaTeX preview settings for dvisvgm
  (add-hook 'org-mode-hook (lambda ()
    (turn-on-org-cdlatex)
    (variable-pitch-mode 1)
    (org-toggle-pretty-entities)
    (org-fragtog-mode)
    (org-appear-mode)
    (+org-pretty-mode)
    ))

  (setq org-preview-latex-default-process 'dvisvgm
        org-format-latex-options
        (plist-put org-format-latex-options :scale 1.5)
        org-latex-create-formula-image-program 'dvisvgm))


;; (after! org
;;   ;; (use-package! org-fragtog)
;;   ;; (use-package! org-appear)
;;   (setq org-latex-create-formula-image-program 'dvisvgm)  ; Use dvisvgm for better quality
;;   (setq org-preview-latex-default-process 'dvisvgm)

;;   ;; First enable the modes we need
;;   (add-hook 'org-mode-hook (lambda ()
;;     ;; (turn-on-org-cdlatex)
;;     (variable-pitch-mode 1)
;;     ;; (org-toggle-pretty-entities)
;;     ))

;;
;; Configure org-appear if needed
;;   ;; (setq org-appear-trigger 'manual)
;;   ;; (setq org-appear-delay 0.3)
;;   )

;; (setq org-appear-trigger 'manual)
;; (add-hook 'org-mode-hook (lambda ()
;;                            (add-hook 'evil-insert-state-entry-hook
;;                                      #'org-appear-manual-start
;;                                      nil
;;                                      t)
;;                            (add-hook 'evil-insert-state-exit-hook
;;                                      #'org-appear-manual-stop
;;                                      nil
;;                                      t)))
;; (after! org
;;   (require 'org-fragtog)
;;   (require 'org-appear)

;;   (add-hook 'org-mode-hook #'turn-on-org-cdlatex)
;;   (add-hook 'org-mode-hook 'org-fragtog-mode)
;;   (add-hook 'org-mode-hook 'org-appear-mode)
;;   (add-hook 'org-mode-hook 'org-toggle-pretty-entities)
;;   (add-hook 'org-mode-hook 'variable-pitch-mode))

;; (after! org
;; )

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
;;   (add-hook 'org-mode-hook (lambda ()
;;     ;; (turn-on-org-cdlatex)
;;     (variable-pitch-mode 1)
;;     ;; (org-toggle-pretty-entities)
;;     ))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-gruvbox)
;; (load-theme 'doom-gruvbox t)
(use-package gruvbox-theme
  :ensure nil
  :config
  (progn
    (defvar after-load-theme-hook nil
      "Hook run after a color theme is loaded using `load-theme'.")
    (defadvice load-theme (after run-after-load-theme-hook activate)
      "Run `after-load-theme-hook'."
      (run-hooks 'after-load-theme-hook))
    (defun customize-gruvbox ()
      "Customize gruvbox theme"
      (if (member 'gruvbox custom-enabled-themes)
          (custom-theme-set-faces
           'gruvbox
           '(cursor                 ((t (:foreground "#928374"))))
           '(org-block              ((t (:foreground "#ebdbb2":background "#1c2021" :extend t))))
           '(org-block-begin-line   ((t (:inherit org-block :background "#1d2021" :foreground "#665c54" :extend t))))
           '(org-block-end-line     ((t (:inherit org-block-begin-line))))
           '(org-document-info      ((t (:foreground "#d5c4a1" :weight bold))))
           '(org-document-info-keyword    ((t (:inherit shadow))))
           '(org-document-title     ((t (:foreground "#fbf1c7" :weight bold :height 1.4))))
           '(org-meta-line          ((t (:inherit shadow))))
           '(org-target             ((t (:height 0.7 :inherit shadow))))
           '(org-link               ((t (:foreground "#b8bb26" :background "#32302f" :overline nil))))  ;;
           '(org-indent             ((t (:inherit org-hide))))
           '(org-indent             ((t (:inherit (org-hide fixed-pitch)))))
           '(org-footnote           ((t (:foreground "#8ec07c" :background "#32302f" :overline nil))))
           '(org-ref-cite-face      ((t (:foreground "#fabd2f" :background "#32302f" :overline nil))))  ;;
           '(org-ref-ref-face       ((t (:foreground "#83a598" :background "#32302f" :overline nil))))
           '(org-ref-label-face     ((t (:inherit shadow :box t))))
           '(org-drawer             ((t (:inherit shadow))))
           '(org-property-value     ((t (:inherit org-document-info))) t)
           '(org-tag                ((t (:inherit shadow))))
           '(org-date               ((t (:foreground "#83a598" :underline t))))
           '(org-verbatim           ((t (:inherit org-block :background "#3c3836" :foreground "#d5c4a1"))))
           '(org-code               ((t (:inherit org-verbatim :background "#3c3836" :foreground "#fe8019"))))
           '(org-quote              ((t (:inherit org-block :slant italic))))
           '(org-level-1            ((t (:foreground "#83a598" :background "#282828" :weight bold :height 1.1 :overline nil :extend t)))) ;; Blue
           '(org-level-2            ((t (:foreground "#8ec07c" :background "#282828" :weight bold :height 1.1 :overline nil :extend t)))) ;; Aqua
           '(org-level-3            ((t (:foreground "#b8bb26" :background "#282828" :weight bold :height 1.1 :overline nil :extend t)))) ;; Green
           '(org-level-4            ((t (:foreground "#fabd2f" :background "#282828" :weight bold :height 1.1 :overline nil :extend t)))) ;; Yellow
           '(org-level-5            ((t (:foreground "#fe8019" :background "#282828" :weight bold :height 1.1 :overline nil :extend t)))) ;; Orange
           '(org-level-6            ((t (:foreground "#fb4934" :background "#282828" :weight bold :height 1.1 :overline nil :extend t)))) ;; Red
           '(org-level-7            ((t (:foreground "#d3869b" :background "#282828" :weight bold :height 1.1 :overline nil :extend t)))) ;; Blue
           '(org-headline-done      ((t (:foreground "#928374" :background "#282828" :weight bold :overline nil :extend t)))) ;; Gray
           '(org-ellipsis           ((t (:inherit shadow :height 1.0 :weight bold :extend t))))
           '(org-table              ((t (:foreground "#d5c4a1" :background "#3c3836"))))

           ;; Doom-modeline settings
           '(doom-modeline-evil-insert-state   ((t (:foreground "#b8bb26" :weight bold)))) ;; Green
           '(doom-modeline-evil-emacs-state    ((t (:foreground "#b16286" :weight bold)))) ;; Purple
           '(doom-modeline-evil-normal-state   ((t (:foreground "#83a598" :weight bold)))) ;; Blue
           '(doom-modeline-evil-visual-state   ((t (:foreground "#fbf1c7" :weight bold)))) ;; Beige
           '(doom-modeline-evil-replace-state  ((t (:foreground "#fb4934" :weight bold)))) ;; Red
           '(doom-modeline-evil-operator-state ((t (:foreground "#fabd2f" :weight bold)))) ;; Yellow
           '(mode-line                         ((t (:background "#504945" :foreground "#d5c4a1"))))
           '(mode-line-inactive                ((t (:background "#3c3836" :foreground "#7c6f64"))))
           '(link                              ((t (:foreground "#b8bb26" :overline t))))

           '(line-number                       ((t (:background "#32302f" :foreground "#665c54"))))
           ;; Mu4E mail client faces
           '(mu4e-header-face                  ((t (:foreground "#d5c4a1" :background "#282828"))))
           '(mu4e-replied-face                 ((t (:inherit mu4e-header-face :foreground "#b8bb26"))))
           '(mu4e-draft-face                   ((t (:inherit mu4e-header-face :foreground "#fabd2f"))))
           '(mu4e-link-face                    ((t (:inherit mu4e-face :foreground "#8ec07c" :underline t))))
           '(mu4e-forwarded-face               ((t (:inherit mu4e-header-face :foreground "#80c07c"))))
           '(mu4e-flagged-face                 ((t (:inherit mu4e-header-face))))
           '(mu4e-header-highlight-face        ((t (:underline nil :background "#3c3836"))))
           '(mu4e-unread-face                  ((t (:foreground "#fbf1c7" :weight bold))))  ;; Originally #83a598
           '(mu4e-cited-1-face                 ((t (:foreground "#458588" :slant italic))))
           '(mu4e-cited-2-face                 ((t (:foreground "#689d6a" :slant italic))))
           '(mu4e-cited-3-face                 ((t (:foreground "#98971a" :slant italic))))
           '(mu4e-cited-4-face                 ((t (:foreground "#d79921" :slant italic))))
           '(mu4e-cited-5-face                 ((t (:foreground "#d65d0e" :slant italic))))
           '(mu4e-cited-6-face                 ((t (:foreground "#cc241d" :slant italic))))
           '(mu4e-cited-7-face                 ((t (:foreground "#b16286" :slant italic))))
           '(mu4e-cited-8-face                 ((t (:foreground "#458588" :slant italic))))
           '(mu4e-cited-9-face                 ((t (:foreground "#689d6a" :slant italic))))
           '(mu4e-cited-10-face                 ((t (:foreground "#98971a" :slant italic))))
           '(mu4e-cited-11-face                 ((t (:foreground "#d79921" :slant italic))))
           '(mu4e-cited-12-face                 ((t (:foreground "#d65d0e" :slant italic))))
           '(mu4e-cited-13-face                 ((t (:foreground "#cc241d" :slant italic))))
           '(mu4e-cited-14-face                 ((t (:foreground "#b16286" :slant italic))))
           '(pdf-view-midnight-colors           '("#d5c4a1" . "#282828"))
           )
        (setq org-n-level-faces 8)
        ) ;; test
      )
    (add-hook 'after-load-theme-hook 'customize-gruvbox)
    )
  (load-theme 'gruvbox t)
  (enable-theme 'gruvbox)
  )

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Enable transient mark mode
(transient-mark-mode 1)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
