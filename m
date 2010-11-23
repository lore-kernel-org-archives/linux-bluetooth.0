Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [RFC 09/20] Bluetooth: Fix locking balance in l2cap_le_conn_ready
Date: Tue, 23 Nov 2010 12:06:25 -0300
Message-Id: <1290524796-32246-10-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

Don't try to unlock sock if the lock was not held.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 5894662..172bf93 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1441,7 +1441,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	parent = l2cap_get_sock_by_cid(BT_LISTEN, L2CAP_CID_LE_DATA,
 					conn->src);
 	if (!parent)
-		goto clean;
+		return;
 
 	/* Check for backlog size */
 	if (sk_acceptq_is_full(parent)) {
-- 
1.7.3.2

