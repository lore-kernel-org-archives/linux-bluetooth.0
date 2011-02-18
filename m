Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v2 01/14] Move 64 and 128 bits byte order functions to bluetooth.h
Date: Fri, 18 Feb 2011 20:29:20 -0200
Message-Id: <1298068173-16518-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/example.c     |    1 +
 attrib/gatt.c        |    1 +
 attrib/interactive.c |    1 +
 health/hdp_manager.c |    1 +
 health/mcap_sync.c   |   17 -----------------
 lib/bluetooth.h      |   41 +++++++++++++++++++++++++++++++++++++++++
 lib/sdp.c            |   43 -------------------------------------------
 lib/sdp.h            |    4 ----
 src/sdp-xml.c        |    1 +
 test/hciemu.c        |   16 ----------------
 10 files changed, 46 insertions(+), 80 deletions(-)

diff --git a/attrib/example.c b/attrib/example.c
index 1911912..f5fcf1b 100644
--- a/attrib/example.c
+++ b/attrib/example.c
@@ -29,6 +29,7 @@
 
 #include <arpa/inet.h>
 
+#include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 20bb96f..b99d39c 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -24,6 +24,7 @@
 
 #include <stdint.h>
 #include <glib.h>
+#include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
diff --git a/attrib/interactive.c b/attrib/interactive.c
index edc465a..f797f71 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -25,6 +25,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
diff --git a/health/hdp_manager.c b/health/hdp_manager.c
index 88b49fc..8ba1720 100644
--- a/health/hdp_manager.c
+++ b/health/hdp_manager.c
@@ -27,6 +27,7 @@
 #include <config.h>
 #endif
 
+#include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
diff --git a/health/mcap_sync.c b/health/mcap_sync.c
index 6f90344..20311a2 100644
--- a/health/mcap_sync.c
+++ b/health/mcap_sync.c
@@ -92,23 +92,6 @@ struct sync_set_data {
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
-#define hton64(x)     ntoh64(x)
-
 static gboolean csp_caps_initialized = FALSE;
 struct csp_caps _caps;
 
diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index bc0921e..d8f36f8 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -35,6 +35,7 @@ extern "C" {
 #include <string.h>
 #include <endian.h>
 #include <byteswap.h>
+#include <arpa/inet.h>
 
 #ifndef AF_BLUETOOTH
 #define AF_BLUETOOTH	31
@@ -88,21 +89,61 @@ enum {
 	BT_CLOSED
 };
 
+typedef struct {
+	uint8_t data[16];
+} uint128_t;
+
 /* Byte order conversions */
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define htobs(d)  (d)
 #define htobl(d)  (d)
 #define btohs(d)  (d)
 #define btohl(d)  (d)
+static inline uint64_t ntoh64(uint64_t n)
+{
+	uint64_t h;
+	uint64_t tmp = ntohl(n & 0x00000000ffffffff);
+	h = ntohl(n >> 32);
+	h |= tmp << 32;
+	return h;
+}
+
+static inline void ntoh128(const uint128_t *src, uint128_t *dst)
+{
+	int i;
+	for (i = 0; i < 16; i++)
+		dst->data[15 - i] = src->data[i];
+}
+
+static inline void btoh128(const uint128_t *src, uint128_t *dst)
+{
+	memcpy(dst, src, sizeof(uint128_t));
+}
 #elif __BYTE_ORDER == __BIG_ENDIAN
 #define htobs(d)  bswap_16(d)
 #define htobl(d)  bswap_32(d)
 #define btohs(d)  bswap_16(d)
 #define btohl(d)  bswap_32(d)
+#define ntoh64(x) (x)
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
+}
 #else
 #error "Unknown byte order"
 #endif
 
+#define hton64(x)     ntoh64(x)
+#define hton128(x, y) ntoh128(x, y)
+#define htob128(x, y) btoh128(x, y)
+
 /* Bluetooth unaligned access */
 #define bt_get_unaligned(ptr)			\
 ({						\
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
index e901b2a..4e0396a 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -421,10 +421,6 @@ typedef struct {
  * Should the type of any of these change, you need only make a change here.
  */
 typedef struct {
-	uint8_t data[16];
-} uint128_t;
-
-typedef struct {
 	uint8_t type;
 	union {
 		uint16_t  uuid16;
diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 3aa9df0..48a3808 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -33,6 +33,7 @@
 #include <limits.h>
 #include <stdlib.h>
 
+#include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
diff --git a/test/hciemu.c b/test/hciemu.c
index 5227766..757a75c 100644
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
1.7.4.1

