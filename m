Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: mesh: Correct segmentation logic
Date: Wed, 11 Oct 2017 13:06:24 -0600
Message-Id: <20171011190624.2093-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The decision whether to segment or not didn't consider the size of the MIC

diff --git a/mesh/net.c b/mesh/net.c
index 2d75c4f7d..96e82fe1c 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2098,7 +2098,7 @@ bool net_access_layer_send(uint8_t ttl, uint16_t src, uint32_t dst,
 	if (!result)
 		return false;
 
-	segN = SEG_MAX(len);
+	segN = SEG_MAX(len + sizeof(uint32_t));
 
 	/* Only one ACK required SAR message per destination at a time */
 	if (segN && IS_UNICAST(dst)) {
