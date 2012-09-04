Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 03/15] Bluetooth: AMP: Process Logical Link Complete event
Date: Tue,  4 Sep 2012 16:44:22 +0300
Message-Id: <1346766274-21612-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_event.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2a517e0..f2d8335 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3490,6 +3490,17 @@ static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 	phylink_put(plink);
 }
 
+static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_logical_link_complete *ev = (void *) skb->data;
+
+	BT_DBG("%s log_handle 0x%4.4x phy_handle 0x%2.2x status 0x%2.2x",
+	       hdev->name, le16_to_cpu(ev->handle), ev->phy_handle,
+	       ev->status);
+
+	/* Return Config Rsp with success */
+}
+
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
@@ -3816,6 +3827,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_phy_link_complete_evt(hdev, skb);
 		break;
 
+	case HCI_EV_LOGICAL_LINK_COMPLETE:
+		hci_loglink_complete_evt(hdev, skb);
+		break;
+
 	case HCI_EV_NUM_COMP_BLOCKS:
 		hci_num_comp_blocks_evt(hdev, skb);
 		break;
-- 
1.7.9.5

