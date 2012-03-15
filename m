Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 07/30] Bluetooth: A2MP: Create A2MP channel
Date: Thu, 15 Mar 2012 14:29:58 +0200
Message-Id: <1331814621-13905-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Create fixed A2MP channel

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    3 ++
 net/bluetooth/a2mp.c          |   63 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 net/bluetooth/a2mp.c

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 1a5c9e6..b3f9854 100644
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
@@ -224,6 +226,7 @@ struct l2cap_conn_rsp {
 /* channel indentifier */
 #define L2CAP_CID_SIGNALING	0x0001
 #define L2CAP_CID_CONN_LESS	0x0002
+#define L2CAP_CID_A2MP		0x0003
 #define L2CAP_CID_LE_DATA	0x0004
 #define L2CAP_CID_LE_SIGNALING	0x0005
 #define L2CAP_CID_SMP		0x0006
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
new file mode 100644
index 0000000..52bb7d8
--- /dev/null
+++ b/net/bluetooth/a2mp.c
@@ -0,0 +1,63 @@
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
+#include <net/bluetooth/l2cap.h>
+
+static struct l2cap_ops a2mp_chan_ops = {
+	.name		= "L2CAP A2MP channel",
+};
+
+static struct l2cap_chan *open_a2mp_chan(struct l2cap_conn *conn)
+{
+	struct l2cap_chan *chan;
+
+	chan = l2cap_chan_create(NULL);
+
+	hci_conn_hold(conn->hcon);
+
+	BT_DBG("chan %p", chan);
+
+	chan->sec_level = BT_SECURITY_LOW;
+	chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
+	chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
+	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
+	chan->fcs = L2CAP_FCS_CRC16;
+
+	chan->ops = &a2mp_chan_ops;
+
+	set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
+
+	chan->max_tx = 0xFF;
+	chan->remote_max_tx = chan->max_tx;
+
+	/* Send 10 packets without ack */
+	chan->tx_win = 10;
+	chan->tx_win_max = L2CAP_DEFAULT_TX_WINDOW;
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
+	chan->remote_mps = chan->omtu;
+	chan->mps = chan->omtu;
+
+	return chan;
+}
-- 
1.7.9.1

