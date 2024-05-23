Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2B812B72
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479596; cv=none; b=VmsZ5bZqM6u2TubRimcHd5Hwl+4t2gsivQaMNzjV/etVcdML83rX1owoMmQuPLFZdyG8oPxzQUTdASdggiKSt5BTXGYQLe95oaWX3PspzLWlwzbbUhOG7uGXmSrILFjq7nHWEEmf02yiI3g+fCihO8GQxvAr9mYnoEUvTgSQp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479596; c=relaxed/simple;
	bh=mC/Ib/klhjwAnku1/NOg8sp4Tax4jaLgmvSraMPGZkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAETc+N40Y63XR/l5B6WRtmS59ZEWsxdqfvTjWmIhwyzeq36xMTL9gzBzmSSHQ6l4vbduSOYAyBLLgLjjTAUkGK1XSHi+9gBl6MzdAGyivl/ffMiV+V9d3lBiqd9xqBYagF6zLqwmby/0Pz2cX3VAwv7kaT4N7PeTQcPObvpG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=nhkxhoFc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="nhkxhoFc"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59b49162aeso1118530366b.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1716479593; x=1717084393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+mVK5SI67gKGdcBy3wYFUC5wzvjiTCDAcmVaTdZzIo=;
        b=nhkxhoFcgwslu+XawXPOvEb04IoEkv8X85QURNdbvL1Fi0JvEZyrx8euznIoH5glVy
         ewuF4jUnPP/Y5RiD/nOV7BzqAoOIWBQpAwUCYW+YouloYAoy+IEPh05JgxAcy9olsguC
         rYM6NAdayGF2Nda+nwxGTAkChaNSq+v32mSlCUZg8/o0YnlPPSjP45Zs1D5zB/l3h6Jk
         ugikp/lUo+B82/VqbL62XajNN/eJDL/LbEb42REiIbTUlA6MwEwTc02DmvBXOExXyzdB
         xCUzZUEDu6qgWtpWsT4xh617uijGn8gTdYWigdPfflYNaPe/UMEndOF//u+/x93wyCAv
         f6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479593; x=1717084393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+mVK5SI67gKGdcBy3wYFUC5wzvjiTCDAcmVaTdZzIo=;
        b=fXnXO5tTU0SOgNbOKPgoV2tXzZuvHSVwO/Ak4QJJ/MRKCVVo4neSbh0RsHGDLvnpVD
         3/+nSaIuDs0CrkuEOcgW3wbRR8wk/V1O3C5b2urknQtit8maeACw+dsXwiGR7aquM+Mb
         ZOM0EEwv1eeMz7dDhDwq/3AECeMJY4q46xiKZwdWOzlnA3prMn6a2mfDaiEymVcUcgem
         F+f2n+y+7pnJEkRxBKpTNJJ9t0KFOs4fjuBFBqFg8qy6jMJ8RG7MOW2k6vBb6vSPaEdH
         gAAdE9IJMMZBUCJKrHGLA9KCTjZW/K3dsG/i+GlA3VtFM254fqwnf2WZ72fDdzy8vygZ
         kyTg==
X-Gm-Message-State: AOJu0YxYlR82q90O8+CY1j4XTUS+LbQyPxk63OTBQH7H/eprV8+FSv7W
	0h/Azezm2DUnaipFcluNfinkggdqLLttinANdtm2eTrnW+6n/T+9eAVxYLuOnltc+19gIQ0atVu
	f
X-Google-Smtp-Source: AGHT+IGA7IHKmzU8DRSYfWHA8xM9WP+GnuWRXCjbOfrY+xBcV7nWYOzV22Hae/+Bpj2TeHughd5QfA==
X-Received: by 2002:a17:907:1749:b0:a61:c730:ac57 with SMTP id a640c23a62f3a-a622818fb09mr395517966b.74.1716479592583;
        Thu, 23 May 2024 08:53:12 -0700 (PDT)
Received: from andromeda.llama-bortle.ts.net (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c686sm1947600566b.47.2024.05.23.08.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:53:11 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v8 1/5] src/shared: Add initial implementation for an ASHA profile
Date: Thu, 23 May 2024 11:52:57 -0400
Message-ID: <20240523155301.140522-2-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523155301.140522-1-arun@asymptotic.io>
References: <20240523155301.140522-1-arun@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements the server role for the Audio Streaming for Hearing Aid
specification[1]. Includes basic ability to probe the ASHA GATT service,
as well as starting/stopping streaming.

[1] https://source.android.com/docs/core/connect/bluetooth/asha
---
 Makefile.am       |   3 +-
 lib/uuid.h        |   3 +
 src/shared/asha.c | 368 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/asha.h |  64 ++++++++
 4 files changed, 437 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/asha.c
 create mode 100644 src/shared/asha.h

diff --git a/Makefile.am b/Makefile.am
index 05d02932f..3e6610017 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -238,7 +238,8 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/bass.h src/shared/bass.c \
 			src/shared/ccp.h src/shared/ccp.c \
 			src/shared/lc3.h src/shared/tty.h \
-			src/shared/bap-defs.h
+			src/shared/bap-defs.h \
+			src/shared/asha.h src/shared/asha.c
 
 if READLINE
 shared_sources += src/shared/shell.c src/shared/shell.h
diff --git a/lib/uuid.h b/lib/uuid.h
index 8404b287e..479986f06 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -163,6 +163,9 @@ extern "C" {
 #define BAA_SERVICE					0x1851
 #define BAA_SERVICE_UUID	"00001851-0000-1000-8000-00805f9b34fb"
 
+#define ASHA_SERVICE					0xFDF0
+#define ASHA_PROFILE_UUID	"0000FDF0-0000-1000-8000-00805f9b34fb"
+
 #define PAC_CONTEXT					0x2bcd
 #define PAC_SUPPORTED_CONTEXT				0x2bce
 
diff --git a/src/shared/asha.c b/src/shared/asha.c
new file mode 100644
index 000000000..4817b93cd
--- /dev/null
+++ b/src/shared/asha.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024  Asymptotic Inc.
+ *
+ *  Author: Arun Raghavan <arun@asymptotic.io>
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/log.h"
+
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+
+#include "asha.h"
+
+/* We use strings instead of uint128_t to maintain readability */
+#define ASHA_CHRC_READ_ONLY_PROPERTIES_UUID "6333651e-c481-4a3e-9169-7c902aad37bb"
+#define ASHA_CHRC_AUDIO_CONTROL_POINT_UUID "f0d4de7e-4a88-476c-9d9f-1937b0996cc0"
+#define ASHA_CHRC_AUDIO_STATUS_UUID "38663f1a-e711-4cac-b641-326b56404837"
+#define ASHA_CHRC_VOLUME_UUID "00e4ca9e-ab14-41e4-8823-f9e70c7e91df"
+#define ASHA_CHRC_LE_PSM_OUT_UUID "2d410339-82b6-42aa-b34e-e2e01df8cc1a"
+
+struct bt_asha *bt_asha_new(void)
+{
+	struct bt_asha *asha;
+
+	asha = new0(struct bt_asha, 1);
+
+	return asha;
+}
+
+void bt_asha_reset(struct bt_asha *asha)
+{
+	if (asha->status_notify_id) {
+		bt_gatt_client_unregister_notify(asha->client,
+						asha->status_notify_id);
+	}
+
+	gatt_db_unref(asha->db);
+	asha->db = NULL;
+
+	bt_gatt_client_unref(asha->client);
+	asha->client = NULL;
+
+	asha->psm = 0;
+}
+
+void bt_asha_state_reset(struct bt_asha *asha)
+{
+	asha->state = ASHA_STOPPED;
+	asha->resume_id = 0;
+
+	asha->cb = NULL;
+	asha->cb_user_data = NULL;
+}
+
+void bt_asha_free(struct bt_asha *asha)
+{
+	gatt_db_unref(asha->db);
+	bt_gatt_client_unref(asha->client);
+	free(asha);
+}
+
+static void asha_acp_sent(bool success, uint8_t err, void *user_data)
+{
+	struct bt_asha *asha = user_data;
+
+	if (success) {
+		DBG("AudioControlPoint command successfully sent");
+	} else {
+		error("Failed to send AudioControlPoint command: %d", err);
+
+		if (asha->cb)
+			asha->cb(-1, asha->cb_user_data);
+
+		bt_asha_state_reset(asha);
+	}
+}
+
+static int asha_send_acp(struct bt_asha *asha, uint8_t *cmd,
+		unsigned int len, bt_asha_cb_t cb, void *user_data)
+{
+	if (!bt_gatt_client_write_value(asha->client, asha->acp_handle, cmd,
+				len, asha_acp_sent, asha, NULL)) {
+		error("Error writing ACP start");
+		return -1;
+	}
+
+	asha->cb = cb;
+	asha->cb_user_data = user_data;
+
+	return 0;
+}
+
+unsigned int bt_asha_start(struct bt_asha *asha, bt_asha_cb_t cb,
+								void *user_data)
+{
+	uint8_t acp_start_cmd[] = {
+		0x01,		/* START */
+		0x01,		/* G.722, 16 kHz */
+		0,		/* Unknown media type */
+		asha->volume,	/* Volume */
+		0,		/* Other disconnected */
+	};
+	int ret;
+
+	if (asha->state != ASHA_STOPPED) {
+		error("ASHA device start failed. Bad state %d", asha->state);
+		return 0;
+	}
+
+	ret = asha_send_acp(asha, acp_start_cmd, sizeof(acp_start_cmd), cb,
+			user_data);
+	if (ret < 0)
+		return 0;
+
+	asha->state = ASHA_STARTING;
+
+	return (++asha->resume_id);
+}
+
+unsigned int bt_asha_stop(struct bt_asha *asha, bt_asha_cb_t cb,
+								void *user_data)
+{
+	uint8_t acp_stop_cmd[] = {
+		0x02, /* STOP */
+	};
+	int ret;
+
+	if (asha->state != ASHA_STARTED)
+		return 0;
+
+	asha->state = ASHA_STOPPING;
+
+	ret = asha_send_acp(asha, acp_stop_cmd, sizeof(acp_stop_cmd), cb,
+			user_data);
+	if (ret < 0)
+		return 0;
+
+	return asha->resume_id;
+}
+
+bool bt_asha_set_volume(struct bt_asha *asha, int8_t volume)
+{
+	if (!bt_gatt_client_write_without_response(asha->client,
+						asha->volume_handle, false,
+						(const uint8_t *)&volume, 1)) {
+		error("Error writing volume");
+		return false;
+	}
+
+	asha->volume = volume;
+	return true;
+}
+
+static bool uuid_cmp(const char *uuid1, const bt_uuid_t *uuid2)
+{
+	bt_uuid_t lhs;
+
+	bt_string_to_uuid(&lhs, uuid1);
+
+	return bt_uuid_cmp(&lhs, uuid2) == 0;
+}
+
+static void read_psm(bool success,
+			uint8_t att_ecode,
+			const uint8_t *value,
+			uint16_t length,
+			void *user_data)
+{
+	struct bt_asha *asha = user_data;
+
+	if (!success) {
+		DBG("Reading PSM failed with ATT error: %u", att_ecode);
+		return;
+	}
+
+	if (length != 2) {
+		DBG("Reading PSM failed: unexpected length %u", length);
+		return;
+	}
+
+	asha->psm = get_le16(value);
+
+	DBG("Got PSM: %u", asha->psm);
+}
+
+static void read_rops(bool success,
+			uint8_t att_ecode,
+			const uint8_t *value,
+			uint16_t length,
+			void *user_data)
+{
+	struct bt_asha *asha = user_data;
+
+	if (!success) {
+		DBG("Reading ROPs failed with ATT error: %u", att_ecode);
+		return;
+	}
+
+	if (length != 17) {
+		DBG("Reading ROPs failed: unexpected length %u", length);
+		return;
+	}
+
+	if (value[0] != 0x01) {
+		DBG("Unexpected ASHA version: %u", value[0]);
+		return;
+	}
+
+	/* Device Capabilities */
+	asha->right_side = (value[1] & 0x1) != 0;
+	asha->binaural = (value[1] & 0x2) != 0;
+	asha->csis_supported = (value[1] & 0x4) != 0;
+	/* HiSyncId: 2 byte company id, 6 byte ID shared by left and right */
+	memcpy(asha->hisyncid, &value[2], 8);
+	/* FeatureMap */
+	asha->coc_streaming_supported = (value[10] & 0x1) != 0;
+	/* RenderDelay */
+	asha->render_delay = get_le16(&value[11]);
+	/* byte 13 & 14 are reserved */
+	/* Codec IDs */
+	asha->codec_ids = get_le16(&value[15]);
+
+	DBG("Got ROPS: side %u, binaural %u, csis: %u, delay %u, codecs: %u",
+			asha->right_side, asha->binaural, asha->csis_supported,
+			asha->render_delay, asha->codec_ids);
+}
+
+static void audio_status_register(uint16_t att_ecode, void *user_data)
+{
+	if (att_ecode)
+		DBG("AudioStatusPoint register failed 0x%04x", att_ecode);
+	else
+		DBG("AudioStatusPoint register succeeded");
+}
+
+static void audio_status_notify(uint16_t value_handle, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	struct bt_asha *asha = user_data;
+	uint8_t status = *value;
+	/* Back these up to survive the reset paths */
+	bt_asha_cb_t cb = asha->cb;
+	bt_asha_cb_t cb_user_data = asha->cb_user_data;
+
+	if (asha->state == ASHA_STARTING) {
+		if (status == 0) {
+			asha->state = ASHA_STARTED;
+			DBG("ASHA start complete");
+		} else {
+			bt_asha_state_reset(asha);
+			DBG("ASHA start failed");
+		}
+	} else if (asha->state == ASHA_STOPPING) {
+		/* We reset our state, regardless */
+		bt_asha_state_reset(asha);
+		DBG("ASHA stop %s", status == 0 ? "complete" : "failed");
+	}
+
+	if (cb) {
+		cb(status, cb_user_data);
+		asha->cb = NULL;
+		asha->cb_user_data = NULL;
+	}
+}
+
+static void handle_characteristic(struct gatt_db_attribute *attr,
+								void *user_data)
+{
+	struct bt_asha *asha = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid;
+	char uuid_str[MAX_LEN_UUID_STR];
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NULL,
+								NULL, &uuid)) {
+		error("Failed to obtain characteristic data");
+		return;
+	}
+
+	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+	if (uuid_cmp(ASHA_CHRC_LE_PSM_OUT_UUID, &uuid)) {
+		DBG("Got chrc %s/0x%x: LE_PSM_ID", uuid_str, value_handle);
+		if (!bt_gatt_client_read_value(asha->client, value_handle,
+					read_psm, asha, NULL))
+			DBG("Failed to send request to read battery level");
+	} else if (uuid_cmp(ASHA_CHRC_READ_ONLY_PROPERTIES_UUID, &uuid)) {
+		DBG("Got chrc %s/0x%x: READ_ONLY_PROPERTIES", uuid_str,
+								value_handle);
+		if (!bt_gatt_client_read_value(asha->client, value_handle,
+					read_rops, asha, NULL))
+			DBG("Failed to send request for readonly properties");
+	} else if (uuid_cmp(ASHA_CHRC_AUDIO_CONTROL_POINT_UUID, &uuid)) {
+		DBG("Got chrc %s/0x%x: AUDIO_CONTROL_POINT", uuid_str,
+								value_handle);
+		/* Store this for later writes */
+		asha->acp_handle = value_handle;
+	} else if (uuid_cmp(ASHA_CHRC_VOLUME_UUID, &uuid)) {
+		DBG("Got chrc %s/0x%x: VOLUME", uuid_str, value_handle);
+		/* Store this for later writes */
+		asha->volume_handle = value_handle;
+	} else if (uuid_cmp(ASHA_CHRC_AUDIO_STATUS_UUID, &uuid)) {
+		DBG("Got chrc %s/0x%x: AUDIO_STATUS", uuid_str, value_handle);
+		asha->status_notify_id =
+			bt_gatt_client_register_notify(asha->client,
+				value_handle, audio_status_register,
+				audio_status_notify, asha, NULL);
+		if (!asha->status_notify_id)
+			DBG("Failed to send request to notify AudioStatus");
+	} else {
+		DBG("Unsupported characteristic: %s", uuid_str);
+	}
+}
+
+static void foreach_asha_service(struct gatt_db_attribute *attr,
+							void *user_data)
+{
+	struct bt_asha *asha = user_data;
+
+	DBG("Found ASHA GATT service");
+
+	asha->attr = attr;
+	gatt_db_service_set_claimed(attr, true);
+	gatt_db_service_foreach_char(asha->attr, handle_characteristic, asha);
+}
+
+bool bt_asha_probe(struct bt_asha *asha, struct gatt_db *db,
+						struct bt_gatt_client *client)
+{
+	bt_uuid_t asha_uuid;
+
+	asha->db = gatt_db_ref(db);
+	asha->client = bt_gatt_client_clone(client);
+
+	bt_uuid16_create(&asha_uuid, ASHA_SERVICE);
+	gatt_db_foreach_service(db, &asha_uuid, foreach_asha_service, asha);
+
+	if (!asha->attr) {
+		error("ASHA attribute not found");
+		bt_asha_reset(asha);
+		return false;
+	}
+
+	return true;
+}
diff --git a/src/shared/asha.h b/src/shared/asha.h
new file mode 100644
index 000000000..9fe051d07
--- /dev/null
+++ b/src/shared/asha.h
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024  Asymptotic Inc.
+ *
+ *  Author: Arun Raghavan <arun@asymptotic.io>
+ *
+ *
+ */
+
+#
+
+#include <stdbool.h>
+#include <stdint.h>
+
+enum bt_asha_state_t {
+	ASHA_STOPPED = 0,
+	ASHA_STARTING,
+	ASHA_STARTED,
+	ASHA_STOPPING,
+};
+
+typedef void (*bt_asha_cb_t)(int status, void *data);
+
+struct bt_asha {
+	struct bt_gatt_client *client;
+	struct gatt_db *db;
+	struct gatt_db_attribute *attr;
+	uint16_t acp_handle;
+	uint16_t volume_handle;
+	unsigned int status_notify_id;
+
+	uint16_t psm;
+	bool right_side;
+	bool binaural;
+	bool csis_supported;
+	bool coc_streaming_supported;
+	uint8_t hisyncid[8];
+	uint16_t render_delay;
+	uint16_t codec_ids;
+	int8_t volume;
+
+	enum bt_asha_state_t state;
+	bt_asha_cb_t cb;
+	void *cb_user_data;
+	unsigned int resume_id;
+};
+
+struct bt_asha *bt_asha_new(void);
+void bt_asha_reset(struct bt_asha *asha);
+void bt_asha_state_reset(struct bt_asha *asha);
+void bt_asha_free(struct bt_asha *asha);
+
+unsigned int bt_asha_start(struct bt_asha *asha, bt_asha_cb_t cb,
+							void *user_data);
+unsigned int bt_asha_stop(struct bt_asha *asha, bt_asha_cb_t cb,
+							void *user_data);
+
+bool bt_asha_set_volume(struct bt_asha *asha, int8_t volume);
+
+bool bt_asha_probe(struct bt_asha *asha, struct gatt_db *db,
+						struct bt_gatt_client *client);
-- 
2.45.1

