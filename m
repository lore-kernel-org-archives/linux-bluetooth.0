Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Update udev rules for udev 098 and newer
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-3wH/yr3DU3ciwsOS7SQn"
Date: Tue, 14 Oct 2008 22:00:37 +0100
Message-Id: <1224018037.5268.850.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-3wH/yr3DU3ciwsOS7SQn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

As per https://bugzilla.redhat.com/show_bug.cgi?id=246840
and the udev release notes, update the udev rules for newer
versions of udev (>= 098).

--=-3wH/yr3DU3ciwsOS7SQn
Content-Disposition: attachment; filename="0001-Update-udev-rules-for-udev-098-and-newer.patch"
Content-Type: text/x-patch; name="0001-Update-udev-rules-for-udev-098-and-newer.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From fcf1518fd2cc804d339b07d1bfbfd9386ac5da22 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 14 Oct 2008 21:58:02 +0100
Subject: [PATCH] Update udev rules for udev 098 and newer

As per https://bugzilla.redhat.com/show_bug.cgi?id=246840
and the udev release notes, update the udev rules for newer
versions of udev (>= 098).
---
 scripts/bluetooth.rules |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/scripts/bluetooth.rules b/scripts/bluetooth.rules
index 0957225..072335f 100644
--- a/scripts/bluetooth.rules
+++ b/scripts/bluetooth.rules
@@ -1,35 +1,35 @@
 # Brain Boxes BL-620 Bluetooth Adapter
-SUBSYSTEM=="tty", BUS=="pcmcia", SYSFS{prod_id1}=="Brain Boxes", SYSFS{prod_id2}=="Bluetooth PC Card", ENV{HCIOPTS}="bboxes", RUN+="bluetooth_serial"
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="Brain Boxes", ATTRS{prod_id2}=="Bluetooth PC Card", ENV{HCIOPTS}="bboxes", RUN+="bluetooth_serial"
 
 # Xircom CreditCard Bluetooth Adapter
-SUBSYSTEM=="tty", BUS=="pcmcia", SYSFS{prod_id1}=="Xircom", SYSFS{prod_id3}=="CBT", ENV{HCIOPTS}="xircom", RUN+="bluetooth_serial"
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="Xircom", ATTRS{prod_id3}=="CBT", ENV{HCIOPTS}="xircom", RUN+="bluetooth_serial"
 
 # Xircom RealPort2 Bluetooth Adapter
-SUBSYSTEM=="tty", BUS=="pcmcia", SYSFS{prod_id1}=="Xircom", SYSFS{prod_id3}=="CBT", ENV{HCIOPTS}="xircom", RUN+="bluetooth_serial"
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="Xircom", ATTRS{prod_id3}=="CBT", ENV{HCIOPTS}="xircom", RUN+="bluetooth_serial"
 
 # IBM Bluetooth PC Card II
-SUBSYSTEM=="tty", BUS=="pcmcia", SYSFS{prod_id1}=="IBM", SYSFS{prod_id2}=="Bluetooth PC Card II", ENV{HCIOPTS}="tdk", RUN+="bluetooth_serial"
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="IBM", ATTRS{prod_id2}=="Bluetooth PC Card II", ENV{HCIOPTS}="tdk", RUN+="bluetooth_serial"
 
 # TDK Bluetooth PC Card
-SUBSYSTEM=="tty", BUS=="pcmcia", SYSFS{prod_id1}=="TDK", SYSFS{prod_id2}=="Bluetooth PC Card II", ENV{HCIOPTS}="tdk", RUN+="bluetooth_serial"
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="TDK", ATTRS{prod_id2}=="Bluetooth PC Card II", ENV{HCIOPTS}="tdk", RUN+="bluetooth_serial"
 
 # AmbiCom BT2000C Bluetooth PC/CF Card
-SUBSYSTEM=="tty", BUS=="pcmcia", SYSFS{prod_id1}=="AmbiCom BT2000C", SYSFS{prod_id2}=="Bluetooth PC/CF Card", ENV{HCIOPTS}="bt2000c", RUN+="bluetooth_serial"
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="AmbiCom BT2000C", ATTRS{prod_id2}=="Bluetooth PC/CF Card", ENV{HCIOPTS}="bt2000c", RUN+="bluetooth_serial"
 
 # COM One Platinium Bluetooth PC Card
-SUBSYSTEM=="tty", BUS=="pcmcia", SYSFS{prod_id1}=="COM1 SA", SYSFS{prod_id2}=="MC310 CARD", ENV{HCIOPTS}="comone", RUN+="bluetooth_serial"
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="COM1 SA", ATTRS{prod_id2}=="MC310 CARD", ENV{HCIOPTS}="comone", RUN+="bluetooth_serial"
 
 # Sphinx PICO Card
-SUBSYSTEM=="tty", BUS=="pcmcia", SYSFS{prod_id1}=="SPHINX", SYSFS{prod_id2}=="BT-CARD", ENV{HCIOPTS}="picocard", RUN+="bluetooth_serial"
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="SPHINX", ATTRS{prod_id2}=="BT-CARD", ENV{HCIOPTS}="picocard", RUN+="bluetooth_serial"
 
 # H-Soft blue+Card
-SUBSYSTEM=="tty", BUS=="pcmcia", SYSFS{prod_id1}=="H-Soft", SYSFS{prod_id2}=="Blue+CARD", ENV{HCIOPTS}="$sysfs{manf_id},$sysfs{card_id}", RUN+="bluetooth_serial"
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="H-Soft", ATTRS{prod_id2}=="Blue+CARD", ENV{HCIOPTS}="$sysfs{manf_id},$sysfs{card_id}", RUN+="bluetooth_serial"
 
 # Compaq iPAQ Bluetooth Sleeve, Belkin F8T020, any other muppet who used an OXCF950 and didn't bother to program it appropriately.
-SUBSYSTEM=="tty", BUS=="pcmcia", SYSFS{prod_id1}=="CF CARD", SYSFS{prod_id2}=="GENERIC", ENV{HCIOPTS}="$sysfs{manf_id},$sysfs{card_id}", RUN+="bluetooth_serial"
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="CF CARD", ATTRS{prod_id2}=="GENERIC", ENV{HCIOPTS}="$sysfs{manf_id},$sysfs{card_id}", RUN+="bluetooth_serial"
 
 # Zoom Bluetooth Card and Sitecom CN-504 Card
-SUBSYSTEM=="tty", BUS=="pcmcia", SYSFS{prod_id1}=="PCMCIA", SYSFS{prod_id2}=="Bluetooth Card", ENV{HCIOPTS}="zoom", RUN+="bluetooth_serial"
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="PCMCIA", ATTRS{prod_id2}=="Bluetooth Card", ENV{HCIOPTS}="zoom", RUN+="bluetooth_serial"
 
 # CC&C BT0100M
-SUBSYSTEM=="tty", BUS=="pcmcia", SYSFS{prod_id1}=="Bluetooth BT0100M", ENV{HCIOPTS}="bcsp 115200", RUN+="bluetooth_serial"
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="Bluetooth BT0100M", ENV{HCIOPTS}="bcsp 115200", RUN+="bluetooth_serial"
-- 
1.5.5.2


--=-3wH/yr3DU3ciwsOS7SQn--

