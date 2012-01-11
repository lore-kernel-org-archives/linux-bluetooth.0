Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/5] Bluetooth: Clear ack_timer when sending ack
Date: Wed, 11 Jan 2012 10:59:47 +0100
Message-ID: <1326275989-32226-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1326275989-32226-1-git-send-email-szymon.janc@tieto.com>
References: <1326275989-32226-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ack_timer should be cleared when sending ACK to avoid acking I-frames
twice.

This commit introduces helper function (only send ack, not clearing
timer) which is used by l2cap_send_ack and l2cap_ack_timeout. This is
to avoid clearing ack timer in timer function.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 308d9d7..b9e232e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1478,7 +1478,7 @@ static int l2cap_retransmit_frames(struct l2cap_chan *chan)
 	return ret;
 }
 
-static void l2cap_send_ack(struct l2cap_chan *chan)
+static void __l2cap_send_ack(struct l2cap_chan *chan)
 {
 	u32 control = 0;
 
@@ -1498,6 +1498,12 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
 	l2cap_send_sframe(chan, control);
 }
 
+static void l2cap_send_ack(struct l2cap_chan *chan)
+{
+	__clear_ack_timer(chan);
+	__l2cap_send_ack(chan);
+}
+
 static void l2cap_send_srejtail(struct l2cap_chan *chan)
 {
 	struct srej_list *tail;
@@ -1988,7 +1994,7 @@ static void l2cap_ack_timeout(struct work_struct *work)
 	BT_DBG("chan %p", chan);
 
 	lock_sock(chan->sk);
-	l2cap_send_ack(chan);
+	__l2cap_send_ack(chan);
 	release_sock(chan->sk);
 }
 
-- 
on behalf of ST-Ericsson

