Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 8/9] unit/avrcp: Add /TP/MPS/BV-01-C test
Date: Wed, 12 Mar 2014 16:40:31 +0200
Message-Id: <1394635232-23774-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394635232-23774-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CABBYNZL5hjJzaxsnXtrHTzJSHSKYjemUnUr=YRE4Zq9qCmoj0g@mail.gmail.com>
 <1394635232-23774-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that SetAddressedPlayer command issued by Controller.
---
 unit/test-avrcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 82c18b5..56f73b4 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -605,6 +605,9 @@ static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(0x0100, data);
 
+	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-01-C"))
+		avrcp_set_addr_player(context->session, 0xabcd, NULL, NULL);
+
 	if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
 		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED,
 								NULL, NULL);
@@ -663,6 +666,14 @@ int main(int argc, char *argv[])
 	if (g_test_verbose())
 		__btd_log_init("*", 0);
 
+	/* Media Player Selection Commands and Notifications */
+
+	/* SetAddressedPlayer - CT */
+	define_test("/TP/MPS/BV-01-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
+				0x00, 0x19, 0x58, 0x60, 0x00, 0x00,
+				0x02, 0xab, 0xcd));
+
 	/* Connection Establishment for Control tests */
 
 	/*
-- 
1.8.3.2

