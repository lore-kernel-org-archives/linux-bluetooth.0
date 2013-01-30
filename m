Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: Fix hci_conn timeout routine
Date: Wed, 30 Jan 2013 11:50:55 -0300
Message-Id: <1359557457-10199-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If occurs a LE or SCO hci_conn timeout and the connection is already
established (BT_CONNECTED state), the connection is not terminated as
expected. This bug can be reproduced using l2test or scotest tool.
Once the connection is established, kill l2test/scotest and the
connection won't be terminated.

This patch fixes hci_conn_disconnect helper so it is able to
terminate LE and SCO connections, as well as ACL.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 25bfce0..4925a02 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -249,12 +249,12 @@ static void hci_conn_disconnect(struct hci_conn *conn)
 	__u8 reason = hci_proto_disconn_ind(conn);
 
 	switch (conn->type) {
-	case ACL_LINK:
-		hci_acl_disconn(conn, reason);
-		break;
 	case AMP_LINK:
 		hci_amp_disconn(conn, reason);
 		break;
+	default:
+		hci_acl_disconn(conn, reason);
+		break;
 	}
 }
 
-- 
1.8.1.1

