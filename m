Return-Path: <office@produktivIT.com>
From: Krisztian Mark Szentes <office@produktivIT.com>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Subject: Re: [Bluez-users] bt3c_cs time out - no firmware loaded?
Date: Fri, 16 May 2003 16:22:47 +0200
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>, Edd Dumbill <ejad@debian.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: 
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
	<1053091452.2561.86.camel@gaston> <1053091839.26550.125.camel@pegasus>
In-Reply-To: <1053091839.26550.125.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Message-Id: <200305161622.47728.office@produktivIT.com>
List-ID: <bluez-users.lists.sourceforge.net>



On Friday 16 May 2003 15:30, Marcel Holtmann wrote:

> > Hrm... The problem isn't simple. You are just not supposed to tap IOs
> > that way from userland, especially since PPC arch doesn't have
> > anything like "PIO" instructions. The IO space of your card is
> > actually mapped somewhere in physical memory, that "somewhere" not
> > beeing generally available to userland.
> >
> > Can you tell me more about the card ? Is it a 16 bits PCMCIA device or
> > is it a cardbus (PCI) one ? Why can't you tap the IOs solely from
> > within a kernel driver ?
>
> this is a 16 Bit PCMCIA card. We need to load the firmware from
> userspace, because we can't distribute it within the kernel driver due
> the legal issues. At the moment we don't even distribute the firmware
> file with our userspace firmware loader program.

OK.

I am fed up with the card, I bought it almost year ago and hoped it would 
some time become easier to use. I chose it over the Xircom and Anycom 
parts because its antenna looked neat. In the meantime, I also bought a 
USB device which explicitely stated Linux compatibility on the 
manufacturer's web site (Epox).
I'm thinking about 

(1) asking 3COM for permission, or 
(2) returning it to 3COM's headquarters or 
(3) publicly destroying it and putting up a video or
(4) sell it to a modern slave (Windoze user) and donating the money to 
Debian

Marcel, can you give me a hint whom I should contact for (1)? 

Salut

Mark

P.S. Maybe I should do (1), (2), (3) AND (4)   :-))

-- 
produktivIT   -  Open-Source Solution Provider
Siebenbrunnengasse 55/7
A-1050 Wien
