Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/2] Change security level on demand when reading characteristic value
Date: Thu, 30 Dec 2010 18:22:09 -0300
Message-Id: <1293744130-21124-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a characteristic requires a higher security level, change it on
demand and re-send the GATT Charateristic Value Read. Request will not
be sent until the SMP negotiation finishes. This change doesn't affect
GATT over BR/EDR, since encryption is mandatory for BR/EDR.
---
 attrib/client.c  |   11 +++++++++++
 attrib/gattrib.c |    8 ++++++++
 attrib/gattrib.h |    2 ++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 10bbf7d..3297a0c 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -744,6 +744,17 @@ static void update_char_value(guint8 status, const guint8 *pdu,
 
 	if (status == 0)
 		characteristic_set_value(chr, pdu + 1, len - 1);
+	else if (status == ATT_ECODE_INSUFF_ENC) {
+		GIOChannel *io = g_attrib_get_channel(gatt->attrib);
+
+		if (bt_io_set(io, BT_IO_L2CAP, NULL,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
+				BT_IO_OPT_INVALID)) {
+			gatt_read_char(gatt->attrib, chr->handle,
+					update_char_value, current);
+			return;
+		}
+	}
 
 	g_attrib_unref(gatt->attrib);
 	g_free(current);
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 9268001..dd7b1d7 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -202,6 +202,14 @@ void g_attrib_unref(GAttrib *attrib)
 	g_free(attrib);
 }
 
+GIOChannel *g_attrib_get_channel(GAttrib *attrib)
+{
+	if (!attrib)
+		return NULL;
+
+	return attrib->io;
+}
+
 gboolean g_attrib_set_disconnect_function(GAttrib *attrib,
 		GAttribDisconnectFunc disconnect, gpointer user_data)
 {
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 0940289..5c50bc9 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -44,6 +44,8 @@ GAttrib *g_attrib_new(GIOChannel *io);
 GAttrib *g_attrib_ref(GAttrib *attrib);
 void g_attrib_unref(GAttrib *attrib);
 
+GIOChannel *g_attrib_get_channel(GAttrib *attrib);
+
 gboolean g_attrib_set_disconnect_function(GAttrib *attrib,
 		GAttribDisconnectFunc disconnect, gpointer user_data);
 
-- 
1.7.3.4

