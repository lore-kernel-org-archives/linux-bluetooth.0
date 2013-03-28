Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 02/16] attrib: Change GAttrib->stale type from gboolean
Date: Thu, 28 Mar 2013 11:39:06 -0400
Message-Id: <1364485160-22720-3-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to GAttrib->stale be gboolean.
---
 attrib/gattrib.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index e8e1c2b..88bfc97 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -27,6 +27,7 @@
 #endif
 
 #include <stdint.h>
+#include <stdbool.h>
 #include <string.h>
 #include <glib.h>
 
@@ -56,7 +57,7 @@ struct _GAttrib {
 	guint next_cmd_id;
 	GDestroyNotify destroy;
 	gpointer destroy_user_data;
-	gboolean stale;
+	bool stale;
 };
 
 struct command {
@@ -277,7 +278,7 @@ static gboolean disconnect_timeout(gpointer data)
 	}
 
 done:
-	attrib->stale = TRUE;
+	attrib->stale = true;
 
 	g_attrib_unref(attrib);
 
-- 
1.8.2

