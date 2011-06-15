Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC 3/7] Add RSSI read callbacks
Date: Wed, 15 Jun 2011 17:03:00 -0400
Message-Id: <4df91d6d.0b73650a.190f.17a8@mx.google.com>
In-Reply-To: <1308171784-24442-1-git-send-email-y>
References: <y>
 <1308171784-24442-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

Implements the adapter callback registration to allow asynchronous
tracking of the RSSI of an active connection.
---
 src/adapter.c |  105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h |   13 +++++++
 src/event.c   |    9 +++--
 3 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b189841..d3d302b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -79,6 +79,8 @@
 
 #define OFF_TIMER 3
 
+#define READ_RSSI_INTERVAL	2
+
 static DBusConnection *connection = NULL;
 static GSList *adapter_drivers = NULL;
 
@@ -104,6 +106,13 @@ struct service_auth {
 	struct btd_adapter *adapter;
 };
 
+struct rssi_callback {
+	guint id;
+	btd_adapter_rssi_cb cb;
+	bdaddr_t bdaddr;
+	gpointer user_data;
+};
+
 struct btd_adapter {
 	uint16_t dev_id;
 	int up;
@@ -151,6 +160,9 @@ struct btd_adapter {
 	gboolean name_stored;
 
 	GSList *loaded_drivers;
+
+	GSList *rssi_callbacks;
+	gint rssi_id;
 };
 
 static void adapter_set_pairable_timeout(struct btd_adapter *adapter,
@@ -2663,6 +2675,13 @@ void adapter_remove(struct btd_adapter *adapter)
 	/* Return adapter to down state if it was not up on init */
 	adapter_ops->restore_powered(adapter->dev_id);
 
+	g_slist_free(adapter->rssi_callbacks);
+
+	if (adapter->rssi_id) {
+		g_source_remove(adapter->rssi_id);
+		adapter->rssi_id = 0;
+	}
+
 	btd_adapter_unref(adapter);
 }
 
@@ -3573,6 +3592,92 @@ void btd_adapter_unregister_powered_callback(struct btd_adapter *adapter,
 			g_slist_remove(adapter->powered_callbacks, cb);
 }
 
+static gint rssi_id_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct rssi_callback *rssicb = a;
+	guint id = GPOINTER_TO_UINT(b);
+
+	return rssicb->id - id;
+}
+
+void adapter_read_rssi_complete(struct btd_adapter *adapter, bdaddr_t *dba,
+								int8_t rssi)
+{
+	struct rssi_callback *rssicb;
+	GSList *list;
+
+	for (list = adapter->rssi_callbacks; list; list = list->next) {
+		rssicb = list->data;
+
+		if (bacmp(&rssicb->bdaddr, dba))
+			continue;
+
+		rssicb->cb(adapter, rssi, rssicb->user_data);
+	}
+}
+
+static gboolean read_rssi(gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	struct rssi_callback *rssicb;
+	GSList *list;
+
+	for (list = adapter->rssi_callbacks; list; list = list->next) {
+		rssicb = list->data;
+		adapter_ops->read_rssi(adapter->dev_id, &rssicb->bdaddr);
+	}
+
+	return TRUE;
+}
+
+guint btd_adapter_register_rssi_callback(struct btd_adapter *adapter,
+					bdaddr_t *bda, btd_adapter_rssi_cb cb,
+					gpointer user_data)
+{
+	struct rssi_callback *rssicb;
+	static guint rssi_counter = 0;
+
+	rssicb = g_new0(struct rssi_callback, 1);
+
+	rssicb->id = ++rssi_counter;
+	rssicb->cb = cb;
+	bacpy(&rssicb->bdaddr, bda);
+	rssicb->user_data = user_data;
+
+	if (adapter->rssi_callbacks == NULL)
+		adapter->rssi_id = g_timeout_add_seconds(READ_RSSI_INTERVAL,
+							read_rssi, adapter);
+
+	adapter->rssi_callbacks =
+		g_slist_append(adapter->rssi_callbacks, rssicb);
+
+	return rssicb->id;
+}
+
+gboolean btd_adapter_unregister_rssi_callback(struct btd_adapter *adapter, guint id)
+{
+	struct rssi_callback *rssicb;
+	GSList *list;
+
+	list = g_slist_find_custom(adapter->rssi_callbacks,
+					GUINT_TO_POINTER(id), rssi_id_cmp);
+	if (!list)
+		return FALSE;
+
+	rssicb = list->data;
+
+	adapter->rssi_callbacks = g_slist_remove(adapter->rssi_callbacks,
+								rssicb);
+	g_free(rssicb);
+
+	if (adapter->rssi_callbacks == NULL) {
+		g_source_remove(adapter->rssi_id);
+		adapter->rssi_id = 0;
+	}
+
+	return TRUE;
+}
+
 int btd_adapter_set_fast_connectable(struct btd_adapter *adapter,
 							gboolean enable)
 {
diff --git a/src/adapter.h b/src/adapter.h
index 342530c..af6b908 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -132,6 +132,9 @@ gboolean adapter_has_discov_sessions(struct btd_adapter *adapter);
 void adapter_suspend_discovery(struct btd_adapter *adapter);
 void adapter_resume_discovery(struct btd_adapter *adapter);
 
+void adapter_read_rssi_complete(struct btd_adapter *adapter, bdaddr_t *dba,
+								int8_t rssi);
+
 struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter);
 void btd_adapter_unref(struct btd_adapter *adapter);
 
@@ -220,11 +223,21 @@ int adapter_ops_setup(void);
 
 typedef void (*btd_adapter_powered_cb) (struct btd_adapter *adapter,
 						gboolean powered);
+
+typedef void (*btd_adapter_rssi_cb) (struct btd_adapter *adapter,
+					int8_t rssi, gpointer user_data);
+
 void btd_adapter_register_powered_callback(struct btd_adapter *adapter,
 						btd_adapter_powered_cb cb);
 void btd_adapter_unregister_powered_callback(struct btd_adapter *adapter,
 						btd_adapter_powered_cb cb);
 
+guint btd_adapter_register_rssi_callback(struct btd_adapter *adapter,
+					bdaddr_t *dba, btd_adapter_rssi_cb cb,
+					gpointer user_data);
+
+gboolean btd_adapter_unregister_rssi_callback(struct btd_adapter *adapter,
+								guint id);
 /* If TRUE, enables fast connectabe, i.e. reduces page scan interval and changes
  * type. If FALSE, disables fast connectable, i.e. sets page scan interval and
  * type to default values. Valid for both connectable and discoverable modes. */
diff --git a/src/event.c b/src/event.c
index 4c613a3..5551cb6 100644
--- a/src/event.c
+++ b/src/event.c
@@ -486,8 +486,11 @@ void btd_event_txpower_read(bdaddr_t *local, bdaddr_t *peer, int8_t level)
 
 void btd_event_rssi_read(bdaddr_t *local, bdaddr_t *peer, int8_t rssi)
 {
-	char peer_addr[18];
+	struct btd_adapter *adapter;
 
-	ba2str(peer, peer_addr);
-	DBG("%s RSSI: %d", peer_addr, rssi);
+	adapter = manager_find_adapter(local);
+	if (!adapter)
+		return;
+
+	adapter_read_rssi_complete(adapter, peer, rssi);
 }
-- 
1.7.4.1

