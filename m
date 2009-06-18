Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 1/2] Adding start_inquiry handler.
Date: Thu, 18 Jun 2009 19:08:01 +0530
Message-Id: <1245332282-10867-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/dbus-hci.c |   36 +++++++++++++++---------------------
 src/dbus-hci.h |    4 ++--
 src/security.c |    7 ++-----
 3 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 8718465..fba66b3 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -434,11 +434,17 @@ void hcid_dbus_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
 	device_simple_pairing_complete(device, status);
 }
 
-void hcid_dbus_inquiry_start(bdaddr_t *local)
+void start_inquiry(bdaddr_t *local, uint8_t status, gboolean periodic)
 {
 	struct btd_adapter *adapter;
 	int state;
 
+	/* Don't send the signal if the cmd failed */
+	if (status) {
+		error("Inquiry Failed with status 0x%02x", status);
+		return;
+	}
+
 	adapter = manager_find_adapter(local);
 	if (!adapter) {
 		error("Unable to find matching adapter");
@@ -446,8 +452,16 @@ void hcid_dbus_inquiry_start(bdaddr_t *local)
 	}
 
 	state = adapter_get_state(adapter);
+
+	if (periodic) {
+		state |= PERIODIC_INQUIRY;
+		adapter_set_state(adapter, state);
+		return;
+	}
+
 	state |= STD_INQUIRY;
 	adapter_set_state(adapter, state);
+
 	/*
 	 * Cancel pending remote name request and clean the device list
 	 * when inquiry is supported in periodic inquiry idle state.
@@ -577,26 +591,6 @@ void hcid_dbus_inquiry_complete(bdaddr_t *local)
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
index d46ccf8..d540ec4 100644
--- a/src/dbus-hci.h
+++ b/src/dbus-hci.h
@@ -24,9 +24,9 @@
 
 int hcid_dbus_request_pin(int dev, bdaddr_t *sba, struct hci_conn_info *ci);
 
-void hcid_dbus_inquiry_start(bdaddr_t *local);
+void start_inquiry(bdaddr_t *local, uint8_t status, gboolean periodic);
+
 void hcid_dbus_inquiry_complete(bdaddr_t *local);
-void hcid_dbus_periodic_inquiry_start(bdaddr_t *local, uint8_t status);
 void hcid_dbus_periodic_inquiry_exit(bdaddr_t *local, uint8_t status);
 void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi, uint8_t *data);
 void hcid_dbus_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
diff --git a/src/security.c b/src/security.c
index a61d75f..138b342 100644
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
+		start_inquiry(sba, evt->status, FALSE);
 }
 
 static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
@@ -562,7 +559,7 @@ static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
 	switch (opcode) {
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_PERIODIC_INQUIRY):
 		status = *((uint8_t *) ptr + EVT_CMD_COMPLETE_SIZE);
-		hcid_dbus_periodic_inquiry_start(sba, status);
+		start_inquiry(sba, status, TRUE);
 		break;
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_EXIT_PERIODIC_INQUIRY):
 		status = *((uint8_t *) ptr + EVT_CMD_COMPLETE_SIZE);
-- 
1.5.6.3

