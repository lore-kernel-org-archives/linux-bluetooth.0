Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH obexd] Fix compiler warning
From: Marcel Holtmann <marcel@holtmann.org>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 18 Jul 2011 14:54:09 +0200
In-Reply-To: <1310988546-8187-1-git-send-email-lkslawek@gmail.com>
References: <1310988546-8187-1-git-send-email-lkslawek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1310993650.21109.159.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawomir,

>  gobex/gobex.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gobex/gobex.c b/gobex/gobex.c
> index 93be21f..173912f 100644
> --- a/gobex/gobex.c
> +++ b/gobex/gobex.c
> @@ -643,8 +643,8 @@ static void handle_request(GObex *obex, GObexPacket *req)
>  
>  	op = g_obex_packet_get_operation(req, NULL);
>  
> -	match = g_slist_find_custom(obex->req_handlers, GUINT_TO_POINTER(op),
> -							req_handler_cmpop);
> +	match = g_slist_find_custom(obex->req_handlers,
> +			GUINT_TO_POINTER((guint)op), req_handler_cmpop);

what compiler warning does this fix. Lets fix this properly and not
introduce more magic casting.

Regards

Marcel


