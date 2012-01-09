Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] Bluetooth: Drop L2CAP chan reference if ERTM ack_timer fired
Date: Mon, 9 Jan 2012 16:19:51 +0100
Message-ID: <1326122391-8438-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1326122391-8438-1-git-send-email-szymon.janc@tieto.com>
References: <1326122391-8438-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reference counter was incremented when starting ack timer but
decremented only when clearing timer, not when timer fired.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cd1eb6d..f4d2e4be 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1996,6 +1996,8 @@ static void l2cap_ack_timeout(struct work_struct *work)
 	lock_sock(chan->sk);
 	__l2cap_send_ack(chan);
 	release_sock(chan->sk);
+
+	l2cap_chan_put(chan);
 }
 
 static inline void l2cap_ertm_init(struct l2cap_chan *chan)
-- 
on behalf of ST-Ericsson

