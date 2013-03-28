Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 01/16] attrib: Simplify boolean tests
Date: Thu, 28 Mar 2013 11:39:05 -0400
Message-Id: <1364485160-22720-2-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove unnecessary TRUE/FALSE in boolean tests.
---
 attrib/gatt.c     | 4 ++--
 attrib/gattrib.c  | 6 +++---
 attrib/gatttool.c | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 44d3eb6..a7cb8f7 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -86,7 +86,7 @@ static struct included_discovery *isd_ref(struct included_discovery *isd)
 
 static void isd_unref(struct included_discovery *isd)
 {
-	if (g_atomic_int_dec_and_test(&isd->refs) == FALSE)
+	if (!g_atomic_int_dec_and_test(&isd->refs))
 		return;
 
 	if (isd->err)
@@ -581,7 +581,7 @@ static void read_long_destroy(gpointer user_data)
 {
 	struct read_long_data *long_read = user_data;
 
-	if (g_atomic_int_dec_and_test(&long_read->ref) == FALSE)
+	if (!g_atomic_int_dec_and_test(&long_read->ref))
 		return;
 
 	if (long_read->buffer != NULL)
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 01c19f9..e8e1c2b 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -228,7 +228,7 @@ void g_attrib_unref(GAttrib *attrib)
 
 	DBG("%p: ref=%d", attrib, attrib->refs);
 
-	if (ret == FALSE)
+	if (!ret)
 		return;
 
 	attrib_destroy(attrib);
@@ -369,7 +369,7 @@ static gboolean match_event(struct event *evt, const uint8_t *pdu, gsize len)
 	if (evt->expected == GATTRIB_ALL_EVENTS)
 		return TRUE;
 
-	if (is_response(pdu[0]) == FALSE && evt->expected == GATTRIB_ALL_REQS)
+	if (!is_response(pdu[0]) && evt->expected == GATTRIB_ALL_REQS)
 		return TRUE;
 
 	if (evt->expected == pdu[0] && evt->handle == GATTRIB_ALL_HANDLES)
@@ -420,7 +420,7 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 			evt->func(buf, len, evt->user_data);
 	}
 
-	if (is_response(buf[0]) == FALSE)
+	if (!is_response(buf[0]))
 		return TRUE;
 
 	if (attrib->timeout_watch > 0) {
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 29e3261..6525ebc 100644
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
 		g_error_free(gerr);
 	}
-- 
1.8.2

