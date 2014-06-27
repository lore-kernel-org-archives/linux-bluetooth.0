Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Store LMP handle when HCI_Read_LMP_Handle completes
Date: Fri, 27 Jun 2014 14:16:46 +0200
Message-Id: <1403871406-41269-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the HCI_Read_LMP_Handle completes and is successfull, then store
the LMP handle from SCO and eSCO connections in the hci_conn structure.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      | 11 +++++++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 23 +++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6933766e7215..0664e5441f24 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -538,6 +538,17 @@ struct hci_cp_read_clock_offset {
 	__le16   handle;
 } __packed;
 
+#define HCI_OP_READ_LMP_HANDLE		0x0420
+struct hci_cp_read_lmp_handle {
+	__le16   handle;
+} __packed;
+struct hci_rp_read_lmp_handle {
+	__u8     status;
+	__le16   handle;
+	__u8     lmp_handle;
+	__le32   reserved;
+} __packed;
+
 #define HCI_OP_SETUP_SYNC_CONN		0x0428
 struct hci_cp_setup_sync_conn {
 	__le16   handle;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ca2a99807615..d066237ab219 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -363,6 +363,7 @@ struct hci_conn {
 	__u8		type;
 	bool		out;
 	__u8		attempt;
+	__u8		lmp_handle;
 	__u8		dev_class[3];
 	__u8		features[HCI_MAX_PAGES][8];
 	__u16		pkt_type;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7a23324eac39..783c45874d65 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -88,6 +88,25 @@ static void hci_cc_remote_name_req_cancel(struct hci_dev *hdev,
 	BT_DBG("%s", hdev->name);
 }
 
+static void hci_cc_read_lmp_handle(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_read_lmp_handle *rp = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
+	if (conn)
+		conn->lmp_handle = rp->lmp_handle;
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_role_discovery(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_role_discovery *rp = (void *) skb->data;
@@ -2473,6 +2492,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_remote_name_req_cancel(hdev, skb);
 		break;
 
+	case HCI_OP_READ_LMP_HANDLE:
+		hci_cc_read_lmp_handle(hdev, skb);
+		break;
+
 	case HCI_OP_ROLE_DISCOVERY:
 		hci_cc_role_discovery(hdev, skb);
 		break;
-- 
1.9.3

