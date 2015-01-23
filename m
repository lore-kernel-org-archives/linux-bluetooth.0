Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] bluetooth: Fix nested sleeps
Date: Fri, 23 Jan 2015 12:08:24 -0500
Message-Id: <1422032904-17091-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1422014582-14391-1-git-send-email-johan.hedberg@gmail.com>
References: <1422014582-14391-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

l2cap/rfcomm/sco_sock_accept() are wait loops which may acquire
sleeping locks. Since both wait loops and sleeping locks use
task_struct.state to sleep and wake, the nested sleeping locks
destroy the wait loop state.

Use the newly-minted wait_woken() and DEFINE_WAIT_FUNC() for the
wait loop. DEFINE_WAIT_FUNC() allows an alternate wake function
to be specified; in this case, the predefined scheduler function,
woken_wait_function(). This wait construct ensures wakeups will
not be missed without requiring the wait loop to set the
task state before condition evaluation. How this works:

 CPU 0                            |  CPU 1
                                  |
                                  | is <condition> set?
                                  | no
set <condition>                   |
                                  |
wake_up_interruptible             |
  woken_wake_function             |
    set WQ_FLAG_WOKEN             |
    try_to_wake_up                |
                                  | wait_woken
                                  |   set TASK_INTERRUPTIBLE
                                  |   WQ_FLAG_WOKEN? yes
                                  |
                                  | set TASK_RUNNING
                                  | loop
				  |
				  | is <condition> set?
                                  | yes - exit wait loop

Fixes "do not call blocking ops when !TASK_RUNNING" warnings
in l2cap_sock_accept(), rfcomm_sock_accept() and sco_sock_accept().

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/l2cap_sock.c  | 9 ++++-----
 net/bluetooth/rfcomm/sock.c | 9 ++++-----
 net/bluetooth/sco.c         | 8 +++-----
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f65caf4..c41c689 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -302,7 +302,7 @@ done:
 static int l2cap_sock_accept(struct socket *sock, struct socket *newsock,
 			     int flags)
 {
-	DECLARE_WAITQUEUE(wait, current);
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	struct sock *sk = sock->sk, *nsk;
 	long timeo;
 	int err = 0;
@@ -316,8 +316,6 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock,
 	/* Wait for an incoming connection. (wake-one). */
 	add_wait_queue_exclusive(sk_sleep(sk), &wait);
 	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		if (sk->sk_state != BT_LISTEN) {
 			err = -EBADFD;
 			break;
@@ -338,10 +336,11 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		release_sock(sk);
-		timeo = schedule_timeout(timeo);
+
+		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
+
 		lock_sock_nested(sk, L2CAP_NESTING_PARENT);
 	}
-	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
 
 	if (err)
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 2348176..0f985ff 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -468,7 +468,7 @@ done:
 
 static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock, int flags)
 {
-	DECLARE_WAITQUEUE(wait, current);
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	struct sock *sk = sock->sk, *nsk;
 	long timeo;
 	int err = 0;
@@ -487,8 +487,6 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock, int f
 	/* Wait for an incoming connection. (wake-one). */
 	add_wait_queue_exclusive(sk_sleep(sk), &wait);
 	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		if (sk->sk_state != BT_LISTEN) {
 			err = -EBADFD;
 			break;
@@ -509,10 +507,11 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock, int f
 		}
 
 		release_sock(sk);
-		timeo = schedule_timeout(timeo);
+
+		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
+
 		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 	}
-	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
 
 	if (err)
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 30e5ea3..b935003 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -618,7 +618,7 @@ done:
 
 static int sco_sock_accept(struct socket *sock, struct socket *newsock, int flags)
 {
-	DECLARE_WAITQUEUE(wait, current);
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	struct sock *sk = sock->sk, *ch;
 	long timeo;
 	int err = 0;
@@ -632,8 +632,6 @@ static int sco_sock_accept(struct socket *sock, struct socket *newsock, int flag
 	/* Wait for an incoming connection. (wake-one). */
 	add_wait_queue_exclusive(sk_sleep(sk), &wait);
 	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		if (sk->sk_state != BT_LISTEN) {
 			err = -EBADFD;
 			break;
@@ -654,10 +652,10 @@ static int sco_sock_accept(struct socket *sock, struct socket *newsock, int flag
 		}
 
 		release_sock(sk);
-		timeo = schedule_timeout(timeo);
+
+		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
 		lock_sock(sk);
 	}
-	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
 
 	if (err)
-- 
2.2.2

