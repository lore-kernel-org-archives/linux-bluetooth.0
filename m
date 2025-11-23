Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0232D838C
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763914655; cv=pass; b=EmkabQFvkwuVwgW00glifmT+iI9rLIYhviGh4P+U3cuQL3k1jvgLPpGeVTTq3aPYzCkez0JXusxJjggwAeQ90rDLd/OrRTpqDLKnddF/NV7YDACiusmXllYjpOh2rXm0u69sAsvqSkdQS+L5YR8rwfV1NrjYQ08mRDSC+GAJ7xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763914655; c=relaxed/simple;
	bh=181MlFAJJnZMsQjObreLZ60SzXrglHJ45RY48h45Cwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFnKEMKSXPw3KAKId8GHqziZ4mRP0BE4JKlTJ1YysW3xonUo8CS2arXUeU4rpe3Gq9TbcfcONjyp7IB3B22/eGkNgzbdKRw62SDZAcfdaffL/j9fzEuK7VX+HogFfCr9ePY2K4fQ5bzmTzUIYmB0SA+YHDieutvbOhqLnNuBcvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=YUU0fwkn; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="YUU0fwkn"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dDvHT5vVlz109W;
	Sun, 23 Nov 2025 18:17:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763914646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrweDQrMqU9GZJoIaqqcUl2Q80bK4o8ww3IM4X8YvJs=;
	b=YUU0fwkn5RVvVoaFYz5g85ocdISToMFYDl5SSDg2s4aGPfoXmFLo9Jo0xkClKY8Rzo79xi
	NmRSbN88lLHxtzVxGLOr6Pv6XkY3WW0AsOgVE11ktO/8poFb2bhhtOj7HT4fVwx6JNxbmg
	/EYDU68Xy4ChvVR422cPuhZt+RsYvBQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763914646;
	b=SOpFnUKdkApHpMfF0eBjPc+lVjfVMBtUaYXgIV61C07GRVpZFojwVz1LnLJp8CzSFJRmBT
	RkSHPMf8YpVAWybDzsckmkdwhbAd5AD8emcTGmcbLmgc5OrqVXnEnsC9bOBebHZOij9AYP
	zptL3p5MZF6BPXcDpkFviIFBD+h10kE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763914646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrweDQrMqU9GZJoIaqqcUl2Q80bK4o8ww3IM4X8YvJs=;
	b=x0V8Q3wOAUwtUSMyDEjxHZ+pREL2ug9zc8FqtmKRqmbMIY1p+0Er5H0CMq5qn0Bq58d5eV
	6tMguFjTGZ8yZqt0NW4KWqqUmpGvOtXi2/p1lJ3tRyja9hG31eHp7bIXgLIBDWG/Met4nT
	d/149DVWxWQ3wjZ6IOmLsIx2jctY748=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 05/10] shared/gmap: add GMAP Service
Date: Sun, 23 Nov 2025 18:17:10 +0200
Message-ID: <c70cfec5c1feecd3845acb45459c0467f7ba4503.1763914558.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1763914558.git.pav@iki.fi>
References: <cover.1763914558.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GMAP Service is just a simple service with bitmasks.

The values can be used to figure out which GMAP roles and features the
remote device claims it supports (matters for available mandatory
features).  Also can advertise the same for remote clients.
---
 Makefile.am          |   1 +
 lib/bluetooth/uuid.h |   8 +
 src/shared/gmap.c    | 402 +++++++++++++++++++++++++++++++++++++++++++
 src/shared/gmap.h    |  70 ++++++++
 4 files changed, 481 insertions(+)
 create mode 100644 src/shared/gmap.c
 create mode 100644 src/shared/gmap.h

diff --git a/Makefile.am b/Makefile.am
index 11e632c02..14dccafaf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -243,6 +243,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/bass.h src/shared/bass.c \
 			src/shared/ccp.h src/shared/ccp.c \
 			src/shared/tmap.c src/shared/tmap.h \
+			src/shared/gmap.c src/shared/gmap.h \
 			src/shared/lc3.h src/shared/tty.h \
 			src/shared/bap-defs.h \
 			src/shared/asha.h src/shared/asha.c \
diff --git a/lib/bluetooth/uuid.h b/lib/bluetooth/uuid.h
index 771f7675d..82e948a23 100644
--- a/lib/bluetooth/uuid.h
+++ b/lib/bluetooth/uuid.h
@@ -216,6 +216,14 @@ extern "C" {
 #define TMAS_UUID				0x1855
 #define TMAP_ROLE_CHRC_UUID			0x2b51
 
+/* Gaming Audio Service */
+#define GMAS_UUID				0x1858
+#define GMAP_ROLE_CHRC_UUID			0x2c00
+#define GMAP_UGG_CHRC_UUID			0x2c01
+#define GMAP_UGT_CHRC_UUID			0x2c02
+#define GMAP_BGS_CHRC_UUID			0x2c03
+#define GMAP_BGR_CHRC_UUID			0x2c04
+
 /* Coordinated Set Identification Profile(CSIP) */
 #define CSIS_UUID					0x1846
 #define CS_SIRK						0x2B84
diff --git a/src/shared/gmap.c b/src/shared/gmap.c
new file mode 100644
index 000000000..f604147c9
--- /dev/null
+++ b/src/shared/gmap.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025	Pauli Virtanen. All rights reserved.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <inttypes.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
+
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+#include "src/shared/timeout.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/gmap.h"
+#include "src/shared/bap.h"
+
+#define DBG(_gmap, fmt, arg...) \
+	gmap_debug(_gmap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
+
+struct bt_gmas_attr {
+	struct bt_gmap *gmap;
+	const char *name;
+	struct gatt_db_attribute *attr;
+	uint8_t value;
+};
+
+struct bt_gmas_db {
+	struct gatt_db *db;
+	struct gatt_db_attribute *service;
+	struct bt_gmas_attr role;
+	struct bt_gmas_attr ugg;
+	struct bt_gmas_attr ugt;
+	struct bt_gmas_attr bgs;
+	struct bt_gmas_attr bgr;
+};
+
+struct bt_gmap {
+	int ref_count;
+	struct bt_gatt_client *client;
+	struct bt_gmas_db db;
+
+	int idle_id;
+	bt_gmap_ready_func_t ready_func;
+	void *ready_data;
+
+	bt_gmap_debug_func_t debug_func;
+	bt_gmap_destroy_func_t debug_destroy;
+	void *debug_data;
+};
+
+static struct queue *instances;
+
+static void gmap_free(void *data)
+{
+	struct bt_gmap *gmap = data;
+
+	if (gmap->client) {
+		bt_gatt_client_idle_unregister(gmap->client, gmap->idle_id);
+		bt_gatt_client_unref(gmap->client);
+	} else {
+		gatt_db_remove_service(gmap->db.db, gmap->db.service);
+		gatt_db_unref(gmap->db.db);
+	}
+
+	queue_remove(instances, gmap);
+	if (queue_isempty(instances)) {
+		queue_destroy(instances, NULL);
+		instances = NULL;
+	}
+
+	free(gmap);
+}
+
+struct bt_gmap *bt_gmap_ref(struct bt_gmap *gmap)
+{
+	if (!gmap)
+		return NULL;
+
+	__sync_fetch_and_add(&gmap->ref_count, 1);
+
+	return gmap;
+}
+
+void bt_gmap_unref(struct bt_gmap *gmap)
+{
+	if (!gmap)
+		return;
+
+	if (__sync_sub_and_fetch(&gmap->ref_count, 1))
+		return;
+
+	gmap_free(gmap);
+}
+
+static void gmap_debug(struct bt_gmap *gmap, const char *format, ...)
+{
+	va_list ap;
+
+	if (!gmap || !format || !gmap->debug_func)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(gmap->debug_func, gmap->debug_data, format, ap);
+	va_end(ap);
+}
+
+bool bt_gmap_set_debug(struct bt_gmap *gmap, bt_gmap_debug_func_t cb,
+		void *user_data, bt_gmap_destroy_func_t destroy)
+{
+	if (!gmap)
+		return false;
+
+	if (gmap->debug_destroy)
+		gmap->debug_destroy(gmap->debug_data);
+
+	gmap->debug_func = cb;
+	gmap->debug_destroy = destroy;
+	gmap->debug_data = user_data;
+
+	return true;
+}
+
+uint8_t bt_gmap_get_role(struct bt_gmap *gmap)
+{
+	if (!gmap)
+		return 0;
+
+	return gmap->db.role.value & BT_GMAP_ROLE_MASK;
+}
+
+uint32_t bt_gmap_get_features(struct bt_gmap *gmap)
+{
+	if (!gmap)
+		return 0;
+
+	return (((uint32_t)gmap->db.ugg.value << BT_GMAP_UGG_FEATURE_SHIFT) |
+		((uint32_t)gmap->db.ugt.value << BT_GMAP_UGT_FEATURE_SHIFT) |
+		((uint32_t)gmap->db.bgs.value << BT_GMAP_BGS_FEATURE_SHIFT) |
+		((uint32_t)gmap->db.bgr.value << BT_GMAP_BGR_FEATURE_SHIFT)) &
+		BT_GMAP_FEATURE_MASK;
+}
+
+/*
+ * GMA Client
+ */
+
+static void gmap_attr_read(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	struct bt_gmas_attr *attr = user_data;
+	struct bt_gmap *gmap = attr->gmap;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	uint8_t v;
+
+	if (!success) {
+		DBG(gmap, "Unable to read %s: error 0x%02x",
+							attr->name, att_ecode);
+		return;
+	}
+
+	if (!util_iov_pull_u8(&iov, &v)) {
+		DBG(gmap, "Invalid %s", attr->name);
+		return;
+	}
+
+	DBG(gmap, "%s Value 0x%x", attr->name, v);
+	attr->value = v;
+}
+
+static void foreach_gmap_char(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct bt_gmap *gmap = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid, uuid_attr;
+	struct {
+		const uint32_t uuid;
+		struct bt_gmas_attr *attr;
+		const char *name;
+	} attrs[] = {
+		{ GMAP_ROLE_CHRC_UUID, &gmap->db.role, "Role" },
+		{ GMAP_UGG_CHRC_UUID, &gmap->db.ugg, "UGG Features" },
+		{ GMAP_UGT_CHRC_UUID, &gmap->db.ugt, "UGT Features" },
+		{ GMAP_BGS_CHRC_UUID, &gmap->db.bgs, "BGS Features" },
+		{ GMAP_BGR_CHRC_UUID, &gmap->db.bgr, "BGR Features" },
+	};
+	unsigned int i;
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
+						NULL, NULL, &uuid))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(attrs); ++i) {
+		bt_uuid16_create(&uuid_attr, attrs[i].uuid);
+		if (bt_uuid_cmp(&uuid, &uuid_attr))
+			continue;
+
+		attrs[i].attr->gmap = gmap;
+		attrs[i].attr->name = attrs[i].name;
+
+		DBG(gmap, "GMAS %s Char found: handle 0x%04x",
+			attrs[i].name, value_handle);
+		bt_gatt_client_read_value(gmap->client, value_handle,
+					gmap_attr_read, attrs[i].attr,
+					NULL);
+		return;
+	}
+}
+
+static void foreach_gmap_service(struct gatt_db_attribute *attr,
+						void *user_data)
+{
+	struct bt_gmap *gmap = user_data;
+
+	gatt_db_service_set_claimed(attr, true);
+	gatt_db_service_foreach_char(attr, foreach_gmap_char, gmap);
+}
+
+static void gmap_idle(void *data)
+{
+	struct bt_gmap *gmap = data;
+
+	gmap->idle_id = 0;
+
+	if (!instances)
+		instances = queue_new();
+	queue_push_tail(instances, gmap);
+
+	if (gmap->ready_func)
+		gmap->ready_func(gmap, gmap->ready_data);
+}
+
+struct bt_gmap *bt_gmap_attach(struct bt_gatt_client *client,
+				bt_gmap_ready_func_t ready, void *user_data)
+{
+	struct bt_gmap *gmap;
+	bt_uuid_t uuid;
+
+	if (!client)
+		return NULL;
+
+	client = bt_gatt_client_clone(client);
+	if (!client)
+		return NULL;
+
+	gmap = new0(struct bt_gmap, 1);
+	gmap->client = client;
+	gmap->ready_func = ready;
+	gmap->ready_data = user_data;
+	gmap->db.db = bt_gatt_client_get_db(gmap->client);
+
+	bt_uuid16_create(&uuid, GMAS_UUID);
+	gatt_db_foreach_service(gmap->db.db, &uuid, foreach_gmap_service, gmap);
+
+	gmap->idle_id = bt_gatt_client_idle_register(gmap->client, gmap_idle,
+								gmap, NULL);
+
+	return bt_gmap_ref(gmap);
+}
+
+/*
+ * GMAS Service
+ */
+
+static void gmas_attr_read(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct bt_gmas_attr *attr = user_data;
+	struct iovec iov = {
+		.iov_base = &attr->value,
+		.iov_len = sizeof(attr->value)
+	};
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
+							iov.iov_len);
+}
+
+static bool match_db(const void *data, const void *match_data)
+{
+	const struct bt_gmap *gmap = data;
+
+	return gmap->db.db == match_data;
+}
+
+struct bt_gmap *bt_gmap_find(struct gatt_db *db)
+{
+	return db ? queue_find(instances, match_db, db) : NULL;
+}
+
+static void gmap_update_chrc(struct bt_gmap *gmap)
+{
+	struct {
+		const uint32_t uuid;
+		uint8_t role;
+		struct bt_gmas_attr *attr;
+		const char *name;
+	} attrs[] = {
+		{ GMAP_ROLE_CHRC_UUID, 0, &gmap->db.role, "Role" },
+		{ GMAP_UGG_CHRC_UUID, BT_GMAP_ROLE_UGG, &gmap->db.ugg,
+							"UGG Features" },
+		{ GMAP_UGT_CHRC_UUID, BT_GMAP_ROLE_UGT, &gmap->db.ugt,
+							"UGT Features" },
+		{ GMAP_BGS_CHRC_UUID, BT_GMAP_ROLE_BGS, &gmap->db.bgs,
+							"BGS Features" },
+		{ GMAP_BGR_CHRC_UUID, BT_GMAP_ROLE_BGR, &gmap->db.bgr,
+							"BGR Features" },
+	};
+	unsigned int i;
+	bt_uuid_t uuid;
+
+	for (i = 0; i < ARRAY_SIZE(attrs); ++i) {
+		if (attrs[i].attr->attr)
+			continue;
+
+		attrs[i].attr->gmap = gmap;
+		attrs[i].attr->name = attrs[i].name;
+
+		if (attrs[i].role && !(gmap->db.role.value & attrs[i].role))
+			continue;
+
+		bt_uuid16_create(&uuid, attrs[i].uuid);
+		attrs[i].attr->attr = gatt_db_service_add_characteristic(
+					gmap->db.service,
+					&uuid,
+					BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ,
+					gmas_attr_read, NULL,
+					attrs[i].attr);
+		gatt_db_attribute_set_fixed_length(attrs[i].attr->attr, 1);
+	}
+}
+
+struct bt_gmap *bt_gmap_add_db(struct gatt_db *db)
+{
+	struct bt_gmap *gmap;
+	bt_uuid_t uuid;
+
+	if (!db || queue_find(instances, match_db, db))
+		return NULL;
+
+	gmap = new0(struct bt_gmap, 1);
+	gmap->db.db = gatt_db_ref(db);
+
+	bt_uuid16_create(&uuid, GMAS_UUID);
+	gmap->db.service = gatt_db_add_service(db, &uuid, true, 5*3);
+
+	if (!instances)
+		instances = queue_new();
+	queue_push_tail(instances, gmap);
+
+	return bt_gmap_ref(gmap);
+}
+
+void bt_gmap_set_role(struct bt_gmap *gmap, uint8_t role)
+{
+	if (gmap->client)
+		return;
+
+	gmap->db.role.value = role & BT_GMAP_ROLE_MASK;
+
+	gmap_update_chrc(gmap);
+
+	/* Expose values only when first set */
+	gatt_db_service_set_active(gmap->db.service, true);
+}
+
+
+void bt_gmap_set_features(struct bt_gmap *gmap, uint32_t features)
+{
+	if (gmap->client)
+		return;
+
+	gmap->db.ugg.value = (features & BT_GMAP_UGG_FEATURE_MASK)
+						>> BT_GMAP_UGG_FEATURE_SHIFT;
+	gmap->db.ugt.value = (features & BT_GMAP_UGT_FEATURE_MASK)
+						>> BT_GMAP_UGT_FEATURE_SHIFT;
+	gmap->db.bgs.value = (features & BT_GMAP_BGS_FEATURE_MASK)
+						>> BT_GMAP_BGS_FEATURE_SHIFT;
+	gmap->db.bgr.value = (features & BT_GMAP_BGR_FEATURE_MASK)
+						>> BT_GMAP_BGR_FEATURE_SHIFT;
+
+	gmap_update_chrc(gmap);
+
+	/* Expose values only when first set */
+	gatt_db_service_set_active(gmap->db.service, true);
+}
diff --git a/src/shared/gmap.h b/src/shared/gmap.h
new file mode 100644
index 000000000..ef7d96e0a
--- /dev/null
+++ b/src/shared/gmap.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025  Pauli Virtanen. All rights reserved.
+ *
+ */
+
+#include <stdbool.h>
+#include <inttypes.h>
+
+#define BT_GMAP_ROLE_UGG		BIT(0)
+#define BT_GMAP_ROLE_UGT		BIT(1)
+#define BT_GMAP_ROLE_BGS		BIT(2)
+#define BT_GMAP_ROLE_BGR		BIT(3)
+#define BT_GMAP_ROLE_MASK		(BIT(4) - 1)
+
+#define BT_GMAP_UGG_MULTIPLEX		(BIT(0) << 0)
+#define BT_GMAP_UGG_96KBPS		(BIT(1) << 0)
+#define BT_GMAP_UGG_MULTISINK		(BIT(2) << 0)
+#define BT_GMAP_UGG_FEATURE_MASK	((BIT(3) - 1) << 0)
+#define BT_GMAP_UGG_FEATURE_SHIFT	0
+
+#define BT_GMAP_UGT_SOURCE		(BIT(0) << 8)
+#define BT_GMAP_UGT_80KBPS_SOURCE	(BIT(1) << 8)
+#define BT_GMAP_UGT_SINK		(BIT(2) << 8)
+#define BT_GMAP_UGT_64KBPS_SINK		(BIT(3) << 8)
+#define BT_GMAP_UGT_MULTIPLEX		(BIT(4) << 8)
+#define BT_GMAP_UGT_MULTISINK		(BIT(5) << 8)
+#define BT_GMAP_UGT_MULTISOURCE		(BIT(6) << 8)
+#define BT_GMAP_UGT_FEATURE_MASK	((BIT(7) - 1) << 8)
+#define BT_GMAP_UGT_FEATURE_SHIFT	8
+
+#define BT_GMAP_BGS_96KBPS		(BIT(0) << 16)
+#define BT_GMAP_BGS_FEATURE_MASK	((BIT(1) - 1) << 16)
+#define BT_GMAP_BGS_FEATURE_SHIFT	16
+
+#define BT_GMAP_BGR_MULTISINK		(BIT(0) << 24)
+#define BT_GMAP_BGR_MULTIPLEX		(BIT(1) << 24)
+#define BT_GMAP_BGR_FEATURE_MASK	((BIT(2) - 1) << 24)
+#define BT_GMAP_BGR_FEATURE_SHIFT	24
+
+#define BT_GMAP_FEATURE_MASK		(BT_GMAP_UGG_FEATURE_MASK | \
+					BT_GMAP_UGT_FEATURE_MASK | \
+					BT_GMAP_BGS_FEATURE_MASK | \
+					BT_GMAP_BGR_FEATURE_MASK)
+
+struct bt_gmap;
+
+typedef void (*bt_gmap_ready_func_t)(struct bt_gmap *gmap, void *user_data);
+typedef void (*bt_gmap_destroy_func_t)(void *user_data);
+typedef void (*bt_gmap_debug_func_t)(const char *str, void *user_data);
+
+struct bt_gmap *bt_gmap_ref(struct bt_gmap *gmap);
+void bt_gmap_unref(struct bt_gmap *gmap);
+
+struct bt_gmap *bt_gmap_attach(struct bt_gatt_client *client,
+				bt_gmap_ready_func_t ready, void *user_data);
+struct bt_gmap *bt_gmap_find(struct gatt_db *db);
+struct bt_gmap *bt_gmap_add_db(struct gatt_db *db);
+
+uint8_t bt_gmap_get_role(struct bt_gmap *gmap);
+uint32_t bt_gmap_get_features(struct bt_gmap *gmap);
+
+void bt_gmap_set_role(struct bt_gmap *gmas, uint8_t role);
+void bt_gmap_set_features(struct bt_gmap *gmas, uint32_t features);
+
+bool bt_gmap_set_debug(struct bt_gmap *gmap, bt_gmap_debug_func_t cb,
+			void *user_data, bt_gmap_destroy_func_t destroy);
-- 
2.51.1

