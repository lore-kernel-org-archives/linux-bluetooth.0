Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] android/avrcp: Add avrcp_get_play_status() function
Date: Wed,  5 Mar 2014 16:32:30 +0200
Message-Id: <1394029952-3319-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 8 ++++++++
 android/avrcp-lib.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 63a1f88..cd39071 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -395,6 +395,14 @@ int avrcp_set_player_value(struct avrcp *session, uint8_t *attributes,
 				func, user_data);
 }
 
+int avrcp_get_play_status(struct avrcp *session, avctp_rsp_cb func,
+								void *user_data)
+{
+	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
+				AVRCP_GET_PLAY_STATUS, NULL, 0, func,
+				user_data);
+}
+
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
 				uint8_t status)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 6bfdff2..ba1d84a 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -143,6 +143,8 @@ int avrcp_set_player_value(struct avrcp *session, uint8_t *attributes,
 int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attrs,
 					uint8_t attr_count, avctp_rsp_cb func,
 					void *user_data);
+int avrcp_get_play_status(struct avrcp *session, avctp_rsp_cb func,
+							void *user_data);
 
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
-- 
1.8.3.2

