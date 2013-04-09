Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] obexd: Automatically setup notification connection for MAP client
Date: Tue,  9 Apr 2013 13:51:37 +0200
Message-Id: <1365508297-13032-6-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365508297-13032-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508297-13032-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This automatically establishes the MNS connection when the MAS client
session is started and terminates the MNS connection when the MAS client
session is closed.

The MAP client controls the notification channel using the
SetNotificationRegistration function. The MSE will connect/disconnect
the MNS connection accordingly.
---
 obexd/client/map.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 2b665ec..25aedb7 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1690,10 +1690,42 @@ static void map_msg_remove(void *data)
 	g_free(path);
 }
 
+static gboolean set_notification_registration(struct map_data *map,
+								gboolean status)
+{
+	struct obc_transfer *transfer;
+	GError *err = NULL;
+	GObexApparam *apparam;
+	char contents[2];
+
+	contents[0] = FILLER_BYTE;
+	contents[1] = '\0';
+
+	transfer = obc_transfer_put("x-bt/MAP-NotificationRegistration", NULL,
+					NULL, contents, sizeof(contents), &err);
+
+	if (transfer == NULL) {
+		return FALSE;
+	}
+
+	apparam = g_obex_apparam_set_uint8(NULL, MAP_AP_NOTIFICATIONSTATUS,
+									status);
+
+	obc_transfer_set_apparam(transfer, apparam);
+
+	if (obc_session_queue(map->session, transfer, NULL, map, &err)) {
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
 static void map_free(void *data)
 {
 	struct map_data *map = data;
 
+	set_notification_registration(map, FALSE);
+
 	obc_session_unref(map->session);
 	g_hash_table_unref(map->messages);
 	g_free(map);
@@ -1716,6 +1748,8 @@ static int map_probe(struct obc_session *session)
 	map->messages = g_hash_table_new_full(g_str_hash, g_str_equal, NULL,
 								map_msg_remove);
 
+	set_notification_registration(map, TRUE);
+
 	if (!g_dbus_register_interface(conn, path, MAP_INTERFACE, map_methods,
 					NULL, NULL, map, map_free)) {
 		map_free(map);
-- 
1.8.2.1

