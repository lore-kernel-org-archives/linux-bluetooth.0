Return-Path: <lgaga@freemail.hu>
Message-ID: <3F7C6888.5050107@freemail.hu>
Date: Thu, 02 Oct 2003 20:03:52 +0200
From: Lengyel Gabor <lgaga@freemail.hu>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] fujitsu-siemens pc card
References: <3F7BF2EC.2080000@freemail.hu> <1065090512.1733.75.camel@pegasus>
In-Reply-To: <1065090512.1733.75.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi,

> it seems that this is a serial cardbus card with a Bluetooth chip on it.
> So please use the yenta_socket PCMCIA bridge driver and you must find
> out which Bluetooth chip they are using.

I did have yenta compiled in the kernel, but I recompiled the whole 
pcmcia support as a module, so now I have a yenta_socket module 
(loaded). Searching through the net with google, I found somewhere that 
in /etc/default/pcmcia I probably should have PCIC=yenta_socket, so I 
changed that (it was PCIC=i82365 before).
However, nothing changed. :( It still does exactly the same I tried to 
explain in my previous post. Maybe I should add some parameters to 
yenta_socket? I am not very familiar with pcmcia, should I do anything 
besides these to "use the yenta_socket PCMCIA bridge driver" as you said?

> Do you got this card working with Windows? If yes, please try to get
> access to another machine with Bluetooth running Linux and run
> 
> 	hcitool info <bdaddr>

I might be able to do this next Tuesday, but not until then. :(

Thank You very much,
Gabor Lengyel (Lgaga)
