Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/7] Bluetooth: Update page scan when necessary for Add/Remove Device
Date: Wed,  9 Jul 2014 11:43:08 +0300
Message-Id: <1404895392-12588-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404895392-12588-1-git-send-email-johan.hedberg@gmail.com>
References: <1404895392-12588-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we're removing the last item in the white list or adding the first
one to it and HCI_CONNECTABLE is not set we need to update the current
page scan. This patch adds a simple helper function for the purpose and
calls it from the respective mgmt command handlers.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 431d5e4aa34b..f5f0763266e0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5198,6 +5198,24 @@ unlock:
 	return err;
 }
 
+/* Helper for Add/Remove Device commands */
+static void update_page_scan(struct hci_dev *hdev, u8 scan)
+{
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+		return;
+
+	if (!hdev_is_powered(hdev))
+		return;
+
+	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+		return;
+
+	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
+		scan |= SCAN_INQUIRY;
+
+	hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+}
+
 static void device_added(struct sock *sk, struct hci_dev *hdev,
 			 bdaddr_t *bdaddr, u8 type, u8 action)
 {
@@ -5235,6 +5253,8 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (cp->addr.type == BDADDR_BREDR) {
+		bool update_scan;
+
 		/* Only "connect" action supported for now */
 		if (cp->action != 0x01) {
 			err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
@@ -5243,10 +5263,16 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
+		update_scan = list_empty(&hdev->whitelist);
+
 		err = hci_bdaddr_list_add(&hdev->whitelist, &cp->addr.bdaddr,
 					  cp->addr.type);
 		if (err)
 			goto unlock;
+
+		if (update_scan)
+			update_page_scan(hdev, SCAN_PAGE);
+
 		goto added;
 	}
 
@@ -5326,6 +5352,9 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 				goto unlock;
 			}
 
+			if (list_empty(&hdev->whitelist))
+				update_page_scan(hdev, SCAN_DISABLED);
+
 			device_removed(sk, hdev, &cp->addr.bdaddr,
 				       cp->addr.type);
 			goto complete;
@@ -5375,6 +5404,8 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			kfree(b);
 		}
 
+		update_page_scan(hdev, SCAN_DISABLED);
+
 		list_for_each_entry_safe(p, tmp, &hdev->le_conn_params, list) {
 			if (p->auto_connect == HCI_AUTO_CONN_DISABLED)
 				continue;
-- 
1.9.3

