Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 22:28:32 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: haijun liu <liuhaijun.er@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 17/22] Add parameter enable_highspeed to control
 highspeed code in running phase
Message-ID: <20100826012832.GI16062@vigoh>
References: <AANLkTinaFobBK5OiFaV+fGsEe3JRTy7_dT-FFLjSt-Rq@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinaFobBK5OiFaV+fGsEe3JRTy7_dT-FFLjSt-Rq@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Haijun,

* haijun liu <liuhaijun.er@gmail.com> [2010-08-26 06:38:27 +0800]:

> From c3fba9b5d7546576d9eb1d30eb45c453c8ee1dff Mon Sep 17 00:00:00 2001
> From: haijun.liu <haijun.liu@atheros.com>
> Date: Mon, 23 Aug 2010 00:17:24 +0800
> Subject: [PATCH 17/22] Add parameter enable_highspeed to control
> highspeed code in running phase.
> 
> ---
>  net/bluetooth/l2cap.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 449cbdd..e7f7067 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -4851,6 +4851,9 @@ module_exit(l2cap_exit);
>  module_param(enable_ertm, bool, 0644);
>  MODULE_PARM_DESC(enable_ertm, "Enable enhanced retransmission mode");
> 
> +module_param(enable_highspeed, bool, 0644);
> +MODULE_PARM_DESC(enable_highspeed, "Enable Bluetooth V3.0+HS
> highspeed feature");

I did not run this code, but I'm sure that this patch doesn't compile. ;)

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
