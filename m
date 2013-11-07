Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Nov 2013 10:35:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sujith Manoharan <sujith@msujith.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCH] Bluetooth: ath3k: Add support for a new AR3012 device
Message-ID: <20131107083514.GA18328@x220.p-661hnu-f1>
References: <1383581303-1081-1-git-send-email-sujith@msujith.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383581303-1081-1-git-send-email-sujith@msujith.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sujith,

On Mon, Nov 04, 2013, Sujith Manoharan wrote:
> T:  Bus=02 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  9 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e05f Rev= 0.02
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Reported-by: Joshua Richenhagen <richenhagen@gmail.com>
> Signed-off-by: Sujith Manoharan <sujith@msujith.org>
> ---
>  drivers/bluetooth/ath3k.c | 2 ++
>  drivers/bluetooth/btusb.c | 1 +
>  2 files changed, 3 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
