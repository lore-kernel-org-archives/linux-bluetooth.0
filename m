Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 3/4] unit/avrcp: Add TP/MPS/BV-03-C test case
Date: Thu, 20 Feb 2014 15:22:38 +0200
Message-Id: <1392902559-23987-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1392902559-23987-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1392902559-23987-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the Set Browsed Player command issued by the
AVRCP controller.
---
 android/avrcp-lib.c | 37 +++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  1 +
 unit/test-avrcp.c   |  6 ++++++
 3 files changed, 44 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 13bfd79..92d2ac8 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -38,6 +38,7 @@
 #define IEEEID_BTSIG		0x001958
 
 #define AVRCP_SET_ADDRESSED_PLAYER	0x60
+#define AVRCP_SET_BROWSED_PLAYER	0x70
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
@@ -67,6 +68,13 @@ struct avrcp_header {
 #error "Unknown byte order"
 #endif
 
+struct avrcp_browsing_header {
+	uint8_t pdu_id;
+	uint16_t param_len;
+	uint8_t params[0];
+} __attribute__ ((packed));
+#define AVRCP_BROWSING_HEADER_LENGTH 3
+
 struct avrcp {
 	struct avctp	*session;
 };
@@ -138,3 +146,32 @@ int avrcp_set_addr_player(struct avrcp *avrcp_session, uint16_t id)
 					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
 					NULL, NULL);
 }
+
+static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
+						uint8_t *operands,
+						size_t operand_count,
+						void *user_data)
+{
+	DBG("");
+
+	return FALSE;
+}
+
+int avrcp_set_browsed_player(struct avrcp *avrcp_session, uint16_t id)
+{
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 2];
+	struct avrcp_browsing_header *pdu = (void *) buf;
+	struct avctp *session = avrcp_session->session;
+
+	DBG("");
+
+	memset(buf, 0, sizeof(buf));
+
+	pdu->pdu_id = AVRCP_SET_BROWSED_PLAYER;
+
+	bt_put_be16(id, &pdu->params[0]);
+	pdu->param_len = htons(sizeof(id));
+
+	return avctp_send_browsing_req(session, buf, sizeof(buf),
+					avrcp_set_browsed_player_rsp, session);
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 7b0aaef..2eb020b 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -32,3 +32,4 @@ int avrcp_connect_browsing(struct avrcp *session, int fd, size_t imtu,
 int avrcp_init_uinput(struct avrcp *session, const char *name,
 							const char *address);
 int avrcp_set_addr_player(struct avrcp *avrcp_session, uint16_t id);
+int avrcp_set_browsed_player(struct avrcp *avrcp_session, uint16_t id);
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 9d4eede..692652c 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -329,6 +329,9 @@ static void test_client(gconstpointer data)
 	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-01-C"))
 		ret = avrcp_set_addr_player(context->session, 0xabcd);
 
+	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-03-C"))
+		ret = avrcp_set_browsed_player(context->session, 0xabcd);
+
 	DBG("ret = %d", ret);
 
 	g_assert(!ret);
@@ -350,5 +353,8 @@ int main(int argc, char *argv[])
 				0x00, 0x19, 0x58, 0x60, 0x00, 0x00,
 				0x02, 0xab, 0xcd));
 
+	define_test("/TP/MPS/BV-03-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x70, 0x00, 0x02,
+				0xab, 0xcd));
 	return g_test_run();
 }
-- 
1.8.3.2

