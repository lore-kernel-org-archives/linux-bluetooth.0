Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Aug 2012 15:33:47 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Peng Chen <pengchen@qca.qualcomm.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH]     Bluetooth: add support for atheros 0489:e057
Message-ID: <20120806183347.GC3146@joana>
References: <1343787119-6750-1-git-send-email-pengchen@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343787119-6750-1-git-send-email-pengchen@qca.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peng,

* Peng Chen <pengchen@qca.qualcomm.com> [2012-08-01 10:11:59 +0800]:

>     Add support for the AR3012 chip found on Fioxconn.
> 
>     usb-devices shows:
> 
>     T:  Bus=06 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 44 Spd=12   MxCh= 0
>     D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>     P:  Vendor=0489 ProdID=e057 Rev= 0.02
>     C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
>     I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>     E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>     E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>     E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>     I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>     E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>     E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>     I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>     E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>     E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>     I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>     E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>     E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>     I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>     E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>     E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>     I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>     E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>     E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>     I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>     E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>     E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> Signed-off-by: Peng Chen <pengchen@qca.qualcomm.com>
> ---
>  drivers/bluetooth/ath3k.c |    2 ++
>  drivers/bluetooth/btusb.c |    1 +
>  2 files changed, 3 insertions(+)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
