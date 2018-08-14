Return-Path: <andrea.parri@amarulasolutions.com>
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Brian Norris <briannorris@chromium.org>,
	AL Yu-Chen Cho <acho@suse.com>,
	Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH] bluetooth/{bnep,cmtp,hidp}: Remove unnecessary smp_mb__{before,after}_atomic
Date: Tue, 14 Aug 2018 20:41:06 +0200
Message-Id: <1534272066-9366-1-git-send-email-andrea.parri@amarulasolutions.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The barriers are unneeded; wait_woken() and woken_wake_function()
already provide us with the required synchronization: remove them
and document that we're relying on the (implicit) synchronization
provided by wait_woken() and woken_wake_function().

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 net/bluetooth/bnep/core.c |  7 ++++---
 net/bluetooth/cmtp/core.c | 14 ++++++++------
 net/bluetooth/hidp/core.c | 13 ++++++++-----
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 7b3965861013c..43c284158f63e 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -489,9 +489,6 @@ static int bnep_session(void *arg)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	while (1) {
-		/* Ensure session->terminate is updated */
-		smp_mb__before_atomic();
-
 		if (atomic_read(&s->terminate))
 			break;
 		/* RX */
@@ -512,6 +509,10 @@ static int bnep_session(void *arg)
 				break;
 		netif_wake_queue(dev);
 
+		/*
+		 * wait_woken() performs the necessary memory barriers
+		 * for us; see the header comment for this primitive.
+		 */
 		wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 7f26a5a19ff6d..07cfa3249f83a 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -288,9 +288,6 @@ static int cmtp_session(void *arg)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	while (1) {
-		/* Ensure session->terminate is updated */
-		smp_mb__before_atomic();
-
 		if (atomic_read(&session->terminate))
 			break;
 		if (sk->sk_state != BT_CONNECTED)
@@ -306,6 +303,10 @@ static int cmtp_session(void *arg)
 
 		cmtp_process_transmit(session);
 
+		/*
+		 * wait_woken() performs the necessary memory barriers
+		 * for us; see the header comment for this primitive.
+		 */
 		wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
@@ -431,9 +432,10 @@ int cmtp_del_connection(struct cmtp_conndel_req *req)
 		/* Stop session thread */
 		atomic_inc(&session->terminate);
 
-		/* Ensure session->terminate is updated */
-		smp_mb__after_atomic();
-
+		/*
+		 * See the comment preceding the call to wait_woken()
+		 * in cmtp_session().
+		 */
 		wake_up_interruptible(sk_sleep(session->sock->sk));
 	} else
 		err = -ENOENT;
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 1036e4fa1ea28..e621551712f59 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1074,6 +1074,10 @@ static int hidp_session_start_sync(struct hidp_session *session)
 static void hidp_session_terminate(struct hidp_session *session)
 {
 	atomic_inc(&session->terminate);
+	/*
+	 * See the comment preceding the call to wait_woken()
+	 * in hidp_session_run().
+	 */
 	wake_up_interruptible(&hidp_session_wq);
 }
 
@@ -1193,8 +1197,6 @@ static void hidp_session_run(struct hidp_session *session)
 		 *    thread is woken up by ->sk_state_changed().
 		 */
 
-		/* Ensure session->terminate is updated */
-		smp_mb__before_atomic();
 		if (atomic_read(&session->terminate))
 			break;
 
@@ -1228,14 +1230,15 @@ static void hidp_session_run(struct hidp_session *session)
 		hidp_process_transmit(session, &session->ctrl_transmit,
 				      session->ctrl_sock);
 
+		/*
+		 * wait_woken() performs the necessary memory barriers
+		 * for us; see the header comment for this primitive.
+		 */
 		wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
 	}
 	remove_wait_queue(&hidp_session_wq, &wait);
 
 	atomic_inc(&session->terminate);
-
-	/* Ensure session->terminate is updated */
-	smp_mb__after_atomic();
 }
 
 static int hidp_session_wake_function(wait_queue_entry_t *wait,
-- 
2.7.4
