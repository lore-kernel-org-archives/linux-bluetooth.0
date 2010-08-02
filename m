Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 8/8] Bluetooth:  Use 3-DH5 payload size for default ERTM max PDU size.
Date: Mon,  2 Aug 2010 12:20:10 -0700
Message-Id: <1280776810-18213-9-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 16e412f..93aba17 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -35,7 +35,7 @@
 #define L2CAP_DEFAULT_MAX_TX		3
 #define L2CAP_DEFAULT_RETRANS_TO	2000    /* 2 seconds */
 #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
-#define L2CAP_DEFAULT_MAX_PDU_SIZE	672
+#define L2CAP_DEFAULT_MAX_PDU_SIZE	1011    /* Sized for 3-DH5 packet */
 #define L2CAP_DEFAULT_ACK_TO		200
 #define L2CAP_LOCAL_BUSY_TRIES		12
 
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
