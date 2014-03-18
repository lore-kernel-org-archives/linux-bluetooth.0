Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 01/16] android/avrcp: Add avrcp_connect_browsing()
Date: Tue, 18 Mar 2014 11:20:32 +0200
Message-Id: <1395134447-8957-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add support for browsing channel
---
 android/avrcp-lib.c | 6 ++++++
 android/avrcp-lib.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 689c536..13acae9 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -270,6 +270,12 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
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
index d9acb7d..8d9782b 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -177,6 +177,8 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
 void avrcp_shutdown(struct avrcp *session);
 void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
 							void *user_data);
+int avrcp_connect_browsing(struct avrcp *session, int fd, size_t imtu,
+								size_t omtu);
 
 void avrcp_register_player(struct avrcp *session,
 				const struct avrcp_control_ind *ind,
-- 
1.8.3.2

