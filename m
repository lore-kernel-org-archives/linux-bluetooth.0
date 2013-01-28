Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 4/4] gas: Fix not sending response to indication
Date: Mon, 28 Jan 2013 20:48:11 -0300
Message-Id: <1359416891-12740-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1359416891-12740-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1359416891-12740-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Even if the remote device is not bonded, we should send the response to the
indication. If we don't the remote device may disconnect.
---
 profiles/gatt/gas.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index e0edbf3..8477dca 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -184,16 +184,16 @@ static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 
 	DBG("Service Changed start: 0x%04X end: 0x%04X", start, end);
 
-	if (device_is_bonded(gas->device) == FALSE) {
-		DBG("Ignoring Service Changed: device is not bonded");
-		return;
-	}
-
 	/* Confirming indication received */
 	opdu = g_attrib_get_buffer(gas->attrib, &plen);
 	olen = enc_confirmation(opdu, plen);
 	g_attrib_send(gas->attrib, 0, opdu, olen, NULL, NULL, NULL);
 
+	if (device_is_bonded(gas->device) == FALSE) {
+		DBG("Ignoring Service Changed: device is not bonded");
+		return;
+	}
+
 	btd_device_gatt_set_service_changed(gas->device, start, end);
 }
 
-- 
1.8.1.1

