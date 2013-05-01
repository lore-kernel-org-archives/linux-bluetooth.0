Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ v2 01/16] attrib: Get rid of gint
Date: Wed,  1 May 2013 02:27:55 -0300
Message-Id: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int,
so it's safe to use it even for callbacks with glib.
---

v2: Fix commit message

 attrib/gatt-service.c | 2 +-
 attrib/gatt.c         | 2 +-
 attrib/gattrib.c      | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index bdb12cd..4b02d39 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -168,7 +168,7 @@ static int att_write_req(int authorization, int authentication, uint8_t props)
 	return ATT_NONE;
 }
 
-static gint find_callback(gconstpointer a, gconstpointer b)
+static int find_callback(gconstpointer a, gconstpointer b)
 {
 	const struct attrib_cb *cb = a;
 	unsigned int event = GPOINTER_TO_UINT(b);
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 749e820..0f116e8 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -575,7 +575,7 @@ struct read_long_data {
 	guint16 size;
 	guint16 handle;
 	guint id;
-	gint ref;
+	int ref;
 };
 
 static void read_long_destroy(gpointer user_data)
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 7fb460f..c662ace 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -45,7 +45,7 @@
 
 struct _GAttrib {
 	GIOChannel *io;
-	gint refs;
+	int refs;
 	uint8_t *buf;
 	size_t buflen;
 	guint read_watch;
@@ -556,7 +556,7 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
 	return c->id;
 }
 
-static gint command_cmp_by_id(gconstpointer a, gconstpointer b)
+static int command_cmp_by_id(gconstpointer a, gconstpointer b)
 {
 	const struct command *cmd = a;
 	guint id = GPOINTER_TO_UINT(b);
@@ -692,7 +692,7 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 	return event->id;
 }
 
-static gint event_cmp_by_id(gconstpointer a, gconstpointer b)
+static int event_cmp_by_id(gconstpointer a, gconstpointer b)
 {
 	const struct event *evt = a;
 	guint id = GPOINTER_TO_UINT(b);
-- 
1.8.2.2

