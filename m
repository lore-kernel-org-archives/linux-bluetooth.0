Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 07/12] Bluetooth: AMP: Process Disc Physical Link Complete evt
Date: Tue, 30 Oct 2012 17:52:59 +0200
Message-Id: <1351612384-12392-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1351612384-12392-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
 <1351612384-12392-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add processing for HCI Disconnection Physical Link Complete Event.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 036cd8d..7ca98b9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3766,6 +3766,28 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
+					     struct sk_buff *skb)
+{
+	struct hci_ev_disconn_phy_link_complete *ev = (void *) skb->data;
+	struct hci_conn *hcon;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
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
@@ -4105,6 +4127,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
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

