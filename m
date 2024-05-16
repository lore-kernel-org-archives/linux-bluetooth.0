Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05F5156F3F
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715888332; cv=none; b=Jwl4Lc1VEtVZudhdunIgDGCCsyoQHffovBxKwk484NUxwe1GNJeGhtcWUhLHIeHM6KC4jkIjVA0WKoq60dZpJXtqh5Z4jYrfgqdGFyhh0gL5kZrGPBqtI75jaJ+mDkLa2XZph7h0aDIBCQpGzzKyst14mBm27ukmxpY70lrbg7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715888332; c=relaxed/simple;
	bh=6z7+sB1mrZc33ngLiMTxHJV2wyU7o9aV0CVhTsVNAww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+rJgNx4w2lzOX7T/yzZ3fOT/RFnXWIhasrWw93uViLSNCNsYusXANE3Rj4v7jF1BJrNGaRpA1Bnu7csDyUlXU5lBJ78dY8C4CI27/zcXu9T14fHNKlq9PNVL1ooibLsFwrD5HYn9048l/zq7n5uvNn5OnQmKLF7uNjrPxkIZuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=ANwrv1tk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="ANwrv1tk"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f74fa2a82so1531529e87.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715888328; x=1716493128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXPd9wbAx5pq3MK8d8b1PsDhjKacO1WgW4KIkhIiHwI=;
        b=ANwrv1tkGzfM52l+xa6B0Mxkhjw73oh6G48I/NkTTRsd30aHiy1Gg7l+AwqqR+WGPK
         UUWgMlAf3ZDm2cKBpKZlPOPxmo6JjcDAX3Hl05qiofpZgdaV+vFUkPcdNrfrfDAyhvM5
         z8RnDwZbnYTgQytXaR6lbwPvvqA77wMjKqG5iP12//ShvUB46E2zJxJZd5Cxbl+mwML3
         3GjTM7Fmur+WwY4gDEYTFmZoEQ/b2Y2fyZloMEIV1Nt79ct8rBYwVyIGEE0Aoj5nkjwv
         ZVhCFhLdwq58QFfG7WKGkHxi28ihqX80u2lLdRe7Wj2896hzdJ4FdstnYD3DLr+j+3Wz
         9lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715888328; x=1716493128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXPd9wbAx5pq3MK8d8b1PsDhjKacO1WgW4KIkhIiHwI=;
        b=AUE49wFqf3jLJE0hhJikLo+qplVlPkiGH/MoB9nqsYHvS/Yat679PaePNKICbGlNeI
         rspOr1i8EXuEuWtowiIh4fyp+FNdE54JNGLxZxdwhIyDRG00/Y9Hi1x0fA2HEVAOciHy
         P9tL24++Zw/McqqNSCXPtM2i40RU9LC0oqqYP6NcOC+haKb3kz8iuehhmqrf1hmcEBo3
         1F2QTvJ3vum/3K+Ff6CO/7I15SSIujLUwy5l2iE3DdPD1aPgz9Zj/2AHytMrTAs8WIDO
         vtbUtADXSAThr4342CtydQxVDw0FUCrXvjzknSwohOTsBF0Nl0VcwgxXm9lm0RQ0SW9T
         DunQ==
X-Gm-Message-State: AOJu0YxzdO4jJNWH8UrbXIbbPSQuy/gAoPDuZhR3xV3miLuJTOcewUjc
	8YAl9lOuBL4plWeIi4Z4Mv+SxqkFYkk1KAvTvY6ZjuEKPkp+wUbGPojNucPo7FL8YWOwjvnVaWK
	e9qI=
X-Google-Smtp-Source: AGHT+IHGC7Jaun0pjRDidGcG/wGJtQ9X1vlZotN2xpxm9QuWIb8WO1RKO7AFX0udMIwBmaXgXbTrYQ==
X-Received: by 2002:ac2:4284:0:b0:51f:567b:c399 with SMTP id 2adb3069b0e04-52210277b79mr16797029e87.62.1715888327760;
        Thu, 16 May 2024 12:38:47 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-19-74-15-47-99.dsl.bell.ca. [74.15.47.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cd85sm1031241766b.15.2024.05.16.12.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:38:47 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v6 1/5] src/shared: Add initial implementation for an ASHA profile
Date: Thu, 16 May 2024 15:38:32 -0400
Message-ID: <20240516193836.228281-2-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516193836.228281-1-arun@asymptotic.io>
References: <20240516193836.228281-1-arun@asymptotic.io>
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
 configure.ac      |   4 +
 lib/uuid.h        |   3 +
 src/shared/asha.c | 529 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/asha.h |  75 +++++++
 5 files changed, 613 insertions(+), 1 deletion(-)
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
diff --git a/configure.ac b/configure.ac
index 8b3cdb4e8..213e36b32 100644
--- a/configure.ac
+++ b/configure.ac
@@ -216,6 +216,10 @@ AC_ARG_ENABLE(csip, AS_HELP_STRING([--disable-csip],
 		[disable CSIP profile]), [enable_csip=${enableval}])
 AM_CONDITIONAL(CSIP, test "${enable_csip}" != "no")
 
+AC_ARG_ENABLE(asha, AS_HELP_STRING([--disable-asha],
+		[disable ASHA support]), [enable_asha=${enableval}])
+AM_CONDITIONAL(ASHA, test "${enable_asha}" != "no")
+
 AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
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
index 000000000..db86846fa
--- /dev/null
+++ b/src/shared/asha.c
@@ -0,0 +1,529 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+#include <unistd.h>
+#include <sys/socket.h>
+
+#include "lib/bluetooth.h"
+#include "lib/l2cap.h"
+#include "lib/uuid.h"
+
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/gatt-db.h"
+#include "src/log.h"
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
+/* 2 byte SDU length, 1 byte sequence number, and then 20ms of G.722 */
+#define ASHA_MIN_MTU 163
+#define ASHA_CONNECTION_MTU 512			/* The default of 672 does not
+						 * work */
+
+struct bt_asha_device *bt_asha_device_new(void)
+{
+	struct bt_asha_device *asha;
+
+	asha = new0(struct bt_asha_device, 1);
+
+	return asha;
+}
+
+void bt_asha_device_reset(struct bt_asha_device *asha)
+{
+	if (asha->status_notify_id) {
+		bt_gatt_client_unregister_notify(asha->client,
+						asha->status_notify_id);
+	}
+
+	if (asha->volume_notify_id) {
+		bt_gatt_client_unregister_notify(asha->client,
+						asha->volume_notify_id);
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
+void bt_asha_state_reset(struct bt_asha_device *asha)
+{
+	close(asha->fd);
+	asha->fd = -1;
+
+	asha->state = ASHA_STOPPED;
+	asha->resume_id = 0;
+
+	asha->cb = NULL;
+	asha->cb_user_data = NULL;
+}
+
+void bt_asha_device_free(struct bt_asha_device *asha)
+{
+	gatt_db_unref(asha->db);
+	bt_gatt_client_unref(asha->client);
+	free(asha);
+}
+
+uint16_t bt_asha_device_get_render_delay(struct bt_asha_device *asha)
+{
+	return asha->render_delay;
+}
+
+enum bt_asha_state_t bt_asha_device_get_state(struct bt_asha_device *asha)
+{
+	return asha->state;
+}
+
+int bt_asha_device_get_fd(struct bt_asha_device *asha)
+{
+	return asha->fd;
+}
+
+uint16_t bt_asha_device_get_omtu(struct bt_asha_device *asha)
+{
+	return asha->omtu;
+}
+uint16_t bt_asha_device_get_imtu(struct bt_asha_device *asha)
+{
+	return asha->imtu;
+}
+
+static int asha_connect_socket(struct bt_asha_device *asha)
+{
+	int fd = 0, err;
+	struct sockaddr_l2 addr = { 0, };
+	struct l2cap_options opts;
+	socklen_t len;
+
+	fd = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+	if (fd < 0) {
+		error("Could not open L2CAP CoC socket: %s", strerror(errno));
+		goto error;
+	}
+
+	addr.l2_family = AF_BLUETOOTH;
+	addr.l2_bdaddr_type = BDADDR_LE_PUBLIC;
+
+	/*
+	 * We need to bind before connect to work around getting the wrong addr
+	 * type on older(?) kernels
+	 */
+	err = bind(fd, (struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0) {
+		error("Could not bind L2CAP CoC socket: %s", strerror(errno));
+		goto error;
+	}
+
+	addr.l2_psm = asha->psm;
+	bacpy(&addr.l2_bdaddr, device_get_address(asha->device));
+
+	opts.mode = BT_MODE_LE_FLOWCTL;
+	opts.omtu = opts.imtu = ASHA_MIN_MTU;
+
+	err = setsockopt(fd, SOL_BLUETOOTH, BT_MODE, &opts.mode,
+							sizeof(opts.mode));
+	if (err < 0) {
+		error("Could not set L2CAP CoC socket flow control mode: %s",
+				strerror(errno));
+		/* Let this be non-fatal? */
+	}
+
+	opts.imtu = ASHA_CONNECTION_MTU;
+	err = setsockopt(fd, SOL_BLUETOOTH, BT_RCVMTU, &opts.imtu,
+							sizeof(opts.imtu));
+	if (err < 0) {
+		error("Could not set L2CAP CoC socket receive MTU: %s",
+				strerror(errno));
+		/* Let this be non-fatal? */
+	}
+
+	err = connect(fd, (struct sockaddr *)&addr, sizeof(addr));
+	if (err < 0) {
+		error("Could not connect L2CAP CoC socket: %s",
+							strerror(errno));
+		goto error;
+	}
+
+	err = getsockopt(fd, SOL_BLUETOOTH, BT_SNDMTU, &opts.omtu, &len);
+	if (err < 0) {
+		error("Could not get L2CAP CoC socket receive MTU: %s",
+				strerror(errno));
+		/* Let this be non-fatal? */
+	}
+
+	err = getsockopt(fd, SOL_BLUETOOTH, BT_RCVMTU, &opts.imtu, &len);
+	if (err < 0) {
+		error("Could not get L2CAP CoC socket receive MTU: %s",
+				strerror(errno));
+		/* Let this be non-fatal? */
+	}
+
+	asha->fd = fd;
+	asha->imtu = opts.imtu;
+	asha->omtu = opts.omtu;
+
+	DBG("L2CAP CoC socket is open");
+	return 0;
+
+error:
+	if (fd)
+		close(fd);
+	return -1;
+}
+
+static void asha_acp_sent(bool success, uint8_t err, void *user_data)
+{
+	struct bt_asha_device *asha = user_data;
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
+static int asha_send_acp(struct bt_asha_device *asha, uint8_t *cmd,
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
+unsigned int bt_asha_device_start(struct bt_asha_device *asha, bt_asha_cb_t cb,
+		void *user_data)
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
+	ret = asha_connect_socket(asha);
+	if (ret < 0)
+		return 0;
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
+unsigned int bt_asha_device_stop(struct bt_asha_device *asha, bt_asha_cb_t cb,
+		void *user_data)
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
+int8_t bt_asha_device_get_volume(struct bt_asha_device *asha)
+{
+	return asha->volume;
+}
+
+bool bt_asha_device_set_volume(struct bt_asha_device *asha, int8_t volume)
+{
+	if (!bt_gatt_client_write_value(asha->client, asha->volume_handle,
+				(const uint8_t *)&volume, 1, NULL, NULL,
+				NULL)) {
+		error("Error writing ACP start");
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
+	struct bt_asha_device *asha = user_data;
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
+	struct bt_asha_device *asha = user_data;
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
+static void audio_status_notify(uint16_t value_handle, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	struct bt_asha_device *asha = user_data;
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
+static void read_volume(bool success,
+			uint8_t att_ecode,
+			const uint8_t *value,
+			uint16_t length,
+			void *user_data)
+{
+	struct bt_asha_device *asha = user_data;
+
+	if (!success) {
+		DBG("Reading volume failed with ATT error: %u", att_ecode);
+		return;
+	}
+
+	if (length != 2) {
+		DBG("Reading volume failed: unexpected length %u", length);
+		return;
+	}
+
+	asha->volume = get_s8(value);
+
+	DBG("Got volume: %d", asha->volume);
+}
+
+static void volume_notify(uint16_t value_handle, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	struct bt_asha_device *asha = user_data;
+
+	asha->volume = get_s8(value);
+
+	DBG("Volume changed: %d", asha->volume);
+}
+
+static void handle_characteristic(struct gatt_db_attribute *attr,
+								void *user_data)
+{
+	struct bt_asha_device *asha = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid;
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NULL,
+								NULL, &uuid)) {
+		error("Failed to obtain characteristic data");
+		return;
+	}
+
+	if (uuid_cmp(ASHA_CHRC_LE_PSM_OUT_UUID, &uuid)) {
+		if (!bt_gatt_client_read_value(asha->client, value_handle,
+					read_psm, asha, NULL))
+			DBG("Failed to send request to read battery level");
+	} else if (uuid_cmp(ASHA_CHRC_READ_ONLY_PROPERTIES_UUID, &uuid)) {
+		if (!bt_gatt_client_read_value(asha->client, value_handle,
+					read_rops, asha, NULL))
+			DBG("Failed to send request for readonly properties");
+	} else if (uuid_cmp(ASHA_CHRC_AUDIO_CONTROL_POINT_UUID, &uuid)) {
+		/* Store this for later writes */
+		asha->acp_handle = value_handle;
+	} else if (uuid_cmp(ASHA_CHRC_VOLUME_UUID, &uuid)) {
+		/* Store this for later reads and writes */
+		asha->volume_handle = value_handle;
+		asha->volume_notify_id =
+			bt_gatt_client_register_notify(asha->client,
+				value_handle, NULL, volume_notify, asha,
+				NULL);
+		if (!asha->status_notify_id)
+			DBG("Failed to send request to notify volume");
+		if (!bt_gatt_client_read_value(asha->client, value_handle,
+					read_volume, asha, NULL))
+			DBG("Failed to send request to volume");
+	} else if (uuid_cmp(ASHA_CHRC_AUDIO_STATUS_UUID, &uuid)) {
+		asha->status_notify_id =
+			bt_gatt_client_register_notify(asha->client,
+				value_handle, NULL, audio_status_notify, asha,
+				NULL);
+		if (!asha->status_notify_id)
+			DBG("Failed to send request to notify AudioStatus");
+	} else {
+		char uuid_str[MAX_LEN_UUID_STR];
+
+		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+		DBG("Unsupported characteristic: %s", uuid_str);
+	}
+}
+
+static void foreach_asha_service(struct gatt_db_attribute *attr,
+							void *user_data)
+{
+	struct bt_asha_device *asha = user_data;
+
+	DBG("Found ASHA GATT service");
+
+	asha->attr = attr;
+	gatt_db_service_foreach_char(asha->attr, handle_characteristic, asha);
+}
+
+bool bt_asha_device_probe(struct bt_asha_device *asha)
+{
+	struct btd_device *device = asha->device;
+	struct gatt_db *db = btd_device_get_gatt_db(device);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
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
+		bt_asha_device_reset(asha);
+		return false;
+	}
+
+	return true;
+}
diff --git a/src/shared/asha.h b/src/shared/asha.h
new file mode 100644
index 000000000..24fe5d5bd
--- /dev/null
+++ b/src/shared/asha.h
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+#include <stdbool.h>
+#include <stdint.h>
+
+struct bt_asha_device;
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
+struct bt_asha_device {
+	struct btd_device *device;
+	struct bt_gatt_client *client;
+	struct gatt_db *db;
+	struct gatt_db_attribute *attr;
+	uint16_t acp_handle;
+	uint16_t volume_handle;
+	unsigned int status_notify_id;
+	unsigned int volume_notify_id;
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
+	struct media_transport *transport;
+	int fd;
+	uint16_t imtu, omtu;
+	enum bt_asha_state_t state;
+	bt_asha_cb_t cb;
+	void *cb_user_data;
+	int resume_id;
+};
+
+struct bt_asha_device *bt_asha_device_new(void);
+void bt_asha_device_reset(struct bt_asha_device *asha);
+void bt_asha_state_reset(struct bt_asha_device *asha);
+void bt_asha_device_free(struct bt_asha_device *asha);
+
+uint16_t bt_asha_device_get_render_delay(struct bt_asha_device *asha);
+enum bt_asha_state_t bt_asha_device_get_state(struct bt_asha_device *asha);
+int bt_asha_device_get_fd(struct bt_asha_device *asha);
+uint16_t bt_asha_device_get_omtu(struct bt_asha_device *asha);
+uint16_t bt_asha_device_get_imtu(struct bt_asha_device *asha);
+
+unsigned int bt_asha_device_start(struct bt_asha_device *asha, bt_asha_cb_t cb,
+		void *user_data);
+unsigned int bt_asha_device_stop(struct bt_asha_device *asha, bt_asha_cb_t cb,
+		void *user_data);
+
+int8_t bt_asha_device_get_volume(struct bt_asha_device *asha);
+bool bt_asha_device_set_volume(struct bt_asha_device *asha, int8_t volume);
+
+bool bt_asha_device_probe(struct bt_asha_device *asha);
-- 
2.45.0

