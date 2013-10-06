Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use helper function for re-enabling advertising
Date: Sun,  6 Oct 2013 04:08:14 -0700
Message-Id: <1381057694-30810-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the all LE connections have been disconneted, then it is up to
the host to re-enable advertising at that point. To ensure that the
correct advertising parameters are used, force the usage of the
common helper to enable advertising.

The change just moves the manual enabling of advertising from the
event handler into the management core so that the helper can
be actually shared.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 36 +-----------------------------------
 net/bluetooth/mgmt.c             | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 82c3974..869f6ad 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1151,6 +1151,7 @@ int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 bool mgmt_valid_hdev(struct hci_dev *hdev);
 int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent);
+void mgmt_reenable_advertising(struct hci_dev *hdev);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6eaef6e..224210c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1796,40 +1796,6 @@ static u8 hci_to_mgmt_reason(u8 err)
 	}
 }
 
-static void adv_enable_complete(struct hci_dev *hdev, u8 status)
-{
-	BT_DBG("%s status %u", hdev->name, status);
-
-	/* Clear the advertising mgmt setting if we failed to re-enable it */
-	if (status) {
-		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
-		mgmt_new_settings(hdev);
-	}
-}
-
-static void reenable_advertising(struct hci_dev *hdev)
-{
-	struct hci_request req;
-	u8 enable = 0x01;
-
-	if (hdev->conn_hash.le_num)
-		return;
-
-	if (!test_bit(HCI_ADVERTISING, &hdev->dev_flags))
-		return;
-
-	hci_req_init(&req, hdev);
-	hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
-
-	/* If this fails we have no option but to let user space know
-	 * that we've disabled advertising.
-	 */
-	if (hci_req_run(&req, adv_enable_complete) < 0) {
-		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
-		mgmt_new_settings(hdev);
-	}
-}
-
 static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_disconn_complete *ev = (void *) skb->data;
@@ -1878,7 +1844,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		 * is timed out due to Directed Advertising."
 		 */
 		if (type == LE_LINK)
-			reenable_advertising(hdev);
+			mgmt_reenable_advertising(hdev);
 	}
 
 unlock:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b78a0ee..381faf6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4660,3 +4660,36 @@ int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	return mgmt_event(MGMT_EV_DEVICE_UNBLOCKED, hdev, &ev, sizeof(ev),
 			  cmd ? cmd->sk : NULL);
 }
+
+static void adv_enable_complete(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("%s status %u", hdev->name, status);
+
+	/* Clear the advertising mgmt setting if we failed to re-enable it */
+	if (status) {
+		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
+		mgmt_new_settings(hdev);
+	}
+}
+
+void mgmt_reenable_advertising(struct hci_dev *hdev)
+{
+	struct hci_request req;
+
+	if (hdev->conn_hash.le_num)
+		return;
+
+	if (!test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+		return;
+
+	hci_req_init(&req, hdev);
+	enable_advertising(&req);
+
+	/* If this fails we have no option but to let user space know
+	 * that we've disabled advertising.
+	 */
+	if (hci_req_run(&req, adv_enable_complete) < 0) {
+		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
+		mgmt_new_settings(hdev);
+	}
+}
-- 
1.8.3.1

