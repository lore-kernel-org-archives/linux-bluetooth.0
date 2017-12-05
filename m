Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c4eddf56-ffe9-ac1c-86c0-5fdca37a6477@jp.fujitsu.com>
References: <c4eddf56-ffe9-ac1c-86c0-5fdca37a6477@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 5 Dec 2017 20:22:33 +0200
Message-ID: <CABBYNZK3B72xpOCqaTHCn8d6Hotnjk+W6g-4iJiezVhen_OTKw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/shell: Fix no version output with option
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Tue, Dec 5, 2017 at 2:23 PM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> bluetoothctl does output the following error message with the option
> -v/--version.
>
>   $ bluetoothctl --version
>   Unknown option --version
> ---
>  client/agent.c     |  2 ++
>  client/main.c      | 18 +-----------------
>  src/shared/shell.c |  5 ++++-
>  src/shared/shell.h |  2 +-
>  4 files changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/client/agent.c b/client/agent.c
> index e8ca4dd19..70c3248c0 100644
> --- a/client/agent.c
> +++ b/client/agent.c
> @@ -31,6 +31,8 @@
>  #include <unistd.h>
>  #include <string.h>
>
> +#include <glib.h>
> +
>  #include "src/shared/shell.h"
>  #include "gdbus/gdbus.h"
>  #include "agent.h"
> diff --git a/client/main.c b/client/main.c
> index 7661b33c0..98123d53a 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -2369,27 +2369,11 @@ static void client_ready(GDBusClient *client, void *user_data)
>
>  int main(int argc, char *argv[])
>  {
> -       GOptionContext *context;
> -       GError *error = NULL;
>         GDBusClient *client;
>
>         auto_register_agent = g_strdup("");
>
> -       context = g_option_context_new(NULL);
> -       g_option_context_add_main_entries(context, options, NULL);
> -
> -       if (g_option_context_parse(context, &argc, &argv, &error) == FALSE) {
> -               if (error != NULL) {
> -                       g_printerr("%s\n", error->message);
> -                       g_error_free(error);
> -               } else
> -                       g_printerr("An unknown error occurred\n");
> -               exit(1);
> -       }
> -
> -       g_option_context_free(context);
> -
> -       bt_shell_init(&argc, &argv);
> +       bt_shell_init(&argc, &argv, options);
>         bt_shell_set_menu(&main_menu);
>         bt_shell_add_submenu(&advertise_menu);
>         bt_shell_add_submenu(&scan_menu);
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index e22d664f7..f108e6de3 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -669,13 +669,16 @@ static void rl_init(void)
>         rl_callback_handler_install(NULL, rl_handler);
>  }
>
> -void bt_shell_init(int *argc, char ***argv)
> +void bt_shell_init(int *argc, char ***argv, GOptionEntry *user_options)
>  {
>         GOptionContext *context;
>         GError *error = NULL;
>
>         context = g_option_context_new(NULL);
>         g_option_context_add_main_entries(context, options, NULL);
> +       if (user_options)
> +               g_option_context_add_main_entries(context,
> +                                                       user_options, NULL);
>
>         if (g_option_context_parse(context, argc, argv, &error) == FALSE) {
>                 if (error != NULL) {
> diff --git a/src/shared/shell.h b/src/shared/shell.h
> index 57b67cbbc..727c9382a 100644
> --- a/src/shared/shell.h
> +++ b/src/shared/shell.h
> @@ -50,7 +50,7 @@ struct bt_shell_menu {
>         const struct bt_shell_menu_entry entries[];
>  };
>
> -void bt_shell_init(int *argc, char ***argv);
> +void bt_shell_init(int *argc, char ***argv, GOptionEntry *user_options);
>
>  void bt_shell_run(void);
>
> --
> 2.14.1

Applied after some minor name adjustments. Going forward I think we
would benefit to use getopts or getopts_long so we don't have glib
symbols on the API making the shell to only work with glib as
mainloop.

-- 
Luiz Augusto von Dentz
