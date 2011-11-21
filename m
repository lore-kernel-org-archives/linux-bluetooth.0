Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1321864353-3159-1-git-send-email-bulislaw@linux.com>
References: <1321864353-3159-1-git-send-email-bulislaw@linux.com>
Date: Mon, 21 Nov 2011 11:50:58 +0200
Message-ID: <CABBYNZKXU-JCLge9bvqr982mVeiohdjuRsPASOTO8n9W5ZF_Bg@mail.gmail.com>
Subject: Re: [PATCH obexd 1/2] client: Fix memory leak connected to params
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Mon, Nov 21, 2011 at 10:32 AM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
> obc_transfer_params (created in obc_session_get) are reused to store
> params received in the response. But actual parameter data were not
> freed before g_memdup in get_buf_xfer_progress.
> ---
>  client/transfer.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/client/transfer.c b/client/transfer.c
> index b6994d1..334d8d4 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -533,11 +533,16 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
>                g_obex_packet_add_bytes(req, G_OBEX_HDR_TYPE, transfer->type,
>                                                strlen(transfer->type) + 1);
>
> -       if (transfer->params != NULL)
> +       if (transfer->params != NULL) {
>                g_obex_packet_add_bytes(req, G_OBEX_HDR_APPARAM,
>                                                transfer->params->data,
>                                                transfer->params->size);
>
> +               g_free(transfer->params->data);
> +               transfer->params->size = 0;
> +               transfer->params->data = NULL;
> +       }
> +
>        if (rsp_cb)
>                transfer->xfer = g_obex_send_req(obex, req, -1, rsp_cb,
>                                                        transfer, &err);
> --
> 1.7.4.1
>
> --

I would like it better if do this on get_buf_xfer_progress, so
whenever we are going to overwrite it we free it before.

-- 
Luiz Augusto von Dentz
