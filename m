Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Restrict HIDP flags to only valid ones
Date: Wed,  1 Apr 2015 13:51:53 -0700
Message-Id: <1427921514-22465-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HIDP flags should be clearly restricted to valid ones. So this puts
extra checks in place to ensure this.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hidp/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 07348e142f16..27a2d948d561 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -70,10 +70,11 @@ static void hidp_session_terminate(struct hidp_session *s);
 
 static void hidp_copy_session(struct hidp_session *session, struct hidp_conninfo *ci)
 {
+	__u32 valid_flags = 0;
 	memset(ci, 0, sizeof(*ci));
 	bacpy(&ci->bdaddr, &session->bdaddr);
 
-	ci->flags = session->flags;
+	ci->flags = session->flags & valid_flags;
 	ci->state = BT_CONNECTED;
 
 	if (session->input) {
@@ -1312,6 +1313,7 @@ int hidp_connection_add(struct hidp_connadd_req *req,
 			struct socket *ctrl_sock,
 			struct socket *intr_sock)
 {
+	__u32 valid_flags = 0;
 	struct hidp_session *session;
 	struct l2cap_conn *conn;
 	struct l2cap_chan *chan;
@@ -1321,6 +1323,9 @@ int hidp_connection_add(struct hidp_connadd_req *req,
 	if (ret)
 		return ret;
 
+	if (req->flags & ~valid_flags)
+		return -EINVAL;
+
 	chan = l2cap_pi(ctrl_sock->sk)->chan;
 	conn = NULL;
 	l2cap_chan_lock(chan);
@@ -1351,8 +1356,12 @@ out_conn:
 
 int hidp_connection_del(struct hidp_conndel_req *req)
 {
+	__u32 valid_flags = BIT(HIDP_VIRTUAL_CABLE_UNPLUG);
 	struct hidp_session *session;
 
+	if (req->flags & ~valid_flags)
+		return -EINVAL;
+
 	session = hidp_session_find(&req->bdaddr);
 	if (!session)
 		return -ENOENT;
-- 
2.1.0

