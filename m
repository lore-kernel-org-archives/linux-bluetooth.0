Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v4 10/10] unit/gattrib: copy result PDU
Date: Wed, 29 Oct 2014 19:45:45 -0700
Message-Id: <1414637145-32919-11-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1414637145-32919-1-git-send-email-jamuraa@chromium.org>
References: <1414637145-32919-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Memory is not guaranteed to stay around after the result
function is called, so we must copy the PDU.
---
 unit/test-gattrib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
index 4f1343b..56dc709 100644
--- a/unit/test-gattrib.c
+++ b/unit/test-gattrib.c
@@ -212,7 +212,7 @@ static gboolean test_client(GIOChannel *channel, GIOCondition cond,
 
 struct result_data {
 	guint8 status;
-	const guint8 *pdu;
+	guint8 *pdu;
 	guint16 len;
 	GSourceFunc complete_cb;
 	gpointer user_data;
@@ -222,8 +222,10 @@ static void result_canary(guint8 status, const guint8 *pdu, guint16 len,
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
@@ -267,6 +269,8 @@ static void test_send(struct context *cxt, gconstpointer unused)
 
 	cmp = memcmp(results.pdu, data.respond.data, results.len);
 
+	g_free(results.pdu);
+
 	g_assert(cmp == 0);
 
 	g_free(results.pdu);
-- 
2.1.0.rc2.206.gedb03e5

