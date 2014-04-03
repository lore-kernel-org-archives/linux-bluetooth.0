Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 1/3] gatt: Add removing service from the database
Date: Thu,  3 Apr 2014 16:46:50 -0300
Message-Id: <1396554412-2057-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396554412-2057-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
 <1396554412-2057-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the service declaration and its attributes when
the external service implementation leaves the system bus, calls
UnregisterService(), or RegisterService() fails.
---
 src/gatt-dbus.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 3ded9cd..d3fd717 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -56,6 +56,7 @@ struct external_service {
 	DBusMessage *reg;
 	GDBusClient *client;
 	GSList *proxies;
+	struct btd_attribute *service;
 };
 
 struct proxy_write_data {
@@ -99,10 +100,11 @@ static void remove_service(DBusConnection *conn, void *user_data)
 {
 	struct external_service *esvc = user_data;
 
-	/* TODO: Remove from the database */
-
 	external_services = g_slist_remove(external_services, esvc);
 
+	if (esvc->service)
+		btd_gatt_remove_service(esvc->service);
+
 	/*
 	 * Do not run in the same loop, this may be a disconnect
 	 * watch call and GDBusClient should not be destroyed.
@@ -336,7 +338,7 @@ static void proxy_write_cb(struct btd_attribute *attr,
 
 }
 
-static int register_external_service(const struct external_service *esvc,
+static int register_external_service(struct external_service *esvc,
 							GDBusProxy *proxy)
 {
 	DBusMessageIter iter;
@@ -360,7 +362,8 @@ static int register_external_service(const struct external_service *esvc,
 	if (bt_string_to_uuid(&uuid, str) < 0)
 		return -EINVAL;
 
-	if (!btd_gatt_add_service(&uuid))
+	esvc->service = btd_gatt_add_service(&uuid);
+	if (!esvc->service)
 		return -EINVAL;
 
 	return 0;
@@ -481,18 +484,25 @@ static void client_ready(GDBusClient *client, void *user_data)
 	DBG("Added GATT service %s", esvc->path);
 
 	reply = dbus_message_new_method_return(esvc->reg);
-	goto reply;
+	g_dbus_send_message(conn, reply);
+
+	dbus_message_unref(esvc->reg);
+	esvc->reg = NULL;
+
+	return;
 
 fail:
 	error("Could not register external service: %s", esvc->path);
 
-	reply = btd_error_invalid_args(esvc->reg);
-	/* TODO: missing esvc/database cleanup */
+	/*
+	 * Set callback to NULL to avoid potential race condition
+	 * when calling remove_service and GDBusClient unref.
+	 */
+	g_dbus_client_set_disconnect_watch(esvc->client, NULL, NULL);
 
-reply:
-	dbus_message_unref(esvc->reg);
-	esvc->reg = NULL;
+	remove_service(conn, esvc);
 
+	reply = btd_error_invalid_args(esvc->reg);
 	g_dbus_send_message(conn, reply);
 }
 
@@ -578,6 +588,12 @@ static DBusMessage *unregister_service(DBusConnection *conn,
 	if (!strcmp(dbus_message_get_sender(msg), esvc->owner))
 		return btd_error_does_not_exist(msg);
 
+	/*
+	 * Set callback to NULL to avoid potential race condition
+	 * when calling remove_service and GDBusClient unref.
+	 */
+	g_dbus_client_set_disconnect_watch(esvc->client, NULL, NULL);
+
 	remove_service(conn, esvc);
 
 	return dbus_message_new_method_return(msg);
-- 
1.8.3.1

