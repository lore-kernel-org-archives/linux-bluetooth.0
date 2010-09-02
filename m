Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Sep 2010 14:41:26 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: haijun liu <liuhaijun.er@gmail.com>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 13/22] Add three new options for l2cap_options which used
 in setsockopt & getsockopt
In-Reply-To: <AANLkTi=8xVks--xcLXEQ_=sHfP3fY+Wvyctu5K_kMDG-@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1009021430120.17665@linux-sea-02>
References: <AANLkTi=8xVks--xcLXEQ_=sHfP3fY+Wvyctu5K_kMDG-@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Thu, 26 Aug 2010, haijun liu wrote:

> From 897b281d14ba4cf9a5fbbf5ba65b84c85e688737 Mon Sep 17 00:00:00 2001
> From: haijun.liu <haijun.liu@atheros.com>
> Date: Mon, 23 Aug 2010 00:00:26 +0800
> Subject: [PATCH 13/22] Add three new options for l2cap_options which
> used in setsockopt & getsockopt.
>
> ---
> include/net/bluetooth/l2cap.h |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index d0ae9f5..4f87aec 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -65,6 +65,9 @@ struct l2cap_options {
> 	__u8  fcs;
> 	__u8  max_tx;
> 	__u16 txwin_size;
> +	__u8  hschan_req;
> +	__u8  guaranteed;
> +	__u8  reconfig;
> };
>
> #define L2CAP_CONNINFO	0x02

How are each of these new options used?

Are any of the new options changeable after the socket is connected?

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

