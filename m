Return-Path: <cyrus@holtmann.org>
Message-ID: <1384016577.3880.36.camel@nuvo>
Subject: [PATCH 1/3] gdbus: Don't try to remove removed sources
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 09 Nov 2013 18:02:57 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


When we return FALSE from idle handlers, the source is removed.
This will be causing warnings in glib 2.40.

See https://bugzilla.gnome.org/show_bug.cgi?id=710724
---
 gdbus/object.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 268fed5..b248cbb 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1006,6 +1006,8 @@ static gboolean process_changes(gpointer user_data)
 	if (data->removed != NULL)
 		emit_interfaces_removed(data);
 
+	data->process_id = 0;
+
 	return FALSE;
 }
 
@@ -1019,6 +1021,7 @@ static void generic_unregister(DBusConnection *connection, void *user_data)
 
 	if (data->process_id > 0) {
 		g_source_remove(data->process_id);
+		data->process_id = 0;
 		process_changes(data);
 	}
 
-- 
1.8.4.2


