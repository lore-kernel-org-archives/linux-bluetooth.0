Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 05 Nov 2006 11:40:20 +0100
From: g.len@gmx.de
Message-ID: <20061105104020.38470@gmx.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Patch for switching a diNovo *Laser* to BT
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

I found some more information that I mixed up some IDs. 0xc709 should be th=
e BT dongle in HCI mode not the Mediepad. Sorry.

The following patch is updated to this situation.

BTW, I would like to do some testing with the LCD of the mediapad. Where wo=
uld be a good starting point looking for ducmentation / code examples to co=
mmunicate with such a device? (I am not asking for the Logitech-protocol.)

Kind regards,

G.Len

--- hid2hci.c.dinovo.diff       2006-10-01 22:39:55.000000000 +0200
+++ tools/hid2hci.c     2006-10-01 22:45:50.000000000 +0200
@@ -223,7 +223,9 @@
        { HCI, 0x046d, 0xc703, switch_logitech },
        { HCI, 0x046d, 0xc704, switch_logitech },
        { HCI, 0x046d, 0xc705, switch_logitech },
        { HCI, 0x046d, 0xc70a, switch_logitech },       /* Logitech diNovo =
mouse */
+       { HCI, 0x046d, 0xc70b, switch_logitech },       /* Logitech diNovo =
Laser keyboard */
+       { HCI, 0x046d, 0xc70c, switch_logitech },       /* Logitech diNovo =
Laser mouse */
        { HCI, 0x046d, 0xc70e, switch_logitech },       /* logitech diNovo =
keyboard */
        { -1 }
 };

-- =

Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! =

Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
