Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com
References: <1418997688-16691-1-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1418997688-16691-1-git-send-email-gowtham.ab@samsung.com>
Subject: RE: [PATCH] src/att: Fix usage of memory after it is freed.
Date: Wed, 07 Jan 2015 15:26:02 +0530
Message-id: <001c01d02a60$26466900$72d33b00$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Friday, December 19, 2014 7:31 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: d.kasatkin@samsung.com; bharat.panda@samsung.com;
> cpgs@samsung.com; Gowtham Anandha Babu
> Subject: [PATCH] src/att: Fix usage of memory after it is freed.
> 
> warning: Use of memory after it is freed
> 	respond_not_supported(att, opcode);
> 	^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ---
>  src/shared/att.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/shared/att.c b/src/shared/att.c index 4be0652..a98909e
> 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -692,14 +692,14 @@ static void handle_notify(struct bt_att *att,
uint8_t
> opcode, uint8_t *pdu,
> 
>  	queue_foreach(att->notify_list, notify_handler, &data);
> 
> -	bt_att_unref(att);
> -
>  	/*
>  	 * If this was a request and no handler was registered for it,
respond
>  	 * with "Not Supported"
>  	 */
>  	if (!data.handler_found && get_op_type(opcode) ==
> ATT_OP_TYPE_REQ)
>  		respond_not_supported(att, opcode);
> +
> +	bt_att_unref(att);
>  }
> 
>  static bool can_read_data(struct io *io, void *user_data)
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

