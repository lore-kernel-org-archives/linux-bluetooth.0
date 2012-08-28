Return-Path: <cyrus@holtmann.org>
Message-ID: <1346173833.23377.0.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: btmrvl: remove pointless conditional before
 kfree_skb()
From: Marcel Holtmann <marcel@holtmann.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: gustavo@padovan.org, johan.hedberg@gmail.com,
	yongjun_wei@trendmicro.com.cn, linux-bluetooth@vger.kernel.org
Date: Tue, 28 Aug 2012 10:10:33 -0700
In-Reply-To: <CAPgLHd-R2t_9aDOQ8Q-Q0nz6k4KZEBPVEO4SMea7T=ANbTOLnQ@mail.gmail.com>
References: <CAPgLHd-R2t_9aDOQ8Q-Q0nz6k4KZEBPVEO4SMea7T=ANbTOLnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wei,

> Remove pointless conditional before kfree_skb().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/bluetooth/btmrvl_sdio.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


