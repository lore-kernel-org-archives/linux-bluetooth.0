Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Nils Faerber <nils.faerber@kernelconcepts.de>
To: bluez-devel@lists.sf.net
Content-Type: text/plain
Message-Id: <1076087010.964.75.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Pairing fails with RFCOMM
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
Date: Fri, 06 Feb 2004 18:03:31 +0100

Hi all!
I think I found a small problem with rfcomm concerning pairing.
The problem is that if you try to connect to a "new" device which
requires pairing using rfcomm you will be queried for y pin on both
sides. But it seems that a connect timeout in rfcomm is way too short
for being able to input the pin.
It happened to me while trying to connect to a Siemens S55 mobile.
I did a "rfcomm bind" and then opened minicom on the port. After that
the mobile requests the pin. But before you can even start to input the
pin minicom exits with an error.
If I start another connection first, like with multisync, the whole
connection process waits until the pin has been entered on both sides.

CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
