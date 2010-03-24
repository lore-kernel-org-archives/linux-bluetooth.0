Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Print pkt_type when decoding Setup Synchronous
 Connection command.
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1265764049-2709-1-git-send-email-npelly@google.com>
References: <1265764049-2709-1-git-send-email-npelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Mar 2010 14:03:47 -0700
Message-ID: <1269464627.11714.141.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> diff --git a/parser/hci.c b/parser/hci.c
> index c0ca27e..958cd38 100644
> --- a/parser/hci.c
> +++ b/parser/hci.c
> @@ -917,8 +917,9 @@ static inline void setup_sync_conn_dump(int level, struct frame *frm)
>  	setup_sync_conn_cp *cp = frm->ptr;
>  
>  	p_indent(level, frm);
> -	printf("handle %d voice setting 0x%4.4x\n", btohs(cp->handle),
> -						btohs(cp->voice_setting));
> +	printf("handle %d voice setting 0x%4.4x pkt_type 0x%4.4x\n",
> +		btohs(cp->handle), btohs(cp->voice_setting),
> +		btohs(cp->pkt_type));
>  }

I renamed it to ptype instead of pkt_type to be consistent, but
otherwise, patch has been applied. Thanks.

Regards

Marcel


