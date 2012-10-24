Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Oct 2012 10:11:49 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Jeff Cook <jeff@deserettechnology.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for BCM20702A0 [0b05, 17b5]
Message-ID: <20121024121149.GE13884@joana>
References: <5087B517.9090703@deserettechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5087B517.9090703@deserettechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeff,

* Jeff Cook <jeff@deserettechnology.com> [2012-10-24 03:29:59 -0600]:

> Hello all,
> 
> Please see included patch. First-time submitter so let me know if I did 
> something wrong.

Your patch is good, but you need to improve the way you submit it. We recommend
using 'git send-email' like this:

$ git send-email HEAD~1..HEAD

For sending the patch on the top of tree. You can also do combined use of 'git
format-patch' and 'git send-email' in case you want to add some message or to your
patch like the first-time submitter message you did here and these messages
needs to be added...

> 
> Thanks,
> Jeff
> --------------------
> 
> Vendor-specific ID for BCM20702A0.
> Support for bluetooth over Asus Wi-Fi GO!, included with Asus P8Z77-V
> Deluxe.
> 
> T:  Bus=07 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0b05 ProdID=17b5 Rev=01.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM20702A0
> S:  SerialNumber=94DBC98AC113
> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> ---

... after these 3 dashes lines so they don't go the final commit when I apply
your patch.

	Gustavo
