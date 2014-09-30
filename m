Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/12] lib/uuid: Add define for GATT PnP ID UUID
Date: Tue, 30 Sep 2014 13:06:21 +0200
Message-Id: <1412075187-5518-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
References: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/uuid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 7901d34..8303772 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -127,6 +127,7 @@ extern "C" {
 #define GATT_CHARAC_HARDWARE_REVISION_STRING		0x2A27
 #define GATT_CHARAC_SOFTWARE_REVISION_STRING		0x2A28
 #define GATT_CHARAC_MANUFACTURER_NAME_STRING		0x2A29
+#define GATT_CHARAC_PNP_ID				0x2A50
 
 /* GATT Characteristic Descriptors */
 #define GATT_CHARAC_EXT_PROPER_UUID			0x2900
-- 
1.9.1

