Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389633824-6871-1-git-send-email-sebastianx.chlad@intel.com>
References: <1389633824-6871-1-git-send-email-sebastianx.chlad@intel.com>
Date: Tue, 14 Jan 2014 11:20:21 +0200
Message-ID: <CABBYNZLCqg+nNanXCv7J1kj=xzDB0S-FGonyyu4yHRzjs+KJOw@mail.gmail.com>
Subject: Re: [PATCH] tools/bluetooth-player: current-folder command
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sebastian Chlad <sebastianx.chlad@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Mon, Jan 13, 2014 at 7:23 PM, Sebastian Chlad
<sebastianx.chlad@intel.com> wrote:
> Add current-folder command listing path to the current folder
> ---
>  tools/bluetooth-player.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
> index f10d9be..1c0348e 100644
> --- a/tools/bluetooth-player.c
> +++ b/tools/bluetooth-player.c
> @@ -891,6 +891,23 @@ done:
>         rl_printf("Attempting to list items\n");
>  }
>
> +static void cmd_current_folder(int argc, char *argv[])
> +{
> +       GDBusProxy *proxy;
> +       GDBusProxy *folder;
> +
> +       if (check_default_player() == FALSE)
> +               return;
> +
> +       proxy = default_player;
> +       folder = find_folder(g_dbus_proxy_get_path(proxy));
> +
> +       if (folder == NULL)
> +               return;
> +
> +       print_property(folder, "Name");
> +}
> +
>  static void search_setup(DBusMessageIter *iter, void *user_data)
>  {
>         char *string = user_data;
> @@ -1023,6 +1040,8 @@ static const struct {
>                                                 "Change current folder" },
>         { "list-items", "[start] [end]",  cmd_list_items,
>                                         "List items of current folder" },
> +       { "current-folder", NULL,     cmd_current_folder,
> +                                       "Show current folder name and path" },
>         { "search",     "string",     cmd_search,
>                                         "Search items containing string" },
>         { "queue",       "<item>",    cmd_queue, "Add item to playlist queue" },
> --
> 1.8.3.2

Command show already prints the current folder, what I had in mind is
to print to prompt the address and folder e.g. XX:..:/folder> but
never had time to do it.


-- 
Luiz Augusto von Dentz
