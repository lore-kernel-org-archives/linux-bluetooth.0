Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 12/21] gatt: add Report Reference descriptor UUID
Date: Tue,  3 Jul 2012 15:43:04 -0300
Message-Id: <1341340993-7480-13-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
References: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 attrib/gatt.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/attrib/gatt.h b/attrib/gatt.h
index 9ffe58f..c7e79ab 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -46,6 +46,7 @@
 #define GATT_CHARAC_FMT_UUID		0x2904
 #define GATT_CHARAC_AGREG_FMT_UUID	0x2905
 #define GATT_CHARAC_VALID_RANGE_UUID	0x2906
+#define GATT_REPORT_REFERENCE           0x2908
 
 /* Client Characteristic Configuration bit field */
 #define GATT_CLIENT_CHARAC_CFG_NOTIF_BIT	0x0001
-- 
1.7.10.4

