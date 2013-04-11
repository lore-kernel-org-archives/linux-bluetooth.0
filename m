Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Bluetooth: Add rejecting SCO
Date: Thu, 11 Apr 2013 11:35:43 -0300
Message-Id: <1365690946-28050-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1365690946-28050-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1365690946-28050-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch sends Reject Synchronous Connection Request Command when
hci_conn_timeout is triggered, and the SCO connection is in BT_CONNECT2
state. It prevents inconsistency if the remote host doesn't implement
properly the timeout for the connection request, and it removes the
connection reference left when the socket is closed for incoming SCO
connections.

[ 2650.129080] sco_sock_release: sock ffff8801ca417400, sk ffff88020c408800
[ 2650.129092] sco_sock_clear_timer: sock ffff88020c408800 state 6
[ 2650.129101] __sco_sock_close: sk ffff88020c408800 state 6 socket
	ffff8801ca417400
[ 2650.129108] sco_chan_del: sk ffff88020c408800, conn ffff8801c650ea20,
	err 104
[ 2650.129114] hci_conn_put: hcon ffff88020c40a800 orig refcnt 1
[ 2650.129128] sco_sock_kill: sk ffff88020c408800 state 9
[ 2650.129135] sco_sock_destruct: sk ffff88020c408800
[ 2650.138468] hci_conn_timeout: hcon ffff88020c40a800 state BT_CONNECT2

Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b9f9016..aed48fe 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -117,6 +117,16 @@ static void hci_acl_create_connection_cancel(struct hci_conn *conn)
 	hci_send_cmd(conn->hdev, HCI_OP_CREATE_CONN_CANCEL, sizeof(cp), &cp);
 }
 
+static void hci_reject_sco(struct hci_conn *conn)
+{
+	struct hci_cp_reject_sync_conn_req cp;
+
+	cp.reason = HCI_ERROR_REMOTE_USER_TERM;
+	bacpy(&cp.bdaddr, &conn->dst);
+
+	hci_send_cmd(conn->hdev, HCI_OP_REJECT_SYNC_CONN_REQ, sizeof(cp), &cp);
+}
+
 void hci_disconnect(struct hci_conn *conn, __u8 reason)
 {
 	struct hci_cp_disconnect cp;
@@ -276,7 +286,8 @@ static void hci_conn_timeout(struct work_struct *work)
 				hci_acl_create_connection_cancel(conn);
 			else if (conn->type == LE_LINK)
 				hci_le_create_connection_cancel(conn);
-		}
+		} else if (conn->type == SCO_LINK || conn->type == ESCO_LINK)
+			hci_reject_sco(conn);
 		break;
 	case BT_CONFIG:
 	case BT_CONNECTED:
-- 
1.7.11.7

