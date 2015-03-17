Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v2 08/14] shared: add advertising-data
Date: Tue, 17 Mar 2015 16:49:55 -0700
Message-Id: <1426636201-30057-9-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1426636201-30057-1-git-send-email-jamuraa@chromium.org>
References: <1426636201-30057-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The advetising_data structure provides an abstraction for easy
translation of defined Advertisement Data fields into the resulting
raw bytes needed by the Bluetooth HCI LE Set Advertising Data command.
---
 Makefile.am                   |   2 +
 src/shared/advertising-data.c | 349 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/advertising-data.h |  69 +++++++++
 3 files changed, 420 insertions(+)
 create mode 100644 src/shared/advertising-data.c
 create mode 100644 src/shared/advertising-data.h

diff --git a/Makefile.am b/Makefile.am
index f534dc0..1f01b3c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -111,6 +111,8 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/uhid.h src/shared/uhid.c \
 			src/shared/pcap.h src/shared/pcap.c \
 			src/shared/btsnoop.h src/shared/btsnoop.c \
+			src/shared/advertising-data.h \
+			src/shared/advertising-data.c \
 			src/shared/att-types.h \
 			src/shared/att.h src/shared/att.c \
 			src/shared/gatt-helpers.h src/shared/gatt-helpers.c \
diff --git a/src/shared/advertising-data.c b/src/shared/advertising-data.c
new file mode 100644
index 0000000..800856c
--- /dev/null
+++ b/src/shared/advertising-data.c
@@ -0,0 +1,349 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Google Inc.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+
+#include "src/shared/advertising-data.h"
+
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+
+struct advertising_data {
+	int ref_count;
+	struct queue *service_uuids;
+	struct queue *manufacturer_data;
+	struct queue *solicit_uuids;
+	struct queue *service_data;
+};
+
+struct uuid_tagged_data {
+	bt_uuid_t uuid;
+	uint8_t *data;
+	size_t len;
+};
+
+struct manufacturer_tagged_data {
+	uint16_t manufacturer_id;
+	uint8_t *data;
+	size_t len;
+};
+
+struct advertising_data *advertising_data_new(void)
+{
+	struct advertising_data *ad;
+
+	ad = new0(struct advertising_data, 1);
+	if (!ad)
+		return NULL;
+
+	ad->service_uuids = queue_new();
+	if (!ad->service_uuids)
+		goto fail;
+
+	ad->manufacturer_data = queue_new();
+	if (!ad->manufacturer_data)
+		goto fail;
+
+	ad->solicit_uuids = queue_new();
+	if (!ad->solicit_uuids)
+		goto fail;
+
+	ad->service_data = queue_new();
+	if (!ad->service_data)
+		goto fail;
+
+	return advertising_data_ref(ad);
+
+fail:
+	queue_destroy(ad->service_uuids, NULL);
+	queue_destroy(ad->manufacturer_data, NULL);
+	queue_destroy(ad->solicit_uuids, NULL);
+	queue_destroy(ad->service_data, NULL);
+
+	free(ad);
+
+	return NULL;
+}
+
+struct advertising_data *advertising_data_ref(struct advertising_data *ad)
+{
+	ad->ref_count++;
+	return ad;
+}
+
+static void uuid_tagged_destroy(void *data)
+{
+	struct uuid_tagged_data *tagged = data;
+
+	free(tagged->data);
+	free(tagged);
+}
+
+static bool uuid_tagged_match(const void *data, const void *elem)
+{
+	const struct uuid_tagged_data *tagged = elem;
+	const bt_uuid_t *uuid = data;
+
+	return !bt_uuid_cmp(&tagged->uuid, uuid);
+}
+
+static void manuf_tagged_destroy(void *data)
+{
+	struct manufacturer_tagged_data *tagged = data;
+
+	free(tagged->data);
+	free(tagged);
+}
+
+static bool manuf_tagged_match(const void *data, const void *elem)
+{
+	const struct manufacturer_tagged_data *tagged = elem;
+	uint16_t manuf_id = PTR_TO_UINT(elem);
+
+	return tagged->manufacturer_id == manuf_id;
+}
+
+void advertising_data_unref(struct advertising_data *ad)
+{
+	if (!ad)
+		return;
+
+	if (__sync_sub_and_fetch(&ad->ref_count, 1))
+		return;
+
+	queue_destroy(ad->service_uuids, free);
+
+	queue_destroy(ad->manufacturer_data, manuf_tagged_destroy);
+
+	queue_destroy(ad->solicit_uuids, free);
+
+	queue_destroy(ad->service_data, uuid_tagged_destroy);
+
+	free(ad);
+}
+
+uint8_t *advertising_data_generate(struct advertising_data *ad, uint8_t *length)
+{
+	/* TODO: implement */
+	return NULL;
+}
+
+static bool queue_add_uuid(struct queue *queue, const bt_uuid_t *uuid)
+{
+	bt_uuid_t *new_uuid;
+
+	if (!queue)
+		return false;
+
+	new_uuid = new0(bt_uuid_t, 1);
+	if (!new_uuid)
+		return false;
+
+	bt_uuid_to_uuid128(uuid, new_uuid);
+
+	queue_push_tail(queue, new_uuid);
+
+	return true;
+}
+
+static bool uuid_match(const void *data, const void *elem)
+{
+	const bt_uuid_t *match_uuid = data;
+	const bt_uuid_t *uuid = elem;
+
+	return bt_uuid_cmp(match_uuid, uuid);
+}
+
+static bool queue_remove_uuid(struct queue *queue, bt_uuid_t *uuid)
+{
+	bt_uuid_t *removed;
+
+	if (!queue || !uuid)
+		return false;
+
+	removed = queue_remove_if(queue, uuid_match, uuid);
+
+	if (removed) {
+		free(removed);
+		return true;
+	}
+
+	return false;
+}
+
+bool advertising_data_add_service_uuid(struct advertising_data *ad,
+							const bt_uuid_t *uuid)
+{
+	if (!ad)
+		return false;
+
+	return queue_add_uuid(ad->service_uuids, uuid);
+}
+
+bool advertising_data_remove_service_uuid(struct advertising_data *ad,
+							bt_uuid_t *uuid)
+{
+	if (!ad)
+		return false;
+
+	return queue_remove_uuid(ad->service_uuids, uuid);
+}
+
+void advertising_data_clear_service_uuid(struct advertising_data *ad)
+{
+	queue_destroy(ad->service_uuids, free);
+
+	ad->service_uuids = queue_new();
+}
+
+bool advertising_data_add_manufacturer_data(struct advertising_data *ad,
+						uint16_t manufacturer_id,
+						void *data, size_t len)
+{
+	struct manufacturer_tagged_data *new_data;
+
+	if (!ad)
+		return false;
+
+	new_data = new0(struct manufacturer_tagged_data, 1);
+	if (!new_data)
+		return false;
+
+	new_data->manufacturer_id = manufacturer_id;
+
+	new_data->data = malloc(len);
+	if (!new_data->data) {
+		free(new_data);
+		return false;
+	}
+
+	memcpy(new_data->data, data, len);
+
+	if (queue_push_tail(ad->manufacturer_data, new_data))
+		return true;
+
+	manuf_tagged_destroy(new_data);
+
+	return false;
+}
+
+bool advertising_data_remove_manufacturer_data(struct advertising_data *ad,
+						uint16_t manufacturer_id)
+{
+	struct manufacturer_tagged_data *data;
+
+	if (!ad)
+		return false;
+
+	data = queue_remove_if(ad->manufacturer_data, manuf_tagged_match,
+						UINT_TO_PTR(manufacturer_id));
+
+	if (!data)
+		return false;
+
+	manuf_tagged_destroy(data);
+
+	return true;
+}
+
+void advertising_data_clear_manufacturer_data(struct advertising_data *ad)
+{
+	queue_destroy(ad->manufacturer_data, manuf_tagged_destroy);
+
+	ad->manufacturer_data = queue_new();
+}
+
+bool advertising_data_add_solicit_uuid(struct advertising_data *ad,
+							const bt_uuid_t *uuid)
+{
+	if (!ad)
+		return false;
+
+	return queue_add_uuid(ad->solicit_uuids, uuid);
+}
+
+bool advertising_data_remove_solicit_uuid(struct advertising_data *ad,
+							bt_uuid_t *uuid)
+{
+	if (!ad)
+		return false;
+
+	return queue_remove_uuid(ad->solicit_uuids, uuid);
+}
+
+void advertising_data_clear_solicit_uuid(struct advertising_data *ad)
+{
+	queue_destroy(ad->solicit_uuids, free);
+
+	ad->solicit_uuids = queue_new();
+}
+
+bool advertising_data_add_service_data(struct advertising_data *ad,
+						const bt_uuid_t *uuid,
+						void *data, size_t len)
+{
+	struct uuid_tagged_data *new_data;
+
+	if (!ad)
+		return false;
+
+	new_data = new0(struct uuid_tagged_data, 1);
+	if (!new_data)
+		return false;
+
+	bt_uuid_to_uuid128(uuid, &new_data->uuid);
+
+	new_data->data = malloc(len);
+	if (!new_data) {
+		free(new_data);
+		return false;
+	}
+
+	memcpy(new_data->data, data, len);
+
+	if (queue_push_tail(ad->service_data, new_data))
+		return true;
+
+	uuid_tagged_destroy(new_data);
+
+	return false;
+}
+
+bool advertising_data_remove_service_data(struct advertising_data *ad,
+							bt_uuid_t *uuid)
+{
+	struct uuid_tagged_data *data;
+
+	if (!ad)
+		return false;
+
+	data = queue_remove_if(ad->service_data, uuid_tagged_match, uuid);
+
+	if (!data)
+		return false;
+
+	uuid_tagged_destroy(data);
+
+	return true;
+}
+
+void advertising_data_clear_service_data(struct advertising_data *ad)
+{
+	queue_destroy(ad->service_data, uuid_tagged_destroy);
+
+	ad->service_data = queue_new();
+}
diff --git a/src/shared/advertising-data.h b/src/shared/advertising-data.h
new file mode 100644
index 0000000..05d2b51
--- /dev/null
+++ b/src/shared/advertising-data.h
@@ -0,0 +1,69 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Google Inc.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+
+#include <inttypes.h>
+#include <stdbool.h>
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+
+struct advertising_data;
+
+struct advertising_data *advertising_data_new(void);
+
+struct advertising_data *advertising_data_ref(struct advertising_data *ad);
+
+void advertising_data_unref(struct advertising_data *ad);
+
+uint8_t *advertising_data_generate(struct advertising_data *ad,
+							uint8_t *length);
+
+bool advertising_data_add_service_uuid(struct advertising_data *ad,
+							const bt_uuid_t *uuid);
+
+bool advertising_data_remove_service_uuid(struct advertising_data *ad,
+							bt_uuid_t *uuid);
+
+void advertising_data_clear_service_uuid(struct advertising_data *ad);
+
+bool advertising_data_add_manufacturer_data(struct advertising_data *ad,
+						uint16_t manufacturer_data,
+						void *data, size_t len);
+
+bool advertising_data_remove_manufacturer_data(struct advertising_data *ad,
+						uint16_t manufacturer_id);
+
+void advertising_data_clear_manufacturer_data(struct advertising_data *ad);
+
+bool advertising_data_add_solicit_uuid(struct advertising_data *ad,
+							const bt_uuid_t *uuid);
+
+bool advertising_data_remove_solicit_uuid(struct advertising_data *ad,
+							bt_uuid_t *uuid);
+
+void advertising_data_clear_solicit_uuid(struct advertising_data *ad);
+
+bool advertising_data_add_service_data(struct advertising_data *ad,
+						const bt_uuid_t *uuid,
+						void *data, size_t len);
+
+bool advertising_data_remove_service_data(struct advertising_data *ad,
+							bt_uuid_t *uuid);
+
+void advertising_data_clear_service_data(struct advertising_data *ad);
-- 
2.2.0.rc0.207.ga3a616c

