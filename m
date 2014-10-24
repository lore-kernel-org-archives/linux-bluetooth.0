Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 1/7] Remove unused g_attrib_set_debug function
Date: Fri, 24 Oct 2014 13:36:17 -0700
Message-Id: <1414182983-23959-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1414182983-23959-1-git-send-email-jamuraa@chromium.org>
References: <1414182983-23959-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is not used, and also not implemented.
---
 attrib/gattrib.c | 5 -----
 attrib/gattrib.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 912dffb..71d1cef 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -651,11 +651,6 @@ gboolean g_attrib_cancel_all(GAttrib *attrib)
 	return ret;
 }
 
-gboolean g_attrib_set_debug(GAttrib *attrib,
-		GAttribDebugFunc func, gpointer user_data)
-{
-	return TRUE;
-}
 
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
 {
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 3fe92c7..18df2ad 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -58,9 +58,6 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
 gboolean g_attrib_cancel(GAttrib *attrib, guint id);
 gboolean g_attrib_cancel_all(GAttrib *attrib);
 
-gboolean g_attrib_set_debug(GAttrib *attrib,
-		GAttribDebugFunc func, gpointer user_data);
-
 guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify);
-- 
2.1.0.rc2.206.gedb03e5

