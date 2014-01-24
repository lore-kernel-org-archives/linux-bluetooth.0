Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 7/8] android/AVCTP: Add avctp_set_destroy_cb
Date: Fri, 24 Jan 2014 15:24:34 +0200
Message-Id: <1390569875-29436-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390569875-29436-1-git-send-email-luiz.dentz@gmail.com>
References: <1390569875-29436-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds avctp_set_destroy_cb that can be use to set a callback when
the AVCTP has been disconnected.
---
 android/avctp.c | 13 +++++++++++++
 android/avctp.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/android/avctp.c b/android/avctp.c
index 1255c3e..a88b7f7 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -174,6 +174,9 @@ struct avctp {
 	uint8_t key_quirks[256];
 	struct key_pressed key;
 	uint16_t version;
+
+	avctp_destroy_cb_t destroy;
+	void *data;
 };
 
 struct avctp_passthrough_handler {
@@ -1445,6 +1448,13 @@ int avctp_connect_browsing(struct avctp *session, int fd, size_t imtu,
 	return 0;
 }
 
+void avctp_set_destroy_cb(struct avctp *session, avctp_destroy_cb_t cb,
+							void *user_data)
+{
+	session->destroy = cb;
+	session->data = user_data;
+}
+
 void avctp_shutdown(struct avctp *session)
 {
 	if (!session)
@@ -1456,6 +1466,9 @@ void avctp_shutdown(struct avctp *session)
 	if (session->control)
 		avctp_channel_destroy(session->control);
 
+	if (session->destroy)
+		session->destroy(session->data);
+
 	if (session->key.timer > 0)
 		g_source_remove(session->key.timer);
 
diff --git a/android/avctp.h b/android/avctp.h
index 99aaf95..a22bf13 100644
--- a/android/avctp.h
+++ b/android/avctp.h
@@ -103,6 +103,9 @@ typedef size_t (*avctp_browsing_pdu_cb) (struct avctp *session,
 typedef void (*avctp_destroy_cb_t) (void *user_data);
 
 struct avctp *avctp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
+void avctp_set_destroy_cb(struct avctp *session, avctp_destroy_cb_t cb,
+							void *user_data);
+
 int avctp_init_uinput(struct avctp *session, const char *name,
 							const char *address);
 int avctp_connect_browsing(struct avctp *session, int fd, size_t imtu,
-- 
1.8.4.2

