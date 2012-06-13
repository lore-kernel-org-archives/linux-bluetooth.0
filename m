Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1339503026-17276-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1339503026-17276-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Wed, 13 Jun 2012 13:01:54 +0300
Message-ID: <CABBYNZJ=mxcqbJUm_43cGT8G317uixrN56XNLj76CtQHGNtfWA@mail.gmail.com>
Subject: Re: [PATCH obexd v0 1/3] client: Fix possible unreplied D-Bus message
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Jun 12, 2012 at 3:10 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> If a previous cancel request is in progress, a second cancel request
> should fail.
>
> This by the way fixes unreplied D-Bus messages.
> ---
>  client/transfer.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/client/transfer.c b/client/transfer.c
> index 242d989..0686afe 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -213,6 +213,11 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
>                                ERROR_INTERFACE ".NotAuthorized",
>                                "Not Authorized");
>
> +       if (transfer->msg != NULL)
> +               return g_dbus_create_error(message,
> +                               ERROR_INTERFACE ".InProgress",
> +                               "Cancellation already in progress");
> +
>        if (!obc_transfer_abort(transfer))
>                return g_dbus_create_error(message,
>                                ERROR_INTERFACE ".Failed",
> --
> 1.7.7.6

All 3 patches are now upstream, thanks.


-- 
Luiz Augusto von Dentz
