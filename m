Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 09/15] android/hardware: Update bt_gatt_types.h header
Date: Thu,  6 Nov 2014 17:05:54 +0200
Message-Id: <1415286360-26268-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hardware/bt_gatt_types.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/hardware/bt_gatt_types.h b/android/hardware/bt_gatt_types.h
index 0ac217e..e037ddc 100644
--- a/android/hardware/bt_gatt_types.h
+++ b/android/hardware/bt_gatt_types.h
@@ -43,6 +43,14 @@ typedef struct
     uint8_t             is_primary;
 } btgatt_srvc_id_t;
 
+/** Preferred physical Transport for GATT connection */
+typedef enum
+{
+    GATT_TRANSPORT_AUTO,
+    GATT_TRANSPORT_BREDR,
+    GATT_TRANSPORT_LE
+} btgatt_transport_t;
+
 __END_DECLS
 
 #endif /* ANDROID_INCLUDE_BT_GATT_TYPES_H */
-- 
1.9.1

