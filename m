Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 1/4] device: Fix invalid memory access during Find Included
Date: Mon, 28 Jan 2013 20:48:08 -0300
Message-Id: <1359416891-12740-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When doing the Find Included Services GATT procedure, the status of the ATT
procedure was being ignored, and in the case of a timeout it is possible to
crash bluetooth with an invalid memory access.

Valgrind log:

==1755== Invalid read of size 8
==1755==    at 0x46971A: find_included_cb (device.c:2964)
==1755==    by 0x4465AE: isd_unref (gatt.c:92)
==1755==    by 0x446885: find_included_cb (gatt.c:425)
==1755==    by 0x448266: disconnect_timeout (gattrib.c:269)
==1755==    by 0x4E76BCA: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x4E76044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x4E76377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x4E76771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x40A2EE: main (main.c:583)
==1755==  Address 0x69530a8 is 8 bytes inside a block of size 64 free'd
==1755==    at 0x4C2874F: free (vg_replace_malloc.c:446)
==1755==    by 0x40BFA6: service_filter (watch.c:486)
==1755==    by 0x40BC6A: message_filter (watch.c:554)
==1755==    by 0x5160A1D: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.7.2)
==1755==    by 0x40AAB7: message_dispatch (mainloop.c:76)
==1755==    by 0x4E76BCA: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x4E76044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x4E76377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x4E76771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x40A2EE: main (main.c:583)
==1755==
==1755== Invalid read of size 8
==1755==    at 0x4486D5: g_attrib_get_buffer (gattrib.c:657)
==1755==    by 0x4467C5: find_included (gatt.c:363)
==1755==    by 0x4465AE: isd_unref (gatt.c:92)
==1755==    by 0x446885: find_included_cb (gatt.c:425)
==1755==    by 0x448266: disconnect_timeout (gattrib.c:269)
==1755==    by 0x4E76BCA: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x4E76044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x4E76377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x4E76771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x40A2EE: main (main.c:583)
==1755==  Address 0x18 is not stack'd, malloc'd or (recently) free'd
==1755==
==1755==
==1755== Process terminating with default action of signal 11 (SIGSEGV)
==1755==  Access not within mapped region at address 0x18
==1755==    at 0x4486D5: g_attrib_get_buffer (gattrib.c:657)
==1755==    by 0x4467C5: find_included (gatt.c:363)
==1755==    by 0x4465AE: isd_unref (gatt.c:92)
==1755==    by 0x446885: find_included_cb (gatt.c:425)
==1755==    by 0x448266: disconnect_timeout (gattrib.c:269)
==1755==    by 0x4E76BCA: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x4E76044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x4E76377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x4E76771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
==1755==    by 0x40A2EE: main (main.c:583)
---
 attrib/gatt.c | 5 ++++-
 src/device.c  | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index d54feac..44d3eb6 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -89,7 +89,10 @@ static void isd_unref(struct included_discovery *isd)
 	if (g_atomic_int_dec_and_test(&isd->refs) == FALSE)
 		return;
 
-	isd->cb(isd->includes, isd->err, isd->user_data);
+	if (isd->err)
+		isd->cb(NULL, isd->err, isd->user_data);
+	else
+		isd->cb(isd->includes, isd->err, isd->user_data);
 
 	g_slist_free_full(isd->includes, g_free);
 	g_attrib_unref(isd->attrib);
diff --git a/src/device.c b/src/device.c
index 34902b3..ceaa575 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2988,6 +2988,12 @@ static void find_included_cb(GSList *includes, uint8_t status,
 	struct gatt_primary *prim;
 	GSList *l;
 
+	if (status != 0) {
+		error("Find included services failed: %s (%d)",
+					att_ecode2str(status), status);
+		goto done;
+	}
+
 	if (includes == NULL)
 		goto done;
 
-- 
1.8.1.1

