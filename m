Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ v3 01/16] attrib: Simplify boolean tests
Date: Wed, 17 Apr 2013 10:03:04 -0400
Message-Id: <1366207399-29536-2-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1366207399-29536-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1365621421-1422-1-git-send-email-jefferson.delfes@openbossa.org>
 <1366207399-29536-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove unnecessary TRUE/FALSE in boolean tests.
---
 attrib/gattrib.c  | 4 ++--
 attrib/gatttool.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index e6d6022..416d17b 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -371,7 +371,7 @@ static gboolean match_event(struct event *evt, const uint8_t *pdu, gsize len)
 	if (evt->expected == GATTRIB_ALL_EVENTS)
 		return TRUE;
 
-	if (is_response(pdu[0]) == FALSE && evt->expected == GATTRIB_ALL_REQS)
+	if (!is_response(pdu[0]) && evt->expected == GATTRIB_ALL_REQS)
 		return TRUE;
 
 	if (evt->expected == pdu[0] && evt->handle == GATTRIB_ALL_HANDLES)
@@ -421,7 +421,7 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 			evt->func(buf, len, evt->user_data);
 	}
 
-	if (is_response(buf[0]) == FALSE)
+	if (!is_response(buf[0]))
 		return TRUE;
 
 	if (attrib->timeout_watch > 0) {
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index e1d8407..dd0f1e2 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -248,7 +248,7 @@ static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	g_print("\n");
 
 done:
-	if (opt_listen == FALSE)
+	if (!opt_listen)
 		g_main_loop_quit(event_loop);
 }
 
@@ -378,7 +378,7 @@ static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	g_print("Characteristic value was written successfully\n");
 
 done:
-	if (opt_listen == FALSE)
+	if (!opt_listen)
 		g_main_loop_quit(event_loop);
 }
 
@@ -452,7 +452,7 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	att_data_list_free(list);
 
 done:
-	if (opt_listen == FALSE)
+	if (!opt_listen)
 		g_main_loop_quit(event_loop);
 }
 
@@ -573,7 +573,7 @@ int main(int argc, char *argv[])
 	g_option_context_add_group(context, char_rw_group);
 	g_option_group_add_entries(char_rw_group, char_rw_options);
 
-	if (g_option_context_parse(context, &argc, &argv, &gerr) == FALSE) {
+	if (!g_option_context_parse(context, &argc, &argv, &gerr)) {
 		g_printerr("%s\n", gerr->message);
 		g_clear_error(&gerr);
 	}
-- 
1.8.2

