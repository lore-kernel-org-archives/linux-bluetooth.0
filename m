Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: Add support of 13d3:3490 AR3012 device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1468276518-12220-1-git-send-email-hanipouspilot@gmail.com>
Date: Tue, 12 Jul 2016 00:37:55 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <A3F8EA18-D101-44FE-A25C-9C27AD565F78@holtmann.org>
References: <1468276518-12220-1-git-send-email-hanipouspilot@gmail.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

> T: Bus=01 Lev=01 Prnt=01 Port=07 Cnt=05 Dev#= 5 Spd=12 MxCh= 0
> D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=13d3 ProdID=3490 Rev=00.01
> C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> BugLink: https://bugs.launchpad.net/bugs/1600623 
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
