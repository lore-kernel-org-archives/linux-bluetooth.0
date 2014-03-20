Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] gobex: Fix not resetting SRM setup
Date: Thu, 20 Mar 2014 19:20:26 +0200
Message-Id: <1395336027-30438-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If SRM is not confirmed by both ends the setup should be disregarded and
the data associated to it can be freed otherwise the next command may
reuse the same setup assuming it is still valid and probably cause SRM
to be enabled without remote consent.
---
 gobex/gobex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 0d9b449..d7d325b 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -400,7 +400,8 @@ static void setup_srm(GObex *obex, GObexPacket *pkt, gboolean outgoing)
 		g_obex_header_get_uint8(hdr, &srm);
 		g_obex_debug(G_OBEX_DEBUG_COMMAND, "srm 0x%02x", srm);
 		set_srm(obex, op, srm);
-	}
+	} else if (!g_obex_srm_enabled(obex))
+		set_srm(obex, op, G_OBEX_SRM_DISABLE);
 
 	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_SRMP);
 	if (hdr != NULL) {
-- 
1.8.5.3

