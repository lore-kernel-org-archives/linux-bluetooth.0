Return-Path: <cyrus@holtmann.org>
Date: Sun, 7 Jul 2013 20:11:14 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Thomas Loo <tloo@saltstorm.net>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: ath3k: Add support for Fujitsu Lifebook UH5x2
 [04c5:1330]
Message-ID: <20130707191114.GA3966@joana>
References: <1372812834-6955-1-git-send-email-tloo@saltstorm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372812834-6955-1-git-send-email-tloo@saltstorm.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

* Thomas Loo <tloo@saltstorm.net> [2013-07-03 02:53:54 +0200]:

> The Fujitsu Lifebook UH552/UH572 ships with a Qualcomm AR9462/AR3012 WLAN/BT-Combo card.
> Add device ID to the ath3k driver to enable the bluetooth side of things.
> Patch against v3.10.
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=04c5 ProdID=1330 Rev=00.02
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Signed-off-by: Thomas Loo <tloo@saltstorm.net>
> ---
>  drivers/bluetooth/ath3k.c | 2 ++
>  drivers/bluetooth/btusb.c | 1 +
>  2 files changed, 3 insertions(+)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
