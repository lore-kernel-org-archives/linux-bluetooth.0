Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Remove redundant read_host_features commands
Date: Tue, 28 Feb 2012 01:41:34 +0200
Message-Id: <1330386094-19501-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1330386094-19501-1-git-send-email-johan.hedberg@gmail.com>
References: <1330386094-19501-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Previously the write_le_enable would trigger a read_host_features
command but since we have access to the value LE support was set to we
can simply just clear or set the bit in hdev->host_features. This also
removes a second unnecessary read_host_features command from the device
initialization procedure since LE is only enabled after the first
read_host_features command completes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |   59 ++++++++++++++++++++++++++-------------------
 1 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e920cd5..84a6d2e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -542,20 +542,6 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 	hci_send_cmd(hdev, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
 }
 
-static void hci_set_le_support(struct hci_dev *hdev)
-{
-	struct hci_cp_write_le_host_supported cp;
-
-	memset(&cp, 0, sizeof(cp));
-
-	if (enable_le && test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
-		cp.le = 1;
-		cp.simul = !!(hdev->features[6] & LMP_SIMUL_LE_BR);
-	}
-
-	hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(cp), &cp);
-}
-
 static void hci_setup(struct hci_dev *hdev)
 {
 	if (hdev->dev_type != HCI_BREDR)
@@ -608,9 +594,6 @@ static void hci_setup(struct hci_dev *hdev)
 		hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE,
 						sizeof(enable), &enable);
 	}
-
-	if (hdev->features[4] & LMP_LE)
-		hci_set_le_support(hdev);
 }
 
 static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
@@ -730,6 +713,22 @@ static void hci_cc_read_local_features(struct hci_dev *hdev, struct sk_buff *skb
 					hdev->features[6], hdev->features[7]);
 }
 
+static void hci_set_le_support(struct hci_dev *hdev)
+{
+	struct hci_cp_write_le_host_supported cp;
+
+	memset(&cp, 0, sizeof(cp));
+
+	if (enable_le && test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+		cp.le = 1;
+		cp.simul = !!(hdev->features[6] & LMP_SIMUL_LE_BR);
+	}
+
+	if (cp.le != !!(hdev->host_features[0] & 0x02))
+		hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED,
+							sizeof(cp), &cp);
+}
+
 static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 							struct sk_buff *skb)
 {
@@ -738,7 +737,7 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 	BT_DBG("%s status 0x%x", hdev->name, rp->status);
 
 	if (rp->status)
-		return;
+		goto done;
 
 	switch (rp->page) {
 	case 0:
@@ -749,6 +748,10 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 		break;
 	}
 
+	if (test_bit(HCI_INIT, &hdev->flags) && hdev->features[4] & LMP_LE)
+		hci_set_le_support(hdev);
+
+done:
 	hci_req_complete(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, rp->status);
 }
 
@@ -1149,21 +1152,27 @@ static void hci_cc_le_ltk_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 static inline void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 							struct sk_buff *skb)
 {
-	struct hci_cp_read_local_ext_features cp;
 	struct hci_cp_write_le_host_supported *sent;
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED);
-	if (sent && test_bit(HCI_MGMT, &hdev->dev_flags))
-		mgmt_le_enable_complete(hdev, sent->le, status);
-
-	if (status)
+	if (!sent)
 		return;
 
-	cp.page = 0x01;
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, sizeof(cp), &cp);
+	if (!status) {
+		if (sent->le)
+			hdev->host_features[0] |= 0x02;
+		else
+			hdev->host_features[0] &= !0x02;
+	}
+
+	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
+					!test_bit(HCI_INIT, &hdev->flags))
+		mgmt_le_enable_complete(hdev, sent->le, status);
+
+	hci_req_complete(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, status);
 }
 
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
-- 
1.7.9.1

