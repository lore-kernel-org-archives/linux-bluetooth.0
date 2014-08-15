Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] Bluetooth: Remove unnecessary l2cap_chan_unlock before l2cap_chan_add
Date: Fri, 15 Aug 2014 21:06:52 +0300
Message-Id: <1408126019-29761-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408126019-29761-1-git-send-email-johan.hedberg@gmail.com>
References: <1408126019-29761-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The l2cap_chan_add() function doesn't require the channel to be
unlocked. It only requires the l2cap_conn to be unlocked. Therefore,
it's unnecessary to unlock a channel before calling l2cap_chan_add().
This patch removes such unnecessary unlocking from the
l2cap_chan_connect() function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 52b56808d5d3..777c41dbfdbe 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7078,9 +7078,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	bacpy(&chan->src, &hcon->src);
 	chan->src_type = bdaddr_type(hcon, hcon->src_type);
 
-	l2cap_chan_unlock(chan);
 	l2cap_chan_add(conn, chan);
-	l2cap_chan_lock(chan);
 
 	/* l2cap_chan_add takes its own ref so we can drop this one */
 	hci_conn_drop(hcon);
-- 
1.9.3

