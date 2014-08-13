Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] bluetooth/btuart_cs: Remove typedef btuart_info_t
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140813092139.GA3189@himangi-Dell>
Date: Wed, 13 Aug 2014 10:18:01 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Julia Lawall <julia.lawall@lip6.fr>
Message-Id: <845CA98D-39F0-4F2F-8ADF-7DBE1D7BA4ED@holtmann.org>
References: <20140813092139.GA3189@himangi-Dell>
To: Himangi Saraogi <himangi774@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Himangi,

> The Linux kernel coding style guidelines suggest not using typedefs
> for structure types. This patch gets rid of the typedef for
> btuart_info_t. Also, the name of the struct is changed to drop the _t,
> to make the name look less typedef-like.
> 
> The following Coccinelle semantic patch detects the case:
> 
> @tn@
> identifier i;
> type td;
> @@
> 
> -typedef
> struct i { ... }
> -td
> ;
> 
> @@
> type tn.td;
> identifier tn.i;
> @@
> 
> -td
> + struct i
> 
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
> drivers/bluetooth/btuart_cs.c | 27 ++++++++++++++-------------
> 1 file changed, 14 insertions(+), 13 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

