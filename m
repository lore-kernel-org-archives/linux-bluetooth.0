Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] shared/btp: define gap device found flags as bit mask
Date: Thu, 21 Dec 2017 17:47:15 +0100
Message-Id: <20171221164720.20925-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch modifies gap device found flags to be bit masks as in other
defined flags groups in btp.
---
 src/shared/btp.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/shared/btp.h b/src/shared/btp.h
index 5044de822..7b1f48817 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -241,9 +241,9 @@ struct btp_new_settings_ev {
 	uint32_t current_settings;
 } __packed;
 
-#define BTP_EV_GAP_DEVICE_FOUND_FLAG_RSSI	0x00
-#define BTP_EV_GAP_DEVICE_FOUND_FLAG_AD		0x01
-#define BTP_EV_GAP_DEVICE_FOUND_FLAG_SR		0x02
+#define BTP_EV_GAP_DEVICE_FOUND_FLAG_RSSI	0x01
+#define BTP_EV_GAP_DEVICE_FOUND_FLAG_AD		0x02
+#define BTP_EV_GAP_DEVICE_FOUND_FLAG_SR		0x04
 
 #define BTP_EV_GAP_DEVICE_FOUND			0x81
 struct btp_device_found_ev {
-- 
2.13.6

