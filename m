Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix L2CAP_CR_SCID_IN_USE value
Date: Wed,  8 Mar 2017 14:09:41 +0100
Message-Id: <1488978581-9574-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix issue found during L2CAP qualification test TP/LE/CFC/BV-20-C.

Signed-off-by: Marcin Kraglak <marcin.kraglak@tieto.com>
---
 include/net/bluetooth/l2cap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5ee3c68..0697fd4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -282,7 +282,7 @@ struct l2cap_conn_rsp {
 #define L2CAP_CR_BAD_KEY_SIZE	0x0007
 #define L2CAP_CR_ENCRYPTION	0x0008
 #define L2CAP_CR_INVALID_SCID	0x0009
-#define L2CAP_CR_SCID_IN_USE	0x0010
+#define L2CAP_CR_SCID_IN_USE	0x000A
 
 /* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
-- 
2.5.5

