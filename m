Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 5 Sep 2006 18:53:33 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060905165333.GB16417@suse.de>
MIME-Version: 1.0
Subject: [Bluez-devel] more udev rules for pcmcia cards
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

Hi,

while updating my packages i found that we (SUSE) still have additional
udev rules for pcmcia cards.
The origin of those is not 100% clear, there are rumours that some =

unfortunate trainee extracted them from the old pcmcia package =

configuration.
I have not verified them with actual hardware.

Index: scripts/bluetooth.rules
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluez/utils/scripts/bluetooth.rules,v
retrieving revision 1.1
diff -u -r1.1 bluetooth.rules
--- scripts/bluetooth.rules	10 Aug 2006 10:09:05 -0000	1.1
+++ scripts/bluetooth.rules	5 Sep 2006 16:48:19 -0000
@@ -34,3 +34,43 @@
 =

 # Zoom Bluetooth Card and Sitecom CN-504 Card
 SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"PCMCIA", SY=
SFS{prod_id2}=3D=3D"Bluetooth Card", RUN+=3D"bluetooth_serial"
+
+# dtl1_cs
+#
+# Nokia Bluetooth Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"Nokia Mobil=
e Phones", SYSFS{prod_id2}=3D=3D"DTL-1", RUN+=3D"bluetooth_serial"
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"Nokia Mobil=
e Phones", SYSFS{prod_id2}=3D=3D"DTL-4", RUN+=3D"bluetooth_serial"
+# Socket Bluetooth Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"Socket", SY=
SFS{prod_id2}=3D=3D"CF+ Personal Network Card", RUN+=3D"bluetooth_serial"
+
+# bt3c_cs
+#
+# 3Com Bluetooth PC Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"3COM", SYSF=
S{prod_id3}=3D=3D"Bluetooth PC Card", RUN+=3D"bluetooth_serial"
+
+# bluecard_cs
+#
+# LSE041 Bluetooth PC Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"BlueCard", =
SYSFS{prod_id2}=3D=3D"LSE041", RUN+=3D"bluetooth_serial"
+
+# LSE039 Bluetooth Compact Flash Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"WSS", SYSFS=
{prod_id2}=3D=3D"LSE039", RUN+=3D"bluetooth_serial"
+
+# LSE139 Bluetooth Compact Flash Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"BTCFCARD", =
SYSFS{prod_id2}=3D=3D"LSE139", RUN+=3D"bluetooth_serial"
+
+# bt950_cs
+#
+# AmbiCom BT2000E Bluetooth Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"AmbiCom,Inc=
", SYSFS{prod_id2}=3D=3D"BT2000E", RUN+=3D"bluetooth_serial"
+
+# Pretec BT2000E Bluetooth Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"Pretec", SY=
SFS{prod_id2}=3D=3D"BT2000E", RUN+=3D"bluetooth_serial"
+
+# Billionton Bluetooth Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"Compact Fla=
sh", SYSFS{prod_id2}=3D=3D"Bluetooth Card", RUN+=3D"bluetooth_serial"
+
+# btuart_cs
+#
+# Cyber-blue Compact Flash Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"BT", SYSFS{=
prod_id2}=3D=3D"", SYSFS{prod_id3}=3D=3D"", SYSFS{prod_id4}=3D=3D"", RUN+=
=3D"bluetooth_serial"
-- =

Stefan Seyfried                     | "Please, just tell people
QA / R&D Team Mobile Devices        |               to use KDE."
SUSE LINUX Products GmbH, N=FCrnberg  |          -- Linus Torvalds

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
