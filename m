Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Klausler <pmk@cray.com>
Cc: Edd Dumbill <edd@usefulinc.com>, Peter Klausler <peter@klausler.com>,
   Charles Bueche <charles@bueche.ch>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20031202114203.A31354@schnell.us.cray.com>
References: <1070201531.8187.20.camel@bluez.bueche.ch>
	 <1070218289.8534.30.camel@bluez.bueche.ch>
	 <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag>
	 <1070386758.18577.2.camel@pegasus>
	 <20031202114203.A31354@schnell.us.cray.com>
Content-Type: text/plain
Message-Id: <1070387803.18574.21.camel@pegasus>
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
Date: Tue, 02 Dec 2003 18:56:43 +0100

Hi Peter,

> > yes you sent it to list. It still resides in my Bluetooth mailbox and
> > it
> > is working fine. I think Marcelo will take my backport of the uinput
> > driver into 2.4.24 and so uinput should be the way to go, even if this
> > means that we have to implement our own HID parser in userspace.
> 
> What's wrong with the HID parser in bthid today?

my problem is that it depends on static variables and I don't see any
method to create HID reports from input events that the kernel send to
us and we have to forward to the HID device. For exmaple the keyboard
leds.

I have rewritten my core HID layer which is now only one process with an
event loop. It handles all connection establishment and termination fine
without any problems or stalled ACL links. It also gets the vendor and
product ID's from the PNP information. Some minor things have to be
fixed first, but I think that I will commit it to CVS very soon. If this
code is available I hope we can work together on a full featured HID
parser implementation and I think we can use your current code as a
starting point.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
