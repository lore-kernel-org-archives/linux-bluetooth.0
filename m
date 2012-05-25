Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 06/12] Bluetooth: Move check for backlog size to l2cap_sock.c
Date: Fri, 25 May 2012 09:30:58 -0300
Message-Id: <1337949064-26187-7-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337949064-26187-1-git-send-email-gustavo@padovan.org>
References: <1337949064-26187-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Remove socket specific code from l2cap_core.c

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   12 ------------
 net/bluetooth/l2cap_sock.c |    6 ++++++
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 53e21ca..01171b1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1156,12 +1156,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	lock_sock(parent);
 
-	/* Check for backlog size */
-	if (sk_acceptq_is_full(parent)) {
-		BT_DBG("backlog full %d", parent->sk_ack_backlog);
-		goto clean;
-	}
-
 	chan = pchan->ops->new_connection(pchan->data);
 	if (!chan)
 		goto clean;
@@ -3348,12 +3342,6 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	result = L2CAP_CR_NO_MEM;
 
-	/* Check for backlog size */
-	if (sk_acceptq_is_full(parent)) {
-		BT_DBG("backlog full %d", parent->sk_ack_backlog);
-		goto response;
-	}
-
 	chan = pchan->ops->new_connection(pchan->data);
 	if (!chan)
 		goto response;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1019c2e..d2d91b3 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -895,6 +895,12 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
 {
 	struct sock *sk, *parent = data;
 
+	/* Check for backlog size */
+	if (sk_acceptq_is_full(parent)) {
+		BT_DBG("backlog full %d", parent->sk_ack_backlog);
+		return NULL;
+	}
+
 	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP,
 								GFP_ATOMIC);
 	if (!sk)
-- 
1.7.10.1

