Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/8] Bluetooth: Store RSSI for connection
Date: Thu, 8 May 2014 15:32:08 +0200
Message-ID: <1399555935-702-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to store RSSI for connection when reply for
HCI_Read_RSSI is received.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 include/net/bluetooth/hci.h      | 10 ++++++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 23 +++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4261a67..ad2ecc9 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1064,6 +1064,16 @@ struct hci_rp_read_page_scan_type {
 	#define PAGE_SCAN_TYPE_STANDARD		0x00
 	#define PAGE_SCAN_TYPE_INTERLACED	0x01
 
+#define HCI_OP_READ_RSSI		0x1405
+struct hci_cp_read_rssi {
+	__le16   handle;
+} __packed;
+struct hci_rp_read_rssi {
+	__u8     status;
+	__le16   handle;
+	__s8     rssi;
+} __packed;
+
 #define HCI_OP_READ_LOCAL_AMP_INFO	0x1409
 struct hci_rp_read_local_amp_info {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d73f418..0318d52 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -374,6 +374,7 @@ struct hci_conn {
 	__u16		setting;
 	__u16		le_conn_min_interval;
 	__u16		le_conn_max_interval;
+	__s8		rssi;
 	unsigned long	flags;
 
 	__u8		remote_cap;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 07c37d0..2bb0053 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1245,6 +1245,25 @@ static void hci_cc_write_remote_amp_assoc(struct hci_dev *hdev,
 	amp_write_rem_assoc_continue(hdev, rp->phy_handle);
 }
 
+static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_read_rssi *rp = (void *) skb->data;
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
+		conn->rssi = rp->rssi;
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
@@ -2637,6 +2656,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_write_remote_amp_assoc(hdev, skb);
 		break;
 
+	case HCI_OP_READ_RSSI:
+		hci_cc_read_rssi(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 		break;
-- 
1.9.2

