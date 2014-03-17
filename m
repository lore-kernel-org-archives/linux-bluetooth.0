Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/17] android/avrcp-lib: Add avrcp_list_player_attributes_rsp function
Date: Mon, 17 Mar 2014 15:07:50 +0200
Message-Id: <1395061683-17206-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function can be used to generate ListPlayerAttributes response PDUs.
---
 android/avrcp-lib.c | 18 ++++++++++++++++++
 android/avrcp-lib.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index dc0d516..97822ac 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -807,6 +807,24 @@ int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id,
 				sizeof(params), func, user_data);
 }
 
+int avrcp_list_player_attributes_rsp(struct avrcp *session, uint8_t transaction,
+					uint8_t number, uint8_t *attrs)
+{
+	uint8_t pdu[AVRCP_ATTRIBUTE_LAST + 1];
+
+	if (number > AVRCP_ATTRIBUTE_LAST)
+		return -EINVAL;
+
+	pdu[0] = number;
+
+	if (number > 0)
+		memcpy(&pdu[1], attrs, number);
+
+	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
+				AVC_SUBUNIT_PANEL, AVRCP_LIST_PLAYER_ATTRIBUTES,
+				pdu, number + 1);
+}
+
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
 				uint8_t status)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 2117838..80a6b6a 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -230,6 +230,8 @@ int avrcp_get_element_attributes(struct avrcp *session, avctp_rsp_cb func,
 int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id,
 					avctp_rsp_cb func, void *user_data);
 
+int avrcp_list_player_attributes_rsp(struct avrcp *session, uint8_t transaction,
+					uint8_t number, uint8_t *attrs);
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
 				uint8_t status);
-- 
1.8.5.3

