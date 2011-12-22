Return-Path: <cyrus@holtmann.org>
Message-ID: <1324522254.1965.193.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Add support for BCM20702A0 [0a5c:21e3]
From: Marcel Holtmann <marcel@holtmann.org>
To: Jesse Sung <jesse.sung@canonical.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 21 Dec 2011 18:50:54 -0800
In-Reply-To: <1324522127-9039-1-git-send-email-jesse.sung@canonical.com>
References: <1324522127-9039-1-git-send-email-jesse.sung@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jesse,

> Add another vendor specific ID for BCM20702A0.
> 
> output of usb-devices:
> T: Bus=06 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 4 Spd=12 MxCh= 0
> D: Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=0a5c ProdID=21e3 Rev=01.12
> S: Manufacturer=Broadcom Corp
> S: Product=BCM20702A0
> S: SerialNumber=9439E5CBF66C
> C: #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I: If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I: If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I: If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I: If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
> ---
>  drivers/bluetooth/btusb.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


