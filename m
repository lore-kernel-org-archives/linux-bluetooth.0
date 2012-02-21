Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329813983-26707-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1329813983-26707-4-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 21 Feb 2012 13:12:28 +0200
Message-ID: <CABBYNZJp7iQ5N4df0h4pfCW8szV5xkvAs9Xm_ahv5Z26w8nY0w@mail.gmail.com>
Subject: Re: [PATCH obexd 3/9] client: deny cancel when no agent present
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Feb 21, 2012 at 10:46 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> The authorization check should consider the scenario of no agent being
> assigned to the transfer.
> ---
>  client/transfer.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/client/transfer.c b/client/transfer.c
> index 157811d..4054799 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -168,7 +168,7 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
>        DBusMessage *reply;
>
>        sender = dbus_message_get_sender(message);
> -       if (g_str_equal(transfer->agent, sender) == FALSE)
> +       if (g_strcmp0(transfer->agent, sender) != 0)
>                return g_dbus_create_error(message,
>                                "org.openobex.Error.NotAuthorized",
>                                "Not Authorized");
> --
> 1.7.6.5

This is actually a fix, g_str_equal does not do NULL-safe comparisons,
could you please make this clear in your commit message.

-- 
Luiz Augusto von Dentz
