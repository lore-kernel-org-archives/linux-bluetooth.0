Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 9/9] Bluetooth:  Use 3-DH5 payload size for default ERTM max PDU size.
Date: Wed,  4 Aug 2010 15:49:06 -0700
Message-Id: <1280962146-22604-10-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
References: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The previous value of 672 for L2CAP_DEFAULT_MAX_PDU_SIZE is based on
the default L2CAP MTU.  That default MTU is calculated from the size
of two DH5 packets, minus ACL and L2CAP b-frame header overhead.

ERTM is used with newer basebands that typically support larger 3-DH5
packets, and i-frames and s-frames have more header overhead.  With
clean RF conditions, basebands will typically attempt to use 1021-byte
3-DH5 packets for maximum throughput.  Adjusting for 2 bytes of ACL
headers plus 10 bytes of worst-case L2CAP headers yields 1009 bytes
of payload.

This PDU size imposes less overhead for header bytes and gives the
baseband the option to choose 3-DH5 packets, but is small enough for
ERTM traffic to interleave well with other L2CAP or SCO data.
672-byte payloads do not allow the most efficient over-the-air
packet choice, and cannot achieve maximum throughput over BR/EDR.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 16e412f..6c24144 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -35,7 +35,7 @@
 #define L2CAP_DEFAULT_MAX_TX		3
 #define L2CAP_DEFAULT_RETRANS_TO	2000    /* 2 seconds */
 #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
-#define L2CAP_DEFAULT_MAX_PDU_SIZE	672
+#define L2CAP_DEFAULT_MAX_PDU_SIZE	1009    /* Sized for 3-DH5 packet */
 #define L2CAP_DEFAULT_ACK_TO		200
 #define L2CAP_LOCAL_BUSY_TRIES		12
 
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
