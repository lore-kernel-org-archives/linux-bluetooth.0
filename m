Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Edd Dumbill <edd@usefulinc.com>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1074424282.16573.52.camel@saag>
Mime-Version: 1.0
Subject: [Bluez-devel] libtool and autoconf versions
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
Date: Sun, 18 Jan 2004 11:11:22 +0000

The BlueZ packages still use libtool1.4 and autoconf2.13, which are
outdated.

Debian wants to remove support for libtool1.4.  The reasons for the
dropping of libtool1.4 are here:
http://lists.debian.org/debian-devel/2004/debian-devel-200401/msg00968.html

What do you think to the idea of updating to libtool1.5 and autoconf2.5
(and a newer automake too)?

It's not actually critical right now, as I am not likely to need to
re-run autoconf or libtool to package BlueZ, but it seems likely that
it's a good idea to move to more updated versions of these tools.

-- Edd




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
