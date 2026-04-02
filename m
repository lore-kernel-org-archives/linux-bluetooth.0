Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958F3264CC
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144736; cv=none; b=uzLNt3JjXNFxQpnpmN83MQMY9YEhAx4E27d/9dc7JxXEnaY167luzxaizNk4RosxDVzvVWoFoqMAguefKxhMsYXeHhM1MwAKIab1joGs7U/biDtZG20+wQyUkdl5YKv7Vx9HwzHqERkXqX5sqR+SJ3kEtgNJJ5YWbqacH97kJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144736; c=relaxed/simple;
	bh=pbYRePsgVvkLZby5mfFbtGS8vpLRxcerJTyp5klQoWM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLXWnNaV1hEp6PAuV54OF7l65EYKwFpHESxXXjYygeEXe07AFRpYmTvQjgpowem4Wxup/RBEJyaZZJMhE3qslJyb5l6fkZmeDJK+TIRtMgD9zl2zSfGOMKceDz8XnF0FyORQVNAdPyg8dyyvWUDvY8bZ4xv58mXbUxtKSdE2MwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DA603EC2B
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 15:45:26 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] shared: Remove glib dependency from src/shared/ad.c
Date: Thu,  2 Apr 2026 17:44:42 +0200
Message-ID: <20260402154520.48939-2-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402154520.48939-1-hadess@hadess.net>
References: <20260402154520.48939-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTGLDtWxhiUUE2qUmONOm1ERJXdAGJcNjFvK0Usq6tRTLPb26z3rnhS+DzchMoH2GKzQScg/bSL+UuSiBdPtlir1opXLGEJwLWp90gzZhfSeVYOea4uenIm9DYz2TH6weXZVVwXOzQ6LhLf/qHhzt5vZDMyF6atNGO50tzpQS2iicYLw7EszsQYa37omp0WzjErnHLXd6UhfqfST//8xZlAMIwrny6iq6frWMaT7zmZ+/T1M3CAvTd37/tF72mkd5Ikgs3mfvU+jN4gBWS8UVHw98Af8MLpWVgRn8DnqwxSuH+H7msDHYzpQ4dBnBe2NZwI5QN0sr/1rE34j8L2eAZcdcVHjJQGnyloJ32VY0mAOdqj6rMce5I1WFVukHZhoGzEGX38k2uLerntWxCT+CZyHIl1/uu+GG13I6ciKKyvvqsmEEdr6iAhQuPc/Hnd+7ParSYzWBQa9DTD+jbdhVDizJdnHJXE2N7Id30rNZ6TpAIVm4+7PfwdvkUMzY5e0Hh9RLbXJoWi/yOpKfqyht214UH5uePf9G6X0GnShjW/5DkiNE/b6Xd4+GaCVG174wdE9bXWkmZZBjB1hwjmWqW36AT214wK12fTT+oZwgvXjBE3CtlVe7BUpXQ8v0v5OuS99dIaX+sdmI49GAmfIsV9nfWKmA03rZplBG5xaHBqBzw

src/shared/ad.c includes src/eir.h, which uses glib, which means that
the non-glib shared library can't be used without linking to glib.

Use our own linked list implementation to remove the glib use.
---
 plugins/neard.c |  4 ++--
 src/adapter.c   |  9 +++++----
 src/device.c    | 22 +++++++++++-----------
 src/device.h    | 10 ++++++----
 src/eir.c       | 24 ++++++++++++------------
 src/eir.h       | 11 +++++------
 unit/test-eir.c |  5 ++---
 7 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index c84934025cd8..b2860403d50d 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -58,7 +58,7 @@ struct oob_params {
 	bdaddr_t address;
 	uint32_t class;
 	char *name;
-	GSList *services;
+	slist_t *services;
 	uint8_t *hash;
 	uint8_t *randomizer;
 	uint8_t *pin;
@@ -68,7 +68,7 @@ struct oob_params {
 
 static void free_oob_params(struct oob_params *params)
 {
-	g_slist_free_full(params->services, free);
+	slist_clear(params->services, free);
 	g_free(params->name);
 	g_free(params->hash);
 	g_free(params->randomizer);
diff --git a/src/adapter.c b/src/adapter.c
index 04568dae6e98..8eb0caa34223 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -43,6 +43,7 @@
 #include "textfile.h"
 
 #include "src/shared/util.h"
+#include "src/shared/list.h"
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
@@ -7171,10 +7172,10 @@ static void confirm_name(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 
 static void adapter_msd_notify(struct btd_adapter *adapter,
 							struct btd_device *dev,
-							GSList *msd_list)
+							slist_t *msd_list)
 {
 	GSList *cb_l, *cb_next;
-	GSList *msd_l, *msd_next;
+	slist_t *msd_l, *msd_next;
 
 	for (cb_l = adapter->msd_callbacks; cb_l != NULL; cb_l = cb_next) {
 		btd_msd_cb_t cb = cb_l->data;
@@ -7184,7 +7185,7 @@ static void adapter_msd_notify(struct btd_adapter *adapter,
 		for (msd_l = msd_list; msd_l != NULL; msd_l = msd_next) {
 			const struct eir_msd *msd = msd_l->data;
 
-			msd_next = g_slist_next(msd_l);
+			msd_next = msd_l->next;
 
 			cb(adapter, dev, msd->company, msd->data,
 								msd->data_len);
@@ -7223,7 +7224,7 @@ static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
 				/* m->data contains string representation of
 				 * uuid.
 				 */
-				if (g_slist_find_custom(eir_data->services,
+				if (slist_find(eir_data->services,
 							m->data,
 							g_strcmp) != NULL)
 					got_match = true;
diff --git a/src/device.c b/src/device.c
index 0e8ca28d3809..2a3b23ef3013 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2432,9 +2432,9 @@ unref:
 	dev->connect = NULL;
 }
 
-void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
+void device_add_eir_uuids(struct btd_device *dev, slist_t *uuids)
 {
-	GSList *l;
+	slist_t *l;
 	GSList *added = NULL;
 
 	if (dev->bredr_state.svc_resolved || dev->le_state.svc_resolved)
@@ -2465,13 +2465,13 @@ static void add_manufacturer_data(void *data, void *user_data)
 					DEVICE_INTERFACE, "ManufacturerData");
 }
 
-void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
+void device_set_manufacturer_data(struct btd_device *dev, slist_t *list,
 								bool duplicate)
 {
 	if (duplicate)
 		bt_ad_clear_manufacturer_data(dev->ad);
 
-	g_slist_foreach(list, add_manufacturer_data, dev);
+	slist_foreach(list, add_manufacturer_data, dev);
 }
 
 static void add_service_data(void *data, void *user_data)
@@ -2479,7 +2479,7 @@ static void add_service_data(void *data, void *user_data)
 	struct eir_sd *sd = data;
 	struct btd_device *dev = user_data;
 	bt_uuid_t uuid;
-	GSList *l;
+	slist_t *l;
 
 	if (bt_string_to_uuid(&uuid, sd->uuid) < 0)
 		return;
@@ -2487,21 +2487,21 @@ static void add_service_data(void *data, void *user_data)
 	if (!bt_ad_add_service_data(dev->ad, &uuid, sd->data, sd->data_len))
 		return;
 
-	l = g_slist_append(NULL, sd->uuid);
+	l = slist_append(NULL, sd->uuid);
 	device_add_eir_uuids(dev, l);
-	g_slist_free(l);
+	slist_free(l);
 
 	g_dbus_emit_property_changed(dbus_conn, dev->path,
 					DEVICE_INTERFACE, "ServiceData");
 }
 
-void device_set_service_data(struct btd_device *dev, GSList *list,
+void device_set_service_data(struct btd_device *dev, slist_t *list,
 							bool duplicate)
 {
 	if (duplicate)
 		bt_ad_clear_service_data(dev->ad);
 
-	g_slist_foreach(list, add_service_data, dev);
+	slist_foreach(list, add_service_data, dev);
 }
 
 static void add_data(void *data, void *user_data)
@@ -2518,13 +2518,13 @@ static void add_data(void *data, void *user_data)
 						"AdvertisingData");
 }
 
-void device_set_data(struct btd_device *dev, GSList *list,
+void device_set_data(struct btd_device *dev, slist_t *list,
 							bool duplicate)
 {
 	if (duplicate)
 		bt_ad_clear_data(dev->ad);
 
-	g_slist_foreach(list, add_data, dev);
+	slist_foreach(list, add_data, dev);
 }
 
 static struct btd_service *find_connectable_service(struct btd_device *dev,
diff --git a/src/device.h b/src/device.h
index c7b8b2a16eb9..5ee1f2300223 100644
--- a/src/device.h
+++ b/src/device.h
@@ -9,6 +9,8 @@
  *
  */
 
+#include "src/shared/list.h"
+
 #define DEVICE_INTERFACE	"org.bluez.Device1"
 
 struct btd_device;
@@ -78,12 +80,12 @@ void btd_device_gatt_set_service_changed(struct btd_device *device,
 						uint16_t start, uint16_t end);
 bool device_attach_att(struct btd_device *dev, GIOChannel *io);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
-void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
-void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
+void device_add_eir_uuids(struct btd_device *dev, slist_t *uuids);
+void device_set_manufacturer_data(struct btd_device *dev, slist_t *list,
 							bool duplicate);
-void device_set_service_data(struct btd_device *dev, GSList *list,
+void device_set_service_data(struct btd_device *dev, slist_t *list,
 							bool duplicate);
-void device_set_data(struct btd_device *dev, GSList *list,
+void device_set_data(struct btd_device *dev, slist_t *list,
 							bool duplicate);
 void device_probe_profile(gpointer a, gpointer b);
 void device_remove_profile(gpointer a, gpointer b);
diff --git a/src/eir.c b/src/eir.c
index 68ed74fe6493..8efca6978b39 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -49,7 +49,7 @@ static void data_free(void *data)
 
 void eir_data_free(struct eir_data *eir)
 {
-	g_slist_free_full(eir->services, free);
+	slist_clear(eir->services, free);
 	eir->services = NULL;
 	g_free(eir->name);
 	eir->name = NULL;
@@ -57,11 +57,11 @@ void eir_data_free(struct eir_data *eir)
 	eir->hash = NULL;
 	free(eir->randomizer);
 	eir->randomizer = NULL;
-	g_slist_free_full(eir->msd_list, g_free);
+	slist_clear(eir->msd_list, g_free);
 	eir->msd_list = NULL;
-	g_slist_free_full(eir->sd_list, sd_free);
+	slist_clear(eir->sd_list, sd_free);
 	eir->sd_list = NULL;
-	g_slist_free_full(eir->data_list, data_free);
+	slist_clear(eir->data_list, data_free);
 	eir->data_list = NULL;
 }
 
@@ -80,7 +80,7 @@ static void eir_parse_uuid16(struct eir_data *eir, const void *data,
 		uuid_str = bt_uuid2string(&service);
 		if (!uuid_str)
 			continue;
-		eir->services = g_slist_append(eir->services, uuid_str);
+		eir->services = slist_append(eir->services, uuid_str);
 	}
 }
 
@@ -99,7 +99,7 @@ static void eir_parse_uuid32(struct eir_data *eir, const void *data,
 		uuid_str = bt_uuid2string(&service);
 		if (!uuid_str)
 			continue;
-		eir->services = g_slist_append(eir->services, uuid_str);
+		eir->services = slist_append(eir->services, uuid_str);
 	}
 }
 
@@ -119,7 +119,7 @@ static void eir_parse_uuid128(struct eir_data *eir, const uint8_t *data,
 		uuid_str = bt_uuid2string(&service);
 		if (!uuid_str)
 			continue;
-		eir->services = g_slist_append(eir->services, uuid_str);
+		eir->services = slist_append(eir->services, uuid_str);
 		uuid_ptr += 16;
 	}
 }
@@ -151,7 +151,7 @@ static void eir_parse_msd(struct eir_data *eir, const uint8_t *data,
 	msd->data_len = len - 2;
 	memcpy(&msd->data, data + 2, msd->data_len);
 
-	eir->msd_list = g_slist_append(eir->msd_list, msd);
+	eir->msd_list = slist_append(eir->msd_list, msd);
 }
 
 static void eir_parse_sd(struct eir_data *eir, uuid_t *service,
@@ -169,7 +169,7 @@ static void eir_parse_sd(struct eir_data *eir, uuid_t *service,
 	sd->data_len = len;
 	memcpy(&sd->data, data, sd->data_len);
 
-	eir->sd_list = g_slist_append(eir->sd_list, sd);
+	eir->sd_list = slist_append(eir->sd_list, sd);
 }
 
 static void eir_parse_uuid16_data(struct eir_data *eir, const uint8_t *data,
@@ -226,7 +226,7 @@ static void eir_parse_data(struct eir_data *eir, uint8_t type,
 	ad->data = g_malloc(len);
 	memcpy(ad->data, data, len);
 
-	eir->data_list = g_slist_append(eir->data_list, ad);
+	eir->data_list = slist_append(eir->data_list, ad);
 
 	if (type == EIR_CSIP_RSI)
 		eir->rsi = true;
@@ -605,12 +605,12 @@ static int match_sd_uuid(const void *data, const void *user_data)
 
 struct eir_sd *eir_get_service_data(struct eir_data *eir, const char *uuid)
 {
-	GSList *l;
+	slist_t *l;
 
 	if (!eir || !uuid)
 		return NULL;
 
-	l = g_slist_find_custom(eir->sd_list, uuid, match_sd_uuid);
+	l = slist_find(eir->sd_list, uuid, match_sd_uuid);
 	if (!l)
 		return NULL;
 
diff --git a/src/eir.h b/src/eir.h
index b9f7c3874eb3..7adaef7fb0e4 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -9,10 +9,9 @@
  *
  */
 
-#include <glib.h>
-
 #include "bluetooth/sdp.h"
 #include "bluetooth/uuid.h"
+#include "src/shared/list.h"
 
 #define EIR_FLAGS                   0x01  /* flags */
 #define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available */
@@ -73,7 +72,7 @@ struct eir_ad {
 };
 
 struct eir_data {
-	GSList *services;
+	slist_t *services;
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
+	slist_t *msd_list;
+	slist_t *sd_list;
+	slist_t *data_list;
 };
 
 void eir_data_free(struct eir_data *eir);
diff --git a/unit/test-eir.c b/unit/test-eir.c
index 55967e957c82..5024d43723a8 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -587,7 +587,7 @@ static void print_debug(const char *str, void *user_data)
 static void test_ad(const struct test_data *test, struct eir_data *eir)
 {
 	struct bt_ad *ad;
-	GSList *list;
+	slist_t *list;
 
 	ad = bt_ad_new_with_data(test->eir_size, test->eir_data);
 	g_assert(ad);
@@ -636,7 +636,7 @@ static void test_parsing(gconstpointer data)
 {
 	const struct test_data *test = data;
 	struct eir_data eir;
-	GSList *list;
+	slist_t *list;
 
 	memset(&eir, 0, sizeof(eir));
 
@@ -664,7 +664,6 @@ static void test_parsing(gconstpointer data)
 	g_assert(eir.tx_power == test->tx_power);
 
 	if (test->uuid) {
-		GSList *list;
 		int n = 0;
 
 		for (list = eir.services; list; list = list->next, n++) {
-- 
2.53.0

