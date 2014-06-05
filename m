Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 1/4] unit/test-avrcp: Add /TP/RCR/BV-02-C test
Date: Thu,  5 Jun 2014 14:45:44 +0300
Message-Id: <1401968747-11848-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify that the TG can handle fragmentation correctly.
---
v2: Fix not copying from offset.
v3: Add define for AV/C data offset so it can be taken into account when
calculating the amount of bytes that can fit in a single packet.

 unit/test-avrcp.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index c41f2e6..eddce41 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -46,6 +46,7 @@
 struct test_pdu {
 	bool valid;
 	bool fragmented;
+	bool continuing;
 	bool browse;
 	const uint8_t *data;
 	size_t size;
@@ -93,6 +94,14 @@ struct context {
 		.size = sizeof(data(args)),			\
 	}
 
+#define cont_pdu(args...)					\
+	{							\
+		.valid = true,					\
+		.continuing = true,				\
+		.data = data(args),				\
+		.size = sizeof(data(args)),			\
+	}
+
 #define define_test(name, function, args...)				\
 	do {								\
 		const struct test_pdu pdus[] = {			\
@@ -195,7 +204,8 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 	if (g_test_verbose())
 		util_hexdump('>', buf, len, test_debug, "AVRCP: ");
 
-	g_assert_cmpint(len, ==, pdu->size);
+	if (!pdu->continuing)
+		g_assert_cmpint(len, ==, pdu->size);
 
 	g_assert(memcmp(buf, pdu->data, pdu->size) == 0);
 
@@ -486,9 +496,20 @@ static int get_element_attributes(struct avrcp *session, uint8_t transaction,
 					uint64_t uid, uint8_t number,
 					uint32_t *attrs, void *user_data)
 {
+	struct context *context = user_data;
+
 	DBG("");
 
-	avrcp_get_element_attrs_rsp(session, transaction, NULL, 0);
+	if (g_str_equal(context->data->test_name, "/TP/RCR/BV-02-C")) {
+		uint8_t params[1024];
+
+		memset(params, 0x00, sizeof(params) / 2);
+		memset(params + (sizeof(params) / 2), 0xff, sizeof(params) / 2);
+
+		avrcp_get_element_attrs_rsp(session, transaction, params,
+							sizeof(params));
+	} else
+		avrcp_get_element_attrs_rsp(session, transaction, NULL, 0);
 
 	return -EAGAIN;
 }
@@ -1623,5 +1644,27 @@ int main(int argc, char *argv[])
 				0x00, 0x19, 0x58, AVRCP_SET_ABSOLUTE_VOLUME,
 				0x00, 0x00, 0x01, 0x00));
 
+	/* Request continuing response - TG */
+	define_test("/TP/RCR/BV-02-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRIBUTES,
+				0x00, 0x00, 0x09, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00),
+			cont_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRIBUTES,
+				0x01, 0x01, 0xf9),
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REQUEST_CONTINUING,
+				0x00, 0x00, 0x01, AVRCP_GET_ELEMENT_ATTRIBUTES),
+			cont_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRIBUTES,
+				0x02, 0x01, 0xf9),
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REQUEST_CONTINUING,
+				0x00, 0x00, 0x01, AVRCP_GET_ELEMENT_ATTRIBUTES),
+			cont_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRIBUTES,
+				0x03, 0x00, 0x0e));
+
 	return g_test_run();
 }
-- 
1.9.3

