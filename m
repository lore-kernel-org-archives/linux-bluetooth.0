Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v8] Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1429214995-11833-1-git-send-email-drake@endlessm.com>
Date: Thu, 16 Apr 2015 14:16:43 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	larry.finger@lwfinger.net,
	Champion Chen <champion_chen@realsil.com.cn>,
	carlo@endlessm.com
Message-Id: <234E205F-7EAB-4E8A-9FFF-44F519415046@holtmann.org>
References: <1429214995-11833-1-git-send-email-drake@endlessm.com>
To: Daniel Drake <drake@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> Realtek ship a variety of bluetooth USB devices that identify
> themselves with standard USB Bluetooth device class values, but
> require a special driver to actually work. Without that driver,
> you never get any scan results.
> 
> More recently however, Realtek appear to have wisened up and simply
> posted a firmware update that makes these devices comply with
> normal btusb protocols. The firmware needs to be uploaded on each boot.
> 
> Based on Realtek code from https://github.com/lwfinger/rtl8723au_bt
> ('new' branch).
> 
> This enables bluetooth support in the Gigabyte Brix GB-BXBT-2807 which
> has this RTL8723BE USB device:
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
> D:  Ver= 2.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3410 Rev= 2.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> There is no change to the USB descriptor after firmware update,
> however the version read by HCI_OP_READ_LOCAL_VERSION changes from
> 0x8723 to 0x3083.
> 
> This has also been tested on RTL8723AE and RTL8821AE. Support for
> RTL8761A has also been added, but that is untested.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
> drivers/bluetooth/btusb.c | 399 ++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 399 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

