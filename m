Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	<kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] Bluetooth: Fix double acking I-Frames when sending pending I-Frames
Date: Tue, 7 Feb 2012 15:43:02 +0100
Message-ID: <1328625782-19624-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1328625782-19624-1-git-send-email-szymon.janc@tieto.com>
References: <1328625782-19624-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pending I-Frame(s) are considered as acknowledgement. To void double
acking (via I-Frame and later via RR) clear ack timer when sending
first pending I-Frame.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5bb298d..8dece4e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1450,7 +1450,9 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 
 		if (bt_cb(skb)->retries == 1) {
 			chan->unacked_frames++;
-			nsent++;
+
+			if (!nsent++)
+				__clear_ack_timer(chan);
 		}
 
 		chan->frames_sent++;
-- 
on behalf of ST-Ericsson

