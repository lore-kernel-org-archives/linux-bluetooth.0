Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B91C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 May 2022 22:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiERWRu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 May 2022 18:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiERWRp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 May 2022 18:17:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4317220AE5D
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 15:17:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i24so3403054pfa.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bpudxNkCKlflupd9luclYs5EjHBTCWE7knXxHrs15Cg=;
        b=K9Jb50NZGxN+GmL4MwP0n9T3ebL9+zR9IOfByslJjLjD8IDlAMq2XTiFMZLNVYLwtG
         Y2SFyrAYD7pzEJkyCWHoFkDgKJDgdwrQg6V0/R0ZhUgnMtuC4QgOpkOkmuy5Yrg3ZaWU
         vwibfzXLTLEU1h1mDBI4s9micbufnxa1yB+sB8xnDHjHg9m2eT95HRwN3NE0UBIIw+xj
         OG03ZwMhUbOFF/anW9qRiyIpm3jen6xPe3W0YycR0Xw4mdhwCKEv9x5ipdBbhbU5y2jI
         0jKiezvaQ1Mq1kggo/Qrup1NeIXh6d6gB7Gw/Ab8uvKuxOrzUdZvcKkeU4ohzFok1RVT
         uhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpudxNkCKlflupd9luclYs5EjHBTCWE7knXxHrs15Cg=;
        b=lAOcL2jshxh+DZRmz8qUmSTrgO4cpP1cjBIhE+z6ttc6evldc67d6taoXDV8i3Wwff
         M5lTjlwX6mi2A7JrhaZlwaezA71PWo9xqf8gJbRTZ8RvXF/WBL/JENRA+F33IJl03NzI
         EPhDbBdEmYoDciAdMfOyPylAPEy5iKU5JXOWdfKAC8wEQmBz8mZd4wo+w0Rui2yp5aIg
         LLcue/KpMgOsgvdb5Kl1soGexPmnZxTc1ta0rhl54FwgdZd1fc7lnzxLnrO0e8pSCqls
         lGzMo4tEI26CABXtHNFId5LfzS5sYFLWBq+at2mz2T565aDIDpmb4WWZuEKt4znsrdHK
         rvHg==
X-Gm-Message-State: AOAM533YOshOVJmLjX7SyuloAt9r2YjYPXK2tG6kQhEFuxQEsek6rAfn
        RNKNsAoBg4urEuZEKwV5ou+WnE98sQo=
X-Google-Smtp-Source: ABdhPJwH4qkoUfDtZqmqtyD0Dqs9jqItKaJJybuJMcG9N4tYWSVm6xvtZaakDm0PeGZ9s4dmZtwlfQ==
X-Received: by 2002:a63:5d10:0:b0:3c5:e836:ffd2 with SMTP id r16-20020a635d10000000b003c5e836ffd2mr1354541pgb.32.1652912258495;
        Wed, 18 May 2022 15:17:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id iz15-20020a170902ef8f00b001619b38701bsm2201363plb.72.2022.05.18.15.17.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:17:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] monitor: Cache connection information
Date:   Wed, 18 May 2022 15:17:00 -0700
Message-Id: <20220518221701.2220062-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518221701.2220062-1-luiz.dentz@gmail.com>
References: <20220518221701.2220062-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This caches connection information including the device addres so it can
be printed alongside the handle:

> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 3585 Address: 68:79:12:XX:XX:XX (OUI 68-79-12)
        Reason: Connection Terminated By Local Host (0x16)
---
 monitor/broadcom.c |   60 ++-
 monitor/intel.c    |   79 +--
 monitor/msft.c     |    6 +-
 monitor/packet.c   | 1288 ++++++++++++++++++++++++++++----------------
 monitor/packet.h   |   12 +
 monitor/vendor.h   |    6 +-
 6 files changed, 918 insertions(+), 533 deletions(-)

diff --git a/monitor/broadcom.c b/monitor/broadcom.c
index 21a86461b..72da56da2 100644
--- a/monitor/broadcom.c
+++ b/monitor/broadcom.c
@@ -220,23 +220,24 @@ static void print_clock_setting(uint8_t clock)
 	print_field("UART clock: %s (0x%2.2x)", str, clock);
 }
 
-static void null_cmd(const void *data, uint8_t size)
+static void null_cmd(uint16_t index, const void *data, uint8_t size)
 {
 }
 
-static void status_rsp(const void *data, uint8_t size)
+static void status_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t status = get_u8(data);
 
 	print_status(status);
 }
 
-static void write_bd_addr_cmd(const void *data, uint8_t size)
+static void write_bd_addr_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	packet_print_addr("Address", data, 0x00);
 }
 
-static void update_uart_baud_rate_cmd(const void *data, uint8_t size)
+static void update_uart_baud_rate_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint16_t enc_rate = get_le16(data);
 	uint32_t exp_rate = get_le32(data + 2);
@@ -249,7 +250,8 @@ static void update_uart_baud_rate_cmd(const void *data, uint8_t size)
 	print_field("Explicit baud rate: %u Mbps", exp_rate);
 }
 
-static void write_sco_pcm_int_param_cmd(const void *data, uint8_t size)
+static void write_sco_pcm_int_param_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t routing = get_u8(data);
 	uint8_t rate = get_u8(data + 1);
@@ -264,7 +266,8 @@ static void write_sco_pcm_int_param_cmd(const void *data, uint8_t size)
 	print_clock_mode(clock_mode);
 }
 
-static void read_sco_pcm_int_param_rsp(const void *data, uint8_t size)
+static void read_sco_pcm_int_param_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t status = get_u8(data);
 	uint8_t routing = get_u8(data + 1);
@@ -281,7 +284,8 @@ static void read_sco_pcm_int_param_rsp(const void *data, uint8_t size)
 	print_clock_mode(clock_mode);
 }
 
-static void set_sleepmode_param_cmd(const void *data, uint8_t size)
+static void set_sleepmode_param_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t mode = get_u8(data);
 
@@ -290,7 +294,8 @@ static void set_sleepmode_param_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 1, size - 1);
 }
 
-static void read_sleepmode_param_rsp(const void *data, uint8_t size)
+static void read_sleepmode_param_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t status = get_u8(data);
 	uint8_t mode = get_u8(data + 1);
@@ -301,7 +306,8 @@ static void read_sleepmode_param_rsp(const void *data, uint8_t size)
 	packet_hexdump(data + 2, size - 2);
 }
 
-static void enable_radio_cmd(const void *data, uint8_t size)
+static void enable_radio_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t mode = get_u8(data);
 	const char *str;
@@ -321,7 +327,8 @@ static void enable_radio_cmd(const void *data, uint8_t size)
 	print_field("Mode: %s (0x%2.2x)", str, mode);
 }
 
-static void enable_usb_hid_emulation_cmd(const void *data, uint8_t size)
+static void enable_usb_hid_emulation_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t enable = get_u8(data);
 	const char *str;
@@ -341,7 +348,8 @@ static void enable_usb_hid_emulation_cmd(const void *data, uint8_t size)
 	print_field("Enable: %s (0x%2.2x)", str, enable);
 }
 
-static void read_uart_clock_setting_rsp(const void *data, uint8_t size)
+static void read_uart_clock_setting_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t status = get_u8(data);
 	uint8_t clock = get_u8(data + 1);
@@ -350,21 +358,22 @@ static void read_uart_clock_setting_rsp(const void *data, uint8_t size)
 	print_clock_setting(clock);
 }
 
-static void write_uart_clock_setting_cmd(const void *data, uint8_t size)
+static void write_uart_clock_setting_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t clock = get_u8(data);
 
 	print_clock_setting(clock);
 }
 
-static void read_raw_rssi_cmd(const void *data, uint8_t size)
+static void read_raw_rssi_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	uint16_t handle = get_le16(data);
 
 	print_handle(handle);
 }
 
-static void read_raw_rssi_rsp(const void *data, uint8_t size)
+static void read_raw_rssi_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t status = get_u8(data);
 	uint16_t handle = get_le16(data + 1);
@@ -375,7 +384,7 @@ static void read_raw_rssi_rsp(const void *data, uint8_t size)
 	print_rssi(rssi);
 }
 
-static void write_ram_cmd(const void *data, uint8_t size)
+static void write_ram_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	uint32_t addr = get_le32(data);
 
@@ -384,7 +393,7 @@ static void write_ram_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 4, size - 4);
 }
 
-static void read_ram_cmd(const void *data, uint8_t size)
+static void read_ram_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	uint32_t addr = get_le32(data);
 	uint8_t length = get_u8(data + 4);
@@ -393,7 +402,7 @@ static void read_ram_cmd(const void *data, uint8_t size)
 	print_field("Length: %u", length);
 }
 
-static void read_ram_rsp(const void *data, uint8_t size)
+static void read_ram_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t status = get_u8(data);
 
@@ -402,14 +411,14 @@ static void read_ram_rsp(const void *data, uint8_t size)
 	packet_hexdump(data + 1, size - 1);
 }
 
-static void launch_ram_cmd(const void *data, uint8_t size)
+static void launch_ram_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	uint32_t addr = get_le32(data);
 
 	print_field("Address: 0x%8.8x", addr);
 }
 
-static void read_vid_pid_rsp(const void *data, uint8_t size)
+static void read_vid_pid_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t status = get_u8(data);
 	uint16_t vid = get_le16(data + 1);
@@ -419,7 +428,8 @@ static void read_vid_pid_rsp(const void *data, uint8_t size)
 	print_field("Product: %4.4x:%4.4x", vid, pid);
 }
 
-static void write_high_priority_connection_cmd(const void *data, uint8_t size)
+static void write_high_priority_connection_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint16_t handle = get_le16(data);
 	uint8_t priority = get_u8(data + 2);
@@ -480,7 +490,8 @@ static void print_features(const uint8_t *features_array)
 						"(0x%16.16" PRIx64 ")", mask);
 }
 
-static void read_controller_features_rsp(const void *data, uint8_t size)
+static void read_controller_features_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t status = get_u8(data);
 
@@ -488,7 +499,8 @@ static void read_controller_features_rsp(const void *data, uint8_t size)
 	print_features(data + 1);
 }
 
-static void read_verbose_version_info_rsp(const void *data, uint8_t size)
+static void read_verbose_version_info_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t status = get_u8(data);
 	uint8_t chip_id = get_u8(data + 1);
@@ -517,7 +529,7 @@ static void read_verbose_version_info_rsp(const void *data, uint8_t size)
 	print_field("Build number: %u (0x%4.4x)", build_num, build_num);
 }
 
-static void enable_wbs_cmd(const void *data, uint8_t size)
+static void enable_wbs_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t mode = get_u8(data);
 	uint16_t codec = get_le16(data + 1);
@@ -694,7 +706,7 @@ void broadcom_lm_diag(const void *data, uint8_t size)
 	}
 }
 
-static void lm_diag_evt(const void *data, uint8_t size)
+static void lm_diag_evt(uint16_t index, const void *data, uint8_t size)
 {
 	broadcom_lm_diag(data, 63);
 }
diff --git a/monitor/intel.c b/monitor/intel.c
index 728bff587..f5e9f5932 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -86,18 +86,18 @@ static void print_module(uint8_t module)
 	print_field("Module: %s (0x%2.2x)", str, module);
 }
 
-static void null_cmd(const void *data, uint8_t size)
+static void null_cmd(uint16_t index, const void *data, uint8_t size)
 {
 }
 
-static void status_rsp(const void *data, uint8_t size)
+static void status_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t status = get_u8(data);
 
 	print_status(status);
 }
 
-static void reset_cmd(const void *data, uint8_t size)
+static void reset_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t reset_type = get_u8(data);
 	uint8_t patch_enable = get_u8(data + 1);
@@ -326,7 +326,7 @@ static void read_version_tlv_rsp(const void *data, uint8_t size)
 	}
 }
 
-static void read_version_rsp(const void *data, uint8_t size)
+static void read_version_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t status = get_u8(data);
 	uint8_t hw_platform = get_u8(data + 1);
@@ -363,7 +363,7 @@ static void read_version_rsp(const void *data, uint8_t size)
 	print_field("Firmware patch: %u", fw_patch);
 }
 
-static void read_version_cmd(const void *data, uint8_t size)
+static void read_version_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	char *str;
 	uint8_t type;
@@ -406,7 +406,8 @@ static void read_version_cmd(const void *data, uint8_t size)
 	}
 }
 
-static void set_uart_baudrate_cmd(const void *data, uint8_t size)
+static void set_uart_baudrate_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t baudrate = get_u8(data);
 	const char *str;
@@ -465,7 +466,7 @@ static void set_uart_baudrate_cmd(const void *data, uint8_t size)
 	print_field("Baudrate: %s (0x%2.2x)", str, baudrate);
 }
 
-static void secure_send_cmd(const void *data, uint8_t size)
+static void secure_send_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t type = get_u8(data);
 	const char *str;
@@ -493,7 +494,8 @@ static void secure_send_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 1, size - 1);
 }
 
-static void manufacturer_mode_cmd(const void *data, uint8_t size)
+static void manufacturer_mode_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t mode = get_u8(data);
 	uint8_t reset = get_u8(data + 1);
@@ -531,7 +533,7 @@ static void manufacturer_mode_cmd(const void *data, uint8_t size)
 	print_field("Reset behavior: %s (0x%2.2x)", str, reset);
 }
 
-static void write_bd_data_cmd(const void *data, uint8_t size)
+static void write_bd_data_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t features[8];
 
@@ -548,7 +550,7 @@ static void write_bd_data_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 21, size - 21);
 }
 
-static void read_bd_data_rsp(const void *data, uint8_t size)
+static void read_bd_data_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t status = get_u8(data);
 
@@ -557,12 +559,12 @@ static void read_bd_data_rsp(const void *data, uint8_t size)
 	packet_hexdump(data + 7, size - 7);
 }
 
-static void write_bd_address_cmd(const void *data, uint8_t size)
+static void write_bd_address_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	packet_print_addr("Address", data, 0x00);
 }
 
-static void act_deact_traces_cmd(const void *data, uint8_t size)
+static void act_deact_traces_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t tx = get_u8(data);
 	uint8_t tx_arq = get_u8(data + 1);
@@ -573,7 +575,8 @@ static void act_deact_traces_cmd(const void *data, uint8_t size)
 	print_field("Receive traces: 0x%2.2x", rx);
 }
 
-static void stimulate_exception_cmd(const void *data, uint8_t size)
+static void stimulate_exception_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t type = get_u8(data);
 	const char *str;
@@ -609,7 +612,7 @@ static const struct {
 	{ }
 };
 
-static void set_event_mask_cmd(const void *data, uint8_t size)
+static void set_event_mask_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const uint8_t *events_array = data;
 	uint64_t mask, events = 0;
@@ -634,7 +637,7 @@ static void set_event_mask_cmd(const void *data, uint8_t size)
 						"(0x%16.16" PRIx64 ")", mask);
 }
 
-static void ddc_config_write_cmd(const void *data, uint8_t size)
+static void ddc_config_write_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	while (size > 0) {
 		uint8_t param_len = get_u8(data);
@@ -648,7 +651,7 @@ static void ddc_config_write_cmd(const void *data, uint8_t size)
 	}
 }
 
-static void ddc_config_write_rsp(const void *data, uint8_t size)
+static void ddc_config_write_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t status = get_u8(data);
 	uint16_t param_id = get_le16(data + 1);
@@ -657,7 +660,7 @@ static void ddc_config_write_rsp(const void *data, uint8_t size)
 	print_field("Identifier: 0x%4.4x", param_id);
 }
 
-static void memory_write_cmd(const void *data, uint8_t size)
+static void memory_write_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	uint32_t addr = get_le32(data);
 	uint8_t mode = get_u8(data + 4);
@@ -687,14 +690,16 @@ static void memory_write_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 6, size - 6);
 }
 
-static void read_supported_features_cmd(const void *data, uint8_t size)
+static void read_supported_features_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t page = get_u8(data);
 
 	print_field("Page: 0x%2.2x", page);
 }
 
-static void read_supported_features_rsp(const void *data, uint8_t size)
+static void read_supported_features_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t status = get_u8(data);
 	uint8_t page = get_u8(data + 1);
@@ -788,11 +793,11 @@ const struct vendor_ocf *intel_vendor_ocf(uint16_t ocf)
 	return NULL;
 }
 
-static void startup_evt(const void *data, uint8_t size)
+static void startup_evt(uint16_t index, const void *data, uint8_t size)
 {
 }
 
-static void fatal_exception_evt(const void *data, uint8_t size)
+static void fatal_exception_evt(uint16_t index, const void *data, uint8_t size)
 {
 	uint16_t line = get_le16(data);
 	uint8_t module = get_u8(data + 2);
@@ -803,7 +808,7 @@ static void fatal_exception_evt(const void *data, uint8_t size)
 	print_field("Reason: 0x%2.2x", reason);
 }
 
-static void bootup_evt(const void *data, uint8_t size)
+static void bootup_evt(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t zero = get_u8(data);
 	uint8_t num_packets = get_u8(data + 1);
@@ -906,7 +911,7 @@ static void bootup_evt(const void *data, uint8_t size)
 	print_field("DDC status: %s (0x%2.2x)", str, ddc_status);
 }
 
-static void default_bd_data_evt(const void *data, uint8_t size)
+static void default_bd_data_evt(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t mem_status = get_u8(data);
 	const char *str;
@@ -923,7 +928,8 @@ static void default_bd_data_evt(const void *data, uint8_t size)
 	print_field("Memory status: %s (0x%2.2x)", str, mem_status);
 }
 
-static void secure_send_commands_result_evt(const void *data, uint8_t size)
+static void secure_send_commands_result_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t result = get_u8(data);
 	uint16_t opcode = get_le16(data + 1);
@@ -967,7 +973,7 @@ static void secure_send_commands_result_evt(const void *data, uint8_t size)
 	print_status(status);
 }
 
-static void debug_exception_evt(const void *data, uint8_t size)
+static void debug_exception_evt(uint16_t index, const void *data, uint8_t size)
 {
 	uint16_t line = get_le16(data);
 	uint8_t module = get_u8(data + 2);
@@ -978,7 +984,8 @@ static void debug_exception_evt(const void *data, uint8_t size)
 	print_field("Reason: 0x%2.2x", reason);
 }
 
-static void le_link_established_evt(const void *data, uint8_t size)
+static void le_link_established_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint16_t handle = get_le16(data);
 	uint32_t access_addr = get_le32(data + 10);
@@ -992,7 +999,7 @@ static void le_link_established_evt(const void *data, uint8_t size)
 	packet_hexdump(data + 14, size - 14);
 }
 
-static void scan_status_evt(const void *data, uint8_t size)
+static void scan_status_evt(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t enable = get_u8(data);
 
@@ -1007,14 +1014,15 @@ static void scan_status_evt(const void *data, uint8_t size)
 
 }
 
-static void act_deact_traces_complete_evt(const void *data, uint8_t size)
+static void act_deact_traces_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t status = get_u8(data);
 
 	print_status(status);
 }
 
-static void lmp_pdu_trace_evt(const void *data, uint8_t size)
+static void lmp_pdu_trace_evt(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t type, len, id;
 	uint16_t handle, count;
@@ -1108,14 +1116,16 @@ static void lmp_pdu_trace_evt(const void *data, uint8_t size)
 	}
 }
 
-static void write_bd_data_complete_evt(const void *data, uint8_t size)
+static void write_bd_data_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t status = get_u8(data);
 
 	print_status(status);
 }
 
-static void sco_rejected_via_lmp_evt(const void *data, uint8_t size)
+static void sco_rejected_via_lmp_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint8_t reason = get_u8(data + 6);
 
@@ -1123,7 +1133,8 @@ static void sco_rejected_via_lmp_evt(const void *data, uint8_t size)
 	packet_print_error("Reason", reason);
 }
 
-static void ptt_switch_notification_evt(const void *data, uint8_t size)
+static void ptt_switch_notification_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	uint16_t handle = get_le16(data);
 	uint8_t table = get_u8(data + 2);
@@ -1146,7 +1157,7 @@ static void ptt_switch_notification_evt(const void *data, uint8_t size)
 	print_field("Packet type table: %s (0x%2.2x)", str, table);
 }
 
-static void system_exception_evt(const void *data, uint8_t size)
+static void system_exception_evt(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t type = get_u8(data);
 	const char *str;
@@ -1614,7 +1625,7 @@ static const struct intel_tlv *process_ext_subevent(const struct intel_tlv *tlv,
 	return next_tlv;
 }
 
-static void intel_vendor_ext_evt(const void *data, uint8_t size)
+static void intel_vendor_ext_evt(uint16_t index, const void *data, uint8_t size)
 {
 	/* The data pointer points to a number of tlv.*/
 	const struct intel_tlv *tlv = data;
diff --git a/monitor/msft.c b/monitor/msft.c
index 6de03f3f5..38af6722e 100644
--- a/monitor/msft.c
+++ b/monitor/msft.c
@@ -219,7 +219,7 @@ static const struct {
 	{ }
 };
 
-static void msft_cmd(const void *data, uint8_t size)
+static void msft_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t code = get_u8(data);
 	const char *code_color, *code_str = NULL;
@@ -253,7 +253,7 @@ static void msft_cmd(const void *data, uint8_t size)
 		packet_hexdump(data + 1, size - 1);
 }
 
-static void msft_rsp(const void *data, uint8_t size)
+static void msft_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t status = get_u8(data);
 	uint8_t code = get_u8(data + 1);
@@ -299,7 +299,7 @@ const struct vendor_ocf *msft_vendor_ocf(void)
 	return &vendor_ocf_entry;
 }
 
-static void msft_evt(const void *data, uint8_t size)
+static void msft_evt(uint16_t index, const void *data, uint8_t size)
 {
 	packet_hexdump(data, size);
 }
diff --git a/monitor/packet.c b/monitor/packet.c
index 2e02b3923..8608cf2ef 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -169,21 +169,24 @@ static uint16_t get_format(uint32_t cookie)
 
 #define MAX_CONN 16
 
-struct conn_data {
-	uint16_t handle;
-	uint8_t  type;
-};
+static struct packet_conn_data conn_list[MAX_CONN];
 
-static struct conn_data conn_list[MAX_CONN];
-
-static void assign_handle(uint16_t handle, uint8_t type)
+static void assign_handle(uint16_t index, uint16_t handle, uint8_t type,
+					uint8_t *dst, uint8_t dst_type)
 {
 	int i;
 
 	for (i = 0; i < MAX_CONN; i++) {
 		if (conn_list[i].handle == 0x0000) {
+			conn_list[i].index = index;
 			conn_list[i].handle = handle;
 			conn_list[i].type = type;
+
+			if (!dst)
+				break;
+
+			memcpy(conn_list[i].dst, dst, sizeof(conn_list[i].dst));
+			conn_list[i].dst_type = dst_type;
 			break;
 		}
 	}
@@ -195,23 +198,36 @@ static void release_handle(uint16_t handle)
 
 	for (i = 0; i < MAX_CONN; i++) {
 		if (conn_list[i].handle == handle) {
-			conn_list[i].handle = 0x0000;
-			conn_list[i].type = 0x00;
+			if (conn_list[i].destroy)
+				conn_list[i].destroy(conn_list[i].data);
+
+			memset(&conn_list[i], 0, sizeof(conn_list[i]));
 			break;
 		}
 	}
 }
 
-static uint8_t get_type(uint16_t handle)
+struct packet_conn_data *packet_get_conn_data(uint16_t handle)
 {
 	int i;
 
 	for (i = 0; i < MAX_CONN; i++) {
 		if (conn_list[i].handle == handle)
-			return conn_list[i].type;
+			return &conn_list[i];
 	}
 
-	return 0xff;
+	return NULL;
+}
+
+static uint8_t get_type(uint16_t handle)
+{
+	struct packet_conn_data *conn;
+
+	conn = packet_get_conn_data(handle);
+	if (!conn)
+		return 0xff;
+
+	return conn->type;
 }
 
 bool packet_has_filter(unsigned long filter)
@@ -739,7 +755,17 @@ static void print_lt_addr(uint8_t lt_addr)
 
 static void print_handle_native(uint16_t handle)
 {
-	print_field("Handle: %d", handle);
+	struct packet_conn_data *conn;
+	char label[25];
+
+	conn = packet_get_conn_data(handle);
+	if (!conn) {
+		print_field("Handle: %d", handle);
+		return;
+	}
+
+	sprintf(label, "Handle: %d Address", handle);
+	print_addr("  Address", conn->dst, conn->dst_type);
 }
 
 static void print_handle(uint16_t handle)
@@ -4267,18 +4293,18 @@ void packet_simulator(struct timeval *tv, uint16_t frequency,
 	ll_packet(frequency, data, size, false);
 }
 
-static void null_cmd(const void *data, uint8_t size)
+static void null_cmd(uint16_t index, const void *data, uint8_t size)
 {
 }
 
-static void status_rsp(const void *data, uint8_t size)
+static void status_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t status = *((const uint8_t *) data);
 
 	print_status(status);
 }
 
-static void status_handle_rsp(const void *data, uint8_t size)
+static void status_handle_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t status = *((const uint8_t *) data);
 
@@ -4286,7 +4312,7 @@ static void status_handle_rsp(const void *data, uint8_t size)
 	print_field("Connection handle: %d", get_u8(data + 1));
 }
 
-static void status_bdaddr_rsp(const void *data, uint8_t size)
+static void status_bdaddr_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t status = *((const uint8_t *) data);
 
@@ -4294,7 +4320,7 @@ static void status_bdaddr_rsp(const void *data, uint8_t size)
 	print_bdaddr(data + 1);
 }
 
-static void inquiry_cmd(const void *data, uint8_t size)
+static void inquiry_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_inquiry *cmd = data;
 
@@ -4304,7 +4330,7 @@ static void inquiry_cmd(const void *data, uint8_t size)
 	print_num_resp(cmd->num_resp);
 }
 
-static void periodic_inquiry_cmd(const void *data, uint8_t size)
+static void periodic_inquiry_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_periodic_inquiry *cmd = data;
 
@@ -4318,7 +4344,7 @@ static void periodic_inquiry_cmd(const void *data, uint8_t size)
 	print_num_resp(cmd->num_resp);
 }
 
-static void create_conn_cmd(const void *data, uint8_t size)
+static void create_conn_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_create_conn *cmd = data;
 	const char *str;
@@ -4344,7 +4370,7 @@ static void create_conn_cmd(const void *data, uint8_t size)
 	print_field("Role switch: %s (0x%2.2x)", str, cmd->role_switch);
 }
 
-static void disconnect_cmd(const void *data, uint8_t size)
+static void disconnect_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_disconnect *cmd = data;
 
@@ -4352,7 +4378,7 @@ static void disconnect_cmd(const void *data, uint8_t size)
 	print_reason(cmd->reason);
 }
 
-static void add_sco_conn_cmd(const void *data, uint8_t size)
+static void add_sco_conn_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_add_sco_conn *cmd = data;
 
@@ -4360,14 +4386,16 @@ static void add_sco_conn_cmd(const void *data, uint8_t size)
 	print_pkt_type_sco(cmd->pkt_type);
 }
 
-static void create_conn_cancel_cmd(const void *data, uint8_t size)
+static void create_conn_cancel_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_create_conn_cancel *cmd = data;
 
 	print_bdaddr(cmd->bdaddr);
 }
 
-static void accept_conn_request_cmd(const void *data, uint8_t size)
+static void accept_conn_request_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_accept_conn_request *cmd = data;
 
@@ -4375,7 +4403,8 @@ static void accept_conn_request_cmd(const void *data, uint8_t size)
 	print_role(cmd->role);
 }
 
-static void reject_conn_request_cmd(const void *data, uint8_t size)
+static void reject_conn_request_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_reject_conn_request *cmd = data;
 
@@ -4383,7 +4412,8 @@ static void reject_conn_request_cmd(const void *data, uint8_t size)
 	print_reason(cmd->reason);
 }
 
-static void link_key_request_reply_cmd(const void *data, uint8_t size)
+static void link_key_request_reply_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_link_key_request_reply *cmd = data;
 
@@ -4391,14 +4421,16 @@ static void link_key_request_reply_cmd(const void *data, uint8_t size)
 	print_link_key(cmd->link_key);
 }
 
-static void link_key_request_neg_reply_cmd(const void *data, uint8_t size)
+static void link_key_request_neg_reply_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_link_key_request_neg_reply *cmd = data;
 
 	print_bdaddr(cmd->bdaddr);
 }
 
-static void pin_code_request_reply_cmd(const void *data, uint8_t size)
+static void pin_code_request_reply_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_pin_code_request_reply *cmd = data;
 
@@ -4407,14 +4439,16 @@ static void pin_code_request_reply_cmd(const void *data, uint8_t size)
 	print_pin_code(cmd->pin_code, cmd->pin_len);
 }
 
-static void pin_code_request_neg_reply_cmd(const void *data, uint8_t size)
+static void pin_code_request_neg_reply_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_pin_code_request_neg_reply *cmd = data;
 
 	print_bdaddr(cmd->bdaddr);
 }
 
-static void change_conn_pkt_type_cmd(const void *data, uint8_t size)
+static void change_conn_pkt_type_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_change_conn_pkt_type *cmd = data;
 
@@ -4422,14 +4456,14 @@ static void change_conn_pkt_type_cmd(const void *data, uint8_t size)
 	print_pkt_type(cmd->pkt_type);
 }
 
-static void auth_requested_cmd(const void *data, uint8_t size)
+static void auth_requested_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_auth_requested *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void set_conn_encrypt_cmd(const void *data, uint8_t size)
+static void set_conn_encrypt_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_set_conn_encrypt *cmd = data;
 
@@ -4437,21 +4471,24 @@ static void set_conn_encrypt_cmd(const void *data, uint8_t size)
 	print_enable("Encryption", cmd->encr_mode);
 }
 
-static void change_conn_link_key_cmd(const void *data, uint8_t size)
+static void change_conn_link_key_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_change_conn_link_key *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void link_key_selection_cmd(const void *data, uint8_t size)
+static void link_key_selection_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_link_key_selection *cmd = data;
 
 	print_key_flag(cmd->key_flag);
 }
 
-static void remote_name_request_cmd(const void *data, uint8_t size)
+static void remote_name_request_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_remote_name_request *cmd = data;
 
@@ -4461,21 +4498,24 @@ static void remote_name_request_cmd(const void *data, uint8_t size)
 	print_clock_offset(cmd->clock_offset);
 }
 
-static void remote_name_request_cancel_cmd(const void *data, uint8_t size)
+static void remote_name_request_cancel_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_remote_name_request_cancel *cmd = data;
 
 	print_bdaddr(cmd->bdaddr);
 }
 
-static void read_remote_features_cmd(const void *data, uint8_t size)
+static void read_remote_features_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_remote_features *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void read_remote_ext_features_cmd(const void *data, uint8_t size)
+static void read_remote_ext_features_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_remote_ext_features *cmd = data;
 
@@ -4483,28 +4523,30 @@ static void read_remote_ext_features_cmd(const void *data, uint8_t size)
 	print_field("Page: %d", cmd->page);
 }
 
-static void read_remote_version_cmd(const void *data, uint8_t size)
+static void read_remote_version_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_remote_version *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void read_clock_offset_cmd(const void *data, uint8_t size)
+static void read_clock_offset_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_clock_offset *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void read_lmp_handle_cmd(const void *data, uint8_t size)
+static void read_lmp_handle_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_read_lmp_handle *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void read_lmp_handle_rsp(const void *data, uint8_t size)
+static void read_lmp_handle_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_read_lmp_handle *rsp = data;
 
@@ -4514,7 +4556,7 @@ static void read_lmp_handle_rsp(const void *data, uint8_t size)
 	print_field("Reserved: %d", le32_to_cpu(rsp->reserved));
 }
 
-static void setup_sync_conn_cmd(const void *data, uint8_t size)
+static void setup_sync_conn_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_setup_sync_conn *cmd = data;
 
@@ -4527,7 +4569,8 @@ static void setup_sync_conn_cmd(const void *data, uint8_t size)
 	print_pkt_type_sco(cmd->pkt_type);
 }
 
-static void accept_sync_conn_request_cmd(const void *data, uint8_t size)
+static void accept_sync_conn_request_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_accept_sync_conn_request *cmd = data;
 
@@ -4540,7 +4583,8 @@ static void accept_sync_conn_request_cmd(const void *data, uint8_t size)
 	print_pkt_type_sco(cmd->pkt_type);
 }
 
-static void reject_sync_conn_request_cmd(const void *data, uint8_t size)
+static void reject_sync_conn_request_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_reject_sync_conn_request *cmd = data;
 
@@ -4548,7 +4592,8 @@ static void reject_sync_conn_request_cmd(const void *data, uint8_t size)
 	print_reason(cmd->reason);
 }
 
-static void io_capability_request_reply_cmd(const void *data, uint8_t size)
+static void io_capability_request_reply_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_io_capability_request_reply *cmd = data;
 
@@ -4558,21 +4603,24 @@ static void io_capability_request_reply_cmd(const void *data, uint8_t size)
 	print_authentication(cmd->authentication);
 }
 
-static void user_confirm_request_reply_cmd(const void *data, uint8_t size)
+static void user_confirm_request_reply_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_user_confirm_request_reply *cmd = data;
 
 	print_bdaddr(cmd->bdaddr);
 }
 
-static void user_confirm_request_neg_reply_cmd(const void *data, uint8_t size)
+static void user_confirm_request_neg_reply_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_user_confirm_request_neg_reply *cmd = data;
 
 	print_bdaddr(cmd->bdaddr);
 }
 
-static void user_passkey_request_reply_cmd(const void *data, uint8_t size)
+static void user_passkey_request_reply_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_user_passkey_request_reply *cmd = data;
 
@@ -4580,14 +4628,16 @@ static void user_passkey_request_reply_cmd(const void *data, uint8_t size)
 	print_passkey(cmd->passkey);
 }
 
-static void user_passkey_request_neg_reply_cmd(const void *data, uint8_t size)
+static void user_passkey_request_neg_reply_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_user_passkey_request_neg_reply *cmd = data;
 
 	print_bdaddr(cmd->bdaddr);
 }
 
-static void remote_oob_data_request_reply_cmd(const void *data, uint8_t size)
+static void remote_oob_data_request_reply_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_remote_oob_data_request_reply *cmd = data;
 
@@ -4596,14 +4646,16 @@ static void remote_oob_data_request_reply_cmd(const void *data, uint8_t size)
 	print_randomizer_p192(cmd->randomizer);
 }
 
-static void remote_oob_data_request_neg_reply_cmd(const void *data, uint8_t size)
+static void remote_oob_data_request_neg_reply_cmd(uint16_t index,
+						const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_remote_oob_data_request_neg_reply *cmd = data;
 
 	print_bdaddr(cmd->bdaddr);
 }
 
-static void io_capability_request_neg_reply_cmd(const void *data, uint8_t size)
+static void io_capability_request_neg_reply_cmd(uint16_t index,
+						const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_io_capability_request_neg_reply *cmd = data;
 
@@ -4611,7 +4663,7 @@ static void io_capability_request_neg_reply_cmd(const void *data, uint8_t size)
 	print_reason(cmd->reason);
 }
 
-static void create_phy_link_cmd(const void *data, uint8_t size)
+static void create_phy_link_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_create_phy_link *cmd = data;
 
@@ -4622,7 +4674,7 @@ static void create_phy_link_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 3, size - 3);
 }
 
-static void accept_phy_link_cmd(const void *data, uint8_t size)
+static void accept_phy_link_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_accept_phy_link *cmd = data;
 
@@ -4633,7 +4685,7 @@ static void accept_phy_link_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 3, size - 3);
 }
 
-static void disconn_phy_link_cmd(const void *data, uint8_t size)
+static void disconn_phy_link_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_disconn_phy_link *cmd = data;
 
@@ -4641,7 +4693,8 @@ static void disconn_phy_link_cmd(const void *data, uint8_t size)
 	print_reason(cmd->reason);
 }
 
-static void create_logic_link_cmd(const void *data, uint8_t size)
+static void create_logic_link_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_create_logic_link *cmd = data;
 
@@ -4650,7 +4703,8 @@ static void create_logic_link_cmd(const void *data, uint8_t size)
 	print_flow_spec("RX", cmd->rx_flow_spec);
 }
 
-static void accept_logic_link_cmd(const void *data, uint8_t size)
+static void accept_logic_link_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_accept_logic_link *cmd = data;
 
@@ -4659,14 +4713,16 @@ static void accept_logic_link_cmd(const void *data, uint8_t size)
 	print_flow_spec("RX", cmd->rx_flow_spec);
 }
 
-static void disconn_logic_link_cmd(const void *data, uint8_t size)
+static void disconn_logic_link_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_disconn_logic_link *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void logic_link_cancel_cmd(const void *data, uint8_t size)
+static void logic_link_cancel_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_logic_link_cancel *cmd = data;
 
@@ -4674,7 +4730,8 @@ static void logic_link_cancel_cmd(const void *data, uint8_t size)
 	print_field("TX flow spec: 0x%2.2x", cmd->flow_spec);
 }
 
-static void logic_link_cancel_rsp(const void *data, uint8_t size)
+static void logic_link_cancel_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_logic_link_cancel *rsp = data;
 
@@ -4683,7 +4740,7 @@ static void logic_link_cancel_rsp(const void *data, uint8_t size)
 	print_field("TX flow spec: 0x%2.2x", rsp->flow_spec);
 }
 
-static void flow_spec_modify_cmd(const void *data, uint8_t size)
+static void flow_spec_modify_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_flow_spec_modify *cmd = data;
 
@@ -4692,7 +4749,8 @@ static void flow_spec_modify_cmd(const void *data, uint8_t size)
 	print_flow_spec("RX", cmd->rx_flow_spec);
 }
 
-static void enhanced_setup_sync_conn_cmd(const void *data, uint8_t size)
+static void enhanced_setup_sync_conn_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_enhanced_setup_sync_conn *cmd = data;
 
@@ -4707,7 +4765,9 @@ static void enhanced_setup_sync_conn_cmd(const void *data, uint8_t size)
 	print_retransmission_effort(cmd->retrans_effort);
 }
 
-static void enhanced_accept_sync_conn_request_cmd(const void *data, uint8_t size)
+static void enhanced_accept_sync_conn_request_cmd(uint16_t index,
+						const void *data,
+						uint8_t size)
 {
 	const struct bt_hci_cmd_enhanced_accept_sync_conn_request *cmd = data;
 
@@ -4722,7 +4782,7 @@ static void enhanced_accept_sync_conn_request_cmd(const void *data, uint8_t size
 	print_retransmission_effort(cmd->retrans_effort);
 }
 
-static void truncated_page_cmd(const void *data, uint8_t size)
+static void truncated_page_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_truncated_page *cmd = data;
 
@@ -4731,14 +4791,16 @@ static void truncated_page_cmd(const void *data, uint8_t size)
 	print_clock_offset(cmd->clock_offset);
 }
 
-static void truncated_page_cancel_cmd(const void *data, uint8_t size)
+static void truncated_page_cancel_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_truncated_page_cancel *cmd = data;
 
 	print_bdaddr(cmd->bdaddr);
 }
 
-static void set_peripheral_broadcast_cmd(const void *data, uint8_t size)
+static void set_peripheral_broadcast_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_set_peripheral_broadcast *cmd = data;
 
@@ -4751,7 +4813,8 @@ static void set_peripheral_broadcast_cmd(const void *data, uint8_t size)
 	print_slot_625("Supervision timeout", cmd->timeout);
 }
 
-static void set_peripheral_broadcast_rsp(const void *data, uint8_t size)
+static void set_peripheral_broadcast_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_set_peripheral_broadcast *rsp = data;
 
@@ -4760,7 +4823,8 @@ static void set_peripheral_broadcast_rsp(const void *data, uint8_t size)
 	print_interval(rsp->interval);
 }
 
-static void set_peripheral_broadcast_receive_cmd(const void *data, uint8_t size)
+static void set_peripheral_broadcast_receive_cmd(uint16_t index,
+						const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_set_peripheral_broadcast_receive *cmd = data;
 
@@ -4778,7 +4842,8 @@ static void set_peripheral_broadcast_receive_cmd(const void *data, uint8_t size)
 	print_channel_map(cmd->map);
 }
 
-static void set_peripheral_broadcast_receive_rsp(const void *data, uint8_t size)
+static void set_peripheral_broadcast_receive_rsp(uint16_t index,
+						const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_set_peripheral_broadcast_receive *rsp = data;
 
@@ -4787,7 +4852,8 @@ static void set_peripheral_broadcast_receive_rsp(const void *data, uint8_t size)
 	print_lt_addr(rsp->lt_addr);
 }
 
-static void receive_sync_train_cmd(const void *data, uint8_t size)
+static void receive_sync_train_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_receive_sync_train *cmd = data;
 
@@ -4797,7 +4863,8 @@ static void receive_sync_train_cmd(const void *data, uint8_t size)
 	print_interval(cmd->interval);
 }
 
-static void remote_oob_ext_data_request_reply_cmd(const void *data, uint8_t size)
+static void remote_oob_ext_data_request_reply_cmd(uint16_t index,
+						const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_remote_oob_ext_data_request_reply *cmd = data;
 
@@ -4808,7 +4875,7 @@ static void remote_oob_ext_data_request_reply_cmd(const void *data, uint8_t size
 	print_randomizer_p256(cmd->randomizer256);
 }
 
-static void hold_mode_cmd(const void *data, uint8_t size)
+static void hold_mode_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_hold_mode *cmd = data;
 
@@ -4817,7 +4884,7 @@ static void hold_mode_cmd(const void *data, uint8_t size)
 	print_slot_625("Hold min interval", cmd->min_interval);
 }
 
-static void sniff_mode_cmd(const void *data, uint8_t size)
+static void sniff_mode_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_sniff_mode *cmd = data;
 
@@ -4828,14 +4895,14 @@ static void sniff_mode_cmd(const void *data, uint8_t size)
 	print_slot_125("Sniff timeout", cmd->timeout);
 }
 
-static void exit_sniff_mode_cmd(const void *data, uint8_t size)
+static void exit_sniff_mode_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_exit_sniff_mode *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void park_state_cmd(const void *data, uint8_t size)
+static void park_state_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_park_state *cmd = data;
 
@@ -4844,14 +4911,14 @@ static void park_state_cmd(const void *data, uint8_t size)
 	print_slot_625("Beacon min interval", cmd->min_interval);
 }
 
-static void exit_park_state_cmd(const void *data, uint8_t size)
+static void exit_park_state_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_exit_park_state *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void qos_setup_cmd(const void *data, uint8_t size)
+static void qos_setup_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_qos_setup *cmd = data;
 
@@ -4866,14 +4933,14 @@ static void qos_setup_cmd(const void *data, uint8_t size)
 	print_field("Delay variation: %d", le32_to_cpu(cmd->delay_variation));
 }
 
-static void role_discovery_cmd(const void *data, uint8_t size)
+static void role_discovery_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_role_discovery *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void role_discovery_rsp(const void *data, uint8_t size)
+static void role_discovery_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_role_discovery *rsp = data;
 
@@ -4882,7 +4949,7 @@ static void role_discovery_rsp(const void *data, uint8_t size)
 	print_role(rsp->role);
 }
 
-static void switch_role_cmd(const void *data, uint8_t size)
+static void switch_role_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_switch_role *cmd = data;
 
@@ -4890,14 +4957,14 @@ static void switch_role_cmd(const void *data, uint8_t size)
 	print_role(cmd->role);
 }
 
-static void read_link_policy_cmd(const void *data, uint8_t size)
+static void read_link_policy_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_read_link_policy *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void read_link_policy_rsp(const void *data, uint8_t size)
+static void read_link_policy_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_read_link_policy *rsp = data;
 
@@ -4906,7 +4973,8 @@ static void read_link_policy_rsp(const void *data, uint8_t size)
 	print_link_policy(rsp->policy);
 }
 
-static void write_link_policy_cmd(const void *data, uint8_t size)
+static void write_link_policy_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_link_policy *cmd = data;
 
@@ -4914,7 +4982,8 @@ static void write_link_policy_cmd(const void *data, uint8_t size)
 	print_link_policy(cmd->policy);
 }
 
-static void write_link_policy_rsp(const void *data, uint8_t size)
+static void write_link_policy_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_write_link_policy *rsp = data;
 
@@ -4922,7 +4991,8 @@ static void write_link_policy_rsp(const void *data, uint8_t size)
 	print_handle(rsp->handle);
 }
 
-static void read_default_link_policy_rsp(const void *data, uint8_t size)
+static void read_default_link_policy_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_default_link_policy *rsp = data;
 
@@ -4930,14 +5000,15 @@ static void read_default_link_policy_rsp(const void *data, uint8_t size)
 	print_link_policy(rsp->policy);
 }
 
-static void write_default_link_policy_cmd(const void *data, uint8_t size)
+static void write_default_link_policy_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_default_link_policy *cmd = data;
 
 	print_link_policy(cmd->policy);
 }
 
-static void flow_spec_cmd(const void *data, uint8_t size)
+static void flow_spec_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_flow_spec *cmd = data;
 
@@ -4954,7 +5025,7 @@ static void flow_spec_cmd(const void *data, uint8_t size)
 	print_field("Access latency: %d", le32_to_cpu(cmd->access_latency));
 }
 
-static void sniff_subrating_cmd(const void *data, uint8_t size)
+static void sniff_subrating_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_sniff_subrating *cmd = data;
 
@@ -4964,7 +5035,7 @@ static void sniff_subrating_cmd(const void *data, uint8_t size)
 	print_slot_625("Min local timeout", cmd->min_local_timeout);
 }
 
-static void sniff_subrating_rsp(const void *data, uint8_t size)
+static void sniff_subrating_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_sniff_subrating *rsp = data;
 
@@ -4972,14 +5043,14 @@ static void sniff_subrating_rsp(const void *data, uint8_t size)
 	print_handle(rsp->handle);
 }
 
-static void set_event_mask_cmd(const void *data, uint8_t size)
+static void set_event_mask_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_set_event_mask *cmd = data;
 
 	print_event_mask(cmd->mask, events_table);
 }
 
-static void set_event_filter_cmd(const void *data, uint8_t size)
+static void set_event_filter_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t type = *((const uint8_t *) data);
 	uint8_t filter;
@@ -5077,14 +5148,14 @@ static void set_event_filter_cmd(const void *data, uint8_t size)
 	}
 }
 
-static void flush_cmd(const void *data, uint8_t size)
+static void flush_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_flush *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void flush_rsp(const void *data, uint8_t size)
+static void flush_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_flush *rsp = data;
 
@@ -5092,7 +5163,7 @@ static void flush_rsp(const void *data, uint8_t size)
 	print_handle(rsp->handle);
 }
 
-static void read_pin_type_rsp(const void *data, uint8_t size)
+static void read_pin_type_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_read_pin_type *rsp = data;
 
@@ -5100,14 +5171,15 @@ static void read_pin_type_rsp(const void *data, uint8_t size)
 	print_pin_type(rsp->pin_type);
 }
 
-static void write_pin_type_cmd(const void *data, uint8_t size)
+static void write_pin_type_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_write_pin_type *cmd = data;
 
 	print_pin_type(cmd->pin_type);
 }
 
-static void read_stored_link_key_cmd(const void *data, uint8_t size)
+static void read_stored_link_key_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_stored_link_key *cmd = data;
 
@@ -5115,7 +5187,8 @@ static void read_stored_link_key_cmd(const void *data, uint8_t size)
 	print_field("Read all: 0x%2.2x", cmd->read_all);
 }
 
-static void read_stored_link_key_rsp(const void *data, uint8_t size)
+static void read_stored_link_key_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_stored_link_key *rsp = data;
 
@@ -5124,7 +5197,8 @@ static void read_stored_link_key_rsp(const void *data, uint8_t size)
 	print_field("Num keys: %d", le16_to_cpu(rsp->num_keys));
 }
 
-static void write_stored_link_key_cmd(const void *data, uint8_t size)
+static void write_stored_link_key_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_stored_link_key *cmd = data;
 
@@ -5133,7 +5207,8 @@ static void write_stored_link_key_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 1, size - 1);
 }
 
-static void write_stored_link_key_rsp(const void *data, uint8_t size)
+static void write_stored_link_key_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_write_stored_link_key *rsp = data;
 
@@ -5141,7 +5216,8 @@ static void write_stored_link_key_rsp(const void *data, uint8_t size)
 	print_field("Num keys: %d", rsp->num_keys);
 }
 
-static void delete_stored_link_key_cmd(const void *data, uint8_t size)
+static void delete_stored_link_key_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_delete_stored_link_key *cmd = data;
 
@@ -5149,7 +5225,8 @@ static void delete_stored_link_key_cmd(const void *data, uint8_t size)
 	print_field("Delete all: 0x%2.2x", cmd->delete_all);
 }
 
-static void delete_stored_link_key_rsp(const void *data, uint8_t size)
+static void delete_stored_link_key_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_delete_stored_link_key *rsp = data;
 
@@ -5157,14 +5234,14 @@ static void delete_stored_link_key_rsp(const void *data, uint8_t size)
 	print_field("Num keys: %d", le16_to_cpu(rsp->num_keys));
 }
 
-static void write_local_name_cmd(const void *data, uint8_t size)
+static void write_local_name_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_write_local_name *cmd = data;
 
 	print_name(cmd->name);
 }
 
-static void read_local_name_rsp(const void *data, uint8_t size)
+static void read_local_name_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_read_local_name *rsp = data;
 
@@ -5172,7 +5249,8 @@ static void read_local_name_rsp(const void *data, uint8_t size)
 	print_name(rsp->name);
 }
 
-static void read_conn_accept_timeout_rsp(const void *data, uint8_t size)
+static void read_conn_accept_timeout_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_conn_accept_timeout *rsp = data;
 
@@ -5180,14 +5258,16 @@ static void read_conn_accept_timeout_rsp(const void *data, uint8_t size)
 	print_timeout(rsp->timeout);
 }
 
-static void write_conn_accept_timeout_cmd(const void *data, uint8_t size)
+static void write_conn_accept_timeout_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_conn_accept_timeout *cmd = data;
 
 	print_timeout(cmd->timeout);
 }
 
-static void read_page_timeout_rsp(const void *data, uint8_t size)
+static void read_page_timeout_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_page_timeout *rsp = data;
 
@@ -5195,14 +5275,15 @@ static void read_page_timeout_rsp(const void *data, uint8_t size)
 	print_timeout(rsp->timeout);
 }
 
-static void write_page_timeout_cmd(const void *data, uint8_t size)
+static void write_page_timeout_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_page_timeout *cmd = data;
 
 	print_timeout(cmd->timeout);
 }
 
-static void read_scan_enable_rsp(const void *data, uint8_t size)
+static void read_scan_enable_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_read_scan_enable *rsp = data;
 
@@ -5210,14 +5291,16 @@ static void read_scan_enable_rsp(const void *data, uint8_t size)
 	print_scan_enable(rsp->enable);
 }
 
-static void write_scan_enable_cmd(const void *data, uint8_t size)
+static void write_scan_enable_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_scan_enable *cmd = data;
 
 	print_scan_enable(cmd->enable);
 }
 
-static void read_page_scan_activity_rsp(const void *data, uint8_t size)
+static void read_page_scan_activity_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_page_scan_activity *rsp = data;
 
@@ -5226,7 +5309,8 @@ static void read_page_scan_activity_rsp(const void *data, uint8_t size)
 	print_window(rsp->window);
 }
 
-static void write_page_scan_activity_cmd(const void *data, uint8_t size)
+static void write_page_scan_activity_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_page_scan_activity *cmd = data;
 
@@ -5234,7 +5318,8 @@ static void write_page_scan_activity_cmd(const void *data, uint8_t size)
 	print_window(cmd->window);
 }
 
-static void read_inquiry_scan_activity_rsp(const void *data, uint8_t size)
+static void read_inquiry_scan_activity_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_inquiry_scan_activity *rsp = data;
 
@@ -5243,7 +5328,8 @@ static void read_inquiry_scan_activity_rsp(const void *data, uint8_t size)
 	print_window(rsp->window);
 }
 
-static void write_inquiry_scan_activity_cmd(const void *data, uint8_t size)
+static void write_inquiry_scan_activity_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_inquiry_scan_activity *cmd = data;
 
@@ -5251,7 +5337,7 @@ static void write_inquiry_scan_activity_cmd(const void *data, uint8_t size)
 	print_window(cmd->window);
 }
 
-static void read_auth_enable_rsp(const void *data, uint8_t size)
+static void read_auth_enable_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_read_auth_enable *rsp = data;
 
@@ -5259,14 +5345,16 @@ static void read_auth_enable_rsp(const void *data, uint8_t size)
 	print_auth_enable(rsp->enable);
 }
 
-static void write_auth_enable_cmd(const void *data, uint8_t size)
+static void write_auth_enable_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_auth_enable *cmd = data;
 
 	print_auth_enable(cmd->enable);
 }
 
-static void read_encrypt_mode_rsp(const void *data, uint8_t size)
+static void read_encrypt_mode_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_encrypt_mode *rsp = data;
 
@@ -5274,14 +5362,16 @@ static void read_encrypt_mode_rsp(const void *data, uint8_t size)
 	print_encrypt_mode(rsp->mode);
 }
 
-static void write_encrypt_mode_cmd(const void *data, uint8_t size)
+static void write_encrypt_mode_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_encrypt_mode *cmd = data;
 
 	print_encrypt_mode(cmd->mode);
 }
 
-static void read_class_of_dev_rsp(const void *data, uint8_t size)
+static void read_class_of_dev_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_class_of_dev *rsp = data;
 
@@ -5289,14 +5379,16 @@ static void read_class_of_dev_rsp(const void *data, uint8_t size)
 	print_dev_class(rsp->dev_class);
 }
 
-static void write_class_of_dev_cmd(const void *data, uint8_t size)
+static void write_class_of_dev_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_class_of_dev *cmd = data;
 
 	print_dev_class(cmd->dev_class);
 }
 
-static void read_voice_setting_rsp(const void *data, uint8_t size)
+static void read_voice_setting_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_voice_setting *rsp = data;
 
@@ -5304,21 +5396,24 @@ static void read_voice_setting_rsp(const void *data, uint8_t size)
 	print_voice_setting(rsp->setting);
 }
 
-static void write_voice_setting_cmd(const void *data, uint8_t size)
+static void write_voice_setting_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_voice_setting *cmd = data;
 
 	print_voice_setting(cmd->setting);
 }
 
-static void read_auto_flush_timeout_cmd(const void *data, uint8_t size)
+static void read_auto_flush_timeout_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_auto_flush_timeout *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void read_auto_flush_timeout_rsp(const void *data, uint8_t size)
+static void read_auto_flush_timeout_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_auto_flush_timeout *rsp = data;
 
@@ -5327,7 +5422,8 @@ static void read_auto_flush_timeout_rsp(const void *data, uint8_t size)
 	print_flush_timeout(rsp->timeout);
 }
 
-static void write_auto_flush_timeout_cmd(const void *data, uint8_t size)
+static void write_auto_flush_timeout_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_auto_flush_timeout *cmd = data;
 
@@ -5335,7 +5431,8 @@ static void write_auto_flush_timeout_cmd(const void *data, uint8_t size)
 	print_flush_timeout(cmd->timeout);
 }
 
-static void write_auto_flush_timeout_rsp(const void *data, uint8_t size)
+static void write_auto_flush_timeout_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_write_auto_flush_timeout *rsp = data;
 
@@ -5343,7 +5440,8 @@ static void write_auto_flush_timeout_rsp(const void *data, uint8_t size)
 	print_handle(rsp->handle);
 }
 
-static void read_num_broadcast_retrans_rsp(const void *data, uint8_t size)
+static void read_num_broadcast_retrans_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_num_broadcast_retrans *rsp = data;
 
@@ -5351,14 +5449,16 @@ static void read_num_broadcast_retrans_rsp(const void *data, uint8_t size)
 	print_num_broadcast_retrans(rsp->num_retrans);
 }
 
-static void write_num_broadcast_retrans_cmd(const void *data, uint8_t size)
+static void write_num_broadcast_retrans_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_num_broadcast_retrans *cmd = data;
 
 	print_num_broadcast_retrans(cmd->num_retrans);
 }
 
-static void read_hold_mode_activity_rsp(const void *data, uint8_t size)
+static void read_hold_mode_activity_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_hold_mode_activity *rsp = data;
 
@@ -5366,14 +5466,15 @@ static void read_hold_mode_activity_rsp(const void *data, uint8_t size)
 	print_hold_mode_activity(rsp->activity);
 }
 
-static void write_hold_mode_activity_cmd(const void *data, uint8_t size)
+static void write_hold_mode_activity_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_hold_mode_activity *cmd = data;
 
 	print_hold_mode_activity(cmd->activity);
 }
 
-static void read_tx_power_cmd(const void *data, uint8_t size)
+static void read_tx_power_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_read_tx_power *cmd = data;
 
@@ -5381,7 +5482,7 @@ static void read_tx_power_cmd(const void *data, uint8_t size)
 	print_power_type(cmd->type);
 }
 
-static void read_tx_power_rsp(const void *data, uint8_t size)
+static void read_tx_power_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_read_tx_power *rsp = data;
 
@@ -5390,7 +5491,8 @@ static void read_tx_power_rsp(const void *data, uint8_t size)
 	print_power_level(rsp->level, NULL);
 }
 
-static void read_sync_flow_control_rsp(const void *data, uint8_t size)
+static void read_sync_flow_control_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_sync_flow_control *rsp = data;
 
@@ -5398,21 +5500,23 @@ static void read_sync_flow_control_rsp(const void *data, uint8_t size)
 	print_enable("Flow control", rsp->enable);
 }
 
-static void write_sync_flow_control_cmd(const void *data, uint8_t size)
+static void write_sync_flow_control_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_sync_flow_control *cmd = data;
 
 	print_enable("Flow control", cmd->enable);
 }
 
-static void set_host_flow_control_cmd(const void *data, uint8_t size)
+static void set_host_flow_control_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_set_host_flow_control *cmd = data;
 
 	print_host_flow_control(cmd->enable);
 }
 
-static void host_buffer_size_cmd(const void *data, uint8_t size)
+static void host_buffer_size_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_host_buffer_size *cmd = data;
 
@@ -5424,7 +5528,8 @@ static void host_buffer_size_cmd(const void *data, uint8_t size)
 					le16_to_cpu(cmd->sco_max_pkt));
 }
 
-static void host_num_completed_packets_cmd(const void *data, uint8_t size)
+static void host_num_completed_packets_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_host_num_completed_packets *cmd = data;
 
@@ -5436,14 +5541,16 @@ static void host_num_completed_packets_cmd(const void *data, uint8_t size)
 		packet_hexdump(data + sizeof(*cmd), size - sizeof(*cmd));
 }
 
-static void read_link_supv_timeout_cmd(const void *data, uint8_t size)
+static void read_link_supv_timeout_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_link_supv_timeout *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void read_link_supv_timeout_rsp(const void *data, uint8_t size)
+static void read_link_supv_timeout_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_link_supv_timeout *rsp = data;
 
@@ -5452,7 +5559,8 @@ static void read_link_supv_timeout_rsp(const void *data, uint8_t size)
 	print_timeout(rsp->timeout);
 }
 
-static void write_link_supv_timeout_cmd(const void *data, uint8_t size)
+static void write_link_supv_timeout_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_link_supv_timeout *cmd = data;
 
@@ -5460,7 +5568,8 @@ static void write_link_supv_timeout_cmd(const void *data, uint8_t size)
 	print_timeout(cmd->timeout);
 }
 
-static void write_link_supv_timeout_rsp(const void *data, uint8_t size)
+static void write_link_supv_timeout_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_write_link_supv_timeout *rsp = data;
 
@@ -5468,7 +5577,8 @@ static void write_link_supv_timeout_rsp(const void *data, uint8_t size)
 	print_handle(rsp->handle);
 }
 
-static void read_num_supported_iac_rsp(const void *data, uint8_t size)
+static void read_num_supported_iac_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_num_supported_iac *rsp = data;
 
@@ -5476,7 +5586,8 @@ static void read_num_supported_iac_rsp(const void *data, uint8_t size)
 	print_field("Number of IAC: %d", rsp->num_iac);
 }
 
-static void read_current_iac_lap_rsp(const void *data, uint8_t size)
+static void read_current_iac_lap_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_current_iac_lap *rsp = data;
 	uint8_t i;
@@ -5488,7 +5599,8 @@ static void read_current_iac_lap_rsp(const void *data, uint8_t size)
 		print_iac(rsp->iac_lap + (i * 3));
 }
 
-static void write_current_iac_lap_cmd(const void *data, uint8_t size)
+static void write_current_iac_lap_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_current_iac_lap *cmd = data;
 	uint8_t i;
@@ -5499,7 +5611,8 @@ static void write_current_iac_lap_cmd(const void *data, uint8_t size)
 		print_iac(cmd->iac_lap + (i * 3));
 }
 
-static void read_page_scan_period_mode_rsp(const void *data, uint8_t size)
+static void read_page_scan_period_mode_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_page_scan_period_mode *rsp = data;
 
@@ -5507,14 +5620,16 @@ static void read_page_scan_period_mode_rsp(const void *data, uint8_t size)
 	print_pscan_period_mode(rsp->mode);
 }
 
-static void write_page_scan_period_mode_cmd(const void *data, uint8_t size)
+static void write_page_scan_period_mode_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_page_scan_period_mode *cmd = data;
 
 	print_pscan_period_mode(cmd->mode);
 }
 
-static void read_page_scan_mode_rsp(const void *data, uint8_t size)
+static void read_page_scan_mode_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_page_scan_mode *rsp = data;
 
@@ -5522,21 +5637,24 @@ static void read_page_scan_mode_rsp(const void *data, uint8_t size)
 	print_pscan_mode(rsp->mode);
 }
 
-static void write_page_scan_mode_cmd(const void *data, uint8_t size)
+static void write_page_scan_mode_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_page_scan_mode *cmd = data;
 
 	print_pscan_mode(cmd->mode);
 }
 
-static void set_afh_host_classification_cmd(const void *data, uint8_t size)
+static void set_afh_host_classification_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_set_afh_host_classification *cmd = data;
 
 	print_channel_map(cmd->map);
 }
 
-static void read_inquiry_scan_type_rsp(const void *data, uint8_t size)
+static void read_inquiry_scan_type_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_inquiry_scan_type *rsp = data;
 
@@ -5544,14 +5662,16 @@ static void read_inquiry_scan_type_rsp(const void *data, uint8_t size)
 	print_inquiry_scan_type(rsp->type);
 }
 
-static void write_inquiry_scan_type_cmd(const void *data, uint8_t size)
+static void write_inquiry_scan_type_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_inquiry_scan_type *cmd = data;
 
 	print_inquiry_scan_type(cmd->type);
 }
 
-static void read_inquiry_mode_rsp(const void *data, uint8_t size)
+static void read_inquiry_mode_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_inquiry_mode *rsp = data;
 
@@ -5559,14 +5679,16 @@ static void read_inquiry_mode_rsp(const void *data, uint8_t size)
 	print_inquiry_mode(rsp->mode);
 }
 
-static void write_inquiry_mode_cmd(const void *data, uint8_t size)
+static void write_inquiry_mode_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_inquiry_mode *cmd = data;
 
 	print_inquiry_mode(cmd->mode);
 }
 
-static void read_page_scan_type_rsp(const void *data, uint8_t size)
+static void read_page_scan_type_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_page_scan_type *rsp = data;
 
@@ -5574,14 +5696,16 @@ static void read_page_scan_type_rsp(const void *data, uint8_t size)
 	print_pscan_type(rsp->type);
 }
 
-static void write_page_scan_type_cmd(const void *data, uint8_t size)
+static void write_page_scan_type_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_page_scan_type *cmd = data;
 
 	print_pscan_type(cmd->type);
 }
 
-static void read_afh_assessment_mode_rsp(const void *data, uint8_t size)
+static void read_afh_assessment_mode_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_afh_assessment_mode *rsp = data;
 
@@ -5589,14 +5713,16 @@ static void read_afh_assessment_mode_rsp(const void *data, uint8_t size)
 	print_enable("Mode", rsp->mode);
 }
 
-static void write_afh_assessment_mode_cmd(const void *data, uint8_t size)
+static void write_afh_assessment_mode_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_afh_assessment_mode *cmd = data;
 
 	print_enable("Mode", cmd->mode);
 }
 
-static void read_ext_inquiry_response_rsp(const void *data, uint8_t size)
+static void read_ext_inquiry_response_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_ext_inquiry_response *rsp = data;
 
@@ -5605,7 +5731,8 @@ static void read_ext_inquiry_response_rsp(const void *data, uint8_t size)
 	print_eir(rsp->data, sizeof(rsp->data), false);
 }
 
-static void write_ext_inquiry_response_cmd(const void *data, uint8_t size)
+static void write_ext_inquiry_response_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_ext_inquiry_response *cmd = data;
 
@@ -5613,14 +5740,16 @@ static void write_ext_inquiry_response_cmd(const void *data, uint8_t size)
 	print_eir(cmd->data, sizeof(cmd->data), false);
 }
 
-static void refresh_encrypt_key_cmd(const void *data, uint8_t size)
+static void refresh_encrypt_key_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_refresh_encrypt_key *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void read_simple_pairing_mode_rsp(const void *data, uint8_t size)
+static void read_simple_pairing_mode_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_simple_pairing_mode *rsp = data;
 
@@ -5628,14 +5757,16 @@ static void read_simple_pairing_mode_rsp(const void *data, uint8_t size)
 	print_enable("Mode", rsp->mode);
 }
 
-static void write_simple_pairing_mode_cmd(const void *data, uint8_t size)
+static void write_simple_pairing_mode_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_simple_pairing_mode *cmd = data;
 
 	print_enable("Mode", cmd->mode);
 }
 
-static void read_local_oob_data_rsp(const void *data, uint8_t size)
+static void read_local_oob_data_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_local_oob_data *rsp = data;
 
@@ -5644,7 +5775,8 @@ static void read_local_oob_data_rsp(const void *data, uint8_t size)
 	print_randomizer_p192(rsp->randomizer);
 }
 
-static void read_inquiry_resp_tx_power_rsp(const void *data, uint8_t size)
+static void read_inquiry_resp_tx_power_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_inquiry_resp_tx_power *rsp = data;
 
@@ -5652,14 +5784,16 @@ static void read_inquiry_resp_tx_power_rsp(const void *data, uint8_t size)
 	print_power_level(rsp->level, NULL);
 }
 
-static void write_inquiry_tx_power_cmd(const void *data, uint8_t size)
+static void write_inquiry_tx_power_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_inquiry_tx_power *cmd = data;
 
 	print_power_level(cmd->level, NULL);
 }
 
-static void read_erroneous_reporting_rsp(const void *data, uint8_t size)
+static void read_erroneous_reporting_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_erroneous_reporting *rsp = data;
 
@@ -5667,14 +5801,15 @@ static void read_erroneous_reporting_rsp(const void *data, uint8_t size)
 	print_enable("Mode", rsp->mode);
 }
 
-static void write_erroneous_reporting_cmd(const void *data, uint8_t size)
+static void write_erroneous_reporting_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_erroneous_reporting *cmd = data;
 
 	print_enable("Mode", cmd->mode);
 }
 
-static void enhanced_flush_cmd(const void *data, uint8_t size)
+static void enhanced_flush_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_enhanced_flush *cmd = data;
 	const char *str;
@@ -5693,7 +5828,8 @@ static void enhanced_flush_cmd(const void *data, uint8_t size)
 	print_field("Type: %s (0x%2.2x)", str, cmd->type);
 }
 
-static void send_keypress_notify_cmd(const void *data, uint8_t size)
+static void send_keypress_notify_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_send_keypress_notify *cmd = data;
 	const char *str;
@@ -5724,7 +5860,8 @@ static void send_keypress_notify_cmd(const void *data, uint8_t size)
 	print_field("Type: %s (0x%2.2x)", str, cmd->type);
 }
 
-static void send_keypress_notify_rsp(const void *data, uint8_t size)
+static void send_keypress_notify_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_send_keypress_notify *rsp = data;
 
@@ -5732,14 +5869,16 @@ static void send_keypress_notify_rsp(const void *data, uint8_t size)
 	print_bdaddr(rsp->bdaddr);
 }
 
-static void set_event_mask_page2_cmd(const void *data, uint8_t size)
+static void set_event_mask_page2_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_set_event_mask_page2 *cmd = data;
 
 	print_event_mask(cmd->mask, events_page2_table);
 }
 
-static void read_location_data_rsp(const void *data, uint8_t size)
+static void read_location_data_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_location_data *rsp = data;
 
@@ -5750,7 +5889,8 @@ static void read_location_data_rsp(const void *data, uint8_t size)
 	print_location_options(rsp->options);
 }
 
-static void write_location_data_cmd(const void *data, uint8_t size)
+static void write_location_data_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_location_data *cmd = data;
 
@@ -5760,7 +5900,8 @@ static void write_location_data_cmd(const void *data, uint8_t size)
 	print_location_options(cmd->options);
 }
 
-static void read_flow_control_mode_rsp(const void *data, uint8_t size)
+static void read_flow_control_mode_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_flow_control_mode *rsp = data;
 
@@ -5768,14 +5909,16 @@ static void read_flow_control_mode_rsp(const void *data, uint8_t size)
 	print_flow_control_mode(rsp->mode);
 }
 
-static void write_flow_control_mode_cmd(const void *data, uint8_t size)
+static void write_flow_control_mode_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_flow_control_mode *cmd = data;
 
 	print_flow_control_mode(cmd->mode);
 }
 
-static void read_enhanced_tx_power_cmd(const void *data, uint8_t size)
+static void read_enhanced_tx_power_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_enhanced_tx_power *cmd = data;
 
@@ -5783,7 +5926,8 @@ static void read_enhanced_tx_power_cmd(const void *data, uint8_t size)
 	print_power_type(cmd->type);
 }
 
-static void read_enhanced_tx_power_rsp(const void *data, uint8_t size)
+static void read_enhanced_tx_power_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_enhanced_tx_power *rsp = data;
 
@@ -5794,7 +5938,7 @@ static void read_enhanced_tx_power_rsp(const void *data, uint8_t size)
 	print_power_level(rsp->level_8dpsk, "8DPSK");
 }
 
-static void short_range_mode_cmd(const void *data, uint8_t size)
+static void short_range_mode_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_short_range_mode *cmd = data;
 
@@ -5802,7 +5946,8 @@ static void short_range_mode_cmd(const void *data, uint8_t size)
 	print_enable("Short range mode", cmd->mode);
 }
 
-static void read_le_host_supported_rsp(const void *data, uint8_t size)
+static void read_le_host_supported_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_le_host_supported *rsp = data;
 
@@ -5811,7 +5956,8 @@ static void read_le_host_supported_rsp(const void *data, uint8_t size)
 	print_field("Simultaneous: 0x%2.2x", rsp->simultaneous);
 }
 
-static void write_le_host_supported_cmd(const void *data, uint8_t size)
+static void write_le_host_supported_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_le_host_supported *cmd = data;
 
@@ -5819,14 +5965,16 @@ static void write_le_host_supported_cmd(const void *data, uint8_t size)
 	print_field("Simultaneous: 0x%2.2x", cmd->simultaneous);
 }
 
-static void set_reserved_lt_addr_cmd(const void *data, uint8_t size)
+static void set_reserved_lt_addr_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_set_reserved_lt_addr *cmd = data;
 
 	print_lt_addr(cmd->lt_addr);
 }
 
-static void set_reserved_lt_addr_rsp(const void *data, uint8_t size)
+static void set_reserved_lt_addr_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_set_reserved_lt_addr *rsp = data;
 
@@ -5834,14 +5982,16 @@ static void set_reserved_lt_addr_rsp(const void *data, uint8_t size)
 	print_lt_addr(rsp->lt_addr);
 }
 
-static void delete_reserved_lt_addr_cmd(const void *data, uint8_t size)
+static void delete_reserved_lt_addr_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_delete_reserved_lt_addr *cmd = data;
 
 	print_lt_addr(cmd->lt_addr);
 }
 
-static void delete_reserved_lt_addr_rsp(const void *data, uint8_t size)
+static void delete_reserved_lt_addr_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_delete_reserved_lt_addr *rsp = data;
 
@@ -5849,7 +5999,8 @@ static void delete_reserved_lt_addr_rsp(const void *data, uint8_t size)
 	print_lt_addr(rsp->lt_addr);
 }
 
-static void set_peripheral_broadcast_data_cmd(const void *data, uint8_t size)
+static void set_peripheral_broadcast_data_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_set_peripheral_broadcast_data *cmd = data;
 
@@ -5864,7 +6015,8 @@ static void set_peripheral_broadcast_data_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 3, size - 3);
 }
 
-static void set_peripheral_broadcast_data_rsp(const void *data, uint8_t size)
+static void set_peripheral_broadcast_data_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_set_peripheral_broadcast_data *rsp = data;
 
@@ -5872,7 +6024,8 @@ static void set_peripheral_broadcast_data_rsp(const void *data, uint8_t size)
 	print_lt_addr(rsp->lt_addr);
 }
 
-static void read_sync_train_params_rsp(const void *data, uint8_t size)
+static void read_sync_train_params_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_sync_train_params *rsp = data;
 
@@ -5884,7 +6037,8 @@ static void read_sync_train_params_rsp(const void *data, uint8_t size)
 	print_field("Service data: 0x%2.2x", rsp->service_data);
 }
 
-static void write_sync_train_params_cmd(const void *data, uint8_t size)
+static void write_sync_train_params_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_sync_train_params *cmd = data;
 
@@ -5896,7 +6050,8 @@ static void write_sync_train_params_cmd(const void *data, uint8_t size)
 	print_field("Service data: 0x%2.2x", cmd->service_data);
 }
 
-static void write_sync_train_params_rsp(const void *data, uint8_t size)
+static void write_sync_train_params_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_write_sync_train_params *rsp = data;
 
@@ -5904,7 +6059,8 @@ static void write_sync_train_params_rsp(const void *data, uint8_t size)
 	print_interval(rsp->interval);
 }
 
-static void read_secure_conn_support_rsp(const void *data, uint8_t size)
+static void read_secure_conn_support_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_secure_conn_support *rsp = data;
 
@@ -5912,21 +6068,24 @@ static void read_secure_conn_support_rsp(const void *data, uint8_t size)
 	print_enable("Support", rsp->support);
 }
 
-static void write_secure_conn_support_cmd(const void *data, uint8_t size)
+static void write_secure_conn_support_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_secure_conn_support *cmd = data;
 
 	print_enable("Support", cmd->support);
 }
 
-static void read_auth_payload_timeout_cmd(const void *data, uint8_t size)
+static void read_auth_payload_timeout_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_auth_payload_timeout *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void read_auth_payload_timeout_rsp(const void *data, uint8_t size)
+static void read_auth_payload_timeout_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_auth_payload_timeout *rsp = data;
 
@@ -5935,7 +6094,8 @@ static void read_auth_payload_timeout_rsp(const void *data, uint8_t size)
 	print_auth_payload_timeout(rsp->timeout);
 }
 
-static void write_auth_payload_timeout_cmd(const void *data, uint8_t size)
+static void write_auth_payload_timeout_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_auth_payload_timeout *cmd = data;
 
@@ -5943,7 +6103,8 @@ static void write_auth_payload_timeout_cmd(const void *data, uint8_t size)
 	print_auth_payload_timeout(cmd->timeout);
 }
 
-static void write_auth_payload_timeout_rsp(const void *data, uint8_t size)
+static void write_auth_payload_timeout_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_write_auth_payload_timeout *rsp = data;
 
@@ -5951,7 +6112,8 @@ static void write_auth_payload_timeout_rsp(const void *data, uint8_t size)
 	print_handle(rsp->handle);
 }
 
-static void read_local_oob_ext_data_rsp(const void *data, uint8_t size)
+static void read_local_oob_ext_data_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_local_oob_ext_data *rsp = data;
 
@@ -5962,7 +6124,8 @@ static void read_local_oob_ext_data_rsp(const void *data, uint8_t size)
 	print_randomizer_p256(rsp->randomizer256);
 }
 
-static void read_ext_page_timeout_rsp(const void *data, uint8_t size)
+static void read_ext_page_timeout_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_ext_page_timeout *rsp = data;
 
@@ -5970,14 +6133,16 @@ static void read_ext_page_timeout_rsp(const void *data, uint8_t size)
 	print_timeout(rsp->timeout);
 }
 
-static void write_ext_page_timeout_cmd(const void *data, uint8_t size)
+static void write_ext_page_timeout_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_ext_page_timeout *cmd = data;
 
 	print_timeout(cmd->timeout);
 }
 
-static void read_ext_inquiry_length_rsp(const void *data, uint8_t size)
+static void read_ext_inquiry_length_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_ext_inquiry_length *rsp = data;
 
@@ -5985,14 +6150,16 @@ static void read_ext_inquiry_length_rsp(const void *data, uint8_t size)
 	print_interval(rsp->interval);
 }
 
-static void write_ext_inquiry_length_cmd(const void *data, uint8_t size)
+static void write_ext_inquiry_length_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_ext_inquiry_length *cmd = data;
 
 	print_interval(cmd->interval);
 }
 
-static void read_local_version_rsp(const void *data, uint8_t size)
+static void read_local_version_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_local_version *rsp = data;
 	uint16_t manufacturer;
@@ -6024,7 +6191,8 @@ static void read_local_version_rsp(const void *data, uint8_t size)
 	}
 }
 
-static void read_local_commands_rsp(const void *data, uint8_t size)
+static void read_local_commands_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_local_commands *rsp = data;
 
@@ -6032,7 +6200,8 @@ static void read_local_commands_rsp(const void *data, uint8_t size)
 	print_commands(rsp->commands);
 }
 
-static void read_local_features_rsp(const void *data, uint8_t size)
+static void read_local_features_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_local_features *rsp = data;
 
@@ -6040,14 +6209,16 @@ static void read_local_features_rsp(const void *data, uint8_t size)
 	print_features(0, rsp->features, 0x00);
 }
 
-static void read_local_ext_features_cmd(const void *data, uint8_t size)
+static void read_local_ext_features_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_local_ext_features *cmd = data;
 
 	print_field("Page: %d", cmd->page);
 }
 
-static void read_local_ext_features_rsp(const void *data, uint8_t size)
+static void read_local_ext_features_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_local_ext_features *rsp = data;
 
@@ -6056,7 +6227,7 @@ static void read_local_ext_features_rsp(const void *data, uint8_t size)
 	print_features(rsp->page, rsp->features, 0x00);
 }
 
-static void read_buffer_size_rsp(const void *data, uint8_t size)
+static void read_buffer_size_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_read_buffer_size *rsp = data;
 
@@ -6069,7 +6240,8 @@ static void read_buffer_size_rsp(const void *data, uint8_t size)
 					le16_to_cpu(rsp->sco_max_pkt));
 }
 
-static void read_country_code_rsp(const void *data, uint8_t size)
+static void read_country_code_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_country_code *rsp = data;
 	const char *str;
@@ -6091,7 +6263,7 @@ static void read_country_code_rsp(const void *data, uint8_t size)
 	print_field("Country code: %s (0x%2.2x)", str, rsp->code);
 }
 
-static void read_bd_addr_rsp(const void *data, uint8_t size)
+static void read_bd_addr_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_read_bd_addr *rsp = data;
 
@@ -6102,7 +6274,8 @@ static void read_bd_addr_rsp(const void *data, uint8_t size)
 		memcpy(index_list[index_current].bdaddr, rsp->bdaddr, 6);
 }
 
-static void read_data_block_size_rsp(const void *data, uint8_t size)
+static void read_data_block_size_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_data_block_size *rsp = data;
 
@@ -6112,7 +6285,8 @@ static void read_data_block_size_rsp(const void *data, uint8_t size)
 	print_field("Num blocks: %d", le16_to_cpu(rsp->num_blocks));
 }
 
-static void read_local_codecs_rsp(const void *data, uint8_t size)
+static void read_local_codecs_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_local_codecs *rsp = data;
 	uint8_t i, num_vnd_codecs;
@@ -6162,7 +6336,8 @@ static void print_list(const void *data, uint8_t size, int num_items,
 		print_hex_field("", data, size);
 }
 
-static void read_local_codecs_rsp_v2(const void *data, uint8_t size)
+static void read_local_codecs_rsp_v2(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_local_codecs_v2 *rsp = data;
 	uint8_t num_vnd_codecs;
@@ -6236,7 +6411,8 @@ static void print_vnd_codec(const char *label,
 				"  Unknown transport (0x%2.2x)", mask);
 }
 
-static void read_local_codec_caps_cmd(const void *data, uint8_t size)
+static void read_local_codec_caps_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_local_codec_caps *cmd = data;
 
@@ -6244,7 +6420,8 @@ static void read_local_codec_caps_cmd(const void *data, uint8_t size)
 	print_path_direction("Direction", cmd->dir);
 }
 
-static void read_local_codec_caps_rsp(const void *data, uint8_t size)
+static void read_local_codec_caps_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_local_codec_caps *rsp = data;
 	uint8_t i;
@@ -6272,7 +6449,8 @@ static void read_local_codec_caps_rsp(const void *data, uint8_t size)
 	}
 }
 
-static void read_local_ctrl_delay_cmd(const void *data, uint8_t size)
+static void read_local_ctrl_delay_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_local_ctrl_delay *cmd = data;
 
@@ -6281,7 +6459,7 @@ static void read_local_ctrl_delay_cmd(const void *data, uint8_t size)
 	print_field("Length Codec Configuration: %u", cmd->codec_cfg_len);
 }
 
-static void config_data_path_cmd(const void *data, uint8_t size)
+static void config_data_path_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_config_data_path *cmd = data;
 
@@ -6301,7 +6479,8 @@ static void print_usec_interval(const char *prefix, const uint8_t interval[3])
 						le32_to_cpu(u24));
 }
 
-static void read_local_ctrl_delay_rsp(const void *data, uint8_t size)
+static void read_local_ctrl_delay_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_local_ctrl_delay *rsp = data;
 
@@ -6310,7 +6489,8 @@ static void read_local_ctrl_delay_rsp(const void *data, uint8_t size)
 	print_usec_interval("Maximum Controller delay", rsp->max_delay);
 }
 
-static void read_local_pairing_options_rsp(const void *data, uint8_t size)
+static void read_local_pairing_options_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_local_pairing_options *rsp = data;
 
@@ -6319,14 +6499,16 @@ static void read_local_pairing_options_rsp(const void *data, uint8_t size)
 	print_field("Max encryption key size: %u octets", rsp->max_key_size);
 }
 
-static void read_failed_contact_counter_cmd(const void *data, uint8_t size)
+static void read_failed_contact_counter_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_failed_contact_counter *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void read_failed_contact_counter_rsp(const void *data, uint8_t size)
+static void read_failed_contact_counter_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_failed_contact_counter *rsp = data;
 
@@ -6335,14 +6517,16 @@ static void read_failed_contact_counter_rsp(const void *data, uint8_t size)
 	print_field("Counter: %u", le16_to_cpu(rsp->counter));
 }
 
-static void reset_failed_contact_counter_cmd(const void *data, uint8_t size)
+static void reset_failed_contact_counter_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_reset_failed_contact_counter *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void reset_failed_contact_counter_rsp(const void *data, uint8_t size)
+static void reset_failed_contact_counter_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_reset_failed_contact_counter *rsp = data;
 
@@ -6350,14 +6534,16 @@ static void reset_failed_contact_counter_rsp(const void *data, uint8_t size)
 	print_handle(rsp->handle);
 }
 
-static void read_link_quality_cmd(const void *data, uint8_t size)
+static void read_link_quality_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_link_quality *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void read_link_quality_rsp(const void *data, uint8_t size)
+static void read_link_quality_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_link_quality *rsp = data;
 
@@ -6366,14 +6552,14 @@ static void read_link_quality_rsp(const void *data, uint8_t size)
 	print_field("Link quality: 0x%2.2x", rsp->link_quality);
 }
 
-static void read_rssi_cmd(const void *data, uint8_t size)
+static void read_rssi_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_read_rssi *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void read_rssi_rsp(const void *data, uint8_t size)
+static void read_rssi_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_read_rssi *rsp = data;
 
@@ -6382,14 +6568,16 @@ static void read_rssi_rsp(const void *data, uint8_t size)
 	print_rssi(rsp->rssi);
 }
 
-static void read_afh_channel_map_cmd(const void *data, uint8_t size)
+static void read_afh_channel_map_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_afh_channel_map *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void read_afh_channel_map_rsp(const void *data, uint8_t size)
+static void read_afh_channel_map_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_afh_channel_map *rsp = data;
 
@@ -6399,7 +6587,7 @@ static void read_afh_channel_map_rsp(const void *data, uint8_t size)
 	print_channel_map(rsp->map);
 }
 
-static void read_clock_cmd(const void *data, uint8_t size)
+static void read_clock_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_read_clock *cmd = data;
 
@@ -6407,7 +6595,7 @@ static void read_clock_cmd(const void *data, uint8_t size)
 	print_clock_type(cmd->type);
 }
 
-static void read_clock_rsp(const void *data, uint8_t size)
+static void read_clock_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_read_clock *rsp = data;
 
@@ -6417,14 +6605,16 @@ static void read_clock_rsp(const void *data, uint8_t size)
 	print_clock_accuracy(rsp->accuracy);
 }
 
-static void read_encrypt_key_size_cmd(const void *data, uint8_t size)
+static void read_encrypt_key_size_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_encrypt_key_size *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void read_encrypt_key_size_rsp(const void *data, uint8_t size)
+static void read_encrypt_key_size_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_encrypt_key_size *rsp = data;
 
@@ -6433,7 +6623,8 @@ static void read_encrypt_key_size_rsp(const void *data, uint8_t size)
 	print_key_size(rsp->key_size);
 }
 
-static void read_local_amp_info_rsp(const void *data, uint8_t size)
+static void read_local_amp_info_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_local_amp_info *rsp = data;
 	const char *str;
@@ -6468,7 +6659,8 @@ static void read_local_amp_info_rsp(const void *data, uint8_t size)
 					le32_to_cpu(rsp->be_flush_to));
 }
 
-static void read_local_amp_assoc_cmd(const void *data, uint8_t size)
+static void read_local_amp_assoc_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_read_local_amp_assoc *cmd = data;
 
@@ -6477,7 +6669,8 @@ static void read_local_amp_assoc_cmd(const void *data, uint8_t size)
 	print_field("Max ASSOC length: %d", le16_to_cpu(cmd->max_assoc_len));
 }
 
-static void read_local_amp_assoc_rsp(const void *data, uint8_t size)
+static void read_local_amp_assoc_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_local_amp_assoc *rsp = data;
 
@@ -6489,7 +6682,8 @@ static void read_local_amp_assoc_rsp(const void *data, uint8_t size)
 	packet_hexdump(data + 4, size - 4);
 }
 
-static void write_remote_amp_assoc_cmd(const void *data, uint8_t size)
+static void write_remote_amp_assoc_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_remote_amp_assoc *cmd = data;
 
@@ -6501,7 +6695,8 @@ static void write_remote_amp_assoc_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 5, size - 5);
 }
 
-static void write_remote_amp_assoc_rsp(const void *data, uint8_t size)
+static void write_remote_amp_assoc_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_write_remote_amp_assoc *rsp = data;
 
@@ -6509,7 +6704,8 @@ static void write_remote_amp_assoc_rsp(const void *data, uint8_t size)
 	print_phy_handle(rsp->phy_handle);
 }
 
-static void get_mws_transport_config_rsp(const void *data, uint8_t size)
+static void get_mws_transport_config_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_get_mws_transport_config *rsp = data;
 	uint8_t sum_baud_rates = 0;
@@ -6564,7 +6760,8 @@ static void get_mws_transport_config_rsp(const void *data, uint8_t size)
 		size - 2 - rsp->num_transports * 2 - sum_baud_rates * 8);
 }
 
-static void set_triggered_clock_capture_cmd(const void *data, uint8_t size)
+static void set_triggered_clock_capture_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_set_triggered_clock_capture *cmd = data;
 
@@ -6575,7 +6772,8 @@ static void set_triggered_clock_capture_cmd(const void *data, uint8_t size)
 	print_field("Clock captures to filter: %u", cmd->num_filter);
 }
 
-static void read_loopback_mode_rsp(const void *data, uint8_t size)
+static void read_loopback_mode_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_read_loopback_mode *rsp = data;
 
@@ -6583,28 +6781,32 @@ static void read_loopback_mode_rsp(const void *data, uint8_t size)
 	print_loopback_mode(rsp->mode);
 }
 
-static void write_loopback_mode_cmd(const void *data, uint8_t size)
+static void write_loopback_mode_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_loopback_mode *cmd = data;
 
 	print_loopback_mode(cmd->mode);
 }
 
-static void write_ssp_debug_mode_cmd(const void *data, uint8_t size)
+static void write_ssp_debug_mode_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_write_ssp_debug_mode *cmd = data;
 
 	print_enable("Debug Mode", cmd->mode);
 }
 
-static void le_set_event_mask_cmd(const void *data, uint8_t size)
+static void le_set_event_mask_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_event_mask *cmd = data;
 
 	print_event_mask(cmd->mask, events_le_table);
 }
 
-static void le_read_buffer_size_rsp(const void *data, uint8_t size)
+static void le_read_buffer_size_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_buffer_size *rsp = data;
 
@@ -6613,7 +6815,8 @@ static void le_read_buffer_size_rsp(const void *data, uint8_t size)
 	print_field("Num data packets: %d", rsp->le_max_pkt);
 }
 
-static void le_read_local_features_rsp(const void *data, uint8_t size)
+static void le_read_local_features_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_local_features *rsp = data;
 
@@ -6621,14 +6824,16 @@ static void le_read_local_features_rsp(const void *data, uint8_t size)
 	print_features(0, rsp->features, 0x01);
 }
 
-static void le_set_random_address_cmd(const void *data, uint8_t size)
+static void le_set_random_address_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_random_address *cmd = data;
 
 	print_addr("Address", cmd->addr, 0x01);
 }
 
-static void le_set_adv_parameters_cmd(const void *data, uint8_t size)
+static void le_set_adv_parameters_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_adv_parameters *cmd = data;
 	const char *str;
@@ -6666,7 +6871,8 @@ static void le_set_adv_parameters_cmd(const void *data, uint8_t size)
 	print_adv_filter_policy("Filter policy", cmd->filter_policy);
 }
 
-static void le_read_adv_tx_power_rsp(const void *data, uint8_t size)
+static void le_read_adv_tx_power_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_adv_tx_power *rsp = data;
 
@@ -6674,7 +6880,7 @@ static void le_read_adv_tx_power_rsp(const void *data, uint8_t size)
 	print_power_level(rsp->level, NULL);
 }
 
-static void le_set_adv_data_cmd(const void *data, uint8_t size)
+static void le_set_adv_data_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_adv_data *cmd = data;
 
@@ -6682,7 +6888,8 @@ static void le_set_adv_data_cmd(const void *data, uint8_t size)
 	print_eir(cmd->data, cmd->len, true);
 }
 
-static void le_set_scan_rsp_data_cmd(const void *data, uint8_t size)
+static void le_set_scan_rsp_data_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_scan_rsp_data *cmd = data;
 
@@ -6690,7 +6897,8 @@ static void le_set_scan_rsp_data_cmd(const void *data, uint8_t size)
 	print_eir(cmd->data, cmd->len, true);
 }
 
-static void le_set_adv_enable_cmd(const void *data, uint8_t size)
+static void le_set_adv_enable_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_adv_enable *cmd = data;
 
@@ -6741,7 +6949,8 @@ static void print_scan_filter_policy(uint8_t policy)
 	print_field("Filter policy: %s (0x%2.2x)", str, policy);
 }
 
-static void le_set_scan_parameters_cmd(const void *data, uint8_t size)
+static void le_set_scan_parameters_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_scan_parameters *cmd = data;
 
@@ -6752,7 +6961,8 @@ static void le_set_scan_parameters_cmd(const void *data, uint8_t size)
 	print_scan_filter_policy(cmd->filter_policy);
 }
 
-static void le_set_scan_enable_cmd(const void *data, uint8_t size)
+static void le_set_scan_enable_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_scan_enable *cmd = data;
 
@@ -6760,7 +6970,7 @@ static void le_set_scan_enable_cmd(const void *data, uint8_t size)
 	print_enable("Filter duplicates", cmd->filter_dup);
 }
 
-static void le_create_conn_cmd(const void *data, uint8_t size)
+static void le_create_conn_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_create_conn *cmd = data;
 	const char *str;
@@ -6796,7 +7006,8 @@ static void le_create_conn_cmd(const void *data, uint8_t size)
 	print_slot_625("Max connection length", cmd->max_length);
 }
 
-static void le_read_accept_list_size_rsp(const void *data, uint8_t size)
+static void le_read_accept_list_size_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_accept_list_size *rsp = data;
 
@@ -6804,7 +7015,8 @@ static void le_read_accept_list_size_rsp(const void *data, uint8_t size)
 	print_field("Size: %u", rsp->size);
 }
 
-static void le_add_to_accept_list_cmd(const void *data, uint8_t size)
+static void le_add_to_accept_list_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_add_to_accept_list *cmd = data;
 
@@ -6812,7 +7024,8 @@ static void le_add_to_accept_list_cmd(const void *data, uint8_t size)
 	print_addr("Address", cmd->addr, cmd->addr_type);
 }
 
-static void le_remove_from_accept_list_cmd(const void *data, uint8_t size)
+static void le_remove_from_accept_list_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_remove_from_accept_list *cmd = data;
 
@@ -6820,7 +7033,7 @@ static void le_remove_from_accept_list_cmd(const void *data, uint8_t size)
 	print_addr("Address", cmd->addr, cmd->addr_type);
 }
 
-static void le_conn_update_cmd(const void *data, uint8_t size)
+static void le_conn_update_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_conn_update *cmd = data;
 
@@ -6835,21 +7048,24 @@ static void le_conn_update_cmd(const void *data, uint8_t size)
 	print_slot_625("Max connection length", cmd->max_length);
 }
 
-static void le_set_host_classification_cmd(const void *data, uint8_t size)
+static void le_set_host_classification_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_host_classification *cmd = data;
 
 	print_le_channel_map(cmd->map);
 }
 
-static void le_read_channel_map_cmd(const void *data, uint8_t size)
+static void le_read_channel_map_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_read_channel_map *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void le_read_channel_map_rsp(const void *data, uint8_t size)
+static void le_read_channel_map_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_channel_map *rsp = data;
 
@@ -6858,14 +7074,15 @@ static void le_read_channel_map_rsp(const void *data, uint8_t size)
 	print_le_channel_map(rsp->map);
 }
 
-static void le_read_remote_features_cmd(const void *data, uint8_t size)
+static void le_read_remote_features_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_read_remote_features *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void le_encrypt_cmd(const void *data, uint8_t size)
+static void le_encrypt_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_encrypt *cmd = data;
 
@@ -6873,7 +7090,7 @@ static void le_encrypt_cmd(const void *data, uint8_t size)
 	print_key("Plaintext data", cmd->plaintext);
 }
 
-static void le_encrypt_rsp(const void *data, uint8_t size)
+static void le_encrypt_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_le_encrypt *rsp = data;
 
@@ -6881,7 +7098,7 @@ static void le_encrypt_rsp(const void *data, uint8_t size)
 	print_key("Encrypted data", rsp->data);
 }
 
-static void le_rand_rsp(const void *data, uint8_t size)
+static void le_rand_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_le_rand *rsp = data;
 
@@ -6889,7 +7106,7 @@ static void le_rand_rsp(const void *data, uint8_t size)
 	print_random_number(rsp->number);
 }
 
-static void le_start_encrypt_cmd(const void *data, uint8_t size)
+static void le_start_encrypt_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_start_encrypt *cmd = data;
 
@@ -6899,7 +7116,7 @@ static void le_start_encrypt_cmd(const void *data, uint8_t size)
 	print_key("Long term key", cmd->ltk);
 }
 
-static void le_ltk_req_reply_cmd(const void *data, uint8_t size)
+static void le_ltk_req_reply_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_ltk_req_reply *cmd = data;
 
@@ -6907,7 +7124,7 @@ static void le_ltk_req_reply_cmd(const void *data, uint8_t size)
 	print_key("Long term key", cmd->ltk);
 }
 
-static void le_ltk_req_reply_rsp(const void *data, uint8_t size)
+static void le_ltk_req_reply_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_le_ltk_req_reply *rsp = data;
 
@@ -6915,14 +7132,16 @@ static void le_ltk_req_reply_rsp(const void *data, uint8_t size)
 	print_handle(rsp->handle);
 }
 
-static void le_ltk_req_neg_reply_cmd(const void *data, uint8_t size)
+static void le_ltk_req_neg_reply_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_ltk_req_neg_reply *cmd = data;
 
 	print_handle(cmd->handle);
 }
 
-static void le_ltk_req_neg_reply_rsp(const void *data, uint8_t size)
+static void le_ltk_req_neg_reply_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_ltk_req_neg_reply *rsp = data;
 
@@ -6930,7 +7149,8 @@ static void le_ltk_req_neg_reply_rsp(const void *data, uint8_t size)
 	print_handle(rsp->handle);
 }
 
-static void le_read_supported_states_rsp(const void *data, uint8_t size)
+static void le_read_supported_states_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_supported_states *rsp = data;
 
@@ -6938,7 +7158,7 @@ static void le_read_supported_states_rsp(const void *data, uint8_t size)
 	print_le_states(rsp->states);
 }
 
-static void le_receiver_test_cmd(const void *data, uint8_t size)
+static void le_receiver_test_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_receiver_test *cmd = data;
 
@@ -6946,7 +7166,8 @@ static void le_receiver_test_cmd(const void *data, uint8_t size)
 				(cmd->frequency * 2) + 2402, cmd->frequency);
 }
 
-static void le_transmitter_test_cmd(const void *data, uint8_t size)
+static void le_transmitter_test_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_transmitter_test *cmd = data;
 
@@ -6956,7 +7177,7 @@ static void le_transmitter_test_cmd(const void *data, uint8_t size)
 	print_field("Packet payload: 0x%2.2x", cmd->payload);
 }
 
-static void le_test_end_rsp(const void *data, uint8_t size)
+static void le_test_end_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_le_test_end *rsp = data;
 
@@ -6964,7 +7185,8 @@ static void le_test_end_rsp(const void *data, uint8_t size)
 	print_field("Number of packets: %d", le16_to_cpu(rsp->num_packets));
 }
 
-static void le_conn_param_req_reply_cmd(const void *data, uint8_t size)
+static void le_conn_param_req_reply_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_conn_param_req_reply *cmd = data;
 
@@ -6979,7 +7201,8 @@ static void le_conn_param_req_reply_cmd(const void *data, uint8_t size)
 	print_slot_625("Max connection length", cmd->max_length);
 }
 
-static void le_conn_param_req_reply_rsp(const void *data, uint8_t size)
+static void le_conn_param_req_reply_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_conn_param_req_reply *rsp = data;
 
@@ -6987,7 +7210,8 @@ static void le_conn_param_req_reply_rsp(const void *data, uint8_t size)
 	print_handle(rsp->handle);
 }
 
-static void le_conn_param_req_neg_reply_cmd(const void *data, uint8_t size)
+static void le_conn_param_req_neg_reply_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_conn_param_req_neg_reply *cmd = data;
 
@@ -6995,7 +7219,8 @@ static void le_conn_param_req_neg_reply_cmd(const void *data, uint8_t size)
 	print_reason(cmd->reason);
 }
 
-static void le_conn_param_req_neg_reply_rsp(const void *data, uint8_t size)
+static void le_conn_param_req_neg_reply_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_conn_param_req_neg_reply *rsp = data;
 
@@ -7003,7 +7228,8 @@ static void le_conn_param_req_neg_reply_rsp(const void *data, uint8_t size)
 	print_handle(rsp->handle);
 }
 
-static void le_set_data_length_cmd(const void *data, uint8_t size)
+static void le_set_data_length_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_data_length *cmd = data;
 
@@ -7012,7 +7238,8 @@ static void le_set_data_length_cmd(const void *data, uint8_t size)
 	print_field("TX time: %d", le16_to_cpu(cmd->tx_time));
 }
 
-static void le_set_data_length_rsp(const void *data, uint8_t size)
+static void le_set_data_length_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_set_data_length *rsp = data;
 
@@ -7020,7 +7247,8 @@ static void le_set_data_length_rsp(const void *data, uint8_t size)
 	print_handle(rsp->handle);
 }
 
-static void le_read_default_data_length_rsp(const void *data, uint8_t size)
+static void le_read_default_data_length_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_default_data_length *rsp = data;
 
@@ -7029,7 +7257,8 @@ static void le_read_default_data_length_rsp(const void *data, uint8_t size)
 	print_field("TX time: %d", le16_to_cpu(rsp->tx_time));
 }
 
-static void le_write_default_data_length_cmd(const void *data, uint8_t size)
+static void le_write_default_data_length_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_write_default_data_length *cmd = data;
 
@@ -7037,14 +7266,16 @@ static void le_write_default_data_length_cmd(const void *data, uint8_t size)
 	print_field("TX time: %d", le16_to_cpu(cmd->tx_time));
 }
 
-static void le_generate_dhkey_cmd(const void *data, uint8_t size)
+static void le_generate_dhkey_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_generate_dhkey *cmd = data;
 
 	print_pk256("Remote P-256 public key", cmd->remote_pk256);
 }
 
-static void le_add_to_resolv_list_cmd(const void *data, uint8_t size)
+static void le_add_to_resolv_list_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_add_to_resolv_list *cmd = data;
 
@@ -7054,7 +7285,8 @@ static void le_add_to_resolv_list_cmd(const void *data, uint8_t size)
 	print_key("Local identity resolving key", cmd->local_irk);
 }
 
-static void le_remove_from_resolv_list_cmd(const void *data, uint8_t size)
+static void le_remove_from_resolv_list_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_remove_from_resolv_list *cmd = data;
 
@@ -7062,7 +7294,8 @@ static void le_remove_from_resolv_list_cmd(const void *data, uint8_t size)
 	print_addr("Address", cmd->addr, cmd->addr_type);
 }
 
-static void le_read_resolv_list_size_rsp(const void *data, uint8_t size)
+static void le_read_resolv_list_size_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_resolv_list_size *rsp = data;
 
@@ -7070,7 +7303,8 @@ static void le_read_resolv_list_size_rsp(const void *data, uint8_t size)
 	print_field("Size: %u", rsp->size);
 }
 
-static void le_read_peer_resolv_addr_cmd(const void *data, uint8_t size)
+static void le_read_peer_resolv_addr_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_read_peer_resolv_addr *cmd = data;
 
@@ -7078,7 +7312,8 @@ static void le_read_peer_resolv_addr_cmd(const void *data, uint8_t size)
 	print_addr("Address", cmd->addr, cmd->addr_type);
 }
 
-static void le_read_peer_resolv_addr_rsp(const void *data, uint8_t size)
+static void le_read_peer_resolv_addr_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_peer_resolv_addr *rsp = data;
 
@@ -7086,7 +7321,8 @@ static void le_read_peer_resolv_addr_rsp(const void *data, uint8_t size)
 	print_addr("Address", rsp->addr, 0x01);
 }
 
-static void le_read_local_resolv_addr_cmd(const void *data, uint8_t size)
+static void le_read_local_resolv_addr_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_read_local_resolv_addr *cmd = data;
 
@@ -7094,7 +7330,8 @@ static void le_read_local_resolv_addr_cmd(const void *data, uint8_t size)
 	print_addr("Address", cmd->addr, cmd->addr_type);
 }
 
-static void le_read_local_resolv_addr_rsp(const void *data, uint8_t size)
+static void le_read_local_resolv_addr_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_local_resolv_addr *rsp = data;
 
@@ -7102,21 +7339,24 @@ static void le_read_local_resolv_addr_rsp(const void *data, uint8_t size)
 	print_addr("Address", rsp->addr, 0x01);
 }
 
-static void le_set_resolv_enable_cmd(const void *data, uint8_t size)
+static void le_set_resolv_enable_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_resolv_enable *cmd = data;
 
 	print_enable("Address resolution", cmd->enable);
 }
 
-static void le_set_resolv_timeout_cmd(const void *data, uint8_t size)
+static void le_set_resolv_timeout_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_resolv_timeout *cmd = data;
 
 	print_field("Timeout: %u seconds", le16_to_cpu(cmd->timeout));
 }
 
-static void le_read_max_data_length_rsp(const void *data, uint8_t size)
+static void le_read_max_data_length_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_max_data_length *rsp = data;
 
@@ -7127,7 +7367,7 @@ static void le_read_max_data_length_rsp(const void *data, uint8_t size)
 	print_field("Max RX time: %d", le16_to_cpu(rsp->max_rx_time));
 }
 
-static void le_read_phy_cmd(const void *data, uint8_t size)
+static void le_read_phy_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_read_phy *cmd = data;
 
@@ -7156,7 +7396,7 @@ static void print_le_phy(const char *prefix, uint8_t phy)
 	print_field("%s: %s (0x%2.2x)", prefix, str, phy);
 }
 
-static void le_read_phy_rsp(const void *data, uint8_t size)
+static void le_read_phy_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_phy *rsp = data;
 
@@ -7208,14 +7448,15 @@ static void print_le_phys_preference(uint8_t all_phys, uint8_t tx_phys,
 							" (0x%2.2x)", mask);
 }
 
-static void le_set_default_phy_cmd(const void *data, uint8_t size)
+static void le_set_default_phy_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_default_phy *cmd = data;
 
 	print_le_phys_preference(cmd->all_phys, cmd->tx_phys, cmd->rx_phys);
 }
 
-static void le_set_phy_cmd(const void *data, uint8_t size)
+static void le_set_phy_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_phy *cmd = data;
 	const char *str;
@@ -7237,7 +7478,8 @@ static void le_set_phy_cmd(const void *data, uint8_t size)
 	print_field("PHY options preference: %s (0x%4.4x)", str, cmd->phy_opts);
 }
 
-static void le_enhanced_receiver_test_cmd(const void *data, uint8_t size)
+static void le_enhanced_receiver_test_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_enhanced_receiver_test *cmd = data;
 	const char *str;
@@ -7262,7 +7504,8 @@ static void le_enhanced_receiver_test_cmd(const void *data, uint8_t size)
 							cmd->modulation_index);
 }
 
-static void le_enhanced_transmitter_test_cmd(const void *data, uint8_t size)
+static void le_enhanced_transmitter_test_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_enhanced_transmitter_test *cmd = data;
 	const char *str;
@@ -7293,7 +7536,8 @@ static void le_enhanced_transmitter_test_cmd(const void *data, uint8_t size)
 	print_field("PHY: %s (0x%2.2x)", str, cmd->phy);
 }
 
-static void le_set_adv_set_rand_addr(const void *data, uint8_t size)
+static void le_set_adv_set_rand_addr(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_adv_set_rand_addr *cmd = data;
 
@@ -7379,7 +7623,8 @@ static void print_ext_slot_625(const char *label, const uint8_t value[3])
 						value_cpu * 0.625, value_cpu);
 }
 
-static void le_set_ext_adv_params_cmd(const void *data, uint8_t size)
+static void le_set_ext_adv_params_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_ext_adv_params *cmd = data;
 	const char *str;
@@ -7418,7 +7663,8 @@ static void le_set_ext_adv_params_cmd(const void *data, uint8_t size)
 	print_enable("Scan request notifications", cmd->notif_enable);
 }
 
-static void le_set_ext_adv_params_rsp(const void *data, uint8_t size)
+static void le_set_ext_adv_params_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_set_ext_adv_params *rsp = data;
 
@@ -7426,7 +7672,8 @@ static void le_set_ext_adv_params_rsp(const void *data, uint8_t size)
 	print_power_level(rsp->tx_power, "selected");
 }
 
-static void le_set_ext_adv_data_cmd(const void *data, uint8_t size)
+static void le_set_ext_adv_data_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_ext_adv_data *cmd = data;
 	const char *str;
@@ -7474,7 +7721,8 @@ static void le_set_ext_adv_data_cmd(const void *data, uint8_t size)
 	packet_print_ad(cmd->data, size - sizeof(*cmd));
 }
 
-static void le_set_ext_scan_rsp_data_cmd(const void *data, uint8_t size)
+static void le_set_ext_scan_rsp_data_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_ext_scan_rsp_data *cmd = data;
 	const char *str;
@@ -7522,7 +7770,8 @@ static void le_set_ext_scan_rsp_data_cmd(const void *data, uint8_t size)
 	packet_print_ad(cmd->data, size - sizeof(*cmd));
 }
 
-static void le_set_ext_adv_enable_cmd(const void *data, uint8_t size)
+static void le_set_ext_adv_enable_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_ext_adv_enable *cmd = data;
 	const struct bt_hci_cmd_ext_adv_set *adv_set;
@@ -7550,7 +7799,8 @@ static void le_set_ext_adv_enable_cmd(const void *data, uint8_t size)
 	}
 }
 
-static void le_read_max_adv_data_len_rsp(const void *data, uint8_t size)
+static void le_read_max_adv_data_len_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_max_adv_data_len *rsp = data;
 
@@ -7558,7 +7808,8 @@ static void le_read_max_adv_data_len_rsp(const void *data, uint8_t size)
 	print_field("Max length: %d", rsp->max_len);
 }
 
-static void le_read_num_supported_adv_sets_rsp(const void *data, uint8_t size)
+static void le_read_num_supported_adv_sets_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_num_supported_adv_sets *rsp = data;
 
@@ -7566,7 +7817,8 @@ static void le_read_num_supported_adv_sets_rsp(const void *data, uint8_t size)
 	print_field("Num supported adv sets: %d", rsp->num_of_sets);
 }
 
-static void le_remove_adv_set_cmd(const void *data, uint8_t size)
+static void le_remove_adv_set_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_remove_adv_set *cmd = data;
 
@@ -7591,7 +7843,7 @@ static void print_pa_properties(uint16_t flags)
 									mask);
 }
 
-static void le_set_pa_params_cmd(const void *data, uint8_t size)
+static void le_set_pa_params_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_pa_params *cmd = data;
 
@@ -7601,7 +7853,7 @@ static void le_set_pa_params_cmd(const void *data, uint8_t size)
 	print_pa_properties(cmd->properties);
 }
 
-static void le_set_pa_data_cmd(const void *data, uint8_t size)
+static void le_set_pa_data_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_pa_data *cmd = data;
 	const char *str;
@@ -7631,7 +7883,7 @@ static void le_set_pa_data_cmd(const void *data, uint8_t size)
 	print_eir(cmd->data, cmd->data_len, true);
 }
 
-static void le_set_pa_enable_cmd(const void *data, uint8_t size)
+static void le_set_pa_enable_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_pa_enable *cmd = data;
 
@@ -7674,7 +7926,8 @@ static void print_ext_scan_phys(const void *data, uint8_t flags)
 							" (0x%2.2x)", mask);
 }
 
-static void le_set_ext_scan_params_cmd(const void *data, uint8_t size)
+static void le_set_ext_scan_params_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_ext_scan_params *cmd = data;
 
@@ -7683,7 +7936,8 @@ static void le_set_ext_scan_params_cmd(const void *data, uint8_t size)
 	print_ext_scan_phys(cmd->data, cmd->num_phys);
 }
 
-static void le_set_ext_scan_enable_cmd(const void *data, uint8_t size)
+static void le_set_ext_scan_enable_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_ext_scan_enable *cmd = data;
 
@@ -7746,7 +8000,8 @@ static void print_ext_conn_phys(const void *data, uint8_t flags)
 							" (0x%2.2x)", mask);
 }
 
-static void le_ext_create_conn_cmd(const void *data, uint8_t size)
+static void le_ext_create_conn_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_ext_create_conn *cmd = data;
 	const char *str;
@@ -7830,7 +8085,8 @@ static void print_create_sync_options(uint8_t flags)
 	}
 }
 
-static void le_pa_create_sync_cmd(const void *data, uint8_t size)
+static void le_pa_create_sync_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_pa_create_sync *cmd = data;
 
@@ -7845,14 +8101,15 @@ static void le_pa_create_sync_cmd(const void *data, uint8_t size)
 	print_create_sync_cte_type(cmd->sync_cte_type);
 }
 
-static void le_pa_term_sync_cmd(const void *data, uint8_t size)
+static void le_pa_term_sync_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_pa_term_sync *cmd = data;
 
 	print_field("Sync handle: 0x%4.4x", cmd->sync_handle);
 }
 
-static void le_add_dev_pa_list_cmd(const void *data, uint8_t size)
+static void le_add_dev_pa_list_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_add_dev_pa_list *cmd = data;
 
@@ -7861,7 +8118,8 @@ static void le_add_dev_pa_list_cmd(const void *data, uint8_t size)
 	print_field("SID: 0x%2.2x", cmd->sid);
 }
 
-static void le_remove_dev_pa_list_cmd(const void *data, uint8_t size)
+static void le_remove_dev_pa_list_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_remove_dev_pa_list *cmd = data;
 
@@ -7870,7 +8128,8 @@ static void le_remove_dev_pa_list_cmd(const void *data, uint8_t size)
 	print_field("SID: 0x%2.2x", cmd->sid);
 }
 
-static void le_read_pa_list_size_rsp(const void *data, uint8_t size)
+static void le_read_pa_list_size_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_dev_pa_list_size *rsp = data;
 
@@ -7878,7 +8137,8 @@ static void le_read_pa_list_size_rsp(const void *data, uint8_t size)
 	print_field("List size: 0x%2.2x", rsp->list_size);
 }
 
-static void le_read_tx_power_rsp(const void *data, uint8_t size)
+static void le_read_tx_power_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_tx_power *rsp = data;
 
@@ -7887,7 +8147,8 @@ static void le_read_tx_power_rsp(const void *data, uint8_t size)
 	print_field("Max Tx power: %d dBm", rsp->max_tx_power);
 }
 
-static void le_read_rf_path_comp_rsp(const void *data, uint8_t size)
+static void le_read_rf_path_comp_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_rf_path_comp *rsp = data;
 
@@ -7898,7 +8159,8 @@ static void le_read_rf_path_comp_rsp(const void *data, uint8_t size)
 							rsp->rf_rx_path_comp);
 }
 
-static void le_write_rf_path_comp_cmd(const void *data, uint8_t size)
+static void le_write_rf_path_comp_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_write_rf_path_comp *cmd = data;
 
@@ -7908,7 +8170,7 @@ static void le_write_rf_path_comp_cmd(const void *data, uint8_t size)
 							cmd->rf_rx_path_comp);
 }
 
-static void le_set_priv_mode_cmd(const void *data, uint8_t size)
+static void le_set_priv_mode_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_priv_mode *cmd = data;
 	const char *str;
@@ -7932,7 +8194,8 @@ static void le_set_priv_mode_cmd(const void *data, uint8_t size)
 	print_field("Privacy Mode: %s (0x%2.2x)", str, cmd->priv_mode);
 }
 
-static void le_receiver_test_cmd_v3(const void *data, uint8_t size)
+static void le_receiver_test_cmd_v3(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_receiver_test_v3 *cmd = data;
 	uint8_t i;
@@ -7993,7 +8256,7 @@ static const char *parse_tx_test_payload(uint8_t payload)
 	}
 }
 
-static void le_tx_test_cmd_v3(const void *data, uint8_t size)
+static void le_tx_test_cmd_v3(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_tx_test_v3 *cmd = data;
 	uint8_t i;
@@ -8034,7 +8297,7 @@ static void le_tx_test_cmd_v3(const void *data, uint8_t size)
 		print_field("  Antenna ID: %u", cmd->antenna_ids[i]);
 }
 
-static void le_pa_rec_enable(const void *data, uint8_t size)
+static void le_pa_rec_enable(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_pa_enable *cmd = data;
 
@@ -8042,7 +8305,7 @@ static void le_pa_rec_enable(const void *data, uint8_t size)
 	print_enable("Reporting", cmd->enable);
 }
 
-static void le_pa_sync_trans(const void *data, uint8_t size)
+static void le_pa_sync_trans(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_periodic_sync_trans *cmd = data;
 
@@ -8051,7 +8314,7 @@ static void le_pa_sync_trans(const void *data, uint8_t size)
 	print_field("Sync handle: %d", cmd->sync_handle);
 }
 
-static void le_pa_set_info_trans(const void *data, uint8_t size)
+static void le_pa_set_info_trans(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_pa_set_info_trans *cmd = data;
 
@@ -8082,7 +8345,8 @@ static void print_sync_mode(uint8_t mode)
 	print_field("Mode: %s (0x%2.2x)", str, mode);
 }
 
-static void le_pa_sync_trans_params(const void *data, uint8_t size)
+static void le_pa_sync_trans_params(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_pa_sync_trans_params *cmd = data;
 
@@ -8095,8 +8359,8 @@ static void le_pa_sync_trans_params(const void *data, uint8_t size)
 	print_create_sync_cte_type(cmd->cte_type);
 }
 
-static void le_set_default_pa_sync_trans_params(const void *data,
-								uint8_t size)
+static void le_set_default_pa_sync_trans_params(uint16_t index,
+						const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_default_pa_sync_trans_params *cmd = data;
 
@@ -8168,7 +8432,8 @@ static void print_framing(uint8_t value)
 	}
 }
 
-static void le_read_buffer_size_v2_rsp(const void *data, uint8_t size)
+static void le_read_buffer_size_v2_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_buffer_size_v2 *rsp = data;
 
@@ -8183,14 +8448,16 @@ static void le_read_buffer_size_v2_rsp(const void *data, uint8_t size)
 	print_field("ISO max packet: %d", rsp->iso_max_pkt);
 }
 
-static void le_read_iso_tx_sync_cmd(const void *data, uint8_t size)
+static void le_read_iso_tx_sync_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_read_iso_tx_sync *cmd = data;
 
 	print_field("Handle: %d", le16_to_cpu(cmd->handle));
 }
 
-static void le_read_iso_tx_sync_rsp(const void *data, uint8_t size)
+static void le_read_iso_tx_sync_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_iso_tx_sync *rsp = data;
 	uint32_t offset = 0;
@@ -8226,7 +8493,8 @@ static void print_cis_params(const void *data, int i)
 							cis->p_rtn);
 }
 
-static void le_set_cig_params_cmd(const void *data, uint8_t size)
+static void le_set_cig_params_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_cig_params *cmd = data;
 
@@ -8270,7 +8538,8 @@ static void print_cis_params_test(const void *data, int i)
 	print_field("Peripheral to Central Burst Number: 0x%2.2x", cis->p_bn);
 }
 
-static void le_set_cig_params_test_cmd(const void *data, uint8_t size)
+static void le_set_cig_params_test_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_cig_params_test *cmd = data;
 
@@ -8302,7 +8571,8 @@ static void print_cig_handle(const void *data, int i)
 	print_field("Connection Handle #%d: %d", i, handle);
 }
 
-static void le_set_cig_params_rsp(const void *data, uint8_t size)
+static void le_set_cig_params_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_set_cig_params *rsp = data;
 
@@ -8328,7 +8598,7 @@ static void print_cis(const void *data, int i)
 	print_field("ACL Handle: %d", cis->acl_handle);
 }
 
-static void le_create_cis_cmd(const void *data, uint8_t size)
+static void le_create_cis_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_create_cis *cmd = data;
 
@@ -8339,14 +8609,14 @@ static void le_create_cis_cmd(const void *data, uint8_t size)
 	print_list(cmd->cis, size, cmd->num_cis, sizeof(*cmd->cis), print_cis);
 }
 
-static void le_remove_cig_cmd(const void *data, uint8_t size)
+static void le_remove_cig_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_remove_cig *cmd = data;
 
 	print_field("CIG ID: 0x%02x", cmd->cig_id);
 }
 
-static void le_remove_cig_rsp(const void *data, uint8_t size)
+static void le_remove_cig_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_le_remove_cig *rsp = data;
 
@@ -8358,14 +8628,16 @@ static void le_remove_cig_rsp(const void *data, uint8_t size)
 	print_field("CIG ID: 0x%2.2x", rsp->cig_id);
 }
 
-static void le_accept_cis_req_cmd(const void *data, uint8_t size)
+static void le_accept_cis_req_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_accept_cis *cmd = data;
 
 	print_field("CIS Handle: %d", le16_to_cpu(cmd->handle));
 }
 
-static void le_reject_cis_req_cmd(const void *data, uint8_t size)
+static void le_reject_cis_req_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_reject_cis *cmd = data;
 
@@ -8387,7 +8659,7 @@ static void print_bis(const struct bt_hci_bis *bis)
 	print_hex_field("Broadcast Code", bis->bcode, 16);
 }
 
-static void le_create_big_cmd(const void *data, uint8_t size)
+static void le_create_big_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_create_big *cmd = data;
 
@@ -8418,7 +8690,8 @@ static void print_bis_test(const void *data, int i)
 	print_hex_field("Broadcast Code", bis->bcode, 16);
 }
 
-static void le_create_big_cmd_test_cmd(const void *data, uint8_t size)
+static void le_create_big_cmd_test_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_create_big_test *cmd = data;
 
@@ -8432,7 +8705,7 @@ static void le_create_big_cmd_test_cmd(const void *data, uint8_t size)
 						print_bis_test);
 }
 
-static void le_terminate_big_cmd(const void *data, uint8_t size)
+static void le_terminate_big_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_term_big *cmd = data;
 
@@ -8447,7 +8720,8 @@ static void print_bis_sync(const void *data, int i)
 	print_field("BIS ID: 0x%2.2x", *bis_id);
 }
 
-static void le_big_create_sync_cmd(const void *data, uint8_t size)
+static void le_big_create_sync_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_big_create_sync *cmd = data;
 
@@ -8468,7 +8742,7 @@ static void le_big_create_sync_cmd(const void *data, uint8_t size)
 						print_bis_sync);
 }
 
-static void le_big_term_sync_cmd(const void *data, uint8_t size)
+static void le_big_term_sync_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_big_term_sync *cmd = data;
 
@@ -8489,7 +8763,8 @@ static void print_iso_path(const char *prefix, uint8_t path)
 	}
 }
 
-static void le_setup_iso_path_cmd(const void *data, uint8_t size)
+static void le_setup_iso_path_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_setup_iso_path *cmd = data;
 
@@ -8505,7 +8780,8 @@ static void le_setup_iso_path_cmd(const void *data, uint8_t size)
 						cmd->codec_cfg_len);
 }
 
-static void le_setup_iso_path_rsp(const void *data, uint8_t size)
+static void le_setup_iso_path_rsp(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_rsp_le_setup_iso_path *rsp = data;
 
@@ -8517,7 +8793,8 @@ static void le_setup_iso_path_rsp(const void *data, uint8_t size)
 	print_field("Handle: %d", le16_to_cpu(rsp->handle));
 }
 
-static void le_remove_iso_path_cmd(const void *data, uint8_t size)
+static void le_remove_iso_path_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_remove_iso_path *cmd = data;
 
@@ -8525,14 +8802,15 @@ static void le_remove_iso_path_cmd(const void *data, uint8_t size)
 	print_path_direction("Data Path Direction", cmd->direction);
 }
 
-static void le_req_peer_sca_cmd(const void *data, uint8_t size)
+static void le_req_peer_sca_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_req_peer_sca *cmd = data;
 
 	print_field("Connection Handle: %d", le16_to_cpu(cmd->handle));
 }
 
-static void le_set_host_feature_cmd(const void *data, uint8_t size)
+static void le_set_host_feature_cmd(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_host_feature *cmd = data;
 	uint64_t mask;
@@ -8552,10 +8830,10 @@ struct opcode_data {
 	uint16_t opcode;
 	int bit;
 	const char *str;
-	void (*cmd_func) (const void *data, uint8_t size);
+	void (*cmd_func) (uint16_t index, const void *data, uint8_t size);
 	uint8_t cmd_size;
 	bool cmd_fixed;
-	void (*rsp_func) (const void *data, uint8_t size);
+	void (*rsp_func) (uint16_t index, const void *data, uint8_t size);
 	uint8_t rsp_size;
 	bool rsp_fixed;
 };
@@ -9593,14 +9871,14 @@ static const struct vendor_evt *current_vendor_evt(const void *data,
 	return NULL;
 }
 
-static void inquiry_complete_evt(const void *data, uint8_t size)
+static void inquiry_complete_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_inquiry_complete *evt = data;
 
 	print_status(evt->status);
 }
 
-static void inquiry_result_evt(const void *data, uint8_t size)
+static void inquiry_result_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_inquiry_result *evt = data;
 
@@ -9616,7 +9894,7 @@ static void inquiry_result_evt(const void *data, uint8_t size)
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
-static void conn_complete_evt(const void *data, uint8_t size)
+static void conn_complete_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_conn_complete *evt = data;
 
@@ -9627,10 +9905,11 @@ static void conn_complete_evt(const void *data, uint8_t size)
 	print_enable("Encryption", evt->encr_mode);
 
 	if (evt->status == 0x00)
-		assign_handle(le16_to_cpu(evt->handle), 0x00);
+		assign_handle(index, le16_to_cpu(evt->handle), 0x00,
+					(void *)evt->bdaddr, BDADDR_BREDR);
 }
 
-static void conn_request_evt(const void *data, uint8_t size)
+static void conn_request_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_conn_request *evt = data;
 
@@ -9639,7 +9918,8 @@ static void conn_request_evt(const void *data, uint8_t size)
 	print_link_type(evt->link_type);
 }
 
-static void disconnect_complete_evt(const void *data, uint8_t size)
+static void disconnect_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_disconnect_complete *evt = data;
 
@@ -9651,7 +9931,7 @@ static void disconnect_complete_evt(const void *data, uint8_t size)
 		release_handle(le16_to_cpu(evt->handle));
 }
 
-static void auth_complete_evt(const void *data, uint8_t size)
+static void auth_complete_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_auth_complete *evt = data;
 
@@ -9659,7 +9939,8 @@ static void auth_complete_evt(const void *data, uint8_t size)
 	print_handle(evt->handle);
 }
 
-static void remote_name_request_complete_evt(const void *data, uint8_t size)
+static void remote_name_request_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_remote_name_request_complete *evt = data;
 
@@ -9668,7 +9949,7 @@ static void remote_name_request_complete_evt(const void *data, uint8_t size)
 	print_name(evt->name);
 }
 
-static void encrypt_change_evt(const void *data, uint8_t size)
+static void encrypt_change_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_encrypt_change *evt = data;
 
@@ -9677,7 +9958,8 @@ static void encrypt_change_evt(const void *data, uint8_t size)
 	print_encr_mode_change(evt->encr_mode, evt->handle);
 }
 
-static void change_conn_link_key_complete_evt(const void *data, uint8_t size)
+static void change_conn_link_key_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_change_conn_link_key_complete *evt = data;
 
@@ -9685,7 +9967,8 @@ static void change_conn_link_key_complete_evt(const void *data, uint8_t size)
 	print_handle(evt->handle);
 }
 
-static void link_key_type_changed_evt(const void *data, uint8_t size)
+static void link_key_type_changed_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_link_key_type_changed *evt = data;
 
@@ -9694,7 +9977,8 @@ static void link_key_type_changed_evt(const void *data, uint8_t size)
 	print_key_flag(evt->key_flag);
 }
 
-static void remote_features_complete_evt(const void *data, uint8_t size)
+static void remote_features_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_remote_features_complete *evt = data;
 
@@ -9703,7 +9987,8 @@ static void remote_features_complete_evt(const void *data, uint8_t size)
 	print_features(0, evt->features, 0x00);
 }
 
-static void remote_version_complete_evt(const void *data, uint8_t size)
+static void remote_version_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_remote_version_complete *evt = data;
 
@@ -9719,7 +10004,8 @@ static void remote_version_complete_evt(const void *data, uint8_t size)
 	}
 }
 
-static void qos_setup_complete_evt(const void *data, uint8_t size)
+static void qos_setup_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_qos_setup_complete *evt = data;
 
@@ -9735,7 +10021,7 @@ static void qos_setup_complete_evt(const void *data, uint8_t size)
 	print_field("Delay variation: %d", le32_to_cpu(evt->delay_variation));
 }
 
-static void cmd_complete_evt(const void *data, uint8_t size)
+static void cmd_complete_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_cmd_complete *evt = data;
 	uint16_t opcode = le16_to_cpu(evt->opcode);
@@ -9828,10 +10114,10 @@ static void cmd_complete_evt(const void *data, uint8_t size)
 		}
 	}
 
-	opcode_data->rsp_func(data + 3, size - 3);
+	opcode_data->rsp_func(index, data + 3, size - 3);
 }
 
-static void cmd_status_evt(const void *data, uint8_t size)
+static void cmd_status_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_cmd_status *evt = data;
 	uint16_t opcode = le16_to_cpu(evt->opcode);
@@ -9883,21 +10169,21 @@ static void cmd_status_evt(const void *data, uint8_t size)
 	print_status(evt->status);
 }
 
-static void hardware_error_evt(const void *data, uint8_t size)
+static void hardware_error_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_hardware_error *evt = data;
 
 	print_field("Code: 0x%2.2x", evt->code);
 }
 
-static void flush_occurred_evt(const void *data, uint8_t size)
+static void flush_occurred_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_flush_occurred *evt = data;
 
 	print_handle(evt->handle);
 }
 
-static void role_change_evt(const void *data, uint8_t size)
+static void role_change_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_role_change *evt = data;
 
@@ -9906,7 +10192,8 @@ static void role_change_evt(const void *data, uint8_t size)
 	print_role(evt->role);
 }
 
-static void num_completed_packets_evt(const void *data, uint8_t size)
+static void num_completed_packets_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_num_completed_packets *evt = data;
 
@@ -9918,7 +10205,7 @@ static void num_completed_packets_evt(const void *data, uint8_t size)
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
-static void mode_change_evt(const void *data, uint8_t size)
+static void mode_change_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_mode_change *evt = data;
 
@@ -9928,7 +10215,7 @@ static void mode_change_evt(const void *data, uint8_t size)
 	print_interval(evt->interval);
 }
 
-static void return_link_keys_evt(const void *data, uint8_t size)
+static void return_link_keys_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_return_link_keys *evt = data;
 	uint8_t i;
@@ -9941,21 +10228,21 @@ static void return_link_keys_evt(const void *data, uint8_t size)
 	}
 }
 
-static void pin_code_request_evt(const void *data, uint8_t size)
+static void pin_code_request_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_pin_code_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void link_key_request_evt(const void *data, uint8_t size)
+static void link_key_request_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_link_key_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void link_key_notify_evt(const void *data, uint8_t size)
+static void link_key_notify_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_link_key_notify *evt = data;
 
@@ -9964,19 +10251,20 @@ static void link_key_notify_evt(const void *data, uint8_t size)
 	print_key_type(evt->key_type);
 }
 
-static void loopback_command_evt(const void *data, uint8_t size)
+static void loopback_command_evt(uint16_t index, const void *data, uint8_t size)
 {
 	packet_hexdump(data, size);
 }
 
-static void data_buffer_overflow_evt(const void *data, uint8_t size)
+static void data_buffer_overflow_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_data_buffer_overflow *evt = data;
 
 	print_link_type(evt->link_type);
 }
 
-static void max_slots_change_evt(const void *data, uint8_t size)
+static void max_slots_change_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_max_slots_change *evt = data;
 
@@ -9984,7 +10272,8 @@ static void max_slots_change_evt(const void *data, uint8_t size)
 	print_field("Max slots: %d", evt->max_slots);
 }
 
-static void clock_offset_complete_evt(const void *data, uint8_t size)
+static void clock_offset_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_clock_offset_complete *evt = data;
 
@@ -9993,7 +10282,8 @@ static void clock_offset_complete_evt(const void *data, uint8_t size)
 	print_clock_offset(evt->clock_offset);
 }
 
-static void conn_pkt_type_changed_evt(const void *data, uint8_t size)
+static void conn_pkt_type_changed_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_conn_pkt_type_changed *evt = data;
 
@@ -10002,14 +10292,15 @@ static void conn_pkt_type_changed_evt(const void *data, uint8_t size)
 	print_pkt_type(evt->pkt_type);
 }
 
-static void qos_violation_evt(const void *data, uint8_t size)
+static void qos_violation_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_qos_violation *evt = data;
 
 	print_handle(evt->handle);
 }
 
-static void pscan_mode_change_evt(const void *data, uint8_t size)
+static void pscan_mode_change_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_pscan_mode_change *evt = data;
 
@@ -10017,7 +10308,8 @@ static void pscan_mode_change_evt(const void *data, uint8_t size)
 	print_pscan_mode(evt->pscan_mode);
 }
 
-static void pscan_rep_mode_change_evt(const void *data, uint8_t size)
+static void pscan_rep_mode_change_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_pscan_rep_mode_change *evt = data;
 
@@ -10025,7 +10317,8 @@ static void pscan_rep_mode_change_evt(const void *data, uint8_t size)
 	print_pscan_rep_mode(evt->pscan_rep_mode);
 }
 
-static void flow_spec_complete_evt(const void *data, uint8_t size)
+static void flow_spec_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_flow_spec_complete *evt = data;
 
@@ -10043,7 +10336,8 @@ static void flow_spec_complete_evt(const void *data, uint8_t size)
 	print_field("Access latency: %d", le32_to_cpu(evt->access_latency));
 }
 
-static void inquiry_result_with_rssi_evt(const void *data, uint8_t size)
+static void inquiry_result_with_rssi_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_inquiry_result_with_rssi *evt = data;
 
@@ -10059,7 +10353,8 @@ static void inquiry_result_with_rssi_evt(const void *data, uint8_t size)
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
-static void remote_ext_features_complete_evt(const void *data, uint8_t size)
+static void remote_ext_features_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_remote_ext_features_complete *evt = data;
 
@@ -10069,7 +10364,8 @@ static void remote_ext_features_complete_evt(const void *data, uint8_t size)
 	print_features(evt->page, evt->features, 0x00);
 }
 
-static void sync_conn_complete_evt(const void *data, uint8_t size)
+static void sync_conn_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_sync_conn_complete *evt = data;
 
@@ -10084,7 +10380,8 @@ static void sync_conn_complete_evt(const void *data, uint8_t size)
 	print_air_mode(evt->air_mode);
 }
 
-static void sync_conn_changed_evt(const void *data, uint8_t size)
+static void sync_conn_changed_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_sync_conn_changed *evt = data;
 
@@ -10096,7 +10393,7 @@ static void sync_conn_changed_evt(const void *data, uint8_t size)
 	print_field("TX packet length: %d", le16_to_cpu(evt->tx_pkt_len));
 }
 
-static void sniff_subrating_evt(const void *data, uint8_t size)
+static void sniff_subrating_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_sniff_subrating *evt = data;
 
@@ -10108,7 +10405,8 @@ static void sniff_subrating_evt(const void *data, uint8_t size)
 	print_slot_625("Min local timeout", evt->min_local_timeout);
 }
 
-static void ext_inquiry_result_evt(const void *data, uint8_t size)
+static void ext_inquiry_result_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_ext_inquiry_result *evt = data;
 
@@ -10122,7 +10420,8 @@ static void ext_inquiry_result_evt(const void *data, uint8_t size)
 	print_eir(evt->data, sizeof(evt->data), false);
 }
 
-static void encrypt_key_refresh_complete_evt(const void *data, uint8_t size)
+static void encrypt_key_refresh_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_encrypt_key_refresh_complete *evt = data;
 
@@ -10130,14 +10429,16 @@ static void encrypt_key_refresh_complete_evt(const void *data, uint8_t size)
 	print_handle(evt->handle);
 }
 
-static void io_capability_request_evt(const void *data, uint8_t size)
+static void io_capability_request_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_io_capability_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void io_capability_response_evt(const void *data, uint8_t size)
+static void io_capability_response_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_io_capability_response *evt = data;
 
@@ -10147,7 +10448,8 @@ static void io_capability_response_evt(const void *data, uint8_t size)
 	print_authentication(evt->authentication);
 }
 
-static void user_confirm_request_evt(const void *data, uint8_t size)
+static void user_confirm_request_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_user_confirm_request *evt = data;
 
@@ -10155,21 +10457,24 @@ static void user_confirm_request_evt(const void *data, uint8_t size)
 	print_passkey(evt->passkey);
 }
 
-static void user_passkey_request_evt(const void *data, uint8_t size)
+static void user_passkey_request_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_user_passkey_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void remote_oob_data_request_evt(const void *data, uint8_t size)
+static void remote_oob_data_request_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_remote_oob_data_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void simple_pairing_complete_evt(const void *data, uint8_t size)
+static void simple_pairing_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_simple_pairing_complete *evt = data;
 
@@ -10177,7 +10482,8 @@ static void simple_pairing_complete_evt(const void *data, uint8_t size)
 	print_bdaddr(evt->bdaddr);
 }
 
-static void link_supv_timeout_changed_evt(const void *data, uint8_t size)
+static void link_supv_timeout_changed_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_link_supv_timeout_changed *evt = data;
 
@@ -10185,14 +10491,16 @@ static void link_supv_timeout_changed_evt(const void *data, uint8_t size)
 	print_timeout(evt->timeout);
 }
 
-static void enhanced_flush_complete_evt(const void *data, uint8_t size)
+static void enhanced_flush_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_enhanced_flush_complete *evt = data;
 
 	print_handle(evt->handle);
 }
 
-static void user_passkey_notify_evt(const void *data, uint8_t size)
+static void user_passkey_notify_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_user_passkey_notify *evt = data;
 
@@ -10200,7 +10508,7 @@ static void user_passkey_notify_evt(const void *data, uint8_t size)
 	print_passkey(evt->passkey);
 }
 
-static void keypress_notify_evt(const void *data, uint8_t size)
+static void keypress_notify_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_keypress_notify *evt = data;
 	const char *str;
@@ -10231,7 +10539,8 @@ static void keypress_notify_evt(const void *data, uint8_t size)
 	print_field("Notification type: %s (0x%2.2x)", str, evt->type);
 }
 
-static void remote_host_features_notify_evt(const void *data, uint8_t size)
+static void remote_host_features_notify_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_remote_host_features_notify *evt = data;
 
@@ -10239,7 +10548,8 @@ static void remote_host_features_notify_evt(const void *data, uint8_t size)
 	print_features(1, evt->features, 0x00);
 }
 
-static void phy_link_complete_evt(const void *data, uint8_t size)
+static void phy_link_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_phy_link_complete *evt = data;
 
@@ -10247,14 +10557,15 @@ static void phy_link_complete_evt(const void *data, uint8_t size)
 	print_phy_handle(evt->phy_handle);
 }
 
-static void channel_selected_evt(const void *data, uint8_t size)
+static void channel_selected_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_channel_selected *evt = data;
 
 	print_phy_handle(evt->phy_handle);
 }
 
-static void disconn_phy_link_complete_evt(const void *data, uint8_t size)
+static void disconn_phy_link_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_disconn_phy_link_complete *evt = data;
 
@@ -10263,7 +10574,8 @@ static void disconn_phy_link_complete_evt(const void *data, uint8_t size)
 	print_reason(evt->reason);
 }
 
-static void phy_link_loss_early_warning_evt(const void *data, uint8_t size)
+static void phy_link_loss_early_warning_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_phy_link_loss_early_warning *evt = data;
 	const char *str;
@@ -10294,14 +10606,16 @@ static void phy_link_loss_early_warning_evt(const void *data, uint8_t size)
 	print_field("Reason: %s (0x%2.2x)", str, evt->reason);
 }
 
-static void phy_link_recovery_evt(const void *data, uint8_t size)
+static void phy_link_recovery_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_phy_link_recovery *evt = data;
 
 	print_phy_handle(evt->phy_handle);
 }
 
-static void logic_link_complete_evt(const void *data, uint8_t size)
+static void logic_link_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_logic_link_complete *evt = data;
 
@@ -10311,7 +10625,8 @@ static void logic_link_complete_evt(const void *data, uint8_t size)
 	print_field("TX flow spec: 0x%2.2x", evt->flow_spec);
 }
 
-static void disconn_logic_link_complete_evt(const void *data, uint8_t size)
+static void disconn_logic_link_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_disconn_logic_link_complete *evt = data;
 
@@ -10320,7 +10635,8 @@ static void disconn_logic_link_complete_evt(const void *data, uint8_t size)
 	print_reason(evt->reason);
 }
 
-static void flow_spec_modify_complete_evt(const void *data, uint8_t size)
+static void flow_spec_modify_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_flow_spec_modify_complete *evt = data;
 
@@ -10328,7 +10644,8 @@ static void flow_spec_modify_complete_evt(const void *data, uint8_t size)
 	print_handle(evt->handle);
 }
 
-static void num_completed_data_blocks_evt(const void *data, uint8_t size)
+static void num_completed_data_blocks_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_num_completed_data_blocks *evt = data;
 
@@ -10343,7 +10660,8 @@ static void num_completed_data_blocks_evt(const void *data, uint8_t size)
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
-static void short_range_mode_change_evt(const void *data, uint8_t size)
+static void short_range_mode_change_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_short_range_mode_change *evt = data;
 
@@ -10352,7 +10670,8 @@ static void short_range_mode_change_evt(const void *data, uint8_t size)
 	print_enable("Short range mode", evt->mode);
 }
 
-static void amp_status_change_evt(const void *data, uint8_t size)
+static void amp_status_change_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_amp_status_change *evt = data;
 
@@ -10360,7 +10679,8 @@ static void amp_status_change_evt(const void *data, uint8_t size)
 	print_amp_status(evt->amp_status);
 }
 
-static void triggered_clock_capture_evt(const void *data, uint8_t size)
+static void triggered_clock_capture_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_triggered_clock_capture *evt = data;
 
@@ -10370,14 +10690,16 @@ static void triggered_clock_capture_evt(const void *data, uint8_t size)
 	print_clock_offset(evt->clock_offset);
 }
 
-static void sync_train_complete_evt(const void *data, uint8_t size)
+static void sync_train_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_sync_train_complete *evt = data;
 
 	print_status(evt->status);
 }
 
-static void sync_train_received_evt(const void *data, uint8_t size)
+static void sync_train_received_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_sync_train_received *evt = data;
 
@@ -10392,7 +10714,8 @@ static void sync_train_received_evt(const void *data, uint8_t size)
 	print_field("Service Data: 0x%2.2x", evt->service_data);
 }
 
-static void peripheral_broadcast_receive_evt(const void *data, uint8_t size)
+static void peripheral_broadcast_receive_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_peripheral_broadcast_receive *evt = data;
 
@@ -10414,7 +10737,8 @@ static void peripheral_broadcast_receive_evt(const void *data, uint8_t size)
 		packet_hexdump(data + 18, size - 18);
 }
 
-static void peripheral_broadcast_timeout_evt(const void *data, uint8_t size)
+static void peripheral_broadcast_timeout_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_peripheral_broadcast_timeout *evt = data;
 
@@ -10422,7 +10746,8 @@ static void peripheral_broadcast_timeout_evt(const void *data, uint8_t size)
 	print_lt_addr(evt->lt_addr);
 }
 
-static void truncated_page_complete_evt(const void *data, uint8_t size)
+static void truncated_page_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_truncated_page_complete *evt = data;
 
@@ -10430,18 +10755,21 @@ static void truncated_page_complete_evt(const void *data, uint8_t size)
 	print_bdaddr(evt->bdaddr);
 }
 
-static void peripheral_page_response_timeout_evt(const void *data, uint8_t size)
+static void peripheral_page_response_timeout_evt(uint16_t index,
+						const void *data, uint8_t size)
 {
 }
 
-static void channel_map_change_evt(const void *data, uint8_t size)
+static void channel_map_change_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_channel_map_change *evt = data;
 
 	print_channel_map(evt->map);
 }
 
-static void inquiry_response_notify_evt(const void *data, uint8_t size)
+static void inquiry_response_notify_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_inquiry_response_notify *evt = data;
 
@@ -10449,14 +10777,15 @@ static void inquiry_response_notify_evt(const void *data, uint8_t size)
 	print_rssi(evt->rssi);
 }
 
-static void auth_payload_timeout_expired_evt(const void *data, uint8_t size)
+static void auth_payload_timeout_expired_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_auth_payload_timeout_expired *evt = data;
 
 	print_handle(evt->handle);
 }
 
-static void le_conn_complete_evt(const void *data, uint8_t size)
+static void le_conn_complete_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_conn_complete *evt = data;
 
@@ -10473,10 +10802,11 @@ static void le_conn_complete_evt(const void *data, uint8_t size)
 	print_field("Central clock accuracy: 0x%2.2x", evt->clock_accuracy);
 
 	if (evt->status == 0x00)
-		assign_handle(le16_to_cpu(evt->handle), 0x01);
+		assign_handle(index, le16_to_cpu(evt->handle), 0x01,
+				(void *)evt->peer_addr, evt->peer_addr_type);
 }
 
-static void le_adv_report_evt(const void *data, uint8_t size)
+static void le_adv_report_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_adv_report *evt = data;
 	uint8_t evt_len;
@@ -10504,7 +10834,8 @@ report:
 	}
 }
 
-static void le_conn_update_complete_evt(const void *data, uint8_t size)
+static void le_conn_update_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_conn_update_complete *evt = data;
 
@@ -10517,7 +10848,8 @@ static void le_conn_update_complete_evt(const void *data, uint8_t size)
 					le16_to_cpu(evt->supv_timeout));
 }
 
-static void le_remote_features_complete_evt(const void *data, uint8_t size)
+static void le_remote_features_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_remote_features_complete *evt = data;
 
@@ -10526,7 +10858,8 @@ static void le_remote_features_complete_evt(const void *data, uint8_t size)
 	print_features(0, evt->features, 0x01);
 }
 
-static void le_long_term_key_request_evt(const void *data, uint8_t size)
+static void le_long_term_key_request_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_long_term_key_request *evt = data;
 
@@ -10535,7 +10868,8 @@ static void le_long_term_key_request_evt(const void *data, uint8_t size)
 	print_encrypted_diversifier(evt->ediv);
 }
 
-static void le_conn_param_request_evt(const void *data, uint8_t size)
+static void le_conn_param_request_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_conn_param_request *evt = data;
 
@@ -10548,7 +10882,8 @@ static void le_conn_param_request_evt(const void *data, uint8_t size)
 					le16_to_cpu(evt->supv_timeout));
 }
 
-static void le_data_length_change_evt(const void *data, uint8_t size)
+static void le_data_length_change_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_data_length_change *evt = data;
 
@@ -10559,7 +10894,8 @@ static void le_data_length_change_evt(const void *data, uint8_t size)
 	print_field("Max RX time: %d", le16_to_cpu(evt->max_rx_time));
 }
 
-static void le_read_local_pk256_complete_evt(const void *data, uint8_t size)
+static void le_read_local_pk256_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_read_local_pk256_complete *evt = data;
 
@@ -10567,7 +10903,8 @@ static void le_read_local_pk256_complete_evt(const void *data, uint8_t size)
 	print_pk256("Local P-256 public key", evt->local_pk256);
 }
 
-static void le_generate_dhkey_complete_evt(const void *data, uint8_t size)
+static void le_generate_dhkey_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_generate_dhkey_complete *evt = data;
 
@@ -10575,7 +10912,8 @@ static void le_generate_dhkey_complete_evt(const void *data, uint8_t size)
 	print_dhkey(evt->dhkey);
 }
 
-static void le_enhanced_conn_complete_evt(const void *data, uint8_t size)
+static void le_enhanced_conn_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_enhanced_conn_complete *evt = data;
 
@@ -10594,10 +10932,12 @@ static void le_enhanced_conn_complete_evt(const void *data, uint8_t size)
 	print_field("Central clock accuracy: 0x%2.2x", evt->clock_accuracy);
 
 	if (evt->status == 0x00)
-		assign_handle(le16_to_cpu(evt->handle), 0x01);
+		assign_handle(index, le16_to_cpu(evt->handle), 0x01,
+				(void *)evt->peer_addr, evt->peer_addr_type);
 }
 
-static void le_direct_adv_report_evt(const void *data, uint8_t size)
+static void le_direct_adv_report_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_direct_adv_report *evt = data;
 
@@ -10614,7 +10954,8 @@ static void le_direct_adv_report_evt(const void *data, uint8_t size)
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
-static void le_phy_update_complete_evt(const void *data, uint8_t size)
+static void le_phy_update_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_phy_update_complete *evt = data;
 
@@ -10717,7 +11058,8 @@ static void print_legacy_adv_report_pdu(uint16_t flags)
 	print_field("  Legacy PDU Type: %s (0x%4.4x)", str, flags);
 }
 
-static void le_ext_adv_report_evt(const void *data, uint8_t size)
+static void le_ext_adv_report_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_ext_adv_report *evt = data;
 	const struct bt_hci_le_ext_adv_report *report;
@@ -10804,7 +11146,7 @@ static void le_ext_adv_report_evt(const void *data, uint8_t size)
 	}
 }
 
-static void le_pa_sync(const void *data, uint8_t size)
+static void le_pa_sync(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_per_sync_established *evt = data;
 
@@ -10822,7 +11164,7 @@ static void le_pa_sync(const void *data, uint8_t size)
 	print_field("Advertiser clock accuracy: 0x%2.2x", evt->clock_accuracy);
 }
 
-static void le_pa_report_evt(const void *data, uint8_t size)
+static void le_pa_report_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_le_pa_report *evt = data;
 	const char *color_on;
@@ -10883,14 +11225,14 @@ static void le_pa_report_evt(const void *data, uint8_t size)
 	packet_hexdump(evt->data, evt->data_len);
 }
 
-static void le_pa_sync_lost(const void *data, uint8_t size)
+static void le_pa_sync_lost(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_per_sync_lost *evt = data;
 
 	print_field("Sync handle: %d", evt->handle);
 }
 
-static void le_adv_set_term_evt(const void *data, uint8_t size)
+static void le_adv_set_term_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_adv_set_term *evt = data;
 
@@ -10901,7 +11243,8 @@ static void le_adv_set_term_evt(const void *data, uint8_t size)
 			evt->num_evts);
 }
 
-static void le_scan_req_received_evt(const void *data, uint8_t size)
+static void le_scan_req_received_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_scan_req_received *evt = data;
 
@@ -10911,7 +11254,8 @@ static void le_scan_req_received_evt(const void *data, uint8_t size)
 							evt->scanner_addr_type);
 }
 
-static void le_chan_select_alg_evt(const void *data, uint8_t size)
+static void le_chan_select_alg_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_chan_select_alg *evt = data;
 	const char *str;
@@ -10933,7 +11277,8 @@ static void le_chan_select_alg_evt(const void *data, uint8_t size)
 	print_field("Algorithm: %s (0x%2.2x)", str, evt->algorithm);
 }
 
-static void le_cte_request_failed_evt(const void *data, uint8_t size)
+static void le_cte_request_failed_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_cte_request_failed *evt = data;
 
@@ -10941,7 +11286,8 @@ static void le_cte_request_failed_evt(const void *data, uint8_t size)
 	print_field("Connection handle: %d", evt->handle);
 }
 
-static void le_pa_sync_trans_rec_evt(const void *data, uint8_t size)
+static void le_pa_sync_trans_rec_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_pa_sync_trans_rec *evt = data;
 
@@ -10959,7 +11305,8 @@ static void le_pa_sync_trans_rec_evt(const void *data, uint8_t size)
 	print_clock_accuracy(evt->clock_accuracy);
 }
 
-static void le_cis_established_evt(const void *data, uint8_t size)
+static void le_cis_established_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_cis_established *evt = data;
 
@@ -10981,7 +11328,7 @@ static void le_cis_established_evt(const void *data, uint8_t size)
 	print_field("ISO Interval: %u", le16_to_cpu(evt->interval));
 }
 
-static void le_req_cis_evt(const void *data, uint8_t size)
+static void le_req_cis_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_cis_req *evt = data;
 
@@ -10998,7 +11345,7 @@ static void print_bis_handle(const void *data, int i)
 	print_field("Connection Handle #%d: %d", i, handle);
 }
 
-static void le_big_complete_evt(const void *data, uint8_t size)
+static void le_big_complete_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_big_complete *evt = data;
 
@@ -11017,7 +11364,7 @@ static void le_big_complete_evt(const void *data, uint8_t size)
 				sizeof(*evt->bis_handle), print_bis_handle);
 }
 
-static void le_big_terminate_evt(const void *data, uint8_t size)
+static void le_big_terminate_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_big_terminate *evt = data;
 
@@ -11025,7 +11372,8 @@ static void le_big_terminate_evt(const void *data, uint8_t size)
 	print_reason(evt->reason);
 }
 
-static void le_big_sync_estabilished_evt(const void *data, uint8_t size)
+static void le_big_sync_estabilished_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_big_sync_estabilished *evt = data;
 
@@ -11042,7 +11390,7 @@ static void le_big_sync_estabilished_evt(const void *data, uint8_t size)
 						print_bis_handle);
 }
 
-static void le_big_sync_lost_evt(const void *data, uint8_t size)
+static void le_big_sync_lost_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_big_sync_lost *evt = data;
 
@@ -11050,7 +11398,8 @@ static void le_big_sync_lost_evt(const void *data, uint8_t size)
 	print_reason(evt->reason);
 }
 
-static void le_req_sca_complete_evt(const void *data, uint8_t size)
+static void le_req_sca_complete_evt(uint16_t index, const void *data,
+							uint8_t size)
 {
 	const struct bt_hci_evt_le_req_peer_sca_complete *evt = data;
 
@@ -11059,7 +11408,7 @@ static void le_req_sca_complete_evt(const void *data, uint8_t size)
 	print_sca(evt->sca);
 }
 
-static void le_big_info_evt(const void *data, uint8_t size)
+static void le_big_info_evt(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_big_info_adv_report *evt = data;
 
@@ -11081,13 +11430,14 @@ static void le_big_info_evt(const void *data, uint8_t size)
 struct subevent_data {
 	uint8_t subevent;
 	const char *str;
-	void (*func) (const void *data, uint8_t size);
+	void (*func) (uint16_t index, const void *data, uint8_t size);
 	uint8_t size;
 	bool fixed;
 };
 
-static void print_subevent(const struct subevent_data *subevent_data,
-					const void *data, uint8_t size)
+static void print_subevent(uint16_t index,
+				const struct subevent_data *subevent_data,
+				const void *data, uint8_t size)
 {
 	const char *subevent_color;
 
@@ -11118,7 +11468,7 @@ static void print_subevent(const struct subevent_data *subevent_data,
 		}
 	}
 
-	subevent_data->func(data, size);
+	subevent_data->func(index, data, size);
 }
 
 static const struct subevent_data le_meta_event_table[] = {
@@ -11203,7 +11553,7 @@ static const struct subevent_data le_meta_event_table[] = {
 	{ }
 };
 
-static void le_meta_event_evt(const void *data, uint8_t size)
+static void le_meta_event_evt(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t subevent = *((const uint8_t *) data);
 	struct subevent_data unknown;
@@ -11223,10 +11573,10 @@ static void le_meta_event_evt(const void *data, uint8_t size)
 		}
 	}
 
-	print_subevent(subevent_data, data + 1, size - 1);
+	print_subevent(index, subevent_data, data + 1, size - 1);
 }
 
-static void vendor_evt(const void *data, uint8_t size)
+static void vendor_evt(uint16_t index, const void *data, uint8_t size)
 {
 	struct subevent_data vendor_data;
 	char vendor_str[150];
@@ -11247,7 +11597,7 @@ static void vendor_evt(const void *data, uint8_t size)
 		vendor_data.size = vnd->evt_size;
 		vendor_data.fixed = vnd->evt_fixed;
 
-		print_subevent(&vendor_data, data + consumed_size,
+		print_subevent(index, &vendor_data, data + consumed_size,
 							size - consumed_size);
 	} else {
 		uint16_t manufacturer;
@@ -11264,7 +11614,7 @@ static void vendor_evt(const void *data, uint8_t size)
 struct event_data {
 	uint8_t event;
 	const char *str;
-	void (*func) (const void *data, uint8_t size);
+	void (*func) (uint16_t index, const void *data, uint8_t size);
 	uint8_t size;
 	bool fixed;
 };
@@ -11696,7 +12046,7 @@ void packet_hci_command(struct timeval *tv, struct ucred *cred, uint16_t index,
 		}
 	}
 
-	opcode_data->cmd_func(data, hdr->plen);
+	opcode_data->cmd_func(index, data, hdr->plen);
 }
 
 void packet_hci_event(struct timeval *tv, struct ucred *cred, uint16_t index,
@@ -11776,7 +12126,7 @@ void packet_hci_event(struct timeval *tv, struct ucred *cred, uint16_t index,
 		}
 	}
 
-	event_data->func(data, hdr->plen);
+	event_data->func(index, data, hdr->plen);
 }
 
 void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
diff --git a/monitor/packet.h b/monitor/packet.h
index 8a11bc714..a00975eb3 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -23,6 +23,18 @@
 #define PACKET_FILTER_SHOW_A2DP_STREAM	(1 << 6)
 #define PACKET_FILTER_SHOW_MGMT_SOCKET	(1 << 7)
 
+struct packet_conn_data {
+	uint16_t index;
+	uint16_t handle;
+	uint8_t  type;
+	uint8_t  dst[6];
+	uint8_t  dst_type;
+	void     *data;
+	void     (*destroy)(void *data);
+};
+
+struct packet_conn_data *packet_get_conn_data(uint16_t handle);
+
 bool packet_has_filter(unsigned long filter);
 void packet_set_filter(unsigned long filter);
 void packet_add_filter(unsigned long filter);
diff --git a/monitor/vendor.h b/monitor/vendor.h
index c70552b66..9430f3736 100644
--- a/monitor/vendor.h
+++ b/monitor/vendor.h
@@ -14,10 +14,10 @@
 struct vendor_ocf {
 	uint16_t ocf;
 	const char *str;
-	void (*cmd_func) (const void *data, uint8_t size);
+	void (*cmd_func) (uint16_t index, const void *data, uint8_t size);
 	uint8_t cmd_size;
 	bool cmd_fixed;
-	void (*rsp_func) (const void *data, uint8_t size);
+	void (*rsp_func) (uint16_t index, const void *data, uint8_t size);
 	uint8_t rsp_size;
 	bool rsp_fixed;
 };
@@ -25,7 +25,7 @@ struct vendor_ocf {
 struct vendor_evt {
 	uint8_t evt;
 	const char *str;
-	void (*evt_func) (const void *data, uint8_t size);
+	void (*evt_func) (uint16_t index, const void *data, uint8_t size);
 	uint8_t evt_size;
 	bool evt_fixed;
 };
-- 
2.35.1

