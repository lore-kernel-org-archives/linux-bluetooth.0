Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ v2 08/16] attrib: Change g_attrib_unregister/_all return type
Date: Wed, 10 Apr 2013 15:16:53 -0400
Message-Id: <1365621421-1422-9-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1365621421-1422-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
 <1365621421-1422-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to use gboolean in return type for these functions.
---
 attrib/gattrib.c | 14 +++++++-------
 attrib/gattrib.h |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index a21661f..e7e1e17 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -712,20 +712,20 @@ gboolean g_attrib_is_encrypted(GAttrib *attrib)
 	return sec_level > BT_IO_SEC_LOW;
 }
 
-gboolean g_attrib_unregister(GAttrib *attrib, guint id)
+bool g_attrib_unregister(GAttrib *attrib, guint id)
 {
 	struct event *evt;
 	GSList *l;
 
 	if (id == 0) {
 		warn("%s: invalid id", __FUNCTION__);
-		return FALSE;
+		return false;
 	}
 
 	l = g_slist_find_custom(attrib->events, GUINT_TO_POINTER(id),
 							event_cmp_by_id);
 	if (l == NULL)
-		return FALSE;
+		return false;
 
 	evt = l->data;
 
@@ -736,15 +736,15 @@ gboolean g_attrib_unregister(GAttrib *attrib, guint id)
 
 	g_free(evt);
 
-	return TRUE;
+	return true;
 }
 
-gboolean g_attrib_unregister_all(GAttrib *attrib)
+bool g_attrib_unregister_all(GAttrib *attrib)
 {
 	GSList *l;
 
 	if (attrib->events == NULL)
-		return FALSE;
+		return false;
 
 	for (l = attrib->events; l; l = l->next) {
 		struct event *evt = l->data;
@@ -758,5 +758,5 @@ gboolean g_attrib_unregister_all(GAttrib *attrib)
 	g_slist_free(attrib->events);
 	attrib->events = NULL;
 
-	return TRUE;
+	return true;
 }
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index fe1ebd8..6e5d183 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -70,8 +70,8 @@ gboolean g_attrib_is_encrypted(GAttrib *attrib);
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len);
 gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu);
 
-gboolean g_attrib_unregister(GAttrib *attrib, guint id);
-gboolean g_attrib_unregister_all(GAttrib *attrib);
+bool g_attrib_unregister(GAttrib *attrib, guint id);
+bool g_attrib_unregister_all(GAttrib *attrib);
 
 #ifdef __cplusplus
 }
-- 
1.8.2

