Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/8] gdbus: Fix emitting PropertiesChanged twice
Date: Mon, 19 Aug 2013 17:32:55 +0300
Message-Id: <1376922779-11802-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1376922779-11802-1-git-send-email-luiz.dentz@gmail.com>
References: <1376922779-11802-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes double emission of PropertiesChanged introduced by flushing
changes, the flushing can happen during the pending processing so the
pending_prop flag needs to be updated in the beginning and the list of
properties can be freed before g_dbus_send_message as it is not required
anymore.
---
 gdbus/object.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 92f57a0..ae73061 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1636,6 +1636,8 @@ static void process_properties_from_interface(struct generic_data *data,
 	DBusMessageIter iter, dict, array;
 	GSList *invalidated;
 
+	data->pending_prop = FALSE;
+
 	if (iface->pending_prop == NULL)
 		return;
 
@@ -1685,10 +1687,10 @@ static void process_properties_from_interface(struct generic_data *data,
 	g_slist_free(invalidated);
 	dbus_message_iter_close_container(&iter, &array);
 
-	g_dbus_send_message(data->conn, signal);
-
 	g_slist_free(iface->pending_prop);
 	iface->pending_prop = NULL;
+
+	g_dbus_send_message(data->conn, signal);
 }
 
 static void process_property_changes(struct generic_data *data)
@@ -1700,8 +1702,6 @@ static void process_property_changes(struct generic_data *data)
 
 		process_properties_from_interface(data, iface);
 	}
-
-	data->pending_prop = FALSE;
 }
 
 void g_dbus_emit_property_changed(DBusConnection *connection,
-- 
1.8.3.1

