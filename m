Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 3/5] Merging remote_name_information() and hcid_dbus_remote_name()
Date: Mon,  9 Nov 2009 15:30:55 +0530
Message-Id: <1257760857-27848-3-git-send-email-alok.barsode@azingo.com>
In-Reply-To: <1257760857-27848-2-git-send-email-alok.barsode@azingo.com>
References: <1257760857-27848-1-git-send-email-alok.barsode@azingo.com>
 <1257760857-27848-2-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/adapter.c  |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h  |    1 +
 src/dbus-hci.c |   45 -------------------------------------
 src/dbus-hci.h |    1 -
 src/security.c |   24 +-------------------
 5 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e03ebbf..5f8eadb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2916,6 +2916,73 @@ void adapter_handle_inquiry_complete(bdaddr_t *local, uint8_t status,
 	adapter_set_state(adapter, state);
 }
 
+void adapter_update_remote_name(bdaddr_t *local, void *ptr)
+{
+	evt_remote_name_req_complete *evt = ptr;
+	char name[MAX_NAME_LENGTH + 1];
+	char srcaddr[18], dstaddr[18];
+	int state;
+	bdaddr_t peer;
+	struct btd_device *device;
+	struct btd_adapter *adapter;
+	struct remote_dev_info match, *dev_info;
+
+	memset(name, 0, sizeof(name));
+	bacpy(&peer, &evt->bdaddr);
+
+	if (!evt->status) {
+		char *end;
+		memcpy(name, evt->name, MAX_NAME_LENGTH);
+		/* It's ok to cast end between const and non-const since
+		 * we know it points to inside of name which is non-const */
+		if (!g_utf8_validate(name, -1, (const char **) &end))
+			*end = '\0';
+		write_device_name(local, &peer, name);
+	}
+
+	ba2str(local, srcaddr);
+	ba2str(&peer, dstaddr);
+
+	adapter = manager_find_adapter(local);
+	if (!adapter) {
+		error("Unable to find matching adapter");
+		return;
+	}
+
+	device = adapter_find_device(adapter, dstaddr);
+	if (!device)
+		return;
+
+	if (evt->status != 0)
+		goto proceed;
+
+	bacpy(&match.bdaddr, &peer);
+	match.name_status = NAME_ANY;
+
+	dev_info = adapter_search_found_devices(adapter, &match);
+	if (dev_info) {
+		g_free(dev_info->name);
+		dev_info->name = g_strdup(name);
+		adapter_emit_device_found(adapter, dev_info);
+	}
+
+	if (device)
+		device_set_name(device, name);
+
+proceed:
+	/* remove from remote name request list */
+	adapter_remove_found_device(adapter, &peer);
+
+	/* check if there is more devices to request names */
+	if (adapter_resolve_names(adapter) == 0)
+		return;
+
+	state = adapter_get_state(adapter);
+	state &= ~PERIODIC_INQUIRY;
+	state &= ~STD_INQUIRY;
+	adapter_set_state(adapter, state);
+}
+
 int btd_register_adapter_driver(struct btd_adapter_driver *driver)
 {
 	GSList *adapters;
diff --git a/src/adapter.h b/src/adapter.h
index 3f15ddd..853bb37 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -120,6 +120,7 @@ void adapter_set_class_complete(bdaddr_t *bdaddr, uint8_t status);
 void adapter_handle_start_inquiry(bdaddr_t *local, uint8_t status, gboolean periodic);
 void adapter_handle_inquiry_complete(bdaddr_t *local, uint8_t status,
 							gboolean periodic);
+void adapter_update_remote_name(bdaddr_t *local, void *ptr);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
 void adapter_add_connection(struct btd_adapter *adapter,
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 6af8246..0197a0d 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -594,51 +594,6 @@ void hcid_dbus_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class)
 				DBUS_TYPE_UINT32, &class);
 }
 
-void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status,
-				char *name)
-{
-	struct btd_adapter *adapter;
-	char srcaddr[18], dstaddr[18];
-	int state;
-	struct btd_device *device;
-	struct remote_dev_info match, *dev_info;
-
-	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
-		return;
-
-	ba2str(local, srcaddr);
-	ba2str(peer, dstaddr);
-
-	if (status != 0)
-		goto proceed;
-
-	bacpy(&match.bdaddr, peer);
-	match.name_status = NAME_ANY;
-
-	dev_info = adapter_search_found_devices(adapter, &match);
-	if (dev_info) {
-		g_free(dev_info->name);
-		dev_info->name = g_strdup(name);
-		adapter_emit_device_found(adapter, dev_info);
-	}
-
-	if (device)
-		device_set_name(device, name);
-
-proceed:
-	/* remove from remote name request list */
-	adapter_remove_found_device(adapter, peer);
-
-	/* check if there is more devices to request names */
-	if (adapter_resolve_names(adapter) == 0)
-		return;
-
-	state = adapter_get_state(adapter);
-	state &= ~PERIODIC_INQUIRY;
-	state &= ~STD_INQUIRY;
-	adapter_set_state(adapter, state);
-}
-
 int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 				uint8_t *key, uint8_t key_type,
 				int pin_length, uint8_t old_key_type)
diff --git a/src/dbus-hci.h b/src/dbus-hci.h
index c85f227..8e21cdc 100644
--- a/src/dbus-hci.h
+++ b/src/dbus-hci.h
@@ -26,7 +26,6 @@ int hcid_dbus_request_pin(int dev, bdaddr_t *sba, struct hci_conn_info *ci);
 void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi, uint8_t *data);
 void hcid_dbus_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean legacy);
 void hcid_dbus_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
-void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status, char *name);
 void hcid_dbus_conn_complete(bdaddr_t *local, uint8_t status, uint16_t handle, bdaddr_t *peer);
 void hcid_dbus_disconn_complete(bdaddr_t *local, uint8_t status, uint16_t handle, uint8_t reason);
 void hcid_dbus_bonding_process_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
diff --git a/src/security.c b/src/security.c
index df72e6a..e92c8f2 100644
--- a/src/security.c
+++ b/src/security.c
@@ -599,28 +599,6 @@ static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
 	};
 }
 
-static inline void remote_name_information(int dev, bdaddr_t *sba, void *ptr)
-{
-	evt_remote_name_req_complete *evt = ptr;
-	bdaddr_t dba;
-	char name[MAX_NAME_LENGTH + 1];
-
-	memset(name, 0, sizeof(name));
-	bacpy(&dba, &evt->bdaddr);
-
-	if (!evt->status) {
-		char *end;
-		memcpy(name, evt->name, MAX_NAME_LENGTH);
-		/* It's ok to cast end between const and non-const since
-		 * we know it points to inside of name which is non-const */
-		if (!g_utf8_validate(name, -1, (const char **) &end))
-			*end = '\0';
-		write_device_name(sba, &dba, name);
-	}
-
-	hcid_dbus_remote_name(sba, &dba, evt->status, name);
-}
-
 static inline void remote_version_information(int dev, bdaddr_t *sba, void *ptr)
 {
 	evt_read_remote_version_complete *evt = ptr;
@@ -883,7 +861,7 @@ static gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer
 		break;
 
 	case EVT_REMOTE_NAME_REQ_COMPLETE:
-		remote_name_information(dev, &di->bdaddr, ptr);
+		adapter_update_remote_name(&di->bdaddr, ptr);
 		break;
 
 	case EVT_READ_REMOTE_VERSION_COMPLETE:
-- 
1.5.6.3

