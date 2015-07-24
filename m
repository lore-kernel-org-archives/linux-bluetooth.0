Return-Path: <cyrus@holtmann.org>
From: Arron Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arron Wang <arron.wang@intel.com>
Subject: [PATCH 2/2] Bluetooth: Move high speed specific event under BT_HS option
Date: Fri, 24 Jul 2015 17:13:15 +0800
Message-Id: <1437729195-16862-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Arron Wang <arron.wang@intel.com>
---
 net/bluetooth/hci_event.c |   44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5e24582..218d7df 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4288,6 +4288,23 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+#if IS_ENABLED(CONFIG_BT_HS)
+static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_channel_selected *ev = (void *)skb->data;
+	struct hci_conn *hcon;
+
+	BT_DBG("%s handle 0x%2.2x", hdev->name, ev->phy_handle);
+
+	skb_pull(skb, sizeof(*ev));
+
+	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
+	if (!hcon)
+		return;
+
+	amp_read_loc_assoc_final_data(hdev, hcon);
+}
+
 static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 				      struct sk_buff *skb)
 {
@@ -4411,6 +4428,7 @@ static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
 
 	hci_dev_unlock(hdev);
 }
+#endif
 
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
@@ -5095,22 +5113,6 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
-static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_ev_channel_selected *ev = (void *) skb->data;
-	struct hci_conn *hcon;
-
-	BT_DBG("%s handle 0x%2.2x", hdev->name, ev->phy_handle);
-
-	skb_pull(skb, sizeof(*ev));
-
-	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (!hcon)
-		return;
-
-	amp_read_loc_assoc_final_data(hdev, hcon);
-}
-
 static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 				 u8 event, struct sk_buff *skb)
 {
@@ -5331,14 +5333,15 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_le_meta_evt(hdev, skb);
 		break;
 
-	case HCI_EV_CHANNEL_SELECTED:
-		hci_chan_selected_evt(hdev, skb);
-		break;
-
 	case HCI_EV_REMOTE_OOB_DATA_REQUEST:
 		hci_remote_oob_data_request_evt(hdev, skb);
 		break;
 
+#if IS_ENABLED(CONFIG_BT_HS)
+	case HCI_EV_CHANNEL_SELECTED:
+		hci_chan_selected_evt(hdev, skb);
+		break;
+
 	case HCI_EV_PHY_LINK_COMPLETE:
 		hci_phy_link_complete_evt(hdev, skb);
 		break;
@@ -5354,6 +5357,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	case HCI_EV_DISCONN_PHY_LINK_COMPLETE:
 		hci_disconn_phylink_complete_evt(hdev, skb);
 		break;
+#endif
 
 	case HCI_EV_NUM_COMP_BLOCKS:
 		hci_num_comp_blocks_evt(hdev, skb);
-- 
1.7.9.5

