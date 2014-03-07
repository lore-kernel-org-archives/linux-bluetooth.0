Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] android/avrcp-lib: Add avrcp_set_volume function
Date: Fri,  7 Mar 2014 14:15:42 +0200
Message-Id: <1394194543-3095-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1394194543-3095-1-git-send-email-luiz.dentz@gmail.com>
References: <1394194543-3095-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds avrcp_set_volume function which can be used to send
SetAbsoluteVolume PDUs.
---
 android/avrcp-lib.c | 9 +++++++++
 android/avrcp-lib.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index a5530ec..bd1e7da 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -416,6 +416,15 @@ int avrcp_get_play_status(struct avrcp *session, avctp_rsp_cb func,
 				user_data);
 }
 
+int avrcp_set_volume(struct avrcp *session, uint8_t volume, avctp_rsp_cb func,
+							void *user_data)
+{
+	return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
+						AVRCP_SET_ABSOLUTE_VOLUME,
+						&volume, sizeof(volume),
+						func, user_data);
+}
+
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
 				uint8_t status)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 4a49fe7..30d220e 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -148,6 +148,8 @@ int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attrs,
 					void *user_data);
 int avrcp_get_play_status(struct avrcp *session, avctp_rsp_cb func,
 							void *user_data);
+int avrcp_set_volume(struct avrcp *session, uint8_t volume, avctp_rsp_cb func,
+							void *user_data);
 
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
-- 
1.8.5.3

