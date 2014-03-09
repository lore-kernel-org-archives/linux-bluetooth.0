Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for handling signature resolving keys
Date: Sun,  9 Mar 2014 12:19:17 -0700
Message-Id: <1394392757-49734-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The connection signature resolving key (CSRK) is used for attribute
protocol signed write procedures. This change generates a new local
key during pairing and requests the peer key as well.

Newly generated key and received key will be provided to userspace
using the New Signature Resolving Key management event.

The Master CSRK can be used for verification of remote signed write
PDUs and the Slave CSRK can be used for sending signed write PDUs
to the remote device.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  8 +++++
 include/net/bluetooth/mgmt.h     | 12 +++++++
 net/bluetooth/mgmt.c             | 30 ++++++++++++++++++
 net/bluetooth/smp.c              | 67 +++++++++++++++++++++++++++++++++++++---
 net/bluetooth/smp.h              |  2 ++
 5 files changed, 114 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dbb788e4f265..e869884fbfa9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -91,6 +91,13 @@ struct bt_uuid {
 	u8 svc_hint;
 };
 
+struct smp_csrk {
+	bdaddr_t bdaddr;
+	u8 bdaddr_type;
+	u8 master;
+	u8 val[16];
+};
+
 struct smp_ltk {
 	struct list_head list;
 	bdaddr_t bdaddr;
@@ -1265,6 +1272,7 @@ int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key);
 void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk);
+void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk);
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 0326648fd799..d4b571c2f9fd 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -551,3 +551,15 @@ struct mgmt_ev_new_irk {
 	bdaddr_t rpa;
 	struct mgmt_irk_info irk;
 } __packed;
+
+struct mgmt_csrk_info {
+	struct mgmt_addr_info addr;
+	__u8 master;
+	__u8 val[16];
+} __packed;
+
+#define MGMT_EV_NEW_CSRK		0x0019
+struct mgmt_ev_new_csrk {
+	__u8 store_hint;
+	struct mgmt_csrk_info key;
+} __packed;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f2397e7ad385..9c7788914b4e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -108,6 +108,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_DEVICE_UNPAIRED,
 	MGMT_EV_PASSKEY_NOTIFY,
 	MGMT_EV_NEW_IRK,
+	MGMT_EV_NEW_CSRK,
 };
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
@@ -5072,6 +5073,35 @@ void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk)
 	mgmt_event(MGMT_EV_NEW_IRK, hdev, &ev, sizeof(ev), NULL);
 }
 
+void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk)
+{
+	struct mgmt_ev_new_csrk ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	/* Devices using resolvable or non-resolvable random addresses
+	 * without providing an indentity resolving key don't require
+	 * to store signature resolving keys. Their addresses will change
+	 * the next time around.
+	 *
+	 * Only when a remote device provides an identity address
+	 * make sure the signature resolving key is stored. So allow
+	 * static random and public addresses here.
+	 */
+	if (csrk->bdaddr_type == ADDR_LE_DEV_RANDOM &&
+	    (csrk->bdaddr.b[5] & 0xc0) != 0xc0)
+		ev.store_hint = 0x00;
+	else
+		ev.store_hint = 0x01;
+
+	bacpy(&ev.key.addr.bdaddr, &csrk->bdaddr);
+	ev.key.addr.type = link_to_bdaddr(LE_LINK, csrk->bdaddr_type);
+	ev.key.master = csrk->master;
+	memcpy(ev.key.val, csrk->val, sizeof(csrk->val));
+
+	mgmt_event(MGMT_EV_NEW_CSRK, hdev, &ev, sizeof(ev), NULL);
+}
+
 static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 				  u8 data_len)
 {
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f886bcae1b7e..fc652592daf6 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -273,8 +273,8 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	u8 local_dist = 0, remote_dist = 0;
 
 	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->dev_flags)) {
-		local_dist = SMP_DIST_ENC_KEY;
-		remote_dist = SMP_DIST_ENC_KEY;
+		local_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
+		remote_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
 		authreq |= SMP_AUTH_BONDING;
 	} else {
 		authreq &= ~SMP_AUTH_BONDING;
@@ -596,6 +596,9 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 	complete = test_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
 	mgmt_smp_complete(conn->hcon, complete);
 
+	kfree(smp->csrk);
+	kfree(smp->slave_csrk);
+
 	/* If pairing failed clean up any keys we might have */
 	if (!complete) {
 		if (smp->ltk) {
@@ -1065,6 +1068,41 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	return 0;
 }
 
+static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct smp_cmd_sign_info *rp = (void *) skb->data;
+	struct smp_chan *smp = conn->smp_chan;
+	struct hci_dev *hdev = conn->hcon->hdev;
+	struct smp_csrk *csrk;
+
+	BT_DBG("conn %p", conn);
+
+	if (skb->len < sizeof(*rp))
+		return SMP_UNSPECIFIED;
+
+	/* Ignore this PDU if it wasn't requested */
+	if (!(smp->remote_key_dist & SMP_DIST_SIGN))
+		return 0;
+
+	/* Mark the information as received */
+	smp->remote_key_dist &= ~SMP_DIST_SIGN;
+
+	skb_pull(skb, sizeof(*rp));
+
+	hci_dev_lock(hdev);
+	csrk = kzalloc(sizeof(*csrk), GFP_KERNEL);
+	if (csrk) {
+		csrk->master = 0x01;
+		memcpy(csrk->val, rp->csrk, sizeof(csrk->val));
+	}
+	smp->csrk = csrk;
+	if (!(smp->remote_key_dist & SMP_DIST_SIGN))
+		smp_distribute_keys(conn);
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
 int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct hci_conn *hcon = conn->hcon;
@@ -1147,8 +1185,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 		break;
 
 	case SMP_CMD_SIGN_INFO:
-		/* Just ignored */
-		reason = 0;
+		reason = smp_cmd_sign_info(conn, skb);
 		break;
 
 	default:
@@ -1176,6 +1213,18 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	if (smp->remote_irk)
 		mgmt_new_irk(hdev, smp->remote_irk);
 
+	if (smp->csrk) {
+		smp->csrk->bdaddr_type = hcon->dst_type;
+		bacpy(&smp->csrk->bdaddr, &hcon->dst);
+		mgmt_new_csrk(hdev, smp->csrk);
+	}
+
+	if (smp->slave_csrk) {
+		smp->slave_csrk->bdaddr_type = hcon->dst_type;
+		bacpy(&smp->slave_csrk->bdaddr, &hcon->dst);
+		mgmt_new_csrk(hdev, smp->slave_csrk);
+	}
+
 	if (smp->ltk) {
 		smp->ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->ltk->bdaddr, &hcon->dst);
@@ -1274,10 +1323,18 @@ int smp_distribute_keys(struct l2cap_conn *conn)
 
 	if (*keydist & SMP_DIST_SIGN) {
 		struct smp_cmd_sign_info sign;
+		struct smp_csrk *csrk;
 
-		/* Send a dummy key */
+		/* Generate a new random key */
 		get_random_bytes(sign.csrk, sizeof(sign.csrk));
 
+		csrk = kzalloc(sizeof(*csrk), GFP_KERNEL);
+		if (csrk) {
+			csrk->master = 0x00;
+			memcpy(csrk->val, sign.csrk, sizeof(csrk->val));
+		}
+		smp->slave_csrk = csrk;
+
 		smp_send_cmd(conn, SMP_CMD_SIGN_INFO, sizeof(sign), &sign);
 
 		*keydist &= ~SMP_DIST_SIGN;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index f55d83617218..f223b9d38b61 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -136,6 +136,8 @@ struct smp_chan {
 	bdaddr_t	id_addr;
 	u8		id_addr_type;
 	u8		irk[16];
+	struct smp_csrk	*csrk;
+	struct smp_csrk	*slave_csrk;
 	struct smp_ltk	*ltk;
 	struct smp_ltk	*slave_ltk;
 	struct smp_irk	*remote_irk;
-- 
1.8.5.3

