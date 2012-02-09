Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] GAttrib: Add debug message for GAttrib references
Date: Thu,  9 Feb 2012 12:41:36 -0300
Message-Id: <1328802098-26789-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools   |    2 +-
 attrib/gattrib.c |   11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index eea1a9b..19a4b04 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -59,7 +59,7 @@ bin_PROGRAMS += attrib/gatttool
 attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 				attrib/gattrib.c btio/btio.c \
 				attrib/gatttool.h attrib/interactive.c \
-				attrib/utils.c
+				attrib/utils.c src/log.c
 attrib_gatttool_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @READLINE_LIBS@
 endif
 
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 4d901f1..ccddabe 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -31,6 +31,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
 
+#include "log.h"
 #include "att.h"
 #include "btio.h"
 #include "gattrib.h"
@@ -147,6 +148,8 @@ GAttrib *g_attrib_ref(GAttrib *attrib)
 
 	g_atomic_int_inc(&attrib->refs);
 
+	DBG("%p: ref=%d", attrib, attrib->refs);
+
 	return attrib;
 }
 
@@ -205,10 +208,16 @@ static void attrib_destroy(GAttrib *attrib)
 
 void g_attrib_unref(GAttrib *attrib)
 {
+	gboolean ret;
+
 	if (!attrib)
 		return;
 
-	if (g_atomic_int_dec_and_test(&attrib->refs) == FALSE)
+	ret = g_atomic_int_dec_and_test(&attrib->refs);
+
+	DBG("%p: ref=%d", attrib, attrib->refs);
+
+	if (ret == FALSE)
 		return;
 
 	attrib_destroy(attrib);
-- 
1.7.8.4

