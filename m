Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 2/2] Adding inquiry_complete method to handle inquiry complete event.
Date: Mon, 22 Jun 2009 20:27:37 +0530
Message-Id: <1245682657-28668-2-git-send-email-alok.barsode@azingo.com>
In-Reply-To: <1245682657-28668-1-git-send-email-alok.barsode@azingo.com>
References: <1245682657-28668-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/dbus-hci.c |   67 +--------------------------------------------------
 src/dbus-hci.h |    3 +-
 src/security.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 64 insertions(+), 79 deletions(-)

diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index ad7204f..61c65a8 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -434,7 +434,7 @@ void hcid_dbus_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
 	device_simple_pairing_complete(device, status);
 }
 
-static int found_device_req_name(struct btd_adapter *adapter)
+int found_device_req_name(struct btd_adapter *adapter)
 {
 	struct hci_request rq;
 	evt_cmd_status rp;
@@ -502,71 +502,6 @@ static int found_device_req_name(struct btd_adapter *adapter)
 	return 0;
 }
 
-void hcid_dbus_inquiry_complete(bdaddr_t *local)
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
-	/*
-	 * The following scenarios can happen:
-	 * 1. standard inquiry: always send discovery completed signal
-	 * 2. standard inquiry + name resolving: send discovery completed
-	 *    after name resolving
-	 * 3. periodic inquiry: skip discovery completed signal
-	 * 4. periodic inquiry + standard inquiry: always send discovery
-	 *    completed signal
-	 *
-	 * Keep in mind that non D-Bus requests can arrive.
-	 */
-	if (found_device_req_name(adapter) == 0)
-		return;
-
-	state = adapter_get_state(adapter);
-
-	/*
-	 * workaround to identify situation when there is no devices around
-	 * but periodic inquiry is active.
-	 */
-	if (!(state & STD_INQUIRY) && !(state & PERIODIC_INQUIRY)) {
-		state |= PERIODIC_INQUIRY;
-		adapter_set_state(adapter, state);
-	}
-
-	/* reset the discover type to be able to handle D-Bus and non D-Bus
-	 * requests */
-	state &= ~STD_INQUIRY;
-	state &= ~PERIODIC_INQUIRY;
-	adapter_set_state(adapter, state);
-}
-
-void hcid_dbus_periodic_inquiry_exit(bdaddr_t *local, uint8_t status)
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
-	/* reset the discover type to be able to handle D-Bus and non D-Bus
-	 * requests */
-	state = adapter_get_state(adapter);
-	state &= ~PERIODIC_INQUIRY;
-	adapter_set_state(adapter, state);
-}
-
 static char *extract_eir_name(uint8_t *data, uint8_t *type)
 {
 	if (!data || !type)
diff --git a/src/dbus-hci.h b/src/dbus-hci.h
index 0c809f6..fb1daba 100644
--- a/src/dbus-hci.h
+++ b/src/dbus-hci.h
@@ -23,8 +23,7 @@
  */
 
 int hcid_dbus_request_pin(int dev, bdaddr_t *sba, struct hci_conn_info *ci);
-void hcid_dbus_inquiry_complete(bdaddr_t *local);
-void hcid_dbus_periodic_inquiry_exit(bdaddr_t *local, uint8_t status);
+int found_device_req_name(struct btd_adapter *adapter);
 void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi, uint8_t *data);
 void hcid_dbus_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
 void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status, char *name);
diff --git a/src/security.c b/src/security.c
index d0a4236..a483400 100644
--- a/src/security.c
+++ b/src/security.c
@@ -588,6 +588,62 @@ static void start_inquiry(bdaddr_t *local, uint8_t status, gboolean periodic)
 	}
 }
 
+static void inquiry_complete(bdaddr_t *local, uint8_t status, gboolean periodic)
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
+	/*
+	 * The following scenarios can happen:
+	 * 1. standard inquiry: always send discovery completed signal
+	 * 2. standard inquiry + name resolving: send discovery completed
+	 *    after name resolving
+	 * 3. periodic inquiry: skip discovery completed signal
+	 * 4. periodic inquiry + standard inquiry: always send discovery
+	 *    completed signal
+	 *
+	 * Keep in mind that non D-Bus requests can arrive.
+	 */
+	if (periodic) {
+		state = adapter_get_state(adapter);
+		state &= ~PERIODIC_INQUIRY;
+		adapter_set_state(adapter, state);
+		return;
+	}
+
+	if (found_device_req_name(adapter) == 0)
+		return;
+
+	state = adapter_get_state(adapter);
+	/*
+	 * workaround to identify situation when there is no devices around
+	 * but periodic inquiry is active.
+	 */
+	if (!(state & STD_INQUIRY) && !(state & PERIODIC_INQUIRY)) {
+		state |= PERIODIC_INQUIRY;
+		adapter_set_state(adapter, state);
+		return;
+	}
+
+	/* reset the discover type to be able to handle D-Bus and non D-Bus
+	 * requests */
+	state &= ~STD_INQUIRY;
+	state &= ~PERIODIC_INQUIRY;
+	adapter_set_state(adapter, state);
+}
+
 static inline void cmd_status(int dev, bdaddr_t *sba, void *ptr)
 {
 	evt_cmd_status *evt = ptr;
@@ -601,19 +657,17 @@ static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
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
@@ -667,11 +721,6 @@ static inline void remote_version_information(int dev, bdaddr_t *sba, void *ptr)
 				evt->lmp_ver, btohs(evt->lmp_subver));
 }
 
-static inline void inquiry_complete(int dev, bdaddr_t *sba, void *ptr)
-{
-	hcid_dbus_inquiry_complete(sba);
-}
-
 static inline void inquiry_result(int dev, bdaddr_t *sba, int plen, void *ptr)
 {
 	uint8_t num = *(uint8_t *) ptr++;
@@ -875,6 +924,7 @@ static gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer
 	size_t len;
 	hci_event_hdr *eh;
 	GIOError err;
+	evt_cmd_status *evt;
 
 	if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR)) {
 		delete_channel(chan);
@@ -925,7 +975,8 @@ static gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer
 		break;
 
 	case EVT_INQUIRY_COMPLETE:
-		inquiry_complete(dev, &di->bdaddr, ptr);
+		evt = (evt_cmd_status *)ptr;
+		inquiry_complete(&di->bdaddr, evt->status, FALSE);
 		break;
 
 	case EVT_INQUIRY_RESULT:
-- 
1.5.6.3

