Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 01/21] Bluetooth: A2MP: Create A2MP socket
Date: Thu, 10 Nov 2011 16:54:08 +0200
Message-Id: <1320936868-7978-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Create fixed channel A2MP socket

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    4 ++
 net/bluetooth/a2mp.c          |   94 +++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c    |    2 +-
 3 files changed, 99 insertions(+), 1 deletions(-)
 create mode 100644 net/bluetooth/a2mp.c

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9280bff..c0af77c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -48,6 +48,8 @@
 #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
 #define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */
 
+#define L2CAP_A2MP_DEFAULT_MTU		670
+
 /* L2CAP socket address */
 struct sockaddr_l2 {
 	sa_family_t	l2_family;
@@ -221,6 +223,7 @@ struct l2cap_conn_rsp {
 /* channel indentifier */
 #define L2CAP_CID_SIGNALING	0x0001
 #define L2CAP_CID_CONN_LESS	0x0002
+#define L2CAP_CID_A2MP		0x0003
 #define L2CAP_CID_LE_DATA	0x0004
 #define L2CAP_CID_LE_SIGNALING	0x0005
 #define L2CAP_CID_SMP		0x0006
@@ -807,5 +810,6 @@ int l2cap_chan_connect(struct l2cap_chan *chan);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 								u32 priority);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
+void l2cap_ertm_init(struct l2cap_chan *chan);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
new file mode 100644
index 0000000..293a765
--- /dev/null
+++ b/net/bluetooth/a2mp.c
@@ -0,0 +1,94 @@
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
+#include <linux/workqueue.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/l2cap.h>
+
+static void l2cap_fixed_channel_config(struct sock *sk)
+{
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
+	lock_sock(sk);
+
+	chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
+	chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
+	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
+	chan->fcs = L2CAP_FCS_CRC16;
+
+	chan->max_tx = 0xFF;
+	chan->remote_max_tx = chan->max_tx;
+
+	/* Send 10 packets without ack */
+	chan->tx_win = 10;
+	chan->remote_tx_win = chan->tx_win;
+
+	chan->remote_mps = chan->omtu;
+	chan->mps = chan->omtu;
+
+	chan->retrans_timeout = L2CAP_DEFAULT_RETRANS_TO;
+	chan->monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
+
+	skb_queue_head_init(&chan->tx_q);
+
+	chan->mode = L2CAP_MODE_ERTM;
+	l2cap_ertm_init(chan);
+
+	release_sock(sk);
+}
+
+static struct socket *open_a2mp_sock(struct l2cap_conn *conn)
+{
+	int err;
+	struct socket *sock;
+	struct sockaddr_l2 addr;
+	struct sock *sk;
+
+	err = sock_create_kern(PF_BLUETOOTH, SOCK_SEQPACKET,
+					BTPROTO_L2CAP, &sock);
+	if (err) {
+		BT_ERR("sock_create_kern failed %d", err);
+		return NULL;
+	}
+
+	sk = sock->sk;
+	memset(&addr, 0, sizeof(addr));
+	bacpy(&addr.l2_bdaddr, conn->src);
+	addr.l2_family = AF_BLUETOOTH;
+	addr.l2_cid = L2CAP_CID_A2MP;
+	err = kernel_bind(sock, (struct sockaddr *) &addr, sizeof(addr));
+	if (err) {
+		BT_ERR("kernel_bind failed %d", err);
+		sock_release(sock);
+		return NULL;
+	}
+
+	l2cap_fixed_channel_config(sk);
+
+	memset(&addr, 0, sizeof(addr));
+	bacpy(&addr.l2_bdaddr, conn->dst);
+	addr.l2_family = AF_BLUETOOTH;
+	addr.l2_cid = L2CAP_CID_A2MP;
+	err = kernel_connect(sock, (struct sockaddr *) &addr, sizeof(addr),
+							O_NONBLOCK);
+	if ((err == 0) || (err == -EINPROGRESS))
+		return sock;
+	else {
+		BT_ERR("kernel_connect failed %d", err);
+		sock_release(sock);
+		return NULL;
+	}
+}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f850684..56b94c0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1942,7 +1942,7 @@ static void l2cap_ack_timeout(unsigned long arg)
 	bh_unlock_sock(chan->sk);
 }
 
-static inline void l2cap_ertm_init(struct l2cap_chan *chan)
+void l2cap_ertm_init(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->sk;
 
-- 
1.7.4.1

