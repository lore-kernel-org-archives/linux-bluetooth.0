Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <ulrik.lauren@stericsson.com>, <kanak.gupta@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] Bluetooth: Add debug print to l2cap_chan_create
Date: Thu, 3 Nov 2011 16:05:44 +0100
Message-ID: <1320332745-21750-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index af3e8c5..9dcbf3d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -294,6 +294,8 @@ struct l2cap_chan *l2cap_chan_create(struct sock *sk)
 
 	atomic_set(&chan->refcnt, 1);
 
+	BT_DBG("sk %p chan %p", sk, chan);
+
 	return chan;
 }
 
-- 
on behalf of ST-Ericsson

