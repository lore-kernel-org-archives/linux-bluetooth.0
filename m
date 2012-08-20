Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 03/10] gatt: Enable indication for Service Changed
Date: Mon, 20 Aug 2012 14:22:48 -0300
Message-Id: <1345483375-27621-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enables indication of the Service Changed characteristic
setting the indication bit in the Client Characteristic Configuration
descriptor.
---
 profiles/gatt/gas.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index d36a457..dda4886 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -100,6 +100,27 @@ done:
 	att_data_list_free(list);
 }
 
+static void ccc_written_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	if (status) {
+		error("Write Service Changed CCC failed: %s",
+						att_ecode2str(status));
+		return;
+	}
+
+	DBG("Service Changed indications enabled");
+}
+
+static void write_ccc(GAttrib *attrib, uint16_t handle, gpointer user_data)
+{
+	uint8_t value[2];
+
+	att_put_u16(GATT_CLIENT_CHARAC_CFG_IND_BIT, value);
+	gatt_write_char(attrib, handle, value, sizeof(value), ccc_written_cb,
+								user_data);
+}
+
 static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 {
 	struct gas *gas = user_data;
@@ -145,6 +166,7 @@ static void gatt_service_changed_cb(guint8 status, const guint8 *pdu,
 static void gatt_descriptors_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
+	struct gas *gas = user_data;
 	struct att_data_list *list;
 	int i;
 	uint8_t format;
@@ -170,6 +192,7 @@ static void gatt_descriptors_cb(guint8 status, const guint8 *pdu, guint16 len,
 		ccc = att_get_u16(value);
 		uuid16 = att_get_u16(&value[2]);
 		DBG("CCC: 0x%04x UUID: 0x%04x", ccc, uuid16);
+		write_ccc(gas->attrib, ccc, user_data);
 	}
 
 done:
-- 
1.7.8.6

