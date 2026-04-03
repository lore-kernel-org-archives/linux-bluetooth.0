Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98C2EAB82
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205700; cv=none; b=SM1Ce/iR1NWHmByyshf8zB7NgdkgstIrgPX8L//+mqYC3OoO/X03tHzAmwN+1mlfRxH2xuKdTmg5t0bSgb5Fshc0qNFHH7+ARHe7RX+Enx6cxnn1620i2x2l4699u2yVkzO6/pRgk4WCqEFYd2iM67QYE79Dd1lLXs581XSgFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205700; c=relaxed/simple;
	bh=CR0es/h5yKizDzENk7y68nue7Nnh0zHxt8Hwbn8jQ10=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdPt0Vpubd1rYlnEvegx6O4riZM4DU0eKdxv2IYdo0IOwL0aaWxv+8UBgXgHbfKHoSUIlrIwqj0RmRJwwnHq4B7fjRKmW7UBTlYoHClu1bYqtJvYZs27UzrB6WvsY5VtM8w3T48cevKsACGN+LwiuqD4Bmw8j9MmYeIPodqEDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08E513EBC2
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:41:36 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared: Remove glib dependency from src/shared/ad.c
Date: Fri,  3 Apr 2026 10:40:55 +0200
Message-ID: <20260403084128.348931-2-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403084128.348931-1-hadess@hadess.net>
References: <20260403084128.348931-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTF8wQdtWsTugDN7F0i8tNPfXw1dsz8/39mAsUvkFjzkGtsqDLKSGLBpXLWch1YuFvtIq378jm4dh5sh4S7Y6kMRAfOc+znNxo9cA41ZyKtRs0+pNez5Z623YM1nwXaHSuprObfH313wPDpmIUut4Qobt9bL0Z2R7W7TMASFjF3NKpqJ3ToF3R8DFL5KkqmMVgVyLmf1vznB7vyE6Xi/utU1nMpJomDs3LA78y/OyufD52xcbXVRtWIWA/kmCLjEOLktNXIm94TkDeaGtluyXYfvrDN6eZW9wGpeOeYmND6OfXxU4qczYir5eFYXuX58SZFfjt9/HNq5Vp0UVL+vrr4si8DRbFicrckMygPGmFpoyqcR42G3tX//FgUzI3qc9S9fvHlwfa6x4UKrEXqsY+ZvZXgcqWDQVxjlfcHbobGYjeFNzwR1giBHQr9/WzfsRGVqOsAMYzbyy6bl4KjPAkcZ9Tkt/IYQ/NKk1xRXpJmM8uhNTyVGNorG84Q1Iylq17iel0RdqkGCRenXAezRC9UwMnZ//UxD5mK1VZC2ua4OFGN9/FPffvbJSXm3kxBWCoAdC+6kR37TbruqxaohEvOGB7rbbz51KaCpz10yHNhUMKKwNNO54MUokDJthLlgbd8SMGNbo2T8xNB1xT/TBN3ROn/miV7tU3Cgvm7u2ikbyQ

src/shared/ad.c includes src/eir.h, which uses glib, which means that
the non-glib shared library can't be used without linking to glib.

Use our own queue implementation to remove the glib linked-list usage.
---
 plugins/neard.c |  4 ++--
 src/adapter.c   | 10 +++++-----
 src/device.c    | 29 +++++++++++++++--------------
 src/device.h    | 10 ++++++----
 src/eir.c       | 41 ++++++++++++++++++++++-------------------
 src/eir.h       | 11 +++++------
 unit/test-eir.c | 29 ++++++++++++++---------------
 7 files changed, 69 insertions(+), 65 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index c84934025cd8..edfc115373ef 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -58,7 +58,7 @@ struct oob_params {
 	bdaddr_t address;
 	uint32_t class;
 	char *name;
-	GSList *services;
+	struct queue *services;
 	uint8_t *hash;
 	uint8_t *randomizer;
 	uint8_t *pin;
@@ -68,7 +68,7 @@ struct oob_params {
 
 static void free_oob_params(struct oob_params *params)
 {
-	g_slist_free_full(params->services, free);
+	queue_destroy(params->services, free);
 	g_free(params->name);
 	g_free(params->hash);
 	g_free(params->randomizer);
diff --git a/src/adapter.c b/src/adapter.c
index 04568dae6e98..aa5aca7d5fe3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7171,20 +7171,20 @@ static void confirm_name(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 
 static void adapter_msd_notify(struct btd_adapter *adapter,
 							struct btd_device *dev,
-							GSList *msd_list)
+							struct queue *msd_list)
 {
 	GSList *cb_l, *cb_next;
-	GSList *msd_l, *msd_next;
+	struct queue_entry *msd_l, *msd_next;
 
 	for (cb_l = adapter->msd_callbacks; cb_l != NULL; cb_l = cb_next) {
 		btd_msd_cb_t cb = cb_l->data;
 
 		cb_next = g_slist_next(cb_l);
 
-		for (msd_l = msd_list; msd_l != NULL; msd_l = msd_next) {
+		for (msd_l = queue_peek_head_entry(msd_list); msd_l != NULL; msd_l = msd_next) {
 			const struct eir_msd *msd = msd_l->data;
 
-			msd_next = g_slist_next(msd_l);
+			msd_next = msd_l->next;
 
 			cb(adapter, dev, msd->company, msd->data,
 								msd->data_len);
@@ -7223,7 +7223,7 @@ static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
 				/* m->data contains string representation of
 				 * uuid.
 				 */
-				if (g_slist_find_custom(eir_data->services,
+				if (queue_find(eir_data->services,
 							m->data,
 							g_strcmp) != NULL)
 					got_match = true;
diff --git a/src/device.c b/src/device.c
index 0e8ca28d3809..f755851280c0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2432,16 +2432,16 @@ unref:
 	dev->connect = NULL;
 }
 
-void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
+void device_add_eir_uuids(struct btd_device *dev, struct queue *uuids)
 {
-	GSList *l;
+	struct queue_entry *q;
 	GSList *added = NULL;
 
 	if (dev->bredr_state.svc_resolved || dev->le_state.svc_resolved)
 		return;
 
-	for (l = uuids; l != NULL; l = l->next) {
-		const char *str = l->data;
+	for (q = queue_peek_head_entry(uuids); q != NULL; q = q->next) {
+		const char *str = q->data;
 		if (g_slist_find_custom(dev->eir_uuids, str, bt_uuid_strcmp))
 			continue;
 		added = g_slist_append(added, (void *)str);
@@ -2465,13 +2465,13 @@ static void add_manufacturer_data(void *data, void *user_data)
 					DEVICE_INTERFACE, "ManufacturerData");
 }
 
-void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
+void device_set_manufacturer_data(struct btd_device *dev, struct queue *queue,
 								bool duplicate)
 {
 	if (duplicate)
 		bt_ad_clear_manufacturer_data(dev->ad);
 
-	g_slist_foreach(list, add_manufacturer_data, dev);
+	queue_foreach(queue, add_manufacturer_data, dev);
 }
 
 static void add_service_data(void *data, void *user_data)
@@ -2479,7 +2479,7 @@ static void add_service_data(void *data, void *user_data)
 	struct eir_sd *sd = data;
 	struct btd_device *dev = user_data;
 	bt_uuid_t uuid;
-	GSList *l;
+	struct queue *q;
 
 	if (bt_string_to_uuid(&uuid, sd->uuid) < 0)
 		return;
@@ -2487,21 +2487,22 @@ static void add_service_data(void *data, void *user_data)
 	if (!bt_ad_add_service_data(dev->ad, &uuid, sd->data, sd->data_len))
 		return;
 
-	l = g_slist_append(NULL, sd->uuid);
-	device_add_eir_uuids(dev, l);
-	g_slist_free(l);
+	q = queue_new();
+	queue_push_tail(q, sd->uuid);
+	device_add_eir_uuids(dev, q);
+	queue_destroy(q, NULL);
 
 	g_dbus_emit_property_changed(dbus_conn, dev->path,
 					DEVICE_INTERFACE, "ServiceData");
 }
 
-void device_set_service_data(struct btd_device *dev, GSList *list,
+void device_set_service_data(struct btd_device *dev, struct queue *queue,
 							bool duplicate)
 {
 	if (duplicate)
 		bt_ad_clear_service_data(dev->ad);
 
-	g_slist_foreach(list, add_service_data, dev);
+	queue_foreach(queue, add_service_data, dev);
 }
 
 static void add_data(void *data, void *user_data)
@@ -2518,13 +2519,13 @@ static void add_data(void *data, void *user_data)
 						"AdvertisingData");
 }
 
-void device_set_data(struct btd_device *dev, GSList *list,
+void device_set_data(struct btd_device *dev, struct queue *queue,
 							bool duplicate)
 {
 	if (duplicate)
 		bt_ad_clear_data(dev->ad);
 
-	g_slist_foreach(list, add_data, dev);
+	queue_foreach(queue, add_data, dev);
 }
 
 static struct btd_service *find_connectable_service(struct btd_device *dev,
diff --git a/src/device.h b/src/device.h
index c7b8b2a16eb9..b36f9af66dd2 100644
--- a/src/device.h
+++ b/src/device.h
@@ -9,6 +9,8 @@
  *
  */
 
+#include "src/shared/queue.h"
+
 #define DEVICE_INTERFACE	"org.bluez.Device1"
 
 struct btd_device;
@@ -78,12 +80,12 @@ void btd_device_gatt_set_service_changed(struct btd_device *device,
 						uint16_t start, uint16_t end);
 bool device_attach_att(struct btd_device *dev, GIOChannel *io);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
-void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
-void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
+void device_add_eir_uuids(struct btd_device *dev, struct queue *uuids);
+void device_set_manufacturer_data(struct btd_device *dev, struct queue *queue,
 							bool duplicate);
-void device_set_service_data(struct btd_device *dev, GSList *list,
+void device_set_service_data(struct btd_device *dev, struct queue *queue,
 							bool duplicate);
-void device_set_data(struct btd_device *dev, GSList *list,
+void device_set_data(struct btd_device *dev, struct queue *queue,
 							bool duplicate);
 void device_probe_profile(gpointer a, gpointer b);
 void device_remove_profile(gpointer a, gpointer b);
diff --git a/src/eir.c b/src/eir.c
index 68ed74fe6493..89c15995a546 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -47,9 +47,18 @@ static void data_free(void *data)
 	g_free(ad);
 }
 
+static struct queue *
+queue_append(struct queue *q, void *data)
+{
+	if (!q)
+		q = queue_new();
+	queue_push_tail(q, data);
+	return q;
+}
+
 void eir_data_free(struct eir_data *eir)
 {
-	g_slist_free_full(eir->services, free);
+	queue_destroy(eir->services, g_free);
 	eir->services = NULL;
 	g_free(eir->name);
 	eir->name = NULL;
@@ -57,11 +66,11 @@ void eir_data_free(struct eir_data *eir)
 	eir->hash = NULL;
 	free(eir->randomizer);
 	eir->randomizer = NULL;
-	g_slist_free_full(eir->msd_list, g_free);
+	queue_destroy(eir->msd_list, g_free);
 	eir->msd_list = NULL;
-	g_slist_free_full(eir->sd_list, sd_free);
+	queue_destroy(eir->sd_list, sd_free);
 	eir->sd_list = NULL;
-	g_slist_free_full(eir->data_list, data_free);
+	queue_destroy(eir->data_list, data_free);
 	eir->data_list = NULL;
 }
 
@@ -80,7 +89,7 @@ static void eir_parse_uuid16(struct eir_data *eir, const void *data,
 		uuid_str = bt_uuid2string(&service);
 		if (!uuid_str)
 			continue;
-		eir->services = g_slist_append(eir->services, uuid_str);
+		eir->services = queue_append(eir->services, uuid_str);
 	}
 }
 
@@ -99,7 +108,7 @@ static void eir_parse_uuid32(struct eir_data *eir, const void *data,
 		uuid_str = bt_uuid2string(&service);
 		if (!uuid_str)
 			continue;
-		eir->services = g_slist_append(eir->services, uuid_str);
+		eir->services = queue_append(eir->services, uuid_str);
 	}
 }
 
@@ -119,7 +128,7 @@ static void eir_parse_uuid128(struct eir_data *eir, const uint8_t *data,
 		uuid_str = bt_uuid2string(&service);
 		if (!uuid_str)
 			continue;
-		eir->services = g_slist_append(eir->services, uuid_str);
+		eir->services = queue_append(eir->services, uuid_str);
 		uuid_ptr += 16;
 	}
 }
@@ -151,7 +160,7 @@ static void eir_parse_msd(struct eir_data *eir, const uint8_t *data,
 	msd->data_len = len - 2;
 	memcpy(&msd->data, data + 2, msd->data_len);
 
-	eir->msd_list = g_slist_append(eir->msd_list, msd);
+	eir->msd_list = queue_append(eir->msd_list, msd);
 }
 
 static void eir_parse_sd(struct eir_data *eir, uuid_t *service,
@@ -169,7 +178,7 @@ static void eir_parse_sd(struct eir_data *eir, uuid_t *service,
 	sd->data_len = len;
 	memcpy(&sd->data, data, sd->data_len);
 
-	eir->sd_list = g_slist_append(eir->sd_list, sd);
+	eir->sd_list = queue_append(eir->sd_list, sd);
 }
 
 static void eir_parse_uuid16_data(struct eir_data *eir, const uint8_t *data,
@@ -226,7 +235,7 @@ static void eir_parse_data(struct eir_data *eir, uint8_t type,
 	ad->data = g_malloc(len);
 	memcpy(ad->data, data, len);
 
-	eir->data_list = g_slist_append(eir->data_list, ad);
+	eir->data_list = queue_append(eir->data_list, ad);
 
 	if (type == EIR_CSIP_RSI)
 		eir->rsi = true;
@@ -595,24 +604,18 @@ int eir_create_oob(const bdaddr_t *addr, const char *name, uint32_t cod,
 	return eir_total_len;
 }
 
-static int match_sd_uuid(const void *data, const void *user_data)
+static bool match_sd_uuid(const void *data, const void *user_data)
 {
 	const struct eir_sd *sd = data;
 	const char *uuid = user_data;
 
-	return strcmp(sd->uuid, uuid);
+	return strcmp(sd->uuid, uuid) == 0;
 }
 
 struct eir_sd *eir_get_service_data(struct eir_data *eir, const char *uuid)
 {
-	GSList *l;
-
 	if (!eir || !uuid)
 		return NULL;
 
-	l = g_slist_find_custom(eir->sd_list, uuid, match_sd_uuid);
-	if (!l)
-		return NULL;
-
-	return l->data;
+	return queue_find(eir->sd_list, match_sd_uuid, uuid);
 }
diff --git a/src/eir.h b/src/eir.h
index b9f7c3874eb3..7d7125e756ce 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -9,10 +9,9 @@
  *
  */
 
-#include <glib.h>
-
 #include "bluetooth/sdp.h"
 #include "bluetooth/uuid.h"
+#include "src/shared/queue.h"
 
 #define EIR_FLAGS                   0x01  /* flags */
 #define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available */
@@ -73,7 +72,7 @@ struct eir_ad {
 };
 
 struct eir_data {
-	GSList *services;
+	struct queue *services;
 	unsigned int flags;
 	char *name;
 	uint32_t class;
@@ -88,9 +87,9 @@ struct eir_data {
 	uint16_t did_product;
 	uint16_t did_version;
 	uint16_t did_source;
-	GSList *msd_list;
-	GSList *sd_list;
-	GSList *data_list;
+	struct queue *msd_list;
+	struct queue *sd_list;
+	struct queue *data_list;
 };
 
 void eir_data_free(struct eir_data *eir);
diff --git a/unit/test-eir.c b/unit/test-eir.c
index 55967e957c82..8d67b1973e6e 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -587,7 +587,7 @@ static void print_debug(const char *str, void *user_data)
 static void test_ad(const struct test_data *test, struct eir_data *eir)
 {
 	struct bt_ad *ad;
-	GSList *list;
+	struct queue_entry *q;
 
 	ad = bt_ad_new_with_data(test->eir_size, test->eir_data);
 	g_assert(ad);
@@ -607,8 +607,8 @@ static void test_ad(const struct test_data *test, struct eir_data *eir)
 		}
 	}
 
-	for (list = eir->msd_list; list; list = list->next) {
-		struct eir_msd *msd = list->data;
+	for (q = queue_peek_head_entry(eir->msd_list); q; q = q->next) {
+		struct eir_msd *msd = q->data;
 		struct bt_ad_manufacturer_data adm;
 
 		adm.manufacturer_id = msd->company;
@@ -618,8 +618,8 @@ static void test_ad(const struct test_data *test, struct eir_data *eir)
 		g_assert(bt_ad_has_manufacturer_data(ad, &adm));
 	}
 
-	for (list = eir->sd_list; list; list = list->next) {
-		struct eir_sd *sd = list->data;
+	for (q = queue_peek_head_entry(eir->sd_list); q; q = q->next) {
+		struct eir_sd *sd = q->data;
 		struct bt_ad_service_data ads;
 
 		bt_string_to_uuid(&ads.uuid, sd->uuid);
@@ -636,7 +636,7 @@ static void test_parsing(gconstpointer data)
 {
 	const struct test_data *test = data;
 	struct eir_data eir;
-	GSList *list;
+	struct queue_entry *q;
 
 	memset(&eir, 0, sizeof(eir));
 
@@ -646,8 +646,8 @@ static void test_parsing(gconstpointer data)
 	tester_debug("Name: %s", eir.name);
 	tester_debug("TX power: %d", eir.tx_power);
 
-	for (list = eir.services; list; list = list->next) {
-		char *uuid_str = list->data;
+	for (q = queue_peek_head_entry(eir.services); q; q = q->next) {
+		char *uuid_str = q->data;
 
 		tester_debug("UUID: %s", uuid_str);
 	}
@@ -664,11 +664,10 @@ static void test_parsing(gconstpointer data)
 	g_assert(eir.tx_power == test->tx_power);
 
 	if (test->uuid) {
-		GSList *list;
 		int n = 0;
 
-		for (list = eir.services; list; list = list->next, n++) {
-			char *uuid_str = list->data;
+		for (q = queue_peek_head_entry(eir.services); q; q = q->next, n++) {
+			char *uuid_str = q->data;
 			g_assert(test->uuid[n]);
 			g_assert_cmpstr(test->uuid[n], ==, uuid_str);
 		}
@@ -676,16 +675,16 @@ static void test_parsing(gconstpointer data)
 		g_assert(eir.services == NULL);
 	}
 
-	for (list = eir.msd_list; list; list = list->next) {
-		struct eir_msd *msd = list->data;
+	for (q = queue_peek_head_entry(eir.msd_list); q; q = q->next) {
+		struct eir_msd *msd = q->data;
 
 		tester_debug("Manufacturer ID: 0x%04x", msd->company);
 		util_hexdump(' ', msd->data, msd->data_len, print_debug,
 							"Manufacturer Data:");
 	}
 
-	for (list = eir.sd_list; list; list = list->next) {
-		struct eir_sd *sd = list->data;
+	for (q = queue_peek_head_entry(eir.sd_list); q; q = q->next) {
+		struct eir_sd *sd = q->data;
 
 		tester_debug("Service UUID: %s", sd->uuid);
 		util_hexdump(' ', sd->data, sd->data_len, print_debug,
-- 
2.53.0

