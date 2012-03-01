Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2 v2] core: Make adapter_ops->set_discoverable to take discoverable timeout
Date: Thu,  1 Mar 2012 11:15:03 +0200
Message-Id: <1330593304-7309-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables the driver to implements its own handling of the timeout
---
v2: Merge changes on hciops and mgmtops

 plugins/hciops.c  |   92 +++++++++++++++++++++++++++++++++++++++++--------
 plugins/mgmtops.c |   13 ++++---
 src/adapter.c     |   98 ++++++-----------------------------------------------
 src/adapter.h     |    7 +++-
 4 files changed, 101 insertions(+), 109 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 00b9006..61fb718 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -171,6 +171,9 @@ static struct dev_info {
 	GSList *need_name;
 
 	guint stop_scan_id;
+
+	uint16_t discoverable_timeout;
+	guint discoverable_id;
 } *devs = NULL;
 
 static int found_dev_rssi_cmp(gconstpointer a, gconstpointer b)
@@ -495,7 +498,8 @@ static int init_ssp_mode(int index)
 	return 0;
 }
 
-static int hciops_set_discoverable(int index, gboolean discoverable)
+static int hciops_set_discoverable(int index, gboolean discoverable,
+							uint16_t timeout)
 {
 	struct dev_info *dev = &devs[index];
 	uint8_t mode;
@@ -511,6 +515,8 @@ static int hciops_set_discoverable(int index, gboolean discoverable)
 								1, &mode) < 0)
 		return -errno;
 
+	dev->discoverable_timeout = timeout;
+
 	return 0;
 }
 
@@ -654,6 +660,7 @@ static gboolean init_adapter(int index)
 	gboolean existing_adapter = dev->registered;
 	uint8_t mode, on_mode;
 	gboolean pairable, discoverable;
+	uint16_t discoverable_timeout;
 
 	if (!dev->registered) {
 		adapter = btd_manager_register_adapter(index, TRUE);
@@ -668,7 +675,9 @@ static gboolean init_adapter(int index)
 	if (adapter == NULL)
 		return FALSE;
 
-	btd_adapter_get_mode(adapter, &mode, &on_mode, &pairable);
+	btd_adapter_get_mode(adapter, &mode, &on_mode,
+						&discoverable_timeout,
+						&pairable);
 
 	if (existing_adapter)
 		mode = on_mode;
@@ -683,7 +692,7 @@ static gboolean init_adapter(int index)
 
 	discoverable = (mode == MODE_DISCOVERABLE);
 
-	hciops_set_discoverable(index, discoverable);
+	hciops_set_discoverable(index, discoverable, discoverable_timeout);
 	hciops_set_pairable(index, pairable);
 
 	if (dev->already_up)
@@ -1650,20 +1659,13 @@ static inline void cmd_status(int index, void *ptr)
 		cs_inquiry_evt(index, evt->status);
 }
 
-static void read_scan_complete(int index, uint8_t status, void *ptr)
+static gboolean discoverable_timeout_handler(gpointer user_data)
 {
-	struct btd_adapter *adapter;
-	read_scan_enable_rp *rp = ptr;
+	struct dev_info *dev = user_data;
 
-	DBG("hci%d status %u", index, status);
+	hciops_set_discoverable(dev->id, FALSE, 0);
 
-	adapter = manager_find_adapter_by_id(index);
-	if (!adapter) {
-		error("Unable to find matching adapter");
-		return;
-	}
-
-	adapter_mode_changed(adapter, rp->enable);
+	return FALSE;
 }
 
 static int write_class(int index, uint32_t class)
@@ -1721,6 +1723,65 @@ static int hciops_set_limited_discoverable(int index, gboolean limited)
 	return write_class(index, dev->wanted_cod);
 }
 
+static void reset_discoverable_timeout(int index)
+{
+	struct dev_info *dev = &devs[index];
+
+	if (dev->discoverable_id > 0) {
+		g_source_remove(dev->discoverable_id);
+		dev->discoverable_id = 0;
+	}
+}
+
+static void set_discoverable_timeout(int index)
+{
+	struct dev_info *dev = &devs[index];
+
+	reset_discoverable_timeout(index);
+
+	if (dev->discoverable_timeout == 0) {
+		hciops_set_limited_discoverable(index, FALSE);
+		return;
+	}
+
+	/* Set limited discoverable if pairable and interval between 0 to 60
+	   sec */
+	if (dev->pairable && dev->discoverable_timeout <= 60)
+		hciops_set_limited_discoverable(index, TRUE);
+	else
+		hciops_set_limited_discoverable(index, FALSE);
+
+	dev->discoverable_id = g_timeout_add_seconds(dev->discoverable_timeout,
+						discoverable_timeout_handler,
+						dev);
+}
+
+static void read_scan_complete(int index, uint8_t status, void *ptr)
+{
+	struct btd_adapter *adapter;
+	read_scan_enable_rp *rp = ptr;
+
+	DBG("hci%d status %u", index, status);
+
+	switch (rp->enable) {
+	case (SCAN_PAGE | SCAN_INQUIRY):
+	case SCAN_INQUIRY:
+		set_discoverable_timeout(index);
+		break;
+	default:
+		reset_discoverable_timeout(index);
+		hciops_set_limited_discoverable(index, FALSE);
+	}
+
+	adapter = manager_find_adapter_by_id(index);
+	if (!adapter) {
+		error("Unable to find matching adapter");
+		return;
+	}
+
+	adapter_mode_changed(adapter, rp->enable);
+}
+
 static void write_class_complete(int index, uint8_t status)
 {
 	struct dev_info *dev = &devs[index];
@@ -2799,6 +2860,7 @@ static void device_event(int event, int index)
 		devs[index].pending_cod = 0;
 		devs[index].cache_enable = TRUE;
 		devs[index].discov_state = DISCOV_HALTED;
+		reset_discoverable_timeout(index);
 		if (!devs[index].pending) {
 			struct btd_adapter *adapter;
 
@@ -3815,8 +3877,8 @@ static struct btd_adapter_ops hci_ops = {
 	.cleanup = hciops_cleanup,
 	.set_powered = hciops_set_powered,
 	.set_discoverable = hciops_set_discoverable,
-	.set_pairable = hciops_set_pairable,
 	.set_limited_discoverable = hciops_set_limited_discoverable,
+	.set_pairable = hciops_set_pairable,
 	.start_discovery = hciops_start_discovery,
 	.stop_discovery = hciops_stop_discovery,
 	.set_name = hciops_set_name,
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 42a8a1f..3cc2c90 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -215,7 +215,8 @@ static int mgmt_set_connectable(int index, gboolean connectable)
 	return mgmt_set_mode(index, MGMT_OP_SET_CONNECTABLE, connectable);
 }
 
-static int mgmt_set_discoverable(int index, gboolean discoverable)
+static int mgmt_set_discoverable(int index, gboolean discoverable,
+							uint16_t timeout)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_set_discoverable)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -229,6 +230,7 @@ static int mgmt_set_discoverable(int index, gboolean discoverable)
 	hdr->len = htobs(sizeof(*cp));
 
 	cp->val = discoverable;
+	cp->timeout = timeout;
 
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
 		return -errno;
@@ -305,16 +307,17 @@ static void update_settings(struct btd_adapter *adapter, uint32_t settings)
 	struct controller_info *info;
 	gboolean pairable;
 	uint8_t on_mode;
-	uint16_t index;
+	uint16_t index, discoverable_timeout;
 
-	btd_adapter_get_mode(adapter, NULL, &on_mode, &pairable);
+	btd_adapter_get_mode(adapter, NULL, &on_mode, &discoverable_timeout,
+								&pairable);
 
 	index = adapter_get_dev_id(adapter);
 
 	info = &controllers[index];
 
 	if (on_mode == MODE_DISCOVERABLE && !mgmt_discoverable(settings))
-		mgmt_set_discoverable(index, TRUE);
+		mgmt_set_discoverable(index, TRUE, discoverable_timeout);
 	else if (on_mode == MODE_CONNECTABLE && !mgmt_connectable(settings))
 		mgmt_set_connectable(index, TRUE);
 	else if (mgmt_powered(settings))
@@ -1021,7 +1024,7 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 
 	adapter_name_changed(adapter, (char *) rp->name);
 
-	btd_adapter_get_mode(adapter, &mode, NULL, NULL);
+	btd_adapter_get_mode(adapter, &mode, NULL, NULL, NULL);
 	if (mode == MODE_OFF && mgmt_powered(info->current_settings)) {
 		mgmt_set_powered(index, FALSE);
 		return;
diff --git a/src/adapter.c b/src/adapter.c
index 685e1ca..208f4c8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -114,7 +114,6 @@ struct btd_adapter {
 	uint32_t dev_class;		/* Class of Device */
 	char *name;			/* adapter name */
 	gboolean allow_name_changes;	/* whether the adapter name can be changed */
-	guint discov_timeout_id;	/* discoverable timeout id */
 	guint stop_discov_id;		/* stop inquiry/scanning id */
 	uint32_t discov_timeout;	/* discoverable time(sec) */
 	guint pairable_timeout_id;	/* pairable timeout id */
@@ -215,54 +214,6 @@ static void adapter_set_limited_discoverable(struct btd_adapter *adapter,
 	adapter_ops->set_limited_discoverable(adapter->dev_id, limited);
 }
 
-static void adapter_remove_discov_timeout(struct btd_adapter *adapter)
-{
-	if (!adapter)
-		return;
-
-	if (adapter->discov_timeout_id == 0)
-		return;
-
-	g_source_remove(adapter->discov_timeout_id);
-	adapter->discov_timeout_id = 0;
-}
-
-static gboolean discov_timeout_handler(gpointer user_data)
-{
-	struct btd_adapter *adapter = user_data;
-
-	adapter->discov_timeout_id = 0;
-
-	adapter_ops->set_discoverable(adapter->dev_id, FALSE);
-
-	return FALSE;
-}
-
-static void adapter_set_discov_timeout(struct btd_adapter *adapter,
-					guint interval)
-{
-	if (adapter->discov_timeout_id) {
-		g_source_remove(adapter->discov_timeout_id);
-		adapter->discov_timeout_id = 0;
-	}
-
-	if (interval == 0) {
-		adapter_set_limited_discoverable(adapter, FALSE);
-		return;
-	}
-
-	/* Set limited discoverable if pairable and interval between 0 to 60
-	   sec */
-	if (adapter->pairable && interval <= 60)
-		adapter_set_limited_discoverable(adapter, TRUE);
-	else
-		adapter_set_limited_discoverable(adapter, FALSE);
-
-	adapter->discov_timeout_id = g_timeout_add_seconds(interval,
-							discov_timeout_handler,
-							adapter);
-}
-
 static struct session_req *session_ref(struct session_req *req)
 {
 	req->refcount++;
@@ -302,22 +253,12 @@ static int adapter_set_mode(struct btd_adapter *adapter, uint8_t mode)
 	int err;
 
 	if (mode == MODE_CONNECTABLE)
-		err = adapter_ops->set_discoverable(adapter->dev_id, FALSE);
+		err = adapter_ops->set_discoverable(adapter->dev_id, FALSE, 0);
 	else
-		err = adapter_ops->set_discoverable(adapter->dev_id, TRUE);
-
-	if (err < 0)
-		return err;
-
-	if (mode == MODE_CONNECTABLE)
-		return 0;
-
-	adapter_remove_discov_timeout(adapter);
-
-	if (adapter->discov_timeout)
-		adapter_set_discov_timeout(adapter, adapter->discov_timeout);
+		err = adapter_ops->set_discoverable(adapter->dev_id, TRUE,
+						adapter->discov_timeout);
 
-	return 0;
+	return err;
 }
 
 static struct session_req *find_session_by_msg(GSList *list, const DBusMessage *msg)
@@ -710,7 +651,7 @@ static DBusMessage *set_discoverable_timeout(DBusConnection *conn,
 		return dbus_message_new_method_return(msg);
 
 	if (adapter->scan_mode & SCAN_INQUIRY)
-		adapter_set_discov_timeout(adapter, timeout);
+		adapter_ops->set_discoverable(adapter->dev_id, TRUE, timeout);
 
 	adapter->discov_timeout = timeout;
 
@@ -2194,7 +2135,9 @@ static void emit_device_disappeared(gpointer data, gpointer user_data)
 }
 
 void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
-					uint8_t *on_mode, gboolean *pairable)
+						uint8_t *on_mode,
+						uint16_t *discoverable_timeout,
+						gboolean *pairable)
 {
 	char str[14], address[18];
 
@@ -2212,6 +2155,9 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
 	if (on_mode)
 		*on_mode = get_mode(&adapter->bdaddr, "on");
 
+	if (discoverable_timeout)
+		*discoverable_timeout = get_discoverable_timeout(address);
+
 	if (pairable)
 		*pairable = adapter->pairable;
 }
@@ -2342,12 +2288,6 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 {
 	gboolean prop_false = FALSE;
 
-	/* cancel pending timeout */
-	if (adapter->discov_timeout_id) {
-		g_source_remove(adapter->discov_timeout_id);
-		adapter->discov_timeout_id = 0;
-	}
-
 	/* check pending requests */
 	reply_pending_requests(adapter);
 
@@ -2977,8 +2917,6 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 	if (adapter->scan_mode == scan_mode)
 		return;
 
-	adapter_remove_discov_timeout(adapter);
-
 	switch (scan_mode) {
 	case SCAN_DISABLED:
 		adapter->mode = MODE_OFF;
@@ -2994,18 +2932,7 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 		adapter->mode = MODE_DISCOVERABLE;
 		discoverable = TRUE;
 		pairable = adapter->pairable;
-		if (adapter->discov_timeout != 0)
-			adapter_set_discov_timeout(adapter,
-						adapter->discov_timeout);
 		break;
-	case SCAN_INQUIRY:
-		/* Address the scenario where a low-level application like
-		 * hciconfig changed the scan mode */
-		if (adapter->discov_timeout != 0)
-			adapter_set_discov_timeout(adapter,
-						adapter->discov_timeout);
-
-		/* ignore, this event should not be sent */
 	default:
 		/* ignore, reserved */
 		return;
@@ -3017,9 +2944,6 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 					ADAPTER_INTERFACE, "Pairable",
 					DBUS_TYPE_BOOLEAN, &pairable);
 
-	if (!discoverable)
-		adapter_set_limited_discoverable(adapter, FALSE);
-
 	emit_property_changed(connection, path,
 				ADAPTER_INTERFACE, "Discoverable",
 				DBUS_TYPE_BOOLEAN, &discoverable);
diff --git a/src/adapter.h b/src/adapter.h
index 22bb0bb..611e86f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -87,7 +87,9 @@ void btd_adapter_start(struct btd_adapter *adapter);
 int btd_adapter_stop(struct btd_adapter *adapter);
 
 void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
-					uint8_t *on_mode, gboolean *pairable);
+						uint8_t *on_mode,
+						uint16_t *discoverable_timeout,
+						gboolean *pairable);
 
 struct btd_device *adapter_get_device(DBusConnection *conn,
 				struct btd_adapter *adapter, const char *address);
@@ -181,7 +183,8 @@ struct btd_adapter_ops {
 	int (*setup) (void);
 	void (*cleanup) (void);
 	int (*set_powered) (int index, gboolean powered);
-	int (*set_discoverable) (int index, gboolean discoverable);
+	int (*set_discoverable) (int index, gboolean discoverable,
+							uint16_t timeout);
 	int (*set_pairable) (int index, gboolean pairable);
 	int (*set_limited_discoverable) (int index, gboolean limited);
 	int (*start_discovery) (int index);
-- 
1.7.7.6

