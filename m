Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/8] unit/test-avrcp: Add /TP/MPS/BV-06-C test
Date: Wed,  8 Oct 2014 15:31:46 +0300
Message-Id: <1412771509-7996-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
References: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify the PlayerFeatureBitmask issued by the TG.
---
 unit/test-avrcp.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 7998976..72e75c3 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -727,17 +727,39 @@ static void test_server(gconstpointer data)
 	execute_context(context);
 }
 
+static void get_folder_items_rsp(struct avrcp *session, int err,
+					uint16_t counter, uint16_t number,
+					uint8_t *params, void *user_data)
+{
+	struct context *context = user_data;
+
+	DBG("");
+
+	g_assert_cmpint(err, ==, 0);
+	g_assert_cmpint(counter, ==, 0xabcd);
+	g_assert_cmpint(number, ==, 0);
+
+	context_quit(context);
+}
+
+static const struct avrcp_control_cfm control_cfm = {
+	.get_folder_items = get_folder_items_rsp,
+};
+
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(0x0100, data);
 
+	avrcp_register_player(context->session, NULL, &control_cfm, context);
+
 	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-01-C"))
 		avrcp_set_addressed_player(context->session, 0xabcd);
 
 	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-03-C"))
 		avrcp_set_browsed_player(context->session, 0xabcd);
 
-	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-08-C"))
+	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-06-C") ||
+		g_str_equal(context->data->test_name, "/TP/MPS/BV-08-C"))
 		avrcp_get_folder_items(context->session,
 					AVRCP_MEDIA_PLAYER_LIST, 0, 2, 0, NULL);
 
@@ -909,6 +931,16 @@ int main(int argc, char *argv[])
 				0x01, 0x00, 0xcd, 0xab));
 
 	/* GetFolderItems - CT */
+	define_test("/TP/MPS/BV-06-C", test_client,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x0a, AVRCP_MEDIA_PLAYER_LIST,
+				0x00, 0x00, 0x00, 0x00, /* start */
+				0x00, 0x00, 0x00, 0x02, /* end */
+				0x00),
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x05, 0x04, 0xab, 0xcd, 0x00, 0x00));
+
+	/* GetFolderItems - CT */
 	define_test("/TP/MPS/BV-08-C", test_client,
 			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
 				0x00, 0x0a, AVRCP_MEDIA_PLAYER_LIST,
-- 
1.9.3

