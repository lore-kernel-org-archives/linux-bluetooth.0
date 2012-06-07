Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/8] gattrib: Fix GAttrib buffer allocation
Date: Wed,  6 Jun 2012 21:40:56 -0300
Message-Id: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GAttrib buffer should be allocated according to ATT_MTU value. Over
BR/EDR, ATT_MTU should be set to the L2CAP imtu negotiated during
L2CAP configuration phase. Over LE, ATT_MTU should be 23 octets.
---
 attrib/gattrib.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 29c3585..137e0ab 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -433,15 +433,34 @@ done:
 GAttrib *g_attrib_new(GIOChannel *io)
 {
 	struct _GAttrib *attrib;
-	uint16_t omtu;
+	uint16_t imtu;
+	uint16_t att_mtu;
+	uint16_t cid;
+	GError *gerr = NULL;
 
 	g_io_channel_set_encoding(io, NULL, NULL);
 	g_io_channel_set_buffered(io, FALSE);
 
+	bt_io_get(io, BT_IO_L2CAP, &gerr,
+			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_CID, &cid,
+			BT_IO_OPT_INVALID);
+
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		return NULL;
+	}
+
 	attrib = g_try_new0(struct _GAttrib, 1);
 	if (attrib == NULL)
 		return NULL;
 
+	att_mtu = (cid == ATT_CID) ? ATT_DEFAULT_LE_MTU : imtu;
+
+	attrib->buf = g_malloc0(att_mtu);
+	attrib->buflen = att_mtu;
+
 	attrib->io = g_io_channel_ref(io);
 	attrib->requests = g_queue_new();
 	attrib->responses = g_queue_new();
@@ -450,17 +469,6 @@ GAttrib *g_attrib_new(GIOChannel *io)
 			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 			received_data, attrib);
 
-	if (bt_io_get(attrib->io, BT_IO_L2CAP, NULL,
-			BT_IO_OPT_OMTU, &omtu,
-			BT_IO_OPT_INVALID)) {
-		if (omtu == 0 || omtu > ATT_MAX_MTU)
-			omtu = ATT_MAX_MTU;
-	} else
-		omtu = ATT_DEFAULT_LE_MTU;
-
-	attrib->buf = g_malloc0(omtu);
-	attrib->buflen = omtu;
-
 	return g_attrib_ref(attrib);
 }
 
-- 
1.7.10.3

