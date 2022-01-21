Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A555C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 11:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349905AbiAULYW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 06:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbiAULYV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 06:24:21 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E4FC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 03:24:21 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id h23so7898725pgk.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 03:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYiyADlYTeMQufmxJhfnNW1qy/27PjrlW16z4gYZSdc=;
        b=jq6irRboSr7x/9JSefuQLxLBv6/rLrYDxRlNaYgxIdHjzveT13Qx6o9kPuCe80jvoP
         PsuLZo8SKQAfepoI+pu8S7FquLFLJmb6Il3DXtEztNkiQhQPAs9svZFnemnqgj2T0JcB
         eeNTlpAKZFlCvkfxv/v0fDYyxCVsquM7z4/6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYiyADlYTeMQufmxJhfnNW1qy/27PjrlW16z4gYZSdc=;
        b=1TrP5wCY8dpC9JysApP6vO+fPzWu13fLunNPltedHu2sGV+FKY4cgVUsOm7sTGHLyp
         bgUGE+1vaPQNovpn3bR1RSj6otL9DF1TX4x7pjRkBuiF7OhNmGvt55sYd2uQSEYUKIkJ
         d6FqAf5byug1K4+DlNgqlnJaU9H/+wVoIEt2nddUSq3yprwUykKxpA761fdhdwe6KwIN
         8z8R90U0Xky1h0YpjecO1mhuGVM5AjkSoxoYH688c+vHwcN93stFrmqfTJgmrFFjZJbm
         WkZF0bVv0nyAfhm2Lsy3sXaLYMF/nycDvCB5HqOLrmXvcLHeo09MhivdWBoB9JWLSBm0
         MfTQ==
X-Gm-Message-State: AOAM530driEei/q0HlnfRpJL8g30DsHBMzzUgfQmutyZEPO2oIPnR9I6
        feQ/CqfjTqByR6Jsb3LVUMySHqa+ujIXYw==
X-Google-Smtp-Source: ABdhPJw3k3I6bfNi4n7lxg7zOm7XlTH/eAQujdjMfy6i3VYHD5+w8r3TwY3/6McJUGeVvL3jJRd5DQ==
X-Received: by 2002:a63:4f23:: with SMTP id d35mr2585276pgb.166.1642764260460;
        Fri, 21 Jan 2022 03:24:20 -0800 (PST)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id d14sm7057317pfv.189.2022.01.21.03.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 03:24:20 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Subject: [BlueZ PATCH v1 2/2] adapter: support Intel MGMT_EV_QUALITY_REPORT
Date:   Fri, 21 Jan 2022 19:24:12 +0800
Message-Id: <20220121192352.BlueZ.v1.2.Ifdf5cf89a14b4f293d868910c6cb85e802f7eb9e@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220121192352.BlueZ.v1.1.Ie4d1be8ced51f0aa92ee6d8eacf9666a121a1292@changeid>
References: <20220121192352.BlueZ.v1.1.Ie4d1be8ced51f0aa92ee6d8eacf9666a121a1292@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch supports a new MGMT event of Intel telemetry report.

An ACL telemetry report looks like:

quality: Intel Extended Telemetry Event
quality:   ACL connection handle: 0x0100
quality:   Rx HEC errors: 0
quality:   Rx CRC errors: 0
quality:   Packets from host: 424
quality:   Tx packets: 425
quality:   Tx packets 0 retries: 391
quality:   Tx packets 1 retries: 33
quality:   Tx packets 2 retries: 1
quality:   Tx packets 3 retries: 0
quality:   Tx packets 4 retries: 0
quality:   Tx DH1 packets: 0
quality:   Tx DH3 packets: 0
quality:   Tx DH5 packets: 0
quality:   Tx 2DH1 packets: 0
quality:   Tx 2DH3 packets: 0
quality:   Tx 2DH5 packets: 0
quality:   Tx 3DH1 packets: 9
quality:   Tx 3DH3 packets: 0
quality:   Tx 3DH5 packets: 415
quality:   Rx packets: 1568
quality:   ACL link throughput: 34071
quality:   ACL max packet latency: 44375
quality:   ACL avg packet latency: 13

A SCO telemetry report looks like:

quality: Intel Extended Telemetry Event
quality:   SCO connection handle: 0x010a
quality:   Packets from host: 667
quality:   Tx packets: 667
quality:   Rx payload lost: 5
quality:   Tx payload lost: 36
quality:   Rx No SYNC errors (slot 0): 11
quality:   Rx No SYNC errors (slot 1): 32
quality:   Rx No SYNC errors (slot 2): 33
quality:   Rx No SYNC errors (slot 3): 13
quality:   Rx No SYNC errors (slot 4): 0
quality:   Rx HEC errors (slot 0): 9
quality:   Rx HEC errors (slot 1): 4
quality:   Rx HEC errors (slot 2): 0
quality:   Rx HEC errors (slot 3): 0
quality:   Rx HEC errors (slot 4): 0
quality:   Rx CRC errors (slot 0): 9
quality:   Rx CRC errors (slot 1): 2
quality:   Rx CRC errors (slot 2): 0
quality:   Rx CRC errors (slot 3): 0
quality:   Rx CRC errors (slot 4): 0
quality:   Rx NAK errors (slot 0): 647
quality:   Rx NAK errors (slot 1): 14
quality:   Rx NAK errors (slot 2): 2
quality:   Rx NAK errors (slot 3): 0
quality:   Rx NAK errors (slot 4): 0
quality:   Failed Tx due to Wifi coex (slot 0): 0
quality:   Failed Tx due to Wifi coex (slot 1): 0
quality:   Failed Tx due to Wifi coex (slot 2): 0
quality:   Failed Tx due to Wifi coex (slot 3): 0
quality:   Failed Tx due to Wifi coex (slot 4): 0
quality:   Failed Rx due to Wifi coex (slot 0): 0
quality:   Failed Rx due to Wifi coex (slot 1): 0
quality:   Failed Rx due to Wifi coex (slot 2): 0
quality:   Failed Rx due to Wifi coex (slot 3): 0
quality:   Failed Rx due to Wifi coex (slot 4): 0
quality:   Late samples inserted based on CDC: 0
quality:   Samples dropped: 0
quality:   Mute samples sent at initial connection: 0
quality:   PLC injection data: 0

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

 Makefile.am        |   3 +-
 src/adapter.c      |   9 +-
 src/shared/intel.c | 327 +++++++++++++++++++++++++++++++++++++++++++++
 src/shared/intel.h | 155 +++++++++++++++++++++
 4 files changed, 492 insertions(+), 2 deletions(-)
 create mode 100644 src/shared/intel.c
 create mode 100644 src/shared/intel.h

diff --git a/Makefile.am b/Makefile.am
index baab40369..abbe3897b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -231,7 +231,8 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/gap.h src/shared/gap.c \
 			src/shared/log.h src/shared/log.c \
 			src/shared/tty.h \
-			src/shared/aosp.h src/shared/aosp.c
+			src/shared/aosp.h src/shared/aosp.c \
+			src/shared/intel.h src/shared/intel.c
 
 if READLINE
 shared_sources += src/shared/shell.c src/shared/shell.h
diff --git a/src/adapter.c b/src/adapter.c
index 03f0e1ca6..6f3bf495d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -48,6 +48,7 @@
 #include "src/shared/gatt-db.h"
 #include "src/shared/timeout.h"
 #include "src/shared/aosp.h"
+#include "src/shared/intel.h"
 
 #include "btio/btio.h"
 #include "btd.h"
@@ -9331,6 +9332,9 @@ static void quality_report_callback(uint16_t index, uint16_t length,
 	if (ev->quality_spec == QUALITY_SPEC_AOSP_BQR) {
 		if (!process_aosp_quality_report(ev))
 			error("processing aosp quality report");
+	} else if (ev->quality_spec == QUALITY_SPEC_INTEL_TELEMETRY) {
+		if (!process_intel_telemetry_report(ev))
+			error("processing intel telemetry report");
 	} else {
 		error("quality report spec %u not supported.",
 			ev->quality_spec);
@@ -9929,7 +9933,10 @@ static void quality_report_debug(const char *str, void *user_data)
 
 static void quality_set_debug(struct btd_adapter *adapter)
 {
-	aosp_set_debug(quality_report_debug, "quality: ");
+	if (is_manufacturer_intel(adapter->manufacturer))
+		intel_set_debug(quality_report_debug, "quality: ");
+	else
+		aosp_set_debug(quality_report_debug, "quality: ");
 }
 
 static void read_info_complete(uint8_t status, uint16_t length,
diff --git a/src/shared/intel.c b/src/shared/intel.c
new file mode 100644
index 000000000..87cc300dc
--- /dev/null
+++ b/src/shared/intel.c
@@ -0,0 +1,327 @@
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
+#include "src/shared/intel.h"
+#include "src/shared/util.h"
+
+#define COMPANY_ID_INTEL	0x0002
+
+struct intel_ext_telemetry_event tev;
+
+static struct {
+	intel_debug_func_t callback;
+	void *data;
+} intel_debug;
+
+static char *bredr_packet_type[INTEL_NUM_PACKET_TYPES] = {
+	"DH1",
+	"DH3",
+	"DH5",
+	"2DH1",
+	"2DH3",
+	"2DH5",
+	"3DH1",
+	"3DH3",
+	"3DH5",
+};
+
+/* Use offsetof to access the attributes of structures. This makes
+ * simple traversing and assigning values to the attributes.
+ */
+#define TELEM_OFFSET(a)		offsetof(struct intel_ext_telemetry_event, a)
+#define TELEM_ATTR(a)		(((uint8_t *)&tev) + TELEM_OFFSET(a))
+
+#define ACL_OFFSET(a)		offsetof(struct intel_acl_event, a)
+#define ACL_ATTR(a)		(((uint8_t *)&tev.conn.acl) + ACL_OFFSET(a))
+#define ACL_ATTR_ARRAY(a, i)	(ACL_ATTR(a) + i * sizeof(tev.conn.acl.a[0]))
+
+#define SCO_OFFSET(a)		offsetof(struct intel_sco_event, a)
+#define SCO_ATTR(a)		(((uint8_t *)&tev.conn.sco) + SCO_OFFSET(a))
+
+static const struct intel_ext_subevent {
+	uint8_t id;
+	uint8_t size;
+	uint8_t elements;
+	uint8_t *attr;  /* address of the attribute in tev */
+} intel_ext_subevent_table[] = {
+	{ 0x01, 1, 1, TELEM_ATTR(telemetry_ev_type) },
+
+	/* ACL audio link quality subevents */
+	{ 0x4a, 2, 1, ACL_ATTR(conn_handle) },
+	{ 0x4b, 4, 1, ACL_ATTR(rx_hec_error) },
+	{ 0x4c, 4, 1, ACL_ATTR(rx_crc_error) },
+	{ 0x4d, 4, 1, ACL_ATTR(packets_from_host) },
+	{ 0x4e, 4, 1, ACL_ATTR(tx_packets) },
+	{ 0x4f, 4, 1, ACL_ATTR_ARRAY(tx_packets_retry, 0) },
+	{ 0x50, 4, 1, ACL_ATTR_ARRAY(tx_packets_retry, 1) },
+	{ 0x51, 4, 1, ACL_ATTR_ARRAY(tx_packets_retry, 2) },
+	{ 0x52, 4, 1, ACL_ATTR_ARRAY(tx_packets_retry, 3) },
+	{ 0x53, 4, 1, ACL_ATTR_ARRAY(tx_packets_retry, 4) },
+	{ 0x54, 4, 1, ACL_ATTR_ARRAY(tx_packets_by_type, 0) },
+	{ 0x55, 4, 1, ACL_ATTR_ARRAY(tx_packets_by_type, 1) },
+	{ 0x56, 4, 1, ACL_ATTR_ARRAY(tx_packets_by_type, 2) },
+	{ 0x57, 4, 1, ACL_ATTR_ARRAY(tx_packets_by_type, 3) },
+	{ 0x58, 4, 1, ACL_ATTR_ARRAY(tx_packets_by_type, 4) },
+	{ 0x59, 4, 1, ACL_ATTR_ARRAY(tx_packets_by_type, 5) },
+	{ 0x5a, 4, 1, ACL_ATTR_ARRAY(tx_packets_by_type, 6) },
+	{ 0x5b, 4, 1, ACL_ATTR_ARRAY(tx_packets_by_type, 7) },
+	{ 0x5c, 4, 1, ACL_ATTR_ARRAY(tx_packets_by_type, 8) },
+	{ 0x5d, 4, 1, ACL_ATTR(rx_packets) },
+	{ 0x5e, 4, 1, ACL_ATTR(link_throughput) },
+	{ 0x5f, 4, 1, ACL_ATTR(max_packet_letency) },
+	{ 0x60, 4, 1, ACL_ATTR(avg_packet_letency) },
+
+	/* SCO/eSCO audio link quality subevents */
+	{ 0x6a, 2, 1, SCO_ATTR(conn_handle) },
+	{ 0x6b, 4, 1, SCO_ATTR(packets_from_host) },
+	{ 0x6c, 4, 1, SCO_ATTR(tx_packets) },
+	{ 0x6d, 4, 1, SCO_ATTR(rx_payload_lost) },
+	{ 0x6e, 4, 1, SCO_ATTR(tx_payload_lost) },
+	{ 0x6f, 4, 5, SCO_ATTR(rx_no_sync_error) },
+	{ 0x70, 4, 5, SCO_ATTR(rx_hec_error) },
+	{ 0x71, 4, 5, SCO_ATTR(rx_crc_error) },
+	{ 0x72, 4, 5, SCO_ATTR(rx_nak_error) },
+	{ 0x73, 4, 5, SCO_ATTR(tx_failed_wifi_coex) },
+	{ 0x74, 4, 5, SCO_ATTR(rx_failed_wifi_coex) },
+	{ 0x75, 4, 1, SCO_ATTR(samples_inserted_by_CDC) },
+	{ 0x76, 4, 1, SCO_ATTR(samples_dropped) },
+	{ 0x77, 4, 1, SCO_ATTR(mute_samples) },
+	{ 0x78, 4, 1, SCO_ATTR(plc_injection) },
+
+	/* end */
+	{ 0x0, 0, 0 }
+};
+
+bool is_manufacturer_intel(uint16_t manufacturer)
+{
+	return manufacturer == COMPANY_ID_INTEL;
+}
+
+void intel_set_debug(intel_debug_func_t callback, void *user_data)
+{
+	intel_debug.callback = callback;
+	intel_debug.data = user_data;
+}
+
+static void debug(const char *format, ...)
+{
+	va_list ap;
+	char str[256];
+
+	if (!intel_debug.callback || !intel_debug.data)
+		return;
+
+	va_start(ap, format);
+	vsnprintf(str, sizeof(str), format, ap);
+	intel_debug.callback(str, intel_debug.data);
+	va_end(ap);
+}
+
+static void print_intel_telemetry_evt(struct intel_ext_telemetry_event *tev)
+{
+	if (!tev)
+		return;
+
+	if (tev->link_type == TELEMETRY_ACL_LINK) {
+		struct intel_acl_event *acl = &tev->conn.acl;
+		int i;
+
+		debug("Intel Extended Telemetry Event");
+		debug("  ACL connection handle: 0x%4.4x", acl->conn_handle);
+		debug("  Rx HEC errors: %u", acl->rx_hec_error);
+		debug("  Rx CRC errors: %u", acl->rx_crc_error);
+		debug("  Packets from host: %u", acl->packets_from_host);
+		debug("  Tx packets: %u", acl->tx_packets);
+
+		for (i = 0; i < INTEL_NUM_RETRIES; i++)
+			debug("  Tx packets %u retries: %u",
+						i, acl->tx_packets_retry[i]);
+
+		for (i = 0; i < INTEL_NUM_PACKET_TYPES; i++)
+			debug("  Tx %s packets: %u", bredr_packet_type[i],
+						acl->tx_packets_by_type[i]);
+
+		debug("  Rx packets: %u", acl->rx_packets);
+		debug("  ACL link throughput: %u", acl->link_throughput);
+		debug("  ACL max packet latency: %u", acl->max_packet_letency);
+		debug("  ACL avg packet latency: %u", acl->avg_packet_letency);
+
+	} else if (tev->link_type == TELEMETRY_SCO_LINK) {
+		struct intel_sco_event *sco = &tev->conn.sco;
+		int i;
+
+		debug("Intel Extended Telemetry Event");
+		debug("  SCO connection handle: 0x%4.4x", sco->conn_handle);
+		debug("  Packets from host: %u", sco->packets_from_host);
+		debug("  Tx packets: %u", sco->tx_packets);
+		debug("  Rx payload lost: %u", sco->rx_payload_lost);
+		debug("  Tx payload lost: %u", sco->tx_payload_lost);
+
+		for (i = 0; i < INTEL_NUM_SLOTS; i++)
+			debug("  Rx No SYNC errors (slot %u): %u",
+						i, sco->rx_no_sync_error[i]);
+
+		for (i = 0; i < INTEL_NUM_SLOTS; i++)
+			debug("  Rx HEC errors (slot %u): %u",
+						i, sco->rx_hec_error[i]);
+
+		for (i = 0; i < INTEL_NUM_SLOTS; i++)
+			debug("  Rx CRC errors (slot %u): %u",
+						i, sco->rx_crc_error[i]);
+
+		for (i = 0; i < INTEL_NUM_SLOTS; i++)
+			debug("  Rx NAK errors (slot %u): %u",
+						i, sco->rx_nak_error[i]);
+
+		for (i = 0; i < INTEL_NUM_SLOTS; i++)
+			debug("  Failed Tx due to Wifi coex (slot %u): %u",
+						i, sco->tx_failed_wifi_coex[i]);
+
+		for (i = 0; i < INTEL_NUM_SLOTS; i++)
+			debug("  Failed Rx due to Wifi coex (slot %u): %u",
+						i, sco->rx_failed_wifi_coex[i]);
+
+		debug("  Late samples inserted based on CDC: %u",
+						sco->samples_inserted_by_CDC);
+		debug("  Samples dropped: %u", sco->samples_dropped);
+		debug("  Mute samples sent at initial connection: %u",
+						sco->mute_samples);
+		debug("  PLC injection data: %u", sco->plc_injection);
+	}
+}
+
+static const struct intel_tlv *process_ext_subevent(
+					struct intel_ext_telemetry_event *tev,
+					const struct intel_tlv *tlv,
+					const struct intel_tlv *last_tlv)
+{
+	const struct intel_tlv *next_tlv = NEXT_TLV(tlv);
+	const struct intel_ext_subevent *subevent = NULL;
+	int i;
+
+	for (i = 0; intel_ext_subevent_table[i].size > 0; i++) {
+		if (intel_ext_subevent_table[i].id == tlv->id) {
+			subevent = &intel_ext_subevent_table[i];
+			break;
+		}
+	}
+
+	if (!subevent) {
+		debug("error: unknown Intel telemetry subevent 0x%2.2x",
+			tlv->id);
+		return NULL;
+	}
+
+	if (tlv->length != subevent->size * subevent->elements) {
+		debug("error: invalid length %d of subevent 0x%2.2x",
+			tlv->length, tlv->id);
+		return NULL;
+	}
+
+	if (next_tlv > last_tlv) {
+		debug("error: subevent 0x%2.2x exceeds the buffer size.",
+			tlv->id);
+		return NULL;
+	}
+
+	/* Assign tlv value to the corresponding attribute of acl/sco struct. */
+	switch (subevent->size) {
+	case 1:
+		*subevent->attr = get_u8(tlv->value);
+		break;
+
+	case 2:
+		*((uint16_t *)subevent->attr) = get_le16(tlv->value);
+		break;
+
+	case 4:
+		if (subevent->elements == 1) {
+			*((uint32_t *)subevent->attr) = get_le32(tlv->value);
+			break;
+		}
+
+		for (i = 0; i < subevent->elements; i++) {
+			/* Both acl and sco structs are __packed such that
+			 * the addresses of array elements can be calculated.
+			 */
+			*((uint32_t *)(subevent->attr + i * subevent->size)) =
+					get_le32((uint32_t *)tlv->value + i);
+		}
+		break;
+
+	default:
+		debug("error: subevent id %u: size %u not supported",
+			subevent->id, subevent->size);
+		break;
+
+	}
+
+	switch (subevent->id) {
+	case EXT_EVT_TYPE:
+		/* Only interested in the LINK_QUALITY_REPORT type for now. */
+		if (*subevent->attr != LINK_QUALITY_REPORT)
+			return NULL;
+		break;
+
+	case ACL_CONNECTION_HANDLE:
+		tev->link_type = TELEMETRY_ACL_LINK;
+		break;
+
+	case SCO_CONNECTION_HANDLE:
+		tev->link_type = TELEMETRY_SCO_LINK;
+		break;
+
+	default:
+		break;
+	}
+
+	return next_tlv;
+}
+
+bool process_intel_telemetry_report(const struct mgmt_ev_quality_report *ev)
+{
+	/* The ev->report points to a number of consecutive tlv.*/
+	const struct intel_tlv *tlv = (const struct intel_tlv *)ev->report;
+	const struct intel_tlv *last_tlv =
+			(const struct intel_tlv *)(ev->report + ev->report_len);
+
+	/* Read every tlv subevent into tev.
+	 * The decoding process terminates normally when tlv == last_tlv.
+	 */
+	memset(&tev, 0, sizeof(tev));
+	while (tlv && tlv < last_tlv)
+		tlv = process_ext_subevent(&tev, tlv, last_tlv);
+
+	/* If the decoding completes successfully, tlv would be non-NULL */
+	if (tlv) {
+		print_intel_telemetry_evt(&tev);
+		return true;
+	}
+
+	return false;
+}
diff --git a/src/shared/intel.h b/src/shared/intel.h
new file mode 100644
index 000000000..2b20f803e
--- /dev/null
+++ b/src/shared/intel.h
@@ -0,0 +1,155 @@
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
+#ifndef __INTEL_H
+#define __INTEL_H
+
+#include <stdbool.h>
+
+struct mgmt_ev_quality_report;
+
+enum intel_telemetry_event_type {
+	SYSTEM_EXCEPTION,
+	FATAL_EXCEPTION,
+	DEBUG_EXCEPTION,
+	CONNECTION_EVENT,
+	DISCONNECTION_EVENT,
+	LINK_QUALITY_REPORT,
+};
+
+enum intel_telemetry_link_type {
+	TELEMETRY_UNKNOWN_LINK,
+	TELEMETRY_ACL_LINK,
+	TELEMETRY_SCO_LINK,
+};
+
+/* The subevent indices of the complete list of Intel telemetry subevents. */
+enum intel_subevt_list {
+	EXT_EVT_TYPE = 0x01,
+
+	ACL_CONNECTION_HANDLE = 0x4a,
+	ACL_HEC_ERRORS,
+	ACL_CRC_ERRORS,
+	ACL_PACKETS_FROM_HOST,
+	ACL_TX_PACKETS_TO_AIR,
+	ACL_TX_PACKETS_0_RETRY,
+	ACL_TX_PACKETS_1_RETRY,
+	ACL_TX_PACKETS_2_RETRY,
+	ACL_TX_PACKETS_3_RETRY,
+	ACL_TX_PACKETS_MORE_RETRY,
+	ACL_TX_PACKETS_DH1,
+	ACL_TX_PACKETS_DH3,
+	ACL_TX_PACKETS_DH5,
+	ACL_TX_PACKETS_2DH1,
+	ACL_TX_PACKETS_2DH3,
+	ACL_TX_PACKETS_2DH5,
+	ACL_TX_PACKETS_3DH1,
+	ACL_TX_PACKETS_3DH3,
+	ACL_TX_PACKETS_3DH5,
+	ACL_RX_PACKETS,
+	ACL_LINK_THROUGHPUT,
+	ACL_MAX_PACKET_LATENCY,
+	ACL_AVG_PACKET_LATENCY,
+
+	SCO_CONNECTION_HANDLE = 0x6a,
+	SCO_RX_PACKETS,
+	SCO_TX_PACKETS,
+	SCO_RX_PACKETS_LOST,
+	SCO_TX_PACKETS_LOST,
+	SCO_RX_NO_SYNC_ERROR,
+	SCO_RX_HEC_ERROR,
+	SCO_RX_CRC_ERROR,
+	SCO_RX_NAK_ERROR,
+	SCO_TX_FAILED_BY_WIFI,
+	SCO_RX_FAILED_BY_WIFI,
+	SCO_SAMPLES_INSERTED,
+	SCO_SAMPLES_DROPPED,
+	SCO_MUTE_SAMPLES,
+	SCO_PLC_INJECTION_DATA,
+};
+
+#define INTEL_NUM_SLOTS		5
+#define INTEL_NUM_RETRIES	5
+#define INTEL_NUM_PACKET_TYPES	9
+
+/* An Intel telemetry subevent is of the TLV format.
+ * - id: takes 1 byte. This is the subevent id.
+ * - length: takes 1 byte.
+ * - value: takes |length| bytes.
+ */
+struct intel_tlv {
+	uint8_t id;
+	uint8_t length;
+	uint8_t value[0];
+};
+
+#define TLV_SIZE(tlv) (*((const uint8_t *) tlv + 1) + 2 * sizeof(uint8_t))
+#define NEXT_TLV(tlv) ((const struct intel_tlv *)\
+					((const uint8_t *)tlv + TLV_SIZE(tlv)))
+
+struct intel_acl_event {
+	uint16_t conn_handle;
+	uint32_t rx_hec_error;
+	uint32_t rx_crc_error;
+	uint32_t packets_from_host;
+	uint32_t tx_packets;
+	uint32_t tx_packets_retry[INTEL_NUM_RETRIES];
+	uint32_t tx_packets_by_type[INTEL_NUM_PACKET_TYPES];
+	uint32_t rx_packets;
+	uint32_t link_throughput;
+	uint32_t max_packet_letency;
+	uint32_t avg_packet_letency;
+} __packed;
+
+struct intel_sco_event {
+	uint16_t conn_handle;
+	uint32_t packets_from_host;
+	uint32_t tx_packets;
+	uint32_t rx_payload_lost;
+	uint32_t tx_payload_lost;
+	uint32_t rx_no_sync_error[INTEL_NUM_SLOTS];
+	uint32_t rx_hec_error[INTEL_NUM_SLOTS];
+	uint32_t rx_crc_error[INTEL_NUM_SLOTS];
+	uint32_t rx_nak_error[INTEL_NUM_SLOTS];
+	uint32_t tx_failed_wifi_coex[INTEL_NUM_SLOTS];
+	uint32_t rx_failed_wifi_coex[INTEL_NUM_SLOTS];
+	uint32_t samples_inserted_by_CDC;
+	uint32_t samples_dropped;
+	uint32_t mute_samples;
+	uint32_t plc_injection;
+} __packed;
+
+struct intel_ext_telemetry_event {
+	uint8_t telemetry_ev_type; /* one in enum intel_telemetry_event_type */
+	uint8_t link_type;
+	union {
+		struct intel_sco_event sco;
+		struct intel_acl_event acl;
+	} conn;
+} __packed;
+
+typedef void (*intel_debug_func_t)(const char *str, void *user_data);
+
+bool is_manufacturer_intel(uint16_t manufacturer);
+void intel_set_debug(intel_debug_func_t callback, void *user_data);
+
+bool process_intel_telemetry_report(const struct mgmt_ev_quality_report *ev);
+
+#endif /* __INTEL_H */
-- 
2.35.0.rc0.227.g00780c9af4-goog

