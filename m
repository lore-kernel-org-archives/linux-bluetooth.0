Return-Path: <cyrus@holtmann.org>
From: "Chlad, SebastianX" <sebastianx.chlad@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] tools/bluetooth-player: current-folder command
Date: Tue, 14 Jan 2014 09:44:31 +0000
Message-ID: <2115852EF878384FA984E6B76A9F379E16789A@IRSMSX104.ger.corp.intel.com>
References: <1389633824-6871-1-git-send-email-sebastianx.chlad@intel.com>,<CABBYNZLCqg+nNanXCv7J1kj=xzDB0S-FGonyyu4yHRzjs+KJOw@mail.gmail.com>
In-Reply-To: <CABBYNZLCqg+nNanXCv7J1kj=xzDB0S-FGonyyu4yHRzjs+KJOw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


________________________________________
From: Luiz Augusto von Dentz [luiz.dentz@gmail.com]
Sent: Tuesday, January 14, 2014 11:20 AM
To: Chlad, SebastianX
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/bluetooth-player: current-folder command

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

Yup, 'show' prints current folder, however I found it inconvenient to use while using bluetooth-player; if one wants to check the current folder, hitting 'show' cmd prints just to much info.
Anyhow I was thinking about same -> having prompt with both address and folder. Let me see what I could do about it.

Sebastian


--
Luiz Augusto von Dentz
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

