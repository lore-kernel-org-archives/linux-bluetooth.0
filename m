Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 2/5] Add internal buffer to GAttrib struct
Date: Wed, 16 Mar 2011 07:25:09 -0400
Message-Id: <1300274712-3931-2-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1300274712-3931-1-git-send-email-bruna.moreira@openbossa.org>
References: <1300274712-3931-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new buffer is allocated in g_attrib_new() and it will be used to
send/receive PDUs. The buffer size is the MTU read from L2CAP channel
limited to ATT_MAX_MTU. Functions to handle the buffer size were also
created.
---
 attrib/gattrib.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 attrib/gattrib.h |    3 +++
 2 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 07e56de..ba168e7 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -40,6 +40,8 @@
 struct _GAttrib {
 	GIOChannel *io;
 	gint refs;
+	uint8_t *buf;
+	int buflen;
 	guint read_watch;
 	guint write_watch;
 	guint timeout_watch;
@@ -193,6 +195,8 @@ static void attrib_destroy(GAttrib *attrib)
 		g_io_channel_unref(attrib->io);
 	}
 
+	g_free(attrib->buf);
+
 	if (attrib->destroy)
 		attrib->destroy(attrib->destroy_user_data);
 
@@ -386,6 +390,7 @@ done:
 GAttrib *g_attrib_new(GIOChannel *io)
 {
 	struct _GAttrib *attrib;
+	uint16_t omtu;
 
 	g_io_channel_set_encoding(io, NULL, NULL);
 	g_io_channel_set_buffered(io, FALSE);
@@ -401,6 +406,17 @@ GAttrib *g_attrib_new(GIOChannel *io)
 			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 			received_data, attrib);
 
+	if (bt_io_get(attrib->io, BT_IO_L2CAP, NULL,
+			BT_IO_OPT_OMTU, &omtu,
+			BT_IO_OPT_INVALID)) {
+		if (omtu > ATT_MAX_MTU)
+			omtu = ATT_MAX_MTU;
+	} else
+		omtu = ATT_DEFAULT_LE_MTU;
+
+	attrib->buf = g_malloc0(omtu);
+	attrib->buflen = omtu;
+
 	return g_attrib_ref(attrib);
 }
 
@@ -504,6 +520,36 @@ gboolean g_attrib_set_debug(GAttrib *attrib,
 	return TRUE;
 }
 
+uint8_t *g_attrib_get_buffer(GAttrib *attrib, int *len)
+{
+	if (len == NULL)
+		return NULL;
+
+	*len = attrib->buflen;
+
+	return attrib->buf;
+}
+
+gboolean g_attrib_set_buffer(GAttrib *attrib, int mtu)
+{
+	if (mtu < ATT_DEFAULT_LE_MTU)
+		mtu = ATT_DEFAULT_LE_MTU;
+
+	if (mtu > ATT_MAX_MTU)
+		mtu = ATT_MAX_MTU;
+
+	if (!bt_io_set(attrib->io, BT_IO_L2CAP, NULL,
+			BT_IO_OPT_OMTU, mtu,
+			BT_IO_OPT_INVALID))
+		return FALSE;
+
+	attrib->buf = g_realloc(attrib->buf, mtu);
+
+	attrib->buflen = mtu;
+
+	return TRUE;
+}
+
 guint g_attrib_register(GAttrib *attrib, guint8 opcode,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify)
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index f25208d..0211068 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -68,6 +68,9 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode,
 
 gboolean g_attrib_is_encrypted(GAttrib *attrib);
 
+uint8_t *g_attrib_get_buffer(GAttrib *attrib, int *len);
+gboolean g_attrib_set_buffer(GAttrib *attrib, int mtu);
+
 gboolean g_attrib_unregister(GAttrib *attrib, guint id);
 gboolean g_attrib_unregister_all(GAttrib *attrib);
 
-- 
1.7.0.4

