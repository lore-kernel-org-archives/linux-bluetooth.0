Return-Path: <cyrus@holtmann.org>
From: Luis Henriques <luis.henriques@canonical.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: Manoj Iyer <manoj.iyer@canonical.com>,  linux-kernel@vger.kernel.org,  linux-bluetooth@vger.kernel.org,  Johan Hedberg <johan.hedberg@intel.com>,  Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: btusb: Add vendor specific ID (0a5c:21f4) BCM20702A0
References: <1334169563-2948-1-git-send-email-manoj.iyer@canonical.com>
	<1334169563-2948-2-git-send-email-manoj.iyer@canonical.com>
	<20120413214817.GB1680@joana>
Date: Fri, 08 Jun 2012 15:19:14 +0100
In-Reply-To: <20120413214817.GB1680@joana> (Gustavo Padovan's message of "Fri,
	13 Apr 2012 18:48:17 -0300")
Message-ID: <87lijxyjh9.fsf@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

Gustavo Padovan <gustavo@padovan.org> writes:

> Hi Manoj,
>
> * Manoj Iyer <manoj.iyer@canonical.com> [2012-04-11 13:39:23 -0500]:
>
>> usb-devices:
>> T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
>> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=0a5c ProdID=21f4 Rev=01.12
>> S:  Manufacturer=Broadcom Corp
>> S:  Product=BCM20702A0
>> S:  SerialNumber=E4D53DF15584
>> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
>> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
>> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
>
> You need to give the usb-devices for the non-working case. I know it
> works but we need to document this right in the commit message.

I was wondering whether there has been any progress with this patch.
Is there something still pending?

I'll try to get the patch tested as we have a bug open to support this
hardware.

Cheers,
--
Luis
