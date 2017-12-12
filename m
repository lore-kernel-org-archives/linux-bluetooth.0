Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171211130452.10363-1-luiz.dentz@gmail.com>
References: <20171211130452.10363-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 12 Dec 2017 09:54:05 -0200
Message-ID: <CABBYNZLC5EmQqa25mPEuM-Cwcpcdta4P3sRBv3dfSsR9ZhfO8Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shell: Add exists callback
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Dec 11, 2017 at 11:04 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds a callback to check if the menu exists at runtime.
> ---
>  src/shared/shell.c | 58 ++++++++++++++++++++++++++++++++----------------------
>  src/shared/shell.h |  4 ++++
>  2 files changed, 39 insertions(+), 23 deletions(-)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index f20c74901..3aa49597c 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -145,6 +145,17 @@ static void cmd_menu(int argc, char *argv[])
>         shell_print_menu();
>  }
>
> +static bool cmd_menu_exists(const struct bt_shell_menu *menu)
> +{
> +       /* Skip menu command if not on main menu or if there are no
> +        * submenus.
> +        */
> +       if (menu != data.main || queue_isempty(data.submenus))
> +               return false;
> +
> +       return true;
> +}
> +
>  static void cmd_back(int argc, char *argv[])
>  {
>         if (data.menu == data.main) {
> @@ -157,10 +168,21 @@ static void cmd_back(int argc, char *argv[])
>         shell_print_menu();
>  }
>
> +static bool cmd_back_exists(const struct bt_shell_menu *menu)
> +{
> +       /* Skip back command if on main menu */
> +       if (menu == data.main)
> +               return false;
> +
> +       return true;
> +}
> +
>  static const struct bt_shell_menu_entry default_menu[] = {
> -       { "back",         NULL,       cmd_back, "Return to main menu" },
> +       { "back",         NULL,       cmd_back, "Return to main menu", NULL,
> +                                                       NULL, cmd_back_exists },
>         { "menu",         "<name>",   cmd_menu, "Select submenu",
> -                                                       menu_generator },
> +                                                       menu_generator, NULL,
> +                                                       cmd_menu_exists},
>         { "version",      NULL,       cmd_version, "Display version" },
>         { "quit",         NULL,       cmd_quit, "Quit program" },
>         { "exit",         NULL,       cmd_quit, "Quit program" },
> @@ -169,22 +191,6 @@ static const struct bt_shell_menu_entry default_menu[] = {
>         { }
>  };
>
> -static bool command_isskipped(const char *cmd)
> -{
> -       /* Skip menu command if not on main menu or if there are no
> -        * submenus.
> -        */
> -       if (!strcmp(cmd, "menu") &&
> -               (data.menu != data.main || queue_isempty(data.submenus)))
> -               return true;
> -
> -       /* Skip back command if on main menu */
> -       if (data.menu == data.main && !strcmp(cmd, "back"))
> -               return true;
> -
> -       return false;
> -}
> -
>  static void shell_print_menu(void)
>  {
>         const struct bt_shell_menu_entry *entry;
> @@ -211,7 +217,7 @@ static void shell_print_menu(void)
>         }
>
>         for (entry = default_menu; entry->cmd; entry++) {
> -               if (command_isskipped(entry->cmd))
> +               if (entry->exists && !entry->exists(data.menu))
>                         continue;
>
>                 print_menu(entry->cmd, entry->arg ? : "", entry->desc ? : "");
> @@ -490,16 +496,22 @@ done:
>  static char *find_cmd(const char *text,
>                         const struct bt_shell_menu_entry *entry, int *index)
>  {
> -       const char *cmd;
> +       const struct bt_shell_menu_entry *tmp;
>         int len;
>
>         len = strlen(text);
>
> -       while ((cmd = entry[*index].cmd)) {
> +       while ((tmp = &entry[*index])) {
>                 (*index)++;
>
> -               if (!strncmp(cmd, text, len) && !command_isskipped(cmd))
> -                       return strdup(cmd);
> +               if (!tmp->cmd)
> +                       break;
> +
> +               if (tmp->exists && !tmp->exists(data.menu))
> +                       continue;
> +
> +               if (!strncmp(tmp->cmd, text, len))
> +                       return strdup(tmp->cmd);
>         }
>
>         return NULL;
> diff --git a/src/shared/shell.h b/src/shared/shell.h
> index 2b9e918d6..5f86ed61e 100644
> --- a/src/shared/shell.h
> +++ b/src/shared/shell.h
> @@ -31,11 +31,14 @@
>  #define COLOR_BOLDWHITE        "\x1B[1;37m"
>  #define COLOR_HIGHLIGHT        "\x1B[1;39m"
>
> +struct bt_shell_menu;
> +
>  typedef void (*bt_shell_menu_cb_t)(int argc, char *argv[]);
>  typedef char * (*bt_shell_menu_gen_t)(const char *text, int state);
>  typedef void (*bt_shell_menu_disp_t) (char **matches, int num_matches,
>                                                         int max_length);
>  typedef void (*bt_shell_prompt_input_func) (const char *input, void *user_data);
> +typedef bool (*bt_shell_menu_exists_t) (const struct bt_shell_menu *menu);
>
>  struct bt_shell_menu_entry {
>         const char *cmd;
> @@ -44,6 +47,7 @@ struct bt_shell_menu_entry {
>         const char *desc;
>         bt_shell_menu_gen_t gen;
>         bt_shell_menu_disp_t disp;
> +       bt_shell_menu_exists_t exists;
>  };
>
>  struct bt_shell_menu {
> --
> 2.13.6

Applied.


-- 
Luiz Augusto von Dentz
