Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] unit/avrcp: Add TP/MPS/BV-03-C test case
Date: Thu,  6 Feb 2014 18:06:14 +0200
Message-Id: <1391702774-18972-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1391702774-18972-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391702774-18972-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the Set Browsed Player command issued by the
AVRCP controller.
---
 unit/test-avrcp.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 58e4c15..211ea36 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -330,6 +330,7 @@ static void execute_context(struct context *context)
 }
 
 #define AVRCP_SET_ADDRESSED_PLAYER	0x60
+#define AVRCP_SET_BROWSED_PLAYER	0x70
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
@@ -359,6 +360,13 @@ struct avrcp_header {
 #error "Unknown byte order"
 #endif
 
+struct avrcp_browsing_header {
+	uint8_t pdu_id;
+	uint16_t param_len;
+	uint8_t params[0];
+} __attribute__ ((packed));
+#define AVRCP_BROWSING_HEADER_LENGTH 3
+
 static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
 {
 	cid[0] = cid_in >> 16;
@@ -386,6 +394,35 @@ static int avrcp_set_addr_player(struct context *context)
 					NULL, NULL);
 }
 
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
+static int avrcp_set_browsed_player(struct context *context)
+{
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 2];
+	struct avrcp_browsing_header *pdu = (void *) buf;
+	struct avctp *session = context->dev->session;
+
+	DBG("");
+
+	memset(buf, 0, sizeof(buf));
+
+	pdu->pdu_id = AVRCP_SET_BROWSED_PLAYER;
+	pdu->params[0] = 0xab;
+	pdu->params[1] = 0xcd;
+	pdu->param_len = htons(2);
+
+	return avctp_send_browsing_req(session, buf, sizeof(buf),
+					avrcp_set_browsed_player_rsp, session);
+}
+
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(0x0100, data);
@@ -394,6 +431,9 @@ static void test_client(gconstpointer data)
 	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-01-C"))
 		ret = avrcp_set_addr_player(context);
 
+	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-03-C"))
+		ret = avrcp_set_browsed_player(context);
+
 	DBG("ret = %d", ret);
 
 	g_assert(!ret);
@@ -415,5 +455,8 @@ int main(int argc, char *argv[])
 				0x00, 0x19, 0x58, 0x60, 0x00, 0x00,
 				0x02, 0xab, 0xcd));
 
+	define_test("/TP/MPS/BV-03-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x70, 0x00, 0x02,
+				0xab, 0xcd));
 	return g_test_run();
 }
-- 
1.8.3.2

