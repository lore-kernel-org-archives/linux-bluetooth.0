Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 29/32] Bluetooth: Fix CID ranges for LE CoC CID allocations
Date: Thu,  5 Dec 2013 15:11:27 +0200
Message-Id: <1386249090-10236-30-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

LE CoC used differend CIC ranges than BR/EDR L2CAP. The start of the
range is the same (0x0040) but the range ends at 0x007f (unlike BR/EDR
where it goes all the way to 0xffff).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h | 1 +
 net/bluetooth/l2cap_core.c    | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a4616eeeb8b5..ef6ca5fa8f5e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -252,6 +252,7 @@ struct l2cap_conn_rsp {
 #define L2CAP_CID_SMP		0x0006
 #define L2CAP_CID_DYN_START	0x0040
 #define L2CAP_CID_DYN_END	0xffff
+#define L2CAP_CID_LE_DYN_END	0x007f
 
 /* connect/create channel results */
 #define L2CAP_CR_SUCCESS	0x0000
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e6bf5ed16313..e447bbedcabf 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -213,9 +213,14 @@ int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid)
 
 static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 {
-	u16 cid = L2CAP_CID_DYN_START;
+	u16 cid, dyn_end;
 
-	for (; cid < L2CAP_CID_DYN_END; cid++) {
+	if (conn->hcon->type == LE_LINK)
+		dyn_end = L2CAP_CID_LE_DYN_END;
+	else
+		dyn_end = L2CAP_CID_DYN_END;
+
+	for (cid = L2CAP_CID_DYN_START; cid < dyn_end; cid++) {
 		if (!__l2cap_get_chan_by_scid(conn, cid))
 			return cid;
 	}
-- 
1.8.4.2

