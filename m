Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 4/4] unit/avrcp: Add TP/MPS/BV-08-C test case
Date: Thu, 20 Feb 2014 15:22:39 +0200
Message-Id: <1392902559-23987-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1392902559-23987-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1392902559-23987-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This verifies GetFolderItems command for controller.
---
 android/avrcp-lib.c | 27 +++++++++++++++++++++++++++
 android/avrcp-lib.h |  2 ++
 unit/test-avrcp.c   | 10 ++++++++++
 3 files changed, 39 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 92d2ac8..4f92780 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -39,6 +39,9 @@
 
 #define AVRCP_SET_ADDRESSED_PLAYER	0x60
 #define AVRCP_SET_BROWSED_PLAYER	0x70
+#define AVRCP_GET_FOLDER_ITEMS		0x71
+
+#define AVRCP_MEDIA_ATTRIBUTE_TITLE	0x01
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
@@ -175,3 +178,27 @@ int avrcp_set_browsed_player(struct avrcp *avrcp_session, uint16_t id)
 	return avctp_send_browsing_req(session, buf, sizeof(buf),
 					avrcp_set_browsed_player_rsp, session);
 }
+
+int avrcp_get_folder_items(struct avrcp *avrcp_session, uint32_t start,
+								uint32_t end)
+{
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 10 + sizeof(uint32_t)];
+	struct avrcp_browsing_header *pdu = (void *) buf;
+	struct avctp *session = avrcp_session->session;
+
+	memset(buf, 0, sizeof(buf));
+
+	pdu->pdu_id = AVRCP_GET_FOLDER_ITEMS;
+	pdu->param_len = htons(10 + sizeof(uint32_t));
+
+	bt_put_be32(start, &pdu->params[1]);
+	bt_put_be32(end, &pdu->params[5]);
+
+	pdu->params[9] = 1;
+
+	/* Only the title (0x01) is mandatory. This can be extended to
+	 * support AVRCP_MEDIA_ATTRIBUTE_* attributes */
+	bt_put_be32(AVRCP_MEDIA_ATTRIBUTE_TITLE, &pdu->params[10]);
+
+	return avctp_send_browsing_req(session, buf, sizeof(buf), NULL, NULL);
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 2eb020b..b5d52b6 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -33,3 +33,5 @@ int avrcp_init_uinput(struct avrcp *session, const char *name,
 							const char *address);
 int avrcp_set_addr_player(struct avrcp *avrcp_session, uint16_t id);
 int avrcp_set_browsed_player(struct avrcp *avrcp_session, uint16_t id);
+int avrcp_get_folder_items(struct avrcp *avrcp_session, uint32_t start,
+								uint32_t end);
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 692652c..3971bd0 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -332,6 +332,9 @@ static void test_client(gconstpointer data)
 	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-03-C"))
 		ret = avrcp_set_browsed_player(context->session, 0xabcd);
 
+	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-08-C"))
+		ret = avrcp_get_folder_items(context->session, 0, 2);
+
 	DBG("ret = %d", ret);
 
 	g_assert(!ret);
@@ -356,5 +359,12 @@ int main(int argc, char *argv[])
 	define_test("/TP/MPS/BV-03-C", test_client,
 			raw_pdu(0x00, 0x11, 0x0e, 0x70, 0x00, 0x02,
 				0xab, 0xcd));
+
+	define_test("/TP/MPS/BV-08-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x71, 0x00, 0x0e,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x02, 0x01, 0x00, 0x00,
+				0x00, 0x01));
+
 	return g_test_run();
 }
-- 
1.8.3.2

