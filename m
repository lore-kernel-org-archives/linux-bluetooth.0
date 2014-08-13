Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: bluecard_cs.c: Remove typedef bluecard_info_t
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140813092331.GA3272@himangi-Dell>
Date: Wed, 13 Aug 2014 10:18:11 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Julia Lawall <julia.lawall@lip6.fr>
Message-Id: <D0003696-4642-4804-A119-B10454751E23@holtmann.org>
References: <20140813092331.GA3272@himangi-Dell>
To: Himangi Saraogi <himangi774@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Himangi,

> The Linux kernel coding style guidelines suggest not using typedefs
> for structure types. This patch gets rid of the typedef for
> bluecard_info_t. Also, the name of the struct is changed to drop the _t,
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
> drivers/bluetooth/bluecard_cs.c | 35 ++++++++++++++++++-----------------
> 1 file changed, 18 insertions(+), 17 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

