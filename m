Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1076265358.2670.36.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] D-Bus support
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
Date: Sun, 08 Feb 2004 19:35:58 +0100

Hi Folks,

while thinking about the best management interface and API for the new
Bluetooth library and utils I came to the conlusion that D-Bus is the
right way to go. My problem is now that I don't wanna link the Bluetooth
library itself with the D-Bus library. So what I was thinking of that we
extend the hcid to be a multiplexer with a D-Bus interface. So we have
the HCI raw socket and ioctl's for configuration and we can use the
D-Bus interface for this and also advanced things like PIN management
etc. My idea behind this is, that graphical interfaces like Gnome or KDE
only have to use the D-Bus for their stuff.

Proposals and comments?

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
