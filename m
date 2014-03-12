Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 7/9] android/avrcp: Add set_addr_player() function
Date: Wed, 12 Mar 2014 16:40:30 +0200
Message-Id: <1394635232-23774-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394635232-23774-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CABBYNZL5hjJzaxsnXtrHTzJSHSKYjemUnUr=YRE4Zq9qCmoj0g@mail.gmail.com>
 <1394635232-23774-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 12 ++++++++++++
 android/avrcp-lib.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index f719a00..68c2df4 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -440,6 +440,18 @@ int avrcp_get_element_attributes(struct avrcp *session, avctp_rsp_cb func,
 				func, user_data);
 }
 
+int avrcp_set_addr_player(struct avrcp *session, uint16_t player_id,
+					avctp_rsp_cb func, void *user_data)
+{
+	uint8_t params[2];
+
+	bt_put_be16(player_id, params);
+
+	return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
+				AVRCP_SET_ADDRESSED_PLAYER, params,
+				sizeof(params), func, user_data);
+}
+
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
 				uint8_t status)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index cc6c2ee..17072fb 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -37,6 +37,7 @@
 #define AVRCP_REQUEST_CONTINUING	0x40
 #define AVRCP_ABORT_CONTINUING		0x41
 #define AVRCP_SET_ABSOLUTE_VOLUME	0x50
+#define AVRCP_SET_ADDRESSED_PLAYER	0x60
 #define AVRCP_SET_BROWSED_PLAYER	0x70
 #define AVRCP_GET_FOLDER_ITEMS		0x71
 #define AVRCP_CHANGE_PATH		0x72
@@ -155,6 +156,8 @@ int avrcp_set_volume(struct avrcp *session, uint8_t volume, avctp_rsp_cb func,
 							void *user_data);
 int avrcp_get_element_attributes(struct avrcp *session, avctp_rsp_cb func,
 							void *user_data);
+int avrcp_set_addr_player(struct avrcp *session, uint16_t player_id,
+					avctp_rsp_cb func, void *user_data);
 
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
-- 
1.8.3.2

