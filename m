Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 09/10] generic attribute: Use GAttrib buffer
Date: Wed, 20 Jun 2012 14:27:51 -0300
Message-Id: <1340213272-2853-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces the static local buffer by the GAttrib internal
buffer to temporarily store the output ATT PDU.
---
 attrib/client.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 8d119df..a90f22b 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -269,9 +269,10 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
 	struct gatt_service *gatt = user_data;
 	struct characteristic *chr;
 	GSList *l;
-	uint8_t opdu[ATT_MAX_MTU];
+	uint8_t *opdu;
 	guint handle;
 	uint16_t olen;
+	int plen;
 
 	if (len < 3) {
 		DBG("Malformed notification/indication packet (opcode 0x%02x)",
@@ -295,7 +296,8 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
 
 	switch (pdu[0]) {
 	case ATT_OP_HANDLE_IND:
-		olen = enc_confirmation(opdu, sizeof(opdu));
+		opdu = g_attrib_get_buffer(gatt->attrib, &plen);
+		olen = enc_confirmation(opdu, plen);
 		g_attrib_send(gatt->attrib, 0, opdu[0], opdu, olen,
 						NULL, NULL, NULL);
 	case ATT_OP_HANDLE_NOTIFY:
-- 
1.7.8.6

