Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: 6lowpan: Remove redundant (and incorrect) MPS assignments
Date: Tue,  6 Oct 2015 13:03:20 +0300
Message-Id: <1444125804-15577-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
References: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The L2CAP core code already sets the local MPS to a sane value. The
remote MPS value otoh comes from the remote side so there's no point
in trying to hard-code it to any value.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/6lowpan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 3e20f7a60d61..3d951abfdf41 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -788,9 +788,6 @@ static struct l2cap_chan *chan_open(struct l2cap_chan *pchan)
 	if (!chan)
 		return NULL;
 
-	chan->remote_mps = chan->omtu;
-	chan->mps = chan->omtu;
-
 	chan->state = BT_CONNECTED;
 
 	return chan;
-- 
2.4.3

