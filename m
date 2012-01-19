Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 04/34] Bluetooth: Make l2cap_ertm_data_rcv available
Date: Thu, 19 Jan 2012 11:19:53 +0200
Message-Id: <1326964823-26747-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Function l2cap_ertm_data_rcv will be used by A2MP

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 60092cb..34a882b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -846,5 +846,6 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 int l2cap_chan_check_security(struct l2cap_chan *chan);
 void l2cap_ertm_init(struct l2cap_chan *chan);
+int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e36aaab..598805b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -73,8 +73,6 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data);
 static void l2cap_send_disconn_req(struct l2cap_conn *conn,
 				struct l2cap_chan *chan, int err);
 
-static int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb);
-
 /* ---- L2CAP channels ---- */
 
 static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16 cid)
-- 
1.7.4.1

