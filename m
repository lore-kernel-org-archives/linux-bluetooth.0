Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1340639082-10347-3-git-send-email-lucas.demarchi@profusion.mobi>
References: <CABBYNZ+oS3tGhYVY01uE6gfuzmA94TqV3YybgHdG83pCMzW8vA@mail.gmail.com>
	<1340639082-10347-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1340639082-10347-3-git-send-email-lucas.demarchi@profusion.mobi>
Date: Mon, 25 Jun 2012 18:55:04 +0300
Message-ID: <CABBYNZKdZnJ+-ywYVnPA-=BvS70qcM0G-N2-NUnRCYVhD-UwJQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] maemo6: mce: Fix listening for signals
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Jun 25, 2012 at 6:44 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> We should listen for signals only on MCE bus name.
> ---
>  plugins/maemo6.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/plugins/maemo6.c b/plugins/maemo6.c
> index 4819af4..a8c9bed 100644
> --- a/plugins/maemo6.c
> +++ b/plugins/maemo6.c
> @@ -224,12 +224,13 @@ static int mce_probe(struct btd_adapter *adapter)
>
>        DBG("path %s", adapter_get_path(adapter));
>
> -       watch_id = g_dbus_add_signal_watch(conn, NULL, MCE_SIGNAL_PATH,
> +       watch_id = g_dbus_add_signal_watch(conn, MCE_SERVICE, MCE_SIGNAL_PATH,
>                                        MCE_SIGNAL_IF, MCE_RADIO_STATES_SIG,
>                                        mce_signal_callback, adapter, NULL);
>
> -       tklock_watch_id = g_dbus_add_signal_watch(conn, NULL, MCE_SIGNAL_PATH,
> -                                       MCE_SIGNAL_IF, MCE_TKLOCK_MODE_SIG,
> +       tklock_watch_id = g_dbus_add_signal_watch(conn, MCE_SERVICE,
> +                                       MCE_SIGNAL_PATH, MCE_SIGNAL_IF,
> +                                       MCE_TKLOCK_MODE_SIG,
>                                        mce_tklock_mode_cb, adapter, NULL);
>
>        btd_adapter_register_powered_callback(adapter, adapter_powered);
> --
> 1.7.11

Don't bother with telephony drivers, they are about to be removed.


-- 
Luiz Augusto von Dentz
