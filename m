Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 03/10] gap: Add read Appearance characteristic
Date: Wed, 15 Aug 2012 11:20:00 -0300
Message-Id: <1345040407-17767-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch registers the ATTIO callbacks, and triggers the Appearance
characteristic read by UUID when the ATT connection is established, and
it's value is not found in the storage.
---
 profiles/gap/gap.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/profiles/gap/gap.c b/profiles/gap/gap.c
index 7172975..0ecadb3 100644
--- a/profiles/gap/gap.c
+++ b/profiles/gap/gap.c
@@ -29,22 +29,32 @@
 
 #include "adapter.h"
 #include "device.h"
+#include "storage.h"
+
 #include "att.h"
 #include "gattrib.h"
+#include "attio.h"
 #include "gatt.h"
+
 #include "log.h"
 #include "gap.h"
 
 struct gap {
 	struct btd_device *device;
 	struct att_range range;	/* GAP Primary service range */
+	GAttrib *attrib;
+	guint attioid;
 };
 
 static GSList *devices = NULL;
 
 static void gap_free(struct gap *gap)
 {
+	if (gap->attioid)
+		btd_device_remove_attio_callback(gap->device, gap->attioid);
+
 	btd_device_unref(gap->device);
+
 	g_free(gap);
 }
 
@@ -56,6 +66,69 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return (gap->device == device ? 0 : -1);
 }
 
+static void appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct att_data_list *list =  NULL;
+	uint16_t app;
+	uint8_t *atval;
+
+	if (status != 0) {
+		DBG("Read characteristics by UUID failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	list = dec_read_by_type_resp(pdu, plen);
+	if (list == NULL)
+		return;
+
+	if (list->len != 4) {
+		DBG("Appearance value: invalid data");
+		goto done;
+	}
+
+	atval = list->data[0] + 2; /* skip handle value */
+	app = att_get_u16(atval);
+
+	DBG("Appearance: 0x%04x", app);
+
+done:
+	att_data_list_free(list);
+}
+
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct gap *gap = user_data;
+	bdaddr_t src, dst;
+	bt_uuid_t app_uuid;
+	uint16_t app;
+	uint8_t type;
+
+	gap->attrib = g_attrib_ref(attrib);
+
+	adapter_get_address(device_get_adapter(gap->device), &src);
+	device_get_address(gap->device, &dst, &type);
+
+	if (read_remote_appearance(&src, &dst, type, &app) == 0)
+		return;
+
+	bt_uuid16_create(&app_uuid, GATT_CHARAC_APPEARANCE);
+
+	gatt_read_char_by_uuid(gap->attrib, gap->range.start, gap->range.end,
+						&app_uuid, appearance_cb, gap);
+
+	/* TODO: Read other GAP characteristics - See Core spec page 1739 */
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct gap *gap = user_data;
+
+	g_attrib_unref(gap->attrib);
+	gap->attrib = NULL;
+}
+
 int gap_register(struct btd_device *device, struct gatt_primary *prim)
 {
 	struct gap *gap;
@@ -67,6 +140,9 @@ int gap_register(struct btd_device *device, struct gatt_primary *prim)
 
 	devices = g_slist_append(devices, gap);
 
+	gap->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
+						attio_disconnected_cb, gap);
+
 	return 0;
 }
 
-- 
1.7.8.6

