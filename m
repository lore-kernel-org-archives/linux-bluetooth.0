Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] "iobase" pcmcia?
From: Marcel Holtmann <marcel@holtmann.org>
To: abhay b <abhay7182@rediffmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040922104057.17401.qmail@webmail27.rediffmail.com>
References: <20040922104057.17401.qmail@webmail27.rediffmail.com>
Content-Type: text/plain
Message-Id: <1095852735.6223.17.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 22 Sep 2004 13:32:15 +0200

Hi Abhay,

> i got the code of Bluetooth driver for the Anycom BlueCard (LSE039/LSE041)in this code and some other codes i have seen there is a parameter called "iobase "
> its being used in many palces like
>  outb(0x08 | 0x20, iobase + 0x30);
> soem functions take it as argument but i dont know how we r getting a partcular address as nowhere its intialized to some address.
> i want to know what this address is? is it base address of io window? is the pcmcia memory is part of io memory? how we get a value for tha parameter "iobase"

this address comes from the CIS data of the PCMCIA card and is stored in
info->link.io.BasePort1 after configuration.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
