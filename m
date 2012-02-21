Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329813983-26707-9-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1329813983-26707-9-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 21 Feb 2012 13:56:07 +0200
Message-ID: <CABBYNZ+HCBZQr1OMOWu_g7neMC6Tk58k_rRLWoFgCiXmO7=q3w@mail.gmail.com>
Subject: Re: [PATCH obexd 8/9] client: allow cancelling queued transfers
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
> The Cancel() method in the D-Bus api should also abort queued transfers,
> which should just be removed from the queue.
> ---
>  client/transfer.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/client/transfer.c b/client/transfer.c
> index 2cf5786..f380cb7 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -143,11 +143,15 @@ static void obc_transfer_abort(struct obc_transfer *transfer)
>  {
>        struct transfer_callback *callback = transfer->callback;
>
> -       if (transfer->xfer == 0)
> -               return;
> +       if (transfer->xfer != 0) {
> +               g_obex_cancel_transfer(transfer->xfer);
> +               transfer->xfer = 0;
> +       }
>
> -       g_obex_cancel_transfer(transfer->xfer);
> -       transfer->xfer = 0;
> +       if (transfer->obex != NULL) {
> +               g_obex_unref(transfer->obex);
> +               transfer->obex = NULL;
> +       }
>
>        if (callback) {
>                GError *err;
> --
> 1.7.6.5

Looks, but this is a fix please update the commit message to make it clear.

-- 
Luiz Augusto von Dentz
