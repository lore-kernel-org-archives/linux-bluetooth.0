Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 1/2] Add pin-code hook to adapter api
Date: Fri,  8 Jul 2011 18:34:54 +0200
Message-Id: <1310142895-20224-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Plugins may now register pincode callbacks which are called when the
authentication of a new device requires a pincode. This allows to have
hard-coded binary pins inside the daemon to circumvent the public dbus
api restrictions (only valid UTF8 strings).

The callbacks shall check via VID/PID information whether they support
the device and if not, return 0 so the dbus api is used to query the
current agent for pin input.
---
 src/adapter.c |   19 +++++++++++++++++++
 src/adapter.h |    8 ++++++++
 src/event.c   |   22 +++++++++++++++++++++-
 3 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0909a22..689b73b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -146,6 +146,7 @@ struct btd_adapter {
 	guint off_timer;
 
 	GSList *powered_callbacks;
+	GSList *pin_callbacks;
 
 	GSList *loaded_drivers;
 };
@@ -2573,6 +2574,7 @@ void adapter_remove(struct btd_adapter *adapter)
 	g_slist_free(adapter->devices);
 
 	unload_drivers(adapter);
+	g_slist_free(adapter->pin_callbacks);
 
 	/* Return adapter to down state if it was not up on init */
 	adapter_ops->restore_powered(adapter->dev_id);
@@ -3435,6 +3437,23 @@ int btd_adapter_switch_offline(struct btd_adapter *adapter)
 	return 0;
 }
 
+void btd_adapter_register_pincb(struct btd_adapter *adapter,
+							btd_adapter_pincb_t cb)
+{
+	adapter->pin_callbacks = g_slist_prepend(adapter->pin_callbacks, cb);
+}
+
+void btd_adapter_unregister_pincb(struct btd_adapter *adapter,
+							btd_adapter_pincb_t cb)
+{
+	adapter->pin_callbacks = g_slist_remove(adapter->pin_callbacks, cb);
+}
+
+GSList *btd_adapter_get_pincbs(struct btd_adapter *adapter)
+{
+	return adapter->pin_callbacks;
+}
+
 int btd_register_adapter_ops(struct btd_adapter_ops *ops, gboolean priority)
 {
 	if (ops->setup == NULL)
diff --git a/src/adapter.h b/src/adapter.h
index 38ea3ca..84b0bb0 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -165,6 +165,14 @@ int btd_adapter_restore_powered(struct btd_adapter *adapter);
 int btd_adapter_switch_online(struct btd_adapter *adapter);
 int btd_adapter_switch_offline(struct btd_adapter *adapter);
 
+typedef int (*btd_adapter_pincb_t) (struct btd_adapter *adapter,
+					struct btd_device *dev, char *out);
+void btd_adapter_register_pincb(struct btd_adapter *adapter,
+							btd_adapter_pincb_t cb);
+void btd_adapter_unregister_pincb(struct btd_adapter *adapter,
+							btd_adapter_pincb_t cb);
+GSList *btd_adapter_get_pincbs(struct btd_adapter *adapter);
+
 typedef void (*bt_hci_result_t) (uint8_t status, gpointer user_data);
 
 struct btd_adapter_ops {
diff --git a/src/event.c b/src/event.c
index 86a413e..ecbdaa0 100644
--- a/src/event.c
+++ b/src/event.c
@@ -123,6 +123,26 @@ fail:
 	error("Sending PIN code reply failed: %s (%d)", strerror(-err), -err);
 }
 
+static int get_pin(struct btd_adapter *adapter, struct btd_device *device,
+				bdaddr_t *sba, bdaddr_t *dba, char *pinbuf)
+{
+	GSList *ele;
+	btd_adapter_pincb_t cb;
+	int ret;
+
+	ele = btd_adapter_get_pincbs(adapter);
+	while (ele) {
+		cb = (void*)ele->data;
+		ret = cb(adapter, device, pinbuf);
+		if (ret > 0)
+			return ret;
+
+		ele = ele->next;
+	}
+
+	return read_pin_code(sba, dba, pinbuf);
+}
+
 int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure)
 {
 	struct btd_adapter *adapter;
@@ -134,7 +154,7 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure)
 		return -ENODEV;
 
 	memset(pin, 0, sizeof(pin));
-	pinlen = read_pin_code(sba, dba, pin);
+	pinlen = get_pin(adapter, device, sba, dba, pin);
 	if (pinlen > 0 && (!secure || pinlen == 16)) {
 		btd_adapter_pincode_reply(adapter, dba, pin, pinlen);
 		return 0;
-- 
1.7.6
