Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hci_uart and Ambicom BT2000E
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Jimenez <djimenez@pobox.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4075EAF9.8060801@pobox.com>
References: <40743AAE.4070808@pobox.com> <1081418373.2970.6.camel@pegasus>
	 <4075EAF9.8060801@pobox.com>
Content-Type: text/plain
Message-Id: <1081534461.26610.15.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 09 Apr 2004 20:14:21 +0200

Hi Daniel,

> > you should check how many hcid you have running. There must only be one.
> 
> Do you mean by doing hciconfig -a? I only see one interface that way.

check it with "ps x".

> > The other problem is that not every serial based PCMCIA card works right
> > now with the 2.6 kernel. Some do and some don't and actually this is a
> > problem in the serial subsystem, but I don't know where.
> 
> Interesting and disappointing. I bought this card because I thought it 
> worked based on the hardware list :(. What can I do to find out if it's 
> the card?

I tested a Pretec card with an Ericsson chip on it and the card don't
works either, but sometimes I get some bytes. I don't have enough time
to dig deeper into it, but it must be possible to use these cards with
serial_cs and hci_uart.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
