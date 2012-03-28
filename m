Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH V4 3/7] Add support for setting VID source in DeviceID from config file
Date: Wed, 28 Mar 2012 12:03:15 +0200
Message-ID: <1332928999-14224-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1332928999-14224-1-git-send-email-szymon.janc@tieto.com>
References: <1332928999-14224-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to set if VID source is Bluetooth SIG or USB. Assigner is
provided as string {bluetooth,usb} and fallback to usb if none is set
in config.
---
 plugins/hciops.c   |    7 +++++--
 plugins/mgmtops.c  |    6 +++---
 src/adapter.c      |    6 ++++--
 src/adapter.h      |    5 +++--
 src/eir.c          |    7 +++----
 src/eir.h          |    2 +-
 src/main.c         |   19 +++++++++++++++++--
 src/main.conf      |    8 +++++---
 src/manager.c      |    4 +++-
 src/sdpd-service.c |    3 ++-
 10 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 4f287f0..6b4a82c 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -147,6 +147,7 @@ static struct dev_info {
 
 	struct hci_version ver;
 
+	uint16_t did_source;
 	uint16_t did_vendor;
 	uint16_t did_product;
 	uint16_t did_version;
@@ -672,7 +673,8 @@ static void update_ext_inquiry_response(int index)
 	memset(&cp, 0, sizeof(cp));
 
 	eir_create(dev->name, dev->tx_power, dev->did_vendor, dev->did_product,
-					dev->did_version, dev->uuids, cp.data);
+			dev->did_version, dev->did_source, dev->uuids,
+			cp.data);
 
 	if (memcmp(cp.data, dev->eir, sizeof(cp.data)) == 0)
 		return;
@@ -886,13 +888,14 @@ fail:
 }
 
 static int hciops_set_did(int index, uint16_t vendor, uint16_t product,
-							uint16_t version)
+					uint16_t version, uint16_t source)
 {
 	struct dev_info *dev = &devs[index];
 
 	dev->did_vendor = vendor;
 	dev->did_product = product;
 	dev->did_version = version;
+	dev->did_source = source;
 
 	return 0;
 }
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 4aa38fe..c24757c 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -2116,10 +2116,10 @@ static int mgmt_encrypt_link(int index, bdaddr_t *dst, bt_hci_result_t cb,
 }
 
 static int mgmt_set_did(int index, uint16_t vendor, uint16_t product,
-							uint16_t version)
+					uint16_t version, uint16_t source)
 {
-	DBG("index %d vendor %u product %u version %u",
-					index, vendor, product, version);
+	DBG("index %d vendor %u product %u version %u source %u",
+				index, vendor, product, version, source);
 	return -ENOSYS;
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index 7a2214a..0b4f9ba 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3476,9 +3476,11 @@ int btd_adapter_encrypt_link(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 }
 
 int btd_adapter_set_did(struct btd_adapter *adapter, uint16_t vendor,
-					uint16_t product, uint16_t version)
+					uint16_t product, uint16_t version,
+					uint16_t source)
 {
-	return adapter_ops->set_did(adapter->dev_id, vendor, product, version);
+	return adapter_ops->set_did(adapter->dev_id, vendor, product, version,
+								source);
 }
 
 int adapter_create_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr,
diff --git a/src/adapter.h b/src/adapter.h
index ceebb97..c47d180 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -212,7 +212,7 @@ struct btd_adapter_ops {
 	int (*encrypt_link) (int index, bdaddr_t *bdaddr, bt_hci_result_t cb,
 							gpointer user_data);
 	int (*set_did) (int index, uint16_t vendor, uint16_t product,
-							uint16_t version);
+					uint16_t version, uint16_t source);
 	int (*add_uuid) (int index, uuid_t *uuid, uint8_t svc_hint);
 	int (*remove_uuid) (int index, uuid_t *uuid);
 	int (*disable_cod_cache) (int index);
@@ -274,7 +274,8 @@ int btd_adapter_encrypt_link(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				bt_hci_result_t cb, gpointer user_data);
 
 int btd_adapter_set_did(struct btd_adapter *adapter, uint16_t vendor,
-					uint16_t product, uint16_t version);
+					uint16_t product, uint16_t version,
+					uint16_t source);
 
 int adapter_create_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				uint8_t addr_type, uint8_t io_cap);
diff --git a/src/eir.c b/src/eir.c
index 419f444..800dafa 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -232,7 +232,7 @@ static void eir_generate_uuid128(GSList *list, uint8_t *ptr, uint16_t *eir_len)
 
 void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
 			uint16_t did_product, uint16_t did_version,
-			GSList *uuids, uint8_t *data)
+			uint16_t did_source, GSList *uuids, uint8_t *data)
 {
 	GSList *l;
 	uint8_t *ptr = data;
@@ -269,11 +269,10 @@ void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
 	}
 
 	if (did_vendor != 0x0000) {
-		uint16_t source = 0x0002;
 		*ptr++ = 9;
 		*ptr++ = EIR_DEVICE_ID;
-		*ptr++ = (source & 0x00ff);
-		*ptr++ = (source & 0xff00) >> 8;
+		*ptr++ = (did_source & 0x00ff);
+		*ptr++ = (did_source & 0xff00) >> 8;
 		*ptr++ = (did_vendor & 0x00ff);
 		*ptr++ = (did_vendor & 0xff00) >> 8;
 		*ptr++ = (did_product & 0x00ff);
diff --git a/src/eir.h b/src/eir.h
index 13311ef..c040e49 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -52,7 +52,7 @@ void eir_data_free(struct eir_data *eir);
 int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len);
 void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
 			uint16_t did_product, uint16_t did_version,
-			GSList *uuids, uint8_t *data);
+			uint16_t did_source, GSList *uuids, uint8_t *data);
 
 gboolean eir_has_data_type(uint8_t *data, size_t len, uint8_t type);
 
diff --git a/src/main.c b/src/main.c
index 4e0cb5a..8763bf9 100644
--- a/src/main.c
+++ b/src/main.c
@@ -90,13 +90,28 @@ static GKeyFile *load_config(const char *file)
 static void parse_did(const char *did)
 {
 	int result;
-	uint16_t vendor, product, version = 0x0000; /* version is optional */
+	uint16_t vendor, product, version , source;
+
+	/* version and source are optional */
+	version = 0x0000;
+	source = 0x0002;
+
+	result = sscanf(did, "bluetooth:%4hx:%4hx:%4hx", &vendor, &product, &version);
+	if (result != EOF && result >= 2) {
+		source = 0x0001;
+		goto done;
+	}
+
+	result = sscanf(did, "usb:%4hx:%4hx:%4hx", &vendor, &product, &version);
+	if (result != EOF && result >= 2)
+		goto done;
 
 	result = sscanf(did, "%4hx:%4hx:%4hx", &vendor, &product, &version);
 	if (result == EOF || result < 2)
 		return;
 
-	main_opts.did_source = 0x0002;
+done:
+	main_opts.did_source = source;
 	main_opts.did_vendor = vendor;
 	main_opts.did_product = product;
 	main_opts.did_version = version;
diff --git a/src/main.conf b/src/main.conf
index 469c077..3419d07 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -43,9 +43,11 @@ InitiallyPowered = true
 # Remember the previously stored Powered state when initializing adapters
 RememberPowered = true
 
-# Use vendor, product and version information for DID profile support.
-# The values are separated by ":" and VID, PID and version.
-#DeviceID = 1234:5678:abcd
+# Use vendor id source (assigner), vendor, product and version information for
+# DID profile support. The values are separated by ":" and assigner, VID, PID
+# and version.
+# Possible vendor id source values: bluetooth, usb (defaults to usb)
+#DeviceID = bluetooth:1234:5678:abcd
 
 # Do reverse service discovery for previously unknown devices that connect to
 # us. This option is really only needed for qualification since the BITE tester
diff --git a/src/manager.c b/src/manager.c
index 3afc581..6244516 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -415,7 +415,9 @@ struct btd_adapter *btd_manager_register_adapter(int id, gboolean up)
 
 	if (main_opts.did_source)
 		btd_adapter_set_did(adapter, main_opts.did_vendor,
-				main_opts.did_product, main_opts.did_version);
+						main_opts.did_product,
+						main_opts.did_version,
+						main_opts.did_source);
 
 	DBG("Adapter %s registered", path);
 
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index ef00760..a6ed90e 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -184,7 +184,8 @@ void register_device_id(void)
 	sdp_profile_desc_t profile;
 	sdp_record_t *record = sdp_record_alloc();
 
-	info("Adding device id record for %04x:%04x:%04x", main_opts.did_vendor,
+	info("Adding device id record for %04x:%04x:%04x:%04x",
+				main_opts.did_source, main_opts.did_vendor,
 				main_opts.did_product, main_opts.did_version);
 
 	record->handle = sdp_next_handle();
-- 
on behalf of ST-Ericsson

