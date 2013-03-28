Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 07/16] attrib: Change g_attrib_cancel/_all return type
Date: Thu, 28 Mar 2013 11:39:11 -0400
Message-Id: <1364485160-22720-8-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These functions doesn't need to use gboolean as return type.
---
 attrib/gattrib.c | 26 +++++++++++++-------------
 attrib/gattrib.h |  4 ++--
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index e9a4557..287f114 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -567,14 +567,14 @@ static gint command_cmp_by_id(gconstpointer a, gconstpointer b)
 	return cmd->id - id;
 }
 
-gboolean g_attrib_cancel(GAttrib *attrib, guint id)
+bool g_attrib_cancel(GAttrib *attrib, guint id)
 {
 	GList *l = NULL;
 	struct command *cmd;
 	GQueue *queue;
 
 	if (attrib == NULL)
-		return FALSE;
+		return false;
 
 	queue = attrib->requests;
 	if (queue)
@@ -583,13 +583,13 @@ gboolean g_attrib_cancel(GAttrib *attrib, guint id)
 	if (l == NULL) {
 		queue = attrib->responses;
 		if (!queue)
-			return FALSE;
+			return false;
 		l = g_queue_find_custom(queue, GUINT_TO_POINTER(id),
 					command_cmp_by_id);
 	}
 
 	if (l == NULL)
-		return FALSE;
+		return false;
 
 	cmd = l->data;
 
@@ -600,16 +600,16 @@ gboolean g_attrib_cancel(GAttrib *attrib, guint id)
 		command_destroy(cmd);
 	}
 
-	return TRUE;
+	return true;
 }
 
-static gboolean cancel_all_per_queue(GQueue *queue)
+static bool cancel_all_per_queue(GQueue *queue)
 {
 	struct command *c, *head = NULL;
-	gboolean first = TRUE;
+	bool first = true;
 
 	if (queue == NULL)
-		return FALSE;
+		return false;
 
 	while ((c = g_queue_pop_head(queue))) {
 		if (first && c->sent) {
@@ -619,7 +619,7 @@ static gboolean cancel_all_per_queue(GQueue *queue)
 			continue;
 		}
 
-		first = FALSE;
+		first = false;
 		command_destroy(c);
 	}
 
@@ -628,15 +628,15 @@ static gboolean cancel_all_per_queue(GQueue *queue)
 		g_queue_push_head(queue, head);
 	}
 
-	return TRUE;
+	return true;
 }
 
-gboolean g_attrib_cancel_all(GAttrib *attrib)
+bool g_attrib_cancel_all(GAttrib *attrib)
 {
-	gboolean ret;
+	bool ret;
 
 	if (attrib == NULL)
-		return FALSE;
+		return false;
 
 	ret = cancel_all_per_queue(attrib->requests);
 	ret = cancel_all_per_queue(attrib->responses) && ret;
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 9d6a1c2..fe1ebd8 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -55,8 +55,8 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
 			GAttribResultFunc func, gpointer user_data,
 			GDestroyNotify notify);
 
-gboolean g_attrib_cancel(GAttrib *attrib, guint id);
-gboolean g_attrib_cancel_all(GAttrib *attrib);
+bool g_attrib_cancel(GAttrib *attrib, guint id);
+bool g_attrib_cancel_all(GAttrib *attrib);
 
 gboolean g_attrib_set_debug(GAttrib *attrib,
 		GAttribDebugFunc func, gpointer user_data);
-- 
1.8.2

