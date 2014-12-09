Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 01/15] attrib/gattrib: Add g_attrib_get_att.
Date: Mon,  8 Dec 2014 16:40:41 -0800
Message-Id: <1418085655-7304-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1418085655-7304-1-git-send-email-armansito@chromium.org>
References: <1418085655-7304-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added the g_attrib_get_att function which returns the underlying bt_att
structure associated with a GAttrib.
---
 attrib/gattrib.c | 8 ++++++++
 attrib/gattrib.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index cfa3b78..f3b1366 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -169,6 +169,14 @@ GIOChannel *g_attrib_get_channel(GAttrib *attrib)
 	return attrib->io;
 }
 
+struct bt_att *g_attrib_get_att(GAttrib *attrib)
+{
+	if (!attrib)
+		return NULL;
+
+	return attrib->att;
+}
+
 gboolean g_attrib_set_destroy_function(GAttrib *attrib, GDestroyNotify destroy,
 							gpointer user_data)
 {
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 2ed57c1..374bac2 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -31,6 +31,7 @@ extern "C" {
 #define GATTRIB_ALL_REQS 0xFE
 #define GATTRIB_ALL_HANDLES 0x0000
 
+struct bt_att;  /* Forward declaration for compatibility */
 struct _GAttrib;
 typedef struct _GAttrib GAttrib;
 
@@ -47,6 +48,8 @@ void g_attrib_unref(GAttrib *attrib);
 
 GIOChannel *g_attrib_get_channel(GAttrib *attrib);
 
+struct bt_att *g_attrib_get_att(GAttrib *attrib);
+
 gboolean g_attrib_set_destroy_function(GAttrib *attrib,
 		GDestroyNotify destroy, gpointer user_data);
 
-- 
2.2.0.rc0.207.ga3a616c

