Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Feb 2012 16:47:43 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix Kconfig help description
Message-ID: <20120229194743.GA5449@joana>
References: <1330544293-17831-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330544293-17831-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andre Guedes <andre.guedes@openbossa.org> [2012-02-29 16:38:13 -0300]:

> SMP is not a kernel module, it is part of Bluetooth Core (as already
> described in lines above).
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
> index 9ec85eb..3537d38 100644
> --- a/net/bluetooth/Kconfig
> +++ b/net/bluetooth/Kconfig
> @@ -29,7 +29,6 @@ menuconfig BT
>  	     BNEP Module (Bluetooth Network Encapsulation Protocol)
>  	     CMTP Module (CAPI Message Transport Protocol)
>  	     HIDP Module (Human Interface Device Protocol)
> -	     SMP Module (Security Manager Protocol)
>  
>  	  Say Y here to compile Bluetooth support into the kernel or say M to
>  	  compile it as module (bluetooth).

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

	Gustavo
