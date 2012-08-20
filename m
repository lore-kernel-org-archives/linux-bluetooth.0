Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 04/10] gatt: Confirm the indication received
Date: Mon, 20 Aug 2012 14:22:49 -0300
Message-Id: <1345483375-27621-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the ATT command reply for the Service Changed
indication value received.
---
 profiles/gatt/gas.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index dda4886..4bf8090 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -124,7 +124,9 @@ static void write_ccc(GAttrib *attrib, uint16_t handle, gpointer user_data)
 static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 {
 	struct gas *gas = user_data;
-	uint16_t handle, start, end;
+	uint16_t handle, start, end, olen;
+	size_t plen;
+	uint8_t *opdu;
 
 	if (len < 7) { /* 1-byte opcode + 2-byte handle + 4 range */
 		error("Malformed ATT notification");
@@ -139,6 +141,11 @@ static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 		return;
 
 	DBG("Service Changed start: 0x%04X end: 0x%04X", start, end);
+
+	/* Confirming indication received */
+	opdu = g_attrib_get_buffer(gas->attrib, &plen);
+	olen = enc_confirmation(opdu, plen);
+	g_attrib_send(gas->attrib, 0, opdu[0], opdu, olen, NULL, NULL, NULL);
 }
 
 static void gatt_service_changed_cb(guint8 status, const guint8 *pdu,
-- 
1.7.8.6

