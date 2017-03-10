Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, Yichen Zhao
	<zhaoyichen@google.com>, "Gustavo F . Padovan" <gustavo@padovan.org>, "Johan
 Hedberg" <johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 2/2] Bluetooth: Avoid bt_accept_unlink() double unlinking
Date: Fri, 10 Mar 2017 11:34:46 +0000
Message-ID: <1489145686-23077-3-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1489145686-23077-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1489145686-23077-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

There is a race condition between a thread calling bt_accept_dequeue()
and a different thread calling bt_accept_unlink(). Protection against
concurrency is implemented using sk locking. However, sk locking causes
serialisation of the bt_accept_dequeue() and bt_accept_unlink() threads.
This serialisation can cause bt_accept_dequeue() to obtain the sk from the
parent list but becomes blocked waiting for the sk lock held by the
bt_accept_unlink() thread. bt_accept_unlink() unlinks sk and this thread
releases the sk lock unblocking bt_accept_dequeue() which potentially runs
bt_accept_unlink() again on the same sk causing a crash. The attempt to
double unlink the same sk from the parent list can cause a NULL pointer
dereference crash due to bt_sk(sk)->parent becoming NULL on the first
unlink, followed by the second unlink trying to execute
bt_sk(sk)->parent->sk_ack_backlog-- in bt_accept_unlink() which crashes.

When sk is in the parent list, bt_sk(sk)->parent will be not be NULL.
When sk is removed from the parent list, bt_sk(sk)->parent is set to
NULL. Therefore, add a defensive check for bt_sk(sk)->parent not being
NULL to ensure that sk is still in the parent list after the sk lock has
been taken in bt_accept_dequeue(). If bt_sk(sk)->parent is detected as
being NULL then restart the loop so that the loop variables are refreshed
to use the latest values. This is necessary as list_for_each_entry_safe()
is not thread safe so causing a risk of an infinite loop occurring as sk
could point to itself.

In addition, in bt_accept_dequeue() increase the sk reference count to
protect against early freeing of sk. Early freeing can be possible if the
bt_accept_unlink() thread calls l2cap_sock_kill() or rfcomm_sock_kill()
functions before bt_accept_dequeue() gets the sk lock.

For test purposes, the probability of failure can be increased by putting
a msleep of 1 second in bt_accept_dequeue() between getting the sk and
waiting for the sk lock. This exposes the fact that the loop
list_for_each_entry_safe(p, n, &bt_sk(parent)->accept_q) is not safe from
threads that unlink sk from the list in parallel with the loop which can
cause sk to become stale within the loop.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 net/bluetooth/af_bluetooth.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index a374fd2..42d0997 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -167,6 +167,9 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk)
 }
 EXPORT_SYMBOL(bt_accept_enqueue);
 
+/* Calling function must hold the sk lock.
+ * bt_sk(sk)->parent must be non-NULL meaning sk is in the parent list.
+ */
 void bt_accept_unlink(struct sock *sk)
 {
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
@@ -185,11 +188,32 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 
 	BT_DBG("parent %p", parent);
 
+restart:
 	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
 		sk = (struct sock *)s;
 
+		/* Prevent early freeing of sk due to unlink and sock_kill */
+		sock_hold(sk);
 		lock_sock(sk);
 
+		/* Check sk has not already been unlinked via
+		 * bt_accept_unlink() due to serialisation caused by sk locking
+		 */
+		if (!bt_sk(sk)->parent) {
+			BT_DBG("sk %p, already unlinked", sk);
+			release_sock(sk);
+			sock_put(sk);
+
+			/* Restart the loop as sk is no longer in the list
+			 * and also avoid a potential infinite loop because
+			 * list_for_each_entry_safe() is not thread safe.
+			 */
+			goto restart;
+		}
+
+		/* sk is safely in the parent list so reduce reference count */
+		sock_put(sk);
+
 		/* FIXME: Is this check still needed */
 		if (sk->sk_state == BT_CLOSED) {
 			bt_accept_unlink(sk);
-- 
2.7.4
