Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 11/26] Bluetooth: Handle AD updating through an async request
Date: Wed, 13 Mar 2013 11:12:02 -0700
Message-Id: <1363198337-3896-12-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For proper control of the AD update and the related HCI commands it's
best to run the AD update through an async request instead of a
standalone HCI command. This patch changes the hci_update_ad() function
to take a request pointer and updates its users appropriately. E.g. the
function is no longer called after the init sequence but during stage 3
of the init sequence.

The TX power is read during the init sequence, so we don't need an
explicit update whenever it is read and the AD update based on the local
name should be done through the local name mgmt handler. The only other
user is the update based on enabling advertising. This part is still
kept as there is no mgmt API to enable it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    4 ++--
 net/bluetooth/hci_core.c         |   29 ++++++++++-------------------
 net/bluetooth/hci_event.c        |   19 +++++++++----------
 3 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d6c3256..cb99193 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -740,8 +740,6 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 								u8 *randomizer);
 int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
-int hci_update_ad(struct hci_dev *hdev);
-
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_recv_frame(struct sk_buff *skb);
@@ -1167,6 +1165,8 @@ struct hci_sec_filter {
 #define hci_req_lock(d)		mutex_lock(&d->req_lock)
 #define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
 
+void hci_update_ad(struct hci_request *req);
+
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 					u16 latency, u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5436e02..d828e49 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -492,8 +492,10 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[5] & 0x10)
 		hci_setup_link_policy(req);
 
-	if (lmp_le_capable(hdev))
+	if (lmp_le_capable(hdev)) {
 		hci_set_le_support(req);
+		hci_update_ad(req);
+	}
 }
 
 static int __hci_init(struct hci_dev *hdev)
@@ -936,39 +938,29 @@ static u8 create_ad(struct hci_dev *hdev, u8 *ptr)
 	return ad_len;
 }
 
-int hci_update_ad(struct hci_dev *hdev)
+void hci_update_ad(struct hci_request *req)
 {
+	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_adv_data cp;
 	u8 len;
-	int err;
-
-	hci_dev_lock(hdev);
 
-	if (!lmp_le_capable(hdev)) {
-		err = -EINVAL;
-		goto unlock;
-	}
+	if (!lmp_le_capable(hdev))
+		return;
 
 	memset(&cp, 0, sizeof(cp));
 
 	len = create_ad(hdev, cp.data);
 
 	if (hdev->adv_data_len == len &&
-	    memcmp(cp.data, hdev->adv_data, len) == 0) {
-		err = 0;
-		goto unlock;
-	}
+	    memcmp(cp.data, hdev->adv_data, len) == 0)
+		return;
 
 	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
 	hdev->adv_data_len = len;
 
 	cp.length = len;
-	err = hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
 
-unlock:
-	hci_dev_unlock(hdev);
-
-	return err;
+	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
 }
 
 /* ---- HCI ioctl helpers ---- */
@@ -1025,7 +1017,6 @@ int hci_dev_open(__u16 dev)
 		hci_dev_hold(hdev);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
-		hci_update_ad(hdev);
 		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
 		    mgmt_valid_hdev(hdev)) {
 			hci_dev_lock(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ec24d9a..4debf4a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -223,9 +223,6 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 		memcpy(hdev->dev_name, sent, HCI_MAX_NAME_LENGTH);
 
 	hci_dev_unlock(hdev);
-
-	if (!status && !test_bit(HCI_INIT, &hdev->flags))
-		hci_update_ad(hdev);
 }
 
 static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
@@ -776,11 +773,8 @@ static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
-	if (!rp->status) {
+	if (!rp->status)
 		hdev->adv_tx_power = rp->tx_power;
-		if (!test_bit(HCI_INIT, &hdev->flags))
-			hci_update_ad(hdev);
-	}
 }
 
 static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
@@ -877,10 +871,15 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 			clear_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
 	}
 
-	hci_dev_unlock(hdev);
+	if (!test_bit(HCI_INIT, &hdev->flags)) {
+		struct hci_request req;
 
-	if (!test_bit(HCI_INIT, &hdev->flags))
-		hci_update_ad(hdev);
+		hci_req_init(&req, hdev);
+		hci_update_ad(&req);
+		hci_req_run(&req, NULL);
+	}
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.7.10.4

