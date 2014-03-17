Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/17] android/avrcp-lib: Add avrcp_set_addressed_player_rsp function
Date: Mon, 17 Mar 2014 15:07:48 +0200
Message-Id: <1395061683-17206-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function can be used to generate SetAddressedPlayer response PDUs.
---
 android/avrcp-lib.c | 8 ++++++++
 android/avrcp-lib.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 60d494f..dc0d516 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -839,6 +839,14 @@ int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 				params, params_len);
 }
 
+int avrcp_set_addressed_player_rsp(struct avrcp *session, uint8_t transaction,
+							uint8_t status)
+{
+	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
+				AVC_SUBUNIT_PANEL, AVRCP_SET_ADDRESSED_PLAYER,
+				&status, sizeof(status));
+}
+
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op)
 {
 	uint8_t params[5];
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 54bdf4f..2117838 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -238,4 +238,6 @@ int avrcp_get_element_attrs_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t code, uint8_t *params,
 					size_t params_len);
+int avrcp_set_addressed_player_rsp(struct avrcp *session, uint8_t transaction,
+							uint8_t status);
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op);
-- 
1.8.5.3

