Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] unit/test-gatt: Check if crypto is enabled
Date: Tue, 10 Mar 2015 15:31:38 +0200
Message-Id: <1425994298-2883-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1425994298-2883-1-git-send-email-luiz.dentz@gmail.com>
References: <1425994298-2883-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks if crypto is enabled and in case it is not do not run test
/TP/GAW/CL/BV-02-C.
---
 unit/test-gatt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 2edcacb..7668e93 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -304,9 +304,12 @@ static gboolean context_quit(gpointer user_data)
 	if (step && step->post_func)
 		step->post_func(context);
 
-	destroy_context(context);
+	if (context->data->pdu_list[context->pdu_offset].valid)
+		tester_test_abort();
+	else
+		tester_test_passed();
 
-	tester_test_passed();
+	destroy_context(context);
 
 	return FALSE;
 }
@@ -910,6 +913,11 @@ static void test_signed_write(struct context *context)
 	uint8_t key[16] = {0xD8, 0x51, 0x59, 0x48, 0x45, 0x1F, 0xEA, 0x32, 0x0D,
 				0xC0, 0x5A, 0x2E, 0x88, 0x30, 0x81, 0x88 };
 
+	if (!bt_att_has_crypto(context->att)) {
+		context_quit(context);
+		return;
+	}
+
 	g_assert(bt_att_set_local_key(context->att, key, local_counter,
 								context));
 
-- 
2.1.0

