Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: L2CAP: Fix auto-allocating LE PSM values
Date: Tue, 26 Jan 2016 17:19:10 -0500
Message-Id: <1453846751-5925-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1453846751-5925-1-git-send-email-johan.hedberg@gmail.com>
References: <1453846751-5925-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The LE dynamic PSM range is different from BR/EDR (0x0080 - 0x00ff)
and doesn't have requirements relating to parity, so separate checks
are needed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 39a5149f3010..eb4f5f24cbe3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -197,10 +197,20 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
 		chan->sport = psm;
 		err = 0;
 	} else {
-		u16 p;
+		u16 p, start, end, incr;
+
+		if (chan->src_type == BDADDR_BREDR) {
+			start = L2CAP_PSM_DYN_START;
+			end = L2CAP_PSM_AUTO_END;
+			incr = 2;
+		} else {
+			start = L2CAP_PSM_LE_DYN_START;
+			end = L2CAP_PSM_LE_DYN_END;
+			incr = 1;
+		}
 
 		err = -EINVAL;
-		for (p = 0x1001; p < 0x1100; p += 2)
+		for (p = start; p <= end; p += incr)
 			if (!__l2cap_global_chan_by_addr(cpu_to_le16(p), src)) {
 				chan->psm   = cpu_to_le16(p);
 				chan->sport = cpu_to_le16(p);
-- 
2.5.0

