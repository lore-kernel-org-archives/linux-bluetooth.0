Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] unit/avrcp: Add /TP/MDI/BV-01-C test
Date: Thu,  6 Mar 2014 16:42:59 +0200
Message-Id: <1394116985-28247-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies Get play status.
---
 unit/test-avrcp.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 8682e63..46ddde9 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -459,6 +459,23 @@ static ssize_t avrcp_handle_set_player_value(struct avrcp *session,
 	return 1;
 }
 
+static ssize_t avrcp_handle_get_play_status(struct avrcp *session,
+						uint8_t transaction,
+						uint16_t params_len,
+						uint8_t *params,
+						void *user_data)
+{
+	DBG("");
+
+	if (params_len)
+		return -EINVAL;
+
+	avrcp_get_play_status_rsp(session, transaction, 0xaaaaaaaa, 0xbbbbbbbb,
+									0x00);
+
+	return -EAGAIN;
+}
+
 static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -481,6 +498,9 @@ static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_SET_PLAYER_VALUE,
 					AVC_CTYPE_CONTROL, AVC_CTYPE_STABLE,
 					avrcp_handle_set_player_value },
+		{ AVRCP_GET_PLAY_STATUS,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
+					avrcp_handle_get_play_status },
 		{ },
 };
 
@@ -782,5 +802,16 @@ int main(int argc, char *argv[])
 				0x00, 0x19, 0x58, AVRCP_GET_PLAY_STATUS,
 				0x00, 0x00, 0x00));
 
+	/* Get play status - TG */
+	define_test("/TP/MDI/BV-02-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_GET_PLAY_STATUS,
+				0x00, 0x00, 0x00),
+			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_GET_PLAY_STATUS,
+				0x00, 0x00, 0x09, 0xaa, 0xaa, 0xaa,
+				0xaa, 0xbb, 0xbb, 0xbb, 0xbb, 0x00));
+
+
 	return g_test_run();
 }
-- 
1.8.3.2

