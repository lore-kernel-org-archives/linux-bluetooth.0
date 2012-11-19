Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Nov 2012 19:41:01 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Jeff Cook <jeff@deserettechnology.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	johan.hedberg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: Add support for BCM20702A0 [0b05, 17b5]
Message-ID: <20121119214101.GD14006@joana>
References: <5087B517.9090703@deserettechnology.com>
 <1352504388-28965-1-git-send-email-jeff@deserettechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352504388-28965-1-git-send-email-jeff@deserettechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeff,

* Jeff Cook <jeff@deserettechnology.com> [2012-11-09 16:39:48 -0700]:

> Vendor-specific ID for BCM20702A0.
> Support for bluetooth over Asus Wi-Fi GO!, included with Asus P8Z77-V
> Deluxe.
> 
> T:  Bus=07 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0b05 ProdID=17b5 Rev=01.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM20702A0
> S:  SerialNumber=94DBC98AC113
> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> Signed-off-by: Jeff Cook <jeff@deserettechnology.com>
> ---
>  drivers/bluetooth/btusb.c | 1 +
>  1 file changed, 1 insertion(+)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
