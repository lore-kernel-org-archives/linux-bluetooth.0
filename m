Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 03/20] Bluetooth: A2MP: sk_state_change for a2mp socket
Date: Wed,  2 Nov 2011 16:02:31 +0200
Message-Id: <1320242568-372-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    5 +++++
 net/bluetooth/a2mp.c         |   28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 95dfaeb..a3938f9 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -21,4 +21,9 @@ struct a2mp_work_data_ready {
 	int bytes;
 };
 
+struct a2mp_work_state_change {
+	struct work_struct work;
+	struct sock *sk;
+};
+
 #endif /* __A2MP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 2b41882..d0b15d8 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -56,6 +56,32 @@ static void a2mp_data_ready(struct sock *sk, int bytes)
 	}
 }
 
+static void state_change_worker(struct work_struct *w)
+{
+	struct a2mp_work_state_change *work = (struct a2mp_work_state_change *) w;
+	struct sock *sk = work->sk;
+
+	BT_DBG("sk %p", sk);
+	sock_put(work->sk);
+	kfree(work);
+}
+
+static void a2mp_state_change(struct sock *sk)
+{
+	struct a2mp_work_state_change *work;
+
+	work = kmalloc(sizeof(*work), GFP_KERNEL);
+	if (work) {
+		INIT_WORK(&work->work, state_change_worker);
+		sock_hold(sk);
+		work->sk = sk;
+		if (!queue_work(a2mp_workqueue, &work->work)) {
+			kfree(work);
+			sock_put(sk);
+		}
+	}
+}
+
 static void l2cap_fixed_channel_config(struct sock *sk)
 {
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
@@ -103,6 +129,8 @@ static struct socket *open_a2mp_sock(struct l2cap_conn *conn)
 
 	sk = sock->sk;
 	sk->sk_data_ready = a2mp_data_ready;
+	sk->sk_state_change = a2mp_state_change;
+
 	memset(&addr, 0, sizeof(addr));
 	bacpy(&addr.l2_bdaddr, conn->src);
 	addr.l2_family = AF_BLUETOOTH;
-- 
1.7.4.1

