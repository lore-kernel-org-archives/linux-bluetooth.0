Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 19/20] unit/avrcp: Add /TP/MCN/SRC/BV-03-C test
Date: Mon, 31 Mar 2014 15:25:13 +0300
Message-Id: <1396268714-4056-19-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that GetFolderItems is issued with parameter
AVRCP_MEDIA_SEARCH.
---
 unit/test-avrcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 00fdaff..d901523 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -611,6 +611,10 @@ static void test_client(gconstpointer data)
 		avrcp_search(context->session, AVRCP_CHARSET_UTF8, "Country",
 								NULL, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/MCN/SRC/BV-03-C"))
+		avrcp_get_folder_items(context->session, AVRCP_MEDIA_SEARCH,
+						0, 2, NULL, 0, NULL, NULL);
+
 	if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
 		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED);
 
@@ -736,6 +740,13 @@ int main(int argc, char *argv[])
 				0x00, 0x07,
 				0x43, 0x6f, 0x75, 0x6e, 0x74, 0x72, 0x79));
 
+	/* GetFolderItems - CT */
+	define_test("/TP/MCN/SRC/BV-03-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x0a, AVRCP_MEDIA_SEARCH,
+				0x00, 0x00, 0x00, 0x00, /* start */
+				0x00, 0x00, 0x00, 0x02, /* end */
+				0x00));
 
 	/* Media Player Selection IOP tests */
 
-- 
1.8.3.2

