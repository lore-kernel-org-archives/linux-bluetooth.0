Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] ath3k: Add support of 0489:e076 AR3012 device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433611540-30860-1-git-send-email-hanipouspilot@gmail.com>
Date: Sun, 7 Jun 2015 09:33:30 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org
Message-Id: <29C5310D-1972-48DB-A17A-3E6934B72FB0@holtmann.org>
References: <1433611540-30860-1-git-send-email-hanipouspilot@gmail.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

> BugLink: https://bugs.launchpad.net/bugs/1462614
> 
> This device requires new firmware files
> AthrBT_0x11020100.dfu and ramps_0x11020100_40.dfu added to
> /lib/firmware/ar3k/ that are not included in linux-firmware yet.
> 
> T: Bus=03 Lev=01 Prnt=01 Port=09 Cnt=06 Dev#= 7 Spd=12 MxCh= 0
> D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=0489 ProdID=e076 Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
> E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
> E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> 
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> drivers/bluetooth/ath3k.c | 2 ++
> drivers/bluetooth/btusb.c | 1 +
> 2 files changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

