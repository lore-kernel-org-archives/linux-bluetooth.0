Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: 6lowpan: Make sure skb exists before accessing it
Date: Mon, 29 Sep 2014 10:55:46 +0300
Message-Id: <1411977346-10219-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need to make sure that the saved skb exists when
resuming or suspending a CoC channel. This can happen if
initial credits is 0 when channel is connected.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index c9effc1..d3d26fe 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -966,6 +966,9 @@ static void chan_suspend_cb(struct l2cap_chan *chan)
 
 	BT_DBG("chan %p conn %p skb %p", chan, chan->conn, skb);
 
+	if (!skb)
+		return;
+
 	lowpan_cb(skb)->status = -EAGAIN;
 }
 
@@ -975,6 +978,9 @@ static void chan_resume_cb(struct l2cap_chan *chan)
 
 	BT_DBG("chan %p conn %p skb %p", chan, chan->conn, skb);
 
+	if (!skb)
+		return;
+
 	lowpan_cb(skb)->status = 0;
 }
 
-- 
1.8.3.1

