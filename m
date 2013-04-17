Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ v3 09/16] attrib: Change g_attrib_set_debug return type from gboolean
Date: Wed, 17 Apr 2013 10:03:12 -0400
Message-Id: <1366207399-29536-10-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1366207399-29536-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1365621421-1422-1-git-send-email-jefferson.delfes@openbossa.org>
 <1366207399-29536-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to use gboolean in return type of g_attrib_set_debug.
---
 attrib/gattrib.c | 6 +++---
 attrib/gattrib.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index e7e1e17..51d6bca 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -641,10 +641,10 @@ bool g_attrib_cancel_all(GAttrib *attrib)
 	return ret;
 }
 
-gboolean g_attrib_set_debug(GAttrib *attrib,
-		GAttribDebugFunc func, gpointer user_data)
+bool g_attrib_set_debug(GAttrib *attrib, GAttribDebugFunc func,
+							gpointer user_data)
 {
-	return TRUE;
+	return true;
 }
 
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 6e5d183..d3d6d0d 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -58,8 +58,8 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
 bool g_attrib_cancel(GAttrib *attrib, guint id);
 bool g_attrib_cancel_all(GAttrib *attrib);
 
-gboolean g_attrib_set_debug(GAttrib *attrib,
-		GAttribDebugFunc func, gpointer user_data);
+bool g_attrib_set_debug(GAttrib *attrib, GAttribDebugFunc func,
+							gpointer user_data);
 
 guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 				GAttribNotifyFunc func, gpointer user_data,
-- 
1.8.2

