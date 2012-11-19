Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 1/2] Bluetooth: Add BT_DEFER_SETUP option to sco socket
Date: Mon, 19 Nov 2012 17:35:56 +0100
Message-Id: <1353342958-25303-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1353342958-25303-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1353342958-25303-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This option will set the BT_SK_DEFER_SETUP bit in socket flags.
---
 net/bluetooth/sco.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 450cdcd..c6678f2 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -666,12 +666,31 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
+	u32 opt;
 
 	BT_DBG("sk %p", sk);
 
 	lock_sock(sk);
 
 	switch (optname) {
+
+	case BT_DEFER_SETUP:
+		if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (opt)
+			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+		else
+			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -753,6 +772,19 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname, char
 	lock_sock(sk);
 
 	switch (optname) {
+
+	case BT_DEFER_SETUP:
+		if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (put_user(test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags),
+			     (u32 __user *) optval))
+			err = -EFAULT;
+
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
1.7.9.5

