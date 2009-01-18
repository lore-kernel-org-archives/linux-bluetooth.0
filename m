Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Performance optimizations for sbcenc utility
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: linux-bluetooth@vger.kernel.org,
	Christian Hoene <hoene@uni-tuebingen.de>
In-Reply-To: <200901161812.45754.siarhei.siamashka@nokia.com>
References: <200901161812.45754.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Sun, 18 Jan 2009 16:15:44 +0100
Message-Id: <1232291744.5095.14.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> The attached patch improves performance of sbcenc utility. This is not very
> useful in general and does not improve the SBC codec itself. But when using
> sbcenc utility for benchmarking, an extra unneeded overhead skews the results
> a bit and this might be worth fixing.
> 
> Before patch:
> 
> real    0m14.984s
> user    0m12.981s
> sys     0m1.924s
> 
> After patch:
> 
> real    0m12.279s
> user    0m11.865s
> sys     0m0.360s
> 
> 
> Christian, you fixed some bugs in sbcenc a bit earlier. Could you please
> also check if all your testcases also work fine with this new patch applied
> and it does not break anything?

patch has been applied to make testing easier. Send fixes if it breaks
something.

Regards

Marcel


