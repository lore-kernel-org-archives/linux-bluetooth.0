Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 12:23:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Manoj Iyer <manoj.iyer@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: btusb: Add vendor specific ID (0489 e042) for
 BCM20702A0
Message-ID: <20120413092312.GA10780@x220.ger.corp.intel.com>
References: <1333981348-3720-1-git-send-email-manoj.iyer@canonical.com>
 <1333981348-3720-2-git-send-email-manoj.iyer@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333981348-3720-2-git-send-email-manoj.iyer@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Manoj,

On Mon, Apr 09, 2012, Manoj Iyer wrote:
> T: Bus=02 Lev=02 Prnt=02 Port=04 Cnt=01 Dev#= 3 Spd=12 MxCh= 0
> D: Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=0489 ProdID=e042 Rev=01.12
> S: Manufacturer=Broadcom Corp
> S: Product=BCM20702A0
> S: SerialNumber=E4D53DCA61B5
> C: #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I: If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I: If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I: If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I: If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> Reported-by: Dennis Chua <dennis.chua@canonical.com>
> Signed-off-by: Manoj Iyer <manoj.iyer@canonical.com>
> ---
>  drivers/bluetooth/btusb.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Applied to both bluetooth.git and bluetooth-next.git. Thanks.

Johan
