Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Create a unique mgmt error code hierarchy
Date: Fri, 11 Nov 2011 18:10:00 +0200
Message-Id: <1321027800-353-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1321021134-31809-2-git-send-email-johan.hedberg@gmail.com>
References: <1321021134-31809-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The management protocol uses a single byte for error codes (aka command
status). In some places this value is directly copied from HCI and in
other a POSIX error number is used. This makes it impossible for
user-space to uniquily decipher the meaning of an error.

To solve this issue a new mgmt-specific set of error codes is added
along with a conversion table for HCI status values.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: Use ARRAY_SIZE() instead of a custom NELEM()

 include/net/bluetooth/mgmt.h |   17 +++
 net/bluetooth/mgmt.c         |  315 ++++++++++++++++++++++++++++++------------
 2 files changed, 241 insertions(+), 91 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index bfdb04b..bd6995d 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -23,6 +23,23 @@
 
 #define MGMT_INDEX_NONE			0xFFFF
 
+#define MGMT_STATUS_SUCCESS		0x00
+#define MGMT_STATUS_UNKNOWN_COMMAND	0x01
+#define MGMT_STATUS_NOT_CONNECTED	0x02
+#define MGMT_STATUS_FAILED		0x03
+#define MGMT_STATUS_CONNECT_FAILED	0x04
+#define MGMT_STATUS_AUTH_FAILED		0x05
+#define MGMT_STATUS_NOT_PAIRED		0x06
+#define MGMT_STATUS_NO_RESOURCES	0x07
+#define MGMT_STATUS_TIMEOUT		0x08
+#define MGMT_STATUS_ALREADY_CONNECTED	0x09
+#define MGMT_STATUS_BUSY		0x0a
+#define MGMT_STATUS_REJECTED		0x0b
+#define MGMT_STATUS_NOT_SUPPORTED	0x0c
+#define MGMT_STATUS_INVALID_PARAMS	0x0d
+#define MGMT_STATUS_DISCONNECTED	0x0e
+#define MGMT_STATUS_NOT_POWERED		0x0f
+
 struct mgmt_hdr {
 	__le16 opcode;
 	__le16 index;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 52f85ec..8fc2ea8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -22,6 +22,7 @@
 
 /* Bluetooth HCI Management interface */
 
+#include <linux/kernel.h>
 #include <linux/uaccess.h>
 #include <asm/unaligned.h>
 
@@ -43,6 +44,79 @@ struct pending_cmd {
 	void *user_data;
 };
 
+/* HCI to MGMT error code conversion table */
+static u8 mgmt_status_table[] = {
+	MGMT_STATUS_SUCCESS,
+	MGMT_STATUS_UNKNOWN_COMMAND,	/* Unknown Command */
+	MGMT_STATUS_NOT_CONNECTED,	/* No Connection */
+	MGMT_STATUS_FAILED,		/* Hardware Failure */
+	MGMT_STATUS_CONNECT_FAILED,	/* Page Timeout */
+	MGMT_STATUS_AUTH_FAILED,	/* Authentication Failed */
+	MGMT_STATUS_NOT_PAIRED,		/* PIN or Key Missing */
+	MGMT_STATUS_NO_RESOURCES,	/* Memory Full */
+	MGMT_STATUS_TIMEOUT,		/* Connection Timeout */
+	MGMT_STATUS_NO_RESOURCES,	/* Max Number of Connections */
+	MGMT_STATUS_NO_RESOURCES,	/* Max Number of SCO Connections */
+	MGMT_STATUS_ALREADY_CONNECTED,	/* ACL Connection Exists */
+	MGMT_STATUS_BUSY,		/* Command Disallowed */
+	MGMT_STATUS_NO_RESOURCES,	/* Rejected Limited Resources */
+	MGMT_STATUS_REJECTED,		/* Rejected Security */
+	MGMT_STATUS_REJECTED,		/* Rejected Personal */
+	MGMT_STATUS_TIMEOUT,		/* Host Timeout */
+	MGMT_STATUS_NOT_SUPPORTED,	/* Unsupported Feature */
+	MGMT_STATUS_INVALID_PARAMS,	/* Invalid Parameters */
+	MGMT_STATUS_DISCONNECTED,	/* OE User Ended Connection */
+	MGMT_STATUS_NO_RESOURCES,	/* OE Low Resources */
+	MGMT_STATUS_DISCONNECTED,	/* OE Power Off */
+	MGMT_STATUS_DISCONNECTED,	/* Connection Terminated */
+	MGMT_STATUS_BUSY,		/* Repeated Attempts */
+	MGMT_STATUS_REJECTED,		/* Pairing Not Allowed */
+	MGMT_STATUS_FAILED,		/* Unknown LMP PDU */
+	MGMT_STATUS_NOT_SUPPORTED,	/* Unsupported Remote Feature */
+	MGMT_STATUS_REJECTED,		/* SCO Offset Rejected */
+	MGMT_STATUS_REJECTED,		/* SCO Interval Rejected */
+	MGMT_STATUS_REJECTED,		/* Air Mode Rejected */
+	MGMT_STATUS_INVALID_PARAMS,	/* Invalid LMP Parameters */
+	MGMT_STATUS_FAILED,		/* Unspecified Error */
+	MGMT_STATUS_NOT_SUPPORTED,	/* Unsupported LMP Parameter Value */
+	MGMT_STATUS_FAILED,		/* Role Change Not Allowed */
+	MGMT_STATUS_TIMEOUT,		/* LMP Response Timeout */
+	MGMT_STATUS_FAILED,		/* LMP Error Transaction Collision */
+	MGMT_STATUS_FAILED,		/* LMP PDU Not Allowed */
+	MGMT_STATUS_REJECTED,		/* Encryption Mode Not Accepted */
+	MGMT_STATUS_FAILED,		/* Unit Link Key Used */
+	MGMT_STATUS_NOT_SUPPORTED,	/* QoS Not Supported */
+	MGMT_STATUS_TIMEOUT,		/* Instant Passed */
+	MGMT_STATUS_NOT_SUPPORTED,	/* Pairing Not Supported */
+	MGMT_STATUS_FAILED,		/* Transaction Collision */
+	MGMT_STATUS_INVALID_PARAMS,	/* Unacceptable Parameter */
+	MGMT_STATUS_REJECTED,		/* QoS Rejected */
+	MGMT_STATUS_NOT_SUPPORTED,	/* Classification Not Supported */
+	MGMT_STATUS_REJECTED,		/* Insufficient Security */
+	MGMT_STATUS_INVALID_PARAMS,	/* Parameter Out Of Range */
+	MGMT_STATUS_BUSY,		/* Role Switch Pending */
+	MGMT_STATUS_FAILED,		/* Slot Violation */
+	MGMT_STATUS_FAILED,		/* Role Switch Failed */
+	MGMT_STATUS_INVALID_PARAMS,	/* EIR Too Large */
+	MGMT_STATUS_NOT_SUPPORTED,	/* Simple Pairing Not Supported */
+	MGMT_STATUS_BUSY,		/* Host Busy Pairing */
+	MGMT_STATUS_REJECTED,		/* Rejected, No Suitable Channel */
+	MGMT_STATUS_BUSY,		/* Controller Busy */
+	MGMT_STATUS_INVALID_PARAMS,	/* Unsuitable Connection Interval */
+	MGMT_STATUS_TIMEOUT,		/* Directed Advertising Timeout */
+	MGMT_STATUS_AUTH_FAILED,	/* Terminated Due to MIC Failure */
+	MGMT_STATUS_CONNECT_FAILED,	/* Connection Establishment Failed */
+	MGMT_STATUS_CONNECT_FAILED,	/* MAC Connection Failed */
+};
+
+static u8 mgmt_status(u8 hci_status)
+{
+	if (hci_status < ARRAY_SIZE(mgmt_status_table))
+		return mgmt_status_table[hci_status];
+
+	return MGMT_STATUS_FAILED;
+}
+
 static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 {
 	struct sk_buff *skb;
@@ -177,7 +251,8 @@ static int read_controller_info(struct sock *sk, u16 index)
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_READ_INFO, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_READ_INFO,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
 		cancel_delayed_work_sync(&hdev->power_off);
@@ -311,11 +386,13 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	BT_DBG("request for hci%u", index);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_POWERED, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_SET_POWERED,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_POWERED, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_POWERED,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
@@ -326,7 +403,8 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_POWERED, hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_POWERED, EBUSY);
+		err = cmd_status(sk, index, MGMT_OP_SET_POWERED,
+							MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
@@ -363,22 +441,26 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 	BT_DBG("request for hci%u", index);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, ENETDOWN);
+		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
+						MGMT_STATUS_NOT_POWERED);
 		goto failed;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev) ||
 			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, EBUSY);
+		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
+							MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
@@ -430,22 +512,26 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
 	BT_DBG("request for hci%u", index);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, ENETDOWN);
+		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE,
+						MGMT_STATUS_NOT_POWERED);
 		goto failed;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev) ||
 			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, EBUSY);
+		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE,
+							MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
@@ -518,11 +604,13 @@ static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
 	BT_DBG("request for hci%u", index);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_PAIRABLE, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_SET_PAIRABLE,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_PAIRABLE, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_PAIRABLE,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
@@ -731,11 +819,13 @@ static int add_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	BT_DBG("request for hci%u", index);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_ADD_UUID, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_ADD_UUID,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_ADD_UUID, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_ADD_UUID,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
@@ -780,11 +870,13 @@ static int remove_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	BT_DBG("request for hci%u", index);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_REMOVE_UUID, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_REMOVE_UUID,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_REMOVE_UUID, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_REMOVE_UUID,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
@@ -806,7 +898,8 @@ static int remove_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	}
 
 	if (found == 0) {
-		err = cmd_status(sk, index, MGMT_OP_REMOVE_UUID, ENOENT);
+		err = cmd_status(sk, index, MGMT_OP_REMOVE_UUID,
+						MGMT_STATUS_INVALID_PARAMS);
 		goto unlock;
 	}
 
@@ -839,11 +932,13 @@ static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
 	BT_DBG("request for hci%u", index);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
@@ -871,11 +966,13 @@ static int set_service_cache(struct sock *sk, u16 index,  unsigned char *data,
 	cp = (void *) data;
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
@@ -915,7 +1012,8 @@ static int load_link_keys(struct sock *sk, u16 index, unsigned char *data,
 	cp = (void *) data;
 
 	if (len < sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_LOAD_LINK_KEYS, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_LOAD_LINK_KEYS,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	key_count = get_unaligned_le16(&cp->key_count);
 
@@ -924,12 +1022,14 @@ static int load_link_keys(struct sock *sk, u16 index, unsigned char *data,
 	if (expected_len != len) {
 		BT_ERR("load_link_keys: expected %u bytes, got %u bytes",
 							len, expected_len);
-		return cmd_status(sk, index, MGMT_OP_LOAD_LINK_KEYS, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_LOAD_LINK_KEYS,
+						MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_LOAD_LINK_KEYS, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_LOAD_LINK_KEYS,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	BT_DBG("hci%u debug_keys %u key_count %u", index, cp->debug_keys,
 								key_count);
@@ -972,20 +1072,25 @@ static int remove_keys(struct sock *sk, u16 index, unsigned char *data,
 	cp = (void *) data;
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_REMOVE_KEYS, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_REMOVE_KEYS,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_REMOVE_KEYS, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_REMOVE_KEYS,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
 	memset(&rp, 0, sizeof(rp));
 	bacpy(&rp.bdaddr, &cp->bdaddr);
+	rp.status = MGMT_STATUS_FAILED;
 
 	err = hci_remove_link_key(hdev, &cp->bdaddr);
-	if (err < 0)
+	if (err < 0) {
+		rp.status = MGMT_STATUS_NOT_PAIRED;
 		goto unlock;
+	}
 
 	if (!test_bit(HCI_UP, &hdev->flags) || !cp->disconnect) {
 		err = cmd_complete(sk, index, MGMT_OP_REMOVE_KEYS, &rp,
@@ -1013,11 +1118,9 @@ static int remove_keys(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 unlock:
-	if (err < 0) {
-		rp.status = -err;
+	if (err < 0)
 		err = cmd_complete(sk, index, MGMT_OP_REMOVE_KEYS, &rp,
 								sizeof(rp));
-	}
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
@@ -1038,21 +1141,25 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	cp = (void *) data;
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_DISCONNECT, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_DISCONNECT,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_DISCONNECT, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_DISCONNECT,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, index, MGMT_OP_DISCONNECT, ENETDOWN);
+		err = cmd_status(sk, index, MGMT_OP_DISCONNECT,
+						MGMT_STATUS_NOT_POWERED);
 		goto failed;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_DISCONNECT, hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_DISCONNECT, EBUSY);
+		err = cmd_status(sk, index, MGMT_OP_DISCONNECT,
+							MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
@@ -1061,7 +1168,8 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
 
 	if (!conn) {
-		err = cmd_status(sk, index, MGMT_OP_DISCONNECT, ENOTCONN);
+		err = cmd_status(sk, index, MGMT_OP_DISCONNECT,
+						MGMT_STATUS_NOT_CONNECTED);
 		goto failed;
 	}
 
@@ -1118,7 +1226,8 @@ static int get_connections(struct sock *sk, u16 index)
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_GET_CONNECTIONS, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_GET_CONNECTIONS,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
@@ -1192,22 +1301,26 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 	cp = (void *) data;
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY, ENETDOWN);
+		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
+						MGMT_STATUS_NOT_POWERED);
 		goto failed;
 	}
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
 	if (!conn) {
-		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY, ENOTCONN);
+		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
+						MGMT_STATUS_NOT_CONNECTED);
 		goto failed;
 	}
 
@@ -1219,7 +1332,7 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 		err = send_pin_code_neg_reply(sk, index, hdev, &ncp);
 		if (err >= 0)
 			err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
-								EINVAL);
+						MGMT_STATUS_INVALID_PARAMS);
 
 		goto failed;
 	}
@@ -1258,18 +1371,18 @@ static int pin_code_neg_reply(struct sock *sk, u16 index, unsigned char *data,
 
 	if (len != sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
-									EINVAL);
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
-									ENODEV);
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
-								ENETDOWN);
+						MGMT_STATUS_NOT_POWERED);
 		goto failed;
 	}
 
@@ -1293,11 +1406,13 @@ static int set_io_capability(struct sock *sk, u16 index, unsigned char *data,
 	cp = (void *) data;
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
@@ -1379,11 +1494,13 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	cp = (void *) data;
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
@@ -1468,11 +1585,13 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
 	}
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, mgmt_op, EINVAL);
+		return cmd_status(sk, index, mgmt_op,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, mgmt_op, ENODEV);
+		return cmd_status(sk, index, mgmt_op,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
@@ -1510,11 +1629,13 @@ static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
 	BT_DBG("");
 
 	if (len != sizeof(*mgmt_cp))
-		return cmd_status(sk, index, MGMT_OP_SET_LOCAL_NAME, EINVAL);
+		return cmd_status(sk, index, MGMT_OP_SET_LOCAL_NAME,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_LOCAL_NAME, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_LOCAL_NAME,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
@@ -1548,24 +1669,25 @@ static int read_local_oob_data(struct sock *sk, u16 index)
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
-									ENODEV);
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
-								ENETDOWN);
+						MGMT_STATUS_NOT_POWERED);
 		goto unlock;
 	}
 
 	if (!(hdev->features[6] & LMP_SIMPLE_PAIR)) {
 		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
-								EOPNOTSUPP);
+						MGMT_STATUS_NOT_SUPPORTED);
 		goto unlock;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA, EBUSY);
+		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
+							MGMT_STATUS_BUSY);
 		goto unlock;
 	}
 
@@ -1597,19 +1719,20 @@ static int add_remote_oob_data(struct sock *sk, u16 index, unsigned char *data,
 
 	if (len != sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
-									EINVAL);
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
-									ENODEV);
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
 	err = hci_add_remote_oob_data(hdev, &cp->bdaddr, cp->hash,
 								cp->randomizer);
 	if (err < 0)
-		err = cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA, -err);
+		err = cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
+							MGMT_STATUS_FAILED);
 	else
 		err = cmd_complete(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA, NULL,
 									0);
@@ -1631,19 +1754,19 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 
 	if (len != sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
-									EINVAL);
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
-									ENODEV);
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
 	err = hci_remove_remote_oob_data(hdev, &cp->bdaddr);
 	if (err < 0)
 		err = cmd_status(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
-									-err);
+						MGMT_STATUS_INVALID_PARAMS);
 	else
 		err = cmd_complete(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
 								NULL, 0);
@@ -1664,12 +1787,14 @@ static int start_discovery(struct sock *sk, u16 index)
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_START_DISCOVERY, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY, ENETDOWN);
+		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
+						MGMT_STATUS_NOT_POWERED);
 		goto failed;
 	}
 
@@ -1700,7 +1825,8 @@ static int stop_discovery(struct sock *sk, u16 index)
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
@@ -1732,18 +1858,19 @@ static int block_device(struct sock *sk, u16 index, unsigned char *data,
 
 	if (len != sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE,
-							EINVAL);
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE,
-							ENODEV);
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
 	err = hci_blacklist_add(hdev, &cp->bdaddr);
 	if (err < 0)
-		err = cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE, -err);
+		err = cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE,
+							MGMT_STATUS_FAILED);
 	else
 		err = cmd_complete(sk, index, MGMT_OP_BLOCK_DEVICE,
 							NULL, 0);
@@ -1765,19 +1892,20 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 
 	if (len != sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE,
-								EINVAL);
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE,
-								ENODEV);
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock_bh(hdev);
 
 	err = hci_blacklist_del(hdev, &cp->bdaddr);
 
 	if (err < 0)
-		err = cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE, -err);
+		err = cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS);
 	else
 		err = cmd_complete(sk, index, MGMT_OP_UNBLOCK_DEVICE,
 								NULL, 0);
@@ -1801,12 +1929,12 @@ static int set_fast_connectable(struct sock *sk, u16 index,
 
 	if (len != sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
-								EINVAL);
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
-								ENODEV);
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
@@ -1824,14 +1952,14 @@ static int set_fast_connectable(struct sock *sk, u16 index,
 						sizeof(acp), &acp);
 	if (err < 0) {
 		err = cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
-								-err);
+							MGMT_STATUS_FAILED);
 		goto done;
 	}
 
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
 	if (err < 0) {
 		err = cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
-								-err);
+							MGMT_STATUS_FAILED);
 		goto done;
 	}
 
@@ -1970,7 +2098,8 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
-		err = cmd_status(sk, index, opcode, 0x01);
+		err = cmd_status(sk, index, opcode,
+						MGMT_STATUS_UNKNOWN_COMMAND);
 		break;
 	}
 
@@ -2093,13 +2222,15 @@ int mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 
 int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
 {
+	u8 mgmt_err = mgmt_status(status);
+
 	if (scan & SCAN_PAGE)
 		mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, hdev,
-						cmd_status_rsp, &status);
+						cmd_status_rsp, &mgmt_err);
 
 	if (scan & SCAN_INQUIRY)
 		mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, hdev,
-						cmd_status_rsp, &status);
+						cmd_status_rsp, &mgmt_err);
 
 	return 0;
 }
@@ -2190,6 +2321,7 @@ int mgmt_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status)
 {
 	struct pending_cmd *cmd;
+	u8 mgmt_err = mgmt_status(status);
 	int err;
 
 	cmd = mgmt_pending_find(MGMT_OP_DISCONNECT, hdev);
@@ -2206,7 +2338,7 @@ int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status)
 							&rp, sizeof(rp));
 	} else
 		err = cmd_status(cmd->sk, hdev->id, MGMT_OP_DISCONNECT,
-								status);
+								mgmt_err);
 
 	mgmt_pending_remove(cmd);
 
@@ -2220,7 +2352,7 @@ int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_mgmt(link_type, addr_type);
-	ev.status = status;
+	ev.status = mgmt_status(status);
 
 	return mgmt_event(MGMT_EV_CONNECT_FAILED, hdev, &ev, sizeof(ev), NULL);
 }
@@ -2248,7 +2380,7 @@ int mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		return -ENOENT;
 
 	bacpy(&rp.bdaddr, bdaddr);
-	rp.status = status;
+	rp.status = mgmt_status(status);
 
 	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_REPLY, &rp,
 								sizeof(rp));
@@ -2270,7 +2402,7 @@ int mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		return -ENOENT;
 
 	bacpy(&rp.bdaddr, bdaddr);
-	rp.status = status;
+	rp.status = mgmt_status(status);
 
 	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_NEG_REPLY, &rp,
 								sizeof(rp));
@@ -2307,7 +2439,7 @@ static int confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		return -ENOENT;
 
 	bacpy(&rp.bdaddr, bdaddr);
-	rp.status = status;
+	rp.status = mgmt_status(status);
 	err = cmd_complete(cmd->sk, hdev->id, opcode, &rp, sizeof(rp));
 
 	mgmt_pending_remove(cmd);
@@ -2318,14 +2450,14 @@ static int confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 int mgmt_user_confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 								u8 status)
 {
-	return confirm_reply_complete(hdev, bdaddr, status,
+	return confirm_reply_complete(hdev, bdaddr, mgmt_status(status),
 						MGMT_OP_USER_CONFIRM_REPLY);
 }
 
 int mgmt_user_confirm_neg_reply_complete(struct hci_dev *hdev,
 						bdaddr_t *bdaddr, u8 status)
 {
-	return confirm_reply_complete(hdev, bdaddr, status,
+	return confirm_reply_complete(hdev, bdaddr, mgmt_status(status),
 					MGMT_OP_USER_CONFIRM_NEG_REPLY);
 }
 
@@ -2334,7 +2466,7 @@ int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status)
 	struct mgmt_ev_auth_failed ev;
 
 	bacpy(&ev.bdaddr, bdaddr);
-	ev.status = status;
+	ev.status = mgmt_status(status);
 
 	return mgmt_event(MGMT_EV_AUTH_FAILED, hdev, &ev, sizeof(ev), NULL);
 }
@@ -2354,7 +2486,7 @@ int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 
 	if (status) {
 		err = cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
-									EIO);
+							mgmt_status(status));
 		goto failed;
 	}
 
@@ -2389,7 +2521,8 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 
 	if (status) {
 		err = cmd_status(cmd->sk, hdev->id,
-					MGMT_OP_READ_LOCAL_OOB_DATA, EIO);
+						MGMT_OP_READ_LOCAL_OOB_DATA,
+						mgmt_status(status));
 	} else {
 		struct mgmt_rp_read_local_oob_data rp;
 
@@ -2447,7 +2580,7 @@ int mgmt_inquiry_failed(struct hci_dev *hdev, u8 status)
 	if (!cmd)
 		return -ENOENT;
 
-	err = cmd_status(cmd->sk, hdev->id, cmd->opcode, status);
+	err = cmd_status(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status));
 	mgmt_pending_remove(cmd);
 
 	return err;
-- 
1.7.7.2

