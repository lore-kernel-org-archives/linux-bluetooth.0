Return-Path: <cyrus@holtmann.org>
Message-ID: <4F4248B9.6090700@bmw-carit.de>
Date: Mon, 20 Feb 2012 14:20:57 +0100
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd] client: Fix ABORT command not sending when user
 cancels the transfer
References: <1329742172-12124-1-git-send-email-jaganath.k@samsung.com>
In-Reply-To: <1329742172-12124-1-git-send-email-jaganath.k@samsung.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> Issue: When user cancels the tranfer, after queuing the ABORT command
> transfer->callback() with error will be called. In that session_unref
> is called which disconnects the transport.
>
> Fix: Just send ABORT command during abort and transfer->callback()
> will be called after getting response of ABORT command.
> ---
>   client/transfer.c      |   12 ------------
>   gobex/gobex-transfer.c |    6 +++++-
>   2 files changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/client/transfer.c b/client/transfer.c
> index 157811d..88e8ef7 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -141,23 +141,11 @@ static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
>
>   static void obc_transfer_abort(struct obc_transfer *transfer)
>   {
> -	struct transfer_callback *callback = transfer->callback;
> -
>   	if (transfer->xfer == 0)
>   		return;
>
>   	g_obex_cancel_transfer(transfer->xfer);
>   	transfer->xfer = 0;
> -
> -	if (callback) {
> -		GError *err;
> -
> -		err = g_error_new(OBC_TRANSFER_ERROR, -ECANCELED, "%s",
> -							strerror(ECANCELED));
> -		callback->func(transfer, transfer->transferred, err,
> -							callback->data);
> -		g_error_free(err);
> -	}
>   }
>

I think this callback is needed here, particularly for transfers that 
are queued but have not been started yet. This does not work right now 
but I was planning to propose a patch series to fix it soon. Also, IMO 
it seems fair to report the abortion as soon as possible to the upper 
layers, no matter what the response will be.

Having said that, I agree that transfer canceling is broken right now.

Cheers,
Mikel

