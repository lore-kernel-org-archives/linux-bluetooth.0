Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 1/2] Bluetooth: cmtp: Fix module reference
Date: Sat, 19 Nov 2011 13:23:32 +0100
Message-Id: <1321705413-2598-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We cannot call module_put(THIS_MODULE) if this is our last reference. Otherwise,
this call may cleanup our module before it returns.

Gladly, the kthread API provides a simple wrapper for us. So lets use
module_put_and_exit() to avoid a race condition with the module cleanup code.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 net/bluetooth/cmtp/core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 9e8940b..6c9c1fd 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -65,14 +65,12 @@ static struct cmtp_session *__cmtp_get_session(bdaddr_t *bdaddr)
 
 static void __cmtp_link_session(struct cmtp_session *session)
 {
-	__module_get(THIS_MODULE);
 	list_add(&session->list, &cmtp_session_list);
 }
 
 static void __cmtp_unlink_session(struct cmtp_session *session)
 {
 	list_del(&session->list);
-	module_put(THIS_MODULE);
 }
 
 static void __cmtp_copy_session(struct cmtp_session *session, struct cmtp_conninfo *ci)
@@ -325,6 +323,7 @@ static int cmtp_session(void *arg)
 	up_write(&cmtp_session_sem);
 
 	kfree(session);
+	module_put_and_exit(0);
 	return 0;
 }
 
@@ -374,9 +373,11 @@ int cmtp_add_connection(struct cmtp_connadd_req *req, struct socket *sock)
 
 	__cmtp_link_session(session);
 
+	__module_get(THIS_MODULE);
 	session->task = kthread_run(cmtp_session, session, "kcmtpd_ctr_%d",
 								session->num);
 	if (IS_ERR(session->task)) {
+		module_put(THIS_MODULE);
 		err = PTR_ERR(session->task);
 		goto unlink;
 	}
-- 
1.7.7.3

