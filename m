Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v1 09/18] gattrib: Use default ATT LE MTU for non-standard sockets
Date: Mon, 20 Jan 2014 15:04:54 -0300
Message-Id: <1390241103-808-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1390241103-808-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1389285503-19348-1-git-send-email-claudio.takahasi@openbossa.org>
 <1390241103-808-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch forces the MTU to 23 (default ATT MTU) if the transport
is not Bluetooth. This is a development purpose change to allow
testing GATT procedures over non-Bluetooth sockets.
---
 attrib/gattrib.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 609b908..fccb2bf 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -468,18 +468,18 @@ GAttrib *g_attrib_new(GIOChannel *io)
 	struct _GAttrib *attrib;
 	uint16_t imtu;
 	uint16_t att_mtu;
-	uint16_t cid;
-	GError *gerr = NULL;
+	uint16_t cid = 0;
 
 	g_io_channel_set_encoding(io, NULL, NULL);
 	g_io_channel_set_buffered(io, FALSE);
 
-	bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &imtu,
-				BT_IO_OPT_CID, &cid, BT_IO_OPT_INVALID);
-	if (gerr) {
-		error("%s", gerr->message);
-		g_error_free(gerr);
-		return NULL;
+	if (bt_io_get(io, NULL, BT_IO_OPT_IMTU, &imtu, BT_IO_OPT_CID, &cid,
+						BT_IO_OPT_INVALID) == FALSE) {
+		/*
+		 * Use default ATT LE MTU for non-standard transports. Used
+		 * for testing purpose only. eg: Unix sockets
+		 */
+		imtu = ATT_DEFAULT_LE_MTU;
 	}
 
 	attrib = g_try_new0(struct _GAttrib, 1);
-- 
1.8.3.1

