Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>,
	Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2] Bluetooth: Make l2cap_ertm_data_rcv static
Date: Mon, 23 Jan 2012 10:06:05 +0100
Message-ID: <1327309565-17367-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is not used outside of l2cap_core.c. Also l2cap_ertm_data_rcv is
only used after it is defined so there is no need for forward declaration.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e42999c..979d5a5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -73,8 +73,6 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data);
 static void l2cap_send_disconn_req(struct l2cap_conn *conn,
 				struct l2cap_chan *chan, int err);
 
-static int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb);
-
 /* ---- L2CAP channels ---- */
 
 static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16 cid)
@@ -4139,7 +4137,7 @@ static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u32 rx_cont
 	return 0;
 }
 
-int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
+static int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	u32 control;
 	u16 req_seq;
-- 
on behalf of ST-Ericsson

