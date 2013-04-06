Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v4 04/16] Bluetooth: hidp: remove unused session->state field
Date: Sat,  6 Apr 2013 20:28:40 +0200
Message-Id: <1365272932-571-5-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This field is always BT_CONNECTED. Remove it and set it to BT_CONNECTED in
hidp_copy_session() unconditionally.

Also note that this field is totally bogus. Userspace can query an
hidp-session for its state. However, whenever user-space queries us, this
field should be BT_CONNECTED. If it wasn't BT_CONNECTED, then we would be
currently cleaning up the session and the session itself would exit in the
next few milliseconds. Hence, there is no reason to let user-space know
that the session will exit now if they cannot make _any_ use of that.

Thus, remove the field and let user-space think that a session is always
BT_CONNECTED as long as they can query it.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hidp/core.c | 5 ++---
 net/bluetooth/hidp/hidp.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 9734136..22e9ab1 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -79,7 +79,7 @@ static void __hidp_copy_session(struct hidp_session *session, struct hidp_connin
 	bacpy(&ci->bdaddr, &session->bdaddr);
 
 	ci->flags = session->flags;
-	ci->state = session->state;
+	ci->state = BT_CONNECTED;
 
 	ci->vendor  = 0x0000;
 	ci->product = 0x0000;
@@ -970,7 +970,7 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 	down_write(&hidp_session_sem);
 
 	s = __hidp_get_session(&bt_sk(ctrl_sock->sk)->dst);
-	if (s && s->state == BT_CONNECTED) {
+	if (s) {
 		up_write(&hidp_session_sem);
 		return -EEXIST;
 	}
@@ -992,7 +992,6 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 
 	session->ctrl_sock = ctrl_sock;
 	session->intr_sock = intr_sock;
-	session->state     = BT_CONNECTED;
 
 	session->conn = hidp_get_connection(session);
 	if (!session->conn) {
diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
index af1bcc8..57a6191 100644
--- a/net/bluetooth/hidp/hidp.h
+++ b/net/bluetooth/hidp/hidp.h
@@ -135,7 +135,6 @@ struct hidp_session {
 
 	bdaddr_t bdaddr;
 
-	unsigned long state;
 	unsigned long flags;
 	unsigned long idle_to;
 
-- 
1.8.2

