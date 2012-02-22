Return-Path: <cyrus@holtmann.org>
Message-id: <921769CBC00A43F9A939E3FA39843F27@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
References: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1329832632-3681-8-git-send-email-mikel.astiz.oss@gmail.com>
In-reply-to: <1329832632-3681-8-git-send-email-mikel.astiz.oss@gmail.com>
Subject: Re: [PATCH obexd v2 7/8] client: fix canceling queued transfers
Date: Wed, 22 Feb 2012 17:11:39 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

--------------------------------------------------
From: "Mikel Astiz" <mikel.astiz.oss@gmail.com>
Sent: Tuesday, February 21, 2012 7:27 PM
To: <linux-bluetooth@vger.kernel.org>
Cc: "Mikel Astiz" <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 7/8] client: fix canceling queued transfers

> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> The Cancel() method in the D-Bus api should also abort queued transfers,
> which should just be removed from the queue.
> ---
> client/transfer.c |   12 ++++++++----
> 1 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/client/transfer.c b/client/transfer.c
> index b470a3a..dea9a2a 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -143,11 +143,15 @@ static void obc_transfer_abort(struct obc_transfer 
> *transfer)
> {
>  struct transfer_callback *callback = transfer->callback;
>
> - if (transfer->xfer == 0)
> - return;
> + if (transfer->xfer != 0) {
> + g_obex_cancel_transfer(transfer->xfer);
> + transfer->xfer = 0;
> + }
>
> - g_obex_cancel_transfer(transfer->xfer);
> - transfer->xfer = 0;
> + if (transfer->obex != NULL) {
> + g_obex_unref(transfer->obex);
> + transfer->obex = NULL;
> + }

If transfer->obex is unrefed here then the queued ABORT packet will not be 
sent.
This will create problem with PTS which requires ABORT command before 
transport disconnection

>
>  if (callback) {
>  GError *err;
> -- 
> 1.7.6.5
>
> --

Regards
Jaganath
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 

