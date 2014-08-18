Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] Bluetooth: Move clock offset reading into hci_disconnect()
Date: Mon, 18 Aug 2014 20:33:34 +0300
Message-Id: <1408383214-16366-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
References: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To give all hci_disconnect() users the advantage of getting the clock
offset read automatically this patch moves the necessary code from
hci_ocnn_timeout() into hci_disconnect(). This way we pretty much always
update the clock offset when disconnecting.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index dd2df20b0f7d..e3d7ae9e2edd 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -128,6 +128,19 @@ int hci_disconnect(struct hci_conn *conn, __u8 reason)
 
 	BT_DBG("hcon %p", conn);
 
+	/* When we are master of an established connection and it enters
+	 * the disconnect timeout, then go ahead and try to read the
+	 * current clock offset.  Processing of the result is done
+	 * within the event handling and hci_clock_offset_evt function.
+	 */
+	if (conn->type == ACL_LINK && conn->role == HCI_ROLE_MASTER) {
+		struct hci_dev *hdev = conn->hdev;
+		struct hci_cp_read_clock_offset cp;
+
+		cp.handle = cpu_to_le16(conn->handle);
+		hci_send_cmd(hdev, HCI_OP_READ_CLOCK_OFFSET, sizeof(cp), &cp);
+	}
+
 	conn->state = BT_DISCONN;
 
 	cp.handle = cpu_to_le16(conn->handle);
@@ -325,25 +338,6 @@ static void hci_conn_timeout(struct work_struct *work)
 			hci_amp_disconn(conn);
 		} else {
 			__u8 reason = hci_proto_disconn_ind(conn);
-
-			/* When we are master of an established connection
-			 * and it enters the disconnect timeout, then go
-			 * ahead and try to read the current clock offset.
-			 *
-			 * Processing of the result is done within the
-			 * event handling and hci_clock_offset_evt function.
-			 */
-			if (conn->type == ACL_LINK &&
-			    conn->role == HCI_ROLE_MASTER) {
-				struct hci_dev *hdev = conn->hdev;
-				struct hci_cp_read_clock_offset cp;
-
-				cp.handle = cpu_to_le16(conn->handle);
-
-				hci_send_cmd(hdev, HCI_OP_READ_CLOCK_OFFSET,
-					     sizeof(cp), &cp);
-			}
-
 			hci_disconnect(conn, reason);
 		}
 		break;
-- 
1.9.3

