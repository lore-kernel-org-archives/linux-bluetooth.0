Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ v1 10/18] gatt: Register ATT command/event handler
Date: Mon, 20 Jan 2014 15:04:55 -0300
Message-Id: <1390241103-808-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1390241103-808-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1389285503-19348-1-git-send-email-claudio.takahasi@openbossa.org>
 <1390241103-808-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

This patch registers the ATT channel handler to manage incoming ATT
commands and events.
---
 src/gatt.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/src/gatt.c b/src/gatt.c
index 4806205..33c3b6a 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -38,6 +38,7 @@
 #include "log.h"
 #include "lib/uuid.h"
 #include "attrib/att.h"
+#include "attrib/gattrib.h"
 
 #include "gatt-dbus.h"
 #include "gatt.h"
@@ -100,12 +101,83 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 	return attr;
 }
 
+static void send_error(GAttrib *attrib, uint8_t opcode, uint16_t handle,
+								uint8_t ecode)
+{
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	size_t plen;
+
+	plen = enc_error_resp(opcode, handle, ecode, pdu, sizeof(pdu));
+
+	g_attrib_send(attrib, 0, pdu, plen, NULL, NULL, NULL);
+}
+
+static void channel_handler_cb(const uint8_t *ipdu, uint16_t ilen,
+							gpointer user_data)
+{
+	GAttrib *attrib = user_data;
+
+	switch (ipdu[0]) {
+	case ATT_OP_ERROR:
+		break;
+
+	/* Requests */
+	case ATT_OP_WRITE_CMD:
+	case ATT_OP_WRITE_REQ:
+	case ATT_OP_READ_REQ:
+	case ATT_OP_READ_BY_TYPE_REQ:
+	case ATT_OP_MTU_REQ:
+	case ATT_OP_FIND_INFO_REQ:
+	case ATT_OP_FIND_BY_TYPE_REQ:
+	case ATT_OP_READ_BLOB_REQ:
+	case ATT_OP_READ_MULTI_REQ:
+	case ATT_OP_PREP_WRITE_REQ:
+	case ATT_OP_EXEC_WRITE_REQ:
+	case ATT_OP_READ_BY_GROUP_REQ:
+	case ATT_OP_SIGNED_WRITE_CMD:
+		send_error(attrib, ipdu[0], 0x0000, ATT_ECODE_REQ_NOT_SUPP);
+		break;
+
+	/* Responses */
+	case ATT_OP_MTU_RESP:
+	case ATT_OP_FIND_INFO_RESP:
+	case ATT_OP_FIND_BY_TYPE_RESP:
+	case ATT_OP_READ_BY_TYPE_RESP:
+	case ATT_OP_READ_RESP:
+	case ATT_OP_READ_BLOB_RESP:
+	case ATT_OP_READ_MULTI_RESP:
+	case ATT_OP_READ_BY_GROUP_RESP:
+	case ATT_OP_WRITE_RESP:
+	case ATT_OP_PREP_WRITE_RESP:
+	case ATT_OP_EXEC_WRITE_RESP:
+	case ATT_OP_HANDLE_CNF:
+		break;
+
+	/* Notification & Indication */
+	case ATT_OP_HANDLE_NOTIFY:
+	case ATT_OP_HANDLE_IND:
+		break;
+	}
+}
+
+static gboolean unix_hup_cb(GIOChannel *io, GIOCondition cond,
+						gpointer user_data)
+{
+	GAttrib *attrib = user_data;
+
+	g_attrib_unregister_all(attrib);
+	g_attrib_unref(attrib);
+
+	return FALSE;
+}
+
 static gboolean unix_accept_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct sockaddr_un uaddr;
 	socklen_t len = sizeof(uaddr);
 	GIOChannel *nio;
+	GAttrib *attrib;
 	int err, nsk, sk;
 
 	sk = g_io_channel_unix_get_fd(io);
@@ -120,6 +192,14 @@ static gboolean unix_accept_cb(GIOChannel *io, GIOCondition cond,
 	nio = g_io_channel_unix_new(nsk);
 	g_io_channel_set_close_on_unref(nio, TRUE);
 	DBG("ATT UNIX socket: %p new client", nio);
+
+	attrib = g_attrib_new(nio);
+
+	g_attrib_register(attrib, GATTRIB_ALL_EVENTS, GATTRIB_ALL_HANDLES,
+					channel_handler_cb, attrib, NULL);
+
+	g_io_add_watch(nio, G_IO_HUP, unix_hup_cb, attrib);
+
 	g_io_channel_unref(nio);
 
 	return TRUE;
-- 
1.8.3.1

