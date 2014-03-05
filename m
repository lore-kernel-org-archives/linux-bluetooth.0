Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/10] unit/avrcp: Add /TP/MDI/BV-01-C test
Date: Wed,  5 Mar 2014 16:32:31 +0200
Message-Id: <1394029952-3319-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies Get play status command.
---
 unit/test-avrcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index b67b89c..8682e63 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -530,6 +530,9 @@ static void test_client(gconstpointer data)
 						NULL, NULL);
 	}
 
+	if (g_str_equal(context->data->test_name, "/TP/MDI/BV-01-C"))
+		avrcp_get_play_status(context->session, NULL, NULL);
+
 	execute_context(context);
 }
 
@@ -771,5 +774,13 @@ int main(int argc, char *argv[])
 				AVRCP_SET_PLAYER_VALUE,
 				0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PARAM));
 
+	/* Media Information Commands */
+
+	/* Get play status - CT */
+	define_test("/TP/MDI/BV-01-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_GET_PLAY_STATUS,
+				0x00, 0x00, 0x00));
+
 	return g_test_run();
 }
-- 
1.8.3.2

