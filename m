Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Move index to common header in management interface
Date: Thu, 24 Feb 2011 14:36:47 +0100
Message-ID: <1298554607-2527-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Match changes introduced in mgmt interface after moving controller
index to common header.
---
 lib/mgmt.h        |   43 +---------
 plugins/mgmtops.c |  243 +++++++++++++++++++----------------------------------
 2 files changed, 90 insertions(+), 196 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index b3eabac..7854ab1 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -25,11 +25,14 @@
 #define __packed __attribute__((packed))
 #endif
 
+#define MGMT_INDEX_NONE			0xFFFF
+
 struct mgmt_hdr {
 	uint16_t opcode;
+	uint16_t index;
 	uint16_t len;
 } __packed;
-#define MGMT_HDR_SIZE	4
+#define MGMT_HDR_SIZE	6
 
 #define MGMT_OP_READ_VERSION		0x0001
 struct mgmt_rp_read_version {
@@ -49,11 +52,7 @@ struct mgmt_rp_read_index_list {
 } __packed;
 
 #define MGMT_OP_READ_INFO		0x0004
-struct mgmt_cp_read_info {
-	uint16_t index;
-} __packed;
 struct mgmt_rp_read_info {
-	uint16_t index;
 	uint8_t type;
 	uint8_t powered;
 	uint8_t connectable;
@@ -69,7 +68,6 @@ struct mgmt_rp_read_info {
 } __packed;
 
 struct mgmt_mode {
-	uint16_t index;
 	uint8_t val;
 } __packed;
 
@@ -83,27 +81,23 @@ struct mgmt_mode {
 
 #define MGMT_OP_ADD_UUID		0x0009
 struct mgmt_cp_add_uuid {
-	uint16_t index;
 	uint8_t uuid[16];
 	uint8_t svc_hint;
 } __packed;
 
 #define MGMT_OP_REMOVE_UUID		0x000A
 struct mgmt_cp_remove_uuid {
-	uint16_t index;
 	uint8_t uuid[16];
 } __packed;
 
 #define MGMT_OP_SET_DEV_CLASS		0x000B
 struct mgmt_cp_set_dev_class {
-	uint16_t index;
 	uint8_t major;
 	uint8_t minor;
 } __packed;
 
 #define MGMT_OP_SET_SERVICE_CACHE	0x000C
 struct mgmt_cp_set_service_cache {
-	uint16_t index;
 	uint8_t enable;
 } __packed;
 
@@ -116,7 +110,6 @@ struct mgmt_key_info {
 
 #define MGMT_OP_LOAD_KEYS		0x000D
 struct mgmt_cp_load_keys {
-	uint16_t index;
 	uint8_t debug_keys;
 	uint16_t key_count;
 	struct mgmt_key_info keys[0];
@@ -124,34 +117,26 @@ struct mgmt_cp_load_keys {
 
 #define MGMT_OP_REMOVE_KEY		0x000E
 struct mgmt_cp_remove_key {
-	uint16_t index;
 	bdaddr_t bdaddr;
 	uint8_t disconnect;
 } __packed;
 
 #define MGMT_OP_DISCONNECT		0x000F
 struct mgmt_cp_disconnect {
-	uint16_t index;
 	bdaddr_t bdaddr;
 } __packed;
 struct mgmt_rp_disconnect {
-	uint16_t index;
 	bdaddr_t bdaddr;
 } __packed;
 
 #define MGMT_OP_GET_CONNECTIONS		0x0010
-struct mgmt_cp_get_connections {
-	uint16_t index;
-} __packed;
 struct mgmt_rp_get_connections {
-	uint16_t index;
 	uint16_t conn_count;
 	bdaddr_t conn[0];
 } __packed;
 
 #define MGMT_OP_PIN_CODE_REPLY		0x0011
 struct mgmt_cp_pin_code_reply {
-	uint16_t index;
 	bdaddr_t bdaddr;
 	uint8_t pin_len;
 	uint8_t pin_code[16];
@@ -159,35 +144,29 @@ struct mgmt_cp_pin_code_reply {
 
 #define MGMT_OP_PIN_CODE_NEG_REPLY	0x0012
 struct mgmt_cp_pin_code_neg_reply {
-	uint16_t index;
 	bdaddr_t bdaddr;
 } __packed;
 
 #define MGMT_OP_SET_IO_CAPABILITY	0x0013
 struct mgmt_cp_set_io_capability {
-	uint16_t index;
 	uint8_t io_capability;
 } __packed;
 
 #define MGMT_OP_PAIR_DEVICE		0x0014
 struct mgmt_cp_pair_device {
-	uint16_t index;
 	bdaddr_t bdaddr;
 	uint8_t io_cap;
 } __packed;
 struct mgmt_rp_pair_device {
-	uint16_t index;
 	bdaddr_t bdaddr;
 	uint8_t status;
 } __packed;
 
 #define MGMT_OP_USER_CONFIRM_REPLY	0x0015
 struct mgmt_cp_user_confirm_reply {
-	uint16_t index;
 	bdaddr_t bdaddr;
 } __packed;
 struct mgmt_rp_user_confirm_reply {
-	uint16_t index;
 	bdaddr_t bdaddr;
 	uint8_t status;
 } __packed;
@@ -208,19 +187,12 @@ struct mgmt_ev_cmd_status {
 
 #define MGMT_EV_CONTROLLER_ERROR	0x0003
 struct mgmt_ev_controller_error {
-	uint16_t index;
 	uint8_t error_code;
 } __packed;
 
 #define MGMT_EV_INDEX_ADDED		0x0004
-struct mgmt_ev_index_added {
-	uint16_t index;
-} __packed;
 
 #define MGMT_EV_INDEX_REMOVED		0x0005
-struct mgmt_ev_index_removed {
-	uint16_t index;
-} __packed;
 
 #define MGMT_EV_POWERED			0x0006
 
@@ -232,46 +204,39 @@ struct mgmt_ev_index_removed {
 
 #define MGMT_EV_NEW_KEY			0x000A
 struct mgmt_ev_new_key {
-	uint16_t index;
 	struct mgmt_key_info key;
 	uint8_t old_key_type;
 } __packed;
 
 #define MGMT_EV_DEVICE_CONNECTED	0x000B
 struct mgmt_ev_device_connected {
-	uint16_t index;
 	bdaddr_t bdaddr;
 } __packed;
 
 #define MGMT_EV_DEVICE_DISCONNECTED	0x000C
 struct mgmt_ev_device_disconnected {
-	uint16_t index;
 	bdaddr_t bdaddr;
 } __packed;
 
 #define MGMT_EV_CONNECT_FAILED		0x000D
 struct mgmt_ev_connect_failed {
-	uint16_t index;
 	bdaddr_t bdaddr;
 	uint8_t status;
 } __packed;
 
 #define MGMT_EV_PIN_CODE_REQUEST	0x000E
 struct mgmt_ev_pin_code_request {
-	uint16_t index;
 	bdaddr_t bdaddr;
 } __packed;
 
 #define MGMT_EV_USER_CONFIRM_REQUEST	0x000F
 struct mgmt_ev_user_confirm_request {
-	uint16_t index;
 	bdaddr_t bdaddr;
 	uint32_t value;
 } __packed;
 
 #define MGMT_EV_AUTH_FAILED		0x0010
 struct mgmt_ev_auth_failed {
-	uint16_t index;
 	bdaddr_t bdaddr;
 	uint8_t status;
 } __packed;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 49f0728..a19a6cc 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -92,6 +92,7 @@ static void read_version_complete(int sk, void *buf, size_t len)
 
 	memset(&hdr, 0, sizeof(hdr));
 	hdr.opcode = htobs(MGMT_OP_READ_INDEX_LIST);
+	hdr.index = htobs(MGMT_INDEX_NONE);
 	if (write(sk, &hdr, sizeof(hdr)) < 0)
 		error("Unable to read controller index list: %s (%d)",
 						strerror(errno), errno);
@@ -114,50 +115,32 @@ static void add_controller(uint16_t index)
 
 static void read_info(int sk, uint16_t index)
 {
-	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_read_info)];
-	struct mgmt_hdr *hdr = (void *) buf;
-	struct mgmt_cp_read_info *cp = (void *) &buf[sizeof(*hdr)];
-
-	memset(buf, 0, sizeof(buf));
-	hdr->opcode = htobs(MGMT_OP_READ_INFO);
-	hdr->len = htobs(sizeof(*cp));
+	struct mgmt_hdr hdr;
 
-	cp->index = htobs(index);
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.opcode = htobs(MGMT_OP_READ_INFO);
+	hdr.index = htobs(index);
 
-	if (write(sk, buf, sizeof(buf)) < 0)
+	if (write(sk, &hdr, sizeof(hdr)) < 0)
 		error("Unable to send read_info command: %s (%d)",
 						strerror(errno), errno);
 }
 
 static void get_connections(int sk, uint16_t index)
 {
-	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_get_connections)];
-	struct mgmt_hdr *hdr = (void *) buf;
-	struct mgmt_cp_get_connections *cp = (void *) &buf[sizeof(*hdr)];
-
-	memset(buf, 0, sizeof(buf));
-	hdr->opcode = htobs(MGMT_OP_GET_CONNECTIONS);
-	hdr->len = htobs(sizeof(*cp));
+	struct mgmt_hdr hdr;
 
-	cp->index = htobs(index);
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.opcode = htobs(MGMT_OP_GET_CONNECTIONS);
+	hdr.index = htobs(index);
 
-	if (write(sk, buf, sizeof(buf)) < 0)
+	if (write(sk, &hdr, sizeof(hdr)) < 0)
 		error("Unable to send get_connections command: %s (%d)",
 						strerror(errno), errno);
 }
 
-static void mgmt_index_added(int sk, void *buf, size_t len)
+static void mgmt_index_added(int sk, uint16_t index)
 {
-	struct mgmt_ev_index_added *ev = buf;
-	uint16_t index;
-
-	if (len < sizeof(*ev)) {
-		error("Too small index added event");
-		return;
-	}
-
-	index = btohs(bt_get_unaligned(&ev->index));
-
 	add_controller(index);
 	read_info(sk, index);
 }
@@ -177,18 +160,8 @@ static void remove_controller(uint16_t index)
 	DBG("Removed controller %u", index);
 }
 
-static void mgmt_index_removed(int sk, void *buf, size_t len)
+static void mgmt_index_removed(int sk, uint16_t index)
 {
-	struct mgmt_ev_index_removed *ev = buf;
-	uint16_t index;
-
-	if (len < sizeof(*ev)) {
-		error("Too small index removed event");
-		return;
-	}
-
-	index = btohs(bt_get_unaligned(&ev->index));
-
 	remove_controller(index);
 }
 
@@ -200,9 +173,9 @@ static int mgmt_set_mode(int index, uint16_t opcode, uint8_t val)
 
 	memset(buf, 0, sizeof(buf));
 	hdr->opcode = htobs(opcode);
+	hdr->index = htobs(index);
 	hdr->len = htobs(sizeof(*cp));
 
-	cp->index = htobs(index);
 	cp->val = val;
 
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
@@ -287,29 +260,25 @@ static int mgmt_update_powered(int index, uint8_t powered)
 	return 0;
 }
 
-static void mgmt_powered(int sk, void *buf, size_t len)
+static void mgmt_powered(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_mode *ev = buf;
-	uint16_t index;
 
 	if (len < sizeof(*ev)) {
 		error("Too small powered event");
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&ev->index));
-
 	DBG("Controller %u powered %u", index, ev->val);
 
 	mgmt_update_powered(index, ev->val);
 }
 
-static void mgmt_discoverable(int sk, void *buf, size_t len)
+static void mgmt_discoverable(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_mode *ev = buf;
 	struct controller_info *info;
 	struct btd_adapter *adapter;
-	uint16_t index;
 	uint8_t mode;
 
 	if (len < sizeof(*ev)) {
@@ -317,8 +286,6 @@ static void mgmt_discoverable(int sk, void *buf, size_t len)
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&ev->index));
-
 	DBG("Controller %u discoverable %u", index, ev->val);
 
 	if (index > max_index) {
@@ -345,12 +312,11 @@ static void mgmt_discoverable(int sk, void *buf, size_t len)
 	adapter_mode_changed(adapter, mode);
 }
 
-static void mgmt_connectable(int sk, void *buf, size_t len)
+static void mgmt_connectable(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_mode *ev = buf;
 	struct controller_info *info;
 	struct btd_adapter *adapter;
-	uint16_t index;
 	uint8_t mode;
 
 	if (len < sizeof(*ev)) {
@@ -358,8 +324,6 @@ static void mgmt_connectable(int sk, void *buf, size_t len)
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&ev->index));
-
 	DBG("Controller %u connectable %u", index, ev->val);
 
 	if (index > max_index) {
@@ -386,20 +350,17 @@ static void mgmt_connectable(int sk, void *buf, size_t len)
 	adapter_mode_changed(adapter, mode);
 }
 
-static void mgmt_pairable(int sk, void *buf, size_t len)
+static void mgmt_pairable(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_mode *ev = buf;
 	struct controller_info *info;
 	struct btd_adapter *adapter;
-	uint16_t index;
 
 	if (len < sizeof(*ev)) {
 		error("Too small pairable event");
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&ev->index));
-
 	DBG("Controller %u pairable %u", index, ev->val);
 
 	if (index > max_index) {
@@ -418,11 +379,10 @@ static void mgmt_pairable(int sk, void *buf, size_t len)
 	btd_adapter_pairable_changed(adapter, info->pairable);
 }
 
-static void mgmt_new_key(int sk, void *buf, size_t len)
+static void mgmt_new_key(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_new_key *ev = buf;
 	struct controller_info *info;
-	uint16_t index;
 
 	if (len != sizeof(*ev)) {
 		error("new_key event size mismatch (%zu != %zu)",
@@ -430,8 +390,6 @@ static void mgmt_new_key(int sk, void *buf, size_t len)
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&ev->index));
-
 	DBG("Controller %u new key of type %u pin_len %u", index,
 					ev->key.type, ev->key.pin_len);
 
@@ -455,11 +413,10 @@ static void mgmt_new_key(int sk, void *buf, size_t len)
 	btd_event_bonding_complete(&info->bdaddr, &ev->key.bdaddr, 0);
 }
 
-static void mgmt_device_connected(int sk, void *buf, size_t len)
+static void mgmt_device_connected(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_device_connected *ev = buf;
 	struct controller_info *info;
-	uint16_t index;
 	char addr[18];
 
 	if (len < sizeof(*ev)) {
@@ -467,7 +424,6 @@ static void mgmt_device_connected(int sk, void *buf, size_t len)
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&ev->index));
 	ba2str(&ev->bdaddr, addr);
 
 	DBG("hci%u device %s connected", index, addr);
@@ -482,11 +438,11 @@ static void mgmt_device_connected(int sk, void *buf, size_t len)
 	btd_event_conn_complete(&info->bdaddr, &ev->bdaddr);
 }
 
-static void mgmt_device_disconnected(int sk, void *buf, size_t len)
+static void mgmt_device_disconnected(int sk, uint16_t index, void *buf,
+								size_t len)
 {
 	struct mgmt_ev_device_disconnected *ev = buf;
 	struct controller_info *info;
-	uint16_t index;
 	char addr[18];
 
 	if (len < sizeof(*ev)) {
@@ -494,7 +450,6 @@ static void mgmt_device_disconnected(int sk, void *buf, size_t len)
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&ev->index));
 	ba2str(&ev->bdaddr, addr);
 
 	DBG("hci%u device %s disconnected", index, addr);
@@ -509,11 +464,10 @@ static void mgmt_device_disconnected(int sk, void *buf, size_t len)
 	btd_event_disconn_complete(&info->bdaddr, &ev->bdaddr);
 }
 
-static void mgmt_connect_failed(int sk, void *buf, size_t len)
+static void mgmt_connect_failed(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_connect_failed *ev = buf;
 	struct controller_info *info;
-	uint16_t index;
 	char addr[18];
 
 	if (len < sizeof(*ev)) {
@@ -521,7 +475,6 @@ static void mgmt_connect_failed(int sk, void *buf, size_t len)
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&ev->index));
 	ba2str(&ev->bdaddr, addr);
 
 	DBG("hci%u %s status %u", index, addr, ev->status);
@@ -556,9 +509,9 @@ static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin)
 
 		hdr->opcode = htobs(MGMT_OP_PIN_CODE_NEG_REPLY);
 		hdr->len = htobs(sizeof(*cp));
+		hdr->index = htobs(index);
 
 		cp = (void *) &buf[sizeof(*hdr)];
-		cp->index = htobs(index);
 		bacpy(&cp->bdaddr, bdaddr);
 
 		buf_len = sizeof(*hdr) + sizeof(*cp);
@@ -572,9 +525,9 @@ static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin)
 
 		hdr->opcode = htobs(MGMT_OP_PIN_CODE_REPLY);
 		hdr->len = htobs(sizeof(*cp));
+		hdr->index = htobs(index);
 
 		cp = (void *) &buf[sizeof(*hdr)];
-		cp->index = htobs(index);
 		bacpy(&cp->bdaddr, bdaddr);
 		cp->pin_len = pin_len;
 		memcpy(cp->pin_code, pin, pin_len);
@@ -588,11 +541,10 @@ static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin)
 	return 0;
 }
 
-static void mgmt_pin_code_request(int sk, void *buf, size_t len)
+static void mgmt_pin_code_request(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_pin_code_request *ev = buf;
 	struct controller_info *info;
-	uint16_t index;
 	char addr[18];
 	int err;
 
@@ -601,7 +553,6 @@ static void mgmt_pin_code_request(int sk, void *buf, size_t len)
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&ev->index));
 	ba2str(&ev->bdaddr, addr);
 
 	DBG("hci%u %s", index, addr);
@@ -638,9 +589,9 @@ static int mgmt_confirm_reply(int index, bdaddr_t *bdaddr, gboolean success)
 		hdr->opcode = htobs(MGMT_OP_USER_CONFIRM_NEG_REPLY);
 
 	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
 
 	cp = (void *) &buf[sizeof(*hdr)];
-	cp->index = htobs(index);
 	bacpy(&cp->bdaddr, bdaddr);
 
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
@@ -649,11 +600,11 @@ static int mgmt_confirm_reply(int index, bdaddr_t *bdaddr, gboolean success)
 	return 0;
 }
 
-static void mgmt_user_confirm_request(int sk, void *buf, size_t len)
+static void mgmt_user_confirm_request(int sk, uint16_t index, void *buf,
+								size_t len)
 {
 	struct mgmt_ev_user_confirm_request *ev = buf;
 	struct controller_info *info;
-	uint16_t index;
 	char addr[18];
 	int err;
 
@@ -662,7 +613,6 @@ static void mgmt_user_confirm_request(int sk, void *buf, size_t len)
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&ev->index));
 	ba2str(&ev->bdaddr, addr);
 
 	DBG("hci%u %s", index, addr);
@@ -707,8 +657,8 @@ static int mgmt_add_uuid(int index, uuid_t *uuid, uint8_t svc_hint)
 	memset(buf, 0, sizeof(buf));
 	hdr->opcode = htobs(MGMT_OP_ADD_UUID);
 	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
 
-	cp->index = htobs(index);
 	memcpy(cp->uuid, uuid128.value.uuid128.data, 16);
 	cp->svc_hint = svc_hint;
 
@@ -732,8 +682,8 @@ static int mgmt_remove_uuid(int index, uuid_t *uuid)
 	memset(buf, 0, sizeof(buf));
 	hdr->opcode = htobs(MGMT_OP_REMOVE_UUID);
 	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
 
-	cp->index = htobs(index);
 	memcpy(cp->uuid, uuid128.value.uuid128.data, 16);
 
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
@@ -787,13 +737,12 @@ static int mgmt_set_powered(int index, gboolean powered)
 	return mgmt_set_mode(index, MGMT_OP_SET_POWERED, powered);
 }
 
-static void read_info_complete(int sk, void *buf, size_t len)
+static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_rp_read_info *rp = buf;
 	struct controller_info *info;
 	struct btd_adapter *adapter;
 	uint8_t mode;
-	uint16_t index;
 	char addr[18];
 
 	if (len < sizeof(*rp)) {
@@ -801,7 +750,6 @@ static void read_info_complete(int sk, void *buf, size_t len)
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&rp->index));
 	if (index > max_index) {
 		error("Unexpected index %u in read info complete", index);
 		return;
@@ -853,29 +801,26 @@ static void read_info_complete(int sk, void *buf, size_t len)
 	btd_adapter_unref(adapter);
 }
 
-static void set_powered_complete(int sk, void *buf, size_t len)
+static void set_powered_complete(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_mode *rp = buf;
-	uint16_t index;
 
 	if (len < sizeof(*rp)) {
 		error("Too small set powered complete event");
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&rp->index));
-
 	DBG("hci%d powered %u", index, rp->val);
 
 	mgmt_update_powered(index, rp->val);
 }
 
-static void set_discoverable_complete(int sk, void *buf, size_t len)
+static void set_discoverable_complete(int sk, uint16_t index, void *buf,
+								size_t len)
 {
 	struct mgmt_mode *rp = buf;
 	struct controller_info *info;
 	struct btd_adapter *adapter;
-	uint16_t index;
 	uint8_t mode;
 
 	if (len < sizeof(*rp)) {
@@ -883,8 +828,6 @@ static void set_discoverable_complete(int sk, void *buf, size_t len)
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&rp->index));
-
 	DBG("hci%d discoverable %u", index, rp->val);
 
 	if (index > max_index) {
@@ -909,20 +852,18 @@ static void set_discoverable_complete(int sk, void *buf, size_t len)
 	adapter_mode_changed(adapter, mode);
 }
 
-static void set_connectable_complete(int sk, void *buf, size_t len)
+static void set_connectable_complete(int sk, uint16_t index, void *buf,
+								size_t len)
 {
 	struct mgmt_mode *rp = buf;
 	struct controller_info *info;
 	struct btd_adapter *adapter;
-	uint16_t index;
 
 	if (len < sizeof(*rp)) {
 		error("Too small set connectable complete event");
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&rp->index));
-
 	DBG("hci%d connectable %u", index, rp->val);
 
 	if (index > max_index) {
@@ -939,20 +880,18 @@ static void set_connectable_complete(int sk, void *buf, size_t len)
 		adapter_mode_changed(adapter, rp->val ? SCAN_PAGE : 0);
 }
 
-static void set_pairable_complete(int sk, void *buf, size_t len)
+static void set_pairable_complete(int sk, uint16_t index, void *buf,
+								size_t len)
 {
 	struct mgmt_mode *rp = buf;
 	struct controller_info *info;
 	struct btd_adapter *adapter;
-	uint16_t index;
 
 	if (len < sizeof(*rp)) {
 		error("Too small set pairable complete event");
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&rp->index));
-
 	DBG("hci%d pairable %u", index, rp->val);
 
 	if (index > max_index) {
@@ -971,11 +910,10 @@ static void set_pairable_complete(int sk, void *buf, size_t len)
 	btd_adapter_pairable_changed(adapter, info->pairable);
 }
 
-static void disconnect_complete(int sk, void *buf, size_t len)
+static void disconnect_complete(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_rp_disconnect *rp = buf;
 	struct controller_info *info;
-	uint16_t index;
 	char addr[18];
 
 	if (len < sizeof(*rp)) {
@@ -983,8 +921,6 @@ static void disconnect_complete(int sk, void *buf, size_t len)
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&rp->index));
-
 	ba2str(&rp->bdaddr, addr);
 
 	DBG("hci%d %s disconnected", index, addr);
@@ -1002,11 +938,10 @@ static void disconnect_complete(int sk, void *buf, size_t len)
 						HCI_CONNECTION_TERMINATED);
 }
 
-static void pair_device_complete(int sk, void *buf, size_t len)
+static void pair_device_complete(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_rp_pair_device *rp = buf;
 	struct controller_info *info;
-	uint16_t index;
 	char addr[18];
 
 	if (len < sizeof(*rp)) {
@@ -1014,8 +949,6 @@ static void pair_device_complete(int sk, void *buf, size_t len)
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&rp->index));
-
 	ba2str(&rp->bdaddr, addr);
 
 	DBG("hci%d %s pairing complete status %u", index, addr, rp->status);
@@ -1030,11 +963,11 @@ static void pair_device_complete(int sk, void *buf, size_t len)
 	btd_event_bonding_complete(&info->bdaddr, &rp->bdaddr, rp->status);
 }
 
-static void get_connections_complete(int sk, void *buf, size_t len)
+static void get_connections_complete(int sk, uint16_t index, void *buf,
+								size_t len)
 {
 	struct mgmt_rp_get_connections *rp = buf;
 	struct controller_info *info;
-	uint16_t index;
 	int i;
 
 	if (len < sizeof(*rp)) {
@@ -1047,8 +980,6 @@ static void get_connections_complete(int sk, void *buf, size_t len)
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&rp->index));
-
 	if (index > max_index) {
 		error("Unexpected index %u in get_connections complete",
 								index);
@@ -1065,7 +996,7 @@ static void get_connections_complete(int sk, void *buf, size_t len)
 	read_info(sk, index);
 }
 
-static void mgmt_cmd_complete(int sk, void *buf, size_t len)
+static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_cmd_complete *ev = buf;
 	uint16_t opcode;
@@ -1079,27 +1010,29 @@ static void mgmt_cmd_complete(int sk, void *buf, size_t len)
 
 	opcode = btohs(bt_get_unaligned(&ev->opcode));
 
+	len -= sizeof(*ev);
+
 	switch (opcode) {
 	case MGMT_OP_READ_VERSION:
-		read_version_complete(sk, ev->data, len - sizeof(*ev));
+		read_version_complete(sk, ev->data, len);
 		break;
 	case MGMT_OP_READ_INDEX_LIST:
-		read_index_list_complete(sk, ev->data, len - sizeof(*ev));
+		read_index_list_complete(sk, ev->data, len);
 		break;
 	case MGMT_OP_READ_INFO:
-		read_info_complete(sk, ev->data, len - sizeof(*ev));
+		read_info_complete(sk, index, ev->data, len);
 		break;
 	case MGMT_OP_SET_POWERED:
-		set_powered_complete(sk, ev->data, len - sizeof(*ev));
+		set_powered_complete(sk, index, ev->data, len);
 		break;
 	case MGMT_OP_SET_DISCOVERABLE:
-		set_discoverable_complete(sk, ev->data, len - sizeof(*ev));
+		set_discoverable_complete(sk, index, ev->data, len);
 		break;
 	case MGMT_OP_SET_CONNECTABLE:
-		set_connectable_complete(sk, ev->data, len - sizeof(*ev));
+		set_connectable_complete(sk, index, ev->data, len);
 		break;
 	case MGMT_OP_SET_PAIRABLE:
-		set_pairable_complete(sk, ev->data, len - sizeof(*ev));
+		set_pairable_complete(sk, index, ev->data, len);
 		break;
 	case MGMT_OP_ADD_UUID:
 		DBG("add_uuid complete");
@@ -1121,10 +1054,10 @@ static void mgmt_cmd_complete(int sk, void *buf, size_t len)
 		break;
 	case MGMT_OP_DISCONNECT:
 		DBG("disconnect complete");
-		disconnect_complete(sk, ev->data, len - sizeof(*ev));
+		disconnect_complete(sk, index, ev->data, len);
 		break;
 	case MGMT_OP_GET_CONNECTIONS:
-		get_connections_complete(sk, ev->data, len - sizeof(*ev));
+		get_connections_complete(sk, index, ev->data, len);
 		break;
 	case MGMT_OP_PIN_CODE_REPLY:
 		DBG("pin_code_reply complete");
@@ -1136,7 +1069,7 @@ static void mgmt_cmd_complete(int sk, void *buf, size_t len)
 		DBG("set_io_capability complete");
 		break;
 	case MGMT_OP_PAIR_DEVICE:
-		pair_device_complete(sk, ev->data, len - sizeof(*ev));
+		pair_device_complete(sk, index, ev->data, len);
 		break;
 	case MGMT_OP_USER_CONFIRM_REPLY:
 		DBG("user_confirm_reply complete");
@@ -1150,7 +1083,7 @@ static void mgmt_cmd_complete(int sk, void *buf, size_t len)
 	}
 }
 
-static void mgmt_cmd_status(int sk, void *buf, size_t len)
+static void mgmt_cmd_status(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_cmd_status *ev = buf;
 	uint16_t opcode;
@@ -1162,37 +1095,31 @@ static void mgmt_cmd_status(int sk, void *buf, size_t len)
 
 	opcode = btohs(bt_get_unaligned(&ev->opcode));
 
-	DBG("status %u opcode %u", ev->status, opcode);
+	DBG("status %u opcode %u (index %u)", ev->status, opcode, index);
 }
 
-static void mgmt_controller_error(int sk, void *buf, size_t len)
+static void mgmt_controller_error(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_controller_error *ev = buf;
-	uint16_t index;
 
 	if (len < sizeof(*ev)) {
 		error("Too small management controller error event packet");
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&ev->index));
-
 	DBG("index %u error_code %u", index, ev->error_code);
 }
 
-static void mgmt_auth_failed(int sk, void *buf, size_t len)
+static void mgmt_auth_failed(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct controller_info *info;
 	struct mgmt_ev_auth_failed *ev = buf;
-	uint16_t index;
 
 	if (len < sizeof(*ev)) {
 		error("Too small mgmt_auth_failed event packet");
 		return;
 	}
 
-	index = btohs(bt_get_unaligned(&ev->index));
-
 	DBG("hci%u auth failed status %u", index, ev->status);
 
 	if (index > max_index) {
@@ -1211,7 +1138,7 @@ static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data
 	struct mgmt_hdr *hdr = (void *) buf;
 	int sk;
 	ssize_t ret;
-	uint16_t len, opcode;
+	uint16_t len, opcode, index;
 
 	DBG("cond %d", cond);
 
@@ -1241,6 +1168,7 @@ static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data
 
 	opcode = btohs(bt_get_unaligned(&hdr->opcode));
 	len = btohs(bt_get_unaligned(&hdr->len));
+	index = btohs(bt_get_unaligned(&hdr->index));
 
 	if (ret != MGMT_HDR_SIZE + len) {
 		error("Packet length mismatch. ret %zd len %u", ret, len);
@@ -1249,55 +1177,55 @@ static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data
 
 	switch (opcode) {
 	case MGMT_EV_CMD_COMPLETE:
-		mgmt_cmd_complete(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_cmd_complete(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_CMD_STATUS:
-		mgmt_cmd_status(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_cmd_status(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_CONTROLLER_ERROR:
-		mgmt_controller_error(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_controller_error(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_INDEX_ADDED:
-		mgmt_index_added(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_index_added(sk, index);
 		break;
 	case MGMT_EV_INDEX_REMOVED:
-		mgmt_index_removed(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_index_removed(sk, index);
 		break;
 	case MGMT_EV_POWERED:
-		mgmt_powered(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_powered(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_DISCOVERABLE:
-		mgmt_discoverable(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_discoverable(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_CONNECTABLE:
-		mgmt_connectable(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_connectable(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_PAIRABLE:
-		mgmt_pairable(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_pairable(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_NEW_KEY:
-		mgmt_new_key(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_new_key(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_DEVICE_CONNECTED:
-		mgmt_device_connected(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_device_connected(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_DEVICE_DISCONNECTED:
-		mgmt_device_disconnected(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_device_disconnected(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_CONNECT_FAILED:
-		mgmt_connect_failed(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_connect_failed(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_PIN_CODE_REQUEST:
-		mgmt_pin_code_request(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_pin_code_request(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_USER_CONFIRM_REQUEST:
-		mgmt_user_confirm_request(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_user_confirm_request(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_AUTH_FAILED:
-		mgmt_auth_failed(sk, buf + MGMT_HDR_SIZE, len);
+		mgmt_auth_failed(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	default:
-		error("Unknown Management opcode %u", opcode);
+		error("Unknown Management opcode %u (index %u)", opcode, index);
 		break;
 	}
 
@@ -1328,6 +1256,7 @@ static int mgmt_setup(void)
 
 	memset(&hdr, 0, sizeof(hdr));
 	hdr.opcode = htobs(MGMT_OP_READ_VERSION);
+	hdr.index = htobs(MGMT_INDEX_NONE);
 	if (write(dd, &hdr, sizeof(hdr)) < 0) {
 		err = -errno;
 		goto fail;
@@ -1377,8 +1306,8 @@ static int mgmt_set_dev_class(int index, uint8_t major, uint8_t minor)
 	memset(buf, 0, sizeof(buf));
 	hdr->opcode = htobs(MGMT_OP_SET_DEV_CLASS);
 	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
 
-	cp->index = htobs(index);
 	cp->major = major;
 	cp->minor = minor;
 
@@ -1554,8 +1483,8 @@ static int mgmt_disconnect(int index, bdaddr_t *bdaddr)
 	memset(buf, 0, sizeof(buf));
 	hdr->opcode = htobs(MGMT_OP_DISCONNECT);
 	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
 
-	cp->index = htobs(index);
 	bacpy(&cp->bdaddr, bdaddr);
 
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
@@ -1577,8 +1506,8 @@ static int mgmt_remove_bonding(int index, bdaddr_t *bdaddr)
 	memset(buf, 0, sizeof(buf));
 	hdr->opcode = htobs(MGMT_OP_REMOVE_KEY);
 	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
 
-	cp->index = htobs(index);
 	bacpy(&cp->bdaddr, bdaddr);
 	cp->disconnect = 1;
 
@@ -1660,9 +1589,9 @@ static int mgmt_load_keys(int index, GSList *keys, gboolean debug_keys)
 	hdr = (void *) buf;
 	hdr->opcode = htobs(MGMT_OP_LOAD_KEYS);
 	hdr->len = htobs(cp_size);
+	hdr->index = htobs(index);
 
 	cp = (void *) (buf + sizeof(*hdr));
-	cp->index = htobs(index);
 	cp->debug_keys = debug_keys;
 	cp->key_count = htobs(key_count);
 
@@ -1696,8 +1625,8 @@ static int mgmt_set_io_capability(int index, uint8_t io_capability)
 	memset(buf, 0, sizeof(buf));
 	hdr->opcode = htobs(MGMT_OP_SET_IO_CAPABILITY);
 	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
 
-	cp->index = htobs(index);
 	cp->io_capability = io_capability;
 
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
@@ -1719,8 +1648,8 @@ static int mgmt_create_bonding(int index, bdaddr_t *bdaddr, uint8_t io_cap)
 	memset(buf, 0, sizeof(buf));
 	hdr->opcode = htobs(MGMT_OP_PAIR_DEVICE);
 	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
 
-	cp->index = htobs(index);
 	bacpy(&cp->bdaddr, bdaddr);
 	cp->io_cap = io_cap;
 
-- 
1.7.0.4
on behalf of ST-Ericsson
