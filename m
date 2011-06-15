Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC 4/7] Add transmission power callbacks
Date: Wed, 15 Jun 2011 17:03:01 -0400
Message-Id: <4df91d6e.0b73650a.190f.17a9@mx.google.com>
In-Reply-To: <1308171784-24442-1-git-send-email-y>
References: <y>
 <1308171784-24442-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

Implements the adapter TX power reading for active connections.
---
 src/adapter.c |  125 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 src/adapter.h |   16 ++++++-
 src/event.c   |    7 +++
 3 files changed, 132 insertions(+), 16 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d3d302b..a020968 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -80,6 +80,7 @@
 #define OFF_TIMER 3
 
 #define READ_RSSI_INTERVAL	2
+#define READ_TXPOWER_INTERVAL	2
 
 static DBusConnection *connection = NULL;
 static GSList *adapter_drivers = NULL;
@@ -106,9 +107,9 @@ struct service_auth {
 	struct btd_adapter *adapter;
 };
 
-struct rssi_callback {
+struct read_callback {
 	guint id;
-	btd_adapter_rssi_cb cb;
+	btd_adapter_read_cb cb;
 	bdaddr_t bdaddr;
 	gpointer user_data;
 };
@@ -163,6 +164,9 @@ struct btd_adapter {
 
 	GSList *rssi_callbacks;
 	gint rssi_id;
+
+	GSList *txpower_callbacks;
+	gint txpower_id;
 };
 
 static void adapter_set_pairable_timeout(struct btd_adapter *adapter,
@@ -2676,12 +2680,18 @@ void adapter_remove(struct btd_adapter *adapter)
 	adapter_ops->restore_powered(adapter->dev_id);
 
 	g_slist_free(adapter->rssi_callbacks);
+	g_slist_free(adapter->txpower_callbacks);
 
 	if (adapter->rssi_id) {
 		g_source_remove(adapter->rssi_id);
 		adapter->rssi_id = 0;
 	}
 
+	if (adapter->txpower_id) {
+		g_source_remove(adapter->txpower_id);
+		adapter->txpower_id = 0;
+	}
+
 	btd_adapter_unref(adapter);
 }
 
@@ -3592,23 +3602,22 @@ void btd_adapter_unregister_powered_callback(struct btd_adapter *adapter,
 			g_slist_remove(adapter->powered_callbacks, cb);
 }
 
-static gint rssi_id_cmp(gconstpointer a, gconstpointer b)
+static gint callback_id_cmp(gconstpointer a, gconstpointer b)
 {
-	const struct rssi_callback *rssicb = a;
+	const struct read_callback *cb = a;
 	guint id = GPOINTER_TO_UINT(b);
 
-	return rssicb->id - id;
+	return cb->id - id;
 }
 
 void adapter_read_rssi_complete(struct btd_adapter *adapter, bdaddr_t *dba,
 								int8_t rssi)
 {
-	struct rssi_callback *rssicb;
+	struct read_callback *rssicb;
 	GSList *list;
 
 	for (list = adapter->rssi_callbacks; list; list = list->next) {
 		rssicb = list->data;
-
 		if (bacmp(&rssicb->bdaddr, dba))
 			continue;
 
@@ -3616,10 +3625,26 @@ void adapter_read_rssi_complete(struct btd_adapter *adapter, bdaddr_t *dba,
 	}
 }
 
+void adapter_read_txpower_complete(struct btd_adapter *adapter, bdaddr_t *dba,
+								int8_t level)
+{
+	struct read_callback *txpowercb;
+	GSList *list;
+
+	for (list = adapter->txpower_callbacks; list; list = list->next) {
+		txpowercb = list->data;
+
+		if (bacmp(&txpowercb->bdaddr, dba))
+			continue;
+
+		txpowercb->cb(adapter, level, txpowercb->user_data);
+	}
+}
+
 static gboolean read_rssi(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
-	struct rssi_callback *rssicb;
+	struct read_callback *rssicb;
 	GSList *list;
 
 	for (list = adapter->rssi_callbacks; list; list = list->next) {
@@ -3631,13 +3656,13 @@ static gboolean read_rssi(gpointer user_data)
 }
 
 guint btd_adapter_register_rssi_callback(struct btd_adapter *adapter,
-					bdaddr_t *bda, btd_adapter_rssi_cb cb,
+					bdaddr_t *bda, btd_adapter_read_cb cb,
 					gpointer user_data)
 {
-	struct rssi_callback *rssicb;
+	struct read_callback *rssicb;
 	static guint rssi_counter = 0;
 
-	rssicb = g_new0(struct rssi_callback, 1);
+	rssicb = g_new0(struct read_callback, 1);
 
 	rssicb->id = ++rssi_counter;
 	rssicb->cb = cb;
@@ -3656,11 +3681,11 @@ guint btd_adapter_register_rssi_callback(struct btd_adapter *adapter,
 
 gboolean btd_adapter_unregister_rssi_callback(struct btd_adapter *adapter, guint id)
 {
-	struct rssi_callback *rssicb;
+	struct read_callback *rssicb;
 	GSList *list;
 
 	list = g_slist_find_custom(adapter->rssi_callbacks,
-					GUINT_TO_POINTER(id), rssi_id_cmp);
+					GUINT_TO_POINTER(id), callback_id_cmp);
 	if (!list)
 		return FALSE;
 
@@ -3678,6 +3703,80 @@ gboolean btd_adapter_unregister_rssi_callback(struct btd_adapter *adapter, guint
 	return TRUE;
 }
 
+static gboolean read_txpower(gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	struct read_callback *txpowercb;
+	GSList *list;
+
+	for (list = adapter->txpower_callbacks; list; list = list->next) {
+		txpowercb = list->data;
+		adapter_ops->read_tx_power(adapter->dev_id,
+						&txpowercb->bdaddr);
+	}
+
+	return TRUE;
+}
+
+guint btd_adapter_register_txpower_callback(struct btd_adapter *adapter,
+						bdaddr_t *bda,
+						btd_adapter_read_cb cb,
+						gpointer user_data)
+{
+	struct read_callback *txpowercb;
+	static guint txpower_counter = 0;
+
+	txpowercb = g_new0(struct read_callback, 1);
+
+	txpowercb->id = ++txpower_counter;
+	txpowercb->cb = cb;
+	bacpy(&txpowercb->bdaddr, bda);
+	txpowercb->user_data = user_data;
+
+	if (adapter->txpower_callbacks == NULL)
+		adapter->txpower_id = g_timeout_add_seconds(
+							READ_TXPOWER_INTERVAL,
+							read_txpower, adapter);
+
+	adapter->txpower_callbacks =
+		g_slist_append(adapter->txpower_callbacks, txpowercb);
+
+	return txpowercb->id;
+}
+
+static gint txpower_id_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct read_callback *txpowercb = a;
+	guint id = GPOINTER_TO_UINT(b);
+
+	return txpowercb->id - id;
+}
+
+gboolean btd_adapter_unregister_txpower_callback(struct btd_adapter *adapter,
+								guint id)
+{
+	struct read_callback *txpowercb;
+	GSList *list;
+
+	list = g_slist_find_custom(adapter->txpower_callbacks,
+					GUINT_TO_POINTER(id), txpower_id_cmp);
+	if (!list)
+		return FALSE;
+
+	txpowercb = list->data;
+
+	adapter->txpower_callbacks = g_slist_remove(adapter->txpower_callbacks,
+								txpowercb);
+	g_free(txpowercb);
+
+	if (adapter->txpower_callbacks == NULL) {
+		g_source_remove(adapter->txpower_id);
+		adapter->txpower_id = 0;
+	}
+
+	return TRUE;
+}
+
 int btd_adapter_set_fast_connectable(struct btd_adapter *adapter,
 							gboolean enable)
 {
diff --git a/src/adapter.h b/src/adapter.h
index af6b908..c3fdd01 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -134,6 +134,8 @@ void adapter_resume_discovery(struct btd_adapter *adapter);
 
 void adapter_read_rssi_complete(struct btd_adapter *adapter, bdaddr_t *dba,
 								int8_t rssi);
+void adapter_read_txpower_complete(struct btd_adapter *adapter, bdaddr_t *dba,
+								int8_t level);
 
 struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter);
 void btd_adapter_unref(struct btd_adapter *adapter);
@@ -224,8 +226,8 @@ int adapter_ops_setup(void);
 typedef void (*btd_adapter_powered_cb) (struct btd_adapter *adapter,
 						gboolean powered);
 
-typedef void (*btd_adapter_rssi_cb) (struct btd_adapter *adapter,
-					int8_t rssi, gpointer user_data);
+typedef void (*btd_adapter_read_cb) (struct btd_adapter *adapter,
+					int8_t level, gpointer user_data);
 
 void btd_adapter_register_powered_callback(struct btd_adapter *adapter,
 						btd_adapter_powered_cb cb);
@@ -233,11 +235,19 @@ void btd_adapter_unregister_powered_callback(struct btd_adapter *adapter,
 						btd_adapter_powered_cb cb);
 
 guint btd_adapter_register_rssi_callback(struct btd_adapter *adapter,
-					bdaddr_t *dba, btd_adapter_rssi_cb cb,
+					bdaddr_t *dba, btd_adapter_read_cb cb,
 					gpointer user_data);
 
 gboolean btd_adapter_unregister_rssi_callback(struct btd_adapter *adapter,
 								guint id);
+
+guint btd_adapter_register_txpower_callback(struct btd_adapter *adapter,
+						bdaddr_t *dba,
+						btd_adapter_read_cb cb,
+						gpointer user_data);
+gboolean btd_adapter_unregister_txpower_callback(struct btd_adapter *adapter,
+								guint id);
+
 /* If TRUE, enables fast connectabe, i.e. reduces page scan interval and changes
  * type. If FALSE, disables fast connectable, i.e. sets page scan interval and
  * type to default values. Valid for both connectable and discoverable modes. */
diff --git a/src/event.c b/src/event.c
index 5551cb6..1d9b29c 100644
--- a/src/event.c
+++ b/src/event.c
@@ -478,10 +478,17 @@ void btd_event_returned_link_key(bdaddr_t *local, bdaddr_t *peer)
 
 void btd_event_txpower_read(bdaddr_t *local, bdaddr_t *peer, int8_t level)
 {
+	struct btd_adapter *adapter;
 	char peer_addr[18];
 
 	ba2str(peer, peer_addr);
 	DBG("%s TX Power: %d", peer_addr, level);
+
+	adapter = manager_find_adapter(local);
+	if (!adapter)
+		return;
+
+	adapter_read_txpower_complete(adapter, peer, level);
 }
 
 void btd_event_rssi_read(bdaddr_t *local, bdaddr_t *peer, int8_t rssi)
-- 
1.7.4.1

