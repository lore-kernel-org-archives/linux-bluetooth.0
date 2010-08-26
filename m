Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 22:04:30 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: haijun liu <liuhaijun.er@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 12/22] Add some default values for configuration process
Message-ID: <20100826010430.GD16062@vigoh>
References: <AANLkTikAZBO6dka+yN3tFTZekm9+1nzo3=OZEoxZ1Eab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikAZBO6dka+yN3tFTZekm9+1nzo3=OZEoxZ1Eab@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Haijun,

* haijun liu <liuhaijun.er@gmail.com> [2010-08-26 06:35:34 +0800]:

> From 2d21459fa52b754ce0f666ccefc0175bc7f04420 Mon Sep 17 00:00:00 2001
> From: haijun.liu <haijun.liu@atheros.com>
> Date: Sun, 22 Aug 2010 23:57:09 +0800
> Subject: [PATCH 12/22] Add some default values for configuration process.
> 
> ---
>  include/net/bluetooth/l2cap.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index fe411e2..d0ae9f5 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -36,6 +36,11 @@
>  #define L2CAP_DEFAULT_MAX_PDU_SIZE	672
>  #define L2CAP_DEFAULT_ACK_TO		200
>  #define L2CAP_LOCAL_BUSY_TRIES		12
> +#define L2CAP_DEFAULT_MAX_SDU_SIZE	0xFFFF
> +#define L2CAP_DEFAULT_SDU_ARRIVAL_TIME	0xFFFFFFFF
> +#define L2CAP_DEFAULT_FLUSH_TIMEOUT	0xFFFFFFFF

We already have L2CAP_DEFAULT_FLUSH_TO with the same value.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
