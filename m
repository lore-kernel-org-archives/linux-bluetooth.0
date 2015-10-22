Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/3] Bluetooth: Make hci_disconnect() behave correctly for all states
Date: Thu, 22 Oct 2015 10:49:39 +0300
Message-Id: <1445500179-5316-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1445500179-5316-1-git-send-email-johan.hedberg@gmail.com>
References: <1445500179-5316-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are a few places that don't explicitly check the connection
state before calling hci_disconnect(). To make this API do the right
thing take advantage of the new hci_abort_conn() API and also make
sure to only read the clock offset if we're really connected.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 665a52fa6c60..85b82f7adbd2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -226,8 +226,6 @@ static void hci_acl_create_connection(struct hci_conn *conn)
 
 int hci_disconnect(struct hci_conn *conn, __u8 reason)
 {
-	struct hci_cp_disconnect cp;
-
 	BT_DBG("hcon %p", conn);
 
 	/* When we are master of an established connection and it enters
@@ -235,7 +233,8 @@ int hci_disconnect(struct hci_conn *conn, __u8 reason)
 	 * current clock offset.  Processing of the result is done
 	 * within the event handling and hci_clock_offset_evt function.
 	 */
-	if (conn->type == ACL_LINK && conn->role == HCI_ROLE_MASTER) {
+	if (conn->type == ACL_LINK && conn->role == HCI_ROLE_MASTER &&
+	    (conn->state == BT_CONNECTED || conn->state == BT_CONFIG)) {
 		struct hci_dev *hdev = conn->hdev;
 		struct hci_cp_read_clock_offset clkoff_cp;
 
@@ -244,11 +243,7 @@ int hci_disconnect(struct hci_conn *conn, __u8 reason)
 			     &clkoff_cp);
 	}
 
-	conn->state = BT_DISCONN;
-
-	cp.handle = cpu_to_le16(conn->handle);
-	cp.reason = reason;
-	return hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT, sizeof(cp), &cp);
+	return hci_abort_conn(conn, reason);
 }
 
 static void hci_add_sco(struct hci_conn *conn, __u16 handle)
-- 
2.5.0

