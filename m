Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: ubaldo <ubaldo@eja.it>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040618183339.20830.qmail@webmail.aruba.it>
References: <20040618175410.28510.qmail@webmail.aruba.it>
	 <1087582530.4309.121.camel@pegasus>
	 <20040618183339.20830.qmail@webmail.aruba.it>
Content-Type: text/plain
Message-Id: <1087583875.25061.2.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: multi rfcomm/sco connection
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
Date: Fri, 18 Jun 2004 20:37:55 +0200

Hi,

> > it is possible to establish up to 30 RFCOMM connections into each
> > direction. The number of SCO connections is limited to one per ACL link.
> 
> Does it mean that for each SCO connection I need another bt-dongle, or there 
> is a way to allow multi SCO connection with the same bt-dongle?

I said per ACL link. The Bluetooth specification defines that between
two devices one ACL and up to three SCO links can exists. The max number
of SCO links per piconet is also three. In BlueZ we currently allow one
ACL and one SCO link between two devices. This limitation is some kind
of historic. Feel free to fix it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
