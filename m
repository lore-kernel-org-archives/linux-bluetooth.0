Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Jan 2014 21:25:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 06/12] tools: Fix unaligned memory access on
 smp-tester
Message-ID: <20140106192520.GA25270@x220.p-661hnu-f1>
References: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
 <1388800528-10699-7-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388800528-10699-7-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Jan 03, 2014, Anderson Lizardo wrote:
> Fixes clang errors like:
> 
> tools/smp-tester.c:263:11: error: cast from 'uint8_t *' (aka 'unsigned
> char *') to 'u128 *' increases required alignment from 1 to 8
> [-Werror,-Wcast-align]
> ---
>  tools/smp-tester.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/smp-tester.c b/tools/smp-tester.c
> index 685d379..20429a9 100644
> --- a/tools/smp-tester.c
> +++ b/tools/smp-tester.c
> @@ -233,10 +233,16 @@ typedef struct {
>  	uint64_t a, b;
>  } u128;
>  
> -static inline void u128_xor(u128 *r, const u128 *p, const u128 *q)
> +static inline void u128_xor(void *r, const void *p, const void *q)
>  {
> -	r->a = p->a ^ q->a;
> -	r->b = p->b ^ q->b;
> +	const u128 pp = bt_get_unaligned((const u128 *) p);
> +	const u128 qq = bt_get_unaligned((const u128 *) q);
> +	u128 rr;
> +
> +	rr.a = pp.a ^ qq.a;
> +	rr.b = pp.b ^ qq.b;
> +
> +	bt_put_unaligned(rr, (u128 *) r);
>  }

This code was essentially a direct copy of what the kernel side SMP
implementation does. Does this mean we have a problem on the kernel side
too? Could you send a patch for that (after confirming that we do have a
problem there too).

Johan
