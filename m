Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 2/7] Bluetooth: Fix coding style in sco.c
Date: Thu, 17 May 2012 00:36:21 -0300
Message-Id: <1337225786-11064-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337225786-11064-1-git-send-email-gustavo@padovan.org>
References: <1337225786-11064-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Follow the net subsystem rules.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/sco.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index cbdd313..78473ff 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -523,7 +523,7 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 		goto done;
 
 	err = bt_sock_wait_state(sk, BT_CONNECTED,
-			sock_sndtimeo(sk, flags & O_NONBLOCK));
+				 sock_sndtimeo(sk, flags & O_NONBLOCK));
 
 done:
 	release_sock(sk);
@@ -788,7 +788,7 @@ static int sco_sock_shutdown(struct socket *sock, int how)
 
 		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
 			err = bt_sock_wait_state(sk, BT_CLOSED,
-							sk->sk_lingertime);
+						 sk->sk_lingertime);
 	}
 	release_sock(sk);
 	return err;
@@ -878,7 +878,7 @@ static void sco_conn_ready(struct sco_conn *conn)
 		bh_lock_sock(parent);
 
 		sk = sco_sock_alloc(sock_net(parent), NULL,
-				BTPROTO_SCO, GFP_ATOMIC);
+				    BTPROTO_SCO, GFP_ATOMIC);
 		if (!sk) {
 			bh_unlock_sock(parent);
 			goto done;
@@ -920,7 +920,7 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 			continue;
 
 		if (!bacmp(&bt_sk(sk)->src, &hdev->bdaddr) ||
-				!bacmp(&bt_sk(sk)->src, BDADDR_ANY)) {
+		    !bacmp(&bt_sk(sk)->src, BDADDR_ANY)) {
 			lm |= HCI_LM_ACCEPT;
 			break;
 		}
@@ -981,7 +981,7 @@ static int sco_debugfs_show(struct seq_file *f, void *p)
 
 	sk_for_each(sk, node, &sco_sk_list.head) {
 		seq_printf(f, "%s %s %d\n", batostr(&bt_sk(sk)->src),
-				batostr(&bt_sk(sk)->dst), sk->sk_state);
+			   batostr(&bt_sk(sk)->dst), sk->sk_state);
 	}
 
 	read_unlock(&sco_sk_list.lock);
@@ -1044,8 +1044,8 @@ int __init sco_init(void)
 	}
 
 	if (bt_debugfs) {
-		sco_debugfs = debugfs_create_file("sco", 0444,
-					bt_debugfs, NULL, &sco_debugfs_fops);
+		sco_debugfs = debugfs_create_file("sco", 0444, bt_debugfs,
+						  NULL, &sco_debugfs_fops);
 		if (!sco_debugfs)
 			BT_ERR("Failed to create SCO debug file");
 	}
-- 
1.7.10.1

