Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 2/4] unit/test-avrcp: Add /TP/RCR/BV-04-C test
Date: Thu,  5 Jun 2014 14:45:45 +0300
Message-Id: <1401968747-11848-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1401968747-11848-1-git-send-email-luiz.dentz@gmail.com>
References: <1401968747-11848-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the TG can accept abort fragmentation correctly.
---
 unit/test-avrcp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index eddce41..e8cf34a 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -500,7 +500,7 @@ static int get_element_attributes(struct avrcp *session, uint8_t transaction,
 
 	DBG("");
 
-	if (g_str_equal(context->data->test_name, "/TP/RCR/BV-02-C")) {
+	if (g_str_has_prefix(context->data->test_name, "/TP/RCR")) {
 		uint8_t params[1024];
 
 		memset(params, 0x00, sizeof(params) / 2);
@@ -1666,5 +1666,21 @@ int main(int argc, char *argv[])
 				0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRIBUTES,
 				0x03, 0x00, 0x0e));
 
+	/* Abort continuing response - TG */
+	define_test("/TP/RCR/BV-04-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRIBUTES,
+				0x00, 0x00, 0x09, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00),
+			cont_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRIBUTES,
+				0x01, 0x01, 0xf9),
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_ABORT_CONTINUING,
+				0x00, 0x00, 0x01, AVRCP_GET_ELEMENT_ATTRIBUTES),
+			raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_ABORT_CONTINUING,
+				0x00, 0x00, 0x00));
+
 	return g_test_run();
 }
-- 
1.9.3

