Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/7] unit/avrcp: Add /TP/MPS/BV-03-C test
Date: Thu, 13 Mar 2014 14:31:18 +0200
Message-Id: <1394713881-21349-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394713881-21349-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394640297-27467-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1394713881-21349-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that SetBrowsedPlayer command issued by the Controller.
---
 unit/test-avrcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 623e62e..22b3e4a 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -710,6 +710,9 @@ static void test_client(gconstpointer data)
 		avrcp_set_addressed_player(context->session, 0xabcd, NULL,
 									NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-03-C"))
+		avrcp_set_browsed_player(context->session, 0xabcd, NULL, NULL);
+
 	if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
 		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED,
 								NULL, NULL);
@@ -786,6 +789,11 @@ int main(int argc, char *argv[])
 				AVRCP_SET_ADDRESSED_PLAYER,
 				0x00, 0x00, 0x01, 0x00));
 
+	/* SetBrowsedPlayer - CT */
+	define_test("/TP/MPS/BV-03-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x70, 0x00, 0x02,
+				0xab, 0xcd));
+
 	/* Connection Establishment for Control tests */
 
 	/*
-- 
1.8.3.2

