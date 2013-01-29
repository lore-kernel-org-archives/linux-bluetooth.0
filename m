Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: Refactor hci_conn_disconnect
Date: Tue, 29 Jan 2013 19:59:54 -0300
Message-Id: <1359500396-8184-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1359500396-8184-1-git-send-email-andre.guedes@openbossa.org>
References: <1359500396-8184-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does a trivial refactoring in hci_conn_disconnect function.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 28cfa72..4925a02 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -249,15 +249,12 @@ static void hci_conn_disconnect(struct hci_conn *conn)
 	__u8 reason = hci_proto_disconn_ind(conn);
 
 	switch (conn->type) {
-	case ACL_LINK:
-	case LE_LINK:
-	case SCO_LINK:
-	case ESCO_LINK:
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

