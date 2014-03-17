Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 15/17] android/avrcp-lib: Add avrcp_get_capabilities_rsp function
Date: Mon, 17 Mar 2014 15:08:01 +0200
Message-Id: <1395061683-17206-15-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function can be used to generate GetCapabilities response PDUs.
---
 android/avrcp-lib.c | 16 ++++++++++++++++
 android/avrcp-lib.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index cb3e61e..360da10 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -809,6 +809,22 @@ int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id,
 				sizeof(params), func, user_data);
 }
 
+int avrcp_get_capabilities_rsp(struct avrcp *session, uint8_t transaction,
+						uint8_t number, uint8_t *events)
+{
+	uint8_t pdu[AVRCP_EVENT_LAST];
+
+	if (number > AVRCP_EVENT_LAST)
+		return -EINVAL;
+
+	pdu[0] = number;
+	memcpy(&pdu[1], events, number);
+
+	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
+				AVC_SUBUNIT_PANEL, AVRCP_GET_CAPABILITIES,
+				pdu, number + 1);
+}
+
 int avrcp_list_player_attributes_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint8_t *attrs)
 {
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 8fb7152..30c7184 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -230,6 +230,8 @@ int avrcp_get_element_attributes(struct avrcp *session, avctp_rsp_cb func,
 int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id,
 					avctp_rsp_cb func, void *user_data);
 
+int avrcp_get_capabilities_rsp(struct avrcp *session, uint8_t transaction,
+					uint8_t number, uint8_t *events);
 int avrcp_list_player_attributes_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint8_t *attrs);
 int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
-- 
1.8.5.3

