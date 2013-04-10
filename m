Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ v2 06/16] attrib: Change g_attrib_set_destroy_function return type
Date: Wed, 10 Apr 2013 15:16:51 -0400
Message-Id: <1365621421-1422-7-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1365621421-1422-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
 <1365621421-1422-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return type from g_attrib_set_destroy_function don't need to be
gboolean, it can be standard bool type.
That change implies change in its signature, which requires stdbool.h to
be included where attrib/gattrib.h is included.
---
 attrib/gatt.c        | 1 +
 attrib/gattrib.c     | 8 ++++----
 attrib/gattrib.h     | 4 ++--
 attrib/gatttool.c    | 1 +
 attrib/interactive.c | 1 +
 attrib/utils.c       | 1 +
 6 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 749e820..3fe6aeb 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -28,6 +28,7 @@
 
 #include <stdint.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <glib.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 636e09d..9ca9537 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -245,16 +245,16 @@ GIOChannel *g_attrib_get_channel(GAttrib *attrib)
 	return attrib->io;
 }
 
-gboolean g_attrib_set_destroy_function(GAttrib *attrib,
-		GDestroyNotify destroy, gpointer user_data)
+bool g_attrib_set_destroy_function(GAttrib *attrib, GDestroyNotify destroy,
+							gpointer user_data)
 {
 	if (attrib == NULL)
-		return FALSE;
+		return false;
 
 	attrib->destroy = destroy;
 	attrib->destroy_user_data = user_data;
 
-	return TRUE;
+	return true;
 }
 
 static gboolean disconnect_timeout(gpointer data)
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 3fe92c7..9d6a1c2 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -48,8 +48,8 @@ void g_attrib_unref(GAttrib *attrib);
 
 GIOChannel *g_attrib_get_channel(GAttrib *attrib);
 
-gboolean g_attrib_set_destroy_function(GAttrib *attrib,
-		GDestroyNotify destroy, gpointer user_data);
+bool g_attrib_set_destroy_function(GAttrib *attrib, GDestroyNotify destroy,
+							gpointer user_data);
 
 guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
 			GAttribResultFunc func, gpointer user_data,
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 8cfac27..1f83004 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include <glib.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <unistd.h>
 
 #include <bluetooth/bluetooth.h>
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 9f72453..89ae7b9 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -27,6 +27,7 @@
 
 #include <string.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <errno.h>
 #include <stdio.h>
 #include <glib.h>
diff --git a/attrib/utils.c b/attrib/utils.c
index c8c8651..e4ef650 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -26,6 +26,7 @@
 #endif
 
 #include <stdlib.h>
+#include <stdbool.h>
 #include <glib.h>
 
 #include <bluetooth/bluetooth.h>
-- 
1.8.2

