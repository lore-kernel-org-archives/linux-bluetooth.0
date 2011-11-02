Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 02/20] Bluetooth: A2MP: sk_data_ready for a2mp socket
Date: Wed,  2 Nov 2011 16:02:30 +0200
Message-Id: <1320242568-372-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |   24 ++++++++++++++++++++++++
 net/bluetooth/a2mp.c         |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 include/net/bluetooth/a2mp.h

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
new file mode 100644
index 0000000..95dfaeb
--- /dev/null
+++ b/include/net/bluetooth/a2mp.h
@@ -0,0 +1,24 @@
+/*
+   Copyright (c) 2010-2011 Code Aurora Forum.  All rights reserved.
+   Copyright (c) 2011 Intel Corp.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 and
+   only version 2 as published by the Free Software Foundation.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+*/
+
+#ifndef __A2MP_H
+#define __A2MP_H
+
+struct a2mp_work_data_ready {
+	struct work_struct work;
+	struct sock *sk;
+	int bytes;
+};
+
+#endif /* __A2MP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index b69dd07..2b41882 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -17,6 +17,44 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/a2mp.h>
+
+static struct workqueue_struct *a2mp_workqueue;
+
+static void data_ready_worker(struct work_struct *w)
+{
+	struct a2mp_work_data_ready *work = (struct a2mp_work_data_ready *) w;
+	struct sock *sk = work->sk;
+	struct sk_buff *skb;
+
+	BT_DBG("sk %p", sk);
+
+	/* skb_dequeue() is thread-safe */
+	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
+		/* process a2mp here */
+		kfree_skb(skb);
+	}
+
+	sock_put(work->sk);
+	kfree(work);
+}
+
+static void a2mp_data_ready(struct sock *sk, int bytes)
+{
+	struct a2mp_work_data_ready *work;
+
+	work = kmalloc(sizeof(*work), GFP_KERNEL);
+	if (work) {
+		INIT_WORK(&work->work, data_ready_worker);
+		sock_hold(sk);
+		work->sk = sk;
+		work->bytes = bytes;
+		if (!queue_work(a2mp_workqueue, &work->work)) {
+			kfree(work);
+			sock_put(sk);
+		}
+	}
+}
 
 static void l2cap_fixed_channel_config(struct sock *sk)
 {
@@ -64,6 +102,7 @@ static struct socket *open_a2mp_sock(struct l2cap_conn *conn)
 	}
 
 	sk = sock->sk;
+	sk->sk_data_ready = a2mp_data_ready;
 	memset(&addr, 0, sizeof(addr));
 	bacpy(&addr.l2_bdaddr, conn->src);
 	addr.l2_family = AF_BLUETOOTH;
-- 
1.7.4.1

