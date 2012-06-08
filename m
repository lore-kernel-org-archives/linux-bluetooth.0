Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add support for encryption key refresh
Date: Fri,  8 Jun 2012 23:31:13 +0800
Message-Id: <1339169473-29187-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <20120608072044.GF1546@joana>
References: <20120608072044.GF1546@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

With LE/SMP the completion of a security level elavation from medium to
high is indicated by a HCI Encryption Key Refresh Complete event. The
necessary behavior upon receiving this event is a mix of what's done for
auth_complete and encryption_change, which is also where most of the
event handling code has been copied from.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: Rebased on top of latest bluetooth.git

 include/net/bluetooth/hci.h |    6 ++++++
 net/bluetooth/hci_event.c   |   48 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 66a7b57..3def64b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1144,6 +1144,12 @@ struct extended_inquiry_info {
 	__u8     data[240];
 } __packed;
 
+#define HCI_EV_KEY_REFRESH_COMPLETE	0x30
+struct hci_ev_key_refresh_complete {
+	__u8	status;
+	__le16	handle;
+} __packed;
+
 #define HCI_EV_IO_CAPA_REQUEST		0x31
 struct hci_ev_io_capa_request {
 	bdaddr_t bdaddr;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4eefb7f..94ad124 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3043,6 +3043,50 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 	hci_dev_unlock(hdev);
 }
 
+static void hci_key_refresh_complete_evt(struct hci_dev *hdev,
+					 struct sk_buff *skb)
+{
+	struct hci_ev_key_refresh_complete *ev = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status %u handle %u", hdev->name, ev->status,
+	       __le16_to_cpu(ev->handle));
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
+		goto unlock;
+
+	if (!ev->status)
+		conn->sec_level = conn->pending_sec_level;
+
+	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
+
+	if (ev->status && conn->state == BT_CONNECTED) {
+		hci_acl_disconn(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_conn_put(conn);
+		goto unlock;
+	}
+
+	if (conn->state == BT_CONFIG) {
+		if (!ev->status)
+			conn->state = BT_CONNECTED;
+
+		hci_proto_connect_cfm(conn, ev->status);
+		hci_conn_put(conn);
+	} else {
+		hci_auth_cfm(conn, ev->status);
+
+		hci_conn_hold(conn);
+		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
+		hci_conn_put(conn);
+	}
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static inline u8 hci_get_auth_req(struct hci_conn *conn)
 {
 	/* If remote requests dedicated bonding follow that lead */
@@ -3559,6 +3603,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_extended_inquiry_result_evt(hdev, skb);
 		break;
 
+	case HCI_EV_KEY_REFRESH_COMPLETE:
+		hci_key_refresh_complete_evt(hdev, skb);
+		break;
+
 	case HCI_EV_IO_CAPA_REQUEST:
 		hci_io_capa_request_evt(hdev, skb);
 		break;
-- 
1.7.10

