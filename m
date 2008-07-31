Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A607FC4A-8311-4276-BE2A-364011C74DC8@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Kasper Revsbech <mail@krevsbech.dk>
In-Reply-To: <48919D91.3070703@krevsbech.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v928.1)
Subject: Re: How to set packet type and how to see which packet type is in use ?
Date: Thu, 31 Jul 2008 15:42:53 +0200
References: <48919D91.3070703@krevsbech.dk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kasper,

> I am trying to compare some different Bluetooth setup. Doing that I  
> would like to try with different baseband packet types.
> So far I have been trying in two scenarios using hciconfig hci0  
> ptype <type> and that seems to work, at least in the case where I am  
> using RFCOMM sockets for communication. But judging from the  
> transfer rate it does not seem to work using a PAND/BNEP setup. This  
> leads to the following questions:
>
> - How can I observe the currently uses packet type? I have been  
> trying with hcidump and even parsed it with wireshark but can't  
> really find the identifier that identifies witch packet type  
> currently  is in use.

you can't since that is the job of the link manager and not the host  
stack.

> - Can I by somehow set the packettype using setsocktop() on a rfcomm  
> socket ? I have been look to find documentation on the content of  
> the sockopt struc used but can't really find any. I have also tried  
> looking in the code but can't figure out how to manipulate the  
> packet type else that using hciconfig

Don't mess around with packet types. Really, I mean it, don't. Leave  
the default and leave the rest up to the link manager.

Regards

Marcel

