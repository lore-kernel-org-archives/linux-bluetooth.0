Return-Path: <t.schorpp@gmx.de>
Message-ID: <3FFACF71.70607@gmx.de>
Date: Tue, 06 Jan 2004 16:08:33 +0100
From: "thomas.schorpp" <t.schorpp@gmx.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_acl_tx_to: hci0 ACL tx timeout, VIA USB HUBS
References: <3FF9E3F2.4040506@gmx.de> <1073393043.2508.50.camel@pegasus>	 <3FFAB0C5.4050407@gmx.de> <1073396288.2508.72.camel@pegasus>	 <3FFABD90.1020903@gmx.de> <1073397402.2508.81.camel@pegasus>
In-Reply-To: <1073397402.2508.81.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi Thomas,
> 
> 
>>>This is HCI 16.4 firmware and it should work fine. Do you use the SCO
>>>audio support for the HCI USB driver? If yes, disable it, because I
>>>heard of problems with ISOC transfers on VIA chips if I remember
>>>correctly.
>>
>>NO sco module loaded(?)
> 
> 
> I am not talking about the sco module. I am talking about the SCO audio
> option of the HCI USB driver. Disable it to avoid ISOC transfers.

yes, ill check, i think it is disabled, wanted only pan from the 
beginning, thx a lot.

> 
> 
>>>Use 2.4.23-mh1 or 2.4.24-mh1.
>>
>>roger that. what change do you think in the changelogs should target the 
>>problem?
> 
> 
> In general nothing will help here, but I must be sure that we talk about
> the same version of the Bluetooth subsystem.

yes, ill try the patches IF theyre considered stable.
will also try another usb driver -WARNING- do not use via vt6202 ehci 
chipsets, they crashed my gatewaysystem reproducable on boot. :(

but i wonder why the window$ stacks do not trigger the fault... maybe 
usb... have problems with sane scanner too :)

> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 

y
tom
