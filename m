Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Dec 2011 20:15:11 +0900
From: Gustavo Padovan <padovan@profusion.mobi>
To: eran <eran@over-here.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Adding USB device 13d3:3375 as an Atheros
 AR3012.
Message-ID: <20111202111511.GA2570@joana>
References: <20111123100356.GB9838@over-here.org>
 <20111123190500.GA7179@samus>
 <20111124111908.GA922@over-here.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111124111908.GA922@over-here.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eran,

* eran <eran@over-here.org> [2011-11-24 11:19:08 +0000]:

> From: Eran <eran@over-here.org>
> 
> The bluetooth module in the Asus UX31/UX21 is based on Atheros AR3012
> and requires a firmware to be uploaded before it's usable.
> 
> Signed-off-by: Eran <eran@over-here.org>
> ---
>  drivers/bluetooth/ath3k.c |    2 ++
>  drivers/bluetooth/btusb.c |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)

Please also add the output of the usb-devices scripts related to this device,
then you can prove in the commit message that your change is really needed.

	Gustavo
