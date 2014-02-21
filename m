Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/6] android/avrcp: Implement avrcp_get_avctp
Date: Fri, 21 Feb 2014 17:23:47 +0200
Message-Id: <1392996230-11789-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1392996230-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1392996230-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 5 +++++
 android/avrcp-lib.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index ef48fa7..9180abd 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -39,6 +39,11 @@ struct avrcp {
 	struct avctp	*session;
 };
 
+struct avctp *avrcp_get_avctp(struct avrcp *session)
+{
+	return session->session;
+}
+
 void avrcp_shutdown(struct avrcp *session)
 {
 	if (session->session)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 7955d56..7bd8b25 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -21,8 +21,11 @@
  *
  */
 
+struct avrcp;
+
 typedef void (*avrcp_destroy_cb_t) (void *user_data);
 
+struct avctp *avrcp_get_avctp(struct avrcp *session);
 struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
 void avrcp_shutdown(struct avrcp *session);
 void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
-- 
1.8.3.2

