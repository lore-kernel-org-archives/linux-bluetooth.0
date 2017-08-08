Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: Add support of 13d3:3494 RTL8723BE device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1502190542-13243-1-git-send-email-hanipouspilot@gmail.com>
Date: Tue, 8 Aug 2017 13:15:16 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, 1708692@bugs.launchpad.net,
        stable@vger.kernel.org
Message-Id: <359B1D72-A050-4429-9EBD-F445A972B0DF@holtmann.org>
References: <1502190542-13243-1-git-send-email-hanipouspilot@gmail.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

> T: Bus=02 Lev=01 Prnt=01 Port=03 Cnt=03 Dev#= 4 Spd=12 MxCh= 0
> D: Ver= 2.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=13d3 ProdID=3494 Rev= 2.00
> S: Manufacturer=Realtek
> S: Product=Bluetooth Radio
> S: SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
> E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
> E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> 
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel
