Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/16] android/avrcp-lib: Make hton24 and ntoh24 public
Date: Sun,  2 Mar 2014 20:48:24 +0200
Message-Id: <1393786109-6554-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
References: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This avoids duplicating those function everytime.
---
 android/avrcp-lib.c | 12 ------------
 android/avrcp-lib.h | 12 ++++++++++++
 unit/test-avrcp.c   |  7 -------
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 40ff7b3..60c8ba3 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -73,18 +73,6 @@ struct avrcp_header {
 #error "Unknown byte order"
 #endif
 
-static inline uint32_t ntoh24(const uint8_t src[3])
-{
-	return src[0] << 16 | src[1] << 8 | src[2];
-}
-
-static inline void hton24(uint8_t dst[3], uint32_t src)
-{
-	dst[0] = (src & 0xff0000) >> 16;
-	dst[1] = (src & 0x00ff00) >> 8;
-	dst[2] = (src & 0x0000ff);
-}
-
 struct avrcp {
 	struct avctp *conn;
 
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 3df5897..8625425 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -91,6 +91,18 @@ struct avrcp_passthrough_handler {
 
 typedef void (*avrcp_destroy_cb_t) (void *user_data);
 
+static inline uint32_t ntoh24(const uint8_t src[3])
+{
+	return src[0] << 16 | src[1] << 8 | src[2];
+}
+
+static inline void hton24(uint8_t dst[3], uint32_t src)
+{
+	dst[0] = (src & 0xff0000) >> 16;
+	dst[1] = (src & 0x00ff00) >> 8;
+	dst[2] = (src & 0x0000ff);
+}
+
 struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
 void avrcp_shutdown(struct avrcp *session);
 void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 0294973..695f62c 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -94,13 +94,6 @@ struct context {
 		g_test_add_data_func(name, &data, function);		\
 	} while (0)
 
-static inline void hton24(uint8_t dst[3], uint32_t src)
-{
-	dst[0] = (src & 0xff0000) >> 16;
-	dst[1] = (src & 0x00ff00) >> 8;
-	dst[2] = (src & 0x0000ff);
-}
-
 static void test_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
-- 
1.8.5.3

