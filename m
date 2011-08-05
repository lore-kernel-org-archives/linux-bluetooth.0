Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
CC: Jaikumar Ganesh <jaikumar@google.com>
Date: Fri, 5 Aug 2011 10:41:35 -0400
Subject: [PATCH v2] Bluetooth: bnep: Fix deadlock in session deletion
Message-ID: <1312555295.2172.2.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commit f4d7cd4a4c introduced the usage of kthread API.
kthread_stop is a blocking function which returns only when
the thread exits. In this case, the thread can't exit because it's
waiting for the write lock, which is being held by bnep_del_connection()
which is waiting for the thread to exit -- deadlock.

Use atomic_t/wake_up_process instead to signal to the thread to exit.

Signed-off-by: Jaikumar Ganesh <jaikumar@google.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/bnep/bnep.h |    1 +
 net/bluetooth/bnep/core.c |    9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
index 8e6c061..e7ee531 100644
--- a/net/bluetooth/bnep/bnep.h
+++ b/net/bluetooth/bnep/bnep.h
@@ -155,6 +155,7 @@ struct bnep_session {
 	unsigned int  role;
 	unsigned long state;
 	unsigned long flags;
+	atomic_t      terminate;
 	struct task_struct *task;
 
 	struct ethhdr eh;
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 7e8ff3c..d9edfe8 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -487,7 +487,7 @@ static int bnep_session(void *arg)
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (kthread_should_stop())
+		if (atomic_read(&s->terminate))
 			break;
 		/* RX */
 		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
@@ -642,9 +642,10 @@ int bnep_del_connection(struct bnep_conndel_req *req)
 	down_read(&bnep_session_sem);
 
 	s = __bnep_get_session(req->dst);
-	if (s)
-		kthread_stop(s->task);
-	else
+	if (s) {
+		atomic_inc(&s->terminate);
+		wake_up_process(s->task);
+	} else
 		err = -ENOENT;
 
 	up_read(&bnep_session_sem);
-- 
1.7.4.1

