Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: L2CAP: Fix checked range when allocating new CID
Date: Mon,  2 Nov 2015 14:39:16 +0200
Message-Id: <1446467957-19646-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1446467957-19646-1-git-send-email-johan.hedberg@gmail.com>
References: <1446467957-19646-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The 'dyn_end' value is also a valid CID so it should be included in
the range of values checked.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8fd36f59dcde..fdb7989e2997 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -239,7 +239,7 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 	else
 		dyn_end = L2CAP_CID_DYN_END;
 
-	for (cid = L2CAP_CID_DYN_START; cid < dyn_end; cid++) {
+	for (cid = L2CAP_CID_DYN_START; cid <= dyn_end; cid++) {
 		if (!__l2cap_get_chan_by_scid(conn, cid))
 			return cid;
 	}
-- 
2.5.0

