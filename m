Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 03/10] unit/avrcp: Add /TP/NFY/BV-08-C test
Date: Tue, 11 Mar 2014 15:05:47 +0200
Message-Id: <1394543154-25355-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394543154-25355-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394458798-13822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1394543154-25355-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that Target issued Track Changed INTERIM response when
the track is SELECTED.
---
 unit/test-avrcp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index fa93b25..0e65789 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -517,7 +517,9 @@ static ssize_t avrcp_handle_register_notification(struct avrcp *session,
 
 	switch (event) {
 	case AVRCP_EVENT_TRACK_CHANGED:
-		if (g_str_equal(context->data->test_name, "/TP/NFY/BV-05-C"))
+		if (g_str_equal(context->data->test_name, "/TP/NFY/BV-05-C") ||
+			g_str_equal(context->data->test_name,
+							"/TP/NFY/BV-08-C"))
 			memset(&pdu[1], 0, 8);
 		else
 			memset(&pdu[1], 0xff, 8);
@@ -989,5 +991,17 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 				0x00, 0x00));
 
+	/* Register notification - Track Changed - Selected Track - TG */
+	define_test("/TP/NFY/BV-08-C", test_server,
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

