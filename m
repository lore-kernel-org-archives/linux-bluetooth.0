Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: btusb: Add support for 0cf3:e009
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1471323006-26712-1-git-send-email-kai.heng.feng@canonical.com>
Date: Tue, 16 Aug 2016 08:14:44 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kai.heng.feng@canonical.com, jesse.sung@canonical.com
Message-Id: <7033EFE1-C455-4A9A-8B99-9514E1F0F9BD@holtmann.org>
References: <1471323006-26712-1-git-send-email-kai.heng.feng@canonical.com>
To: Kai-Heng Feng <kaihengfeng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kai-Heng,

> Device 0cf3:e009 is one of the QCA ROME family.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=07 Cnt=04 Dev#=  4 Spd=12  MxCh= 0
> D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0cf3 ProdID=e009 Rev=00.01
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied ti bluetooth-next tree.

Regards

Marcel
