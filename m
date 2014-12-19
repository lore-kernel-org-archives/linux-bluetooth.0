Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: 6lowpan: Add IPSP PSM value
Date: Fri, 19 Dec 2014 10:39:08 +0200
Message-Id: <1418978348-15816-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Internet Protocol Support Profile a.k.a BT 6LoWPAN spesification
is ready so PSM value for it is now known.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 include/net/bluetooth/l2cap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d1bb342..2239a37 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -248,6 +248,7 @@ struct l2cap_conn_rsp {
 #define L2CAP_PSM_SDP		0x0001
 #define L2CAP_PSM_RFCOMM	0x0003
 #define L2CAP_PSM_3DSP		0x0021
+#define L2CAP_PSM_IPSP		0x0023 /* 6LoWPAN */
 
 /* channel identifier */
 #define L2CAP_CID_SIGNALING	0x0001
-- 
1.8.3.1

