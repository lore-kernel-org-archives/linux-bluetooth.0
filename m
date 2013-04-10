Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ v2 13/16] attrib: Change event->handle type from guint16
Date: Wed, 10 Apr 2013 15:16:58 -0400
Message-Id: <1365621421-1422-14-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1365621421-1422-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
 <1365621421-1422-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change type of event->handle for a standard type.
---
 attrib/gattrib.c | 6 +++---
 attrib/gattrib.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 57acb09..0dd4a87 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -75,7 +75,7 @@ struct command {
 struct event {
 	guint id;
 	uint8_t expected;
-	guint16 handle;
+	uint16_t handle;
 	GAttribNotifyFunc func;
 	gpointer user_data;
 	GDestroyNotify notify;
@@ -367,7 +367,7 @@ static void wake_up_sender(struct _GAttrib *attrib)
 
 static bool match_event(struct event *evt, const uint8_t *pdu, gsize len)
 {
-	guint16 handle;
+	uint16_t handle;
 
 	if (evt->expected == GATTRIB_ALL_EVENTS)
 		return true;
@@ -669,7 +669,7 @@ bool g_attrib_set_mtu(GAttrib *attrib, int mtu)
 	return true;
 }
 
-guint g_attrib_register(GAttrib *attrib, uint8_t opcode, guint16 handle,
+guint g_attrib_register(GAttrib *attrib, uint8_t opcode, uint16_t handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify)
 {
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 2cf5b4d..9d98bfe 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -61,7 +61,7 @@ bool g_attrib_cancel_all(GAttrib *attrib);
 bool g_attrib_set_debug(GAttrib *attrib, GAttribDebugFunc func,
 							gpointer user_data);
 
-guint g_attrib_register(GAttrib *attrib, uint8_t opcode, guint16 handle,
+guint g_attrib_register(GAttrib *attrib, uint8_t opcode, uint16_t handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify);
 
-- 
1.8.2

