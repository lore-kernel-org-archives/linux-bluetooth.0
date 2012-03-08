Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Mar 2012 02:17:07 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: eran <eran@over-here.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Adding USB device 13d3:3375 as an Atheros
 AR3012.
Message-ID: <20120308051707.GA3998@joana>
References: <20111123100356.GB9838@over-here.org>
 <20111123190500.GA7179@samus>
 <20111205221529.GA21676@over-here.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111205221529.GA21676@over-here.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eran,

* eran <eran@over-here.org> [2011-12-05 22:15:29 +0000]:

> From: Eran <eran@over-here.org>
> 
> The bluetooth module in the Asus UX31/UX21 is based on Atheros AR3012
> and requires a firmware to be uploaded before it's usable.
> 
> output of usb-devices for this module:
> T:  Bus=01 Lev=02 Prnt=02 Port=07 Cnt=03 Dev#=  6 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3375 Rev=00.02
> S:  Manufacturer=Atheros Communications
> S:  Product=Bluetooth USB Host Controller
> S:  SerialNumber=Alaska Day 2006
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

I applied this patch now, thanks.

	Gustavo
