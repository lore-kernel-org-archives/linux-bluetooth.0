Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: Radu Maurer <a400@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040210175802.GA17705@mail.gmx.de>
References: <20040210175802.GA17705@mail.gmx.de>
Content-Type: text/plain
Message-Id: <1076451979.2777.21.camel@pegasus>
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
Date: Tue, 10 Feb 2004 23:26:19 +0100

Hi Radu,

> What is the method of choice to get an Apple BT keyboard running with
> linux?

start here http://www.bueche.ch/comp/mx900/mx900.html

> I am running kernel 2.4.24 and debian unstable. 
> I have a USB dongle Epox DG02A.
> 
> Do I need to patch the kernel?

Maybe, because you need the uinput kernel module.

> Do I need to upgrade to the 2.6 kernel series?

You don't need, if you don't want to ;)

> Do i need bluez from CVS?

Yes.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
