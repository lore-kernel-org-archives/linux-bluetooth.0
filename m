Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/17] android/avrcp-lib: Add avrcp_get_player_attribute_text_rsp function
Date: Mon, 17 Mar 2014 15:07:52 +0200
Message-Id: <1395061683-17206-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function can be used to generate GetPlayerAttributeText response
PDUs.
---
 android/avrcp-lib.c | 39 +++++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  3 +++
 2 files changed, 42 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 97822ac..05ec329 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -43,6 +43,8 @@
 #define AVRCP_PACKET_TYPE_CONTINUING		0x02
 #define AVRCP_PACKET_TYPE_END			0x03
 
+#define AVRCP_CHARSET_UTF8			106
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
 struct avrcp_header {
@@ -825,6 +827,43 @@ int avrcp_list_player_attributes_rsp(struct avrcp *session, uint8_t transaction,
 				pdu, number + 1);
 }
 
+int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
+					uint8_t transaction, uint8_t number,
+					uint8_t *attrs, const char **text)
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
+		if (attrs[i] > AVRCP_ATTRIBUTE_LAST ||
+					attrs[i] == AVRCP_ATTRIBUTE_ILEGAL)
+			return -EINVAL;
+
+		if (text[i])
+			len = strlen(text[i]);
+
+		ptr[0] = attrs[i];
+		bt_put_be16(AVRCP_CHARSET_UTF8, &ptr[1]);
+		ptr[3] = len;
+		memcpy(ptr, text[i], len);
+		ptr += 4 + len;
+		length += 4 + len;
+	}
+
+	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
+			AVC_SUBUNIT_PANEL, AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
+			pdu, length);
+}
+
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
 				uint8_t status)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 80a6b6a..b53b916 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -232,6 +232,9 @@ int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id,
 
 int avrcp_list_player_attributes_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint8_t *attrs);
+int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
+					uint8_t transaction, uint8_t number,
+					uint8_t *attrs, const char **text);
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
 				uint8_t status);
-- 
1.8.5.3

