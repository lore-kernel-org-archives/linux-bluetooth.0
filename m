Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Force pairing on single connection?
From: Marcel Holtmann <marcel@holtmann.org>
To: Nils Faerber <nils.faerber@kernelconcepts.de>
Cc: bluez-devel@lists.sf.net
In-Reply-To: <1076339030.2892.64.camel@localhost>
References: <1076339030.2892.64.camel@localhost>
Content-Type: text/plain
Message-Id: <1076407517.32750.36.camel@pegasus>
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
Date: Tue, 10 Feb 2004 11:05:17 +0100

Hi Nils,

> Is it possible to force a pairing process for a single device pair?
> The situation is that I have a device that seems to accept non-paired
> and paired connections. I would now like to pair with this device and
> thus force the pairing, but only for this device - I am quite happy with
> not being forced to pair for mostly all other devices ;)

you must issue a HCI_Authenticate command on the HCI socket. There is no
other method at the moment. I was thinking about adding an ioctl to the
L2CAP socket so this can also be triggered by normal users.

Other proposals are welcome.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
