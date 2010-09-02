Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Sep 2010 14:29:55 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: haijun liu <liuhaijun.er@gmail.com>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 12/22] Add some default values for configuration
 process
In-Reply-To: <AANLkTikAZBO6dka+yN3tFTZekm9+1nzo3=OZEoxZ1Eab@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1009021422570.17665@linux-sea-02>
References: <AANLkTikAZBO6dka+yN3tFTZekm9+1nzo3=OZEoxZ1Eab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Thu, 26 Aug 2010, haijun liu wrote:

> From 2d21459fa52b754ce0f666ccefc0175bc7f04420 Mon Sep 17 00:00:00 2001
> From: haijun.liu <haijun.liu@atheros.com>
> Date: Sun, 22 Aug 2010 23:57:09 +0800
> Subject: [PATCH 12/22] Add some default values for configuration process.
>
> ---
> include/net/bluetooth/l2cap.h |    5 +++++
> 1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index fe411e2..d0ae9f5 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -36,6 +36,11 @@
> #define L2CAP_DEFAULT_MAX_PDU_SIZE	672
> #define L2CAP_DEFAULT_ACK_TO		200
> #define L2CAP_LOCAL_BUSY_TRIES		12
> +#define L2CAP_DEFAULT_MAX_SDU_SIZE	0xFFFF
> +#define L2CAP_DEFAULT_SDU_ARRIVAL_TIME	0xFFFFFFFF
> +#define L2CAP_DEFAULT_FLUSH_TIMEOUT	0xFFFFFFFF
> +#define L2CAP_DEFAULT_ACCESS_LATENCY	0xFFFFFFFF
> +#define L2CAP_DEFAULT_EXT_WINSIZE	1024

This seems like a large window size for a default - why 1024?

>
> #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
> #define L2CAP_CONFIG_TIMEOUT	(40000) /* 40 seconds */


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

