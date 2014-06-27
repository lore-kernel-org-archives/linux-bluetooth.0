Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Send HCI_Read_Clock_Offset before disconnecting
Date: Fri, 27 Jun 2014 13:45:10 +0200
Message-Id: <1403869510-30820-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the connection is in master role and it is going to be
disconnected based on the disconnection timeout, then send
the HCI_Read_Clock_Offset command in an attempt to update the
clock offset value in the inquiry cache.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  5 +++++
 net/bluetooth/hci_conn.c    | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cc2e88dd20ea..6933766e7215 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -533,6 +533,11 @@ struct hci_cp_read_remote_version {
 	__le16   handle;
 } __packed;
 
+#define HCI_OP_READ_CLOCK_OFFSET	0x041f
+struct hci_cp_read_clock_offset {
+	__le16   handle;
+} __packed;
+
 #define HCI_OP_SETUP_SYNC_CONN		0x0428
 struct hci_cp_setup_sync_conn {
 	__le16   handle;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6d0fe3df2fa5..f477756966b9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -309,6 +309,24 @@ static void hci_conn_timeout(struct work_struct *work)
 			hci_amp_disconn(conn);
 		} else {
 			__u8 reason = hci_proto_disconn_ind(conn);
+
+			/* When we are master of an established connection
+			 * and it enters the disconnect timeout, then go
+			 * ahead and try to read the current clock offset.
+			 *
+			 * Processing of the result is done within the
+			 * event handling and hci_clock_offset_evt function.
+			 */
+			if (test_bit(HCI_CONN_MASTER, &conn->flags)) {
+				struct hci_dev *hdev = conn->hdev;
+				struct hci_cp_read_clock_offset cp;
+
+				cp.handle = cpu_to_le16(conn->handle);
+
+				hci_send_cmd(hdev, HCI_OP_READ_CLOCK_OFFSET,
+					     sizeof(cp), &cp);
+			}
+
 			hci_disconnect(conn, reason);
 		}
 		break;
-- 
1.9.3

