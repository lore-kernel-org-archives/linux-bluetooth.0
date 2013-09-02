Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Sep 2013 13:41:33 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Raphael Kubo da Costa <rakuco@FreeBSD.org>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for BCM20702A0 [0b05, 17cb]
Message-ID: <20130902124133.GP7440@joana>
References: <1378123071-16732-1-git-send-email-rakuco@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378123071-16732-1-git-send-email-rakuco@FreeBSD.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Raphael,

2013-09-02 Raphael Kubo da Costa <rakuco@FreeBSD.org>:

> Yet another vendor specific ID for this chipset; this one for the ASUS
> USB-BT400 Bluetooth 4.0 adapter.
> 
> T:  Bus=03 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0b05 ProdID=17cb Rev=01.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM20702A0
> S:  SerialNumber=000272C64400
> C:  #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Raphael Kubo da Costa <rakuco@FreeBSD.org>
> ---
>  drivers/bluetooth/btusb.c | 1 +
>  1 file changed, 1 insertion(+)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
