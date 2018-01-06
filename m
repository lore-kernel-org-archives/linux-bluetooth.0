Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: bpa10x: make array 'req' static, shrinks
 object size
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180106161514.18308-1-colin.king@canonical.com>
Date: Sat, 6 Jan 2018 17:42:59 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <5236E589-503D-4845-B4BF-EAD9EF4461B0@holtmann.org>
References: <20180106161514.18308-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

> Don't populate the const read-only array 'req' on the stack but instead
> make it static. Makes the object code smaller by over 40 bytes:
> 
> Before:
>   text	   data	    bss	    dec	    hex	filename
>   8497	   3408	    128	  12033	   2f01	linux/drivers/bluetooth/bpa10x.o
> 
> After:
>   text	   data	    bss	    dec	    hex	filename
>   8366	   3496	    128	  11990	   2ed6	linux/drivers/bluetooth/bpa10x.o
> 
> (gcc version 7.2.0 x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> drivers/bluetooth/bpa10x.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
