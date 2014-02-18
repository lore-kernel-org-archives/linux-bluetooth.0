Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 2/2] Bluetooth: append new supported device to the list [0b05:17d0]
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392740780-27372-2-git-send-email-andriy.shevchenko@linux.intel.com>
Date: Tue, 18 Feb 2014 09:54:59 -0800
Cc: linux-bluetooth@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Message-Id: <E7C36CF9-7788-4E53-8F1B-6F5200E4D08E@holtmann.org>
References: <1392740780-27372-1-git-send-email-andriy.shevchenko@linux.intel.com> <1392740780-27372-2-git-send-email-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

> The device found on Asus Z87 Expert motherboard requires firmware to work
> correctly.
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=03 Cnt=02 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0b05 ProdID=17d0 Rev=00.02
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> drivers/bluetooth/ath3k.c | 2 ++
> drivers/bluetooth/btusb.c | 1 +
> 2 files changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

