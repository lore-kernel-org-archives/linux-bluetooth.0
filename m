Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: btusb: Add Dell OptiPlex 3060 to
 btusb_needs_reset_resume_table
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180301054252.16007-1-kai.heng.feng@canonical.com>
Date: Thu, 1 Mar 2018 08:43:59 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>
Message-Id: <80186954-EDE1-4DBA-8ED6-055BC53FD1C5@holtmann.org>
References: <20180301054252.16007-1-kai.heng.feng@canonical.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kai-Heng,

> The issue can be reproduced before commit fd865802c66b ("Bluetooth:
> btusb: fix QCA Rome suspend/resume") gets introduced, so the reset
> resume quirk is still needed for this system.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=13 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
> D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0cf3 ProdID=e007 Rev=00.01
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Cc: stable@vger.kernel.org
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 7 +++++++
> 1 file changed, 7 insertions(+)

patch has been applied to bluetooth-stable tree.

Regards

Marcel
