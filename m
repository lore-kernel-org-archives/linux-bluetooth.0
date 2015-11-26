Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Simplify read_adv_features code
Date: Thu, 26 Nov 2015 12:15:58 +0200
Message-Id: <1448532959-21912-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The code in the Read Advertising Features mgmt command handler is
unnecessarily complicated. Clean it up and remove unnecessary
variables & branches.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 468402ad933c..9ce2bb2fc977 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5788,10 +5788,10 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_rp_read_adv_features *rp;
 	size_t rp_len;
-	int err, i;
-	bool instance;
+	int err;
 	struct adv_info *adv_instance;
 	u32 supported_flags;
+	u8 *instance;
 
 	BT_DBG("%s", hdev->name);
 
@@ -5801,12 +5801,7 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	rp_len = sizeof(*rp);
-
-	instance = hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE);
-	if (instance)
-		rp_len += hdev->adv_instance_cnt;
-
+	rp_len = sizeof(*rp) + hdev->adv_instance_cnt;
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
 		hci_dev_unlock(hdev);
@@ -5819,19 +5814,12 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
 	rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
 	rp->max_instances = HCI_MAX_ADV_INSTANCES;
+	rp->num_instances = hdev->adv_instance_cnt;
 
-	if (instance) {
-		i = 0;
-		list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
-			if (i >= hdev->adv_instance_cnt)
-				break;
-
-			rp->instance[i] = adv_instance->instance;
-			i++;
-		}
-		rp->num_instances = hdev->adv_instance_cnt;
-	} else {
-		rp->num_instances = 0;
+	instance = rp->instance;
+	list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
+		*instance = adv_instance->instance;
+		instance++;
 	}
 
 	hci_dev_unlock(hdev);
-- 
2.5.0

