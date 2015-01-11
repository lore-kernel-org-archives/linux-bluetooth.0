Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: Handle command complete event for HCI Read Stored Link Keys
Date: Sun, 11 Jan 2015 13:44:22 -0800
Message-Id: <1421012665-4842-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the HCI Read Stored Link Keys command completes it gives useful
information of the current stored keys and maximum keys a controller
can actually store. So process this event and store these information
in hci_dev structure.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_event.c        | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 89f4e3c8a097..1f21fe48b38e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -205,6 +205,8 @@ struct hci_dev {
 	__u16		lmp_subver;
 	__u16		voice_setting;
 	__u8		num_iac;
+	__u8		stored_max_keys;
+	__u8		stored_num_keys;
 	__u8		io_capability;
 	__s8		inq_tx_power;
 	__u16		page_scan_interval;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0881efd0ad2d..09dde59ddeec 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -214,6 +214,24 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_bdaddr_list_clear(&hdev->le_white_list);
 }
 
+static void hci_cc_read_stored_link_key(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	struct hci_rp_read_stored_link_key *rp = (void *)skb->data;
+	struct hci_cp_read_stored_link_key *sent;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_READ_STORED_LINK_KEY);
+	if (!sent)
+		return;
+
+	if (!rp->status && !bacmp(&sent->bdaddr, BDADDR_ANY)) {
+		hdev->stored_max_keys = rp->max_keys;
+		hdev->stored_num_keys = rp->num_keys;
+	}
+}
+
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2714,6 +2732,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_reset(hdev, skb);
 		break;
 
+	case HCI_OP_READ_STORED_LINK_KEY:
+		hci_cc_read_stored_link_key(hdev, skb);
+		break;
+
 	case HCI_OP_WRITE_LOCAL_NAME:
 		hci_cc_write_local_name(hdev, skb);
 		break;
-- 
2.1.0

