Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/17] android/avrcp-lib: Add avrcp_list_player_values_rsp function
Date: Mon, 17 Mar 2014 15:07:54 +0200
Message-Id: <1395061683-17206-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function can be used to generate ListPlayerValues response PDUs.
---
 android/avrcp-lib.c | 16 ++++++++++++++++
 android/avrcp-lib.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 05ec329..fe3205e 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -864,6 +864,22 @@ int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
 			pdu, length);
 }
 
+int avrcp_list_player_values_rsp(struct avrcp *session, uint8_t transaction,
+					uint8_t number, uint8_t *values)
+{
+	uint8_t pdu[AVRCP_ATTRIBUTE_LAST + 1];
+
+	if (number > AVRCP_ATTRIBUTE_LAST)
+		return -EINVAL;
+
+	pdu[0] = number;
+	memcpy(&pdu[1], values, number);
+
+	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
+			AVC_SUBUNIT_PANEL, AVRCP_LIST_PLAYER_VALUES,
+			pdu, number + 1);
+}
+
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
 				uint8_t status)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index b53b916..a9485b2 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -235,6 +235,8 @@ int avrcp_list_player_attributes_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
 					uint8_t transaction, uint8_t number,
 					uint8_t *attrs, const char **text);
+int avrcp_list_player_values_rsp(struct avrcp *session, uint8_t transaction,
+					uint8_t number, uint8_t *values);
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
 				uint8_t status);
-- 
1.8.5.3

