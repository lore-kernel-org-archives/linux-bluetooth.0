Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Bluetooth: Fix L2CAP socket shutdown for LE connections
Date: Tue, 29 Jan 2013 19:59:52 -0300
Message-Id: <1359500396-8184-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During the L2CAP socket shutdown, the LE connection is not terminated
as expected. This bug can be reproduced using l2test tool. Once the
LE connection is established, kill l2test and the LE connection will
not terminate.

This patch fixes hci_conn_disconnect function so it is able to
terminate LE connections.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 25bfce0..0492949 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -250,6 +250,7 @@ static void hci_conn_disconnect(struct hci_conn *conn)
 
 	switch (conn->type) {
 	case ACL_LINK:
+	case LE_LINK:
 		hci_acl_disconn(conn, reason);
 		break;
 	case AMP_LINK:
-- 
1.8.1.1

