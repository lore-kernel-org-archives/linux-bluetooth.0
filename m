Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Fix re-enabling advertising after a connection
Date: Sat,  5 Oct 2013 12:01:06 +0200
Message-Id: <1380967266-28782-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380967266-28782-1-git-send-email-johan.hedberg@gmail.com>
References: <1380967266-28782-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

LE controllers will automatically disable advertising whenever they
accept a new connection. In order not to fall out of sync with the
advertising setting we need to re-enable advertising whenever the last
LE connection drops. A failure to re-enable advertising should cause the
setting to be disabled, so this patch also calls mgmt_new_settings()
when this happens.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e1ad858..6eaef6e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1796,6 +1796,40 @@ static u8 hci_to_mgmt_reason(u8 err)
 	}
 }
 
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
+static void reenable_advertising(struct hci_dev *hdev)
+{
+	struct hci_request req;
+	u8 enable = 0x01;
+
+	if (hdev->conn_hash.le_num)
+		return;
+
+	if (!test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+		return;
+
+	hci_req_init(&req, hdev);
+	hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
+
+	/* If this fails we have no option but to let user space know
+	 * that we've disabled advertising.
+	 */
+	if (hci_req_run(&req, adv_enable_complete) < 0) {
+		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
+		mgmt_new_settings(hdev);
+	}
+}
+
 static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_disconn_complete *ev = (void *) skb->data;
@@ -1826,10 +1860,25 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (ev->status == 0) {
-		if (conn->type == ACL_LINK && conn->flush_key)
+		u8 type = conn->type;
+
+		if (type == ACL_LINK && conn->flush_key)
 			hci_remove_link_key(hdev, &conn->dst);
 		hci_proto_disconn_cfm(conn, ev->reason);
 		hci_conn_del(conn);
+
+		/* Re-enable advertising if necessary, since it might
+		 * have been disabled by the connection. From the
+		 * HCI_LE_Set_Advertise_Enable command description in
+		 * the core specification (v4.0):
+		 * "The Controller shall continue advertising until the Host
+		 * issues an LE_Set_Advertise_Enable command with
+		 * Advertising_Enable set to 0x00 (Advertising is disabled)
+		 * or until a connection is created or until the Advertising
+		 * is timed out due to Directed Advertising."
+		 */
+		if (type == LE_LINK)
+			reenable_advertising(hdev);
 	}
 
 unlock:
-- 
1.8.3.1

