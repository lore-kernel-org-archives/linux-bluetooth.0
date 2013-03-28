Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 11/16] attrib: Change g_attrib_is_encrypted return type from gboolean
Date: Thu, 28 Mar 2013 11:39:15 -0400
Message-Id: <1364485160-22720-12-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The function g_attrib_is_encrypted don't need to use gboolean as return
type, it can be standard bool type.
This change implies that gatt_channel->encrypted from
src/attrib-server.c can be standard bool type too.
---
 attrib/gattrib.c    | 4 ++--
 attrib/gattrib.h    | 2 +-
 src/attrib-server.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 365a58e..2cb8265 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -703,14 +703,14 @@ static gint event_cmp_by_id(gconstpointer a, gconstpointer b)
 	return evt->id - id;
 }
 
-gboolean g_attrib_is_encrypted(GAttrib *attrib)
+bool g_attrib_is_encrypted(GAttrib *attrib)
 {
 	BtIOSecLevel sec_level;
 
 	if (!bt_io_get(attrib->io, NULL,
 			BT_IO_OPT_SEC_LEVEL, &sec_level,
 			BT_IO_OPT_INVALID))
-		return FALSE;
+		return false;
 
 	return sec_level > BT_IO_SEC_LOW;
 }
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 70c730f..03f4911 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -65,7 +65,7 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify);
 
-gboolean g_attrib_is_encrypted(GAttrib *attrib);
+bool g_attrib_is_encrypted(GAttrib *attrib);
 
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len);
 bool g_attrib_set_mtu(GAttrib *attrib, int mtu);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 99656e3..7976610 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -75,7 +75,7 @@ struct gatt_channel {
 	guint mtu;
 	gboolean le;
 	guint id;
-	gboolean encrypted;
+	bool encrypted;
 	struct gatt_server *server;
 	guint cleanup_id;
 	struct btd_device *device;
-- 
1.8.2

