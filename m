Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] android/avrcp-lib: Rename AVCTP session to conn
Date: Thu, 20 Feb 2014 16:40:53 +0200
Message-Id: <1392907255-29758-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index ef48fa7..8450480 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -36,13 +36,13 @@
 #include "avrcp-lib.h"
 
 struct avrcp {
-	struct avctp	*session;
+	struct avctp	*conn;
 };
 
 void avrcp_shutdown(struct avrcp *session)
 {
-	if (session->session)
-		avctp_shutdown(session->session);
+	if (session->conn)
+		avctp_shutdown(session->conn);
 
 	g_free(session);
 }
@@ -53,8 +53,8 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 
 	session = g_new0(struct avrcp, 1);
 
-	session->session = avctp_new(fd, imtu, omtu, version);
-	if (!session->session) {
+	session->conn = avctp_new(fd, imtu, omtu, version);
+	if (!session->conn) {
 		g_free(session);
 		return NULL;
 	}
@@ -65,11 +65,11 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
 							void *user_data)
 {
-	avctp_set_destroy_cb(session->session, cb, user_data);
+	avctp_set_destroy_cb(session->conn, cb, user_data);
 }
 
 int avrcp_init_uinput(struct avrcp *session, const char *name,
 							const char *address)
 {
-	return avctp_init_uinput(session->session, name, address);
+	return avctp_init_uinput(session->conn, name, address);
 }
-- 
1.8.5.3

