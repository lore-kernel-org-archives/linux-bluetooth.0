Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4B8479
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763914652; cv=pass; b=Yla5sl64Mqgyimliel2kYbKT+6IlWvtxpcTs86nnICsoIOxMH9mGINHQ4ADhWilaT8BHQaQd6CXns2k6gJRGLmKBjGP8UO6hRsM80uigidMU4rtsZmWYi6UXftcY4t67+srbBPsx4ahTLdRUBcY5bjjeRmEzbcjI9FsZm6kDWkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763914652; c=relaxed/simple;
	bh=94UsmdCBGyr2KESbaE0h9mv4g+D4NJUgYWSsuUAumxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPUijJLxUMYKFzy5X7R59jJqlMKotYrtAoTr20YBGicG7tBNDt8vyALOWg/CNicoCIXLN+QiDHdkOsvb+0+wzcJ53+rSniONDQtitRMegmA96E5taa5D11tvL1ynt2QYmaDtb7zont2mBaWECQ5V4xpFuceCTWZCiC/kt0QeKpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=fexH7QZx; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="fexH7QZx"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dDvHP06VhzyWZ;
	Sun, 23 Nov 2025 18:17:20 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763914641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ORlV+CI3J6pfFZTB7kbPQZUTnQWPlX3Meik89W83dA=;
	b=fexH7QZxVI8aW4QcAHO8A2kXs8VXFl4BlKmxKHR/A2xFbw3hoGNP36s7tqeKF4chfTwJXq
	rM9E7ou69o9Aiz+LRoiUE198tBvZ0mLjQiIWcxr3WsKKzxpRxCNGAtGAcgP5LjgUsvvRTr
	BE99q46xdLxcvUjOjaAVTeRyJM/OPEQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763914641;
	b=HRUWZeNq72n41XjgZ4uMPMTdGks6YNmUHD1e/8B5fhp+V3y1ym8ILTcha+kKxqh1SWkk7l
	77unvhddb8JJSungUfS84D1FTjyf3+nGv0eTWudwFJo17EKkHmFJ/7Xr5wDqRtmfVTOBvg
	eerDbOe/WgCVlx38kga59mqvwwkI4+I=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763914641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ORlV+CI3J6pfFZTB7kbPQZUTnQWPlX3Meik89W83dA=;
	b=P+KJPF2FKvElrvW0uh1JnHHsH8Ybw1PDJXtCqRvOLbcTQ1ZmW/yzpCAFzQ7mpJNUG9YINv
	5cpoCqnLJmoHyEfvKLzYJMpYmIUypuwkZFbTsYH5zQUkTN8F6pq/3dbLalDQsP3lhwN7Md
	lrujPch+ei6yU2KWjbLvIFjQjRu+Wxw=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 01/10] shared/tmap: add TMAP Service
Date: Sun, 23 Nov 2025 18:17:06 +0200
Message-ID: <f8714ae4192d4f2e745ddd8e76eca552d505dcf6.1763914558.git.pav@iki.fi>
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

TMAP Service is just a simple service with a Role bitmask.

The value can be used to figure out which TMAP roles the remote device
claims it supports (matters for available mandatory features).  Also can
advertise the same for remote clients.
---
 Makefile.am          |   1 +
 lib/bluetooth/uuid.h |   4 +
 src/shared/tmap.c    | 302 +++++++++++++++++++++++++++++++++++++++++++
 src/shared/tmap.h    |  39 ++++++
 4 files changed, 346 insertions(+)
 create mode 100644 src/shared/tmap.c
 create mode 100644 src/shared/tmap.h

diff --git a/Makefile.am b/Makefile.am
index 9f06d60e6..d2e67012d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -242,6 +242,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/csip.c src/shared/csip.h \
 			src/shared/bass.h src/shared/bass.c \
 			src/shared/ccp.h src/shared/ccp.c \
+			src/shared/tmap.c src/shared/tmap.h \
 			src/shared/lc3.h src/shared/tty.h \
 			src/shared/bap-defs.h \
 			src/shared/asha.h src/shared/asha.c \
diff --git a/lib/bluetooth/uuid.h b/lib/bluetooth/uuid.h
index 479986f06..771f7675d 100644
--- a/lib/bluetooth/uuid.h
+++ b/lib/bluetooth/uuid.h
@@ -212,6 +212,10 @@ extern "C" {
 #define MEDIA_CP_OP_SUPPORTED_CHRC_UUID         0x2ba5
 #define MEDIA_CONTENT_CONTROL_ID_CHRC_UUID      0x2bba
 
+/* Telephony and Media Audio Service */
+#define TMAS_UUID				0x1855
+#define TMAP_ROLE_CHRC_UUID			0x2b51
+
 /* Coordinated Set Identification Profile(CSIP) */
 #define CSIS_UUID					0x1846
 #define CS_SIRK						0x2B84
diff --git a/src/shared/tmap.c b/src/shared/tmap.c
new file mode 100644
index 000000000..6fc96cd89
--- /dev/null
+++ b/src/shared/tmap.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025  Pauli Virtanen. All rights reserved.
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
+#include "src/shared/tmap.h"
+#include "src/shared/bap.h"
+
+#define DBG(_tmap, fmt, arg...) \
+	tmap_debug(_tmap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
+
+struct bt_tmas_db {
+	struct gatt_db *db;
+	struct gatt_db_attribute *service;
+	struct gatt_db_attribute *role;
+	uint16_t role_value;
+};
+
+struct bt_tmap {
+	int ref_count;
+	struct bt_gatt_client *client;
+	struct bt_tmas_db db;
+
+	int idle_id;
+	bt_tmap_ready_func_t ready_func;
+	void *ready_data;
+
+	bt_tmap_debug_func_t debug_func;
+	bt_tmap_destroy_func_t debug_destroy;
+	void *debug_data;
+};
+
+static struct queue *instances;
+
+static void tmap_free(void *data)
+{
+	struct bt_tmap *tmap = data;
+
+	if (tmap->client) {
+		bt_gatt_client_idle_unregister(tmap->client, tmap->idle_id);
+		bt_gatt_client_unref(tmap->client);
+	} else {
+		gatt_db_remove_service(tmap->db.db, tmap->db.service);
+		gatt_db_unref(tmap->db.db);
+	}
+
+	queue_remove(instances, tmap);
+	if (queue_isempty(instances)) {
+		queue_destroy(instances, NULL);
+		instances = NULL;
+	}
+
+	free(tmap);
+}
+
+struct bt_tmap *bt_tmap_ref(struct bt_tmap *tmap)
+{
+	if (!tmap)
+		return NULL;
+
+	__sync_fetch_and_add(&tmap->ref_count, 1);
+
+	return tmap;
+}
+
+void bt_tmap_unref(struct bt_tmap *tmap)
+{
+	if (!tmap)
+		return;
+
+	if (__sync_sub_and_fetch(&tmap->ref_count, 1))
+		return;
+
+	tmap_free(tmap);
+}
+
+static void tmap_debug(struct bt_tmap *tmap, const char *format, ...)
+{
+	va_list ap;
+
+	if (!tmap || !format || !tmap->debug_func)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(tmap->debug_func, tmap->debug_data, format, ap);
+	va_end(ap);
+}
+
+bool bt_tmap_set_debug(struct bt_tmap *tmap, bt_tmap_debug_func_t cb,
+		void *user_data, bt_tmap_destroy_func_t destroy)
+{
+	if (!tmap)
+		return false;
+
+	if (tmap->debug_destroy)
+		tmap->debug_destroy(tmap->debug_data);
+
+	tmap->debug_func = cb;
+	tmap->debug_destroy = destroy;
+	tmap->debug_data = user_data;
+
+	return true;
+}
+
+uint16_t bt_tmap_get_role(struct bt_tmap *tmap)
+{
+	if (!tmap)
+		return 0;
+
+	return tmap->db.role_value;
+}
+
+/*
+ * TMA Client
+ */
+
+static void tmap_role_read(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	struct bt_tmap *tmap = user_data;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	uint16_t role;
+
+	if (!success) {
+		DBG(tmap, "Unable to read Role: error 0x%02x", att_ecode);
+		return;
+	}
+
+	if (!util_iov_pull_le16(&iov, &role)) {
+		DBG(tmap, "Invalid Role");
+		return;
+	}
+
+	DBG(tmap, "Role 0x%x", role);
+	tmap->db.role_value = role & BT_TMAP_ROLE_MASK;
+}
+
+static void foreach_tmap_char(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct bt_tmap *tmap = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid, uuid_role;
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
+						NULL, NULL, &uuid))
+		return;
+
+	bt_uuid16_create(&uuid_role, TMAP_ROLE_CHRC_UUID);
+
+	if (!bt_uuid_cmp(&uuid, &uuid_role)) {
+		DBG(tmap, "TMAS Role Char found: handle 0x%04x", value_handle);
+		bt_gatt_client_read_value(tmap->client, value_handle,
+					tmap_role_read, tmap, NULL);
+		return;
+	}
+}
+
+static void foreach_tmap_service(struct gatt_db_attribute *attr,
+						void *user_data)
+{
+	struct bt_tmap *tmap = user_data;
+
+	gatt_db_service_set_claimed(attr, true);
+	gatt_db_service_foreach_char(attr, foreach_tmap_char, tmap);
+}
+
+static void tmap_idle(void *data)
+{
+	struct bt_tmap *tmap = data;
+
+	tmap->idle_id = 0;
+
+	if (!instances)
+		instances = queue_new();
+	queue_push_tail(instances, tmap);
+
+	if (tmap->ready_func)
+		tmap->ready_func(tmap, tmap->ready_data);
+}
+
+struct bt_tmap *bt_tmap_attach(struct bt_gatt_client *client,
+				bt_tmap_ready_func_t ready, void *user_data)
+{
+	struct bt_tmap *tmap;
+	bt_uuid_t uuid;
+
+	if (!client)
+		return NULL;
+
+	client = bt_gatt_client_clone(client);
+	if (!client)
+		return NULL;
+
+	tmap = new0(struct bt_tmap, 1);
+	tmap->client = client;
+	tmap->ready_func = ready;
+	tmap->ready_data = user_data;
+	tmap->db.db = bt_gatt_client_get_db(tmap->client);
+
+	bt_uuid16_create(&uuid, TMAS_UUID);
+	gatt_db_foreach_service(tmap->db.db, &uuid, foreach_tmap_service, tmap);
+
+	tmap->idle_id = bt_gatt_client_idle_register(tmap->client, tmap_idle,
+								tmap, NULL);
+
+	return bt_tmap_ref(tmap);
+}
+
+/*
+ * TMAS Service
+ */
+
+static void tmas_role_read(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct bt_tmas_db *db = user_data;
+	struct iovec iov = {
+		.iov_base = &db->role_value,
+		.iov_len = sizeof(db->role_value)
+	};
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
+							iov.iov_len);
+}
+
+static bool match_db(const void *data, const void *match_data)
+{
+	const struct bt_tmap *tmap = data;
+
+	return tmap->db.db == match_data;
+}
+
+struct bt_tmap *bt_tmap_find(struct gatt_db *db)
+{
+	return db ? queue_find(instances, match_db, db) : NULL;
+}
+
+struct bt_tmap *bt_tmap_add_db(struct gatt_db *db)
+{
+	struct bt_tmap *tmap;
+	bt_uuid_t uuid;
+
+	if (!db || queue_find(instances, match_db, db))
+		return NULL;
+
+	tmap = new0(struct bt_tmap, 1);
+	tmap->db.db = gatt_db_ref(db);
+
+	bt_uuid16_create(&uuid, TMAS_UUID);
+	tmap->db.service = gatt_db_add_service(db, &uuid, true, 3);
+
+	bt_uuid16_create(&uuid, TMAP_ROLE_CHRC_UUID);
+	tmap->db.role = gatt_db_service_add_characteristic(
+					tmap->db.service,
+					&uuid,
+					BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ,
+					tmas_role_read, NULL,
+					&tmap->db);
+
+	if (!instances)
+		instances = queue_new();
+	queue_push_tail(instances, tmap);
+
+	return bt_tmap_ref(tmap);
+}
+
+void bt_tmap_set_role(struct bt_tmap *tmap, uint16_t role)
+{
+	if (tmap->client)
+		return;
+
+	tmap->db.role_value = role & BT_TMAP_ROLE_MASK;
+
+	/* Expose value only when first set. Role does not have Notify. */
+	gatt_db_service_set_active(tmap->db.service, true);
+}
diff --git a/src/shared/tmap.h b/src/shared/tmap.h
new file mode 100644
index 000000000..9d872f0b6
--- /dev/null
+++ b/src/shared/tmap.h
@@ -0,0 +1,39 @@
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
+#define BT_TMAP_ROLE_CG			BIT(0)
+#define BT_TMAP_ROLE_CT			BIT(1)
+#define BT_TMAP_ROLE_UMS		BIT(2)
+#define BT_TMAP_ROLE_UMR		BIT(3)
+#define BT_TMAP_ROLE_BMS		BIT(4)
+#define BT_TMAP_ROLE_BMR		BIT(5)
+#define BT_TMAP_ROLE_MASK		(BIT(6) - 1)
+
+struct bt_tmap;
+
+typedef void (*bt_tmap_ready_func_t)(struct bt_tmap *tmap, void *user_data);
+typedef void (*bt_tmap_destroy_func_t)(void *user_data);
+typedef void (*bt_tmap_debug_func_t)(const char *str, void *user_data);
+
+struct bt_tmap *bt_tmap_ref(struct bt_tmap *tmap);
+void bt_tmap_unref(struct bt_tmap *tmap);
+
+struct bt_tmap *bt_tmap_attach(struct bt_gatt_client *client,
+			bt_tmap_ready_func_t ready, void *user_data);
+struct bt_tmap *bt_tmap_find(struct gatt_db *db);
+struct bt_tmap *bt_tmap_add_db(struct gatt_db *db);
+
+uint16_t bt_tmap_get_role(struct bt_tmap *tmap);
+void bt_tmap_set_role(struct bt_tmap *tmas, uint16_t role);
+
+bool bt_tmap_set_debug(struct bt_tmap *tmap, bt_tmap_debug_func_t cb,
+			void *user_data, bt_tmap_destroy_func_t destroy);
-- 
2.51.1

