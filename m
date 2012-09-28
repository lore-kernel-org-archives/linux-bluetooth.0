Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 2/4] gatt: Ignore Service Changed if not bonded
Date: Fri, 28 Sep 2012 11:47:52 -0300
Message-Id: <1348843674-10878-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1348843674-10878-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1348843674-10878-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix replying for Service Changed indication when the device
is not bonded. From Erratum 3951: Indications caused by changes to the
Service Changed Characteristic Value shall be considered lost if the
client has not enabled indications the Client Configuration
Characteristic Descriptor.
---
 profiles/gatt/gas.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index a828fcd..b42aa64 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -146,6 +146,11 @@ static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 
 	DBG("Service Changed start: 0x%04X end: 0x%04X", start, end);
 
+	if (device_is_bonded(gas->device) == FALSE) {
+		DBG("Ignoring Service Changed: device is not bonded");
+		return;
+	}
+
 	/* Confirming indication received */
 	opdu = g_attrib_get_buffer(gas->attrib, &plen);
 	olen = enc_confirmation(opdu, plen);
-- 
1.7.12

