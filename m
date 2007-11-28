Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 28 Nov 2007 14:14:27 -0500
From: Aristeu Rozanski <aris@ruivo.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20071128191427.GJ24494@cathedrallabs.org>
MIME-Version: 1.0
Subject: [Bluez-devel] [PATCH] utils/input: introduce bluetooth_ids header
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

This patch adds a header to keep vendor/product ids for special input
devices.

---
 input/Makefile.am     |    3 ++-
 input/bluetooth_ids.h |    8 ++++++++
 input/device.c        |    4 +++-
 3 files changed, 13 insertions(+), 2 deletions(-)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/input/bluetooth_ids.h	2007-11-28 11:56:37.000000000 -0500
@@ -0,0 +1,8 @@
+#ifndef BLUETOOTH_IDS_H
+#define BLUETOOTH_IDS_H
+
+#define BLUETOOTH_VENDOR_ID_SONY 0x054c
+#define BLUETOOTH_DEVICE_ID_PS3CONTROLLER 0x0268
+
+#endif	/* BLUETOOTH_IDS_H */
+
--- a/input/device.c	2007-11-28 11:56:36.000000000 -0500
+++ b/input/device.c	2007-11-28 11:56:37.000000000 -0500
@@ -52,6 +52,7 @@
 #include "error.h"
 #include "manager.h"
 #include "storage.h"
+#include "bluetooth_ids.h"
 
 #define INPUT_DEVICE_INTERFACE	"org.bluez.input.Device"
 
@@ -615,7 +616,8 @@ static int hidp_connadd(bdaddr_t *src, b
 
 	info("New input device %s (%s)", addr, req.name);
 
-	if (req.vendor == 0x054c && req.product == 0x0268) {
+	if (req.vendor == BLUETOOTH_VENDOR_ID_SONY &&
+	    req.product == BLUETOOTH_DEVICE_ID_PS3CONTROLLER) {
 		unsigned char buf[] = { 0x53, 0xf4,  0x42, 0x03, 0x00, 0x00 };
 		err = write(ctrl_sk, buf, sizeof(buf));
 	}
--- a/input/Makefile.am	2007-11-28 11:56:36.000000000 -0500
+++ b/input/Makefile.am	2007-11-28 11:56:37.000000000 -0500
@@ -12,7 +12,8 @@ service_PROGRAMS = bluetoothd-service-in
 
 bluetoothd_service_input_SOURCES = main.c \
 	manager.h manager.c \
-	server.h server.c device.h device.c storage.h storage.c
+	server.h server.c device.h device.c storage.h storage.c \
+	bluetooth_ids.h
 
 LDADD = $(top_builddir)/common/libhelper.a \
 		@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
