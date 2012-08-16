Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 03/10] gatt: Add read Appearance characteristic
Date: Thu, 16 Aug 2012 17:13:04 -0300
Message-Id: <1345147991-31320-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
References: <CAKT1EBfp+iJfRSodDfoqtDB4X90BNR1wEJh_zXvw0t6JvnaWuA@mail.gmail.com>
 <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch registers the ATTIO callbacks, and triggers the Appearance
characteristic read by UUID when the ATT connection is established (if
appearance value is not found in the storage).
---
 profiles/gatt/gas.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index d13eadc..2fb12ce 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -29,8 +29,10 @@
 
 #include "adapter.h"
 #include "device.h"
+#include "storage.h"
 #include "att.h"
 #include "gattrib.h"
+#include "attio.h"
 #include "gatt.h"
 #include "log.h"
 #include "gas.h"
@@ -40,12 +42,17 @@ struct gas {
 	struct btd_device *device;
 	struct att_range gap;	/* GAP Primary service range */
 	struct att_range gatt;	/* GATT Primary service range */
+	GAttrib *attrib;
+	guint attioid;
 };
 
 static GSList *devices = NULL;
 
 static void gas_free(struct gas *gas)
 {
+	if (gas->attioid)
+		btd_device_remove_attio_callback(gas->device, gas->attioid);
+
 	btd_device_unref(gas->device);
 	g_free(gas);
 }
@@ -58,6 +65,70 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return (gas->device == device ? 0 : -1);
 }
 
+static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct att_data_list *list =  NULL;
+	uint16_t app;
+	uint8_t *atval;
+
+	if (status != 0) {
+		error("Read characteristics by UUID failed: %s",
+				att_ecode2str(status));
+		return;
+	}
+
+	list = dec_read_by_type_resp(pdu, plen);
+	if (list == NULL)
+		return;
+
+	if (list->len != 4) {
+		error("GAP Appearance value: invalid data");
+		goto done;
+	}
+
+	atval = list->data[0] + 2; /* skip handle value */
+	app = att_get_u16(atval);
+
+	DBG("GAP Appearance: 0x%04x", app);
+
+done:
+	att_data_list_free(list);
+}
+
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct gas *gas = user_data;
+	bdaddr_t src, dst;
+	uint16_t app;
+	uint8_t type;
+
+	gas->attrib = g_attrib_ref(attrib);
+
+	adapter_get_address(device_get_adapter(gas->device), &src);
+	device_get_address(gas->device, &dst, &type);
+
+	if (read_remote_appearance(&src, &dst, type, &app) < 0) {
+		bt_uuid_t uuid;
+
+		bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
+
+		gatt_read_char_by_uuid(gas->attrib, gas->gap.start,
+						gas->gap.end, &uuid,
+						gap_appearance_cb, gas);
+	}
+
+	/* TODO: Read other GAP characteristics - See Core spec page 1739 */
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct gas *gas = user_data;
+
+	g_attrib_unref(gas->attrib);
+	gas->attrib = NULL;
+}
+
 int gas_register(struct btd_device *device, struct att_range *gap,
 						struct att_range *gatt)
 {
@@ -73,6 +144,10 @@ int gas_register(struct btd_device *device, struct att_range *gap,
 
 	devices = g_slist_append(devices, gas);
 
+	gas->attioid = btd_device_add_attio_callback(device,
+						attio_connected_cb,
+						attio_disconnected_cb, gas);
+
 	return 0;
 }
 
-- 
1.7.8.6

