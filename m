Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Jun 2013 16:53:13 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	yongjun_wei@trendmicro.com.cn, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btmrvl: fix error return code in
 btmrvl_sdio_card_to_host()
Message-ID: <20130605155313.GC3043@joana>
References: <CAPgLHd_+jJEOiO9x=gw1eW0LrrRj-rkKhb7mDqhg1ALaMzjKwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPgLHd_+jJEOiO9x=gw1eW0LrrRj-rkKhb7mDqhg1ALaMzjKwQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wei,

* Wei Yongjun <weiyj.lk@gmail.com> [2013-06-05 10:16:55 +0800]:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return -ENOMEM in the skb alloc error handling case
> instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/bluetooth/btmrvl_sdio.c | 1 +
>  1 file changed, 1 insertion(+)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
