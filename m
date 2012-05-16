Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: use list_for_each_entry_safe()
Date: Wed, 16 May 2012 12:17:11 -0300
Message-Id: <1337181432-979-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337181432-979-1-git-send-email-gustavo@padovan.org>
References: <1337181432-979-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use of list_for_each_entry_safe is cleaner, then replace the
list_for_each_safe() + list_entry().

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 net/bluetooth/af_bluetooth.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 46e7f86..c5f34cc 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -404,11 +404,9 @@ EXPORT_SYMBOL(bt_sock_stream_recvmsg);
 
 static inline unsigned int bt_accept_poll(struct sock *parent)
 {
-	struct list_head *p, *n;
-	struct sock *sk;
+	struct sock *sk, *n;
 
-	list_for_each_safe(p, n, &bt_sk(parent)->accept_q) {
-		sk = (struct sock *) list_entry(p, struct bt_sock, accept_q);
+	list_for_each_entry_safe(sk, n, &bt_sk(parent), accept_q) {
 		if (sk->sk_state == BT_CONNECTED ||
 		    (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &&
 		     sk->sk_state == BT_CONNECT2))
-- 
1.7.10.1

