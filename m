Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] Bluetooth: Add new AR3012 ID 0489:e095
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1455054551-3884-1-git-send-email-hanipouspilot@gmail.com>
Date: Sat, 20 Feb 2016 00:09:38 -0800
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-firmware@kernel.org, dams.38@hotmail.fr,
	stable@vger.kernel.org
Message-Id: <F8D5C5E2-8172-4EF6-AA99-B369DC5E3D8B@holtmann.org>
References: <1455054551-3884-1-git-send-email-hanipouspilot@gmail.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

> T: Bus=01 Lev=01 Prnt=01 Port=04 Cnt=02 Dev#= 3 Spd=12 MxCh= 0
> D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=0489 ProdID=e095 Rev=00.01
> C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> This device requires ar3k/AthrBT_0x31010100.dfu and
> ar3k/ramps_0x31010100_40.dfu firmware files that are not in
> linux-firmware yet.
> 
> BugLink: https://bugs.launchpad.net/bugs/1542944
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
