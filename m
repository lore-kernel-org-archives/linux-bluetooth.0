Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Aug 2014 10:56:22 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 1/6] gobex: Fix use after free
Message-ID: <20140805075616.GA26104@aemeltch-MOBL1>
References: <CABBYNZJSfWa8r8Ab-Dp3cmSwcxQc_7t7W0Cb2EALobM4RQnLkw@mail.gmail.com>
 <1406882679-28568-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406882679-28568-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Fri, Aug 01, 2014 at 11:44:34AM +0300, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> transfer_complete() frees transfer pointer.
> ---
>  gobex/gobex-transfer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
> index 8498177..6dc7d9f 100644
> --- a/gobex/gobex-transfer.c
> +++ b/gobex/gobex-transfer.c
> @@ -378,6 +378,7 @@ static void transfer_put_req_first(struct transfer *transfer, GObexPacket *req,
>  	if (!g_obex_send(transfer->obex, rsp, &err)) {
>  		transfer_complete(transfer, err);
>  		g_error_free(err);
> +		return;
>  	}
>  
>  	if (rspcode != G_OBEX_RSP_CONTINUE)
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
