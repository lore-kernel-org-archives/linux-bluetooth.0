Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: Radu Maurer <a400@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040213113749.GA13481@mail.gmx.de>
References: <20040210175802.GA17705@mail.gmx.de>
	 <1076451979.2777.21.camel@pegasus> <20040211151146.GA19818@mail.gmx.de>
	 <1076515215.2696.36.camel@pegasus> <20040213105035.GA10464@mail.gmx.de>
	 <1076669640.2671.27.camel@pegasus>  <20040213113749.GA13481@mail.gmx.de>
Content-Type: text/plain
Message-Id: <1076673365.2671.30.camel@pegasus>
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
Date: Fri, 13 Feb 2004 12:56:05 +0100

Hi Radu,

> > So it is a pairing problem. Check the keyboard manual how the pairing
> > procedure should work. Maybe it has a default PIN or you have to use the
> > num pad for input.
> 
> The manual just sais to follow the instructions on screen :-(
> There is no default PIN in the manual.
> I tested it on windows 2000: there you get a PIN written on the screen,
> which you have to type on the keyboard.

then you must make sure that the hcid PIN helper works perfect. To be
sure replace it with a simple executable shell script.

	#!/bin/sh
	echo "PIN:0000"

Try again and enter the PIN "0000" on your keyboard.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
