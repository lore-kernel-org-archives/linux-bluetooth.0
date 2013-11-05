Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH] android/client: Fix build for android 4.3
Date: Tue, 5 Nov 2013 12:48:41 +0100
Message-ID: <1383652121-4121-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Chagnes in HAL interface from 4.3 to 4.4 result in build failure:

target thumb C: haltest <=
    external/bluetooth/bluez/android/client/if-gatt.c
external/bluetooth/bluez/android/client/if-gatt.c:225:1:
    error: unknown type name 'btgatt_gatt_id_t'

This patch allows to build GATT for Android 4.3 (api level 18).
---

I sent this patch to the mailing list primarily to allow people
who work on android 4.3 to be able to build GATT.

 android/client/if-gatt.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index f070bb3..b2b20cb 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -21,6 +21,21 @@
 
 const btgatt_interface_t *if_gatt = NULL;
 
+/* In version 19 some callback were changed.
+ * btgatt_char_id_t -> btgatt_gatt_id_t
+ * bt_uuid_t        -> btgatt_gatt_id_t
+ */
+#if PLATFORM_SDK_VERSION > 18
+#define str2btgatt_descr_id_t str2btgatt_gatt_id_t
+#define btgatt_descr_id_t2str btgatt_gatt_id_t2str
+#define btgatt_descr_id_t btgatt_gatt_id_t
+#else
+#define btgatt_descr_id_t2str gatt_uuid_t2str
+#define str2btgatt_descr_id_t(a, b) gatt_str2bt_uuid_t(a, -1, b)
+#define btgatt_gatt_id_t btgatt_char_id_t
+#define btgatt_descr_id_t bt_uuid_t
+#endif
+
 #define MAX_CHAR_ID_STR_LEN (MAX_UUID_STR_LEN + 3 + 11)
 #define MAX_SRVC_ID_STR_LEN (MAX_UUID_STR_LEN + 3 + 11 + 1 + 11)
 /* How man characters print from binary objects (arbitrary) */
@@ -90,7 +105,7 @@ const btgatt_interface_t *if_gatt = NULL;
 #define VERIFY_DESCR_ID(n, v) \
 	do { \
 		if (n < argc) \
-			str2btgatt_gatt_id_t(argv[n], v); \
+			str2btgatt_descr_id_t(argv[n], v); \
 		else { \
 			haltest_error("No descr_id specified\n"); \
 			return;\
@@ -358,7 +373,7 @@ static char *btgatt_read_params_t2str(const btgatt_read_params_t *data,
 	sprintf(buf, "{srvc_id=%s, char_id=%s, descr_id=%s, val=%s value_type=%d, status=%d}",
 		btgatt_srvc_id_t2str(&data->srvc_id, srvc_id),
 		btgatt_gatt_id_t2str(&data->char_id, char_id),
-		btgatt_gatt_id_t2str(&data->descr_id, descr_id),
+		btgatt_descr_id_t2str(&data->descr_id, descr_id),
 		btgatt_unformatted_value_t2str(&data->value, value, 100),
 		data->value_type, data->status);
 	return buf;
@@ -455,7 +470,7 @@ static void gattc_get_characteristic_cb(int conn_id, int status,
 /* GATT descriptor enumeration result callback */
 static void gattc_get_descriptor_cb(int conn_id, int status,
 		btgatt_srvc_id_t *srvc_id, btgatt_gatt_id_t *char_id,
-		btgatt_gatt_id_t *descr_id)
+		btgatt_descr_id_t *descr_id)
 {
 	char buf[MAX_UUID_STR_LEN];
 	char srvc_id_buf[MAX_SRVC_ID_STR_LEN];
@@ -465,7 +480,7 @@ static void gattc_get_descriptor_cb(int conn_id, int status,
 				__func__, conn_id, status,
 				btgatt_srvc_id_t2str(srvc_id, srvc_id_buf),
 				btgatt_gatt_id_t2str(char_id, char_id_buf),
-				btgatt_gatt_id_t2str(descr_id, buf));
+				btgatt_descr_id_t2str(descr_id, buf));
 
 	if (status == 0)
 		EXEC(if_gatt->client->get_descriptor, conn_id, srvc_id, char_id,
@@ -1124,7 +1139,7 @@ static void read_descriptor_p(int argc, const char **argv)
 	int conn_id;
 	btgatt_srvc_id_t srvc_id;
 	btgatt_gatt_id_t char_id;
-	btgatt_gatt_id_t descr_id;
+	btgatt_descr_id_t descr_id;
 	int auth_req = 0;
 
 	RETURN_IF_NULL(if_gatt);
@@ -1166,7 +1181,7 @@ static void write_descriptor_p(int argc, const char **argv)
 	int conn_id;
 	btgatt_srvc_id_t srvc_id;
 	btgatt_gatt_id_t char_id;
-	btgatt_gatt_id_t descr_id;
+	btgatt_descr_id_t descr_id;
 	int write_type;
 	int len;
 	int auth_req = 0;
-- 
1.7.9.5

