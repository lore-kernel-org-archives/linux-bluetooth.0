Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/17] android/avrcp-lib: Add avrcp_get_player_values_text_rsp function
Date: Mon, 17 Mar 2014 15:07:56 +0200
Message-Id: <1395061683-17206-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function can be used to generate GetPlayerValuesText response PDUs.
---
 android/avrcp-lib.c | 33 +++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index fe3205e..16636e6 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -895,6 +895,39 @@ int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				pdu, sizeof(pdu));
 }
 
+int avrcp_get_player_values_text_rsp(struct avrcp *session,
+					uint8_t transaction, uint8_t number,
+					uint8_t *values, const char **text)
+{
+	uint8_t pdu[AVRCP_ATTRIBUTE_LAST * (4 + 255)];
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
+		uint8_t len = 0;
+
+		if (text[i])
+			len = strlen(text[i]);
+
+		ptr[0] = values[i];
+		bt_put_be16(AVRCP_CHARSET_UTF8, &ptr[1]);
+		ptr[3] = len;
+		memcpy(ptr, text[i], len);
+		ptr += 4 + len;
+		length += 4 + len;
+	}
+
+	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
+			AVC_SUBUNIT_PANEL, AVRCP_GET_PLAYER_VALUE_TEXT,
+			pdu, length);
+}
+
 int avrcp_get_element_attrs_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t *params, size_t params_len)
 {
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index a9485b2..181e7aa 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -240,6 +240,9 @@ int avrcp_list_player_values_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
 				uint8_t status);
+int avrcp_get_player_values_text_rsp(struct avrcp *session,
+					uint8_t transaction, uint8_t number,
+					uint8_t *values, const char **text);
 int avrcp_get_element_attrs_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t *params, size_t params_len);
 int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
-- 
1.8.5.3

