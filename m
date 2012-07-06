Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Jul 2012 12:14:22 -0500 (CDT)
From: Manoj Iyer <manoj.iyer@canonical.com>
To: Gustavo Padovan <gustavo@padovan.org>
cc: Manoj Iyer <manoj.iyer@canonical.com>, linux-kernel@vger.kernel.org,
    linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@intel.com>,
    Marcel Holtmann <marcel@holtmann.org>,
    Chris Gagnon <chris.gagnon@canonical.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add vendor specific ID (0a5c:21f4)
 BCM20702A0
In-Reply-To: <20120413214817.GB1680@joana>
Message-ID: <alpine.DEB.2.02.1207061211420.2959@lazy>
References: <1334169563-2948-1-git-send-email-manoj.iyer@canonical.com> <1334169563-2948-2-git-send-email-manoj.iyer@canonical.com> <20120413214817.GB1680@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 13 Apr 2012, Gustavo Padovan wrote:

Gustavo,

Sorry it took a long time to locate the hardware to get this info, I got 
this info from one our QA engg cced here. Do you want me to resubmit the 
patch ?

Before the patch
=================
T: Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 2 Spd=12 MxCh= 0
D: Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=0a5c ProdID=21f4 Rev=01.12
S: Manufacturer=Broadcom Corp
S: Product=BCM20702A0
S: SerialNumber=E4D53DF154D6
C: #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I: If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I: If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I: If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I: If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

After the patch
================
T: Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 2 Spd=12 MxCh= 0
D: Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=0a5c ProdID=21f4 Rev=01.12
S: Manufacturer=Broadcom Corp
S: Product=BCM20702A0
S: SerialNumber=E4D53DF154D6
C: #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I: If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I: If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I: If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I: If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

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
>
> 	Gustavo
>
>




--
====================
Manoj Iyer
Ubuntu/Canonical
Hardware Enablement
====================
