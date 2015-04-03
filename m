Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: cmtp: Use BIT(x) instead of (1 << x)
Date: Fri,  3 Apr 2015 11:02:09 -0700
Message-Id: <1428084130-330-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/cmtp/capi.c | 2 +-
 net/bluetooth/cmtp/core.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
index 75bd2c42e3e7..b0c6c6af76ef 100644
--- a/net/bluetooth/cmtp/capi.c
+++ b/net/bluetooth/cmtp/capi.c
@@ -333,7 +333,7 @@ void cmtp_recv_capimsg(struct cmtp_session *session, struct sk_buff *skb)
 		return;
 	}
 
-	if (session->flags & (1 << CMTP_LOOPBACK)) {
+	if (session->flags & BIT(CMTP_LOOPBACK)) {
 		kfree_skb(skb);
 		return;
 	}
diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index ddbc348c9dff..298ed37010e6 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -314,7 +314,7 @@ static int cmtp_session(void *arg)
 
 	down_write(&cmtp_session_sem);
 
-	if (!(session->flags & (1 << CMTP_LOOPBACK)))
+	if (!(session->flags & BIT(CMTP_LOOPBACK)))
 		cmtp_detach_device(session);
 
 	fput(session->sock->file);
@@ -390,7 +390,7 @@ int cmtp_add_connection(struct cmtp_connadd_req *req, struct socket *sock)
 		goto unlink;
 	}
 
-	if (!(session->flags & (1 << CMTP_LOOPBACK))) {
+	if (!(session->flags & BIT(CMTP_LOOPBACK))) {
 		err = cmtp_attach_device(session);
 		if (err < 0) {
 			atomic_inc(&session->terminate);
-- 
2.1.0

