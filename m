Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH 5/7] Bluetooth: Implement Read RSSI command
Date: Tue,  9 Aug 2011 16:29:40 -0400
Message-Id: <4e4198cf.0750640a.58f6.0ec5@mx.google.com>
In-Reply-To: <1312921782-27523-1-git-send-email-y>
References: <y>
 <1312921782-27523-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This command is used for RSSI Monitoring since the controller did not
have this feature.
When Read RSSI Command completes, the RSSI alert level is calculated for
monitored connections and if the alert type has changed, an alert event
is sent to user space according to configured threshold values.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/hci.h |   10 ++++++++++
 net/bluetooth/hci_event.c   |   23 +++++++++++++++++++++++
 net/bluetooth/mgmt.c        |   23 +++++++++++++++++++++++
 3 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c4fdeeb..276be6e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -550,6 +550,16 @@ struct hci_cp_set_event_flt {
 	__u8     condition[0];
 } __packed;
 
+#define HCI_OP_READ_RSSI		0x1405
+struct hci_cp_read_rssi {
+	__le16	handle;
+} __packed;
+struct hci_rp_read_rssi {
+	__u8	status;
+	__le16	handle;
+	__s8	rssi;
+} __packed;
+
 /* Filter types */
 #define HCI_FLT_CLEAR_ALL	0x00
 #define HCI_FLT_INQ_RESULT	0x01
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 55872ff..b21da65 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -982,6 +982,25 @@ static inline void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, sizeof(cp), &cp);
 }
 
+static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_read_rssi *rp = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	if (!test_bit(HCI_MGMT, &hdev->flags))
+		return;
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
+	if (!conn) {
+		BT_DBG("%s read rssi failed", hdev->name);
+		return;
+	}
+
+	mgmt_rssi_monitor_send_alert(hdev->id, &conn->dst, rp->rssi);
+}
+
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%x", hdev->name, status);
@@ -2012,6 +2031,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_write_le_host_supported(hdev, skb);
 		break;
 
+	case HCI_OP_READ_RSSI:
+		hci_cc_read_rssi(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 635ab8c..bda2b23 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2706,3 +2706,26 @@ int mgmt_do_interleaved_discovery(u16 index)
 
 	return err;
 }
+
+static int mgmt_read_rssi(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct hci_cp_read_rssi rs;
+	struct hci_conn *conn;
+
+	BT_DBG("hci%u", hdev->id);
+
+	if (!test_bit(HCI_UP, &hdev->flags))
+		return -ENETDOWN;
+
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, bdaddr);
+	if (!conn)
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
+
+	if (!conn)
+		return -ENOTCONN;
+
+	put_unaligned_le16(conn->handle, &rs.handle);
+
+	return hci_send_cmd(hdev, HCI_OP_READ_RSSI, sizeof(rs), &rs);
+}
+
-- 
1.7.4.1

