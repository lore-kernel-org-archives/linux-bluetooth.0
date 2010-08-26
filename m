Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 22:13:30 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: haijun liu <liuhaijun.er@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 14/22] Add three new options for l2cap_pinfo
Message-ID: <20100826011330.GF16062@vigoh>
References: <AANLkTikf=UeHUaT8wLnwUDnxgg0ouz1f6QkgYZvbr8t8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikf=UeHUaT8wLnwUDnxgg0ouz1f6QkgYZvbr8t8@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Haijun,

* haijun liu <liuhaijun.er@gmail.com> [2010-08-26 06:36:35 +0800]:

> From 06124ba36c1f6c9cf5bef861751ce749712cecb0 Mon Sep 17 00:00:00 2001
> From: haijun.liu <haijun.liu@atheros.com>
> Date: Mon, 23 Aug 2010 00:03:39 +0800
> Subject: [PATCH 14/22] Add three new options for l2cap_pinfo.
> 
> ---
>  include/net/bluetooth/l2cap.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 4f87aec..7a9bec4 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -367,6 +367,10 @@ struct l2cap_pinfo {
>  	__u8		num_conf_req;
>  	__u8		num_conf_rsp;
> 
> +	__u8		hschan_req;
> +	__u8		guaranteed;
> +	__u8		reconfig;
> +

The same here, you have to explain why you to increase struct l2cap_pinfo
size, and maybe only add them when you have a piece of code that uses
that.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
