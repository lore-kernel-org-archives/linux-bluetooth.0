Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Problem with read on RFCOMM Sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: "Williams, Richard" <Richard.Williams@VITRONICS.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A45BDC12@goofy.vitronics.com>
References: <A1F0D47583A2D711919F00600819B3A45BDC12@goofy.vitronics.com>
Content-Type: text/plain
Message-Id: <1087392453.4309.19.camel@pegasus>
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
Date: Wed, 16 Jun 2004 15:27:33 +0200

Hi Richard,

> I understand why strlen should not be used in this case, but why
> unsigned char instead of char ? There are many examples of the 
> use of the generic file I/O read() function in the literature 
> using char buffers. Is this case different ?

it actually depends on the other side. If the other side also uses char
then there should be no problem, but it is better to use unsigned char
if you don't know what the other side is sending.

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
