Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Feb 2011 12:24:20 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andre Dieb Martins <andre.dieb@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] Add dump for ATT MTU req/resp and notify value
Message-ID: <20110209142420.GE1995@joana>
References: <1297259619-10325-1-git-send-email-andre.dieb@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297259619-10325-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Dieb Martins <andre.dieb@signove.com> [2011-02-09 10:53:34 -0300]:

> ---
>  parser/att.c |   31 ++++++++++++++++++++++++++++++-
>  1 files changed, 30 insertions(+), 1 deletions(-)
> 
> diff --git a/parser/att.c b/parser/att.c
> index b670694..05f9c23 100644
> --- a/parser/att.c
> +++ b/parser/att.c
> @@ -132,12 +132,35 @@ static const char *attop2str(uint8_t op)
>  	}
>  }
>  
> +static void att_mtu_req_dump(int level, struct frame *frm)
> +{
> +	uint16_t client_rx_mtu = btohs(htons(get_u16(frm)));
> +
> +	p_indent(level, frm);
> +	printf("client rx mtu %d\n", client_rx_mtu);
> +}
> +
> +static void att_mtu_resp_dump(int level, struct frame *frm)
> +{
> +	uint16_t server_rx_mtu = btohs(htons(get_u16(frm)));
> +
> +	p_indent(level, frm);
> +	printf("server rx mtu %d\n", server_rx_mtu);
> +}
> +
>  static void att_handle_notify_dump(int level, struct frame *frm)
>  {
>  	uint16_t handle = btohs(htons(get_u16(frm)));
>  
>  	p_indent(level, frm);
>  	printf("handle 0x%2.2x\n", handle);
> +
> +	p_indent(level, frm);
> +	printf("value ");
> +	while (frm->len > 0) {
> +		printf("0x%.2x ", get_u8(frm));
> +	}
> +	printf("\n");
>  }
>  
>  void att_dump(int level, struct frame *frm)
> @@ -147,9 +170,15 @@ void att_dump(int level, struct frame *frm)
>  	op = get_u8(frm);
>  
>  	p_indent(level, frm);
> -	printf("Opcode: %d (%s)\n", op, attop2str(op));
> +	printf("Opcode %d (%s)\n", op, attop2str(op));

-v2 delivered a blank email to me for this one, so replying here.

Please move this change to the patch that introduced it.

-- 
Gustavo F. Padovan
http://profusion.mobi
