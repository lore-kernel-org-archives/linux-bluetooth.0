Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/3] Add support for GATT client timeouts
Date: Thu, 24 Feb 2011 17:34:27 -0300
Message-Id: <1298579668-3143-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1298579668-3143-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1298579668-3143-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to destroying the GATT connection
when a GATT server doesn't respond for more than 30 seconds.

A function to destroy the GAttrib is introduced and it is used
in the timeout case and when the last GAttrib reference is
dropped.
---
 attrib/gattrib.c |   43 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 5b8b590..cf49ede 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -36,12 +36,15 @@
 #include "btio.h"
 #include "gattrib.h"
 
+#define GATT_TIMEOUT 30
+
 struct _GAttrib {
 	GIOChannel *io;
 	gint refs;
 	gint mtu;
 	guint read_watch;
 	guint write_watch;
+	guint timeout_watch;
 	GQueue *queue;
 	GSList *events;
 	guint next_cmd_id;
@@ -164,17 +167,11 @@ static void event_destroy(struct event *evt)
 	g_free(evt);
 }
 
-void g_attrib_unref(GAttrib *attrib)
+static void attrib_destroy(GAttrib *attrib)
 {
 	GSList *l;
 	struct command *c;
 
-	if (!attrib)
-		return;
-
-	if (g_atomic_int_dec_and_test(&attrib->refs) == FALSE)
-		return;
-
 	while ((c = g_queue_pop_head(attrib->queue)))
 		command_destroy(c);
 
@@ -187,6 +184,9 @@ void g_attrib_unref(GAttrib *attrib)
 	g_slist_free(attrib->events);
 	attrib->events = NULL;
 
+	if (attrib->timeout_watch> 0)
+		g_source_remove(attrib->timeout_watch);
+
 	if (attrib->write_watch > 0)
 		g_source_remove(attrib->write_watch);
 
@@ -201,6 +201,17 @@ void g_attrib_unref(GAttrib *attrib)
 	g_free(attrib);
 }
 
+void g_attrib_unref(GAttrib *attrib)
+{
+	if (!attrib)
+		return;
+
+	if (g_atomic_int_dec_and_test(&attrib->refs) == FALSE)
+		return;
+
+	attrib_destroy(attrib);
+}
+
 GIOChannel *g_attrib_get_channel(GAttrib *attrib)
 {
 	if (!attrib)
@@ -233,6 +244,15 @@ gboolean g_attrib_set_destroy_function(GAttrib *attrib,
 	return TRUE;
 }
 
+static gboolean disconnect_timeout(gpointer data)
+{
+	struct _GAttrib *attrib = data;
+
+	attrib_destroy(attrib);
+
+	return FALSE;
+}
+
 static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
 								gpointer data)
 {
@@ -267,6 +287,10 @@ static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
 
 	cmd->sent = TRUE;
 
+	if (attrib->timeout_watch == 0)
+		attrib->timeout_watch = g_timeout_add_seconds(GATT_TIMEOUT,
+						disconnect_timeout, attrib);
+
 	return FALSE;
 }
 
@@ -295,6 +319,11 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	GIOStatus iostat;
 	gboolean qempty;
 
+	if (attrib->timeout_watch > 0) {
+		g_source_remove(attrib->timeout_watch);
+		attrib->timeout_watch = 0;
+	}
+
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
 		attrib->read_watch = 0;
 		if (attrib->disconnect)
-- 
1.7.4.1

