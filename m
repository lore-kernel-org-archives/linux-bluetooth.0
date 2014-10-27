Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v3 02/10] attrib: Remove MTU-probing code
Date: Mon, 27 Oct 2014 15:13:53 -0700
Message-Id: <1414448041-27866-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1414448041-27866-1-git-send-email-jamuraa@chromium.org>
References: <1414448041-27866-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Probing for the MTU using bt_io is problematic for
testing because you cannot impersonate AF_BLUETOOTH sockets
with a socketpair.
---
 attrib/gattrib.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 71d1cef..fa41ade 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -476,27 +476,17 @@ done:
 GAttrib *g_attrib_new(GIOChannel *io)
 {
 	struct _GAttrib *attrib;
-	uint16_t imtu;
 	uint16_t att_mtu;
 	uint16_t cid;
-	GError *gerr = NULL;
 
 	g_io_channel_set_encoding(io, NULL, NULL);
 	g_io_channel_set_buffered(io, FALSE);
 
-	bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &imtu,
-				BT_IO_OPT_CID, &cid, BT_IO_OPT_INVALID);
-	if (gerr) {
-		error("%s", gerr->message);
-		g_error_free(gerr);
-		return NULL;
-	}
-
 	attrib = g_try_new0(struct _GAttrib, 1);
 	if (attrib == NULL)
 		return NULL;
 
-	att_mtu = (cid == ATT_CID) ? ATT_DEFAULT_LE_MTU : imtu;
+	att_mtu = ATT_DEFAULT_LE_MTU;
 
 	attrib->buf = g_malloc0(att_mtu);
 	attrib->buflen = att_mtu;
@@ -651,7 +641,6 @@ gboolean g_attrib_cancel_all(GAttrib *attrib)
 	return ret;
 }
 
-
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
 {
 	if (len == NULL)
-- 
2.1.0.rc2.206.gedb03e5

