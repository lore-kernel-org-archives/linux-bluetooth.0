Return-Path: <johnathon@meichtry.org>
Message-ID: <418997BC.4070702@meichtry.org>
Date: Thu, 04 Nov 2004 02:45:16 +0000
From: Johnathon Meichtry <johnathon@meichtry.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Zoom Bluetooth PCMCIA Card
References: <41893E1D.701@meichtry.org> <1099519948.7125.164.camel@pegasus>
In-Reply-To: <1099519948.7125.164.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel,

Your right, it works fine with serial_cs and bcsp.  FANTASTIC!!!! 

The Xircom CBT works fine in 2.6 although quite flakey as the card is 
prone to dropping device connections (which it does in Windows XP as 
well).  Personally I don't like the Xircom card, it is problematic and 
does not seem to support HID's.

Once again, many thanks,

Johnathon




Marcel Holtmann wrote:

>Hi Johnathon,
>
>  
>
>>Has anyone managed to get the *Zoom Bluetooth PCMCIA card* working with 
>>the btuart_cs driver?  It's man.id us is the same as the CyberBlue CF 
>>Card but when inserted I get the following:
>>
>>*btuart_config: No usable port range found
>>btuart_cs: RequestIO: No more items*
>>
>>Yet i have ample resources and when inserted in the same machine (a 
>>laptop) running XP the Widcomm drivers load fine so there is no hardware 
>>compat. issue.
>>
>>The odd thing is that on Marcel Holtmanns pages there is one with CIS 
>>data (http://www.holtmann.org/linux/bluetooth/cis.html) and in there is 
>>the CIS for this card yet the 2.6 kernel btuart_cs driver is unhappy for 
>>some reason.  I have tried all the other drivers (by editing 
>>pcmcia/config) and none work to the point where "hciconfig dev" shows a 
>>valid device.  I have even edited the source for btuart_cs and added 
>>some additional IO ports but that do not seemed to have helped.  I even 
>>added some additional IRQ's to pcmcia/config.opts.
>>
>>FYI I am running Gentoo 2.6.9-rc1 with the mh3 patch applied and 
>>bluez-libs v2.1, bluez- utils v2.1-r1 and bluez-kernel v2.3.
>>    
>>
>
>I lately get my hands on the Zoom PCMCIA card and it works fine with the
>hci_uart and serial_cs driver. Use "hciattach <dev> bcsp" and it should
>also work for you.
>
>  
>
>>BTW Marcel & the team if you read this post thanks for all your work on 
>>bluez, I have another laptop with a Xircom CBT card in it and for months 
>>it has worked well thanks to all your effort.
>>    
>>
>
>Thanks. Did the Xircom card worked with a 2.6 kernel? Mine doesn't.
>
>Regards
>
>Marcel
>
>
>
>
>  
>
