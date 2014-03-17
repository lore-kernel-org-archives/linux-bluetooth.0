Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 17/17] android/avrcp-lib: Make unused public function private
Date: Mon, 17 Mar 2014 15:08:03 +0200
Message-Id: <1395061683-17206-17-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 28 ++++++++++++++++++++--------
 android/avrcp-lib.h | 15 ---------------
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 360da10..83ff96a 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -99,6 +99,18 @@ struct avrcp_player {
 	void *user_data;
 };
 
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
 void avrcp_shutdown(struct avrcp *session)
 {
 	if (session->conn) {
@@ -592,6 +604,14 @@ static const struct avrcp_control_handler player_handlers[] = {
 		{ },
 };
 
+static void avrcp_set_control_handlers(struct avrcp *session,
+				const struct avrcp_control_handler *handlers,
+				void *user_data)
+{
+	session->control_handlers = handlers;
+	session->control_data = user_data;
+}
+
 void avrcp_register_player(struct avrcp *session,
 				const struct avrcp_control_ind *ind,
 				const struct avrcp_control_cfm *cfm,
@@ -608,14 +628,6 @@ void avrcp_register_player(struct avrcp *session,
 	session->player = player;
 }
 
-void avrcp_set_control_handlers(struct avrcp *session,
-				const struct avrcp_control_handler *handlers,
-				void *user_data)
-{
-	session->control_handlers = handlers;
-	session->control_data = user_data;
-}
-
 void avrcp_set_passthrough_handlers(struct avrcp *session,
 			const struct avrcp_passthrough_handler *handlers,
 			void *user_data)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 30c7184..d9acb7d 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -173,18 +173,6 @@ struct avrcp_passthrough_handler {
 
 typedef void (*avrcp_destroy_cb_t) (void *user_data);
 
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
 struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
 void avrcp_shutdown(struct avrcp *session);
 void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
@@ -194,9 +182,6 @@ void avrcp_register_player(struct avrcp *session,
 				const struct avrcp_control_ind *ind,
 				const struct avrcp_control_cfm *cfm,
 				void *user_data);
-void avrcp_set_control_handlers(struct avrcp *session,
-				const struct avrcp_control_handler *handlers,
-				void *user_data);
 void avrcp_set_passthrough_handlers(struct avrcp *session,
 			const struct avrcp_passthrough_handler *handlers,
 			void *user_data);
-- 
1.8.5.3

