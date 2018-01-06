Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: btintel: make array 'param' static, shrinks
 object size
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180106162328.18625-1-colin.king@canonical.com>
Date: Sat, 6 Jan 2018 17:43:52 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1B85A899-6FB7-4BDB-B123-848C14BDFE54@holtmann.org>
References: <20180106162328.18625-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

> Don't populate the const read-only array 'param' on the stack but instead
> make it static. Makes the object code smaller by nearly 20 bytes:
> 
> Before:
>   text	   data	    bss	    dec	    hex	filename
>  11605	   2629	     64	  14298	   37da	linux/drivers/bluetooth/btintel.o
> 
> After:
>   text	   data	    bss	    dec	    hex	filename
>  11531	   2685	     64	  14280	   37c8	linux/drivers/bluetooth/btintel.o
> 
> (gcc version 7.2.0 x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> drivers/bluetooth/btintel.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

