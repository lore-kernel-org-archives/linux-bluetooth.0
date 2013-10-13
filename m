Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Access BNEP session addresses through L2CAP channel
Date: Sun, 13 Oct 2013 09:49:57 -0700
Message-Id: <1381682997-26437-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The L2CAP socket structure does not contain the address information
anymore. They need to be accessed through the L2CAP channel.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/bnep/core.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index e430b1a..a841d3e 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -32,6 +32,7 @@
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/hci_core.h>
 
 #include "bnep.h"
@@ -510,20 +511,13 @@ static int bnep_session(void *arg)
 
 static struct device *bnep_get_device(struct bnep_session *session)
 {
-	bdaddr_t *src = &bt_sk(session->sock->sk)->src;
-	bdaddr_t *dst = &bt_sk(session->sock->sk)->dst;
-	struct hci_dev *hdev;
 	struct hci_conn *conn;
 
-	hdev = hci_get_route(dst, src);
-	if (!hdev)
+	conn = l2cap_pi(session->sock->sk)->chan->conn->hcon;
+	if (!conn)
 		return NULL;
 
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
-
-	hci_dev_put(hdev);
-
-	return conn ? &conn->dev : NULL;
+	return &conn->dev;
 }
 
 static struct device_type bnep_type = {
@@ -539,8 +533,8 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 
 	BT_DBG("");
 
-	baswap((void *) dst, &bt_sk(sock->sk)->dst);
-	baswap((void *) src, &bt_sk(sock->sk)->src);
+	baswap((void *) dst, &l2cap_pi(sock->sk)->chan->dst);
+	baswap((void *) src, &l2cap_pi(sock->sk)->chan->src);
 
 	/* session struct allocated as private part of net_device */
 	dev = alloc_netdev(sizeof(struct bnep_session),
-- 
1.8.3.1

