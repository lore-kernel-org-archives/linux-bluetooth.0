Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/17] android/avrcp-lib: Add avrcp_get_current_player_value_rsp function
Date: Mon, 17 Mar 2014 15:07:59 +0200
Message-Id: <1395061683-17206-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function can be used to generate GetCurrentPlayerValue response
PDUs.
---
 android/avrcp-lib.c | 26 ++++++++++++++++++++++++++
 android/avrcp-lib.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 16636e6..cb3e61e 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -928,6 +928,32 @@ int avrcp_get_player_values_text_rsp(struct avrcp *session,
 			pdu, length);
 }
 
+int avrcp_get_current_player_value_rsp(struct avrcp *session,
+					uint8_t transaction, uint8_t number,
+					uint8_t *attrs, uint8_t *values)
+{
+	uint8_t pdu[AVRCP_ATTRIBUTE_LAST * 2  + 1];
+	uint8_t *ptr;
+	uint16_t length;
+	int i;
+
+	if (number > AVRCP_ATTRIBUTE_LAST)
+		return -EINVAL;
+
+	pdu[0] = number;
+	length = 1;
+	for (i = 0, ptr = &pdu[1]; i < number; i++) {
+		ptr[0] = attrs[i];
+		ptr[1] = values[i];
+		ptr += 2;
+		length += 2;
+	}
+
+	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
+			AVC_SUBUNIT_PANEL, AVRCP_GET_CURRENT_PLAYER_VALUE,
+			pdu, length);
+}
+
 int avrcp_get_element_attrs_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t *params, size_t params_len)
 {
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 181e7aa..8fb7152 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -243,6 +243,9 @@ int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_get_player_values_text_rsp(struct avrcp *session,
 					uint8_t transaction, uint8_t number,
 					uint8_t *values, const char **text);
+int avrcp_get_current_player_value_rsp(struct avrcp *session,
+					uint8_t transaction, uint8_t number,
+					uint8_t *attrs, uint8_t *values);
 int avrcp_get_element_attrs_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t *params, size_t params_len);
 int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
-- 
1.8.5.3

