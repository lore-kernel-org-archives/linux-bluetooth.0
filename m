Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 2/4] gattrib: Remove unused GATTRIB_ALL_EVENTS
Date: Wed,  5 Nov 2014 18:15:09 -0800
Message-Id: <1415240111-10596-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1415240111-10596-1-git-send-email-jamuraa@chromium.org>
References: <1415240111-10596-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In prep to use shared stack, this is unused and not functionally
supported by bt_att.
---
 attrib/gattrib.c    |  3 ---
 attrib/gattrib.h    |  1 -
 unit/test-gattrib.c | 16 ----------------
 3 files changed, 20 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index f678435..fa51b6d 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -391,9 +391,6 @@ static bool match_event(struct event *evt, const uint8_t *pdu, gsize len)
 {
 	guint16 handle;
 
-	if (evt->expected == GATTRIB_ALL_EVENTS)
-		return true;
-
 	if (is_request(pdu[0]) && evt->expected == GATTRIB_ALL_REQS)
 		return true;
 
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 1557b99..2ed57c1 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -28,7 +28,6 @@
 extern "C" {
 #endif
 
-#define GATTRIB_ALL_EVENTS 0xFF
 #define GATTRIB_ALL_REQS 0xFE
 #define GATTRIB_ALL_HANDLES 0x0000
 
diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
index 228ef5b..109e516 100644
--- a/unit/test-gattrib.c
+++ b/unit/test-gattrib.c
@@ -425,8 +425,6 @@ static void test_register(struct context *cxt, gconstpointer user_data)
 	guint reg_id;
 	gboolean canceled;
 	struct test_pdu pdus[] = {
-		/* Unmatched by any (GATTRIB_ALL_EVENTS) */
-		PDU_MTU_RESP,
 		/*
 		 * Unmatched PDU opcode
 		 * Unmatched handle (GATTRIB_ALL_REQS) */
@@ -461,22 +459,8 @@ static void test_register(struct context *cxt, gconstpointer user_data)
 	/*
 	 * Without registering anything, should be able to ignore everything but
 	 * an unexpected response. */
-	send_test_pdus(cxt, pdus + 1);
-
-	expect.expected = pdus;
-	reg_id = g_attrib_register(cxt->att, GATTRIB_ALL_EVENTS,
-				      GATTRIB_ALL_HANDLES, notify_canary_expect,
-								 &expect, NULL);
-
 	send_test_pdus(cxt, pdus);
 
-	canceled = g_attrib_unregister(cxt->att, reg_id);
-
-	g_assert(canceled);
-
-	for (current_pdu = pdus; current_pdu->valid; current_pdu++)
-		g_assert(current_pdu->received);
-
 	if (g_test_verbose())
 		g_print("ALL_REQS, ALL_HANDLES\r\n");
 
-- 
2.1.2

