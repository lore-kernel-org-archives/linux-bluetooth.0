Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 01/10] gatt: Add Service Changed read
Date: Mon, 20 Aug 2012 14:22:46 -0300
Message-Id: <1345483375-27621-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the Service Changed GATT charateristic value read.
Force reading the value is necessary while Service Changed value handle
is not stored. Indication can be lost since it is the first data sent
from the GATT server when the connection is established, and the client
may not be filtering the ATT indications.
---
 profiles/gatt/gas.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 54f5842..01017fe 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -98,9 +98,32 @@ done:
 	att_data_list_free(list);
 }
 
+static void gatt_service_changed_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data)
+{
+	uint16_t start, end;
+
+	if (status) {
+		error("Read GATT Service Changed failed: %s",
+						att_ecode2str(status));
+		return;
+	}
+
+	if (plen != 5) {
+		error("Service Changed: PDU length mismatch");
+		return;
+	}
+
+	start = att_get_u16(&pdu[1]);
+	end = att_get_u16(&pdu[3]);
+
+	DBG("GATT Service Changed start: 0x%04X end: 0x%04X", start, end);
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct gas *gas = user_data;
+	bt_uuid_t changed_uuid;
 	uint16_t app;
 
 	gas->attrib = g_attrib_ref(attrib);
@@ -116,6 +139,16 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	}
 
 	/* TODO: Read other GAP characteristics - See Core spec page 1739 */
+
+	/*
+	 * Always read the characteristic value in the first connection
+	 * since attribute handles caching is not supported at the moment.
+	 */
+	bt_uuid16_create(&changed_uuid, GATT_CHARAC_SERVICE_CHANGED);
+
+	gatt_read_char_by_uuid(gas->attrib, gas->gatt.start,
+					gas->gatt.end, &changed_uuid,
+					gatt_service_changed_cb, gas);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
-- 
1.7.8.6

