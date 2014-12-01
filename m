Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2] gattrib: Fix not changing the buffer size when mtu is reduced
Date: Mon,  1 Dec 2014 13:54:06 +0100
Message-Id: <1417438446-15350-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using larger buffer than mtu resulted in not sending the message at all
as encode_pdu() in shared/att.c fails when provided data buffer is
larger than current mtu.
---
 attrib/gattrib.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index a04a0ee..cfa3b78 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -324,11 +324,17 @@ uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
 
 gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
 {
-	/* Clients of this expect a buffer to use. */
-	if (mtu > attrib->buflen) {
+	/*
+	 * Clients of this expect a buffer to use.
+	 *
+	 * Pdu encoding in sharred/att verifies if whole buffer fits the mtu,
+	 * thus we should set the buflen also when mtu is reduced. But we
+	 * need to reallocate the buffer only if mtu is larger.
+	 */
+	if (mtu > attrib->buflen)
 		attrib->buf = g_realloc(attrib->buf, mtu);
-		attrib->buflen = mtu;
-	}
+
+	attrib->buflen = mtu;
 
 	return bt_att_set_mtu(attrib->att, mtu);
 }
-- 
1.9.1

