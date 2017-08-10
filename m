Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 09/14] advertising: Don't depend on kernel to include the Local Name
Date: Thu, 10 Aug 2017 16:32:46 +0300
Message-Id: <20170810133251.23920-9-luiz.dentz@gmail.com>
In-Reply-To: <20170810133251.23920-1-luiz.dentz@gmail.com>
References: <20170810133251.23920-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The flag to include Local Name may not be available in older kernel so
instead of depending on the kernel to add the adapter name in the scan
response generate it and set it as instance scan response:

@ MGMT Command: Add Advertising (0x003e) plen 31
        Instance: 1
        Flags: 0x00000003
          Switch into Connectable mode
          Advertise as Discoverable
        Duration: 0
        Timeout: 0
        Advertising data length: 0
        Scan response length: 20
        Name (complete): Vudentz's T460s #1
---
 src/advertising.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 6d54814d5..7e7458414 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -33,6 +33,7 @@
 #include "dbus-common.h"
 #include "error.h"
 #include "log.h"
+#include "eir.h"
 #include "src/shared/ad.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
@@ -47,6 +48,7 @@ struct btd_adv_manager {
 	struct mgmt *mgmt;
 	uint16_t mgmt_index;
 	uint8_t max_adv_len;
+	uint8_t max_scan_rsp_len;
 	uint8_t max_ads;
 	uint32_t supported_flags;
 	unsigned int instance_bitmap;
@@ -65,6 +67,7 @@ struct btd_adv_client {
 	uint8_t type; /* Advertising type */
 	uint32_t flags;
 	struct bt_ad *data;
+	struct bt_ad *scan;
 	uint8_t instance;
 };
 
@@ -101,6 +104,7 @@ static void client_free(void *data)
 						client->instance);
 
 	bt_ad_unref(client->data);
+	bt_ad_unref(client->scan);
 
 	g_dbus_proxy_unref(client->proxy);
 
@@ -532,12 +536,34 @@ static size_t calc_max_adv_len(struct btd_adv_client *client, uint32_t flags)
 	return max;
 }
 
+static uint8_t *generate_scan_rsp(struct btd_adv_client *client,
+						uint32_t *flags, size_t *len)
+{
+	struct btd_adv_manager *manager = client->manager;
+	const char *name;
+
+	if (!(*flags & MGMT_ADV_FLAG_LOCAL_NAME)) {
+		*len = 0;
+		return NULL;
+	}
+
+	*flags &= ~MGMT_ADV_FLAG_LOCAL_NAME;
+
+	name = btd_adapter_get_name(manager->adapter);
+
+	bt_ad_add_name(client->scan, name);
+
+	return bt_ad_generate(client->scan, len);
+}
+
 static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
 {
 	struct mgmt_cp_add_advertising *cp;
 	uint8_t param_len;
 	uint8_t *adv_data;
 	size_t adv_data_len;
+	uint8_t *scan_rsp;
+	size_t scan_rsp_len = -1;
 	uint32_t flags = 0;
 
 	DBG("Refreshing advertisement: %s", client->path);
@@ -557,7 +583,17 @@ static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
 						"Advertising data too long.");
 	}
 
-	param_len = sizeof(struct mgmt_cp_add_advertising) + adv_data_len;
+	scan_rsp = generate_scan_rsp(client, &flags, &scan_rsp_len);
+	if (!scan_rsp && scan_rsp_len) {
+		error("Scan data couldn't be generated.");
+
+		return g_dbus_create_error(client->reg, ERROR_INTERFACE
+						".InvalidLength",
+						"Advertising data too long.");
+	}
+
+	param_len = sizeof(struct mgmt_cp_add_advertising) + adv_data_len +
+							scan_rsp_len;
 
 	cp = malloc0(param_len);
 
@@ -565,6 +601,7 @@ static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
 		error("Couldn't allocate for MGMT!");
 
 		free(adv_data);
+		free(scan_rsp);
 
 		return btd_error_failed(client->reg, "Failed");
 	}
@@ -572,9 +609,12 @@ static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
 	cp->flags = htobl(flags);
 	cp->instance = client->instance;
 	cp->adv_data_len = adv_data_len;
+	cp->scan_rsp_len = scan_rsp_len;
 	memcpy(cp->data, adv_data, adv_data_len);
+	memcpy(cp->data + adv_data_len, scan_rsp, scan_rsp_len);
 
 	free(adv_data);
+	free(scan_rsp);
 
 	if (!mgmt_send(client->manager->mgmt, MGMT_OP_ADD_ADVERTISING,
 				client->manager->mgmt_index, param_len, cp,
@@ -672,6 +712,10 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
 	if (!client->data)
 		goto fail;
 
+	client->scan = bt_ad_new();
+	if (!client->scan)
+		goto fail;
+
 	client->manager = manager;
 
 	return client;
@@ -865,8 +909,9 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
 	}
 
 	manager->max_adv_len = feat->max_adv_data_len;
+	manager->max_scan_rsp_len = feat->max_scan_rsp_len;
 	manager->max_ads = feat->max_instances;
-	manager->supported_flags = feat->supported_flags;
+	manager->supported_flags |= feat->supported_flags;
 
 	if (manager->max_ads == 0)
 		return;
@@ -910,6 +955,7 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter)
 	}
 
 	manager->clients = queue_new();
+	manager->supported_flags = MGMT_ADV_FLAG_LOCAL_NAME;
 
 	return manager;
 }
-- 
2.13.4

