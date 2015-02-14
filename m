Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2] Bluetooth: ath3k: Add support for 04f2:aff1 (Atheros AR5B195 combo Mini PCIe card)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1423854311-7909-1-git-send-email-alexpl@fedoraproject.org>
Date: Sat, 14 Feb 2015 15:48:57 -0800
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, jwboyer@redhat.com,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Stable <stable@vger.kernel.org>,
	Dmitry Tunin <hanipouspilot@gmail.com>,
	Alexander Ploumistos <alexpl@fedoraproject.org>
Message-Id: <DF500ED1-4BCC-42D6-9195-C86A3A5198F2@holtmann.org>
References: <CAM86y2vc-EUswU+D6EeEAeKQWDVuDVGOvpLTgKjB-R4VzxyshA@mail.gmail.com> <1423854311-7909-1-git-send-email-alexpl@fedoraproject.org>
To: alex.ploumistos@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

> Add 04f2:aff1 to ath3k.c supported devices list and btusb.c blacklist, so that the device can load the ath3k firmware and re-enumerate itself as an AR3011 device.
> 
> 
> T:  Bus=05 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=04f2 ProdID=aff1 Rev= 0.01
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
> 
> Signed-off-by: Alexander Ploumistos <alexpl@fedoraproject.org>
> ---
> drivers/bluetooth/ath3k.c | 1 +
> drivers/bluetooth/btusb.c | 1 +
> 2 files changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

However I had to reformat the From: line, the subject and the commit message. Please make sure that these are following in the rules for patches. Otherwise applying a patch turns into a lot of work for maintainer.

Regards

Marcel

