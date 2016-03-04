Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] Bluetooth: btusb: Add a new AR3012 ID 13d3:3472
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1457044339-2447-1-git-send-email-hanipouspilot@gmail.com>
Date: Thu, 3 Mar 2016 16:15:19 -0800
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org
Message-Id: <BF563103-E99E-4F2B-BD80-76E4AB006619@holtmann.org>
References: <1457044339-2447-1-git-send-email-hanipouspilot@gmail.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

> T: Bus=01 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#= 4 Spd=12 MxCh= 0
> D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=13d3 ProdID=3472 Rev=00.01
> C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> BugLink: https://bugs.launchpad.net/bugs/1552925
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
