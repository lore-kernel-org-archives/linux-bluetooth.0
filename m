Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/15] Bluetooth: Merge boolean members of struct hci_conn into flags
Date: Wed, 18 Jan 2012 20:51:51 +0200
Message-Id: <1326912717-6347-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that the flags member of struct hci_conn is supposed to accommodate
any boolean type values we can easily merge all boolean members into it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    6 +++---
 net/bluetooth/hci_conn.c         |   15 +++++++++------
 net/bluetooth/hci_event.c        |   21 +++++++++++++--------
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c8ae176..5f6cb35 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -286,7 +286,6 @@ struct hci_conn {
 	__u8		attempt;
 	__u8		dev_class[3];
 	__u8		features[8];
-	__u8		ssp_mode;
 	__u16		interval;
 	__u16		pkt_type;
 	__u16		link_policy;
@@ -298,12 +297,10 @@ struct hci_conn {
 	__u8		pin_length;
 	__u8		enc_key_size;
 	__u8		io_capability;
-	__u8		power_save;
 	__u16		disc_timeout;
 	unsigned long	flags;
 
 	__u8		remote_cap;
-	__u8		remote_oob;
 	__u8		remote_auth;
 
 	unsigned int	sent;
@@ -409,6 +406,9 @@ enum {
 	HCI_CONN_MODE_CHANGE_PEND,
 	HCI_CONN_SCO_SETUP_PEND,
 	HCI_CONN_LE_SMP_PEND,
+	HCI_CONN_SSP_SUPPORT,
+	HCI_CONN_POWER_SAVE,
+	HCI_CONN_REMOTE_OOB,
 };
 
 static inline void hci_conn_hash_init(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8a4678a..566254f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -105,7 +105,8 @@ void hci_acl_connect(struct hci_conn *conn)
 		}
 
 		memcpy(conn->dev_class, ie->data.dev_class, 3);
-		conn->ssp_mode = ie->data.ssp_mode;
+		if (ie->data.ssp_mode > 0)
+			set_bit(HCI_CONN_SSP_SUPPORT, &conn->flags);
 	}
 
 	cp.pkt_type = cpu_to_le16(conn->pkt_type);
@@ -386,7 +387,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	conn->remote_auth = 0xff;
 	conn->key_type = 0xff;
 
-	conn->power_save = 1;
+	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 
 	switch (type) {
@@ -586,7 +587,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 
 	if (acl->state == BT_CONNECTED &&
 			(sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
-		acl->power_save = 1;
+		set_bit(HCI_CONN_POWER_SAVE, &acl->flags);
 		hci_conn_enter_active_mode(acl, BT_POWER_FORCE_ACTIVE_ON);
 
 		if (test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->flags)) {
@@ -607,7 +608,8 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 {
 	BT_DBG("conn %p", conn);
 
-	if (conn->ssp_mode > 0 && conn->hdev->ssp_mode > 0 &&
+	if (test_bit(HCI_CONN_SSP_SUPPORT, &conn->flags) &&
+					conn->hdev->ssp_mode > 0 &&
 					!(conn->link_mode & HCI_LM_ENCRYPT))
 		return 0;
 
@@ -671,7 +673,8 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 	/* For non 2.1 devices and low security level we don't need the link
 	   key. */
 	if (sec_level == BT_SECURITY_LOW &&
-				(!conn->ssp_mode || !conn->hdev->ssp_mode))
+			(!test_bit(HCI_CONN_SSP_SUPPORT, &conn->flags) ||
+							!conn->hdev->ssp_mode))
 		return 1;
 
 	/* For other security levels we need the link key. */
@@ -778,7 +781,7 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 	if (conn->mode != HCI_CM_SNIFF)
 		goto timer;
 
-	if (!conn->power_save && !force_active)
+	if (!test_bit(HCI_CONN_POWER_SAVE, &conn->flags) && !force_active)
 		goto timer;
 
 	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags)) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 373ae73..e592ddc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1264,7 +1264,8 @@ static int hci_outgoing_auth_needed(struct hci_dev *hdev,
 
 	/* Only request authentication for SSP connections or non-SSP
 	 * devices with sec_level HIGH or if MITM protection is requested */
-	if (!(hdev->ssp_mode > 0 && conn->ssp_mode > 0) &&
+	if (!(hdev->ssp_mode > 0 &&
+			test_bit(HCI_CONN_SSP_SUPPORT, &conn->flags)) &&
 				conn->pending_sec_level != BT_SECURITY_HIGH &&
 				!(conn->auth_type & 0x01))
 		return 0;
@@ -1816,7 +1817,8 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 		goto unlock;
 
 	if (!ev->status) {
-		if (!(conn->ssp_mode > 0 && hdev->ssp_mode > 0) &&
+		if (!(test_bit(HCI_CONN_SSP_SUPPORT, &conn->flags) &&
+							hdev->ssp_mode > 0) &&
 				test_bit(HCI_CONN_REAUTH_PEND,	&conn->flags)) {
 			BT_INFO("re-auth of legacy device is not possible.");
 		} else {
@@ -1831,7 +1833,8 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 	clear_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
 
 	if (conn->state == BT_CONFIG) {
-		if (!ev->status && hdev->ssp_mode > 0 && conn->ssp_mode > 0) {
+		if (!ev->status && hdev->ssp_mode > 0 &&
+				test_bit(HCI_CONN_SSP_SUPPORT, &conn->flags)) {
 			struct hci_cp_set_conn_encrypt cp;
 			cp.handle  = ev->handle;
 			cp.encrypt = 0x01;
@@ -2476,9 +2479,9 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb
 
 		if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags)) {
 			if (conn->mode == HCI_CM_ACTIVE)
-				conn->power_save = 1;
+				set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 			else
-				conn->power_save = 0;
+				clear_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 		}
 
 		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags))
@@ -2751,7 +2754,8 @@ static inline void hci_remote_ext_features_evt(struct hci_dev *hdev, struct sk_b
 		if (ie)
 			ie->data.ssp_mode = (ev->features[0] & 0x01);
 
-		conn->ssp_mode = (ev->features[0] & 0x01);
+		if (ev->features[0] & 0x01)
+			set_bit(HCI_CONN_SSP_SUPPORT, &conn->flags);
 	}
 
 	if (conn->state != BT_CONFIG)
@@ -2930,7 +2934,7 @@ static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
 		conn->auth_type = hci_get_auth_req(conn);
 		cp.authentication = conn->auth_type;
 
-		if ((conn->out == 0x01 || conn->remote_oob == 0x01) &&
+		if ((conn->out || test_bit(HCI_CONN_REMOTE_OOB, &conn->flags)) &&
 				hci_find_remote_oob_data(hdev, &conn->dst))
 			cp.oob_data = 0x01;
 		else
@@ -2966,8 +2970,9 @@ static inline void hci_io_capa_reply_evt(struct hci_dev *hdev, struct sk_buff *s
 		goto unlock;
 
 	conn->remote_cap = ev->capability;
-	conn->remote_oob = ev->oob_data;
 	conn->remote_auth = ev->authentication;
+	if (ev->oob_data)
+		set_bit(HCI_CONN_REMOTE_OOB, &conn->flags);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
1.7.8.3

