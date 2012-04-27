Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH RFC BlueZ 1/1] attrib: Retry ATT request when link is unencrypted
Date: Fri, 27 Apr 2012 12:05:25 -0400
Message-Id: <1335542725-8806-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1335542725-8806-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1335542725-8806-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

If the client side receives an Error Response with "Insufficient
Authentication" or "Insufficient Encryption", it will increase the link
security level and send the same request again.
---
 attrib/gattrib.c |   32 ++++++++++++++++++++++++++++++++
 src/device.c     |    2 +-
 2 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 769be36..e551aef 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -61,6 +61,7 @@ struct command {
 	guint16 len;
 	guint8 expected;
 	gboolean sent;
+	gboolean retry;
 	GAttribResultFunc func;
 	gpointer user_data;
 	GDestroyNotify notify;
@@ -307,6 +308,22 @@ static void wake_up_sender(struct _GAttrib *attrib)
 				can_write_data, attrib, destroy_sender);
 }
 
+static void increase_sec_level(struct _GAttrib *attrib)
+{
+	BtIOSecLevel sec_level;
+
+	bt_io_get(attrib->io, BT_IO_L2CAP, NULL,
+			BT_IO_OPT_SEC_LEVEL, &sec_level,
+			BT_IO_OPT_INVALID);
+
+	if (sec_level < BT_IO_SEC_HIGH) {
+		sec_level++;
+		bt_io_set(attrib->io, BT_IO_L2CAP, NULL,
+					BT_IO_OPT_SEC_LEVEL, sec_level,
+					BT_IO_OPT_INVALID);
+	}
+}
+
 static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 {
 	struct _GAttrib *attrib = data;
@@ -368,6 +385,20 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	status = 0;
 
 done:
+	if ((status == ATT_ECODE_INSUFF_ENC ||
+				status == ATT_ECODE_AUTHENTICATION) &&
+				cmd && cmd->retry) {
+		/* Increase security level */
+		increase_sec_level(attrib);
+
+		/* Retry request once */
+		cmd->sent = FALSE;
+		cmd->retry = FALSE;
+		g_queue_push_head(attrib->queue, cmd);
+		wake_up_sender(attrib);
+		return TRUE;
+	}
+
 	qempty = attrib->queue == NULL || g_queue_is_empty(attrib->queue);
 
 	if (cmd) {
@@ -434,6 +465,7 @@ guint g_attrib_send(GAttrib *attrib, guint id, guint8 opcode,
 	c->func = func;
 	c->user_data = user_data;
 	c->notify = notify;
+	c->retry = TRUE;
 
 	if (id) {
 		c->id = id;
diff --git a/src/device.c b/src/device.c
index 021b200..37b05f4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2003,7 +2003,7 @@ static gboolean att_connect(gpointer user_data)
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
 				BT_IO_OPT_CID, ATT_CID,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
 	}
 
-- 
1.7.5.4

