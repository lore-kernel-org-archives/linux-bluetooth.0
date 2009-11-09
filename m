Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 1/5] Moving start_inquiry() from security.c to adapter.c and
Date: Mon,  9 Nov 2009 15:30:53 +0530
Message-Id: <1257760857-27848-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/adapter.c  |   49 ++++++++++++++++++++++++++++++++++++++++++--
 src/adapter.h  |    6 +----
 src/security.c |   61 ++++++-------------------------------------------------
 3 files changed, 54 insertions(+), 62 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index fec14dc..18bab3d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -192,7 +192,7 @@ static void dev_info_free(struct remote_dev_info *dev)
 	g_free(dev);
 }
 
-void clear_found_devices_list(struct btd_adapter *adapter)
+static void clear_found_devices_list(struct btd_adapter *adapter)
 {
 	if (!adapter->found_devices)
 		return;
@@ -255,7 +255,7 @@ int btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
 	return err;
 }
 
-int pending_remote_name_cancel(struct btd_adapter *adapter)
+static int pending_remote_name_cancel(struct btd_adapter *adapter)
 {
 	struct remote_dev_info *dev, match;
 	int err = 0;
@@ -2808,7 +2808,7 @@ void adapter_remove_connection(struct btd_adapter *adapter,
 	}
 }
 
-gboolean adapter_has_discov_sessions(struct btd_adapter *adapter)
+static inline gboolean adapter_has_discov_sessions(struct btd_adapter *adapter)
 {
 	if (!adapter || !adapter->disc_sessions)
 		return FALSE;
@@ -2816,6 +2816,49 @@ gboolean adapter_has_discov_sessions(struct btd_adapter *adapter)
 	return TRUE;
 }
 
+void adapter_handle_start_inquiry(bdaddr_t *local, uint8_t status, gboolean periodic)
+{
+	struct btd_adapter *adapter;
+	int state;
+
+	/* Don't send the signal if the cmd failed */
+	if (status) {
+		error("Inquiry Failed with status 0x%02x", status);
+		return;
+	}
+
+	adapter = manager_find_adapter(local);
+	if (!adapter) {
+		error("Unable to find matching adapter");
+		return;
+	}
+
+	state = adapter_get_state(adapter);
+
+	/* Disable name resolution for non D-Bus clients */
+	if (!adapter_has_discov_sessions(adapter))
+		state &= ~RESOLVE_NAME;
+
+	if (periodic) {
+		state |= PERIODIC_INQUIRY;
+		adapter_set_state(adapter, state);
+		return;
+	}
+
+	state |= STD_INQUIRY;
+	adapter_set_state(adapter, state);
+
+	/*
+	 * Cancel pending remote name request and clean the device list
+	 * when inquiry is supported in periodic inquiry idle state.
+	 */
+	if (adapter->state & PERIODIC_INQUIRY) {
+		pending_remote_name_cancel(adapter);
+
+		clear_found_devices_list(adapter);
+	}
+}
+
 int btd_register_adapter_driver(struct btd_adapter_driver *driver)
 {
 	GSList *adapters;
diff --git a/src/adapter.h b/src/adapter.h
index 0954424..f92fd9e 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -92,12 +92,8 @@ void adapter_remove_device(DBusConnection *conn, struct btd_adapter *adapter,
 struct btd_device *adapter_create_device(DBusConnection *conn,
 				struct btd_adapter *adapter, const char *address);
 
-int pending_remote_name_cancel(struct btd_adapter *adapter);
-
 int adapter_resolve_names(struct btd_adapter *adapter);
 
-void clear_found_devices_list(struct btd_adapter *adapter);
-
 struct btd_adapter *adapter_create(DBusConnection *conn, int id,
 				gboolean devup);
 void adapter_remove(struct btd_adapter *adapter);
@@ -121,13 +117,13 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
 void adapter_setname_complete(bdaddr_t *local, uint8_t status);
 void adapter_update_local_name(bdaddr_t *bdaddr, uint8_t status, void *ptr);
 void adapter_set_class_complete(bdaddr_t *bdaddr, uint8_t status);
+void adapter_handle_start_inquiry(bdaddr_t *local, uint8_t status, gboolean periodic);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
 void adapter_add_connection(struct btd_adapter *adapter,
 				struct btd_device *device, uint16_t handle);
 void adapter_remove_connection(struct btd_adapter *adapter,
 				struct btd_device *device, uint16_t handle);
-gboolean adapter_has_discov_sessions(struct btd_adapter *adapter);
 
 struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter);
 void btd_adapter_unref(struct btd_adapter *adapter);
diff --git a/src/security.c b/src/security.c
index 843361b..5095218 100644
--- a/src/security.c
+++ b/src/security.c
@@ -554,49 +554,6 @@ reject:
 	hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_NEG_REPLY, 6, dba);
 }
 
-static void start_inquiry(bdaddr_t *local, uint8_t status, gboolean periodic)
-{
-	struct btd_adapter *adapter;
-	int state;
-
-	/* Don't send the signal if the cmd failed */
-	if (status) {
-		error("Inquiry Failed with status 0x%02x", status);
-		return;
-	}
-
-	adapter = manager_find_adapter(local);
-	if (!adapter) {
-		error("Unable to find matching adapter");
-		return;
-	}
-
-	state = adapter_get_state(adapter);
-
-	/* Disable name resolution for non D-Bus clients */
-	if (!adapter_has_discov_sessions(adapter))
-		state &= ~RESOLVE_NAME;
-
-	if (periodic) {
-		state |= PERIODIC_INQUIRY;
-		adapter_set_state(adapter, state);
-		return;
-	}
-
-	state |= STD_INQUIRY;
-	adapter_set_state(adapter, state);
-
-	/*
-	 * Cancel pending remote name request and clean the device list
-	 * when inquiry is supported in periodic inquiry idle state.
-	 */
-	if (adapter_get_state(adapter) & PERIODIC_INQUIRY) {
-		pending_remote_name_cancel(adapter);
-
-		clear_found_devices_list(adapter);
-	}
-}
-
 static void inquiry_complete(bdaddr_t *local, uint8_t status, gboolean periodic)
 {
 	struct btd_adapter *adapter;
@@ -663,15 +620,6 @@ static inline void remote_features_notify(int dev, bdaddr_t *sba, void *ptr)
 		hcid_dbus_set_legacy_pairing(sba, &evt->bdaddr, TRUE);
 }
 
-static inline void cmd_status(int dev, bdaddr_t *sba, void *ptr)
-{
-	evt_cmd_status *evt = ptr;
-	uint16_t opcode = btohs(evt->opcode);
-
-	if (opcode == cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY))
-		start_inquiry(sba, evt->status, FALSE);
-}
-
 static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
 {
 	evt_cmd_complete *evt = ptr;
@@ -680,7 +628,7 @@ static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
 
 	switch (opcode) {
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_PERIODIC_INQUIRY):
-		start_inquiry(sba, status, TRUE);
+		adapter_handle_start_inquiry(sba, status, TRUE);
 		break;
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_EXIT_PERIODIC_INQUIRY):
 		inquiry_complete(sba, status, TRUE);
@@ -948,6 +896,7 @@ static gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer
 	hci_event_hdr *eh;
 	GIOError err;
 	evt_cmd_status *evt;
+	uint16_t opcode;
 
 	if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR)) {
 		delete_channel(chan);
@@ -978,7 +927,11 @@ static gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer
 
 	switch (eh->evt) {
 	case EVT_CMD_STATUS:
-		cmd_status(dev, &di->bdaddr, ptr);
+		evt = (evt_cmd_status *) ptr;
+		opcode = btohs(evt->opcode);
+		if (opcode == cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY))
+			adapter_handle_start_inquiry(&di->bdaddr, evt->status,
+									FALSE);
 		break;
 
 	case EVT_CMD_COMPLETE:
-- 
1.5.6.3

