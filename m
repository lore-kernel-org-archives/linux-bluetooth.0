Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 01 Nov 2006 12:54:19 +0100
From: g.len@gmx.de
Message-ID: <20061101115419.9210@gmx.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Patch for switching a diNovo *Laser* to BT
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

following patch extends the hid2hci utility to switch a Logitech diNovo Las=
er desktop to BT mode.

The MediaPad is not visible until switching at least one device to BT mode =
but is switched, too.

Kind regards,

G.Len

--- hid2hci.c.dinovo.diff       2006-10-01 22:39:55.000000000 +0200
+++ tools/hid2hci.c     2006-10-01 22:45:50.000000000 +0200
@@ -223,7 +223,10 @@
        { HCI, 0x046d, 0xc703, switch_logitech },
        { HCI, 0x046d, 0xc704, switch_logitech },
        { HCI, 0x046d, 0xc705, switch_logitech },
+       { HCI, 0x046d, 0xc709, switch_logitech },       /* Logitech diNovo =
Laser mediapad */
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

GMX DSL-Flatrate 0,- Euro* - =DCberall, wo DSL verf=FCgbar ist!
NEU: Jetzt bis zu 16.000 kBit/s! http://www.gmx.net/de/go/dsl

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
