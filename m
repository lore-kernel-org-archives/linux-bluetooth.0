Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 17/38] android/gatt: Add register GAP Service
Date: Wed, 30 Apr 2014 11:13:48 +0200
Message-Id: <1398849249-5868-18-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Register GAP service with device name characteristic,
appearance and peripheral privacy flag
---
 android/gatt.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index c2f43b5..ef8bd7c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3706,6 +3706,101 @@ static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
 		error("gatt: Could not attach to server");
 }
 
+struct gap_srvc_handles {
+	uint16_t srvc;
+
+	/* Characteristics */
+	uint16_t dev_name;
+	uint16_t appear;
+	uint16_t priv;
+};
+
+static struct gap_srvc_handles gap_srvc_data;
+
+#define APPEARANCE_GENERIC_PHONE 0x0040
+#define PERIPHERAL_PRIVACY_DISABLE 0x00
+
+static void gap_read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
+					bdaddr_t *bdaddr, void *user_data)
+{
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	uint16_t len;
+	struct gatt_device *dev;
+
+	DBG("");
+
+	dev = find_device_by_addr(bdaddr);
+	if (!dev) {
+		error("gatt: Could not find device ?!");
+		return;
+	}
+
+	if (handle == gap_srvc_data.dev_name) {
+		const char *name = bt_get_adapter_name();
+
+		len = enc_read_resp((uint8_t *)name, strlen(name),
+							pdu, sizeof(pdu));
+		goto done;
+	}
+
+	if (handle == gap_srvc_data.appear) {
+		uint8_t val[2];
+		put_le16(APPEARANCE_GENERIC_PHONE, val);
+		len = enc_read_resp(val, sizeof(val), pdu, sizeof(pdu));
+		goto done;
+	}
+
+	if (handle == gap_srvc_data.priv) {
+		uint8_t val = PERIPHERAL_PRIVACY_DISABLE;
+		len = enc_read_resp(&val, sizeof(val), pdu, sizeof(pdu));
+		goto done;
+	}
+
+	error("gatt: Unknown handle 0x%02x", handle);
+	len = enc_error_resp(ATT_OP_READ_REQ, handle,
+					ATT_ECODE_UNLIKELY, pdu, sizeof(pdu));
+
+done:
+	g_attrib_send(dev->attrib, 0, pdu, len, NULL, NULL, NULL);
+}
+
+static void register_gap_service(void)
+{
+	bt_uuid_t uuid;
+
+	/* GAP UUID */
+	bt_uuid16_create(&uuid, 0x1800);
+	gap_srvc_data.srvc = gatt_db_add_service(gatt_db, &uuid, true, 7);
+
+	/* Device name characteristic */
+	bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
+	gap_srvc_data.dev_name =
+			gatt_db_add_characteristic(gatt_db, gap_srvc_data.srvc,
+							&uuid, 0,
+							GATT_CHR_PROP_READ,
+							gap_read_cb, NULL,
+							NULL);
+
+	/* Appearance */
+	bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
+	gap_srvc_data.appear =
+			gatt_db_add_characteristic(gatt_db, gap_srvc_data.srvc,
+							&uuid, 0,
+							GATT_CHR_PROP_READ,
+							gap_read_cb, NULL,
+							NULL);
+
+	/* Pripheral privacy flag */
+	bt_uuid16_create(&uuid, GATT_CHARAC_PERIPHERAL_PRIV_FLAG);
+	gap_srvc_data.priv =
+			gatt_db_add_characteristic(gatt_db, gap_srvc_data.srvc,
+							&uuid, 0,
+							GATT_CHR_PROP_READ,
+							gap_read_cb, NULL,
+							NULL);
+
+	gatt_db_service_set_active(gatt_db, gap_srvc_data.srvc , true);
+}
 static int start_listen_socket(void)
 {
 	GError *gerr = NULL;
@@ -3772,6 +3867,8 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	if (start_listen_socket() < 0)
 		error("Could not start GATT listening");
 
+	register_gap_service();
+
 	return true;
 }
 
-- 
1.8.4

