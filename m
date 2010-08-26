Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 22:10:39 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: haijun liu <liuhaijun.er@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 13/22] Add three new options for l2cap_options which
 used in setsockopt & getsockopt
Message-ID: <20100826011039.GE16062@vigoh>
References: <AANLkTi=8xVks--xcLXEQ_=sHfP3fY+Wvyctu5K_kMDG-@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=8xVks--xcLXEQ_=sHfP3fY+Wvyctu5K_kMDG-@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Haijun,

* haijun liu <liuhaijun.er@gmail.com> [2010-08-26 06:36:05 +0800]:

> From 897b281d14ba4cf9a5fbbf5ba65b84c85e688737 Mon Sep 17 00:00:00 2001
> From: haijun.liu <haijun.liu@atheros.com>
> Date: Mon, 23 Aug 2010 00:00:26 +0800
> Subject: [PATCH 13/22] Add three new options for l2cap_options which
> used in setsockopt & getsockopt.
> 
> ---
>  include/net/bluetooth/l2cap.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index d0ae9f5..4f87aec 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -65,6 +65,9 @@ struct l2cap_options {
>  	__u8  fcs;
>  	__u8  max_tx;
>  	__u16 txwin_size;
> +	__u8  hschan_req;
> +	__u8  guaranteed;
> +	__u8  reconfig;
>  };

Here you are extending the API with the userspace, so we need a patch
for each option explaining why you need it and why the userspace should
care about that. It's a good idea here add this option to l2cap_options
in the same patch you implement the handling for it apply such patch hen
it is actually needed. ;)


-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
