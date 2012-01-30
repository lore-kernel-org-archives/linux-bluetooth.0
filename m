Return-Path: <cyrus@holtmann.org>
Message-ID: <1327948421.1955.143.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Add support for Atheros [0cf3:e004]
From: Marcel Holtmann <marcel@holtmann.org>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Date: Mon, 30 Jan 2012 10:33:41 -0800
In-Reply-To: <1327895375-9162-1-git-send-email-acelan.kao@canonical.com>
References: <1327895375-9162-1-git-send-email-acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi AceLan,

> Add another vendor specific ID for Atheros BT device
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
> BTW, to enable this device correctly, the btusb module should be loaded
> before ath3k. So, user should have this line in /etc/modprobe.d/ath3k.conf
> 
>    install ath3k modprobe btusb; modprobe --ignore-install ath3k;

NAK. Get this fixed properly then.

Regards

Marcel


