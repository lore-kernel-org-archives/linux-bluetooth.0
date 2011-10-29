Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Bluetooth: hidp: Fix module reference cleanup
Date: Sat, 29 Oct 2011 22:34:25 +0200
Message-Id: <1319920465-32766-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Calling module_put(THIS_MODULE) is *never* safe when we cannot go sure that we
own at least two references. This is because the call may unload our module
before it returns and then the "return" will jump into invalid memory.

Gladly, module.h provides a wrapper for kthread-users: module_put_and_exit().
This puts our module and then exits the kthread without returning to the module.

This patch fixes the hidp kthread to use this wrapper instead of manually
freeing its own reference. See nfsd or lockd for other kthreads using this.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 net/bluetooth/hidp/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index fb68f34..5a470fc 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -95,7 +95,6 @@ static struct hidp_session *__hidp_get_session(bdaddr_t *bdaddr)
 
 static void __hidp_link_session(struct hidp_session *session)
 {
-	__module_get(THIS_MODULE);
 	list_add(&session->list, &hidp_session_list);
 
 	hci_conn_hold_device(session->conn);
@@ -106,7 +105,6 @@ static void __hidp_unlink_session(struct hidp_session *session)
 	hci_conn_put_device(session->conn);
 
 	list_del(&session->list);
-	module_put(THIS_MODULE);
 }
 
 static void __hidp_copy_session(struct hidp_session *session, struct hidp_conninfo *ci)
@@ -766,6 +764,7 @@ static int hidp_session(void *arg)
 
 	kfree(session->rd_data);
 	kfree(session);
+	module_put_and_exit(0);
 	return 0;
 }
 
@@ -1033,6 +1032,7 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 		product = 0x0000;
 	}
 
+	__module_get(THIS_MODULE);
 	session->task = kthread_run(hidp_session, session, "khidpd_%04x%04x",
 							vendor, product);
 	if (IS_ERR(session->task)) {
-- 
1.7.7.1
