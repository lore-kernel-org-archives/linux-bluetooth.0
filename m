Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH] Bluetooth: ath3k: Add support for another AR3012 card
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383715560-25328-1-git-send-email-sujith@msujith.org>
Date: Wed, 6 Nov 2013 21:21:33 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Message-Id: <03051E38-A042-404E-9E30-CCEC6EFE17E1@holtmann.org>
References: <1383715560-25328-1-git-send-email-sujith@msujith.org>
To: Sujith Manoharan <sujith@msujith.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sujith,

> T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=04ca ProdID=300b Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Reported-by:Face <falazemi@gmail.com>
> Signed-off-by: Sujith Manoharan <sujith@msujith.org>
> ---
> drivers/bluetooth/ath3k.c | 2 ++
> drivers/bluetooth/btusb.c | 1 +
> 2 files changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

