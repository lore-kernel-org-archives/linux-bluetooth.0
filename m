Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v3 2/5] Bluetooth: Move address type macros to bluetooth.h
Date: Thu,  5 Apr 2012 14:17:18 -0300
Message-Id: <1333646241-12574-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1333646241-12574-1-git-send-email-andre.guedes@openbossa.org>
References: <1333646241-12574-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves address type macros to bluetooth.h since they will be
used by management interface and Bluetooth socket interface. It also
replaces the macro prefix MGMT_ADDR_ by BDADDR_.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/bluetooth.h |    5 +++++
 include/net/bluetooth/hci_core.h  |   16 ++++++----------
 net/bluetooth/mgmt.c              |   28 ++++++++++++++--------------
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index f2c8bdf..3fe927d 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -163,6 +163,11 @@ typedef struct {
 	__u8 b[6];
 } __packed bdaddr_t;
 
+/* BD Address type */
+#define BDADDR_BREDR		0x00
+#define BDADDR_LE_PUBLIC	0x01
+#define BDADDR_LE_RANDOM	0x02
+
 #define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0}})
 #define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c0b232c..43a97e4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -964,16 +964,12 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb);
 void hci_sock_dev_event(struct hci_dev *hdev, int event);
 
 /* Management interface */
-#define MGMT_ADDR_BREDR			0x00
-#define MGMT_ADDR_LE_PUBLIC		0x01
-#define MGMT_ADDR_LE_RANDOM		0x02
-
-#define DISCOV_TYPE_BREDR		(BIT(MGMT_ADDR_BREDR))
-#define DISCOV_TYPE_LE			(BIT(MGMT_ADDR_LE_PUBLIC) | \
-						BIT(MGMT_ADDR_LE_RANDOM))
-#define DISCOV_TYPE_INTERLEAVED		(BIT(MGMT_ADDR_BREDR) | \
-						BIT(MGMT_ADDR_LE_PUBLIC) | \
-						BIT(MGMT_ADDR_LE_RANDOM))
+#define DISCOV_TYPE_BREDR		(BIT(BDADDR_BREDR))
+#define DISCOV_TYPE_LE			(BIT(BDADDR_LE_PUBLIC) | \
+					 BIT(BDADDR_LE_RANDOM))
+#define DISCOV_TYPE_INTERLEAVED		(BIT(BDADDR_BREDR) | \
+					 BIT(BDADDR_LE_PUBLIC) | \
+					 BIT(BDADDR_LE_RANDOM))
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 int mgmt_index_added(struct hci_dev *hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4e7a01f..c6e70b6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1532,7 +1532,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	if (cp->addr.type == MGMT_ADDR_BREDR)
+	if (cp->addr.type == BDADDR_BREDR)
 		err = hci_remove_link_key(hdev, &cp->addr.bdaddr);
 	else
 		err = hci_remove_ltk(hdev, &cp->addr.bdaddr);
@@ -1544,7 +1544,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (cp->disconnect) {
-		if (cp->addr.type == MGMT_ADDR_BREDR)
+		if (cp->addr.type == BDADDR_BREDR)
 			conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
 							&cp->addr.bdaddr);
 		else
@@ -1604,7 +1604,7 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (cp->addr.type == MGMT_ADDR_BREDR)
+	if (cp->addr.type == BDADDR_BREDR)
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->addr.bdaddr);
 	else
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
@@ -1639,16 +1639,16 @@ static u8 link_to_mgmt(u8 link_type, u8 addr_type)
 	case LE_LINK:
 		switch (addr_type) {
 		case ADDR_LE_DEV_PUBLIC:
-			return MGMT_ADDR_LE_PUBLIC;
+			return BDADDR_LE_PUBLIC;
 
 		default:
 			/* Fallback to LE Random address type */
-			return MGMT_ADDR_LE_RANDOM;
+			return BDADDR_LE_RANDOM;
 		}
 
 	default:
 		/* Fallback to BR/EDR type */
-		return MGMT_ADDR_BREDR;
+		return BDADDR_BREDR;
 	}
 }
 
@@ -1910,7 +1910,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	else
 		auth_type = HCI_AT_DEDICATED_BONDING_MITM;
 
-	if (cp->addr.type == MGMT_ADDR_BREDR)
+	if (cp->addr.type == BDADDR_BREDR)
 		conn = hci_connect(hdev, ACL_LINK, &cp->addr.bdaddr, sec_level,
 				   auth_type);
 	else
@@ -1943,7 +1943,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	/* For LE, just connecting isn't a proof that the pairing finished */
-	if (cp->addr.type == MGMT_ADDR_BREDR)
+	if (cp->addr.type == BDADDR_BREDR)
 		conn->connect_cfm_cb = pairing_complete_cb;
 
 	conn->security_cfm_cb = pairing_complete_cb;
@@ -2020,7 +2020,7 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 		goto done;
 	}
 
-	if (type == MGMT_ADDR_BREDR)
+	if (type == BDADDR_BREDR)
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
 	else
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, bdaddr);
@@ -2031,7 +2031,7 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 		goto done;
 	}
 
-	if (type == MGMT_ADDR_LE_PUBLIC || type == MGMT_ADDR_LE_RANDOM) {
+	if (type == BDADDR_LE_PUBLIC || type == BDADDR_LE_RANDOM) {
 		/* Continue with pairing via SMP */
 		err = smp_user_confirm_reply(conn, mgmt_op, passkey);
 
@@ -2962,7 +2962,7 @@ int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key, u8 persistent)
 
 	ev.store_hint = persistent;
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = MGMT_ADDR_BREDR;
+	ev.key.addr.type = BDADDR_BREDR;
 	ev.key.type = key->type;
 	memcpy(ev.key.val, key->val, 16);
 	ev.key.pin_len = key->pin_len;
@@ -3120,7 +3120,7 @@ int mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure)
 	struct mgmt_ev_pin_code_request ev;
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
-	ev.addr.type = MGMT_ADDR_BREDR;
+	ev.addr.type = BDADDR_BREDR;
 	ev.secure = secure;
 
 	return mgmt_event(MGMT_EV_PIN_CODE_REQUEST, hdev, &ev, sizeof(ev),
@@ -3139,7 +3139,7 @@ int mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		return -ENOENT;
 
 	bacpy(&rp.addr.bdaddr, bdaddr);
-	rp.addr.type = MGMT_ADDR_BREDR;
+	rp.addr.type = BDADDR_BREDR;
 
 	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
 			   mgmt_status(status), &rp, sizeof(rp));
@@ -3161,7 +3161,7 @@ int mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		return -ENOENT;
 
 	bacpy(&rp.addr.bdaddr, bdaddr);
-	rp.addr.type = MGMT_ADDR_BREDR;
+	rp.addr.type = BDADDR_BREDR;
 
 	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_NEG_REPLY,
 			   mgmt_status(status), &rp, sizeof(rp));
-- 
1.7.9.4

