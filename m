Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 1/3] gatt: Add a new descriptor UUID
Date: Mon, 13 Aug 2012 09:23:14 -0300
Message-Id: <1344860596-30617-2-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1344860596-30617-1-git-send-email-jprvita@openbossa.org>
References: <1344860596-30617-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add the UUID of the External Report Reference descriptor.
---
 attrib/gatt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/attrib/gatt.h b/attrib/gatt.h
index c7e79ab..aab93b6 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -46,6 +46,7 @@
 #define GATT_CHARAC_FMT_UUID		0x2904
 #define GATT_CHARAC_AGREG_FMT_UUID	0x2905
 #define GATT_CHARAC_VALID_RANGE_UUID	0x2906
+#define GATT_EXTERNAL_REPORT_REFERENCE  0x2907
 #define GATT_REPORT_REFERENCE           0x2908
 
 /* Client Characteristic Configuration bit field */
-- 
1.7.11.2

