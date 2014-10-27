Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v3 10/10] unit/gattrib: copy result PDU
Date: Mon, 27 Oct 2014 15:14:01 -0700
Message-Id: <1414448041-27866-11-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1414448041-27866-1-git-send-email-jamuraa@chromium.org>
References: <1414448041-27866-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Memory is not guaranteed to stay around after the result
function is called, so we must copy the PDU.
---
 unit/test-gattrib.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
index 0ccf09a..e8d7c84 100644
--- a/unit/test-gattrib.c
+++ b/unit/test-gattrib.c
@@ -203,7 +203,7 @@ static gboolean test_client(GIOChannel *channel, GIOCondition cond,
 
 struct result_data {
 	guint8 status;
-	const guint8 *pdu;
+	guint8 *pdu;
 	guint16 len;
 	bool done;
 };
@@ -212,8 +212,10 @@ static void result_canary(guint8 status, const guint8 *pdu, guint16 len,
 								gpointer data)
 {
 	struct result_data *result = data;
+
 	result->status = status;
-	result->pdu = pdu;
+	result->pdu = g_malloc0(len);
+	memcpy(result->pdu, pdu, len);
 	result->len = len;
 
 	if (g_test_verbose())
@@ -229,7 +231,7 @@ static void test_send(struct context *cxt, gconstpointer unused)
 	struct challenge_response data = {
 		.expect = data(0x02, 0x00, 0x02),
 		.expect_len = 3,
-		.respond = data(0x01, 0x02, 0x03, 0x04),
+		.respond = data(0x03, 0x02, 0x03, 0x04),
 		.respond_len = 4,
 		.received = false,
 	};
@@ -251,6 +253,8 @@ static void test_send(struct context *cxt, gconstpointer unused)
 
 	cmp = memcmp(results.pdu, data.respond, results.len);
 
+	g_free(results.pdu);
+
 	g_assert(cmp == 0);
 }
 
@@ -262,7 +266,7 @@ static void test_cancel(struct context *cxt, gconstpointer unused)
 	struct challenge_response data = {
 		.expect = data(0x02, 0x00, 0x02),
 		.expect_len = 3,
-		.respond = data(0x01, 0x02, 0x03, 0x04),
+		.respond = data(0x03, 0x02, 0x03, 0x04),
 		.respond_len = 4,
 		.received = false,
 	};
-- 
2.1.0.rc2.206.gedb03e5

