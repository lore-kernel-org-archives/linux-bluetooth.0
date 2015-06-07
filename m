Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] ath3k: add support of 13d3:3474 AR3012 device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433611765-31075-1-git-send-email-hanipouspilot@gmail.com>
Date: Sun, 7 Jun 2015 09:33:24 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Message-Id: <0F60387C-ADE1-476C-85EA-FD66E590C0E1@holtmann.org>
References: <1433611765-31075-1-git-send-email-hanipouspilot@gmail.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

> BugLink: https://bugs.launchpad.net/bugs/1427680
> 
> This device requires new firmware files
> AthrBT_0x11020100.dfu and ramps_0x11020100_40.dfu added to
> /lib/firmware/ar3k/ that are not included in linux-firmware yet.
> 
> T: Bus=01 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#= 4 Spd=12 MxCh= 0
> D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=13d3 ProdID=3474 Rev=00.01
> C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
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

