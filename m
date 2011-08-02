Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC 5/7] Bluetooth: Implement Read RSSI command
Date: Tue,  2 Aug 2011 14:35:07 -0400
Message-Id: <1312310109-27082-6-git-send-email-anderson.briglia@openbossa.org>
In-Reply-To: <1312310109-27082-1-git-send-email-anderson.briglia@openbossa.org>
References: <y>
 <1312310109-27082-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command is used for RSSI Monitoring since the controller did not
have this feature.
When Read RSSI Command completes, the RSSI alert level is calculated for
monitored connections and if the alert type has changed, an alert event
is sent to user space according to configured threshold values.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/hci.h      |   10 ++++++++++
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |   24 ++++++++++++++++++++++++
 net/bluetooth/mgmt.c             |   32 ++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 0 deletions(-)

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
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1bc1c3a..a3cf433 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -856,6 +856,7 @@ int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_set_local_name_complete(u16 index, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 								u8 status);
+void mgmt_read_rssi_complete(u16 index, bdaddr_t *bdaddr, s8 rssi, u8 status);
 int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
 							u8 *eir, u8 eir_len);
 int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 55872ff..4379de0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -982,6 +982,26 @@ static inline void hci_cc_write_le_host_supported(struct hci_dev *hdev,
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
+	mgmt_read_rssi_complete(hdev->id, &conn->dst, rp->rssi,
+							rp->status);
+}
+
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%x", hdev->name, status);
@@ -2012,6 +2032,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
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
index a1955df..65ddbff 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2686,3 +2686,35 @@ int mgmt_do_interleaved_discovery(u16 index)
 
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
+void mgmt_read_rssi_complete(u16 index, bdaddr_t *bdaddr, s8 rssi, u8 status)
+{
+	BT_DBG("hci%d status %0x", index, status);
+
+	if (status)
+		return -EINVAL;
+
+	rssi_monitor_send_alert(index, bdaddr, rssi);
+}
-- 
1.7.4.1

