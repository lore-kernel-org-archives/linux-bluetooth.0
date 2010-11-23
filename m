Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [RFC 10/20] Bluetooth: Add server socket support for LE connection
Date: Tue, 23 Nov 2010 12:06:26 -0300
Message-Id: <1290524796-32246-11-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

Add support for LE server sockets.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/l2cap.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 172bf93..e481d6b 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1438,8 +1438,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	BT_DBG("");
 
 	/* Check if we have socket listening on cid */
-	parent = l2cap_get_sock_by_cid(BT_LISTEN, L2CAP_CID_LE_DATA,
-					conn->src);
+	parent = l2cap_get_sock_by_cid(BT_LISTEN, L2CAP_CID_LE_DATA, conn->src);
 	if (!parent)
 		return;
 
-- 
1.7.3.2

