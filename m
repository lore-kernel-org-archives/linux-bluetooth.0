Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Mar 2014 22:17:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1 20/22] tools: Use unaligned access macros from util.h
Message-ID: <20140324201729.GB31654@t440s.P-661HNU-F1>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395689143-11091-21-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395689143-11091-21-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Mar 24, 2014, Claudio Takahasi wrote:
> ---
>  tools/parser/hci.c    | 1 -
>  tools/parser/l2cap.c  | 1 -
>  tools/parser/parser.h | 9 ++++-----
>  tools/parser/ppp.c    | 2 +-
>  4 files changed, 5 insertions(+), 8 deletions(-)

I've applied all patches until this one.

This patch has a quite severe bug in it (which to be honest makes me a
bit nervous of the earlier ones I applied):

>  static inline uint16_t get_u16(struct frame *frm)
>  {
> -	uint16_t *u16_ptr = frm->ptr;
>  	frm->ptr += 2;
>  	frm->len -= 2;
> -	return ntohs(bt_get_unaligned(u16_ptr));
> +	return get_be16(frm->ptr);
>  }
>  
>  static inline uint32_t get_u32(struct frame *frm)
>  {
> -	uint32_t *u32_ptr = frm->ptr;
>  	frm->ptr += 4;
>  	frm->len -= 4;
> -	return ntohl(bt_get_unaligned(u32_ptr));
> +	return get_be32(frm->ptr);
>  }

Note that the value passed to ntohl before your patch is the pointer
before it is incremented. However after your patch it's the pointer
after it has been incremented, so you're changing the behavior of these
two functions.

Johan
