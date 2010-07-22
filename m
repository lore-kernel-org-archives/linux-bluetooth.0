Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 1/5] Spec constants for Extended Inquiry Response field types
Date: Thu, 22 Jul 2010 09:06:16 -0700
Message-Id: <1279814780-29673-2-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
References: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sdpd.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/src/sdpd.h b/src/sdpd.h
index e93b0b6..c1d69a9 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -34,6 +34,19 @@
 #define SDPDBG(fmt...)
 #endif
 
+#define EIR_DATA_LENGTH  240
+
+#define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available */
+#define EIR_UUID16_ALL              0x03  /* 16-bit UUID, all listed */
+#define EIR_UUID32_SOME             0x04  /* 32-bit UUID, more available */
+#define EIR_UUID32_ALL              0x05  /* 32-bit UUID, all listed */
+#define EIR_UUID128_SOME            0x06  /* 128-bit UUID, more available */
+#define EIR_UUID128_ALL             0x07  /* 128-bit UUID, all listed */
+#define EIR_NAME_SHORT              0x08  /* shortened local name */
+#define EIR_NAME_COMPLETE           0x09  /* complete local name */
+#define EIR_TX_POWER                0x0A  /* Transmit power level */
+#define EIR_DEVICE_ID               0x10  /* device ID */
+
 typedef struct request {
 	bdaddr_t device;
 	bdaddr_t bdaddr;
-- 
1.7.1

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
