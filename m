Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/35] unit/test-avrcp: Add /TP/MPS/BV-09-C test
Date: Fri, 25 Apr 2014 11:38:44 +0300
Message-Id: <1398415152-22950-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify the GetFolderItems response for the Media Player List issued by
the TG.
---
 unit/test-avrcp.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index a483f0e..40c8ed5 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -231,7 +231,7 @@ static gboolean browse_test_handler(GIOChannel *channel, GIOCondition cond,
 	g_assert(len > 0);
 
 	if (g_test_verbose())
-		util_hexdump('>', buf, len, test_debug, "AVCTP: ");
+		util_hexdump('>', buf, len, test_debug, "AVRCP: ");
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -545,6 +545,19 @@ static int set_addressed(struct avrcp *session, uint8_t transaction,
 	return -EAGAIN;
 }
 
+static int get_folder_items(struct avrcp *session, uint8_t transaction,
+				uint8_t scope, uint32_t start, uint32_t end,
+				uint16_t number, uint32_t *attrs,
+				void *user_data)
+{
+	DBG("");
+
+	avrcp_get_folder_items_rsp(session, transaction, 0xabcd, 0, NULL, NULL,
+									NULL);
+
+	return -EAGAIN;
+}
+
 static const struct avrcp_control_ind control_ind = {
 	.get_capabilities = get_capabilities,
 	.list_attributes = list_attributes,
@@ -557,6 +570,7 @@ static const struct avrcp_control_ind control_ind = {
 	.get_element_attributes = get_element_attributes,
 	.register_notification = register_notification,
 	.set_addressed = set_addressed,
+	.get_folder_items = get_folder_items,
 };
 
 static void test_server(gconstpointer data)
@@ -699,6 +713,16 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x00, 0x02, /* end */
 				0x00));
 
+	/* GetFolderItems - TG */
+	define_test("/TP/MPS/BV-09-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x0a, AVRCP_MEDIA_PLAYER_LIST,
+				0x00, 0x00, 0x00, 0x00, /* start */
+				0x00, 0x00, 0x00, 0x02, /* end */
+				0x00),
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x05, 0x04, 0xab, 0xcd, 0x00, 0x00));
+
 	/*
 	 * Media Content Navigation Commands and Notifications for Content
 	 * Browsing.
-- 
1.9.0

