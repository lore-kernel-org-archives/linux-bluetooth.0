Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 16/35] unit/test-avrcp: Add /TP/MCN/CB/BV-05-C test
Date: Fri, 25 Apr 2014 11:38:53 +0300
Message-Id: <1398415152-22950-17-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the ChangePath response issued by the TG.
---
 unit/test-avrcp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 723d90d..ecaaeda 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -567,6 +567,17 @@ static int get_folder_items(struct avrcp *session, uint8_t transaction,
 	return -EAGAIN;
 }
 
+static int change_path(struct avrcp *session, uint8_t transaction,
+					uint16_t counter, uint8_t direction,
+					uint64_t uid, void *user_data)
+{
+	DBG("");
+
+	avrcp_change_path_rsp(session, transaction, 0);
+
+	return -EAGAIN;
+}
+
 static const struct avrcp_control_ind control_ind = {
 	.get_capabilities = get_capabilities,
 	.list_attributes = list_attributes,
@@ -580,6 +591,7 @@ static const struct avrcp_control_ind control_ind = {
 	.register_notification = register_notification,
 	.set_addressed = set_addressed,
 	.get_folder_items = get_folder_items,
+	.change_path = change_path,
 };
 
 static void test_server(gconstpointer data)
@@ -768,6 +780,17 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x00, 0x00,
 				0x00, 0x00, 0x00, 0x01	/* Folder UID */));
 
+	/* ChangePath - TG */
+	define_test("/TP/MCN/CB/BV-05-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_CHANGE_PATH,
+				0x00, 0x0b,
+				0xaa, 0xbb,		/* counter */
+				0x01,			/* direction */
+				0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x01	/* Folder UID */),
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_CHANGE_PATH,
+				0x00, 0x05, 0x04, 0x00, 0x00, 0x00, 0x00));
+
 	/* GetItemAttributes - CT */
 	define_test("/TP/MCN/CB/BV-07-C", test_client,
 			raw_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUTES,
-- 
1.9.0

