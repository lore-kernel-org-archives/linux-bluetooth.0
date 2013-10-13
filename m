Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Access HIDP session addresses through L2CAP channel
Date: Sun, 13 Oct 2013 09:49:56 -0700
Message-Id: <1381682997-26437-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The L2CAP socket structure does not contain the address information
anymore. They need to be accessed through the L2CAP channel.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hidp/core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index bdc35a7..292e619 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -767,10 +767,10 @@ static int hidp_setup_hid(struct hidp_session *session,
 	strncpy(hid->name, req->name, sizeof(req->name) - 1);
 
 	snprintf(hid->phys, sizeof(hid->phys), "%pMR",
-		 &bt_sk(session->ctrl_sock->sk)->src);
+		 &l2cap_pi(session->ctrl_sock->sk)->chan->src);
 
 	snprintf(hid->uniq, sizeof(hid->uniq), "%pMR",
-		 &bt_sk(session->ctrl_sock->sk)->dst);
+		 &l2cap_pi(session->ctrl_sock->sk)->chan->dst);
 
 	hid->dev.parent = &session->conn->hcon->dev;
 	hid->ll_driver = &hidp_hid_driver;
@@ -1283,23 +1283,29 @@ static int hidp_session_thread(void *arg)
 static int hidp_verify_sockets(struct socket *ctrl_sock,
 			       struct socket *intr_sock)
 {
+	struct l2cap_chan *ctrl_chan, *intr_chan;
 	struct bt_sock *ctrl, *intr;
 	struct hidp_session *session;
 
 	if (!l2cap_is_socket(ctrl_sock) || !l2cap_is_socket(intr_sock))
 		return -EINVAL;
 
+	ctrl_chan = l2cap_pi(ctrl_sock->sk)->chan;
+	intr_chan = l2cap_pi(intr_sock->sk)->chan;
+
+	if (bacmp(&ctrl_chan->src, &intr_chan->src) ||
+	    bacmp(&ctrl_chan->dst, &intr_chan->dst))
+		return -ENOTUNIQ;
+
 	ctrl = bt_sk(ctrl_sock->sk);
 	intr = bt_sk(intr_sock->sk);
 
-	if (bacmp(&ctrl->src, &intr->src) || bacmp(&ctrl->dst, &intr->dst))
-		return -ENOTUNIQ;
 	if (ctrl->sk.sk_state != BT_CONNECTED ||
 	    intr->sk.sk_state != BT_CONNECTED)
 		return -EBADFD;
 
 	/* early session check, we check again during session registration */
-	session = hidp_session_find(&ctrl->dst);
+	session = hidp_session_find(&ctrl_chan->dst);
 	if (session) {
 		hidp_session_put(session);
 		return -EEXIST;
@@ -1332,7 +1338,7 @@ int hidp_connection_add(struct hidp_connadd_req *req,
 	if (!conn)
 		return -EBADFD;
 
-	ret = hidp_session_new(&session, &bt_sk(ctrl_sock->sk)->dst, ctrl_sock,
+	ret = hidp_session_new(&session, &chan->dst, ctrl_sock,
 			       intr_sock, req, conn);
 	if (ret)
 		goto out_conn;
-- 
1.8.3.1

