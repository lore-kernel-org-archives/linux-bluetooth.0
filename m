Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH] Check the security level on a per request base
Date: Thu,  9 Dec 2010 09:09:13 -0400
Message-Id: <1291900153-8541-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check security level on attribute server on each request, and update the
"encrypted" flag.
---
 attrib/gattrib.c    |   13 +++++++++++++
 attrib/gattrib.h    |    2 ++
 src/attrib-server.c |    7 ++-----
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 1083519..4ed29d9 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -32,6 +32,7 @@
 #include <bluetooth/sdp.h>
 
 #include "att.h"
+#include "btio.h"
 #include "gattrib.h"
 
 struct _GAttrib {
@@ -489,6 +490,18 @@ static gint event_cmp_by_id(gconstpointer a, gconstpointer b)
 	return evt->id - id;
 }
 
+gboolean g_attrib_is_encrypted(GAttrib *attrib)
+{
+	BtIOSecLevel sec_level;
+
+	if (!bt_io_get(attrib->io, BT_IO_L2CAP, NULL,
+			BT_IO_OPT_SEC_LEVEL, &sec_level,
+			BT_IO_OPT_INVALID))
+		return FALSE;
+
+	return sec_level > BT_IO_SEC_LOW;
+}
+
 gboolean g_attrib_unregister(GAttrib *attrib, guint id)
 {
 	struct event *evt;
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 4306ca4..0940289 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -63,6 +63,8 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode,
 		GAttribNotifyFunc func, gpointer user_data,
 					GDestroyNotify notify);
 
+gboolean g_attrib_is_encrypted(GAttrib *attrib);
+
 gboolean g_attrib_unregister(GAttrib *attrib, guint id);
 gboolean g_attrib_unregister_all(GAttrib *attrib);
 
diff --git a/src/attrib-server.c b/src/attrib-server.c
index f2df853..18759e7 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -145,6 +145,8 @@ static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 	/* FIXME: currently, it is assumed an encrypted link is enough for
 	 * authentication. This will allow to enable the SMP negotiation once
 	 * it is on upstream kernel. */
+	if (!channel->encrypted)
+		channel->encrypted = g_attrib_is_encrypted(channel->attrib);
 	if (reqs == ATT_AUTHENTICATION && !channel->encrypted)
 		return ATT_ECODE_INSUFF_ENC;
 
@@ -700,7 +702,6 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 {
 	struct gatt_channel *channel;
 	GError *gerr = NULL;
-	int sec_level;
 
 	if (err) {
 		error("%s", err->message);
@@ -712,7 +713,6 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 	bt_io_get(io, BT_IO_L2CAP, &gerr,
 			BT_IO_OPT_SOURCE_BDADDR, &channel->src,
 			BT_IO_OPT_DEST_BDADDR, &channel->dst,
-			BT_IO_OPT_SEC_LEVEL, &sec_level,
 			BT_IO_OPT_INVALID);
 	if (gerr) {
 		error("bt_io_get: %s", gerr->message);
@@ -725,9 +725,6 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 	channel->attrib = g_attrib_new(io);
 	channel->mtu = ATT_DEFAULT_MTU;
 
-	/* FIXME: the security level needs to checked on every request. */
-	channel->encrypted = sec_level > BT_IO_SEC_LOW;
-
 	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_EVENTS,
 				channel_handler, channel, NULL);
 
-- 
1.7.0.4

