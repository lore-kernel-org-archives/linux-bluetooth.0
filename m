Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 2/5 v2] Add more functions for new UUID handling
Date: Fri, 11 Mar 2011 11:30:10 -0300
Message-Id: <1299853813-15753-2-git-send-email-epx@signove.com>
In-Reply-To: <1299853813-15753-1-git-send-email-epx@signove.com>
References: <1299853813-15753-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds more functions that are necessary to handle
the new bt_uuid_t type, and moves basic things like
byte-swapping functions and uint128_t type to bluetooth.h.
---
 health/mcap_sync.c |   15 -----
 lib/bluetooth.h    |   54 ++++++++++++++++++
 lib/sdp.c          |   43 --------------
 lib/sdp.h          |    4 +-
 lib/uuid.c         |  159 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/uuid.h         |   12 +++-
 test/hciemu.c      |   16 -----
 7 files changed, 222 insertions(+), 81 deletions(-)

diff --git a/health/mcap_sync.c b/health/mcap_sync.c
index 6f90344..f4b005a 100644
--- a/health/mcap_sync.c
+++ b/health/mcap_sync.c
@@ -92,21 +92,6 @@ struct sync_set_data {
 	gboolean role;
 };
 
-/* Ripped from lib/sdp.c */
-
-#if __BYTE_ORDER == __BIG_ENDIAN
-#define ntoh64(x) (x)
-#else
-static inline uint64_t ntoh64(uint64_t n)
-{
-        uint64_t h;
-        uint64_t tmp = ntohl(n & 0x00000000ffffffff);
-        h = ntohl(n >> 32);
-        h |= tmp << 32;
-        return h;
-}
-#endif
-
 #define hton64(x)     ntoh64(x)
 
 static gboolean csp_caps_initialized = FALSE;
diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index bc0921e..714b2c9 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -35,6 +35,7 @@ extern "C" {
 #include <string.h>
 #include <endian.h>
 #include <byteswap.h>
+#include <netinet/in.h>
 
 #ifndef AF_BLUETOOTH
 #define AF_BLUETOOTH	31
@@ -158,6 +159,59 @@ void bt_free(void *ptr);
 int bt_error(uint16_t code);
 char *bt_compidtostr(int id);
 
+typedef struct {
+	uint8_t data[16];
+} uint128_t;
+
+#if __BYTE_ORDER == __BIG_ENDIAN
+
+#define ntoh64(x) (x)
+
+static inline void ntoh128(const uint128_t *src, uint128_t *dst)
+{
+	memcpy(dst, src, sizeof(uint128_t));
+}
+
+static inline void btoh128(const uint128_t *src, uint128_t *dst)
+{
+	int i;
+	for (i = 0; i < 16; i++)
+		dst->data[15 - i] = src->data[i];
+
+}
+
+#else
+
+static inline uint64_t ntoh64(uint64_t n)
+{
+	uint64_t h;
+	uint64_t tmp = ntohl(n & 0x00000000ffffffff);
+
+	h = ntohl(n >> 32);
+	h |= tmp << 32;
+
+	return h;
+}
+
+static inline void ntoh128(const uint128_t *src, uint128_t *dst)
+{
+	int i;
+
+	for (i = 0; i < 16; i++)
+		dst->data[15 - i] = src->data[i];
+}
+
+static inline void btoh128(const uint128_t *src, uint128_t *dst)
+{
+	memcpy(dst, src, sizeof(uint128_t));
+}
+
+#endif
+
+#define hton64(x)     ntoh64(x)
+#define hton128(x, y) ntoh128(x, y)
+#define htob128(x, y) btoh128(x, y)
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/sdp.c b/lib/sdp.c
index e782aec..d24d1e2 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -60,49 +60,6 @@
 #define SDPDBG(fmt...)
 #endif
 
-#if __BYTE_ORDER == __BIG_ENDIAN
-#define ntoh64(x) (x)
-static inline void ntoh128(const uint128_t *src, uint128_t *dst)
-{
-	memcpy(dst, src, sizeof(uint128_t));
-}
-
-static inline void btoh128(const uint128_t *src, uint128_t *dst)
-{
-	int i;
-	for (i = 0; i < 16; i++)
-		dst->data[15 - i] = src->data[i];
-
-}
-
-#else
-static inline uint64_t ntoh64(uint64_t n)
-{
-	uint64_t h;
-	uint64_t tmp = ntohl(n & 0x00000000ffffffff);
-	h = ntohl(n >> 32);
-	h |= tmp << 32;
-	return h;
-}
-
-static inline void ntoh128(const uint128_t *src, uint128_t *dst)
-{
-	int i;
-	for (i = 0; i < 16; i++)
-		dst->data[15 - i] = src->data[i];
-}
-
-static inline void btoh128(const uint128_t *src, uint128_t *dst)
-{
-	memcpy(dst, src, sizeof(uint128_t));
-}
-
-#endif
-
-#define hton64(x)     ntoh64(x)
-#define hton128(x, y) ntoh128(x, y)
-#define htob128(x, y) btoh128(x, y)
-
 #define BASE_UUID "00000000-0000-1000-8000-00805F9B34FB"
 
 static uint128_t bluetooth_base_uuid = {
diff --git a/lib/sdp.h b/lib/sdp.h
index f0758b2..5f7d271 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -32,6 +32,7 @@ extern "C" {
 #endif
 
 #include <stdint.h>
+#include <bluetooth/bluetooth.h>
 
 #define SDP_UNIX_PATH "/var/run/sdp"
 #define SDP_RESPONSE_TIMEOUT	20
@@ -420,9 +421,6 @@ typedef struct {
  * Common definitions for attributes in the SDP.
  * Should the type of any of these change, you need only make a change here.
  */
-typedef struct {
-	uint8_t data[16];
-} uint128_t;
 
 typedef struct {
 	uint8_t type;
diff --git a/lib/uuid.c b/lib/uuid.c
index 66ab544..90b42cc 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -27,6 +27,8 @@
 #endif
 
 #include <string.h>
+#include <stdlib.h>
+#include <errno.h>
 
 #include "uuid.h"
 
@@ -73,6 +75,7 @@ static void bt_uuid2uuid128(const bt_uuid_t *uuid, bt_uuid_t *uuid128)
 	switch (uuid->type) {
 	case BT_UUID128:
 		memcpy(uuid128, uuid, sizeof(bt_uuid_t));
+		uuid128->type = BT_UUID128;
 		break;
 	case BT_UUID32:
 		bt_uuid32_to_uuid128(uuid, uuid128);
@@ -80,9 +83,22 @@ static void bt_uuid2uuid128(const bt_uuid_t *uuid, bt_uuid_t *uuid128)
 	case BT_UUID16:
 		bt_uuid16_to_uuid128(uuid, uuid128);
 		break;
+	default:
+		break;
 	}
 }
 
+void bt_uuid_to_uuid128(bt_uuid_t *uuid)
+{
+	bt_uuid_t orig;
+
+	if (uuid->type == BT_UUID128)
+		return;
+
+	memcpy(&orig, uuid, sizeof(bt_uuid_t));
+	bt_uuid2uuid128(&orig, uuid);
+}
+
 static int bt_uuid128_cmp(const bt_uuid_t *u1, const bt_uuid_t *u2)
 {
 	return memcmp(&u1->value.u128, &u2->value.u128, sizeof(uint128_t));
@@ -124,3 +140,146 @@ int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2)
 
 	return bt_uuid128_cmp(&u1, &u2);
 }
+
+/*
+ * convert the UUID to string, copying a maximum of n characters.
+ */
+int bt_uuid_to_string(const bt_uuid_t *uuid, char *str, size_t n)
+{
+	if (!uuid) {
+		snprintf(str, n, "NULL");
+		return -EINVAL;
+	}
+
+	switch (uuid->type) {
+	case BT_UUID16:
+		snprintf(str, n, "%.4x", uuid->value.u16);
+		break;
+	case BT_UUID32:
+		snprintf(str, n, "%.8x", uuid->value.u32);
+		break;
+	case BT_UUID128: {
+		unsigned int   data0;
+		unsigned short data1;
+		unsigned short data2;
+		unsigned short data3;
+		unsigned int   data4;
+		unsigned short data5;
+
+		uint128_t nvalue;
+		const uint8_t *data = (uint8_t *) &nvalue;
+
+		hton128(&uuid->value.u128, &nvalue);
+
+		memcpy(&data0, &data[0], 4);
+		memcpy(&data1, &data[4], 2);
+		memcpy(&data2, &data[6], 2);
+		memcpy(&data3, &data[8], 2);
+		memcpy(&data4, &data[10], 4);
+		memcpy(&data5, &data[14], 2);
+
+		snprintf(str, n, "%.8x-%.4x-%.4x-%.4x-%.8x%.4x",
+				ntohl(data0), ntohs(data1),
+				ntohs(data2), ntohs(data3),
+				ntohl(data4), ntohs(data5));
+		}
+		break;
+	default:
+		snprintf(str, n, "Type of UUID (%x) unknown.", uuid->type);
+		return -EINVAL;	/* Enum type of UUID not set */
+	}
+
+	return 0;
+}
+
+static inline int is_uuid128(const char *string)
+{
+	return (strlen(string) == 36 &&
+			string[8] == '-' &&
+			string[13] == '-' &&
+			string[18] == '-' &&
+			string[23] == '-');
+}
+
+static inline int is_uuid32(const char *string)
+{
+	return (strlen(string) == 8 || strlen(string) == 10);
+}
+
+static inline int is_uuid16(const char *string)
+{
+	return (strlen(string) == 4 || strlen(string) == 6);
+}
+
+static int bt_string_to_uuid16(bt_uuid_t *uuid, const char *string)
+{
+	uint16_t u16;
+	char *endptr = NULL;
+
+	u16 = strtol(string, &endptr, 16);
+	if (endptr && *endptr == '\0') {
+		bt_uuid16_create(uuid, u16);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int bt_string_to_uuid32(bt_uuid_t *uuid, const char *string)
+{
+	uint32_t u32;
+	char *endptr = NULL;
+
+	u32 = strtol(string, &endptr, 16);
+	if (endptr && *endptr == '\0') {
+		bt_uuid32_create(uuid, u32);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int bt_string_to_uuid128(bt_uuid_t *uuid, const char *string)
+{
+	uint32_t data0, data4;
+	uint16_t data1, data2, data3, data5;
+	uint128_t n128, u128;
+	uint8_t *val = (uint8_t *) &n128;
+
+	if (sscanf(string, "%08x-%04hx-%04hx-%04hx-%08x%04hx",
+				&data0, &data1, &data2,
+				&data3, &data4, &data5) != 6)
+		return -EINVAL;
+
+	data0 = htonl(data0);
+	data1 = htons(data1);
+	data2 = htons(data2);
+	data3 = htons(data3);
+	data4 = htonl(data4);
+	data5 = htons(data5);
+
+	memcpy(&val[0], &data0, 4);
+	memcpy(&val[4], &data1, 2);
+	memcpy(&val[6], &data2, 2);
+	memcpy(&val[8], &data3, 2);
+	memcpy(&val[10], &data4, 4);
+	memcpy(&val[14], &data5, 2);
+
+	ntoh128(&n128, &u128);
+
+	bt_uuid128_create(uuid, u128);
+
+	return 0;
+}
+
+int bt_string_to_uuid(bt_uuid_t *uuid, const char *string)
+{
+	if (is_uuid128(string))
+		return bt_string_to_uuid128(uuid, string);
+	else if (is_uuid32(string))
+		return bt_string_to_uuid32(uuid, string);
+	else if (is_uuid16(string))
+		return bt_string_to_uuid16(uuid, string);
+
+	return -EINVAL;
+}
diff --git a/lib/uuid.h b/lib/uuid.h
index bc9ca31..7d73625 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -30,13 +30,11 @@ extern "C" {
 #endif
 
 #include <stdint.h>
-
-typedef struct {
-	uint8_t data[16];
-} uint128_t;
+#include <bluetooth.h>
 
 typedef struct {
 	enum {
+		BT_UUID_UNSPEC = 0,
 		BT_UUID16 = 16,
 		BT_UUID32 = 32,
 		BT_UUID128 = 128,
@@ -53,6 +51,12 @@ int bt_uuid32_create(bt_uuid_t *btuuid, uint32_t value);
 int bt_uuid128_create(bt_uuid_t *btuuid, uint128_t value);
 
 int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2);
+void bt_uuid_to_uuid128(bt_uuid_t *uuid);
+
+#define MAX_LEN_UUID_STR 37
+
+int bt_uuid_to_string(const bt_uuid_t *uuid, char *str, size_t n);
+int bt_string_to_uuid(bt_uuid_t *uuid, const char *string);
 
 #ifdef __cplusplus
 }
diff --git a/test/hciemu.c b/test/hciemu.c
index 9eed9d9..9950372 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -52,22 +52,6 @@
 
 #include <glib.h>
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-static inline uint64_t ntoh64(uint64_t n)
-{
-	uint64_t h;
-	uint64_t tmp = ntohl(n & 0x00000000ffffffff);
-	h = ntohl(n >> 32);
-	h |= tmp << 32;
-	return h;
-}
-#elif __BYTE_ORDER == __BIG_ENDIAN
-#define ntoh64(x) (x)
-#else
-#error "Unknown byte order"
-#endif
-#define hton64(x) ntoh64(x)
-
 #define GHCI_DEV		"/dev/ghci"
 
 #define VHCI_DEV		"/dev/vhci"
-- 
1.7.1

