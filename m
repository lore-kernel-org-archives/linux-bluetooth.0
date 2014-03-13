Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/7] android/avrcp: Add avrcp_connect_browsing()
Date: Thu, 13 Mar 2014 14:31:15 +0200
Message-Id: <1394713881-21349-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394640297-27467-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394640297-27467-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add support for browsing channel
---
 android/avrcp-lib.c | 6 ++++++
 android/avrcp-lib.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index f5ae5a3..39fc748 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -244,6 +244,12 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 	return session;
 }
 
+int avrcp_connect_browsing(struct avrcp *session, int fd, size_t imtu,
+								size_t omtu)
+{
+	return avctp_connect_browsing(session->conn, fd, imtu, omtu);
+}
+
 void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
 							void *user_data)
 {
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 4adf4bf..7f82d7d 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -123,6 +123,8 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
 void avrcp_shutdown(struct avrcp *session);
 void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
 							void *user_data);
+int avrcp_connect_browsing(struct avrcp *session, int fd, size_t imtu,
+								size_t omtu);
 void avrcp_set_control_handlers(struct avrcp *session,
 				const struct avrcp_control_handler *handlers,
 				void *user_data);
-- 
1.8.3.2

