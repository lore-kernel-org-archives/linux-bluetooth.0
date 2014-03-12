Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 9/9] unit/avrcp: Add /TP/MPS/BV-02-C test
Date: Wed, 12 Mar 2014 16:40:32 +0200
Message-Id: <1394635232-23774-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394635232-23774-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CABBYNZL5hjJzaxsnXtrHTzJSHSKYjemUnUr=YRE4Zq9qCmoj0g@mail.gmail.com>
 <1394635232-23774-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that SetAddressedPlayer response issued by the Target.
---
 unit/test-avrcp.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 56f73b4..75e8036 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -468,6 +468,19 @@ static ssize_t avrcp_handle_set_player_value(struct avrcp *session,
 	return 1;
 }
 
+static ssize_t avrcp_handle_set_addr_player(struct avrcp *session,
+						uint8_t transaction,
+						uint16_t params_len,
+						uint8_t *params,
+						void *user_data)
+{
+	DBG("");
+
+	params[0] = 0;
+
+	return 1;
+}
+
 static ssize_t avrcp_handle_get_play_status(struct avrcp *session,
 						uint8_t transaction,
 						uint16_t params_len,
@@ -585,6 +598,9 @@ static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_REGISTER_NOTIFICATION,
 					AVC_CTYPE_NOTIFY, AVC_CTYPE_INTERIM,
 					avrcp_handle_register_notification },
+		{ AVRCP_SET_ADDRESSED_PLAYER,
+					AVC_CTYPE_CONTROL, AVC_CTYPE_STABLE,
+					avrcp_handle_set_addr_player },
 		{ },
 };
 
@@ -674,6 +690,16 @@ int main(int argc, char *argv[])
 				0x00, 0x19, 0x58, 0x60, 0x00, 0x00,
 				0x02, 0xab, 0xcd));
 
+	/* SetAddressedPlayer - TG */
+	define_test("/TP/MPS/BV-02-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_SET_ADDRESSED_PLAYER,
+				0x00, 0x00, 0x02, 0xab, 0xcd),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_STABLE,
+				0x48, 0x00, 0x00, 0x19, 0x58,
+				AVRCP_SET_ADDRESSED_PLAYER,
+				0x00, 0x00, 0x01, 0x00));
+
 	/* Connection Establishment for Control tests */
 
 	/*
-- 
1.8.3.2

