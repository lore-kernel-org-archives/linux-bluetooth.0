Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared/btp: Change struct member order for device found as in btp
Date: Mon, 12 Feb 2018 17:01:00 +0100
Message-Id: <20180212160102.31451-2-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180212160102.31451-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180212160102.31451-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes member order in device found struct definition to be
compatible with btp specification.
---
 src/shared/btp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/btp.h b/src/shared/btp.h
index 0b605be18..f0ac3a1ee 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -247,8 +247,8 @@ struct btp_new_settings_ev {
 
 #define BTP_EV_GAP_DEVICE_FOUND			0x81
 struct btp_device_found_ev {
-	bdaddr_t address;
 	uint8_t address_type;
+	bdaddr_t address;
 	int8_t rssi;
 	uint8_t flags;
 	uint16_t eir_len;
-- 
2.13.6

