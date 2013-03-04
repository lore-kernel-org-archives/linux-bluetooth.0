Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 5/6] attrib: simplify boolean tests
Date: Mon,  4 Mar 2013 16:58:49 -0400
Message-Id: <1362430730-19580-6-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove unnecessary TRUE/FALSE in boolean tests.
---
 attrib/gatt.c     | 4 ++--
 attrib/gattrib.c  | 6 +++---
 attrib/gatttool.c | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 9a2d909..3f1a469 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -86,7 +86,7 @@ static struct included_discovery *isd_ref(struct included_discovery *isd)
 
 static void isd_unref(struct included_discovery *isd)
 {
-	if (g_atomic_int_dec_and_test(&isd->refs) == FALSE)
+	if (!g_atomic_int_dec_and_test(&isd->refs))
 		return;
 
 	if (isd->err)
@@ -582,7 +582,7 @@ static void read_long_destroy(void *user_data)
 {
 	struct read_long_data *long_read = user_data;
 
-	if (g_atomic_int_dec_and_test(&long_read->ref) == FALSE)
+	if (!g_atomic_int_dec_and_test(&long_read->ref))
 		return;
 
 	if (long_read->buffer != NULL)
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 7cc489a..33df293 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -228,7 +228,7 @@ void g_attrib_unref(GAttrib *attrib)
 
 	DBG("%p: ref=%d", attrib, attrib->refs);
 
-	if (ret == FALSE)
+	if (!ret)
 		return;
 
 	attrib_destroy(attrib);
@@ -368,7 +368,7 @@ static gboolean match_event(struct event *evt, const uint8_t *pdu, size_t len)
 	if (evt->expected == GATTRIB_ALL_EVENTS)
 		return TRUE;
 
-	if (is_response(pdu[0]) == FALSE && evt->expected == GATTRIB_ALL_REQS)
+	if (!is_response(pdu[0]) && evt->expected == GATTRIB_ALL_REQS)
 		return TRUE;
 
 	if (evt->expected == pdu[0] && evt->handle == GATTRIB_ALL_HANDLES)
@@ -419,7 +419,7 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, void *data)
 			evt->func(buf, len, evt->user_data);
 	}
 
-	if (is_response(buf[0]) == FALSE)
+	if (!is_response(buf[0]))
 		return TRUE;
 
 	if (attrib->timeout_watch > 0) {
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 62a7c11..5f4388d 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -247,7 +247,7 @@ static void char_read_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 	g_print("\n");
 
 done:
-	if (opt_listen == FALSE)
+	if (!opt_listen)
 		g_main_loop_quit(event_loop);
 }
 
@@ -377,7 +377,7 @@ static void char_write_req_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 	g_print("Characteristic value was written successfully\n");
 
 done:
-	if (opt_listen == FALSE)
+	if (!opt_listen)
 		g_main_loop_quit(event_loop);
 }
 
@@ -451,7 +451,7 @@ static void char_desc_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 	att_data_list_free(list);
 
 done:
-	if (opt_listen == FALSE)
+	if (!opt_listen)
 		g_main_loop_quit(event_loop);
 }
 
@@ -572,7 +572,7 @@ int main(int argc, char *argv[])
 	g_option_context_add_group(context, char_rw_group);
 	g_option_group_add_entries(char_rw_group, char_rw_options);
 
-	if (g_option_context_parse(context, &argc, &argv, &gerr) == FALSE) {
+	if (!g_option_context_parse(context, &argc, &argv, &gerr)) {
 		g_printerr("%s\n", gerr->message);
 		g_error_free(gerr);
 	}
-- 
1.8.1.4

