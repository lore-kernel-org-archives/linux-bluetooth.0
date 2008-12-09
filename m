Return-Path: <cyrus@holtmann.org>
From: Luca Santarelli <hrk@users.sourceforge.net>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <F469DC97-2EE0-4CE5-BB1C-7419B8A31985@users.sourceforge.net>
Subject: Re: [PATCH] bluetooth usb hci: ISSC usb dongle with buggy SCO  support
References: <200812050002.13560.hrk@users.sourceforge.net> <20081207001953.c04b9357.akpm@linux-foundation.org> <F469DC97-2EE0-4CE5-BB1C-7419B8A31985@users.sourceforge.net>
Message-Id: <42AA6D4E-DCE6-487B-9B70-2B0A7EFA76EC@users.sourceforge.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Tue, 9 Dec 2008 20:22:27 +0100
Cc: marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Il giorno 09/dic/08, alle ore 00:07, Luca Santarelli ha scritto:

>
> Il giorno 07/dic/08, alle ore 09:19, Andrew Morton ha scritto:
>
>> linux-next has:
>>
>> commit 12421b40b81d101d7535e03f1af197365adc932b
>> Author: Marcel Holtmann <marcel@holtmann.org>
>> Date:   Sun Nov 30 12:17:21 2008 +0100
>>
>>   Bluetooth: Remove deprecated hci_usb driver
>>
>>   The old hci_usb driver has been fully replaced with the new btusb  
>> driver
>>   and all major distributions switched to the new driver now. This  
>> removes
>>   it since it should not be used at all anymore.
>>
>> so please confirm that btusb correctly supports that hardware?
>
>
> Thanks for the heads up! I'll compile the new sources and let you  
> know if it's supported. However, since the hci_usb is being  
> deprecated but not removed, shouldn't the patch be incorporated  
> nonetheless?
>
> Luca

Ok, I'm back. I compiled the latest sources and the device is  
recognized and works with the new btusb driver. What about the  
deprecated driver? Will it be fixed or kept as it is?

Luca
