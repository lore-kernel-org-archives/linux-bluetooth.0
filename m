Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] unit/avrcp: Add /TP/NFY/BV-03-C test
Date: Fri,  7 Mar 2014 17:38:30 +0200
Message-Id: <1394206711-5508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that Target responds Register notification command with
parameter AVRCP_EVENT_SETTINGS_CHANGED.
---
 unit/test-avrcp.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 0e3bb51..c442001 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -521,6 +521,12 @@ static ssize_t avrcp_handle_register_notification(struct avrcp *session,
 		memset(&pdu[1], 0xff, 8);
 		pdu_len += 8;
 		break;
+	case AVRCP_EVENT_SETTINGS_CHANGED:
+		pdu[1] = 0x01;
+		pdu[2] = 0x01;
+		pdu[3] = 0x02;
+		pdu_len = 4;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -938,5 +944,23 @@ int main(int argc, char *argv[])
 				0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 				0xff, 0xff));
 
+	/* Register notification - TG */
+	define_test("/TP/NFY/BV-03-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x05,
+				AVRCP_EVENT_SETTINGS_CHANGED,
+				0x00, 0x00, 0x00, 0x00),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x04,
+				AVRCP_EVENT_SETTINGS_CHANGED,
+				0x01, 0x01, 0x02),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x04,
+				AVRCP_EVENT_SETTINGS_CHANGED,
+				0x01, 0x01, 0x02));
+
 	return g_test_run();
 }
-- 
1.8.3.2

