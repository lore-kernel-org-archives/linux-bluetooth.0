Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <776845cc-b63f-15f3-283f-877c875db234@jp.fujitsu.com>
References: <776845cc-b63f-15f3-283f-877c875db234@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Mar 2018 14:58:19 +0200
Message-ID: <CABBYNZJkF_qJ-93PEAg_-QYboHqVt-E3KWb=mR_Q-sewh8cCpA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] tools/bluetooth-player: Merge cmd_play{,_item}()
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Fri, Mar 9, 2018 at 2:10 PM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Also adds item generator for the change-folder command.
> ---
>  tools/bluetooth-player.c | 38 ++++++++++++++------------------------
>  1 file changed, 14 insertions(+), 24 deletions(-)
>
> diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
> index 75650a722..441a934cc 100644
> --- a/tools/bluetooth-player.c
> +++ b/tools/bluetooth-player.c
> @@ -115,15 +115,21 @@ static void play_reply(DBusMessage *message, void *user_data)
>         return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  }
>
> -static void cmd_play_item(int argc, char *argv[])
> +static void cmd_play(int argc, char *argv[])
>  {
>         GDBusProxy *proxy;
>
> -       proxy = g_dbus_proxy_lookup(items, NULL, argv[1],
> +       if (argc > 1) {
> +               proxy = g_dbus_proxy_lookup(items, NULL, argv[1],
>                                                 BLUEZ_MEDIA_ITEM_INTERFACE);
> -       if (proxy == NULL) {
> -               bt_shell_printf("Item %s not available\n", argv[1]);
> -               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +               if (proxy == NULL) {
> +                       bt_shell_printf("Item %s not available\n", argv[1]);
> +                       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +               }
> +       } else {
> +               if (!check_default_player())
> +                       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +               proxy = default_player;
>         }
>
>         if (g_dbus_proxy_method_call(proxy, "Play", NULL, play_reply,
> @@ -132,24 +138,7 @@ static void cmd_play_item(int argc, char *argv[])
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>
> -       bt_shell_printf("Attempting to play %s\n", argv[1]);
> -}
> -
> -static void cmd_play(int argc, char *argv[])
> -{
> -       if (argc > 1)
> -               return cmd_play_item(argc, argv);
> -
> -       if (!check_default_player())
> -               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> -
> -       if (g_dbus_proxy_method_call(default_player, "Play", NULL, play_reply,
> -                                                       NULL, NULL) == FALSE) {
> -               bt_shell_printf("Failed to play\n");
> -               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> -       }
> -
> -       bt_shell_printf("Attempting to play\n");
> +       bt_shell_printf("Attempting to play %s\n", argv[1] ? : "");
>  }
>
>  static void pause_reply(DBusMessage *message, void *user_data)
> @@ -963,7 +952,8 @@ static const struct bt_shell_menu main_menu = {
>         { "scan",         "<alltracks/group/off>", cmd_scan,
>                                                 "Set scan mode"},
>         { "change-folder", "<item>",  cmd_change_folder,
> -                                               "Change current folder" },
> +                                               "Change current folder",
> +                                                       item_generator},

This seems unrelated, could send it in a separate patch?

>         { "list-items", "[start] [end]",  cmd_list_items,
>                                         "List items of current folder" },
>         { "search",     "<string>",   cmd_search,
> --
> 2.14.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
