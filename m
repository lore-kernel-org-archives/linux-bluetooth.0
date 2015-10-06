Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: 6lowpan: Fix imtu & omtu values
Date: Tue,  6 Oct 2015 13:03:19 +0300
Message-Id: <1444125804-15577-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
References: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The omtu value is determined by the remote peer so there's no point in
trying to hard-code it to any value. The IPSP specification otoh gives
a more reasonable value for the imtu, i.e. 1280.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/6lowpan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 131e79cde350..3e20f7a60d61 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -775,8 +775,7 @@ static struct l2cap_chan *chan_create(void)
 
 	chan->chan_type = L2CAP_CHAN_CONN_ORIENTED;
 	chan->mode = L2CAP_MODE_LE_FLOWCTL;
-	chan->omtu = 65535;
-	chan->imtu = chan->omtu;
+	chan->imtu = 1280;
 
 	return chan;
 }
-- 
2.4.3

