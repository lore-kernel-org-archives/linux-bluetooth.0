Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, Yichen Zhao
	<zhaoyichen@google.com>, "Gustavo F . Padovan" <gustavo@padovan.org>, "Johan
 Hedberg" <johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 1/2] Bluetooth: Handle bt_accept_enqueue() socket atomically
Date: Fri, 10 Mar 2017 11:34:45 +0000
Message-ID: <1489145686-23077-2-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1489145686-23077-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1489145686-23077-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

There is a small risk that bt_accept_unlink() runs concurrently with
bt_accept_enqueue() on the same socket. This scenario could potentially
lead to a NULL pointer dereference of the socket's parent member because
the socket can be on the list but the socket's parent member is not yet
updated by bt_accept_enqueue().

Therefore, add socket locking inside bt_accept_enqueue() so that the
socket is added to the list AND the parent's socket address is set in the
socket's parent member. The socket locking ensures that the socket is on
the list with a valid non-NULL parent member.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 net/bluetooth/af_bluetooth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 69e1f7d..a374fd2 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -159,8 +159,10 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk)
 	BT_DBG("parent %p, sk %p", parent, sk);
 
 	sock_hold(sk);
+	lock_sock(sk);
 	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
 	bt_sk(sk)->parent = parent;
+	release_sock(sk);
 	parent->sk_ack_backlog++;
 }
 EXPORT_SYMBOL(bt_accept_enqueue);
-- 
2.7.4
