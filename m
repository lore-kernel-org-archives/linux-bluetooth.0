Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Jun 2012 11:28:32 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/8] /proc/net/ entries for bluetooth protocols
Message-ID: <20120618082826.GA2898@aemeltch-MOBL1>
References: <20120615.021553.2062569361246467656.yamato@redhat.com>
 <20120615080007.GD7205@aemeltch-MOBL1>
 <20120617.092637.2171077367789127221.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120617.092637.2171077367789127221.yamato@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Masatake,

On Sun, Jun 17, 2012 at 09:26:37AM +0900, Masatake YAMATO wrote:
> Hi,
> 
> Thank you for reviewing.
> I have a question.
> 
> >> +		sk = sk_entry(v);
> >> +		bt = bt_sk(sk);
> >> +		seq_printf(seq, "%pK %-6d %-6u %-6u %-6u %-6lu",
> >> +			   sk,
> >> +			   atomic_read(&sk->sk_refcnt),
> >> +			   sk_rmem_alloc_get(sk),
> >> +			   sk_wmem_alloc_get(sk),
> >> +			   sock_i_uid(sk),
> >> +			   sock_i_ino(sk)
> >> +			);
> >> +		seq_puts(seq, batostr(&bt->src));
> > 
> > batostr looks OK now but this will be outdated soon by %pMR.
> 
> As far as reading Documentation/printk-formats.txt and 
> pointer() in lib/vsprintf.c, %pMR is not defined.
> I guess you mean %pM, don't you?

Sorry for confusion, I meant my patch adding new printf specifier which
is not yet in the tree. I think it will take longer time to be accepted 
then your patch.

> I've tried following code, and it works as expected.
> 
> 		baswap(&src_baswapped, &bt->src);
> 		baswap(&dst_baswapped, &bt->dst);
> 
> 		seq_printf(seq, "%pK %-6d %-6u %-6u %-6u %-6lu %pM %pM %-6lu",
> 			   sk,
> 			   atomic_read(&sk->sk_refcnt),
> 			   sk_rmem_alloc_get(sk),
> 			   sk_wmem_alloc_get(sk),
> 			   sock_i_uid(sk),
> 			   sock_i_ino(sk),
> 			   &src_baswapped,
> 			   &dst_baswapped,
> 			   bt->parent? sock_i_ino(bt->parent): 0LU);
>

Please use whatever method best suits for you although I prefer second
solution since it is easier to change to %pMR later.

Best regards 
Andrei Emeltchenko 

