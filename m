Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7472BC48BDF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 07:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3F561139
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 07:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhFRH7m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jun 2021 03:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhFRH7i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jun 2021 03:59:38 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDB4C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 00:57:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso5381693pjb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6BQoz8ehRFDJXPjl0RKbab6MVr0CDK9rSTRp7fElzQ=;
        b=AebFidX6cNqHqn6s+y9Va1YLVKm7dwc+YT6ILBSOJkwHTrPRIeNQ+NbiUJi3hibmVB
         6fP9/7eaJTjMZ4PH8+XYkvIfMk5DuHM5qzHk7qH3xuN/DuY/JB74nqZXWiPIgZCKNBn+
         XWbjl/EQnm3JTS/XbbIjARNhp9BzOBNtMPYoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6BQoz8ehRFDJXPjl0RKbab6MVr0CDK9rSTRp7fElzQ=;
        b=eEjGJ7idK+3pwv0mMFAHpkavkZm67LemzKElUDysfMMqOaqNJ5KrFMuYA8SD9JZjnc
         m4JoiLses7Gea7SSYatRl9MNWaHNNSEl1FtBzGy3bInu5b5izThLQf2HLi+RD5t4cswP
         v+O4eEYRcaFn7z0FfSbQxqL4PLlgDme4Y2pUopK5D1EMu5Lwh8lzSlWGu/J1tOEaUihC
         W6IQ3Vn5Lhp1PR6Xnj/83zItB4f4Xx+8/xS9OGmDJa1e8tG35F2wl6giI5agoKzvX6n3
         c/hzCFYty0UTd+MpdpBXDx7/AANhg/KRLM09kvxgCUCdeMZ8xuKpQgI6f3bd7V36uCCg
         YTMQ==
X-Gm-Message-State: AOAM531RqX7UVxsAFmI32dC5laQutCnyrj7jCfE8efrLr2xfXl0TYQTc
        vNSjRGFvFfmu6OHP/aWC2nqlxlMfq1IikQ==
X-Google-Smtp-Source: ABdhPJyNhDHsVDtDPfIewSp+oRX8znhuzPG7CmXTp0VXE5/O0gShL7dxfc2C4h5qwgZDuh2AwlM+hA==
X-Received: by 2002:a17:90a:fb51:: with SMTP id iq17mr9685939pjb.26.1624003048758;
        Fri, 18 Jun 2021 00:57:28 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:6cbb:95eb:e2ae:8479])
        by smtp.gmail.com with ESMTPSA id z185sm7879219pgb.4.2021.06.18.00.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 00:57:28 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH v1 1/3] monitor: add new Intel extended telemetry events
Date:   Fri, 18 Jun 2021 15:57:15 +0800
Message-Id: <20210618155610.v1.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds new Intel extended telemetry events for both ACL and
SCO/eSCO audio link quality reports.

For SCO/eSCO audio link quality report, it shows something like
> HCI Event: Vendor (0xff) plen 190  #120 [hci0] 2021-05-31 20:27:50.257
      Intel Extended Telemetry (0x87)
        Extended Telemetry (0x80): SubOpcode (0x03)
        Extended event type (0x01): Audio Link Quality Report Type(0x05)
        SCO/eSCO connection handle (0x6a): 0x0101
        Packets from host (0x6b): 399
        Tx packets (0x6c): 403
        Rx payload lost (0x6d): 3
        Tx payload lost (0x6e): 0
        Rx No SYNC errors (0x6f): 3 2 3 3 0
        Rx HEC errors (0x70): 0 0 0 0 0
        Rx CRC errors (0x71): 2 0 0 0 0
        Rx NAK errors (0x72): 6 0 0 0 0
        Failed Tx due to Wifi coex (0x73): 6 0 0 0 0
        Failed Rx due to Wifi coex (0x74): 0 0 0 0 0
        Late samples inserted based on CDC (0x75): 0
        Samples dropped (0x76): 0
        Mute samples sent at initial connection (0x77): 0
        PLC injection data (0x78): 0

For ACL audio link quality report, it shows something like
> HCI Event: Vendor (0xff) plen 142  #120 [hci0] 2021-05-31 20:27:50.261
      Intel Extended Telemetry (0x87)
        Extended Telemetry (0x80): SubOpcode (0x03)
        Extended event type (0x01): Audio Link Quality Report Type(0x05)
        ACL connection handle (0x4a): 0x0100
        Rx HEC errors (0x4b): 0
        Rx CRC errors (0x4c): 0
        Packets from host (0x4d): 100
        Tx packets (0x4e): 101
        Tx packets 0 retries (0x4f): 89
        Tx packets 1 retries (0x50): 11
        Tx packets 2 retries (0x51): 1
        Tx packets 3 retries (0x52): 0
        Tx packets 4 retries and more (0x53): 0
        Tx DH1 packets (0x54): 0
        Tx DH3 packets (0x55): 0
        Tx DH5 packets (0x56): 0
        Tx 2DH1 packets (0x57): 0
        Tx 2DH3 packets (0x58): 0
        Tx 2DH5 packets (0x59): 0
        Tx 3DH1 packets (0x5a): 6
        Tx 3DH3 packets (0x5b): 0
        Tx 3DH5 packets (0x5c): 94
        Rx packets (0x5d): 272
        ACL link throughput (KBps) (0x5e): 343815
        ACL max packet latency (ms) (0x5f): 20625
        ACL avg packet latency (ms) (0x60): 12

series-prefix: bluez
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

 monitor/intel.c  | 469 +++++++++++++++++++++++++++++++++++++++++++++++
 monitor/vendor.h |   6 +
 2 files changed, 475 insertions(+)

diff --git a/monitor/intel.c b/monitor/intel.c
index d2aefa6a8..045d535b6 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -30,6 +30,7 @@
 
 #define COLOR_UNKNOWN_EVENT_MASK	COLOR_WHITE_BG
 #define COLOR_UNKNOWN_SCAN_STATUS	COLOR_WHITE_BG
+#define COLOR_UNKNOWN_EXT_EVENT		COLOR_WHITE_BG
 
 static void print_status(uint8_t status)
 {
@@ -958,6 +959,8 @@ static void system_exception_evt(const void *data, uint8_t size)
 	packet_hexdump(data + 1, size - 1);
 }
 
+static void intel_vendor_ext_evt(const void *data, uint8_t size);
+
 static const struct vendor_evt vendor_evt_table[] = {
 	{ 0x00, "Startup",
 			startup_evt, 0, true },
@@ -989,6 +992,7 @@ static const struct vendor_evt vendor_evt_table[] = {
 			system_exception_evt, 133, true },
 	{ 0x2c, "FW Trace String" },
 	{ 0x2e, "FW Trace Binary" },
+	{ 0x87, "Extended Telemetry", intel_vendor_ext_evt },
 	{ }
 };
 
@@ -1003,3 +1007,468 @@ const struct vendor_evt *intel_vendor_evt(uint8_t evt)
 
 	return NULL;
 }
+
+static void ext_evt_type(uint8_t subevent_id, const void *data, uint8_t size)
+{
+	uint8_t evt_type = get_u8(data);
+	const char *str;
+
+	switch (evt_type) {
+	case 0x00:
+		str = "System Exception";
+		break;
+	case 0x01:
+		str = "Fatal Exception";
+		break;
+	case 0x02:
+		str = "Debug Exception";
+		break;
+	case 0x03:
+		str = "Connection Event for BR/EDR Link Type";
+		break;
+	case 0x04:
+		str = "Disconnection Event";
+		break;
+	case 0x05:
+		str = "Audio Link Quality Report Type";
+		break;
+	case 0x06:
+		str = "Stats for BR/EDR Link Type";
+		break;
+	default:
+		print_text(COLOR_UNKNOWN_EXT_EVENT,
+			"Unknown extended telemetry event type (0x%2.2x)",
+			evt_type);
+		packet_hexdump(data, size);
+		return;
+	}
+
+	print_field("Extended event type (0x%2.2x): %s (0x%2.2x)",
+			subevent_id, str, evt_type);
+}
+
+static void ext_acl_evt_conn_handle(uint8_t subevent_id, const void *data,
+					uint8_t size)
+{
+	uint16_t conn_handle = get_le16(data);
+
+	print_field("ACL connection handle (0x%2.2x): 0x%4.4x",
+			subevent_id, conn_handle);
+}
+
+static void ext_acl_evt_hec_errors(uint8_t subevent_id, const void *data,
+					uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("Rx HEC errors (0x%2.2x): %d", subevent_id, num);
+}
+
+static void ext_acl_evt_crc_errors(uint8_t subevent_id, const void *data,
+					uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("Rx CRC errors (0x%2.2x): %d", subevent_id, num);
+}
+
+static void ext_acl_evt_num_pkt_from_host(uint8_t subevent_id, const void *data,
+						uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("Packets from host (0x%2.2x): %d",
+			subevent_id, num);
+}
+
+static void ext_acl_evt_num_tx_pkt_to_air(uint8_t subevent_id, const void *data,
+						uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("Tx packets (0x%2.2x): %d", subevent_id, num);
+}
+
+static void ext_acl_evt_num_tx_pkt_retry(uint8_t subevent_id, const void *data,
+						uint8_t size)
+{
+	char *subevent_str;
+	uint32_t num = get_le32(data);
+
+	switch (subevent_id) {
+	case 0x4f:
+		subevent_str = "Tx packets 0 retries";
+		break;
+	case 0x50:
+		subevent_str = "Tx packets 1 retries";
+		break;
+	case 0x51:
+		subevent_str = "Tx packets 2 retries";
+		break;
+	case 0x52:
+		subevent_str = "Tx packets 3 retries";
+		break;
+	case 0x53:
+		subevent_str = "Tx packets 4 retries and more";
+		break;
+	default:
+		subevent_str = "Unknown";
+		break;
+	}
+
+	print_field("%s (0x%2.2x): %d", subevent_str, subevent_id, num);
+}
+
+static void ext_acl_evt_num_tx_pkt_type(uint8_t subevent_id, const void *data,
+					uint8_t size)
+{
+	char *packet_type_str;
+	uint32_t num = get_le32(data);
+
+	switch (subevent_id) {
+	case 0x54:
+		packet_type_str = "DH1";
+		break;
+	case 0x55:
+		packet_type_str = "DH3";
+		break;
+	case 0x56:
+		packet_type_str = "DH5";
+		break;
+	case 0x57:
+		packet_type_str = "2DH1";
+		break;
+	case 0x58:
+		packet_type_str = "2DH3";
+		break;
+	case 0x59:
+		packet_type_str = "2DH5";
+		break;
+	case 0x5a:
+		packet_type_str = "3DH1";
+		break;
+	case 0x5b:
+		packet_type_str = "3DH3";
+		break;
+	case 0x5c:
+		packet_type_str = "3DH5";
+		break;
+	default:
+		packet_type_str = "Unknown";
+		break;
+	}
+
+	print_field("Tx %s packets (0x%2.2x): %d",
+			packet_type_str, subevent_id, num);
+}
+
+static void ext_acl_evt_num_rx_pkt_from_air(uint8_t subevent_id,
+						const void *data, uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("Rx packets (0x%2.2x): %d",
+			subevent_id, num);
+}
+
+static void ext_acl_evt_link_throughput(uint8_t subevent_id, const void *data,
+					uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("ACL link throughput (KBps) (0x%2.2x): %d",
+			subevent_id, num);
+}
+
+static void ext_acl_evt_max_packet_latency(uint8_t subevent_id,
+						const void *data, uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("ACL max packet latency (ms) (0x%2.2x): %d",
+			subevent_id, num);
+}
+
+static void ext_acl_evt_avg_packet_latency(uint8_t subevent_id,
+						const void *data, uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("ACL avg packet latency (ms) (0x%2.2x): %d",
+			subevent_id, num);
+}
+
+static void ext_sco_evt_conn_handle(uint8_t subevent_id, const void *data,
+					uint8_t size)
+{
+	uint16_t conn_handle = get_le16(data);
+
+	print_field("SCO/eSCO connection handle (0x%2.2x): 0x%4.4x",
+			subevent_id, conn_handle);
+}
+
+static void ext_sco_evt_num_rx_pkt_from_air(uint8_t subevent_id,
+						const void *data, uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("Packets from host (0x%2.2x): %d", subevent_id, num);
+}
+
+static void ext_sco_evt_num_tx_pkt_to_air(uint8_t subevent_id, const void *data,
+						uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("Tx packets (0x%2.2x): %d", subevent_id, num);
+}
+
+static void ext_sco_evt_num_rx_payloads_lost(uint8_t subevent_id,
+						const void *data, uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("Rx payload lost (0x%2.2x): %d", subevent_id, num);
+}
+
+static void ext_sco_evt_num_tx_payloads_lost(uint8_t subevent_id,
+						const void *data, uint8_t size)
+{
+
+	uint32_t num = get_le32(data);
+
+	print_field("Tx payload lost (0x%2.2x): %d", subevent_id, num);
+}
+
+static void slots_errors(const char *type_str, uint8_t subevent_id,
+				const void *data, uint8_t size)
+{
+	/* The subevent has 5 slots where each slot is of the uint32_t type. */
+	uint32_t num[5];
+	int i;
+
+	if (size != 5 * sizeof(uint32_t)) {
+		print_text(COLOR_UNKNOWN_EXT_EVENT,
+				"  Invalid subevent length (%d)", size);
+		return;
+	}
+
+	for (i = 0; i < 5; i++) {
+		num[i] = get_le32(data);
+		data = (const void *)((const uint8_t *) data +
+						sizeof(uint32_t));
+	}
+
+	print_field("%s (0x%2.2x): %d %d %d %d %d", type_str, subevent_id,
+			num[0], num[1], num[2], num[3], num[4]);
+}
+
+static void ext_sco_evt_num_no_sync_errors(uint8_t subevent_id,
+						const void *data, uint8_t size)
+{
+	slots_errors("Rx No SYNC errors", subevent_id, data, size);
+}
+
+static void ext_sco_evt_num_hec_errors(uint8_t subevent_id, const void *data,
+					uint8_t size)
+{
+	slots_errors("Rx HEC errors", subevent_id, data, size);
+}
+
+static void ext_sco_evt_num_crc_errors(uint8_t subevent_id, const void *data,
+					uint8_t size)
+{
+	slots_errors("Rx CRC errors", subevent_id, data, size);
+}
+
+static void ext_sco_evt_num_naks(uint8_t subevent_id, const void *data,
+					uint8_t size)
+{
+	slots_errors("Rx NAK errors", subevent_id, data, size);
+}
+
+static void ext_sco_evt_num_failed_tx_by_wifi(uint8_t subevent_id,
+						const void *data, uint8_t size)
+{
+	slots_errors("Failed Tx due to Wifi coex", subevent_id, data, size);
+}
+
+static void ext_sco_evt_num_failed_rx_by_wifi(uint8_t subevent_id,
+						const void *data, uint8_t size)
+{
+	slots_errors("Failed Rx due to Wifi coex", subevent_id, data, size);
+}
+
+static void ext_sco_evt_samples_inserted(uint8_t subevent_id, const void *data,
+						uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("Late samples inserted based on CDC (0x%2.2x): %d",
+			subevent_id, num);
+}
+
+static void ext_sco_evt_samples_dropped(uint8_t subevent_id, const void *data,
+					uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("Samples dropped (0x%2.2x): %d", subevent_id, num);
+}
+
+static void ext_sco_evt_mute_samples(uint8_t subevent_id, const void *data,
+					uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("Mute samples sent at initial connection (0x%2.2x): %d",
+			subevent_id, num);
+}
+
+static void ext_sco_evt_plc_injection_data(uint8_t subevent_id,
+						const void *data, uint8_t size)
+{
+	uint32_t num = get_le32(data);
+
+	print_field("PLC injection data (0x%2.2x): %d", subevent_id, num);
+}
+
+
+static const struct vendor_ext_subevent vendor_ext_subevent_table[] = {
+	{ 0x01, 1, ext_evt_type },
+
+	/* ACL audio link quality subevents */
+	{ 0x4a, 2, ext_acl_evt_conn_handle },
+	{ 0x4b, 4, ext_acl_evt_hec_errors },
+	{ 0x4c, 4, ext_acl_evt_crc_errors },
+	{ 0x4d, 4, ext_acl_evt_num_pkt_from_host },
+	{ 0x4e, 4, ext_acl_evt_num_tx_pkt_to_air },
+	{ 0x4f, 4, ext_acl_evt_num_tx_pkt_retry },
+	{ 0x50, 4, ext_acl_evt_num_tx_pkt_retry },
+	{ 0x51, 4, ext_acl_evt_num_tx_pkt_retry },
+	{ 0x52, 4, ext_acl_evt_num_tx_pkt_retry },
+	{ 0x53, 4, ext_acl_evt_num_tx_pkt_retry },
+	{ 0x54, 4, ext_acl_evt_num_tx_pkt_type },
+	{ 0x55, 4, ext_acl_evt_num_tx_pkt_type },
+	{ 0x56, 4, ext_acl_evt_num_tx_pkt_type },
+	{ 0x57, 4, ext_acl_evt_num_tx_pkt_type },
+	{ 0x58, 4, ext_acl_evt_num_tx_pkt_type },
+	{ 0x59, 4, ext_acl_evt_num_tx_pkt_type },
+	{ 0x5a, 4, ext_acl_evt_num_tx_pkt_type },
+	{ 0x5b, 4, ext_acl_evt_num_tx_pkt_type },
+	{ 0x5c, 4, ext_acl_evt_num_tx_pkt_type },
+	{ 0x5d, 4, ext_acl_evt_num_rx_pkt_from_air },
+	{ 0x5e, 4, ext_acl_evt_link_throughput },
+	{ 0x5f, 4, ext_acl_evt_max_packet_latency },
+	{ 0x60, 4, ext_acl_evt_avg_packet_latency },
+
+	/* SCO/eSCO audio link quality subevents */
+	{ 0x6a, 2, ext_sco_evt_conn_handle },
+	{ 0x6b, 4, ext_sco_evt_num_rx_pkt_from_air },
+	{ 0x6c, 4, ext_sco_evt_num_tx_pkt_to_air },
+	{ 0x6d, 4, ext_sco_evt_num_rx_payloads_lost },
+	{ 0x6e, 4, ext_sco_evt_num_tx_payloads_lost },
+	{ 0x6f, 20, ext_sco_evt_num_no_sync_errors },
+	{ 0x70, 20, ext_sco_evt_num_hec_errors },
+	{ 0x71, 20, ext_sco_evt_num_crc_errors },
+	{ 0x72, 20, ext_sco_evt_num_naks },
+	{ 0x73, 20, ext_sco_evt_num_failed_tx_by_wifi },
+	{ 0x74, 20, ext_sco_evt_num_failed_rx_by_wifi },
+	{ 0x75, 4, ext_sco_evt_samples_inserted },
+	{ 0x76, 4, ext_sco_evt_samples_dropped },
+	{ 0x77, 4, ext_sco_evt_mute_samples },
+	{ 0x78, 4, ext_sco_evt_plc_injection_data },
+
+	/* end */
+	{ 0x0, 0}
+};
+
+static const uint8_t process_ext_subevent(const uint8_t *data)
+{
+	/*
+	 * A subevent is of the TLV format.
+	 * - Type: takes 1 byte. This is the subevent_id.
+	 * - Length: takes 1 byte.
+	 * - Value: takes |Length| bytes.
+	 */
+	uint8_t subevent_id = *data;
+	uint8_t length = *(data + 1);
+	uint16_t subevent_size = 2 + length;
+	const struct vendor_ext_subevent *subevent = NULL;
+	int i;
+
+	for (i = 0; vendor_ext_subevent_table[i].length > 0; i++) {
+		if (vendor_ext_subevent_table[i].subevent_id == subevent_id) {
+			subevent = &vendor_ext_subevent_table[i];
+			break;
+		}
+	}
+
+	if (!subevent) {
+		print_text(COLOR_UNKNOWN_EXT_EVENT,
+				"  Unknown extended event type id (0x%2.2x)",
+				subevent_id);
+		return subevent_size;
+	}
+
+	if (length != subevent->length) {
+		print_text(COLOR_UNKNOWN_EXT_EVENT, "  Invalid event length");
+		return subevent_size;
+	}
+
+	subevent->func(subevent_id, data + 2, length);
+
+	return subevent_size;
+}
+
+static void intel_vendor_ext_evt(const void *data, uint8_t size)
+{
+	uint8_t *tlv = (const uint8_t *) data;
+	uint8_t ext_telemetry_type = *tlv;
+	uint8_t sub_opcode = *(tlv + 1);
+	uint16_t subevent_size;
+	uint16_t processed_size = 0;
+
+	/*
+	 * Intel extended telemetry event is of the format:
+	 *   Event Code: 0xff
+	 *   Length:     0xnn
+	 *   Event Type: 0x8780
+	 *   SubOpcode:  0x03
+	 *   A number of TLV data
+	 *
+	 *   Each TLV Data, i.e., a subevent, consists of
+	 *     Subevent Id
+	 *     Length
+	 *     Value
+	 *
+	 * Arrives here through the telemetry event (0x87) in vendor_evt_table.
+	 * It is required to further check the extended telemetry type (0x80)
+	 * and sub-opcode (0x03) in the tlv data.
+	 */
+	if (ext_telemetry_type == 0x80 && sub_opcode == 0x03) {
+		/* Consumed two octets, i.e., 0x80 and 0x03. */
+		print_field("Extended Telemetry (0x%2.2x): SubOpcode (0x%2.2x)",
+				ext_telemetry_type, sub_opcode);
+		processed_size += 2;
+		tlv += 2;
+	} else {
+		print_text(COLOR_UNKNOWN_EXT_EVENT,
+			"  Unknown extended telemetry event (0x%2.2x 0x%2.2x)",
+			ext_telemetry_type, sub_opcode);
+		packet_hexdump(data, size);
+		return;
+	}
+
+	/* Process every TLV subevent data. */
+	while (processed_size < size) {
+		subevent_size = process_ext_subevent(tlv);
+		processed_size += subevent_size;
+		tlv += subevent_size;
+	}
+
+	if (processed_size > size) {
+		print_field("Error: processed size 0x%2.2x is greater than "
+				"total size (0x%2.2x)", processed_size, size);
+	}
+}
diff --git a/monitor/vendor.h b/monitor/vendor.h
index c70552b66..347b4bfe9 100644
--- a/monitor/vendor.h
+++ b/monitor/vendor.h
@@ -30,4 +30,10 @@ struct vendor_evt {
 	bool evt_fixed;
 };
 
+struct vendor_ext_subevent {
+	uint8_t subevent_id;
+	uint8_t length;
+	void (*func)(uint8_t subevent_id, const void *data, uint8_t size);
+};
+
 void vendor_event(uint16_t manufacturer, const void *data, uint8_t size);
-- 
2.32.0.288.g62a8d224e6-goog

