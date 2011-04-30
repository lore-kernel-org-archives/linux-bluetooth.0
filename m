Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 05/16] Remove Periodic Inquiry support in hciops
Date: Fri, 29 Apr 2011 21:27:21 -0300
Message-Id: <1304123252-14464-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Periodic Inquiry is no longer supported in hciops since the discovery
procedure will use Standard Inquiry only.

External tools which request Periodic Inquiry will not change the
adapter's state.
---
 plugins/hciops.c |  112 +++++++----------------------------------------------
 src/event.c      |   13 +------
 2 files changed, 16 insertions(+), 109 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index dfd00b1..81a0f29 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -507,24 +507,13 @@ static void start_adapter(int index)
 static int hciops_stop_inquiry(int index)
 {
 	struct dev_info *dev = &devs[index];
-	struct hci_dev_info di;
-	int err;
 
 	DBG("hci%d", index);
 
-	if (hci_devinfo(index, &di) < 0)
+	if (hci_send_cmd(dev->sk, OGF_LINK_CTL, OCF_INQUIRY_CANCEL, 0, 0) < 0)
 		return -errno;
 
-	if (hci_test_bit(HCI_INQUIRY, &di.flags))
-		err = hci_send_cmd(dev->sk, OGF_LINK_CTL,
-						OCF_INQUIRY_CANCEL, 0, 0);
-	else
-		err = hci_send_cmd(dev->sk, OGF_LINK_CTL,
-					OCF_EXIT_PERIODIC_INQUIRY, 0, 0);
-	if (err < 0)
-		err = -errno;
-
-	return err;
+	return 0;
 }
 
 static gboolean init_adapter(int index)
@@ -1306,56 +1295,6 @@ reject:
 	hci_send_cmd(dev->sk, OGF_LINK_CTL, OCF_PIN_CODE_NEG_REPLY, 6, dba);
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
-	if (periodic)
-		state |= STATE_PINQ;
-	else
-		state |= STATE_STDINQ;
-
-	adapter_set_state(adapter, state);
-}
-
-static void inquiry_complete(bdaddr_t *local, uint8_t status,
-							gboolean periodic)
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
-	state &= ~(STATE_STDINQ | STATE_PINQ);
-	adapter_set_state(adapter, state);
-}
-
 static inline void remote_features_notify(int index, void *ptr)
 {
 	struct dev_info *dev = &devs[index];
@@ -1945,12 +1884,6 @@ static inline void cmd_complete(int index, void *ptr)
 		ptr += sizeof(evt_cmd_complete);
 		read_bd_addr_complete(index, ptr);
 		break;
-	case cmd_opcode_pack(OGF_LINK_CTL, OCF_PERIODIC_INQUIRY):
-		start_inquiry(&dev->bdaddr, status, TRUE);
-		break;
-	case cmd_opcode_pack(OGF_LINK_CTL, OCF_EXIT_PERIODIC_INQUIRY):
-		inquiry_complete(&dev->bdaddr, status, TRUE);
-		break;
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY_CANCEL):
 		cc_inquiry_cancel(index, status);
 		break;
@@ -2043,6 +1976,10 @@ static inline void inquiry_result(int index, int plen, void *ptr)
 	uint8_t num = *(uint8_t *) ptr++;
 	int i;
 
+	/* Skip if it is not in Inquiry state */
+	if (get_state(index) != DISCOV_INQ)
+		return;
+
 	for (i = 0; i < num; i++) {
 		inquiry_info *info = ptr;
 		uint32_t class = info->dev_class[0] |
@@ -3060,39 +2997,20 @@ static int hciops_start_inquiry(int index, uint8_t length, gboolean periodic)
 {
 	struct dev_info *dev = &devs[index];
 	uint8_t lap[3] = { 0x33, 0x8b, 0x9e };
-	int err;
+	inquiry_cp inq_cp;
 
 	DBG("hci%d length %u periodic %d", index, length, periodic);
 
-	if (periodic) {
-		periodic_inquiry_cp cp;
-
-		memset(&cp, 0, sizeof(cp));
-		memcpy(&cp.lap, lap, 3);
-		cp.max_period = htobs(24);
-		cp.min_period = htobs(16);
-		cp.length  = length;
-		cp.num_rsp = 0x00;
-
-		err = hci_send_cmd(dev->sk, OGF_LINK_CTL,
-						OCF_PERIODIC_INQUIRY,
-						PERIODIC_INQUIRY_CP_SIZE, &cp);
-	} else {
-		inquiry_cp inq_cp;
-
-		memset(&inq_cp, 0, sizeof(inq_cp));
-		memcpy(&inq_cp.lap, lap, 3);
-		inq_cp.length = length;
-		inq_cp.num_rsp = 0x00;
+	memset(&inq_cp, 0, sizeof(inq_cp));
+	memcpy(&inq_cp.lap, lap, 3);
+	inq_cp.length = length;
+	inq_cp.num_rsp = 0x00;
 
-		err = hci_send_cmd(dev->sk, OGF_LINK_CTL,
-					OCF_INQUIRY, INQUIRY_CP_SIZE, &inq_cp);
-	}
-
-	if (err < 0)
-		err = -errno;
+	if (hci_send_cmd(dev->sk, OGF_LINK_CTL,
+			OCF_INQUIRY, INQUIRY_CP_SIZE, &inq_cp) < 0)
+		return -errno;
 
-	return err;
+	return 0;
 }
 
 static int le_set_scan_enable(int index, uint8_t enable)
diff --git a/src/event.c b/src/event.c
index 7feec1f..b04220a 100644
--- a/src/event.c
+++ b/src/event.c
@@ -435,7 +435,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	char local_addr[18], peer_addr[18], *alias, *name;
 	name_status_t name_status;
 	struct eir_data eir_data;
-	int state, err;
+	int err;
 	dbus_bool_t legacy;
 	unsigned char features[8];
 	const char *dev_name;
@@ -455,17 +455,6 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	if (data)
 		write_remote_eir(local, peer, data);
 
-	/*
-	 * Workaround to identify periodic inquiry: inquiry complete event is
-	 * sent after each window, however there isn't an event to indicate the
-	 * beginning of a new periodic inquiry window.
-	 */
-	state = adapter_get_state(adapter);
-	if (!(state & (STATE_STDINQ | STATE_LE_SCAN | STATE_PINQ))) {
-		state |= STATE_PINQ;
-		adapter_set_state(adapter, state);
-	}
-
 	/* the inquiry result can be triggered by NON D-Bus client */
 	if (adapter_get_discover_type(adapter) & DISC_RESOLVNAME &&
 				adapter_has_discov_sessions(adapter))
-- 
1.7.1

