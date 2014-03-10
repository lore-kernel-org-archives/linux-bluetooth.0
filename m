Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 09/10] unit/avrcp: Add /TP/NFY/BV-04-C test
Date: Mon, 10 Mar 2014 11:09:52 +0200
Message-Id: <1394442593-4233-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394442593-4233-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394442593-4233-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that Target responds to Register notification - Track
Changed - No Selected Track.
---
 unit/test-avrcp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index c442001..6b5f615 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -962,5 +962,17 @@ int main(int argc, char *argv[])
 				AVRCP_EVENT_SETTINGS_CHANGED,
 				0x01, 0x01, 0x02));
 
+	/* Register notification - Track Changed - No Selected Track - TG */
+	define_test("/TP/NFY/BV-04-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x05, AVRCP_EVENT_TRACK_CHANGED,
+				0x00, 0x00, 0x00, 0x00),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x09, AVRCP_EVENT_TRACK_CHANGED,
+				0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+				0xff, 0xff));
+
 	return g_test_run();
 }
-- 
1.8.3.2

