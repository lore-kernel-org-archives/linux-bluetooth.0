Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC v1 3/9] adapter: rename discovery_client to watch_client
Date: Tue, 11 Jun 2013 01:03:25 +0100
Message-Id: <1370909011-19315-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1370909011-19315-1-git-send-email-gustavo@padovan.org>
References: <1370909011-19315-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Rename to a more generic name since we will have different uses for this.
---
 src/adapter.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5f01edf..0277057 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -105,7 +105,7 @@ static uint8_t mgmt_revision = 0;
 
 static GSList *adapter_drivers = NULL;
 
-struct discovery_client {
+struct watch_client {
 	struct btd_adapter *adapter;
 	char *owner;
 	guint watch;
@@ -1480,7 +1480,7 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
 
 static int compare_discovery_sender(gconstpointer a, gconstpointer b)
 {
-	const struct discovery_client *client = a;
+	const struct watch_client *client = a;
 	const char *sender = b;
 
 	return g_strcmp0(client->owner, sender);
@@ -1522,7 +1522,7 @@ static gboolean remove_temp_devices(gpointer user_data)
 
 static void discovery_destroy(void *user_data)
 {
-	struct discovery_client *client = user_data;
+	struct watch_client *client = user_data;
 	struct btd_adapter *adapter = client->adapter;
 
 	DBG("owner %s", client->owner);
@@ -1560,7 +1560,7 @@ static void discovery_destroy(void *user_data)
 
 static void discovery_disconnect(DBusConnection *conn, void *user_data)
 {
-	struct discovery_client *client = user_data;
+	struct watch_client *client = user_data;
 	struct btd_adapter *adapter = client->adapter;
 	struct mgmt_cp_stop_discovery cp;
 
@@ -1604,7 +1604,7 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 {
 	struct btd_adapter *adapter = user_data;
 	const char *sender = dbus_message_get_sender(msg);
-	struct discovery_client *client;
+	struct watch_client *client;
 	GSList *list;
 
 	DBG("sender %s", sender);
@@ -1621,7 +1621,7 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 	if (list)
 		return btd_error_busy(msg);
 
-	client = g_new0(struct discovery_client, 1);
+	client = g_new0(struct watch_client, 1);
 
 	client->adapter = adapter;
 	client->owner = g_strdup(sender);
@@ -1648,7 +1648,7 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
 	struct btd_adapter *adapter = user_data;
 	const char *sender = dbus_message_get_sender(msg);
 	struct mgmt_cp_stop_discovery cp;
-	struct discovery_client *client;
+	struct watch_client *client;
 	GSList *list;
 
 	DBG("sender %s", sender);
@@ -4264,7 +4264,7 @@ static void adapter_stop(struct btd_adapter *adapter)
 	cancel_passive_scanning(adapter);
 
 	while (adapter->discovery_list) {
-		struct discovery_client *client;
+		struct watch_client *client;
 
 		client = adapter->discovery_list->data;
 
-- 
1.8.1.4

