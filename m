Return-Path: <cyrus@holtmann.org>
Date: Sun, 17 Jun 2012 09:26:37 +0900 (JST)
Message-Id: <20120617.092637.2171077367789127221.yamato@redhat.com>
To: andrei.emeltchenko.news@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/8] /proc/net/ entries for bluetooth protocols
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20120615080007.GD7205@aemeltch-MOBL1>
References: <20120615.021553.2062569361246467656.yamato@redhat.com>
	<20120615080007.GD7205@aemeltch-MOBL1>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Thank you for reviewing.
I have a question.

>> +		sk = sk_entry(v);
>> +		bt = bt_sk(sk);
>> +		seq_printf(seq, "%pK %-6d %-6u %-6u %-6u %-6lu",
>> +			   sk,
>> +			   atomic_read(&sk->sk_refcnt),
>> +			   sk_rmem_alloc_get(sk),
>> +			   sk_wmem_alloc_get(sk),
>> +			   sock_i_uid(sk),
>> +			   sock_i_ino(sk)
>> +			);
>> +		seq_puts(seq, batostr(&bt->src));
> 
> batostr looks OK now but this will be outdated soon by %pMR.

As far as reading Documentation/printk-formats.txt and 
pointer() in lib/vsprintf.c, %pMR is not defined.
I guess you mean %pM, don't you?

I've tried following code, and it works as expected.

		baswap(&src_baswapped, &bt->src);
		baswap(&dst_baswapped, &bt->dst);

		seq_printf(seq, "%pK %-6d %-6u %-6u %-6u %-6lu %pM %pM %-6lu",
			   sk,
			   atomic_read(&sk->sk_refcnt),
			   sk_rmem_alloc_get(sk),
			   sk_wmem_alloc_get(sk),
			   sock_i_uid(sk),
			   sock_i_ino(sk),
			   &src_baswapped,
			   &dst_baswapped,
			   bt->parent? sock_i_ino(bt->parent): 0LU);


Masatake YAMATO
