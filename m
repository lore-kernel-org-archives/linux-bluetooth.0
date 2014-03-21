Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 4/4] tools: Fix coding style checking boolean
Date: Fri, 21 Mar 2014 16:20:33 -0300
Message-Id: <1395429633-656-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395429633-656-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395429633-656-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes tools/gatt-service.c coding style, using !foo instead
of foo == FALSE.
---
 tools/gatt-service.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 71f7a50..6933c05 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -205,9 +205,9 @@ static char *register_service(const char *uuid)
 	char *path;
 
 	path = g_strdup_printf("/service%d", id++);
-	if (g_dbus_register_interface(connection, path, GATT_SERVICE_IFACE,
+	if (!g_dbus_register_interface(connection, path, GATT_SERVICE_IFACE,
 				NULL, NULL, service_properties,
-				g_strdup(uuid), g_free) == FALSE) {
+				g_strdup(uuid), g_free)) {
 		printf("Couldn't register service interface\n");
 		g_free(path);
 		return NULL;
@@ -287,7 +287,7 @@ static void register_external_service(gpointer a, gpointer b)
 
 	dbus_message_iter_close_container(&iter, &dict);
 
-	if (g_dbus_send_message_with_reply(conn, msg, &call, -1) == FALSE) {
+	if (!g_dbus_send_message_with_reply(conn, msg, &call, -1)) {
 		dbus_message_unref(msg);
 		return;
 	}
-- 
1.8.3.1

