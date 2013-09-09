Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] gdbus/watch: Fix crash when g_dbus_remove_watch is called from connect callback
Date: Mon,  9 Sep 2013 17:49:34 +0300
Message-Id: <1378738179-21047-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1378738179-21047-1-git-send-email-luiz.dentz@gmail.com>
References: <1378738179-21047-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

 at 0x40570C: update_service (watch.c:601)
 by 0x40584B: service_reply (watch.c:627)
 by 0x3B0700C511: ??? (in /usr/lib64/libdbus-1.so.3.7.4)
 by 0x3B0700F740: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.7.4)
 by 0x405167: message_dispatch (mainloop.c:76)
 by 0x3B03C48962: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
 by 0x3B03C47E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
 by 0x3B03C48157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
 by 0x3B03C48559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
Address 0x4c58a30 is 32 bytes inside a block of size 56 free'd
 at 0x4A074C4: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
 by 0x3B03C4D9AE: g_free (in /usr/lib64/libglib-2.0.so.0.3600.3)
 by 0x406102: filter_data_remove_callback (watch.c:378)
 by 0x405FC0: g_dbus_remove_watch (watch.c:798)
 by 0x40A22B: g_dbus_client_unref (client.c:1227)
 by 0x40570B: update_service (watch.c:599)
 by 0x40584B: service_reply (watch.c:627)
---
 gdbus/watch.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 9e4f994..d334580 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -593,12 +593,16 @@ static gboolean update_service(void *user_data)
 {
 	struct service_data *data = user_data;
 	struct filter_callback *cb = data->callback;
+	DBusConnection *conn;
 
 	update_name_cache(data->name, data->owner);
+	conn = dbus_connection_ref(data->conn);
+	service_data_free(cb->data);
+
 	if (cb->conn_func)
-		cb->conn_func(data->conn, cb->user_data);
+		cb->conn_func(conn, cb->user_data);
 
-	service_data_free(data);
+	dbus_connection_unref(conn);
 
 	return FALSE;
 }
-- 
1.8.3.1

