Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [PATCH 07/12] Bluetooth: Stop to acquire hdev lock inside hci_update_ad
Date: Fri, 14 Dec 2012 14:51:33 -0400
Message-Id: <1355511098-10190-8-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>

In order to enable broadcaster mode even in power off state, hci_update_ad
must be called in mgmt_powered function, that already has the lock.

Removing the locking logic from inside this function is not a big deal as
most of the functions that already call hci_update_ad also have the lock.

The function was renamed to __hci_update_ad to follow the convention.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_core.c         | 23 ++++++++---------------
 net/bluetooth/hci_event.c        | 19 +++++++++++--------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 56af0fd..d5fd56a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -754,7 +754,7 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 								u8 *randomizer);
 int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
-int hci_update_ad(struct hci_dev *hdev);
+int __hci_update_ad(struct hci_dev *hdev);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5ba9fad..c692b14 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -678,18 +678,14 @@ static u8 create_ad_broadcast(struct hci_dev *hdev, u8 *ptr)
 	return len;
 }
 
-int hci_update_ad(struct hci_dev *hdev)
+int __hci_update_ad(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_adv_data cp;
 	u8 len;
 	int err;
 
-	hci_dev_lock(hdev);
-
-	if (!lmp_le_capable(hdev)) {
-		err = -EINVAL;
-		goto unlock;
-	}
+	if (!lmp_le_capable(hdev))
+		return -EINVAL;
 
 	memset(&cp, 0, sizeof(cp));
 
@@ -699,10 +695,8 @@ int hci_update_ad(struct hci_dev *hdev)
 		len = create_ad(hdev, cp.data);
 
 	if (hdev->adv_data_len == len &&
-	    memcmp(cp.data, hdev->adv_data, len) == 0) {
-		err = 0;
-		goto unlock;
-	}
+	    memcmp(cp.data, hdev->adv_data, len) == 0)
+		return 0;
 
 	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
 	hdev->adv_data_len = len;
@@ -710,9 +704,6 @@ int hci_update_ad(struct hci_dev *hdev)
 	cp.length = len;
 	err = hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
 
-unlock:
-	hci_dev_unlock(hdev);
-
 	return err;
 }
 
@@ -773,7 +764,9 @@ int hci_dev_open(__u16 dev)
 		hci_dev_hold(hdev);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
-		hci_update_ad(hdev);
+		hci_dev_lock(hdev);
+		__hci_update_ad(hdev);
+		hci_dev_unlock(hdev);
 		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
 		    mgmt_valid_hdev(hdev)) {
 			hci_dev_lock(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 46f76d6..b5eb89a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -227,10 +227,10 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 	else if (!status)
 		memcpy(hdev->dev_name, sent, HCI_MAX_NAME_LENGTH);
 
-	hci_dev_unlock(hdev);
-
 	if (!status && !test_bit(HCI_INIT, &hdev->flags))
-		hci_update_ad(hdev);
+		__hci_update_ad(hdev);
+
+	hci_dev_unlock(hdev);
 
 	hci_req_complete(hdev, HCI_OP_WRITE_LOCAL_NAME, status);
 }
@@ -1110,8 +1110,11 @@ static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 
 	if (!rp->status) {
 		hdev->adv_tx_power = rp->tx_power;
-		if (!test_bit(HCI_INIT, &hdev->flags))
-			hci_update_ad(hdev);
+		if (!test_bit(HCI_INIT, &hdev->flags)) {
+			hci_dev_lock(hdev);
+			__hci_update_ad(hdev);
+			hci_dev_unlock(hdev);
+		}
 	}
 
 	hci_req_complete(hdev, HCI_OP_LE_READ_ADV_TX_POWER, rp->status);
@@ -1238,10 +1241,10 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
-	hci_dev_unlock(hdev);
-
 	if (!test_bit(HCI_INIT, &hdev->flags))
-		hci_update_ad(hdev);
+		__hci_update_ad(hdev);
+
+	hci_dev_unlock(hdev);
 
 	hci_req_complete(hdev, HCI_OP_LE_SET_ADV_ENABLE, status);
 }
-- 
1.8.0.2

