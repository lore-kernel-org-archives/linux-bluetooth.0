Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Bluez-users] bt3c_cs time out - no firmware loaded?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: Krisztian Mark Szentes <office@produktivIT.com>, BlueZ Mailing List <bluez-users@lists.sourceforge.net>, Edd Dumbill <ejad@debian.org>
In-Reply-To: <1053095112.26551.141.camel@pegasus>
References: 
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
	<200305131047.39294.office@produktivIT.com>
	<1053083095.26552.49.camel@pegasus>
	<200305161438.08919.office@produktivIT.com>
	<1053091452.2561.86.camel@gaston>  <1053091839.26550.125.camel@pegasus>
	<1053091938.2978.88.camel@gaston>  <1053092394.26552.132.camel@pegasus>
	<1053092826.2561.90.camel@gaston>  <1053093446.26552.137.camel@pegasus>
	<1053094302.2561.99.camel@gaston>  <1053095112.26551.141.camel@pegasus>
Content-Type: text/plain
Message-Id: <1053096479.2562.101.camel@gaston>
Mime-Version: 1.0
Date: 16 May 2003 16:48:00 +0200
Sender: Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <bluez-users.lists.sourceforge.net>


> I have not a PowerPC platform for testing, so I can't write any code at
> the moment. But your proposal looks very ugly and I don't want to go
> this way for 2.4. I will wait until the firmware stuff is accepted by
> Linus and then try to port the current driver to the new architecture.

It is quite ugly, though not as ugly as hard coding the IO ports like
some ppl do ;) It's also the only proper way to access the IO ports
from userland regardless which PCI host bus they are on. We added this
syscall for the sake of XFree initially.

Ben.
