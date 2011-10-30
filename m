Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	anderson.lizardo@openbossa.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2] Bluetooth: hidp: Fix module reference cleanup
Date: Sun, 30 Oct 2011 15:33:43 +0100
Message-Id: <1319985223-6043-1-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <CAJdJm_NYEiw21=XwSCsqHtGjK18r6SXAJcLVdAG0LPEB6a9Wdg@mail.gmail.com>
References: <CAJdJm_NYEiw21=XwSCsqHtGjK18r6SXAJcLVdAG0LPEB6a9Wdg@mail.gmail.com>
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
V2: Fix error path of kthread_run(). We now take the module reference inside the
kthread. This is safe because the caller will wait for us until we set
"waiting_for_startup" to 0. Thanks to Anderson Lizardo for pointing this out.

 net/bluetooth/hidp/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index fb68f34..e3a6340 100644
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
@@ -700,6 +698,7 @@ static int hidp_session(void *arg)
 
 	BT_DBG("session %p", session);
 
+	__module_get(THIS_MODULE);
 	set_user_nice(current, -15);
 
 	init_waitqueue_entry(&ctrl_wait, current);
@@ -766,6 +765,7 @@ static int hidp_session(void *arg)
 
 	kfree(session->rd_data);
 	kfree(session);
+	module_put_and_exit(0);
 	return 0;
 }
 
-- 
1.7.7.1
