Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] Bluetooth: Make l2cap_ertm_data_rcv static
Date: Tue, 17 Jan 2012 11:42:30 +0100
Message-ID: <1326796951-16377-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is not used outside of l2cap_core.c.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0087db8..d66c368 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4139,7 +4139,7 @@ static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u32 rx_cont
 	return 0;
 }
 
-int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
+static int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	u32 control;
 	u16 req_seq;
-- 
on behalf of ST-Ericsson

