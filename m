Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH] Extract flags from advertising data
Date: Fri, 19 Nov 2010 09:57:28 -0400
Message-Id: <1290175048-16026-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These flags will be used to decide if GATT service discovery will happen
over LE (for single mode devices) or BR/EDR (for dual mode and non-LE
devices).
---
 src/adapter.c |   14 ++++++++++++++
 src/adapter.h |    1 +
 src/sdpd.h    |   10 ++++++++++
 3 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8136229..648d2a8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3053,6 +3053,18 @@ static struct remote_dev_info *get_found_dev(struct btd_adapter *adapter,
 	return dev;
 }
 
+static uint8_t extract_eir_flags(uint8_t *eir_data)
+{
+	if (eir_data[0] == 0)
+		return 0;
+
+	if (eir_data[1] != EIR_FLAGS)
+		return 0;
+
+	/* For now, only one octet is used for flags */
+	return eir_data[2];
+}
+
 void adapter_update_device_from_info(struct btd_adapter *adapter,
 						le_advertising_info *info)
 {
@@ -3084,6 +3096,8 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 			g_free(dev->name);
 			dev->name = tmp_name;
 		}
+
+		dev->flags = extract_eir_flags(info->data);
 	}
 
 	/* FIXME: check if other information was changed before emitting the
diff --git a/src/adapter.h b/src/adapter.h
index 4af69b3..3a67539 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -74,6 +74,7 @@ struct remote_dev_info {
 	GSList *services;
 	uint8_t evt_type;
 	uint8_t bdaddr_type;
+	uint8_t flags;
 };
 
 struct hci_dev {
diff --git a/src/sdpd.h b/src/sdpd.h
index 5bab869..a46ad3c 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -36,6 +36,7 @@
 
 #define EIR_DATA_LENGTH  240
 
+#define EIR_FLAGS                   0x01  /* flags */
 #define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available */
 #define EIR_UUID16_ALL              0x03  /* 16-bit UUID, all listed */
 #define EIR_UUID32_SOME             0x04  /* 32-bit UUID, more available */
@@ -47,6 +48,15 @@
 #define EIR_TX_POWER                0x0A  /* transmit power level */
 #define EIR_DEVICE_ID               0x10  /* device ID */
 
+/* Flags Descriptions */
+#define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
+#define EIR_GEN_DISC                0x02 /* LE General Discoverable Mode */
+#define EIR_BREDR_UNSUP             0x04 /* BR/EDR Not Supported */
+#define EIR_SIM_CONTROLLER          0x08 /* Simultaneous LE and BR/EDR to Same
+					    Device Capable (Controller) */
+#define EIR_SIM_HOST                0x10 /* Simultaneous LE and BR/EDR to Same
+					    Device Capable (Host) */
+
 typedef struct request {
 	bdaddr_t device;
 	bdaddr_t bdaddr;
-- 
1.7.0.4

