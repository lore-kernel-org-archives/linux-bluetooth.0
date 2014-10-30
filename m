Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v4 04/10] attrib: remove g_attrib_is_encrypted
Date: Wed, 29 Oct 2014 19:45:39 -0700
Message-Id: <1414637145-32919-5-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1414637145-32919-1-git-send-email-jamuraa@chromium.org>
References: <1414637145-32919-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is only used in one place and encryption is the
responsibility of the channel, not the attribute.
---
 attrib/gattrib.c    | 12 ------------
 attrib/gattrib.h    |  2 --
 src/attrib-server.c | 12 ++++++++++++
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index a6511a2..a65d1ca 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -690,18 +690,6 @@ static int event_cmp_by_id(gconstpointer a, gconstpointer b)
 	return evt->id - id;
 }
 
-gboolean g_attrib_is_encrypted(GAttrib *attrib)
-{
-	BtIOSecLevel sec_level;
-
-	if (!bt_io_get(attrib->io, NULL,
-			BT_IO_OPT_SEC_LEVEL, &sec_level,
-			BT_IO_OPT_INVALID))
-		return FALSE;
-
-	return sec_level > BT_IO_SEC_LOW;
-}
-
 gboolean g_attrib_unregister(GAttrib *attrib, guint id)
 {
 	struct event *evt;
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 99b8b37..1557b99 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -62,8 +62,6 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify);
 
-gboolean g_attrib_is_encrypted(GAttrib *attrib);
-
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len);
 gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu);
 
diff --git a/src/attrib-server.c b/src/attrib-server.c
index e65fff2..6571577 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -372,6 +372,18 @@ static struct attribute *attrib_db_add_new(struct gatt_server *server,
 	return a;
 }
 
+static bool g_attrib_is_encrypted(GAttrib *attrib)
+{
+	BtIOSecLevel sec_level;
+	GIOChannel *io = g_attrib_get_channel(attrib);
+
+	if (!bt_io_get(io, NULL, BT_IO_OPT_SEC_LEVEL, &sec_level,
+							     BT_IO_OPT_INVALID))
+		return FALSE;
+
+	return sec_level > BT_IO_SEC_LOW;
+}
+
 static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 								int reqs)
 {
-- 
2.1.0.rc2.206.gedb03e5

