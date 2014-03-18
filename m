Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 12/16] unit/avrcp: Add /TP/MCN/CB/BV-04-C test
Date: Tue, 18 Mar 2014 11:20:43 +0200
Message-Id: <1395134447-8957-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the ChangePath command issued by the Controller.
---
 unit/test-avrcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index b69674b..2905380 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -581,6 +581,10 @@ static void test_client(gconstpointer data)
 					AVRCP_MEDIA_PLAYER_VFS, 0, 2, NULL, 0,
 					NULL, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/MCN/CB/BV-04-C"))
+		avrcp_change_path(context->session, 0x01, 0x01, 0xaabb,
+								NULL, NULL);
+
 	if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
 		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED,
 								NULL, NULL);
@@ -683,6 +687,15 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x00, 0x02, /* end */
 				0x00));
 
+	/* ChangePath - CT */
+	define_test("/TP/MCN/CB/BV-04-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, AVRCP_CHANGE_PATH,
+				0x00, 0x0b,
+				0xaa, 0xbb,		/* counter */
+				0x01,			/* direction */
+				0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x01	/* Folder UID */));
+
 	/* Media Player Selection IOP tests */
 
 	/* Listing of available media players */
-- 
1.8.3.2

