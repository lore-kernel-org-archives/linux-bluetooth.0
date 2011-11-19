Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 2/2] Bluetooth: bnep: Fix module reference
Date: Sat, 19 Nov 2011 13:23:33 +0100
Message-Id: <1321705413-2598-2-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1321705413-2598-1-git-send-email-dh.herrmann@googlemail.com>
References: <1321705413-2598-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We cannot call module_put(THIS_MODULE) if this is our last reference. Otherwise,
this call may cleanup our module before it returns.

Gladly, the kthread API provides a simple wrapper for us. So lets use
module_put_and_exit() to avoid a race condition with the module cleanup code.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 net/bluetooth/bnep/core.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index a6cd856..42d53b8 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -77,17 +77,12 @@ static struct bnep_session *__bnep_get_session(u8 *dst)
 
 static void __bnep_link_session(struct bnep_session *s)
 {
-	/* It's safe to call __module_get() here because sessions are added
-	   by the socket layer which has to hold the reference to this module.
-	 */
-	__module_get(THIS_MODULE);
 	list_add(&s->list, &bnep_session_list);
 }
 
 static void __bnep_unlink_session(struct bnep_session *s)
 {
 	list_del(&s->list);
-	module_put(THIS_MODULE);
 }
 
 static int bnep_send(struct bnep_session *s, void *data, size_t len)
@@ -528,6 +523,7 @@ static int bnep_session(void *arg)
 
 	up_write(&bnep_session_sem);
 	free_netdev(dev);
+	module_put_and_exit(0);
 	return 0;
 }
 
@@ -614,9 +610,11 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 
 	__bnep_link_session(s);
 
+	__module_get(THIS_MODULE);
 	s->task = kthread_run(bnep_session, s, "kbnepd %s", dev->name);
 	if (IS_ERR(s->task)) {
 		/* Session thread start failed, gotta cleanup. */
+		module_put(THIS_MODULE);
 		unregister_netdev(dev);
 		__bnep_unlink_session(s);
 		err = PTR_ERR(s->task);
-- 
1.7.7.3

