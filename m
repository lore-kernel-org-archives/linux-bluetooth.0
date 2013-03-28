Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 15/16] attrib: Change event->id type from guint
Date: Thu, 28 Mar 2013 11:39:19 -0400
Message-Id: <1364485160-22720-16-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change type of event->id for a standard type.
---
 attrib/gattrib.c | 6 +++---
 attrib/gattrib.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 438a522..3fdcf6d 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -73,7 +73,7 @@ struct command {
 };
 
 struct event {
-	guint id;
+	unsigned int id;
 	uint8_t expected;
 	uint16_t handle;
 	GAttribNotifyFunc func;
@@ -672,11 +672,11 @@ bool g_attrib_set_mtu(GAttrib *attrib, int mtu)
 	return true;
 }
 
-guint g_attrib_register(GAttrib *attrib, uint8_t opcode, uint16_t handle,
+unsigned int g_attrib_register(GAttrib *attrib, uint8_t opcode, uint16_t handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify)
 {
-	static guint next_evt_id = 0;
+	static unsigned int next_evt_id = 0;
 	struct event *event;
 
 	event = g_try_new0(struct event, 1);
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 06ed450..4404428 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -61,7 +61,7 @@ bool g_attrib_cancel_all(GAttrib *attrib);
 bool g_attrib_set_debug(GAttrib *attrib, GAttribDebugFunc func,
 							gpointer user_data);
 
-guint g_attrib_register(GAttrib *attrib, uint8_t opcode, uint16_t handle,
+unsigned int g_attrib_register(GAttrib *attrib, uint8_t opcode, uint16_t handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify);
 
-- 
1.8.2

