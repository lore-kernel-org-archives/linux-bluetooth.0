Return-Path: <cyrus@holtmann.org>
Message-ID: <4C7644EE.4090606@csr.com>
Date: Thu, 26 Aug 2010 11:41:50 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: haijun liu <liuhaijun.er@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 13/22] Add three new options for l2cap_options which used
 in setsockopt & getsockopt
References: <AANLkTi=8xVks--xcLXEQ_=sHfP3fY+Wvyctu5K_kMDG-@mail.gmail.com>
In-Reply-To: <AANLkTi=8xVks--xcLXEQ_=sHfP3fY+Wvyctu5K_kMDG-@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

haijun liu wrote:
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

This isn't the API that was agreed.  See Mat Martineau's "Bluetooth:
Add socket option definitions for AMP" patch.

> +	__u8  guaranteed;

Selecting guaranteed without being able to specify flow specs doesn't
seem useful.

I would like to see support for best-effort links merged first before
guaranteed links are considered.

> +	__u8  reconfig;

I'd suggest removing this unless there's a profile/application that will
make use of it.  I'd have thought that channel reconfiguration was
something the L2CAP stack does automatically when moving channels
between BR/EDR and AMP radios.

>  };

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
