Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Check malformed notification/indication PDU
Date: Wed, 23 Feb 2011 08:56:20 -0300
Message-Id: <1298462180-17737-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements discard of obviously malformed
GATT notification/indication PDUs.
---
 attrib/client.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 0f9ba3e..dc7ee8b 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -272,9 +272,16 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
 	struct primary *prim;
 	GSList *lprim, *lchr;
 	uint8_t opdu[ATT_MAX_MTU];
-	guint handle = att_get_u16(&pdu[1]);
+	guint handle;
 	uint16_t olen;
 
+	if (len < 3) {
+		DBG("Malformed notif/indic packet (opcode %x)", pdu[0]);
+		return;
+	}
+
+	handle = att_get_u16(&pdu[1]);
+
 	for (lprim = gatt->primary, prim = NULL, chr = NULL; lprim;
 						lprim = lprim->next) {
 		prim = lprim->data;
-- 
1.7.1

