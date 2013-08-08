Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] gobex: Make PUT request with just filler byte to set the final bit
Date: Thu,  8 Aug 2013 16:49:08 +0300
Message-Id: <1375969749-2097-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1375969749-2097-1-git-send-email-luiz.dentz@gmail.com>
References: <1375969749-2097-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make PUT request with just filler byte 0x30 to be treated as there
is no data and thus avoid an extra packet to be sent.

Some profiles such as MAP use this to workaround PUT being interpreted as
a delete request:

"5.7.5 Body/EndOfBody
To avoid PUT with empty Body leading to a 'delete' of the related
message these headers shall contain a filler byte. The value of this
byte shall be set to 0x30 (="0")."

Future PIM related specs in development also seems to be following the
use of filler byte.
---
 gobex/gobex-packet.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/gobex/gobex-packet.c b/gobex/gobex-packet.c
index 4c14cf7..96f8c76 100644
--- a/gobex/gobex-packet.c
+++ b/gobex/gobex-packet.c
@@ -387,9 +387,15 @@ static gssize get_body(GObexPacket *pkt, guint8 *buf, gsize len)
 	if (ret < 0)
 		return ret;
 
-	if (ret > 0)
-		buf[0] = G_OBEX_HDR_BODY;
-	else
+	if (ret > 0) {
+		/* To avoid PUT with empty Body leading to a 'delete' some
+		 * transfer may use a filler byte of 0x30 (="0").
+		 */
+		if (ret == 2 && strcmp((char *) buf + 3, "0") == 0)
+			buf[0] = G_OBEX_HDR_BODY_END;
+		else
+			buf[0] = G_OBEX_HDR_BODY;
+	} else
 		buf[0] = G_OBEX_HDR_BODY_END;
 
 	u16 = g_htons(ret + 3);
@@ -440,7 +446,7 @@ gssize g_obex_packet_encode(GObexPacket *pkt, guint8 *buf, gsize len)
 		ret = get_body(pkt, buf + count, len - count);
 		if (ret < 0)
 			return ret;
-		if (ret == 0) {
+		if (ret == 0 || buf[count] == G_OBEX_HDR_BODY_END) {
 			if (pkt->opcode == G_OBEX_RSP_CONTINUE)
 				buf[0] = G_OBEX_RSP_SUCCESS;
 			buf[0] |= FINAL_BIT;
-- 
1.8.3.1

