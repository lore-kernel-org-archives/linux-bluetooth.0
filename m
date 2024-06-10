Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10B18E2A
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058974; cv=none; b=UVOmEf3GGrgrQZ3j9CKDG93QrABZCuCuiDTTDeXlKexTXcqvyshZOadRwCuKG7NAFz0V3ai0vwCScm67JPCjc0asX+W7F/nAB5TuAo1YPMquV1+hRFyoDuGBz0nPaSd7iBxqYsLXMywZPdbHuBIFAdKgwyuHCQ9yKibUypLpbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058974; c=relaxed/simple;
	bh=pmhbn/uve2HgcH9QxExAD7WTCA2WiIZNwE0g+fMwsGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AT8061W9G1Tbq0MM+DFwki1BkXqeTFaTQIevL8IzRU661x8FPU/L/WEINJZ6MRcWSEjk1a0JHIkjmjy2gM2PZXScHm8nQ7zgOnyP8xrhVpV8VdB1h/Z44A7wuk7CashEzZKg+k/mxjxnzR3x0KNhdDx+I1sojzakyO3sT4xWJaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=sMb4TGxA; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="sMb4TGxA"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44051a577easo17585781cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1718058970; x=1718663770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4e2bbfhXrnrsAWJlpdBp4JSaXCX8/Pe/o13a1AAjME=;
        b=sMb4TGxA6CYKVwN/lx1L/IvYXsWjERNC0QEwUmUu/CvrS9myMBTQMGXJyqIFcCnEKZ
         dKmuM+4GLK9AVWfCTwMACgTVEDPzjGQJTxywej1GHOJxFQbDwDZzQ8Hl1ozkzuQiG23d
         si2881CQLOLaIZdRaescWBDFiRxRN0h7aNoTKOUp5Z8YxsPg8nZ2/unYT3je+lgrRbo+
         HSnYnbfD5gXL2Ouib8Re6pED5hyVm6NZDaGEsBVDBTwV5Geen9CCe0Eau8naeAs+LMJ1
         w8j3IWj+Kr5fLiago6qyT6eU1yjuANsYebPhUX7PQv2HW46h3hTeGi8x0+lphHBtR93l
         BNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058970; x=1718663770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4e2bbfhXrnrsAWJlpdBp4JSaXCX8/Pe/o13a1AAjME=;
        b=uRv9WxYhGUlPHznFsN+7PLW/S6tQfMyNPAMlusrVRCdz74vYDQFpy7R8IZPV5UzEfu
         uWO1XukGRHzshaK1EdawUKfep2ilFmgoIZ2eu4b7txQuL7JiXO0ovzUlPlvjDQ49YIzs
         mprtFjTt9X80XwFavRot4sw1b7yd984BlqVunGI0a1Q+nrJX5udk09pJRBy3FkA7Pf41
         vQqhFa5/NL1OW3KzEPyylcMWkSBrnvF38z2wU99BMVrC+PjtpRhxhX7ElRK58+/09DNU
         vrSqGeEWA4jNdXUBMVMYxxHu/m0OMVAwY1FmKFgqJa4CVpVAmS1olZgLG5KCMYRTysjz
         qxTw==
X-Gm-Message-State: AOJu0YzY5nOPG+e72lNpKWaopd2TGNQ0cvYZGH/aU46MxIZjyLiJUJ6v
	kgXutEb0TpdIvElt5cFs6jRaQY/tIk+3u6pN5RnqIR0XgvUsHtqu8TdcOrOV6EzSqlXOiYPzods
	B
X-Google-Smtp-Source: AGHT+IEz0O8LGIopYf9Zqt9+KUrQga7LqsBwh0XPvOs1UADcN/bb9NtqskWWXw9VyVSuQLk7XrWKJQ==
X-Received: by 2002:a05:622a:1823:b0:440:dd96:be82 with SMTP id d75a77b69052e-440dd96c9a5mr63484041cf.33.1718058969466;
        Mon, 10 Jun 2024 15:36:09 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440711c3c53sm16283221cf.80.2024.06.10.15.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:36:08 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v9 1/3] src/shared: Add initial implementation for an ASHA profile
Date: Mon, 10 Jun 2024 18:35:59 -0400
Message-ID: <20240610223601.378127-2-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240610223601.378127-1-arun@asymptotic.io>
References: <20240610223601.378127-1-arun@asymptotic.io>
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
 src/shared/asha.c | 360 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/asha.h |  63 ++++++++
 4 files changed, 428 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/asha.c
 create mode 100644 src/shared/asha.h

diff --git a/Makefile.am b/Makefile.am
index 8f5d2fb55..0ae721111 100644
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
index 000000000..a5ac8cc3d
--- /dev/null
+++ b/src/shared/asha.c
@@ -0,0 +1,360 @@
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
+		error("Error writing ACP command");
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
+		return ret;
+
+	asha->state = ASHA_STARTING;
+
+	return 0;
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
+	return asha_send_acp(asha, acp_stop_cmd, sizeof(acp_stop_cmd),
+								cb, user_data);
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
index 000000000..c2c232fff
--- /dev/null
+++ b/src/shared/asha.h
@@ -0,0 +1,63 @@
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
2.45.2

