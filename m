Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: 6lowpan: Remove redundant BT_CONNECTED assignment
Date: Tue,  6 Oct 2015 13:03:21 +0300
Message-Id: <1444125804-15577-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
References: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The L2CAP core code makes sure of setting the channel state to
BT_CONNECTED, so there's no need for the implementation code (6lowpan
in this case) to do it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/6lowpan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 3d951abfdf41..023fa29db709 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -788,8 +788,6 @@ static struct l2cap_chan *chan_open(struct l2cap_chan *pchan)
 	if (!chan)
 		return NULL;
 
-	chan->state = BT_CONNECTED;
-
 	return chan;
 }
 
-- 
2.4.3

