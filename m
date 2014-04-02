Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 5/7] gatt: Add removing service from the database
Date: Wed,  2 Apr 2014 15:30:24 -0300
Message-Id: <1396463426-7268-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the service declaration and its attributes when
the external service implementation leaves the system bus, calls
UnregisterService(), or RegisterService() fails.
---
 src/gatt-dbus.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 3ded9cd..17c3359 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -56,6 +56,7 @@ struct external_service {
 	DBusMessage *reg;
 	GDBusClient *client;
 	GSList *proxies;
+	struct btd_attribute *service;
 };
 
 struct proxy_write_data {
@@ -99,7 +100,8 @@ static void remove_service(DBusConnection *conn, void *user_data)
 {
 	struct external_service *esvc = user_data;
 
-	/* TODO: Remove from the database */
+	if (esvc->service)
+		btd_gatt_remove_service(esvc->service);
 
 	external_services = g_slist_remove(external_services, esvc);
 
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
@@ -487,7 +490,8 @@ fail:
 	error("Could not register external service: %s", esvc->path);
 
 	reply = btd_error_invalid_args(esvc->reg);
-	/* TODO: missing esvc/database cleanup */
+	if (esvc->service)
+		btd_gatt_remove_service(esvc->service);
 
 reply:
 	dbus_message_unref(esvc->reg);
-- 
1.8.3.1

