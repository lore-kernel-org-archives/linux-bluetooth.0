Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 2/2] Adding inquiry_complete handler.
Date: Thu, 18 Jun 2009 19:08:02 +0530
Message-Id: <1245332282-10867-2-git-send-email-alok.barsode@azingo.com>
In-Reply-To: <1245332282-10867-1-git-send-email-alok.barsode@azingo.com>
References: <1245332282-10867-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/adapter.c  |    8 ++++-
 src/dbus-hci.c |   89 ++++++++++++++++----------------------------------------
 src/dbus-hci.h |    3 +-
 src/security.c |   16 +++++-----
 4 files changed, 40 insertions(+), 76 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8d277ba..76fc6a8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -561,7 +561,11 @@ static void session_remove(struct session_req *req)
 		if (adapter->scheduler_id)
 			g_source_remove(adapter->scheduler_id);
 
-		adapter_ops->stop_discovery(adapter->dev_id);
+		if ((adapter->state & STD_INQUIRY) ||
+		    (adapter->state & PERIODIC_INQUIRY))
+			adapter_ops->stop_discovery(adapter->dev_id);
+
+		adapter->state &= ~RESOLVE_NAME;
 	}
 }
 
@@ -1012,7 +1016,7 @@ static DBusMessage *adapter_stop_discovery(DBusConnection *conn,
 				"Invalid discovery session");
 
 	session_unref(req);
-	info("Stopping discovery");
+
 	return dbus_message_new_method_return(msg);
 }
 
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index fba66b3..c31d536 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -480,13 +480,13 @@ void start_inquiry(bdaddr_t *local, uint8_t status, gboolean periodic)
 	}
 }
 
-static int found_device_req_name(struct btd_adapter *adapter)
+static void found_device_req_name(struct btd_adapter *adapter)
 {
 	struct hci_request rq;
 	evt_cmd_status rp;
 	remote_name_req_cp cp;
 	struct remote_dev_info *dev, match;
-	int dd, req_sent = 0;
+	int dd;
 	uint16_t dev_id = adapter_get_dev_id(adapter);
 
 	memset(&match, 0, sizeof(struct remote_dev_info));
@@ -495,11 +495,11 @@ static int found_device_req_name(struct btd_adapter *adapter)
 
 	dev = adapter_search_found_devices(adapter, &match);
 	if (!dev)
-		return -ENODATA;
+		return;
 
 	dd = hci_open_dev(dev_id);
 	if (dd < 0)
-		return -errno;
+		return;
 
 	memset(&rq, 0, sizeof(rq));
 	rq.ogf    = OGF_LINK_CTL;
@@ -524,10 +524,8 @@ static int found_device_req_name(struct btd_adapter *adapter)
 			error("Unable to send HCI remote name req: %s (%d)",
 						strerror(errno), errno);
 
-		if (!rp.status) {
-			req_sent = 1;
+		if (!rp.status)
 			break;
-		}
 
 		error("Remote name request failed with status 0x%02x",
 								rp.status);
@@ -541,18 +539,19 @@ static int found_device_req_name(struct btd_adapter *adapter)
 	} while (dev);
 
 	hci_close_dev(dd);
-
-	if (!req_sent)
-		return -ENODATA;
-
-	return 0;
 }
 
-void hcid_dbus_inquiry_complete(bdaddr_t *local)
+void inquiry_complete(bdaddr_t *local, uint8_t status, gboolean periodic)
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
@@ -560,57 +559,26 @@ void hcid_dbus_inquiry_complete(bdaddr_t *local)
 	}
 
 	/*
-	 * The following scenarios can happen:
-	 * 1. standard inquiry: always send discovery completed signal
-	 * 2. standard inquiry + name resolving: send discovery completed
-	 *    after name resolving
-	 * 3. periodic inquiry: skip discovery completed signal
-	 * 4. periodic inquiry + standard inquiry: always send discovery
-	 *    completed signal
+	 * Notes:
+	 * 1. Send discovery completed signal after standard or periodic
+	 *    inquiry is completed/cancelled.
+	 * 2. During periodic inquiry, we receive standard inquiry completed
+	 *    signals at end of every inquiry train.
+	 * 3. Start name resolving after inquiry is complete.
 	 *
 	 * Keep in mind that non D-Bus requests can arrive.
 	 */
-	if (found_device_req_name(adapter) == 0)
-		return;
-
 	state = adapter_get_state(adapter);
 
-	/*
-	 * workaround to identify situation when there is no devices around
-	 * but periodic inquiry is active.
-	 */
-	if (!(state & STD_INQUIRY) && !(state & PERIODIC_INQUIRY)) {
-		state |= PERIODIC_INQUIRY;
-		adapter_set_state(adapter, state);
-	}
+	if (periodic) {
+		state &= ~PERIODIC_INQUIRY;
+	} else if (state & STD_INQUIRY)
+		state &= ~STD_INQUIRY;
 
-	/* reset the discover type to be able to handle D-Bus and non D-Bus
-	 * requests */
-	state &= ~STD_INQUIRY;
-	state &= ~PERIODIC_INQUIRY;
 	adapter_set_state(adapter, state);
-}
-
-void hcid_dbus_periodic_inquiry_exit(bdaddr_t *local, uint8_t status)
-{
-	struct btd_adapter *adapter;
-	int state;
 
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
-	/* reset the discover type to be able to handle D-Bus and non D-Bus
-	 * requests */
-	state = adapter_get_state(adapter);
-	state &= ~PERIODIC_INQUIRY;
-	adapter_set_state(adapter, state);
+	if (state & RESOLVE_NAME)
+		found_device_req_name(adapter);
 }
 
 static char *extract_eir_name(uint8_t *data, uint8_t *type)
@@ -754,7 +722,6 @@ void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status,
 {
 	struct btd_adapter *adapter;
 	char srcaddr[18], dstaddr[18];
-	int state;
 	struct btd_device *device;
 	struct remote_dev_info match, *dev_info;
 
@@ -785,13 +752,7 @@ proceed:
 	adapter_remove_found_device(adapter, peer);
 
 	/* check if there is more devices to request names */
-	if (found_device_req_name(adapter) == 0)
-		return;
-
-	state = adapter_get_state(adapter);
-	state &= ~PERIODIC_INQUIRY;
-	state &= ~STD_INQUIRY;
-	adapter_set_state(adapter, state);
+	found_device_req_name(adapter);
 }
 
 int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
diff --git a/src/dbus-hci.h b/src/dbus-hci.h
index d540ec4..c489abf 100644
--- a/src/dbus-hci.h
+++ b/src/dbus-hci.h
@@ -25,9 +25,8 @@
 int hcid_dbus_request_pin(int dev, bdaddr_t *sba, struct hci_conn_info *ci);
 
 void start_inquiry(bdaddr_t *local, uint8_t status, gboolean periodic);
+void inquiry_complete(bdaddr_t *local, uint8_t status, gboolean periodic);
 
-void hcid_dbus_inquiry_complete(bdaddr_t *local);
-void hcid_dbus_periodic_inquiry_exit(bdaddr_t *local, uint8_t status);
 void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi, uint8_t *data);
 void hcid_dbus_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
 void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status, char *name);
diff --git a/src/security.c b/src/security.c
index 138b342..4f7c0ff 100644
--- a/src/security.c
+++ b/src/security.c
@@ -554,19 +554,17 @@ static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
 {
 	evt_cmd_complete *evt = ptr;
 	uint16_t opcode = btohs(evt->opcode);
-	uint8_t status;
+	uint8_t status = *((uint8_t *) ptr + EVT_CMD_COMPLETE_SIZE);
 
 	switch (opcode) {
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_PERIODIC_INQUIRY):
-		status = *((uint8_t *) ptr + EVT_CMD_COMPLETE_SIZE);
 		start_inquiry(sba, status, TRUE);
 		break;
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_EXIT_PERIODIC_INQUIRY):
-		status = *((uint8_t *) ptr + EVT_CMD_COMPLETE_SIZE);
-		hcid_dbus_periodic_inquiry_exit(sba, status);
+		inquiry_complete(sba, status, TRUE);
 		break;
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY_CANCEL):
-		hcid_dbus_inquiry_complete(sba);
+		inquiry_complete(sba, status, FALSE);
 		break;
 	case cmd_opcode_pack(OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME):
 		hcid_dbus_setname_complete(sba);
@@ -620,9 +618,11 @@ static inline void remote_version_information(int dev, bdaddr_t *sba, void *ptr)
 				evt->lmp_ver, btohs(evt->lmp_subver));
 }
 
-static inline void inquiry_complete(int dev, bdaddr_t *sba, void *ptr)
+static inline void inquiry_complete_event(int dev, bdaddr_t *sba, void *ptr)
 {
-	hcid_dbus_inquiry_complete(sba);
+	evt_cmd_status *evt = ptr;
+
+	inquiry_complete(sba, evt->status, FALSE);
 }
 
 static inline void inquiry_result(int dev, bdaddr_t *sba, int plen, void *ptr)
@@ -878,7 +878,7 @@ static gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer
 		break;
 
 	case EVT_INQUIRY_COMPLETE:
-		inquiry_complete(dev, &di->bdaddr, ptr);
+		inquiry_complete_event(dev, &di->bdaddr, ptr);
 		break;
 
 	case EVT_INQUIRY_RESULT:
-- 
1.5.6.3

