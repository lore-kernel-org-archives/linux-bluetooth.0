Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 7 Oct 2007 14:40:23 -0400
From: Aristeu Sergio Rozanski Filho <aris@ruivo.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20071007184023.GX7430@cathedrallabs.org>
MIME-Version: 1.0
Subject: [Bluez-devel] [RFC][PATCH 1/4] add bluetooth id database
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This patch adds a simple bluetooth id database

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ input/bluetooth_ids.h	2007-10-06 23:35:10.000000000 -0400
@@ -0,0 +1,8 @@
+#ifndef BLUETOOTH_IDS_H
+#define BLUETOOTH_IDS_H
+
+#define BLUETOOTH_VENDOR_ID_SONY 0x054c
+#define BLUETOOTH_DEVICE_ID_PS3CONTROLLER 0x0268
+
+#endif	/* BLUETOOTH_IDS_H */
+
--- input.orig/device.c	2007-10-06 23:35:07.000000000 -0400
+++ input/device.c	2007-10-06 23:35:10.000000000 -0400
@@ -52,6 +52,7 @@
 #include "error.h"
 #include "manager.h"
 #include "storage.h"
+#include "bluetooth_ids.h"
 
 #define INPUT_DEVICE_INTERFACE	"org.bluez.input.Device"
 
@@ -615,7 +616,8 @@
 
 	info("New input device %s (%s)", addr, req.name);
 
-	if (req.vendor == 0x054c && req.product == 0x0268) {
+	if (req.vendor == BLUETOOTH_VENDOR_ID_SONY &&
+	    req.product == BLUETOOTH_DEVICE_ID_PS3CONTROLLER) {
 		unsigned char buf[] = { 0x53, 0xf4,  0x42, 0x03, 0x00, 0x00 };
 		err = write(ctrl_sk, buf, sizeof(buf));
 	}
--- input.orig/Makefile.am	2007-10-06 23:35:23.000000000 -0400
+++ input/Makefile.am	2007-10-06 23:35:33.000000000 -0400
@@ -12,7 +12,8 @@
 
 bluetoothd_service_input_SOURCES = main.c \
 	manager.h manager.c error.h error.c \
-	server.h server.c device.h device.c storage.h storage.c
+	server.h server.c device.h device.c \
+	storage.h storage.c bluetooth_ids.h
 
 LDADD = $(top_builddir)/common/libhelper.a \
 		@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
