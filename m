Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Track LE connection parameter update event
Date: Mon, 23 Jun 2014 11:40:05 +0200
Message-Id: <1403516405-2184-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the LE controller changes its connection parameters, it will send
a connection parameter update event. Make sure that the new set of
parameters are stored in hci_conn struct and thus will properly update
the previous values retrieved from the connection complete event.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  9 +++++++++
 net/bluetooth/hci_event.c   | 27 +++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3f3a3f1399fb..6b8371d73d3d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1666,6 +1666,15 @@ struct hci_ev_le_conn_complete {
 	__u8     clk_accurancy;
 } __packed;
 
+#define HCI_EV_LE_CONN_UPDATE_COMPLETE	0x03
+struct hci_ev_le_conn_update_complete {
+	__u8     status;
+	__le16   handle;
+	__le16   interval;
+	__le16   latency;
+	__le16   supervision_timeout;
+} __packed;
+
 #define HCI_EV_LE_LTK_REQ		0x05
 struct hci_ev_le_ltk_req {
 	__le16	handle;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3d4741d789d3..e239435312dc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4070,6 +4070,29 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_conn_update_complete_evt(struct hci_dev *hdev,
+					    struct sk_buff *skb)
+{
+	struct hci_ev_le_conn_update_complete *ev = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+
+	if (ev->status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (conn) {
+		conn->le_conn_interval = le16_to_cpu(ev->interval);
+		conn->le_conn_latency = le16_to_cpu(ev->latency);
+		conn->le_supv_timeout = le16_to_cpu(ev->supervision_timeout);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 /* This function requires the caller holds hdev->lock */
 static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 				  u8 addr_type)
@@ -4269,6 +4292,10 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_le_conn_complete_evt(hdev, skb);
 		break;
 
+	case HCI_EV_LE_CONN_UPDATE_COMPLETE:
+		hci_le_conn_update_complete_evt(hdev, skb);
+		break;
+
 	case HCI_EV_LE_ADVERTISING_REPORT:
 		hci_le_adv_report_evt(hdev, skb);
 		break;
-- 
1.9.3

