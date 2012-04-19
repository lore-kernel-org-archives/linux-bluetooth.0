Return-Path: <cyrus@holtmann.org>
Message-ID: <1334826918.16897.270.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Add support for AR3012 [0cf3:e004]
From: Marcel Holtmann <marcel@holtmann.org>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Date: Thu, 19 Apr 2012 11:15:18 +0200
In-Reply-To: <1334818425-13601-1-git-send-email-acelan.kao@canonical.com>
References: <1334818425-13601-1-git-send-email-acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi AceLan,

> Add another vendor specific ID for Atheros AR3012
> 
> output of usb-devices:
> T:  Bus=02 Lev=02 Prnt=02 Port=04 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0cf3 ProdID=e004 Rev=00.02
> S:  Manufacturer=Atheros Communications
> S:  Product=Bluetooth USB Host Controller
> S:  SerialNumber=Alaska Day 2006
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> BugLink: https://bugs.launchpad.net/bugs/922715
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/bluetooth/ath3k.c |    2 ++
>  drivers/bluetooth/btusb.c |    1 +
>  2 files changed, 3 insertions(+)

patch has been applied to bluetooth and bluetooth-next trees.

Regards

Marcel


