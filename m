Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] absolute clock
From: Marcel Holtmann <marcel@holtmann.org>
To: paolo2278@freemail.it
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040331113603.3852.qmail@mail.supereva.it>
References: <20040331113603.3852.qmail@mail.supereva.it>
Content-Type: text/plain
Message-Id: <1080733267.2674.53.camel@pegasus>
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
Date: Wed, 31 Mar 2004 13:41:07 +0200

Hi Paolo,

> >about what clock are you talking? With Bluetooth 1.1 you can only read the clock 
> >offset of a remote device. With 1.2 you can also read the
> >local and remote clock values. Look at the HCI specification.
> >
> Are you sure of it? Now I'm reading the BCCMD Baic Commands of July 2003 of the CSR (page 13 BT_Clock), and it doesn't specify if it is refer to 1.1 or 1.2 version.
> And, like I sayed before, when I use the hcitool_cmd with Varid, type, etc., the event is formed of 4 fields: the num. of HCI packets, the OPCODE of the command, and the lenght of the event paramenters. I'd like to read not the lenght of the parameters, but the content of this parameters.

I am sure about it, but you don't understand the difference between the
HCI specification and special vendor commands. What you are talking
about is a CSR specific command to read the local Bluetooth clock. And
because of the fact that this is CSR specific, you should start asking
them.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
