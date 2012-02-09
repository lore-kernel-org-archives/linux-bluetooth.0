Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 7/7] GAttrib: Remove unused function
Date: Thu,  9 Feb 2012 12:56:09 -0300
Message-Id: <1328802969-20244-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GAttrib disconnection tracking is being moved to device.c
---
 attrib/gattrib.c |   22 +---------------------
 attrib/gattrib.h |    3 ---
 2 files changed, 1 insertions(+), 24 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 12a9fcf..8a1e97b 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -51,9 +51,7 @@ struct _GAttrib {
 	guint next_cmd_id;
 	guint next_evt_id;
 	GDestroyNotify destroy;
-	GAttribDisconnectFunc disconnect;
 	gpointer destroy_user_data;
-	gpointer disc_user_data;
 };
 
 struct command {
@@ -232,18 +230,6 @@ GIOChannel *g_attrib_get_channel(GAttrib *attrib)
 	return attrib->io;
 }
 
-gboolean g_attrib_set_disconnect_function(GAttrib *attrib,
-		GAttribDisconnectFunc disconnect, gpointer user_data)
-{
-	if (attrib == NULL)
-		return FALSE;
-
-	attrib->disconnect = disconnect;
-	attrib->disc_user_data = user_data;
-
-	return TRUE;
-}
-
 gboolean g_attrib_set_destroy_function(GAttrib *attrib,
 		GDestroyNotify destroy, gpointer user_data)
 {
@@ -274,12 +260,8 @@ static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
 	gsize len;
 	GIOStatus iostat;
 
-	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
-		if (attrib->disconnect)
-			attrib->disconnect(attrib->disc_user_data);
-
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
 		return FALSE;
-	}
 
 	cmd = g_queue_peek_head(attrib->queue);
 	if (cmd == NULL)
@@ -338,8 +320,6 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
 		attrib->read_watch = 0;
-		if (attrib->disconnect)
-			attrib->disconnect(attrib->disc_user_data);
 		return FALSE;
 	}
 
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 47c0d60..f73b741 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -47,9 +47,6 @@ void g_attrib_unref(GAttrib *attrib);
 
 GIOChannel *g_attrib_get_channel(GAttrib *attrib);
 
-gboolean g_attrib_set_disconnect_function(GAttrib *attrib,
-		GAttribDisconnectFunc disconnect, gpointer user_data);
-
 gboolean g_attrib_set_destroy_function(GAttrib *attrib,
 		GDestroyNotify destroy, gpointer user_data);
 
-- 
1.7.8.4

