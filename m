Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 14/16] attrib: Change command->id type from guint
Date: Thu, 28 Mar 2013 11:39:18 -0400
Message-Id: <1364485160-22720-15-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change type of command->id and GAttrib->next_cmd_id for a standard type.
---
 attrib/gattrib.c | 10 +++++-----
 attrib/gattrib.h |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index ff29fc8..438a522 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -54,14 +54,14 @@ struct _GAttrib {
 	GQueue *requests;
 	GQueue *responses;
 	GSList *events;
-	guint next_cmd_id;
+	unsigned int next_cmd_id;
 	GDestroyNotify destroy;
 	gpointer destroy_user_data;
 	bool stale;
 };
 
 struct command {
-	guint id;
+	unsigned int id;
 	uint8_t opcode;
 	guint8 *pdu;
 	guint16 len;
@@ -505,9 +505,9 @@ GAttrib *g_attrib_new(GIOChannel *io)
 	return g_attrib_ref(attrib);
 }
 
-guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
-			GAttribResultFunc func, gpointer user_data,
-			GDestroyNotify notify)
+unsigned int g_attrib_send(GAttrib *attrib, unsigned int id, const guint8 *pdu,
+				guint16 len, GAttribResultFunc func,
+				gpointer user_data, GDestroyNotify notify)
 {
 	struct command *c;
 	GQueue *queue;
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 9d98bfe..06ed450 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -51,9 +51,9 @@ GIOChannel *g_attrib_get_channel(GAttrib *attrib);
 bool g_attrib_set_destroy_function(GAttrib *attrib, GDestroyNotify destroy,
 							gpointer user_data);
 
-guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
-			GAttribResultFunc func, gpointer user_data,
-			GDestroyNotify notify);
+unsigned int g_attrib_send(GAttrib *attrib, unsigned int id, const guint8 *pdu,
+				guint16 len, GAttribResultFunc func,
+				gpointer user_data, GDestroyNotify notify);
 
 bool g_attrib_cancel(GAttrib *attrib, guint id);
 bool g_attrib_cancel_all(GAttrib *attrib);
-- 
1.8.2

