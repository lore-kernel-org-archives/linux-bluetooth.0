Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 02/20] Bluetooth: A2MP: Add data_ready and state_change
Date: Thu, 22 Dec 2011 13:06:08 +0200
Message-Id: <1324551986-29431-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds sk_data_ready and sk_state_change for A2MP socket

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |   20 ++++++++++++++++++++
 net/bluetooth/a2mp.c         |   22 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100644 include/net/bluetooth/a2mp.h

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
new file mode 100644
index 0000000..97a0752
--- /dev/null
+++ b/include/net/bluetooth/a2mp.h
@@ -0,0 +1,20 @@
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
+void a2mp_incoming(struct l2cap_conn *conn, struct sk_buff *skb);
+
+#endif /* __A2MP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index a5e9d17..87ff996 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -14,6 +14,25 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/a2mp.h>
+
+static void a2mp_data_ready(struct sock *sk, int bytes)
+{
+	struct sk_buff *skb;
+
+	BT_DBG("sk %p", sk);
+
+	/* skb_dequeue() is thread-safe */
+	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
+		/* process a2mp here */
+		kfree_skb(skb);
+	}
+}
+
+static void a2mp_state_change(struct sock *sk)
+{
+	BT_DBG("sk %p", sk);
+}
 
 static void l2cap_fixed_channel_config(struct sock *sk)
 {
@@ -62,6 +81,9 @@ static struct socket *open_a2mp_sock(struct l2cap_conn *conn)
 	}
 
 	sk = sock->sk;
+	sk->sk_data_ready = a2mp_data_ready;
+	sk->sk_state_change = a2mp_state_change;
+
 	memset(&addr, 0, sizeof(addr));
 	bacpy(&addr.l2_bdaddr, conn->src);
 	addr.l2_family = AF_BLUETOOTH;
-- 
1.7.4.1

