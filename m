Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv7 01/23] Bluetooth: A2MP: Create A2MP channel
Date: Fri, 20 Apr 2012 14:09:29 +0300
Message-Id: <1334920191-29308-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Create and initialize fixed A2MP channel

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    5 ++++
 net/bluetooth/Makefile        |    3 ++-
 net/bluetooth/a2mp.c          |   59 +++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c    |    4 +--
 4 files changed, 68 insertions(+), 3 deletions(-)
 create mode 100644 net/bluetooth/a2mp.c

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0fac788..a8c4457 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -51,6 +51,8 @@
 #define L2CAP_CONN_TIMEOUT		msecs_to_jiffies(40000)
 #define L2CAP_INFO_TIMEOUT		msecs_to_jiffies(4000)
 
+#define L2CAP_A2MP_DEFAULT_MTU		670
+
 /* L2CAP socket address */
 struct sockaddr_l2 {
 	sa_family_t	l2_family;
@@ -230,6 +232,7 @@ struct l2cap_conn_rsp {
 /* channel indentifier */
 #define L2CAP_CID_SIGNALING	0x0001
 #define L2CAP_CID_CONN_LESS	0x0002
+#define L2CAP_CID_A2MP		0x0003
 #define L2CAP_CID_LE_DATA	0x0004
 #define L2CAP_CID_LE_SIGNALING	0x0005
 #define L2CAP_CID_SMP		0x0006
@@ -927,5 +930,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 int l2cap_chan_check_security(struct l2cap_chan *chan);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan);
+int l2cap_ertm_init(struct l2cap_chan *chan);
+void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 2dc5a57..fa6d94a 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_BT_CMTP)	+= cmtp/
 obj-$(CONFIG_BT_HIDP)	+= hidp/
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
-	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o
+	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
+	a2mp.o
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
new file mode 100644
index 0000000..1f733b5
--- /dev/null
+++ b/net/bluetooth/a2mp.c
@@ -0,0 +1,59 @@
+/*
+   Copyright (c) 2010,2011 Code Aurora Forum.  All rights reserved.
+   Copyright (c) 2011,2012 Intel Corp.
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
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/l2cap.h>
+
+static struct l2cap_ops a2mp_chan_ops = {
+	.name = "L2CAP A2MP channel",
+};
+
+static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
+{
+	struct l2cap_chan *chan;
+
+	chan = l2cap_chan_create();
+	if (!chan)
+		return NULL;
+
+	BT_DBG("chan %p", chan);
+
+	hci_conn_hold(conn->hcon);
+
+	chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
+	chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
+	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
+
+	chan->ops = &a2mp_chan_ops;
+
+	l2cap_chan_set_defaults(chan);
+	chan->remote_max_tx = chan->max_tx;
+	chan->remote_tx_win = chan->tx_win;
+
+	chan->retrans_timeout = L2CAP_DEFAULT_RETRANS_TO;
+	chan->monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
+
+	skb_queue_head_init(&chan->tx_q);
+
+	chan->mode = L2CAP_MODE_ERTM;
+	l2cap_ertm_init(chan);
+
+	l2cap_chan_add(conn, chan);
+
+	chan->remote_mps = chan->omtu;
+	chan->mps = chan->omtu;
+
+	return chan;
+}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 97bb212..b6d0d0b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -472,7 +472,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	list_add(&chan->list, &conn->chan_l);
 }
 
-static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
+void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
 	mutex_lock(&conn->chan_lock);
 	__l2cap_chan_add(conn, chan);
@@ -2273,7 +2273,7 @@ static void l2cap_ack_timeout(struct work_struct *work)
 	l2cap_chan_put(chan);
 }
 
-static inline int l2cap_ertm_init(struct l2cap_chan *chan)
+int l2cap_ertm_init(struct l2cap_chan *chan)
 {
 	int err;
 
-- 
1.7.9.5

