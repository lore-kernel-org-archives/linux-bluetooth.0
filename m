Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix correct nesting for 6lowpan server channel
Date: Thu, 13 Nov 2014 09:46:05 +0200
Message-Id: <1415864765-7507-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1415864765-7507-1-git-send-email-johan.hedberg@gmail.com>
References: <1415864765-7507-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Server channels in BT_LISTEN state should use L2CAP_NESTING_PARENT. This
patch fixes the nesting value for the 6lowpan channel.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/6lowpan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 3d8ceb251d75..bdcaefd2db12 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1130,6 +1130,8 @@ static struct l2cap_chan *bt_6lowpan_listen(void)
 	pchan->state = BT_LISTEN;
 	pchan->src_type = BDADDR_LE_PUBLIC;
 
+	atomic_set(&pchan->nesting, L2CAP_NESTING_PARENT);
+
 	BT_DBG("psm 0x%04x chan %p src type %d", psm_6lowpan, pchan,
 	       pchan->src_type);
 
-- 
2.1.0

