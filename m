Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 02/11] attrib: Add missing g_error_free()
Date: Sat, 11 Jan 2014 00:47:18 -0400
Message-Id: <1389415647-25831-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also print error message.
---
 src/attrib-server.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index a7ee55d..fcc6601 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -944,10 +944,12 @@ static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 	io = g_attrib_get_channel(channel->attrib);
 
 	bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &imtu, BT_IO_OPT_INVALID);
-
-	if (gerr)
-		return enc_error_resp(ATT_OP_MTU_REQ, 0,
-					ATT_ECODE_UNLIKELY, pdu, len);
+	if (gerr) {
+		error("bt_io_get: %s", gerr->message);
+		g_error_free(gerr);
+		return enc_error_resp(ATT_OP_MTU_REQ, 0, ATT_ECODE_UNLIKELY,
+								pdu, len);
+	}
 
 	channel->mtu = MIN(mtu, imtu);
 	g_attrib_set_mtu(channel->attrib, channel->mtu);
-- 
1.8.3.2

