Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Feb 2012 09:18:20 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Manoj Iyer <manoj.iyer@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: [PATCH] Add vendor specific ID (0a5c 21f3) for BCM20702A0.
Message-ID: <20120202171820.GB22585@x220.globalsuite.net>
References: <1328196756-3087-1-git-send-email-manoj.iyer@canonical.com>
 <1328196756-3087-2-git-send-email-manoj.iyer@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328196756-3087-2-git-send-email-manoj.iyer@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Feb 02, 2012, Manoj Iyer wrote:
> T: Bus=01 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#= 5 Spd=12 MxCh= 0
> D: Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=0a5c ProdID=21f3 Rev=01.12
> S: Manufacturer=Broadcom Corp
> S: Product=BCM20702A0
> S: SerialNumber=74DE2B344A7B
> C: #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I: If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I: If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I: If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I: If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> Signed-off-by: Manoj Iyer <manoj.iyer@canonical.com>
> Tested-by: Dennis Chua <dennis.chua@canonical.com>
> ---
>  drivers/bluetooth/btusb.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Applied to my bluetooth-next tree (after adding the missing Bluetooth:
prefix to the summary line). Thanks.

Johan
