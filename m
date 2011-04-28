Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 13/13] Drop variable EIR length
Date: Thu, 28 Apr 2011 19:37:09 -0300
Message-Id: <1304030229-6672-14-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

The functions eir_parse() and adapter_update_found_devices() now
assume that the EIR buffer has always 240 octets. For advertising
reports, the advertising data is stored on a buffer with 240 bytes,
padded with zeroes.
---
 plugins/hciops.c |   13 +++++++++----
 src/adapter.c    |    5 ++---
 src/adapter.h    |    3 +--
 src/eir.c        |    8 ++++----
 src/eir.h        |    2 +-
 src/event.c      |    2 +-
 6 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 91d5778..8b7befa 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -2080,7 +2080,7 @@ static inline void le_advertising_report(int index, evt_le_meta_event *meta)
 {
 	struct dev_info *dev = &devs[index];
 	le_advertising_info *info;
-	uint8_t num_reports, rssi;
+	uint8_t num_reports, rssi, eir[HCI_MAX_EIR_LENGTH];
 	const uint8_t RSSI_SIZE = 1;
 
 	num_reports = meta->data[0];
@@ -2088,8 +2088,11 @@ static inline void le_advertising_report(int index, evt_le_meta_event *meta)
 	info = (le_advertising_info *) &meta->data[1];
 	rssi = *(info->data + info->length);
 
+	memset(eir, 0, sizeof(eir));
+	memcpy(eir, info->data, info->length);
+
 	btd_event_device_found(&dev->bdaddr, &info->bdaddr,
-				info->bdaddr_type, 0, rssi, info->data);
+					info->bdaddr_type, 0, rssi, eir);
 
 	num_reports--;
 
@@ -2098,9 +2101,11 @@ static inline void le_advertising_report(int index, evt_le_meta_event *meta)
 								RSSI_SIZE);
 		rssi = *(info->data + info->length);
 
+		memset(eir, 0, sizeof(eir));
+		memcpy(eir, info->data, info->length);
+
 		btd_event_device_found(&dev->bdaddr, &info->bdaddr,
-						info->bdaddr_type, 0,
-						rssi, info->data);
+					info->bdaddr_type, 0, rssi, eir);
 	}
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index bae7324..cd9df75 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3114,8 +3114,7 @@ static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer, const char *file)
 
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 					uint8_t bda_type, uint32_t class,
-					int8_t rssi, uint8_t *data,
-					size_t eir_size)
+					int8_t rssi, uint8_t *data)
 {
 	struct remote_dev_info *dev, match;
 	struct eir_data eir_data;
@@ -3125,7 +3124,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	int err, type;
 
 	memset(&eir_data, 0, sizeof(eir_data));
-	err = eir_parse(&eir_data, data, HCI_MAX_EIR_LENGTH);
+	err = eir_parse(&eir_data, data);
 	if (err < 0) {
 		error("Error parsing EIR data: %s (%d)", strerror(-err), -err);
 		return;
diff --git a/src/adapter.h b/src/adapter.h
index 931be37..f296389 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -120,8 +120,7 @@ struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter
 						struct remote_dev_info *match);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 					uint8_t bda_type, uint32_t class,
-					int8_t rssi, uint8_t *data,
-					size_t eir_size);
+					int8_t rssi, uint8_t *data);
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 void adapter_emit_device_found(struct btd_adapter *adapter,
 						struct remote_dev_info *dev);
diff --git a/src/eir.c b/src/eir.c
index 7dfc444..01b6ac5 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -52,7 +52,7 @@ void eir_data_free(struct eir_data *eir)
 	g_free(eir->name);
 }
 
-int eir_parse(struct eir_data *eir, uint8_t *eir_data, size_t eir_length)
+int eir_parse(struct eir_data *eir, uint8_t *eir_data)
 {
 	uint16_t len = 0;
 	size_t total;
@@ -69,10 +69,10 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, size_t eir_length)
 	eir->flags = -1;
 
 	/* No EIR data to parse */
-	if (eir_data == NULL || eir_length == 0)
+	if (eir_data == NULL)
 		return 0;
 
-	while (len < eir_length - 1) {
+	while (len < HCI_MAX_EIR_LENGTH - 1) {
 		uint8_t field_len = eir_data[0];
 
 		/* Check for the end of EIR */
@@ -115,7 +115,7 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, size_t eir_length)
 	}
 
 	/* Bail out if got incorrect length */
-	if (len > eir_length)
+	if (len > HCI_MAX_EIR_LENGTH)
 		return -EINVAL;
 
 	total = uuid16_count + uuid32_count + uuid128_count;
diff --git a/src/eir.h b/src/eir.h
index ea38570..d225973 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -35,7 +35,7 @@ struct eir_data {
 };
 
 void eir_data_free(struct eir_data *eir);
-int eir_parse(struct eir_data *eir, uint8_t *eir_data, size_t eir_length);
+int eir_parse(struct eir_data *eir, uint8_t *eir_data);
 void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
 			uint16_t did_product, uint16_t did_version,
 			GSList *uuids, uint8_t *data);
diff --git a/src/event.c b/src/event.c
index 2b83ea7..4390c54 100644
--- a/src/event.c
+++ b/src/event.c
@@ -302,7 +302,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bda_type,
 	}
 
 	adapter_update_found_devices(adapter, peer, bda_type, class,
-						rssi, data, HCI_MAX_EIR_LENGTH);
+								rssi, data);
 }
 
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer,
-- 
1.7.5.rc3

