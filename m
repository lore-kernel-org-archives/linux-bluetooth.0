Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 4/7] attrib: remove g_attrib_is_encrypted
Date: Fri, 24 Oct 2014 13:36:20 -0700
Message-Id: <1414182983-23959-5-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1414182983-23959-1-git-send-email-jamuraa@chromium.org>
References: <1414182983-23959-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is only used in one place and encryption is the
responsibility of the channel, not the attribute.
---
 attrib/gattrib.c    | 12 ------------
 attrib/gattrib.h    |  2 --
 src/attrib-server.c |  9 +++++++--
 3 files changed, 7 insertions(+), 16 deletions(-)

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
index e65fff2..1ccfc65 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -375,12 +375,17 @@ static struct attribute *attrib_db_add_new(struct gatt_server *server,
 static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 								int reqs)
 {
+	BtIOSecLevel sec_level;
+	GIOChannel *io = g_attrib_get_channel(channel->attrib);
+
 	/* FIXME: currently, it is assumed an encrypted link is enough for
 	 * authentication. This will allow to enable the SMP negotiation once
 	 * it is on upstream kernel. High security level should be mapped
 	 * to authentication and medium to encryption permission. */
-	if (!channel->encrypted)
-		channel->encrypted = g_attrib_is_encrypted(channel->attrib);
+	if (!channel->encrypted &&
+			    bt_io_get(io, NULL, BT_IO_OPT_SEC_LEVEL, &sec_level,
+							     BT_IO_OPT_INVALID))
+		channel->encrypted = sec_level > BT_IO_SEC_LOW;
 	if (reqs == ATT_AUTHENTICATION && !channel->encrypted)
 		return ATT_ECODE_AUTHENTICATION;
 	else if (reqs == ATT_AUTHORIZATION)
-- 
2.1.0.rc2.206.gedb03e5

