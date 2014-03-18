Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 04/16] unit/avrcp: Add /TP/MPS/BV-03-C test
Date: Tue, 18 Mar 2014 11:20:35 +0200
Message-Id: <1395134447-8957-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that SetBrowsedPlayer command issued by the Controller.
---
 unit/test-avrcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index bd65637..401a50d 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -563,6 +563,9 @@ static void test_client(gconstpointer data)
 		avrcp_set_addressed_player(context->session, 0xabcd, NULL,
 									NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-03-C"))
+		avrcp_set_browsed_player(context->session, 0xabcd, NULL, NULL);
+
 	if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
 		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED,
 								NULL, NULL);
@@ -639,6 +642,11 @@ int main(int argc, char *argv[])
 				AVRCP_SET_ADDRESSED_PLAYER,
 				0x00, 0x00, 0x01, 0x04));
 
+	/* SetBrowsedPlayer - CT */
+	define_test("/TP/MPS/BV-03-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x70, 0x00, 0x02,
+				0xab, 0xcd));
+
 	/* Connection Establishment for Control tests */
 
 	/*
-- 
1.8.3.2

