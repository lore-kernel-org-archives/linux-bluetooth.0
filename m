Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Nov 2012 10:43:05 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcos Chaparro <marcos@mrkindustries.com.ar>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluetooth: ath3k: Add support for VAIO VPCEH [0489:e027]
Message-ID: <20121109094305.GB9183@joana>
References: <1352229551-22842-1-git-send-email-marcos@mrkindustries.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352229551-22842-1-git-send-email-marcos@mrkindustries.com.ar>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcos,

* Marcos Chaparro <marcos@mrkindustries.com.ar> [2012-11-06 16:19:11 -0300]:

> Added Atheros AR3011 internal bluetooth device found in Sony VAIO VPCEH to the
> devices list.
> Before this, the bluetooth module was identified as an Foxconn / Hai bluetooth
> device [0489:e027], now it claims to be an AtherosAR3011 Bluetooth
> [0cf3:3005].
> 
> T:  Bus=01 Lev=02 Prnt=02 Port=04 Cnt=02 Dev#=  4 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e027 Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> Signed-off-by: Marcos Chaparro <marcos@mrkindustries.com.ar>
> ---
>  drivers/bluetooth/ath3k.c |    1 +
>  drivers/bluetooth/btusb.c |    1 +
>  2 files changed, 2 insertions(+)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
