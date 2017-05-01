Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] unit/test-gatt: Add test for unknown request
Date: Mon,  1 May 2017 18:57:00 +0300
Message-Id: <20170501155700.23761-3-luiz.dentz@gmail.com>
In-Reply-To: <20170501155700.23761-1-luiz.dentz@gmail.com>
References: <20170501155700.23761-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This send an unknown command (0xff) to test that no response is sent
since the spec mandates the server to not respond to commands:

BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part F page 2179

  'If a server receives a command that it does not support, indicated
  by the Command Flag of the PDU set to one, then the server shall
  ignore the Command.'
---
 unit/test-gatt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 371cb46..e0d29c7 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -90,6 +90,11 @@ struct context {
 		.size = sizeof(data(args)),			\
 	}
 
+#define false_pdu()						\
+	{							\
+		.valid = false,					\
+	}
+
 #define define_test(name, function, type, bt_uuid, db,			\
 		test_step, args...)					\
 	do {								\
@@ -403,6 +408,13 @@ static gboolean send_pdu(gpointer user_data)
 	if (pdu->valid && (pdu->size == 0)) {
 		test_debug("(no action expected)", "GATT: ");
 		context->pdu_offset++;
+
+		/* Quit the context if we processed the last PDU */
+		if (!context->data->pdu_list[context->pdu_offset].valid) {
+			context_quit(context);
+			return FALSE;
+		}
+
 		return send_pdu(context);
 	}
 
@@ -4467,5 +4479,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0xbf, 0x00),
 			raw_pdu(0x01, 0xbf, 0x00, 0x00, 0x06));
 
+	define_test_server("/robustness/unkown-command",
+			test_server, service_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0xff, 0x00),
+			raw_pdu());
+
 	return tester_run();
 }
-- 
2.9.3

