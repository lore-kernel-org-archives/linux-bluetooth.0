Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH] Fix build in directory separate from source.
Date: Tue, 21 Dec 2010 15:22:35 +0100
Message-ID: <1292941355-5870-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After bootstrapping can build bluez outside of sources. Patch add required
"include" paths, put all udev's rules to preprocess stage and change
behaviour on "./configure --prefix=PATH". When --prefix is set, all files
will be put in prefix-path. Otherwise, use path from PKG_CONFIG. This change
allow install all files in place which user chosen.
---
 Makefile.am                        |   10 ++++++----
 acinclude.m4                       |    2 +-
 configure.ac                       |    5 +++--
 scripts/bluetooth-hid2hci.rules    |   36 ------------------------------------
 scripts/bluetooth-hid2hci.rules.in |   36 ++++++++++++++++++++++++++++++++++++
 scripts/bluetooth-serial.rules     |   35 -----------------------------------
 scripts/bluetooth-serial.rules.in  |   35 +++++++++++++++++++++++++++++++++++
 7 files changed, 81 insertions(+), 78 deletions(-)
 delete mode 100644 scripts/bluetooth-hid2hci.rules
 create mode 100644 scripts/bluetooth-hid2hci.rules.in
 delete mode 100644 scripts/bluetooth-serial.rules
 create mode 100644 scripts/bluetooth-serial.rules.in

diff --git a/Makefile.am b/Makefile.am
index 5f96975..ab4b460 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -361,12 +361,14 @@ AM_YFLAGS = -d
 AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@ \
 		-DBLUETOOTH_PLUGIN_BUILTIN -DPLUGINDIR=\""$(plugindir)"\"
 
-INCLUDES = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
-			-I$(srcdir)/audio -I$(srcdir)/sbc -I$(srcdir)/gdbus \
-			-I$(srcdir)/attrib -I$(srcdir)/btio
+INCLUDES = -I$(builddir)/lib -I$(srcdir)/lib \
+		-I$(builddir)/tools -I$(srcdir)/tools \
+		-I$(builddir)/src -I$(srcdir)/src \
+		-I$(srcdir)/audio -I$(srcdir)/sbc -I$(srcdir)/gdbus \
+		-I$(srcdir)/attrib -I$(srcdir)/btio
 
 if MCAP
-INCLUDES += -I$(builddir)/health
+INCLUDES += -I$(builddir)/health -I$(srcdir)/health
 endif
 
 pkgconfigdir = $(libdir)/pkgconfig
diff --git a/acinclude.m4 b/acinclude.m4
index 287f07d..4f1aae4 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -84,7 +84,7 @@ AC_DEFUN([AC_INIT_BLUEZ], [
 	AC_SUBST(STORAGEDIR, "${storagedir}")
 
 	UDEV_DATADIR="`$PKG_CONFIG --variable=udevdir udev`"
-	if (test -z "${UDEV_DATADIR}"); then
+	if ((test "${prefix}" != "NONE") || (test -z "${UDEV_DATADIR}")); then
 		UDEV_DATADIR="${sysconfdir}/udev/rules.d"
 	else
 		UDEV_DATADIR="${UDEV_DATADIR}/rules.d"
diff --git a/configure.ac b/configure.ac
index 5f09cb6..da567e6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -55,5 +55,6 @@ if (test "${enable_capng}" = "yes"); then
 	AC_DEFINE(HAVE_CAPNG, 1, [Define to 1 if you have capabilities library.])
 fi
 
-AC_OUTPUT(Makefile scripts/bluetooth.rules doc/version.xml
-					src/bluetoothd.8 bluez.pc)
+AC_OUTPUT(Makefile scripts/bluetooth.rules scripts/bluetooth-hid2hci.rules
+		scripts/bluetooth-serial.rules doc/version.xml src/bluetoothd.8
+		bluez.pc)
diff --git a/scripts/bluetooth-hid2hci.rules b/scripts/bluetooth-hid2hci.rules
deleted file mode 100644
index 1b231d1..0000000
--- a/scripts/bluetooth-hid2hci.rules
+++ /dev/null
@@ -1,36 +0,0 @@
-# Variety of Dell Bluetooth devices
-#
-# it looks like a bit of an odd rule, because it is matching
-# on a mouse device that is self powered, but that is where
-# a HID report needs to be sent to switch modes.
-#
-# Known supported devices:
-#   413c:8154
-#   413c:8158
-#   413c:8162
-ACTION=="add", ENV{ID_VENDOR}=="413c", ENV{ID_CLASS}=="mouse", ATTRS{bmAttributes}=="e0", KERNEL=="mouse*", RUN+="/usr/sbin/hid2hci --method dell -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-
-# Logitech devices
-ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c703" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c704" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c705" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c70a" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c70b" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c70c" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c70e" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c713" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c714" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c71b" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c71c" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-
-# CSR devices (in HID mode)
-ACTION=="add", ENV{ID_VENDOR}=="0a12", ENV{ID_MODEL}=="1000" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-ACTION=="add", ENV{ID_VENDOR}=="0458", ENV{ID_MODEL}=="1000" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-ACTION=="add", ENV{ID_VENDOR}=="05ac", ENV{ID_MODEL}=="1000" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-
-# CSR devices (in HCI mode)
-#ACTION=="add", ENV{ID_VENDOR}=="0a12", ENV{ID_MODEL}=="0001" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hid"
-#ACTION=="add", ENV{ID_VENDOR}=="0458", ENV{ID_MODEL}=="003f" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hid"
-#ACTION=="add", ENV{ID_VENDOR}=="05ac", ENV{ID_MODEL}=="8203" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hid"
-#ACTION=="add", ENV{ID_VENDOR}=="05ac", ENV{ID_MODEL}=="8204" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hid"
-#ACTION=="add", ENV{ID_VENDOR}=="05ac", ENV{ID_MODEL}=="8207" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hid"
diff --git a/scripts/bluetooth-hid2hci.rules.in b/scripts/bluetooth-hid2hci.rules.in
new file mode 100644
index 0000000..1b231d1
--- /dev/null
+++ b/scripts/bluetooth-hid2hci.rules.in
@@ -0,0 +1,36 @@
+# Variety of Dell Bluetooth devices
+#
+# it looks like a bit of an odd rule, because it is matching
+# on a mouse device that is self powered, but that is where
+# a HID report needs to be sent to switch modes.
+#
+# Known supported devices:
+#   413c:8154
+#   413c:8158
+#   413c:8162
+ACTION=="add", ENV{ID_VENDOR}=="413c", ENV{ID_CLASS}=="mouse", ATTRS{bmAttributes}=="e0", KERNEL=="mouse*", RUN+="/usr/sbin/hid2hci --method dell -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+
+# Logitech devices
+ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c703" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c704" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c705" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c70a" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c70b" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c70c" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c70e" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c713" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c714" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c71b" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c71c" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+
+# CSR devices (in HID mode)
+ACTION=="add", ENV{ID_VENDOR}=="0a12", ENV{ID_MODEL}=="1000" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+ACTION=="add", ENV{ID_VENDOR}=="0458", ENV{ID_MODEL}=="1000" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+ACTION=="add", ENV{ID_VENDOR}=="05ac", ENV{ID_MODEL}=="1000" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+
+# CSR devices (in HCI mode)
+#ACTION=="add", ENV{ID_VENDOR}=="0a12", ENV{ID_MODEL}=="0001" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hid"
+#ACTION=="add", ENV{ID_VENDOR}=="0458", ENV{ID_MODEL}=="003f" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hid"
+#ACTION=="add", ENV{ID_VENDOR}=="05ac", ENV{ID_MODEL}=="8203" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hid"
+#ACTION=="add", ENV{ID_VENDOR}=="05ac", ENV{ID_MODEL}=="8204" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hid"
+#ACTION=="add", ENV{ID_VENDOR}=="05ac", ENV{ID_MODEL}=="8207" RUN+="/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hid"
diff --git a/scripts/bluetooth-serial.rules b/scripts/bluetooth-serial.rules
deleted file mode 100644
index 072335f..0000000
--- a/scripts/bluetooth-serial.rules
+++ /dev/null
@@ -1,35 +0,0 @@
-# Brain Boxes BL-620 Bluetooth Adapter
-SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="Brain Boxes", ATTRS{prod_id2}=="Bluetooth PC Card", ENV{HCIOPTS}="bboxes", RUN+="bluetooth_serial"
-
-# Xircom CreditCard Bluetooth Adapter
-SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="Xircom", ATTRS{prod_id3}=="CBT", ENV{HCIOPTS}="xircom", RUN+="bluetooth_serial"
-
-# Xircom RealPort2 Bluetooth Adapter
-SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="Xircom", ATTRS{prod_id3}=="CBT", ENV{HCIOPTS}="xircom", RUN+="bluetooth_serial"
-
-# IBM Bluetooth PC Card II
-SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="IBM", ATTRS{prod_id2}=="Bluetooth PC Card II", ENV{HCIOPTS}="tdk", RUN+="bluetooth_serial"
-
-# TDK Bluetooth PC Card
-SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="TDK", ATTRS{prod_id2}=="Bluetooth PC Card II", ENV{HCIOPTS}="tdk", RUN+="bluetooth_serial"
-
-# AmbiCom BT2000C Bluetooth PC/CF Card
-SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="AmbiCom BT2000C", ATTRS{prod_id2}=="Bluetooth PC/CF Card", ENV{HCIOPTS}="bt2000c", RUN+="bluetooth_serial"
-
-# COM One Platinium Bluetooth PC Card
-SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="COM1 SA", ATTRS{prod_id2}=="MC310 CARD", ENV{HCIOPTS}="comone", RUN+="bluetooth_serial"
-
-# Sphinx PICO Card
-SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="SPHINX", ATTRS{prod_id2}=="BT-CARD", ENV{HCIOPTS}="picocard", RUN+="bluetooth_serial"
-
-# H-Soft blue+Card
-SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="H-Soft", ATTRS{prod_id2}=="Blue+CARD", ENV{HCIOPTS}="$sysfs{manf_id},$sysfs{card_id}", RUN+="bluetooth_serial"
-
-# Compaq iPAQ Bluetooth Sleeve, Belkin F8T020, any other muppet who used an OXCF950 and didn't bother to program it appropriately.
-SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="CF CARD", ATTRS{prod_id2}=="GENERIC", ENV{HCIOPTS}="$sysfs{manf_id},$sysfs{card_id}", RUN+="bluetooth_serial"
-
-# Zoom Bluetooth Card and Sitecom CN-504 Card
-SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="PCMCIA", ATTRS{prod_id2}=="Bluetooth Card", ENV{HCIOPTS}="zoom", RUN+="bluetooth_serial"
-
-# CC&C BT0100M
-SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="Bluetooth BT0100M", ENV{HCIOPTS}="bcsp 115200", RUN+="bluetooth_serial"
diff --git a/scripts/bluetooth-serial.rules.in b/scripts/bluetooth-serial.rules.in
new file mode 100644
index 0000000..072335f
--- /dev/null
+++ b/scripts/bluetooth-serial.rules.in
@@ -0,0 +1,35 @@
+# Brain Boxes BL-620 Bluetooth Adapter
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="Brain Boxes", ATTRS{prod_id2}=="Bluetooth PC Card", ENV{HCIOPTS}="bboxes", RUN+="bluetooth_serial"
+
+# Xircom CreditCard Bluetooth Adapter
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="Xircom", ATTRS{prod_id3}=="CBT", ENV{HCIOPTS}="xircom", RUN+="bluetooth_serial"
+
+# Xircom RealPort2 Bluetooth Adapter
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="Xircom", ATTRS{prod_id3}=="CBT", ENV{HCIOPTS}="xircom", RUN+="bluetooth_serial"
+
+# IBM Bluetooth PC Card II
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="IBM", ATTRS{prod_id2}=="Bluetooth PC Card II", ENV{HCIOPTS}="tdk", RUN+="bluetooth_serial"
+
+# TDK Bluetooth PC Card
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="TDK", ATTRS{prod_id2}=="Bluetooth PC Card II", ENV{HCIOPTS}="tdk", RUN+="bluetooth_serial"
+
+# AmbiCom BT2000C Bluetooth PC/CF Card
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="AmbiCom BT2000C", ATTRS{prod_id2}=="Bluetooth PC/CF Card", ENV{HCIOPTS}="bt2000c", RUN+="bluetooth_serial"
+
+# COM One Platinium Bluetooth PC Card
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="COM1 SA", ATTRS{prod_id2}=="MC310 CARD", ENV{HCIOPTS}="comone", RUN+="bluetooth_serial"
+
+# Sphinx PICO Card
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="SPHINX", ATTRS{prod_id2}=="BT-CARD", ENV{HCIOPTS}="picocard", RUN+="bluetooth_serial"
+
+# H-Soft blue+Card
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="H-Soft", ATTRS{prod_id2}=="Blue+CARD", ENV{HCIOPTS}="$sysfs{manf_id},$sysfs{card_id}", RUN+="bluetooth_serial"
+
+# Compaq iPAQ Bluetooth Sleeve, Belkin F8T020, any other muppet who used an OXCF950 and didn't bother to program it appropriately.
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="CF CARD", ATTRS{prod_id2}=="GENERIC", ENV{HCIOPTS}="$sysfs{manf_id},$sysfs{card_id}", RUN+="bluetooth_serial"
+
+# Zoom Bluetooth Card and Sitecom CN-504 Card
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="PCMCIA", ATTRS{prod_id2}=="Bluetooth Card", ENV{HCIOPTS}="zoom", RUN+="bluetooth_serial"
+
+# CC&C BT0100M
+SUBSYSTEM=="tty", SUBSYSTEMS=="pcmcia", ATTRS{prod_id1}=="Bluetooth BT0100M", ENV{HCIOPTS}="bcsp 115200", RUN+="bluetooth_serial"
-- 
1.7.0.4

