Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 30/35] unit/test-avrcp: Add /TP/MCN/SRC/BV-02-C test
Date: Fri, 25 Apr 2014 11:39:07 +0300
Message-Id: <1398415152-22950-31-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the Search response issued by the TG.
---
 unit/test-avrcp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 9da8761..0450d37 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -606,6 +606,16 @@ static int play_item(struct avrcp *session, uint8_t transaction, uint8_t scope,
 	return -EAGAIN;
 }
 
+static int search(struct avrcp *session, uint8_t transaction,
+					const char *string, void *user_data)
+{
+	DBG("");
+
+	avrcp_search_rsp(session, transaction, 0xaabb, 0);
+
+	return -EAGAIN;
+}
+
 static const struct avrcp_control_ind control_ind = {
 	.get_capabilities = get_capabilities,
 	.list_attributes = list_attributes,
@@ -622,6 +632,7 @@ static const struct avrcp_control_ind control_ind = {
 	.change_path = change_path,
 	.get_item_attributes = get_item_attributes,
 	.play_item = play_item,
+	.search = search,
 };
 
 static void test_server(gconstpointer data)
@@ -911,6 +922,16 @@ int main(int argc, char *argv[])
 				0x00, 0x07,
 				0x43, 0x6f, 0x75, 0x6e, 0x74, 0x72, 0x79));
 
+	define_test("/TP/MCN/SRC/BV-02-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_SEARCH,
+				0x00, 0x0b, 0x00, 0x6a,
+				0x00, 0x07,
+				0x43, 0x6f, 0x75, 0x6e, 0x74, 0x72, 0x79),
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_SEARCH,
+				0x00, 0x07, 0x04,
+				0xaa, 0xbb,		/* counter */
+				0x00, 0x00, 0x00, 0x00));
+
 	/* GetFolderItems - CT */
 	define_test("/TP/MCN/SRC/BV-03-C", test_client,
 			raw_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
-- 
1.9.0

