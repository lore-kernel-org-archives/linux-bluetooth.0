Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@gmail.com,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 04/18] lib: Move GATT UUID to uuid.h
Date: Thu,  9 Jan 2014 13:38:09 -0300
Message-Id: <1389285503-19348-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1389285503-19348-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
 <1389285503-19348-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves GATT UUIDs definitions to a common header. uuid.h contains
helper functions to manipulate Bluetooth UUIDs and some common BR/EDR services
UUIDs.
---
 attrib/gatt.h | 25 -------------------------
 lib/uuid.h    | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/attrib/gatt.h b/attrib/gatt.h
index e5abd85..9e4ade2 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -24,31 +24,6 @@
 
 #include <bluetooth/sdp.h>
 
-/* GATT Profile Attribute types */
-#define GATT_PRIM_SVC_UUID		0x2800
-#define GATT_SND_SVC_UUID		0x2801
-#define GATT_INCLUDE_UUID		0x2802
-#define GATT_CHARAC_UUID		0x2803
-
-/* GATT Characteristic Types */
-#define GATT_CHARAC_DEVICE_NAME			0x2A00
-#define GATT_CHARAC_APPEARANCE			0x2A01
-#define GATT_CHARAC_PERIPHERAL_PRIV_FLAG	0x2A02
-#define GATT_CHARAC_RECONNECTION_ADDRESS	0x2A03
-#define GATT_CHARAC_PERIPHERAL_PREF_CONN	0x2A04
-#define GATT_CHARAC_SERVICE_CHANGED		0x2A05
-
-/* GATT Characteristic Descriptors */
-#define GATT_CHARAC_EXT_PROPER_UUID	0x2900
-#define GATT_CHARAC_USER_DESC_UUID	0x2901
-#define GATT_CLIENT_CHARAC_CFG_UUID	0x2902
-#define GATT_SERVER_CHARAC_CFG_UUID	0x2903
-#define GATT_CHARAC_FMT_UUID		0x2904
-#define GATT_CHARAC_AGREG_FMT_UUID	0x2905
-#define GATT_CHARAC_VALID_RANGE_UUID	0x2906
-#define GATT_EXTERNAL_REPORT_REFERENCE	0x2907
-#define GATT_REPORT_REFERENCE		0x2908
-
 /* Client Characteristic Configuration bit field */
 #define GATT_CLIENT_CHARAC_CFG_NOTIF_BIT	0x0001
 #define GATT_CLIENT_CHARAC_CFG_IND_BIT		0x0002
diff --git a/lib/uuid.h b/lib/uuid.h
index 95e5a9a..c24cee5 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -105,6 +105,31 @@ extern "C" {
 #define OBEX_MNS_UUID		"00001133-0000-1000-8000-00805f9b34fb"
 #define OBEX_MAP_UUID		"00001134-0000-1000-8000-00805f9b34fb"
 
+/* GATT UUIDs section */
+#define GATT_PRIM_SVC_UUID				0x2800
+#define GATT_SND_SVC_UUID				0x2801
+#define GATT_INCLUDE_UUID				0x2802
+#define GATT_CHARAC_UUID				0x2803
+
+/* GATT Characteristic Types */
+#define GATT_CHARAC_DEVICE_NAME				0x2A00
+#define GATT_CHARAC_APPEARANCE				0x2A01
+#define GATT_CHARAC_PERIPHERAL_PRIV_FLAG		0x2A02
+#define GATT_CHARAC_RECONNECTION_ADDRESS		0x2A03
+#define GATT_CHARAC_PERIPHERAL_PREF_CONN		0x2A04
+#define GATT_CHARAC_SERVICE_CHANGED			0x2A05
+
+/* GATT Characteristic Descriptors */
+#define GATT_CHARAC_EXT_PROPER_UUID			0x2900
+#define GATT_CHARAC_USER_DESC_UUID			0x2901
+#define GATT_CLIENT_CHARAC_CFG_UUID			0x2902
+#define GATT_SERVER_CHARAC_CFG_UUID			0x2903
+#define GATT_CHARAC_FMT_UUID				0x2904
+#define GATT_CHARAC_AGREG_FMT_UUID			0x2905
+#define GATT_CHARAC_VALID_RANGE_UUID			0x2906
+#define GATT_EXTERNAL_REPORT_REFERENCE			0x2907
+#define GATT_REPORT_REFERENCE				0x2908
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
1.8.3.1

