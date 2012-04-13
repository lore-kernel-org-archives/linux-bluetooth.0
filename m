Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 13:01:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Add support for Atheros [13d3:3362]
Message-ID: <20120413100101.GC11639@x220.ger.corp.intel.com>
References: <1334309997-882-1-git-send-email-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334309997-882-1-git-send-email-acelan.kao@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi AceLan,

On Fri, Apr 13, 2012, AceLan Kao wrote:
> Add another vendor specific ID for Atheros AR3012 device.
> This chip is wrapped by IMC Networks.
> 
> output of usb-devices:
> T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  5 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3362 Rev=00.02
> S:  Manufacturer=Atheros Communications
> S:  Product=Bluetooth USB Host Controller
> S:  SerialNumber=Alaska Day 2006
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/bluetooth/ath3k.c |    2 ++
>  drivers/bluetooth/btusb.c |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)

Applied to the bluetooth and bluetooth-next trees. Thanks.

Johan
