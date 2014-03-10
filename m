Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] unit/avrcp: Add /TP/NFY/BV-05-C test.
Date: Mon, 10 Mar 2014 15:39:55 +0200
Message-Id: <1394458798-13822-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394458798-13822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394458798-13822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies Register notification - Track Changed - Track Playing.
---
 unit/test-avrcp.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index fe7009a..fa93b25 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -501,6 +501,7 @@ static ssize_t avrcp_handle_register_notification(struct avrcp *session,
 							uint8_t *params,
 							void *user_data)
 {
+	struct context *context = user_data;
 	uint8_t event;
 	uint8_t pdu[9];
 	size_t pdu_len;
@@ -516,7 +517,11 @@ static ssize_t avrcp_handle_register_notification(struct avrcp *session,
 
 	switch (event) {
 	case AVRCP_EVENT_TRACK_CHANGED:
-		memset(&pdu[1], 0xff, 8);
+		if (g_str_equal(context->data->test_name, "/TP/NFY/BV-05-C"))
+			memset(&pdu[1], 0, 8);
+		else
+			memset(&pdu[1], 0xff, 8);
+
 		pdu_len += 8;
 		break;
 	case AVRCP_EVENT_SETTINGS_CHANGED:
@@ -972,5 +977,17 @@ int main(int argc, char *argv[])
 				0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 				0xff, 0xff));
 
+	/* Register notification - Track Changed - Track Playing - TG */
+	define_test("/TP/NFY/BV-05-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x05, AVRCP_EVENT_TRACK_CHANGED,
+				0x00, 0x00, 0x00, 0x00),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x09, AVRCP_EVENT_TRACK_CHANGED,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00));
+
 	return g_test_run();
 }
-- 
1.8.3.2

