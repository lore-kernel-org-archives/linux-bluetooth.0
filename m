Return-Path: <cyrus@holtmann.org>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: Re: [PATCH obexd 2/2] gobex: Fix ABORT request not processing
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Date: Fri, 13 Jan 2012 11:29:04 +0100
From: Hendrik Sattler <post@hendrik-sattler.de>
Cc: <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1326448613-8367-1-git-send-email-jaganath.k@samsung.com>
References: <1326448613-8367-1-git-send-email-jaganath.k@samsung.com>
Message-ID: <adc3f64ff0de3606125dfbdea3f6b2ac@mail.hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 13.01.2012 10:56, schrieb Jaganath Kanakkassery:
> G_OBEX_OP_ABORT is defined as 0x7f but error checking of opcode is
> done for greater than 0x1f. So abort request is simply ignored.
> So corrected the error checking.
> ---
>  gobex/gobex.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/gobex/gobex.c b/gobex/gobex.c
> index 33b77fd..bfb9f37 100644
> --- a/gobex/gobex.c
> +++ b/gobex/gobex.c
> @@ -1150,7 +1150,7 @@ static gboolean incoming_data(GIOChannel *io,
> GIOCondition cond,
>  	} else {
>  		opcode = obex->rx_last_op;
>  		/* Unexpected response -- fail silently */
> -		if (opcode > 0x1f && opcode < 0xff) {
> +		if (opcode > G_OBEX_OP_ABORT && opcode < 0xff) {
>  			obex->rx_data = 0;
>  			return TRUE;
>  		}

This one always evaluates to false because 0xff == G_OBEX_OP_ABORT | 
FINAL_BIT.

HS

