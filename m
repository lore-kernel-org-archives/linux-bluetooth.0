Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Restrict CMTP flags to only valid ones
Date: Wed,  1 Apr 2015 13:51:52 -0700
Message-Id: <1427921514-22465-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The CMTP flags should be clearly restricted to valid ones. So this puts
extra checks in place to ensure this.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/cmtp/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 278a194e6af4..239be2027454 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -75,10 +75,11 @@ static void __cmtp_unlink_session(struct cmtp_session *session)
 
 static void __cmtp_copy_session(struct cmtp_session *session, struct cmtp_conninfo *ci)
 {
+	__u32 valid_flags = BIT(CMTP_LOOPBACK);
 	memset(ci, 0, sizeof(*ci));
 	bacpy(&ci->bdaddr, &session->bdaddr);
 
-	ci->flags = session->flags;
+	ci->flags = session->flags & valid_flags;
 	ci->state = session->state;
 
 	ci->num = session->num;
@@ -329,6 +330,7 @@ static int cmtp_session(void *arg)
 
 int cmtp_add_connection(struct cmtp_connadd_req *req, struct socket *sock)
 {
+	__u32 valid_flags = BIT(CMTP_LOOPBACK);
 	struct cmtp_session *session, *s;
 	int i, err;
 
@@ -337,6 +339,9 @@ int cmtp_add_connection(struct cmtp_connadd_req *req, struct socket *sock)
 	if (!l2cap_is_socket(sock))
 		return -EBADFD;
 
+	if (req->flags & ~valid_flags)
+		return -EINVAL;
+
 	session = kzalloc(sizeof(struct cmtp_session), GFP_KERNEL);
 	if (!session)
 		return -ENOMEM;
@@ -409,11 +414,15 @@ failed:
 
 int cmtp_del_connection(struct cmtp_conndel_req *req)
 {
+	__u32 valid_flags = 0;
 	struct cmtp_session *session;
 	int err = 0;
 
 	BT_DBG("");
 
+	if (req->flags & ~valid_flags)
+		return -EINVAL;
+
 	down_read(&cmtp_session_sem);
 
 	session = __cmtp_get_session(&req->bdaddr);
-- 
2.1.0

