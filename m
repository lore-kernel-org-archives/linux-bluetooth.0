Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 12/12] Bluetooth: Don't disable interruptions on RFCOMM
Date: Thu, 22 Dec 2011 16:56:13 -0200
Message-Id: <1324580173-24957-12-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324580173-24957-11-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-6-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-7-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-8-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-9-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-10-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-11-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

As everything is now process context, disable interruptions is now
pointless.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/rfcomm/sock.c |   12 ++++++------
 net/bluetooth/rfcomm/tty.c  |   16 ++++++++--------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index aea2bdd..f066678 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -370,7 +370,7 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 		goto done;
 	}
 
-	write_lock_bh(&rfcomm_sk_list.lock);
+	write_lock(&rfcomm_sk_list.lock);
 
 	if (sa->rc_channel && __rfcomm_get_sock_by_addr(sa->rc_channel, &sa->rc_bdaddr)) {
 		err = -EADDRINUSE;
@@ -381,7 +381,7 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 		sk->sk_state = BT_BOUND;
 	}
 
-	write_unlock_bh(&rfcomm_sk_list.lock);
+	write_unlock(&rfcomm_sk_list.lock);
 
 done:
 	release_sock(sk);
@@ -455,7 +455,7 @@ static int rfcomm_sock_listen(struct socket *sock, int backlog)
 
 		err = -EINVAL;
 
-		write_lock_bh(&rfcomm_sk_list.lock);
+		write_lock(&rfcomm_sk_list.lock);
 
 		for (channel = 1; channel < 31; channel++)
 			if (!__rfcomm_get_sock_by_addr(channel, src)) {
@@ -464,7 +464,7 @@ static int rfcomm_sock_listen(struct socket *sock, int backlog)
 				break;
 			}
 
-		write_unlock_bh(&rfcomm_sk_list.lock);
+		write_unlock(&rfcomm_sk_list.lock);
 
 		if (err < 0)
 			goto done;
@@ -982,7 +982,7 @@ static int rfcomm_sock_debugfs_show(struct seq_file *f, void *p)
 	struct sock *sk;
 	struct hlist_node *node;
 
-	read_lock_bh(&rfcomm_sk_list.lock);
+	read_lock(&rfcomm_sk_list.lock);
 
 	sk_for_each(sk, node, &rfcomm_sk_list.head) {
 		seq_printf(f, "%s %s %d %d\n",
@@ -991,7 +991,7 @@ static int rfcomm_sock_debugfs_show(struct seq_file *f, void *p)
 				sk->sk_state, rfcomm_pi(sk)->channel);
 	}
 
-	read_unlock_bh(&rfcomm_sk_list.lock);
+	read_unlock(&rfcomm_sk_list.lock);
 
 	return 0;
 }
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index fa8f4de5..6583f1c 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -205,7 +205,7 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	if (!dev)
 		return -ENOMEM;
 
-	write_lock_bh(&rfcomm_dev_lock);
+	write_lock(&rfcomm_dev_lock);
 
 	if (req->dev_id < 0) {
 		dev->id = 0;
@@ -290,7 +290,7 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	__module_get(THIS_MODULE);
 
 out:
-	write_unlock_bh(&rfcomm_dev_lock);
+	write_unlock(&rfcomm_dev_lock);
 
 	if (err < 0)
 		goto free;
@@ -327,9 +327,9 @@ static void rfcomm_dev_del(struct rfcomm_dev *dev)
 	if (atomic_read(&dev->opened) > 0)
 		return;
 
-	write_lock_bh(&rfcomm_dev_lock);
+	write_lock(&rfcomm_dev_lock);
 	list_del_init(&dev->list);
-	write_unlock_bh(&rfcomm_dev_lock);
+	write_unlock(&rfcomm_dev_lock);
 
 	rfcomm_dev_put(dev);
 }
@@ -473,7 +473,7 @@ static int rfcomm_get_dev_list(void __user *arg)
 
 	di = dl->dev_info;
 
-	read_lock_bh(&rfcomm_dev_lock);
+	read_lock(&rfcomm_dev_lock);
 
 	list_for_each_entry(dev, &rfcomm_dev_list, list) {
 		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
@@ -488,7 +488,7 @@ static int rfcomm_get_dev_list(void __user *arg)
 			break;
 	}
 
-	read_unlock_bh(&rfcomm_dev_lock);
+	read_unlock(&rfcomm_dev_lock);
 
 	dl->dev_num = n;
 	size = sizeof(*dl) + n * sizeof(*di);
@@ -766,9 +766,9 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 		rfcomm_dlc_unlock(dev->dlc);
 
 		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags)) {
-			write_lock_bh(&rfcomm_dev_lock);
+			write_lock(&rfcomm_dev_lock);
 			list_del_init(&dev->list);
-			write_unlock_bh(&rfcomm_dev_lock);
+			write_unlock(&rfcomm_dev_lock);
 
 			rfcomm_dev_put(dev);
 		}
-- 
1.7.6.4

