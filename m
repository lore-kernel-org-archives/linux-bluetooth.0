Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix "blocking ops when !TASK_RUNNING" with sock_accept
Date: Fri, 23 Jan 2015 14:03:02 +0200
Message-Id: <1422014582-14391-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Recent kernels have started giving the following style warnings:

[  +0.000237] WARNING: CPU: 1 PID: 701 at kernel/sched/core.c:7300 __might_sleep+0x65/0xa3()
[  +0.000407] do not call blocking ops when !TASK_RUNNING; state=1 set at [<f88b0955>] l2cap_sock_accept+0x97/0x1b4 [bluetooth]
[  +0.000611] Modules linked in: btusb hci_vhci rfcomm bluetooth
[  +0.000305] CPU: 1 PID: 701 Comm: l2cap-tester Not tainted 3.19.0-rc4+ #1304
[  +0.000318] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-20140709_153950- 04/01/2014
[  +0.000463]  00000000 00000000 f2e81c70 c13e57df f2e81c9c f2e81c8c c103372c 00001c84
[  +0.000586]  c104e4a1 00000001 f5e93390 f5e93390 f2e81ca4 c103376e 00000009 f2e81c9c
[  +0.000422]  c15da812 f2e81cb8 f2e81cdc c104e4a1 c15da2ae 00001c84 c15da812 00000001
[  +0.000869] Call Trace:
[  +0.000073]  [<c13e57df>] dump_stack+0x49/0x73
[  +0.000182]  [<c103372c>] warn_slowpath_common+0x89/0xa0
[  +0.000225]  [<c104e4a1>] ? __might_sleep+0x65/0xa3
[  +0.000204]  [<c103376e>] warn_slowpath_fmt+0x2b/0x2f
[  +0.000215]  [<c104e4a1>] __might_sleep+0x65/0xa3
[  +0.000212]  [<f88b0955>] ? l2cap_sock_accept+0x97/0x1b4 [bluetooth]
[  +0.000297]  [<f88b0955>] ? l2cap_sock_accept+0x97/0x1b4 [bluetooth]
[  +0.000284]  [<c130bfad>] lock_sock_nested+0x23/0x77
[  +0.000219]  [<f888b25d>] bt_accept_dequeue+0x68/0x11b [bluetooth]
[  +0.000274]  [<c1060165>] ? trace_hardirqs_on+0xb/0xd
[  +0.000224]  [<f88b0985>] l2cap_sock_accept+0xc7/0x1b4 [bluetooth]
[  +0.000498]  [<f88b0985>] ? l2cap_sock_accept+0xc7/0x1b4 [bluetooth]
[  +0.000494]  [<c1051849>] ? wake_up_state+0x11/0x11
[  +0.000202]  [<c1309c27>] SYSC_accept4+0xf3/0x1af
[  +0.000194]  [<c11912b5>] ? security_socket_accept+0x14/0x16
[  +0.000252]  [<c1309c27>] ? SYSC_accept4+0xf3/0x1af
[  +0.000201]  [<c1061507>] ? lock_release_non_nested+0x137/0x217
[  +0.000256]  [<c10cd5bc>] ? might_fault+0x44/0x8b
[  +0.000190]  [<c10cd5bc>] ? might_fault+0x44/0x8b
[  +0.000196]  [<c11da2b0>] ? _copy_from_user+0x44/0x4e
[  +0.000210]  [<c130b3ea>] SYSC_socketcall+0xff/0x38c
[  +0.000205]  [<c105fdcb>] ? mark_lock+0x1e/0x1c5
[  +0.000186]  [<c10606d8>] ? __lock_acquire+0x342/0xc89
[  +0.000215]  [<c1060926>] ? __lock_acquire+0x590/0xc89
[  +0.000217]  [<c105ea2e>] ? __lock_is_held+0x2e/0x44
[  +0.000205]  [<c11106c9>] ? fsnotify+0x452/0x494
[  +0.000186]  [<c1060165>] ? trace_hardirqs_on+0xb/0xd
[  +0.000403]  [<c10e4516>] ? fsnotify_modify+0x4a/0x55
[  +0.000497]  [<c10e4516>] ? fsnotify_modify+0x4a/0x55
[  +0.000220]  [<c10e48eb>] ? vfs_write+0xbb/0xc5
[  +0.000186]  [<c106013f>] ? trace_hardirqs_on_caller+0x15f/0x17a
[  +0.000273]  [<c130b6a8>] SyS_socketcall+0x13/0x15
[  +0.000200]  [<c13ea628>] sysenter_do_call+0x12/0x12

The problematic code is bt_accept_dequeue() which calls the blocking
lock_sock() function. The simplest fix is to move setting
TASK_INTERRUPTIBLE after the call to bt_accept_dequeue(). This patch
makes this fix for our three socket types (L2CAP, RFCOMM & SCO).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
Note: Due to my limited experience with waitqueues and playing with the
task state, this can be considered a rather naive approach to the
problem. However, the patch seems to work fine in practice and
effectively removes the warning in question.

 net/bluetooth/l2cap_sock.c  | 4 ++--
 net/bluetooth/rfcomm/sock.c | 4 ++--
 net/bluetooth/sco.c         | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 20206cd3acbc..8d723e6ae802 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -316,8 +316,6 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock,
 	/* Wait for an incoming connection. (wake-one). */
 	add_wait_queue_exclusive(sk_sleep(sk), &wait);
 	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		if (sk->sk_state != BT_LISTEN) {
 			err = -EBADFD;
 			break;
@@ -327,6 +325,8 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock,
 		if (nsk)
 			break;
 
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		if (!timeo) {
 			err = -EAGAIN;
 			break;
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index d8a95755a8a8..8f492707f6d2 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -487,8 +487,6 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock, int f
 	/* Wait for an incoming connection. (wake-one). */
 	add_wait_queue_exclusive(sk_sleep(sk), &wait);
 	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		if (sk->sk_state != BT_LISTEN) {
 			err = -EBADFD;
 			break;
@@ -498,6 +496,8 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock, int f
 		if (nsk)
 			break;
 
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		if (!timeo) {
 			err = -EAGAIN;
 			break;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 07ec7d23b843..ee9673e014cb 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -632,8 +632,6 @@ static int sco_sock_accept(struct socket *sock, struct socket *newsock, int flag
 	/* Wait for an incoming connection. (wake-one). */
 	add_wait_queue_exclusive(sk_sleep(sk), &wait);
 	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		if (sk->sk_state != BT_LISTEN) {
 			err = -EBADFD;
 			break;
@@ -643,6 +641,8 @@ static int sco_sock_accept(struct socket *sock, struct socket *newsock, int flag
 		if (ch)
 			break;
 
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		if (!timeo) {
 			err = -EAGAIN;
 			break;
-- 
2.1.0

