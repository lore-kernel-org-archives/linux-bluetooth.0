Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 7/7] Bluetooth: Adjust L2CAP Max PDU size for AMP packets
Date: Fri,  5 Oct 2012 16:56:58 +0300
Message-Id: <1349445419-16788-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1349445419-16788-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349445419-16788-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Maximum PDU size is defined by new BT Spec as 1492 octets.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 83fb9c7..caab98c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -39,7 +39,7 @@
 #define L2CAP_DEFAULT_MAX_TX		3
 #define L2CAP_DEFAULT_RETRANS_TO	2000    /* 2 seconds */
 #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
-#define L2CAP_DEFAULT_MAX_PDU_SIZE	1009    /* Sized for 3-DH5 packet */
+#define L2CAP_DEFAULT_MAX_PDU_SIZE	1492    /* Sized for AMP packet */
 #define L2CAP_DEFAULT_ACK_TO		200
 #define L2CAP_DEFAULT_MAX_SDU_SIZE	0xFFFF
 #define L2CAP_DEFAULT_SDU_ITIME		0xFFFFFFFF
-- 
1.7.9.5

