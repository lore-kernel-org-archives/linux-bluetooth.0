Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Bluetooth: hidp: Fix module reference cleanup
Date: Tue,  1 Nov 2011 17:27:50 +0100
Message-Id: <1320164870-13797-1-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <20111101161242.GE2580@joana>
References: <20111101161242.GE2580@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Calling module_put(THIS_MODULE) is *never* safe when we cannot go sure that we
own at least two references. This is because the call may unload our module
before it returns and then the "return" will jump into invalid memory.

Gladly, module.h provides a wrapper for kthread-users: module_put_and_exit().
This puts our module and then exits the kthread without returning to the module.

This patch fixes the hidp kthread to use this wrapper instead of manually
freeing its own reference. See nfsd or lockd for other kthreads using this.

Calling __module_get() inside the kthread is safe as the hidp module will always
wait until the kthread sets "waiting_for_startup" to 0.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
V3: I rebased on top of bluetooth-next plus the patches already pending on the
ML. It should apply cleanly now. Otherwise, just tell me what tree to use for
the rebase ;) Or try "git am -3 ..."

 net/bluetooth/hidp/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 217ef47..ff42c20 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -93,7 +93,6 @@ static struct hidp_session *__hidp_get_session(bdaddr_t *bdaddr)
 
 static void __hidp_link_session(struct hidp_session *session)
 {
-	__module_get(THIS_MODULE);
 	list_add(&session->list, &hidp_session_list);
 }
 
@@ -102,7 +101,6 @@ static void __hidp_unlink_session(struct hidp_session *session)
 	hci_conn_put_device(session->conn);
 
 	list_del(&session->list);
-	module_put(THIS_MODULE);
 }
 
 static void __hidp_copy_session(struct hidp_session *session, struct hidp_conninfo *ci)
@@ -702,6 +700,7 @@ static int hidp_session(void *arg)
 
 	BT_DBG("session %p", session);
 
+	__module_get(THIS_MODULE);
 	set_user_nice(current, -15);
 
 	init_waitqueue_entry(&ctrl_wait, current);
@@ -780,6 +779,7 @@ static int hidp_session(void *arg)
 
 	kfree(session->rd_data);
 	kfree(session);
+	module_put_and_exit(0);
 	return 0;
 }
 
-- 
1.7.7.1

