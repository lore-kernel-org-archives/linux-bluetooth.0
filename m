Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1100541627.7208.61.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] K700i and HID
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 15 Nov 2004 19:00:27 +0100

Hi,

I got my hands on the Sony Ericsson K700i from a friend and this is a
very interesting phone from the Bluetooth view. It supports a lot of
services and one of them is the HID profile. However it only allows two
L2CAP channels at the same time and this makes the SDP discovery in this
case a little bit hard. If you wanna request the SDP information after
you opend the HID control and interrupt channels the phone simply
responds with an error message and then crashes. To workaround this
problem for now I added the --nosdp parameter to hidd and simply assume
a boot mode with a subclass value of 0xc0. This works great so far and
if this was my phone I could use it for my next presentation. The new
code is in CVS now. If you own the K700i, give it a try.

Other stuff to investigate is the PAN/BNEP support and of couse the
SyncML over OBEX. I have seen this SyncML over OBEX support also on
newer Nokia phones and hopefully the mRouter crap will be gone very
soon.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
