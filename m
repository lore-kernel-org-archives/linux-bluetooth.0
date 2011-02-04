Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 14/16] Bluetooth: move L2CAP sock timers function to l2cap_sock.c
Date: Fri,  4 Feb 2011 04:01:56 -0200
Message-Id: <1296799318-5517-15-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-14-git-send-email-padovan@profusion.mobi>
References: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-2-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-3-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-4-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-5-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-6-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-7-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-8-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-9-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-10-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-11-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-12-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-13-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-14-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |   13 -------------
 net/bluetooth/l2cap_sock.c |   13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4e3a06e..1baa16c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -77,19 +77,6 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 
 static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
 
-/* ---- L2CAP timers ---- */
-void l2cap_sock_set_timer(struct sock *sk, long timeout)
-{
-	BT_DBG("sk %p state %d timeout %ld", sk, sk->sk_state, timeout);
-	sk_reset_timer(sk, &sk->sk_timer, jiffies + timeout);
-}
-
-void l2cap_sock_clear_timer(struct sock *sk)
-{
-	BT_DBG("sock %p state %d", sk, sk->sk_state);
-	sk_stop_timer(sk, &sk->sk_timer);
-}
-
 /* ---- L2CAP channels ---- */
 static struct sock *__l2cap_get_chan_by_dcid(struct l2cap_chan_list *l, u16 cid)
 {
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index fe4f834..23bb968 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -30,6 +30,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 
+/* ---- L2CAP timers ---- */
 static void l2cap_sock_timeout(unsigned long arg)
 {
 	struct sock *sk = (struct sock *) arg;
@@ -63,6 +64,18 @@ static void l2cap_sock_timeout(unsigned long arg)
 	sock_put(sk);
 }
 
+void l2cap_sock_set_timer(struct sock *sk, long timeout)
+{
+	BT_DBG("sk %p state %d timeout %ld", sk, sk->sk_state, timeout);
+	sk_reset_timer(sk, &sk->sk_timer, jiffies + timeout);
+}
+
+void l2cap_sock_clear_timer(struct sock *sk)
+{
+	BT_DBG("sock %p state %d", sk, sk->sk_state);
+	sk_stop_timer(sk, &sk->sk_timer);
+}
+
 static struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
 {
 	struct sock *sk;
-- 
1.7.4.rc3

