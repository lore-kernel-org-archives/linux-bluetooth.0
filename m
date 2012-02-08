Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] device: Fix invalid read in att_connect_cb
Date: Wed,  8 Feb 2012 14:55:07 -0300
Message-Id: <1328723708-21731-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1328723708-21731-1-git-send-email-andre.guedes@openbossa.org>
References: <1328723708-21731-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should keep a reference to GIOChannel created in att_connect
so we can properly shut it down if the device is removed during a
connection attempt. After establishing the connection, we drop the
GIOChannel reference because GAttrib will take the responsability
of disconnect the link based on the registered ATTIO connection
callbacks.

This patch fixes the following invalid read reported by valgrind
when the device is removed and we have a ongoing connection attempt:

Invalid read of size 4
   at 0x1A90D8: att_connect_cb (device.c:1712)
   by 0x17EDB9: connect_cb (btio.c:169)
   by 0x4E6E29C: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.2800.8)
   by 0x4E6EA77: ??? (in /usr/lib/libglib-2.0.so.0.2800.8)
   by 0x4E6F0B9: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.2800.8)
   by 0x18ACB3: main (main.c:485)
 Address 0x68aacb8 is 456 bytes inside a block of size 472 free'd
   at 0x4C2556E: free (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x1A596B: device_free (device.c:248)
   by 0x121EB5: remove_interface (object.c:563)
   by 0x122288: g_dbus_unregister_interface (object.c:715)
   by 0x1AAFD8: btd_device_unref (device.c:2636)
   by 0x1A7912: device_remove (device.c:1058)
   by 0x19F371: adapter_remove_device (adapter.c:1122)
   by 0x1A0AD4: remove_device (adapter.c:1720)
   by 0x1214C4: process_message (object.c:224)
   by 0x121B60: generic_message (object.c:447)
   by 0x51348C0: ??? (in /usr/lib/libdbus-1.so.3.5.7)
   by 0x512679F: dbus_connection_dispatch (in /usr/lib/libdbus-1.so.3.5.7)
---
 src/device.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 311dca1..36d07ca 100644
--- a/src/device.c
+++ b/src/device.c
@@ -160,6 +160,8 @@ struct btd_device {
 
 	gboolean	authorizing;
 	gint		ref;
+
+	GIOChannel      *att_io;
 };
 
 static uint16_t uuid_list[] = {
@@ -247,6 +249,11 @@ static void device_free(gpointer user_data)
 	if (device->auto_id)
 		g_source_remove(device->auto_id);
 
+	if (device->att_io) {
+		g_io_channel_shutdown(device->att_io, FALSE, NULL);
+		g_io_channel_unref(device->att_io);
+	}
+
 	DBG("%p", device);
 
 	g_free(device->authr);
@@ -1820,6 +1827,9 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	struct btd_device *device = user_data;
 	GAttrib *attrib;
 
+	g_io_channel_unref(device->att_io);
+	device->att_io = NULL;
+
 	if (gerr) {
 		DBG("%s", gerr->message);
 
@@ -1885,7 +1895,7 @@ static gboolean att_connect(gpointer user_data)
 		return FALSE;
 	}
 
-	g_io_channel_unref(io);
+	device->att_io = io;
 
 	return FALSE;
 }
-- 
1.7.9

