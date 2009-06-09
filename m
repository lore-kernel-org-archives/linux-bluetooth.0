Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: depends on RFKILL
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: linux-next@vger.kernel.org, linux-bluetooth@vger.kernel.org
In-Reply-To: <1244560060-28112-1-git-send-email-a.beregalov@gmail.com>
References: <1244560060-28112-1-git-send-email-a.beregalov@gmail.com>
Content-Type: text/plain
Date: Tue, 09 Jun 2009 17:22:24 +0200
Message-Id: <1244560944.3068.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

> Since commit "Bluetooth: Add native RFKILL soft-switch support for all
> devices" (611b30f74b5) bluetooth depends on RFKILL.
> 
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
> ---
>  net/bluetooth/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
> index 7725da9..85ec71d 100644
> --- a/net/bluetooth/Kconfig
> +++ b/net/bluetooth/Kconfig
> @@ -3,7 +3,7 @@
>  #
>  
>  menuconfig BT
> -	depends on NET && !S390
> +	depends on NET && RFKILL && !S390
>  	tristate "Bluetooth subsystem support"
>  	help
>  	  Bluetooth is low-cost, low-power, short-range wireless technology

this patch is wrong. I think it just needs an extra

	depends on RFKILL || !RFKILL

It is fine to compile Bluetooth without RFKILL support.

Regards

Marcel


