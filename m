Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/12] android/gatt: Add support for PnP ID in DIS
Date: Tue, 30 Sep 2014 13:06:22 +0200
Message-Id: <1412075187-5518-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
References: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index c00265a..7346d98 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6446,6 +6446,43 @@ done:
 	entry->state = REQUEST_DONE;
 }
 
+static void device_info_read_pnp_id_cb(uint16_t handle, uint16_t offset,
+					uint8_t att_opcode, bdaddr_t *bdaddr,
+					void *user_data)
+{
+	struct pending_request *entry;
+	struct gatt_device *dev;
+
+	dev = find_device_by_addr(bdaddr);
+	if (!dev) {
+		error("gatt: Could not find device ?!");
+		return;
+	}
+
+	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
+							UINT_TO_PTR(handle));
+	if (!entry)
+		return;
+
+	entry->value = malloc0(sizeof(uint8_t) + 3 * sizeof(uint16_t));
+	if (!entry->value) {
+		entry->error = ATT_ECODE_UNLIKELY;
+		goto done;
+	}
+
+	entry->length = sizeof(uint8_t) + 3 * sizeof(uint16_t);
+
+	entry->value[0] = bt_config_get_pnp_source();
+	put_le16(bt_config_get_pnp_vendor(), entry->value + 1);
+	put_le16(bt_config_get_pnp_product(), entry->value + 3);
+	put_le16(bt_config_get_pnp_version(), entry->value + 5);
+
+	entry->offset = offset;
+
+done:
+	entry->state = REQUEST_DONE;
+}
+
 static void register_device_info_service(void)
 {
 	bt_uuid_t uuid;
@@ -6530,6 +6567,15 @@ static void register_device_info_service(void)
 						(void *) data);
 	}
 
+	if (bt_config_get_pnp_source()) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_PNP_ID);
+		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
+						GATT_PERM_READ,
+						GATT_CHR_PROP_READ,
+						device_info_read_pnp_id_cb,
+						NULL, NULL);
+	}
+
 	gatt_db_service_set_active(gatt_db, srvc_handle, true);
 
 	/* SDP */
-- 
1.9.1

