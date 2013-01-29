Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: Fix SCO socket shutdown
Date: Tue, 29 Jan 2013 19:59:53 -0300
Message-Id: <1359500396-8184-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1359500396-8184-1-git-send-email-andre.guedes@openbossa.org>
References: <1359500396-8184-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During the SCO socket shutdown, the connection is not terminated a
expected. This bug can be reproduced using scotest tool. Once the
connection is established, kill scotest and the connection will not
terminate.

This patch fixes hci_conn_disconnect function so it is able to
terminate SCO connections.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0492949..28cfa72 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -251,6 +251,8 @@ static void hci_conn_disconnect(struct hci_conn *conn)
 	switch (conn->type) {
 	case ACL_LINK:
 	case LE_LINK:
+	case SCO_LINK:
+	case ESCO_LINK:
 		hci_acl_disconn(conn, reason);
 		break;
 	case AMP_LINK:
-- 
1.8.1.1

