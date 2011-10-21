Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add eir length parameter to eir_parse()
Date: Fri, 21 Oct 2011 12:10:23 +0200
Message-Id: <1319191823-17377-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

LE use shorter eir (31 bytes) than HCI (240 bytes)
---
 plugins/hciops.c  |   22 +++++++++-------------
 plugins/mgmtops.c |    3 ++-
 src/adapter.c     |    4 ++--
 src/adapter.h     |    2 +-
 src/eir.c         |    6 +++---
 src/eir.h         |    2 +-
 src/event.c       |    5 +++--
 src/event.h       |    2 +-
 unit/test-eir.c   |    2 +-
 9 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 90b2112..54e29e5 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1869,7 +1869,7 @@ static inline void inquiry_result(int index, int plen, void *ptr)
 						(info->dev_class[2] << 16);
 
 		btd_event_device_found(&dev->bdaddr, &info->bdaddr, class,
-								0, NULL);
+								0, NULL, 0);
 		ptr += INQUIRY_INFO_SIZE;
 	}
 }
@@ -1891,7 +1891,7 @@ static inline void inquiry_result_with_rssi(int index, int plen, void *ptr)
 						| (info->dev_class[2] << 16);
 
 			btd_event_device_found(&dev->bdaddr, &info->bdaddr,
-						class, info->rssi, NULL);
+						class, info->rssi, NULL, 0);
 			ptr += INQUIRY_INFO_WITH_RSSI_AND_PSCAN_MODE_SIZE;
 		}
 	} else {
@@ -1902,7 +1902,7 @@ static inline void inquiry_result_with_rssi(int index, int plen, void *ptr)
 						| (info->dev_class[2] << 16);
 
 			btd_event_device_found(&dev->bdaddr, &info->bdaddr,
-						class, info->rssi, NULL);
+						class, info->rssi, NULL, 0);
 			ptr += INQUIRY_INFO_WITH_RSSI_SIZE;
 		}
 	}
@@ -1921,7 +1921,8 @@ static inline void extended_inquiry_result(int index, int plen, void *ptr)
 					| (info->dev_class[2] << 16);
 
 		btd_event_device_found(&dev->bdaddr, &info->bdaddr, class,
-						info->rssi, info->data);
+						info->rssi, info->data,
+						HCI_MAX_EIR_LENGTH);
 		ptr += EXTENDED_INQUIRY_INFO_SIZE;
 	}
 }
@@ -2140,7 +2141,7 @@ static inline void le_advertising_report(int index, evt_le_meta_event *meta)
 {
 	struct dev_info *dev = &devs[index];
 	le_advertising_info *info;
-	uint8_t num_reports, rssi, eir[HCI_MAX_EIR_LENGTH];
+	uint8_t num_reports, rssi;
 	const uint8_t RSSI_SIZE = 1;
 
 	num_reports = meta->data[0];
@@ -2148,10 +2149,8 @@ static inline void le_advertising_report(int index, evt_le_meta_event *meta)
 	info = (le_advertising_info *) &meta->data[1];
 	rssi = *(info->data + info->length);
 
-	memset(eir, 0, sizeof(eir));
-	memcpy(eir, info->data, info->length);
-
-	btd_event_device_found(&dev->bdaddr, &info->bdaddr, 0, rssi, eir);
+	btd_event_device_found(&dev->bdaddr, &info->bdaddr, 0, rssi,
+						info->data, info->length);
 
 	num_reports--;
 
@@ -2160,11 +2159,8 @@ static inline void le_advertising_report(int index, evt_le_meta_event *meta)
 								RSSI_SIZE);
 		rssi = *(info->data + info->length);
 
-		memset(eir, 0, sizeof(eir));
-		memcpy(eir, info->data, info->length);
-
 		btd_event_device_found(&dev->bdaddr, &info->bdaddr, 0, rssi,
-									eir);
+						info->data, info->length);
 	}
 }
 
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 7df00ee..0bea368 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1328,7 +1328,8 @@ static void mgmt_device_found(int sk, uint16_t index, void *buf, size_t len)
 	DBG("hci%u addr %s, class %u rssi %d %s", index, addr, cls,
 						ev->rssi, eir ? "eir" : "");
 
-	btd_event_device_found(&info->bdaddr, &ev->bdaddr, cls, ev->rssi, eir);
+	btd_event_device_found(&info->bdaddr, &ev->bdaddr, cls, ev->rssi, eir,
+							HCI_MAX_EIR_LENGTH);
 }
 
 static void mgmt_remote_name(int sk, uint16_t index, void *buf, size_t len)
diff --git a/src/adapter.c b/src/adapter.c
index f08910e..2b4b7e3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2906,7 +2906,7 @@ static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer, const char *file)
 
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 						uint32_t class, int8_t rssi,
-						uint8_t *data)
+						uint8_t *data, uint8_t data_len)
 {
 	struct remote_dev_info *dev, match;
 	struct eir_data eir_data;
@@ -2916,7 +2916,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	int err;
 
 	memset(&eir_data, 0, sizeof(eir_data));
-	err = eir_parse(&eir_data, data);
+	err = eir_parse(&eir_data, data, data_len);
 	if (err < 0) {
 		error("Error parsing EIR data: %s (%d)", strerror(-err), -err);
 		return;
diff --git a/src/adapter.h b/src/adapter.h
index d30e82a..ff1d659 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -111,7 +111,7 @@ struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter
 						struct remote_dev_info *match);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 						uint32_t class, int8_t rssi,
-						uint8_t *data);
+						uint8_t *data, uint8_t data_len);
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 void adapter_emit_device_found(struct btd_adapter *adapter,
 						struct remote_dev_info *dev);
diff --git a/src/eir.c b/src/eir.c
index 4e7c028..5e0e96a 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -107,7 +107,7 @@ static void eir_parse_uuid128(struct eir_data *eir, uint8_t *data, uint8_t len)
 	}
 }
 
-int eir_parse(struct eir_data *eir, uint8_t *eir_data)
+int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 {
 	uint16_t len = 0;
 
@@ -117,7 +117,7 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data)
 	if (eir_data == NULL)
 		return 0;
 
-	while (len < HCI_MAX_EIR_LENGTH - 1) {
+	while (len < eir_len - 1) {
 		uint8_t field_len = eir_data[0];
 
 		/* Check for the end of EIR */
@@ -127,7 +127,7 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data)
 		len += field_len + 1;
 
 		/* Bail out if got incorrect length */
-		if (len > HCI_MAX_EIR_LENGTH) {
+		if (len > eir_len) {
 			eir_data_free(eir);
 			return -EINVAL;
 		}
diff --git a/src/eir.h b/src/eir.h
index d225973..8842790 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -35,7 +35,7 @@ struct eir_data {
 };
 
 void eir_data_free(struct eir_data *eir);
-int eir_parse(struct eir_data *eir, uint8_t *eir_data);
+int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len);
 void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
 			uint16_t did_product, uint16_t did_version,
 			GSList *uuids, uint8_t *data);
diff --git a/src/event.c b/src/event.c
index 9f3f2e3..9849280 100644
--- a/src/event.c
+++ b/src/event.c
@@ -265,7 +265,7 @@ static void update_lastused(bdaddr_t *sba, bdaddr_t *dba)
 }
 
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
-				int8_t rssi, uint8_t *data)
+				int8_t rssi, uint8_t *data, uint8_t data_len)
 {
 	struct btd_adapter *adapter;
 
@@ -281,7 +281,8 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	if (data)
 		write_remote_eir(local, peer, data);
 
-	adapter_update_found_devices(adapter, peer, class, rssi, data);
+	adapter_update_found_devices(adapter, peer, class, rssi, data,
+								data_len);
 }
 
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer,
diff --git a/src/event.h b/src/event.h
index d93a361..1c1098a 100644
--- a/src/event.h
+++ b/src/event.h
@@ -24,7 +24,7 @@
 
 int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure);
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
-						int8_t rssi, uint8_t *data);
+				int8_t rssi, uint8_t *data, uint8_t data_len);
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean legacy);
 void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status, char *name);
diff --git a/unit/test-eir.c b/unit/test-eir.c
index 5ea5d75..f25b58e 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -44,7 +44,7 @@ static void test_basic(void)
 	memset(buf, 0, sizeof(buf));
 	memset(&data, 0, sizeof(data));
 
-	err = eir_parse(&data, buf);
+	err = eir_parse(&data, buf, HCI_MAX_EIR_LENGTH);
 	g_assert(err == 0);
 	g_assert(data.services == NULL);
 	g_assert(data.name == NULL);
-- 
1.7.1

