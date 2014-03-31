Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 20/20] unit/avrcp: Add /TP/MCN/SRC/BV-05-C test
Date: Mon, 31 Mar 2014 15:25:14 +0300
Message-Id: <1396268714-4056-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that GetItemAttributes command issued by the Controller on
a Media Item in the Search folder.
---
 unit/test-avrcp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index d901523..d02cd2d 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -615,6 +615,11 @@ static void test_client(gconstpointer data)
 		avrcp_get_folder_items(context->session, AVRCP_MEDIA_SEARCH,
 						0, 2, NULL, 0, NULL, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/MCN/SRC/BV-05-C"))
+		avrcp_get_item_attributes(context->session,
+					AVRCP_MEDIA_SEARCH, 0x01, 0xaabb,
+					NULL, 0, NULL, NULL);
+
 	if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
 		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED);
 
@@ -748,6 +753,15 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x00, 0x02, /* end */
 				0x00));
 
+	/* GetItemAttributes - CT */
+	define_test("/TP/MCN/SRC/BV-05-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUTES,
+				0x00, 0x0c, AVRCP_MEDIA_SEARCH,
+				0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x01,	/* uuid */
+				0xaa, 0xbb,		/* counter */
+				0x00));			/* num attr */
+
 	/* Media Player Selection IOP tests */
 
 	/* Listing of available media players */
-- 
1.8.3.2

