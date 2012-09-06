Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 19/19] Bluetooth: AMP: Process physical link complete event
Date: Thu,  6 Sep 2012 15:19:57 +0300
Message-Id: <1346933997-14369-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add new hci_conn for representing AMP physical link.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_event.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0841b25..3630044 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3427,6 +3427,43 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static void hci_phy_link_complete_evt(struct hci_dev *hdev,
+				      struct sk_buff *skb)
+{
+	struct hci_ev_phy_link_complete *ev = (void *) skb->data;
+	struct hci_conn *hcon, *bredr_hcon;
+	struct hci_dev *bredr_hdev;
+
+	BT_DBG("%s handle 0x%2.2x status 0x%2.2x", hdev->name, ev->phy_handle,
+	       ev->status);
+
+	if (ev->status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
+	if (!hcon)
+		return;
+
+	bredr_hcon = hcon->amp_mgr->l2cap_conn->hcon;
+
+	hcon->state = BT_CONNECTED;
+	bacpy(&hcon->dst, &bredr_hcon->dst);
+
+	hci_conn_hold_device(hcon);
+	hci_conn_add_sysfs(hcon);
+
+	hci_dev_unlock(hdev);
+
+	bredr_hdev = bredr_hcon->hdev;
+	if (bredr_hdev) {
+		hci_dev_hold(bredr_hdev);
+		l2cap_chan_create_cfm(bredr_hcon, hcon->remote_id);
+		hci_dev_put(bredr_hdev);
+	}
+}
+
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
@@ -3746,6 +3783,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_remote_oob_data_request_evt(hdev, skb);
 		break;
 
+	case HCI_EV_PHY_LINK_COMPLETE:
+		hci_phy_link_complete_evt(hdev, skb);
+		break;
+
 	case HCI_EV_NUM_COMP_BLOCKS:
 		hci_num_comp_blocks_evt(hdev, skb);
 		break;
-- 
1.7.9.5

