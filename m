Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH] Adding adapter_inquiry_begin callback to adapter.c
Date: Tue,  2 Jun 2009 16:46:33 +0530
Message-Id: <1243941393-32513-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/adapter.c  |   35 ++++++++++++++++++++++++++++++++++-
 src/adapter.h  |    3 +--
 src/dbus-hci.c |   49 -------------------------------------------------
 src/dbus-hci.h |    2 --
 src/security.c |    7 ++-----
 5 files changed, 37 insertions(+), 59 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index fbf642c..9e4046e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -214,7 +214,7 @@ static void dev_info_free(struct remote_dev_info *dev)
 	g_free(dev);
 }
 
-int pending_remote_name_cancel(struct btd_adapter *adapter)
+static int pending_remote_name_cancel(struct btd_adapter *adapter)
 {
 	struct remote_dev_info *dev, match;
 	GSList *l;
@@ -949,6 +949,39 @@ struct btd_device *adapter_get_device(DBusConnection *conn,
 	return adapter_create_device(conn, adapter, address);
 }
 
+void adapter_inquiry_begin(bdaddr_t *bdaddr, gboolean periodic, uint8_t status)
+{
+	struct btd_adapter *adapter;
+
+	adapter = manager_find_adapter(bdaddr);
+	if (!adapter) {
+		error("Unable to find matching adapter");
+		return;
+	}
+
+	if (status) {
+		error("Inquiry failed to start.");
+		return;
+	}
+
+	if (periodic) {
+		adapter->state |= PERIODIC_INQUIRY;
+		return;
+	}
+
+	adapter->state |= STD_INQUIRY;
+	/*
+	 * Cancel pending remote name request and clean the device list
+	 * when inquiry is supported in periodic inquiry idle state.
+	 */
+	if (adapter->state & PERIODIC_INQUIRY)
+		pending_remote_name_cancel(adapter);
+
+	/* Disable name resolution for non D-Bus clients */
+	if (!adapter->disc_sessions)
+		adapter->state &= ~RESOLVE_NAME;
+}
+
 static int adapter_start_inquiry(struct btd_adapter *adapter)
 {
 	gboolean periodic = TRUE;
diff --git a/src/adapter.h b/src/adapter.h
index 7300ce6..a1921f0 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -93,8 +93,6 @@ void adapter_remove_device(DBusConnection *conn, struct btd_adapter *adapter,
 struct btd_device *adapter_create_device(DBusConnection *conn,
 				struct btd_adapter *adapter, const char *address);
 
-int pending_remote_name_cancel(struct btd_adapter *adapter);
-
 void remove_pending_device(struct btd_adapter *adapter);
 
 struct btd_adapter *adapter_create(DBusConnection *conn, int id,
@@ -149,6 +147,7 @@ void btd_adapter_any_release_path(void);
 gboolean adapter_is_pairable(struct btd_adapter *adapter);
 gboolean adapter_powering_down(struct btd_adapter *adapter);
 
+void adapter_inquiry_begin(bdaddr_t *bdaddr, gboolean periodic, uint8_t status);
 
 struct btd_adapter_ops {
 	int (*setup) (void);
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 06155ad..072728a 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -434,35 +434,6 @@ void hcid_dbus_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
 	device_simple_pairing_complete(device, status);
 }
 
-void hcid_dbus_inquiry_start(bdaddr_t *local)
-{
-	struct btd_adapter *adapter;
-	int state;
-
-	adapter = manager_find_adapter(local);
-	if (!adapter) {
-		error("Unable to find matching adapter");
-		return;
-	}
-
-	state = adapter_get_state(adapter);
-	state |= STD_INQUIRY;
-	adapter_set_state(adapter, state);
-	/*
-	 * Cancel pending remote name request and clean the device list
-	 * when inquiry is supported in periodic inquiry idle state.
-	 */
-	if (adapter_get_state(adapter) & PERIODIC_INQUIRY)
-		pending_remote_name_cancel(adapter);
-
-	/* Disable name resolution for non D-Bus clients */
-	if (!adapter_has_discov_sessions(adapter)) {
-		state = adapter_get_state(adapter);
-		state &= ~RESOLVE_NAME;
-		adapter_set_state(adapter, state);
-	}
-}
-
 static int found_device_req_name(struct btd_adapter *adapter)
 {
 	struct hci_request rq;
@@ -574,26 +545,6 @@ void hcid_dbus_inquiry_complete(bdaddr_t *local)
 	adapter_set_state(adapter, state);
 }
 
-void hcid_dbus_periodic_inquiry_start(bdaddr_t *local, uint8_t status)
-{
-	struct btd_adapter *adapter;
-	int state;
-
-	/* Don't send the signal if the cmd failed */
-	if (status)
-		return;
-
-	adapter = manager_find_adapter(local);
-	if (!adapter) {
-		error("No matching adapter found");
-		return;
-	}
-
-	state = adapter_get_state(adapter);
-	state |= PERIODIC_INQUIRY;
-	adapter_set_state(adapter, state);
-}
-
 void hcid_dbus_periodic_inquiry_exit(bdaddr_t *local, uint8_t status)
 {
 	struct btd_adapter *adapter;
diff --git a/src/dbus-hci.h b/src/dbus-hci.h
index d46ccf8..051a506 100644
--- a/src/dbus-hci.h
+++ b/src/dbus-hci.h
@@ -24,9 +24,7 @@
 
 int hcid_dbus_request_pin(int dev, bdaddr_t *sba, struct hci_conn_info *ci);
 
-void hcid_dbus_inquiry_start(bdaddr_t *local);
 void hcid_dbus_inquiry_complete(bdaddr_t *local);
-void hcid_dbus_periodic_inquiry_start(bdaddr_t *local, uint8_t status);
 void hcid_dbus_periodic_inquiry_exit(bdaddr_t *local, uint8_t status);
 void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi, uint8_t *data);
 void hcid_dbus_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
diff --git a/src/security.c b/src/security.c
index a61d75f..16c85e0 100644
--- a/src/security.c
+++ b/src/security.c
@@ -546,11 +546,8 @@ static inline void cmd_status(int dev, bdaddr_t *sba, void *ptr)
 	evt_cmd_status *evt = ptr;
 	uint16_t opcode = btohs(evt->opcode);
 
-	if (evt->status)
-		return;
-
 	if (opcode == cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY))
-		hcid_dbus_inquiry_start(sba);
+		adapter_inquiry_begin(sba, FALSE, evt->status);
 }
 
 static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
@@ -562,7 +559,7 @@ static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
 	switch (opcode) {
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_PERIODIC_INQUIRY):
 		status = *((uint8_t *) ptr + EVT_CMD_COMPLETE_SIZE);
-		hcid_dbus_periodic_inquiry_start(sba, status);
+		adapter_inquiry_begin(sba, TRUE, status);
 		break;
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_EXIT_PERIODIC_INQUIRY):
 		status = *((uint8_t *) ptr + EVT_CMD_COMPLETE_SIZE);
-- 
1.5.6.3

