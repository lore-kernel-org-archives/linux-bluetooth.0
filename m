Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] gatt: Fix whitespace in UUID definitions
Date: Fri, 31 Aug 2012 16:36:32 +0200
Message-ID: <1346423792-29996-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attrib/gatt.h b/attrib/gatt.h
index a15e92f..6bb6f0f 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -46,8 +46,8 @@
 #define GATT_CHARAC_FMT_UUID		0x2904
 #define GATT_CHARAC_AGREG_FMT_UUID	0x2905
 #define GATT_CHARAC_VALID_RANGE_UUID	0x2906
-#define GATT_EXTERNAL_REPORT_REFERENCE  0x2907
-#define GATT_REPORT_REFERENCE           0x2908
+#define GATT_EXTERNAL_REPORT_REFERENCE	0x2907
+#define GATT_REPORT_REFERENCE		0x2908
 
 /* Client Characteristic Configuration bit field */
 #define GATT_CLIENT_CHARAC_CFG_NOTIF_BIT	0x0001
-- 
1.7.11.3

