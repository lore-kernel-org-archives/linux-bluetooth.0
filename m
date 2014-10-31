Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 5/7] unit/test-gatt: Add TP/GAD/CL/BV-02-C-2 test
Date: Fri, 31 Oct 2014 09:52:01 +0100
Message-Id: <1414745523-31699-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414745523-31699-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414745523-31699-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile client
can discover Primary Services selected by service
using 128-bit UUID.
---
 unit/test-gatt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 1167d4d..239f471 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -99,6 +99,12 @@ static bt_uuid_t uuid_16 = {
 	.value.u16 = 0x1800
 };
 
+static bt_uuid_t uuid_128 = {
+	.type = BT_UUID128,
+	.value.u128.data = {0x00, 0x00, 0x18, 0x0d, 0x00, 0x00, 0x10, 0x00,
+				0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb}
+};
+
 static void test_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
@@ -349,5 +355,19 @@ int main(int argc, char *argv[])
 					0x18),
 			raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
 
+	define_test("/TP/GAD/CL/BV-02-C-2", test_search_primary, ATT, &uuid_128,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0xfb,
+					0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00,
+					0x80, 0x00, 0x10, 0x00, 0x00, 0x0d,
+					0x18, 0x00, 0x00),
+			raw_pdu(0x07, 0x10, 0x00, 0x17, 0x00),
+			raw_pdu(06, 0x18, 0x00, 0xff, 0xff, 0x00, 0x28, 0xfb,
+					0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00,
+					0x80, 0x00, 0x10, 0x00, 0x00, 0x0d,
+					0x18, 0x00, 0x00),
+			raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
+
 	return g_test_run();
 }
-- 
1.9.3

