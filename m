Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 5/8] Bluetooth: AMP: Process Disc Physical Link complete evt
Date: Tue, 16 Oct 2012 18:01:07 +0300
Message-Id: <1350399670-12418-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350399670-12418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350399670-12418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add processing for HCI Disconnection Physical Link Complete Event.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_event.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dc24489..3440e52 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3663,6 +3663,28 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
+					     struct sk_buff *skb)
+{
+	struct hci_ev_disconn_phy_link_complete *ev = (void *) skb->data;
+	struct hci_conn *hcon;
+
+	BT_DBG("%s status %d", hdev->name, ev->status);
+
+	if (ev->status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
+	if (hcon) {
+		hcon->state = BT_CLOSED;
+		hci_conn_del(hcon);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
@@ -4002,6 +4024,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_disconn_loglink_complete_evt(hdev, skb);
 		break;
 
+	case HCI_EV_DISCONN_PHY_LINK_COMPLETE:
+		hci_disconn_phylink_complete_evt(hdev, skb);
+		break;
+
 	case HCI_EV_NUM_COMP_BLOCKS:
 		hci_num_comp_blocks_evt(hdev, skb);
 		break;
-- 
1.7.9.5

