Return-Path: <cyrus@holtmann.org>
Message-ID: <4E79FB51.5030008@canonical.com>
Date: Wed, 21 Sep 2011 22:57:21 +0800
From: Jesse Sung <jesse.sung@canonical.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org, 854399@bugs.launchpad.net
Subject: Re: [PATCH] Bluetooth: Add support for Broadcom BCM20702A0.
References: <4E7840CF.5010805@canonical.com>	 <1316523932.1937.102.camel@aeonflux> <4E794037.6090809@canonical.com> <1316591610.1937.107.camel@aeonflux>
In-Reply-To: <1316591610.1937.107.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 09/21/2011 03:53 PM, Marcel Holtmann wrote:
> Hi Jesse,
>
>> btusb would not take care of this device without its id in the table.
>>
>> If the output of usb-devices is still needed, please let me know.
>
> yes, I just wanna see usb-devices and not go through 3 pages of verbose
> lsusb output since that is not helping me.

Hi Marcel,

usb-devices output:

T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=413c ProdID=8197 Rev=01.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
S:  SerialNumber=D0DF9AA9C9F1
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Thanks,
Jesse
