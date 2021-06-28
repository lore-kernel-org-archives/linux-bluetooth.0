Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A74BC49EAB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 08:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0556361C2F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 08:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhF1IYc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhF1IYb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 04:24:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DF5C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 01:22:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h1so8503487plt.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 01:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xoLz0ysx0yxzjTJvX9YDCGa4YTDdfn2KYAvEiyrlCJQ=;
        b=nGtEUvuRGTnnFWgvnglod77amNzEQBaKPPx7i915xjWFddG0FRBC96TKW3nKIyKdAW
         525Zcry12jlLUx9wJrcojx8pFVENSwDxvsLY52Z2D0yKqwGn11DnGdeFxEao57VD0u6o
         8c08ym0ZBIXV7aw0ovd8MSyUIFJXVSuZ1ZLYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xoLz0ysx0yxzjTJvX9YDCGa4YTDdfn2KYAvEiyrlCJQ=;
        b=nijBRZcwq6xLYaie/AdPJkvLy0XuUvenohUT3d2xhM7+grOzKGVIeJYDhjT061u5gp
         Ig6QO9L2iryvC56sDMwryxeK+S16CoQYKAxdlsXEYa3QKjvRl4jrD0VRhnjhtFD7hHcp
         BJifzFEFTXj2oZmqERXrK7C2uJD3Mx7fLjGsZ/Mor/89aaP6vcdESQbKpp61m0AWJRSg
         O38DHp0vsZuFoAqN40+eIABULrsrDEuZYKcU7qnhf8R6LWp8fHyykV9MBt6pkNqGhZkH
         MFPS6EadSeQq4qFGxvN89PfSfoT2oLjrh7jwplXKnMEU28HfQsoi8t7naD9Kv/riU9qd
         /Lkg==
X-Gm-Message-State: AOAM5319zRnW8iq8lTEaI1Q34n/1pUXbYp2/tuYDp7V6GaRfmmojkJcc
        ak07yO42YybW3wsW2AFYosL6UXfdvFwG8g==
X-Google-Smtp-Source: ABdhPJzGVhv2mIBbcGNNclBPvK47oTMbpnVdYOm287PKkKB7QCM3UTAK2DBr39QMpDvQDaA2vz5A4w==
X-Received: by 2002:a17:902:8e88:b029:11c:51bc:def8 with SMTP id bg8-20020a1709028e88b029011c51bcdef8mr21360217plb.57.1624868522192;
        Mon, 28 Jun 2021 01:22:02 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:d73e:91da:d7c7:57a])
        by smtp.gmail.com with ESMTPSA id b22sm5381125pfp.20.2021.06.28.01.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 01:22:01 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v3 1/3] monitor: add new Intel extended telemetry events
Date:   Mon, 28 Jun 2021 16:21:48 +0800
Message-Id: <20210628162107.BlueZ.v3.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds new Intel extended telemetry events for both ACL and
SCO/eSCO audio link quality reports.

For SCO/eSCO audio link quality report, it shows something like
> HCI Event: Vendor (0xff) plen 190  #120 [hci0] 2021-05-31 20:27:50.257
        Vendor Prefix (0x8780)
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
        Vendor Prefix (0x8780)
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

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v3:
- Define the packed struct intel_ext_evt for the extended telemetry
  event.
- Define the packed struct intel_tlv for the telemetry subevent.
- Define a new function intel_vendor_prefix_evt() to handle the new
  vendor event type with a vendor prefix
      0xff <length> <vendor_prefix> <subopcode> <data>
  while intel_vendor_evt() handles the original vendor event type
      0xff <length> <subopcode> <data>
- Add the vendor_prefix_evt_table table so that more subopcodes can be
  added for the events with a vendor prefix.
- Move the event data buffer check after processing the current tlv.
- Fix typos.

Changes in v2:
- Perform size checks for tlv subevents.
- Fix the Make errors about qualifiers.

 monitor/intel.c  | 492 ++++++++++++++++++++++++++++++++++++++++++++++-
 monitor/intel.h  |   2 +-
 monitor/packet.c |  19 +-
 3 files changed, 504 insertions(+), 9 deletions(-)

diff --git a/monitor/intel.c b/monitor/intel.c
index d2aefa6a8..e350fd140 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -30,6 +30,7 @@
 
 #define COLOR_UNKNOWN_EVENT_MASK	COLOR_WHITE_BG
 #define COLOR_UNKNOWN_SCAN_STATUS	COLOR_WHITE_BG
+#define COLOR_UNKNOWN_EXT_EVENT		COLOR_WHITE_BG
 
 static void print_status(uint8_t status)
 {
@@ -992,14 +993,501 @@ static const struct vendor_evt vendor_evt_table[] = {
 	{ }
 };
 
-const struct vendor_evt *intel_vendor_evt(uint8_t evt)
+/*
+ * An Intel telemetry subevent is of the TLV format.
+ * - Type: takes 1 byte. This is the subevent_id.
+ * - Length: takes 1 byte.
+ * - Value: takes |Length| bytes.
+ */
+struct intel_tlv {
+	uint8_t subevent_id;
+	uint8_t length;
+	uint8_t value[];
+};
+
+#define TLV_SIZE(tlv) (*((const uint8_t *) tlv + 1) + 2 * sizeof(uint8_t))
+#define NEXT_TLV(tlv) (const struct intel_tlv *) \
+					((const uint8_t *) tlv + TLV_SIZE(tlv))
+
+static void ext_evt_type(const struct intel_tlv *tlv)
+{
+	uint8_t evt_type = get_u8(tlv->value);
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
+		packet_hexdump((const void *) tlv,
+					tlv->length + 2 * sizeof(uint8_t));
+		return;
+	}
+
+	print_field("Extended event type (0x%2.2x): %s (0x%2.2x)",
+			tlv->subevent_id, str, evt_type);
+}
+
+static void ext_acl_evt_conn_handle(const struct intel_tlv *tlv)
+{
+	uint16_t conn_handle = get_le16(tlv->value);
+
+	print_field("ACL connection handle (0x%2.2x): 0x%4.4x",
+			tlv->subevent_id, conn_handle);
+}
+
+static void ext_acl_evt_hec_errors(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("Rx HEC errors (0x%2.2x): %d", tlv->subevent_id, num);
+}
+
+static void ext_acl_evt_crc_errors(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("Rx CRC errors (0x%2.2x): %d", tlv->subevent_id, num);
+}
+
+static void ext_acl_evt_num_pkt_from_host(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("Packets from host (0x%2.2x): %d",
+			tlv->subevent_id, num);
+}
+
+static void ext_acl_evt_num_tx_pkt_to_air(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("Tx packets (0x%2.2x): %d", tlv->subevent_id, num);
+}
+
+static void ext_acl_evt_num_tx_pkt_retry(const struct intel_tlv *tlv)
+{
+	char *subevent_str;
+	uint32_t num = get_le32(tlv->value);
+
+	switch (tlv->subevent_id) {
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
+	print_field("%s (0x%2.2x): %d", subevent_str, tlv->subevent_id, num);
+}
+
+static void ext_acl_evt_num_tx_pkt_type(const struct intel_tlv *tlv)
+{
+	char *packet_type_str;
+	uint32_t num = get_le32(tlv->value);
+
+	switch (tlv->subevent_id) {
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
+			packet_type_str, tlv->subevent_id, num);
+}
+
+static void ext_acl_evt_num_rx_pkt_from_air(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("Rx packets (0x%2.2x): %d",
+			tlv->subevent_id, num);
+}
+
+static void ext_acl_evt_link_throughput(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("ACL link throughput (KBps) (0x%2.2x): %d",
+			tlv->subevent_id, num);
+}
+
+static void ext_acl_evt_max_packet_latency(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("ACL max packet latency (ms) (0x%2.2x): %d",
+			tlv->subevent_id, num);
+}
+
+static void ext_acl_evt_avg_packet_latency(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("ACL avg packet latency (ms) (0x%2.2x): %d",
+			tlv->subevent_id, num);
+}
+
+static void ext_sco_evt_conn_handle(const struct intel_tlv *tlv)
+{
+	uint16_t conn_handle = get_le16(tlv->value);
+
+	print_field("SCO/eSCO connection handle (0x%2.2x): 0x%4.4x",
+			tlv->subevent_id, conn_handle);
+}
+
+static void ext_sco_evt_num_rx_pkt_from_air(const struct intel_tlv *tlv)
 {
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("Packets from host (0x%2.2x): %d", tlv->subevent_id, num);
+}
+
+static void ext_sco_evt_num_tx_pkt_to_air(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("Tx packets (0x%2.2x): %d", tlv->subevent_id, num);
+}
+
+static void ext_sco_evt_num_rx_payloads_lost(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("Rx payload lost (0x%2.2x): %d", tlv->subevent_id, num);
+}
+
+static void ext_sco_evt_num_tx_payloads_lost(const struct intel_tlv *tlv)
+{
+
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("Tx payload lost (0x%2.2x): %d", tlv->subevent_id, num);
+}
+
+static void slots_errors(const struct intel_tlv *tlv, const char *type_str)
+{
+	/* The subevent has 5 slots where each slot is of the uint32_t type. */
+	uint32_t num[5];
+	const uint8_t *data = tlv->value;
 	int i;
 
+	if (tlv->length != 5 * sizeof(uint32_t)) {
+		print_text(COLOR_UNKNOWN_EXT_EVENT,
+				"  Invalid subevent length (%d)", tlv->length);
+		return;
+	}
+
+	for (i = 0; i < 5; i++) {
+		num[i] = get_le32(data);
+		data += sizeof(uint32_t);
+	}
+
+	print_field("%s (0x%2.2x): %d %d %d %d %d", type_str, tlv->subevent_id,
+			num[0], num[1], num[2], num[3], num[4]);
+}
+
+static void ext_sco_evt_num_no_sync_errors(const struct intel_tlv *tlv)
+{
+	slots_errors(tlv, "Rx No SYNC errors");
+}
+
+static void ext_sco_evt_num_hec_errors(const struct intel_tlv *tlv)
+{
+	slots_errors(tlv, "Rx HEC errors");
+}
+
+static void ext_sco_evt_num_crc_errors(const struct intel_tlv *tlv)
+{
+	slots_errors(tlv, "Rx CRC errors");
+}
+
+static void ext_sco_evt_num_naks(const struct intel_tlv *tlv)
+{
+	slots_errors(tlv, "Rx NAK errors");
+}
+
+static void ext_sco_evt_num_failed_tx_by_wifi(const struct intel_tlv *tlv)
+{
+	slots_errors(tlv, "Failed Tx due to Wifi coex");
+}
+
+static void ext_sco_evt_num_failed_rx_by_wifi(const struct intel_tlv *tlv)
+{
+	slots_errors(tlv, "Failed Rx due to Wifi coex");
+}
+
+static void ext_sco_evt_samples_inserted(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("Late samples inserted based on CDC (0x%2.2x): %d",
+			tlv->subevent_id, num);
+}
+
+static void ext_sco_evt_samples_dropped(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("Samples dropped (0x%2.2x): %d", tlv->subevent_id, num);
+}
+
+static void ext_sco_evt_mute_samples(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("Mute samples sent at initial connection (0x%2.2x): %d",
+			tlv->subevent_id, num);
+}
+
+static void ext_sco_evt_plc_injection_data(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le32(tlv->value);
+
+	print_field("PLC injection data (0x%2.2x): %d", tlv->subevent_id, num);
+}
+
+static const struct intel_ext_subevent {
+	uint8_t subevent_id;
+	uint8_t length;
+	void (*func)(const struct intel_tlv *tlv);
+} intel_ext_subevent_table[] = {
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
+static const struct intel_tlv *process_ext_subevent(const struct intel_tlv *tlv,
+					const struct intel_tlv *last_tlv)
+{
+	const struct intel_tlv *next_tlv = NEXT_TLV(tlv);
+	const struct intel_ext_subevent *subevent = NULL;
+	int i;
+
+	for (i = 0; intel_ext_subevent_table[i].length > 0; i++) {
+		if (intel_ext_subevent_table[i].subevent_id ==
+							tlv->subevent_id) {
+			subevent = &intel_ext_subevent_table[i];
+			break;
+		}
+	}
+
+	if (!subevent) {
+		print_text(COLOR_UNKNOWN_EXT_EVENT,
+				"Unknown extended subevent 0x%2.2x",
+				tlv->subevent_id);
+		return NULL;
+	}
+
+	if (tlv->length != subevent->length) {
+		print_text(COLOR_ERROR, "Invalid length %d of subevent 0x%2.2x",
+				tlv->length, tlv->subevent_id);
+		return NULL;
+	}
+
+	if (next_tlv > last_tlv) {
+		print_text(COLOR_ERROR, "Subevent exceeds the buffer size.");
+		return NULL;
+	}
+
+	subevent->func(tlv);
+
+	return next_tlv;
+}
+
+static void intel_vendor_ext_evt(const void *data, uint8_t size)
+{
+	/* The data pointer points to a number of tlv.*/
+	const struct intel_tlv *tlv = data;
+	const struct intel_tlv *last_tlv = data + size;
+
+	/* Process every tlv subevent until reaching last_tlv.
+	 * The decoding process terminates normally when tlv == last_tlv.
+	 */
+	while (tlv && tlv < last_tlv)
+		tlv = process_ext_subevent(tlv, last_tlv);
+
+	/* If an error occurs in decoding the subevents, hexdump the packet. */
+	if (!tlv)
+		packet_hexdump(data, size);
+}
+
+/* Vendor extended events with a vendor prefix. */
+static const struct vendor_evt vendor_prefix_evt_table[] = {
+	{ 0x03, "Extended Telemetry", intel_vendor_ext_evt },
+	{ }
+};
+
+const uint8_t intel_vendor_prefix[] = {0x87, 0x80};
+#define INTEL_VENDOR_PREFIX_SIZE sizeof(intel_vendor_prefix)
+
+/*
+ * The vendor event with Intel vendor prefix.
+ * Its format looks like
+ *   0xff <length> <vendor_prefix> <subopcode> <data>
+ *   where Intel's <vendor_prefix> is 0x8780.
+ *
+ *   When <subopcode> == 0x03, it is a telemetry event; and
+ *   <data> is a number of tlv data.
+ */
+struct vendor_prefix_evt {
+	uint8_t prefix_data[INTEL_VENDOR_PREFIX_SIZE];
+	uint8_t subopcode;
+};
+
+const struct vendor_evt *intel_vendor_prefix_evt(const void *data,
+							int *consumed_size)
+{
+	int i;
+	const struct vendor_prefix_evt *vnd = data;
+	char prefix_string[INTEL_VENDOR_PREFIX_SIZE * 2 + 1] = { 0 };
+
+	/* Check if the vendor prefix matches. */
+	for (i = 0; i < INTEL_VENDOR_PREFIX_SIZE; i++) {
+		if (vnd->prefix_data[i] != intel_vendor_prefix[i])
+			return NULL;
+		sprintf(prefix_string + i * 2, "%02x", vnd->prefix_data[i]);
+	}
+	print_field("Vendor Prefix (0x%s)", prefix_string);
+
+	/*
+	 * Handle the vendor event with a vendor prefix.
+	 *   0xff <length> <vendor_prefix> <subopcode> <data>
+	 * This loop checks whether the <subopcode> exists in the
+	 * vendor_prefix_evt_table.
+	 */
+	for (i = 0; vendor_prefix_evt_table[i].str; i++) {
+		if (vendor_prefix_evt_table[i].evt == vnd->subopcode) {
+			*consumed_size = sizeof(struct vendor_prefix_evt);
+			return &vendor_prefix_evt_table[i];
+		}
+	}
+
+	return NULL;
+}
+
+const struct vendor_evt *intel_vendor_evt(const void *data, int *consumed_size)
+{
+	uint8_t evt = *((const uint8_t *) data);
+	int i;
+
+	/*
+	 * Handle the vendor event without a vendor prefix.
+	 *   0xff <length> <evt> <data>
+	 * This loop checks whether the <evt> exists in the vendor_evt_table.
+	 */
 	for (i = 0; vendor_evt_table[i].str; i++) {
 		if (vendor_evt_table[i].evt == evt)
 			return &vendor_evt_table[i];
 	}
 
-	return NULL;
+	/*
+	 * It is not a regular event. Check whether it is a vendor extended
+	 * event that comes with a vendor prefix followed by a subopcode.
+	 */
+	return intel_vendor_prefix_evt(data, consumed_size);
 }
diff --git a/monitor/intel.h b/monitor/intel.h
index bf00ad491..bfb04540c 100644
--- a/monitor/intel.h
+++ b/monitor/intel.h
@@ -15,4 +15,4 @@ struct vendor_ocf;
 struct vendor_evt;
 
 const struct vendor_ocf *intel_vendor_ocf(uint16_t ocf);
-const struct vendor_evt *intel_vendor_evt(uint8_t evt);
+const struct vendor_evt *intel_vendor_evt(const void *data, int *consumed_size);
diff --git a/monitor/packet.c b/monitor/packet.c
index 82513a63c..cce84cffa 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9371,9 +9371,15 @@ static const struct vendor_ocf *current_vendor_ocf(uint16_t ocf)
 	return NULL;
 }
 
-static const struct vendor_evt *current_vendor_evt(uint8_t evt)
+static const struct vendor_evt *current_vendor_evt(const void *data,
+							int *consumed_size)
 {
 	uint16_t manufacturer, msft_opcode;
+	uint8_t evt = *((const uint8_t *) data);
+	const struct vendor_evt *vnd;
+
+	/* A regular vendor event consumes 1 byte. */
+	*consumed_size = 1;
 
 	if (index_current < MAX_INDEX) {
 		manufacturer = index_list[index_current].manufacturer;
@@ -9388,7 +9394,7 @@ static const struct vendor_evt *current_vendor_evt(uint8_t evt)
 
 	switch (manufacturer) {
 	case 2:
-		return intel_vendor_evt(evt);
+		return intel_vendor_evt(data, consumed_size);
 	case 15:
 		return broadcom_vendor_evt(evt);
 	}
@@ -11007,10 +11013,10 @@ static void le_meta_event_evt(const void *data, uint8_t size)
 
 static void vendor_evt(const void *data, uint8_t size)
 {
-	uint8_t subevent = *((const uint8_t *) data);
 	struct subevent_data vendor_data;
 	char vendor_str[150];
-	const struct vendor_evt *vnd = current_vendor_evt(subevent);
+	int consumed_size;
+	const struct vendor_evt *vnd = current_vendor_evt(data, &consumed_size);
 
 	if (vnd) {
 		const char *str = current_vendor_str();
@@ -11021,12 +11027,13 @@ static void vendor_evt(const void *data, uint8_t size)
 			vendor_data.str = vendor_str;
 		} else
 			vendor_data.str = vnd->str;
-		vendor_data.subevent = subevent;
+		vendor_data.subevent = vnd->evt;
 		vendor_data.func = vnd->evt_func;
 		vendor_data.size = vnd->evt_size;
 		vendor_data.fixed = vnd->evt_fixed;
 
-		print_subevent(&vendor_data, data + 1, size - 1);
+		print_subevent(&vendor_data, data + consumed_size,
+							size - consumed_size);
 	} else {
 		uint16_t manufacturer;
 
-- 
2.32.0.93.g670b81a890-goog

