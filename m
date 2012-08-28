Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Aug 2012 10:24:00 -0700
From: Gustavo Padovan <gustavo@padovan.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	yongjun_wei@trendmicro.com.cn, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btmrvl: remove pointless conditional before
 kfree_skb()
Message-ID: <20120828172400.GB23552@joana>
References: <CAPgLHd-R2t_9aDOQ8Q-Q0nz6k4KZEBPVEO4SMea7T=ANbTOLnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPgLHd-R2t_9aDOQ8Q-Q0nz6k4KZEBPVEO4SMea7T=ANbTOLnQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wei,

* Wei Yongjun <weiyj.lk@gmail.com> [2012-08-28 21:12:48 +0800]:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove pointless conditional before kfree_skb().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/bluetooth/btmrvl_sdio.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
