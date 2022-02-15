Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5B8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 13:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbiBONhC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 08:37:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiBONhB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 08:37:01 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A318A65179
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 05:36:50 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c4so13587969pfl.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 05:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5n3haFpZLnaDEFp3A7vWWmUJ5KXe2KNH2oILgjnwTvw=;
        b=Ba/IZNJAqf/cSmBmG3ZQZNEc3UULGfBsOhjcCD3hfyDBbJjuqwB5sR+M/zqgGa/ly1
         G7rofxzJeCK4KKBzBVBbP/C1Uw0aKKMnldePmGjadibjs/gHo+IboQjAE+GGFwJLncVi
         bcqkIiDTGSpLqTIrgm23Sk7yepfRv7yegtU1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5n3haFpZLnaDEFp3A7vWWmUJ5KXe2KNH2oILgjnwTvw=;
        b=ZHNFbTHCr1oIz5ffL4OWBZoPyMY6mUdjPj9x7gTtlEGqxOqqDr+xRUTMw7MLdcCafE
         I3qsghwy6+mcfIFqO0tpddgqaflJQQ8OeLc0T8KfMYhLhdyyMzlgm2+jtnhI7VcrtuHR
         LjT5p9S3JuwvTHq9YaXgMDYhD7Kr9e9iFTxhZ2IBo6d0pAQ+tatul0cH8NyuMclt3ydv
         JCIslyBAkCKLXwBlLic8JRO4IoSpAjeAlEytK5X9MGWb6mZoXwMst/GURYtvRdiKF5v3
         4n+mPnctepy1FAgIMmXDWoTsafDUtzAMylEci6k7rZseub3PAimLiRVrPupbAT1ghWhU
         B41g==
X-Gm-Message-State: AOAM532+WAmSbm8e9LqJEii2b3KC8+icwCNOhiTlMXWTEfHrCYgxLgi1
        X3XmypdqghRHUYR/e9k7a/A1hH2NnFtbEQ==
X-Google-Smtp-Source: ABdhPJz5QqkiRrG0mMxgaBLvctPzibNXbGeuhfv3R6ToCGpV0GBhS/bAV+Oo75R+7wP7xp0JwRNd/g==
X-Received: by 2002:a05:6a00:1803:: with SMTP id y3mr3405969pfa.65.1644932209769;
        Tue, 15 Feb 2022 05:36:49 -0800 (PST)
Received: from localhost (208.158.221.35.bc.googleusercontent.com. [35.221.158.208])
        by smtp.gmail.com with UTF8SMTPSA id u16sm2757986pgh.54.2022.02.15.05.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 05:36:49 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Subject: [BlueZ PATCH v4 4/8] adapter: support AOSP MGMT_EV_QUALITY_REPORT
Date:   Tue, 15 Feb 2022 21:36:32 +0800
Message-Id: <20220215213600.BlueZ.v4.4.Ie4d1be8ced51f0aa92ee6d8eacf9666a121a1292@changeid>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220215133636.2827039-1-josephsih@chromium.org>
References: <20220215133636.2827039-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch supports a new MGMT event of AOSP bluetooth quality report.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v4:
- Change QUALITY_SPEC_AOSP_BQR to QUALITY_SPEC_AOSP.

Changes in v2:
- The new structs and constants are moved to separate patches:
  * doc: Add Bluetooth quality report event
  * lib: Add structures and constants for quality report
- The btmon decoding patches, about 500 lines of code, are ready
  and will be submitted immediately after these patches are accepted.
- Use util_debug instead of defining a new debug function.
- Remove the event printing function.
- The plan about the BQR events is to further expose them to other
  daemons, e.g., an audio daemon to make some smart control, or
  to an UI daemon to display alerts to users.

 Makefile.am       |  3 +-
 src/adapter.c     | 43 ++++++++++++++++++++++
 src/adapter.h     |  2 ++
 src/shared/aosp.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/aosp.h | 58 ++++++++++++++++++++++++++++++
 5 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/aosp.c
 create mode 100644 src/shared/aosp.h

diff --git a/Makefile.am b/Makefile.am
index 82125c482..600d85354 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -230,7 +230,8 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/gatt-db.h src/shared/gatt-db.c \
 			src/shared/gap.h src/shared/gap.c \
 			src/shared/log.h src/shared/log.c \
-			src/shared/tty.h
+			src/shared/tty.h \
+			src/shared/aosp.h src/shared/aosp.c
 
 if READLINE
 shared_sources += src/shared/shell.c src/shared/shell.h
diff --git a/src/adapter.c b/src/adapter.c
index d988865f6..c4c56e610 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -47,6 +47,7 @@
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/timeout.h"
+#include "src/shared/aosp.h"
 
 #include "btio/btio.h"
 #include "btd.h"
@@ -9178,6 +9179,28 @@ static void controller_resume_callback(uint16_t index, uint16_t length,
 	controller_resume_notify(adapter);
 }
 
+static void quality_report_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_quality_report *ev = param;
+
+	if (!ev)
+		return;
+
+	if (length < sizeof(*ev)) {
+		error("MGMT_EV_QUALITY_REPORT event too small");
+		return;
+	}
+
+	if (ev->quality_spec == QUALITY_SPEC_AOSP) {
+		if (!process_aosp_quality_report(ev))
+			error("processing aosp quality report");
+	} else {
+		error("quality report spec %u not supported.",
+			ev->quality_spec);
+	}
+}
+
 static void device_blocked_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9746,6 +9769,18 @@ bool is_quality_report_supported(struct btd_adapter *adapter)
 	return !!(adapter->supported_settings & MGMT_SETTING_QUALITY_REPORT);
 }
 
+static void quality_report_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	info("%s%s", prefix, str);
+}
+
+static void quality_set_debug(struct btd_adapter *adapter)
+{
+	aosp_set_debug(quality_report_debug, "quality: ");
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9974,6 +10009,11 @@ static void read_info_complete(uint8_t status, uint16_t length,
 						controller_resume_callback,
 						adapter, NULL);
 
+	mgmt_register(adapter->mgmt, MGMT_EV_QUALITY_REPORT,
+						adapter->dev_id,
+						quality_report_callback,
+						adapter, NULL);
+
 	set_dev_class(adapter);
 
 	set_name(adapter, btd_adapter_get_name(adapter));
@@ -10001,6 +10041,9 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	if (btd_adapter_get_powered(adapter))
 		adapter_start(adapter);
 
+	if (is_quality_report_supported(adapter) && getenv("QUALITY_DEBUG"))
+		quality_set_debug(adapter);
+
 	return;
 
 failed:
diff --git a/src/adapter.h b/src/adapter.h
index 35deb1d11..c199e358a 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -266,6 +266,8 @@ enum kernel_features {
 
 bool btd_has_kernel_features(uint32_t feature);
 
+bool is_quality_report_supported(struct btd_adapter *adapter);
+
 bool btd_adapter_set_allowed_uuids(struct btd_adapter *adapter,
 							struct queue *uuids);
 bool btd_adapter_is_uuid_allowed(struct btd_adapter *adapter,
diff --git a/src/shared/aosp.c b/src/shared/aosp.c
new file mode 100644
index 000000000..838babea4
--- /dev/null
+++ b/src/shared/aosp.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2021 Google LLC
+ *
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#include <stddef.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+
+#include "lib/bluetooth.h"
+#include "lib/mgmt.h"
+
+#include "src/shared/aosp.h"
+#include "src/shared/util.h"
+
+static struct {
+	aosp_debug_func_t callback;
+	void *data;
+} aosp_debug;
+
+void aosp_set_debug(aosp_debug_func_t callback, void *user_data)
+{
+	aosp_debug.callback = callback;
+	aosp_debug.data = user_data;
+}
+
+bool process_aosp_quality_report(const struct mgmt_ev_quality_report *ev)
+{
+	const struct aosp_bqr *edata = (struct aosp_bqr *)ev->data;
+	struct aosp_bqr bqr;
+
+	if (edata->subevent_code != 0x58) {
+		util_debug(aosp_debug.callback, aosp_debug.data,
+			"error: %u not AOSP Bluetooth quality report subevent",
+			edata->subevent_code);
+		return false;
+	}
+
+	if (ev->data_len < sizeof(struct aosp_bqr)) {
+		util_debug(aosp_debug.callback, aosp_debug.data,
+			"error: AOSP report size %u too small (expect >= %lu).",
+			ev->data_len, sizeof(struct aosp_bqr));
+		return false;
+	}
+
+	/* Ignore the Vendor Specific Parameter (VSP) field for now
+	 * due to the lack of standard way of reading it.
+	 */
+	bqr.quality_report_id = edata->quality_report_id;
+	bqr.packet_type = edata->packet_type;
+	bqr.conn_handle = btohs(edata->conn_handle);
+	bqr.conn_role = edata->conn_role;
+	bqr.tx_power_level = edata->tx_power_level;
+	bqr.rssi = edata->rssi;
+	bqr.snr = edata->snr;
+	bqr.unused_afh_channel_count = edata->unused_afh_channel_count;
+	bqr.afh_select_unideal_channel_count =
+				edata->afh_select_unideal_channel_count;
+	bqr.lsto = btohs(edata->lsto);
+	bqr.conn_piconet_clock = btohl(edata->conn_piconet_clock);
+	bqr.retransmission_count = btohl(edata->retransmission_count);
+	bqr.no_rx_count = btohl(edata->no_rx_count);
+	bqr.nak_count = btohl(edata->nak_count);
+	bqr.last_tx_ack_timestamp = btohl(edata->last_tx_ack_timestamp);
+	bqr.flow_off_count = btohl(edata->flow_off_count);
+	bqr.last_flow_on_timestamp = btohl(edata->last_flow_on_timestamp);
+	bqr.buffer_overflow_bytes = btohl(edata->buffer_overflow_bytes);
+	bqr.buffer_underflow_bytes = btohl(edata->buffer_underflow_bytes);
+
+	util_debug(aosp_debug.callback, aosp_debug.data,
+		"AOSP report of connection hanle %u received", bqr.conn_handle);
+
+	return true;
+}
diff --git a/src/shared/aosp.h b/src/shared/aosp.h
new file mode 100644
index 000000000..b58aa5e3a
--- /dev/null
+++ b/src/shared/aosp.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2021 Google LLC
+ *
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifndef __AOSP_H
+#define __AOSP_H
+
+#include <stdbool.h>
+
+struct mgmt_ev_quality_report;
+
+struct aosp_bqr {
+	uint8_t subevent_code;
+	uint8_t quality_report_id;
+	uint8_t packet_type;
+	uint16_t conn_handle;
+	uint8_t conn_role;
+	int8_t tx_power_level;			/* -30  to 20 dbm */
+	int8_t rssi;				/* -127 to 20 dbm */
+	uint8_t snr;				/* db */
+	uint8_t unused_afh_channel_count;
+	uint8_t afh_select_unideal_channel_count;
+	uint16_t lsto;
+	uint32_t conn_piconet_clock;
+	uint32_t retransmission_count;
+	uint32_t no_rx_count;
+	uint32_t nak_count;
+	uint32_t last_tx_ack_timestamp;
+	uint32_t flow_off_count;
+	uint32_t last_flow_on_timestamp;
+	uint32_t buffer_overflow_bytes;
+	uint32_t buffer_underflow_bytes;
+
+	uint8_t vsp[0];			/* Vendor Specific Parameter */
+} __packed;
+
+typedef void (*aosp_debug_func_t)(const char *str, void *user_data);
+void aosp_set_debug(aosp_debug_func_t callback, void *user_data);
+
+bool process_aosp_quality_report(const struct mgmt_ev_quality_report *ev);
+
+#endif /* __AOSP_H */
-- 
2.35.1.265.g69c8d7142f-goog

