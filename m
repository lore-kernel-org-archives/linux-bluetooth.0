Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 2/8] unit/test-gatt: Add support for no-actions
Date: Tue, 10 Feb 2015 12:16:18 -0800
Message-Id: <1423599385-36295-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
References: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With some tests (specifically notification / indication tests), the
client sets up a condition and then the server does something without
a message from the client.  This patch makes it possible to add a
zero-length PDU which indicates that no message is expected from the
client after a server response.
---
 unit/test-gatt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index cd90d83..7bc2168 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -250,6 +250,15 @@ static gboolean send_pdu(gpointer user_data)
 	g_assert_cmpint(len, ==, pdu->size);
 
 	context->process = 0;
+
+	pdu = &context->data->pdu_list[context->pdu_offset];
+	if (pdu->valid && (pdu->size == 0)) {
+		if (g_test_verbose())
+			test_debug("(no action expected)", "GATT: ");
+		context->pdu_offset++;
+		return send_pdu(context);
+	}
+
 	return FALSE;
 }
 
-- 
2.2.0.rc0.207.ga3a616c

