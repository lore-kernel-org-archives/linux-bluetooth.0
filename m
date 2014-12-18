Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] Bluetooth: 6lowpan: Add IPSP PSM value
Date: Thu, 18 Dec 2014 14:23:51 +0200
Message-Id: <1418905432-19793-2-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1418905432-19793-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1418905432-19793-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Internet Protocol Support Profile a.k.a BT 6LoWPAN spesification
is ready so PSM value for it is now known.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 include/net/bluetooth/l2cap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index eee3ef5..f71644f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -248,6 +248,7 @@ struct l2cap_conn_rsp {
 #define L2CAP_PSM_SDP		0x0001
 #define L2CAP_PSM_RFCOMM	0x0003
 #define L2CAP_PSM_3DSP		0x0021
+#define L2CAP_PSM_LE_PSM_IPSP	0x0023 /* 6LoWPAN */
 
 /* channel identifier */
 #define L2CAP_CID_SIGNALING	0x0001
-- 
1.8.3.1

