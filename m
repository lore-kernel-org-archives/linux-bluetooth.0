Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2ACC77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 23:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjERXVB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 19:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjERXVA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 19:21:00 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17C9E49
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 16:20:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so563330b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684452054; x=1687044054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiHwPsPb2g0nL1dVJcrpu34OZJFiVowecDtOBPL1WCI=;
        b=c7IclzPEzJNP8Nu2fOmLxze56dzvkkBHjs9O0nCFwle7bqX0CZA91c73clEZJBJJvt
         lgnQSltZ6t5NLjx3cCeptvf2llWrQvCscwZajsAftYMqDBs5eyGXy+QKVB4lgtmGy/Dq
         mGNKL4x9yAgbPGK2ZAzUkgpcl0tAD4wo03HPD0CWCSKS/wUio7c0SFKTVjrjbOdxxbMc
         WllhHC6Yy4Esp3YmxAZ+P/YdlHh11dUeXk3aajzQhrhSAP88FTJBW7EIYHZeenks9puM
         3K43xOmz+q7jkyjw7JdDn8kZCBmNXLVnoWL7Wq9fJegmCy3beyCdI/wKjK6RyHy96xNL
         Hafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684452054; x=1687044054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiHwPsPb2g0nL1dVJcrpu34OZJFiVowecDtOBPL1WCI=;
        b=aiWOScpNQ2fAEhh4HegJozTVbpFroU+n4UqNrFTuB4Fr0UT7dqxiPyKtm5DTCLPFxL
         5n4xFe+GPiju9opAZ51tMb63ETMyTPPTssLK+p7Ii+xFCvqhud/GEutAsGhctakmCT7p
         JRABdq3sRjzkf1kUzkeVxeePnRMpAtgIuX65tvvfZFdN7RCc2j6sckBaGK+NlL6lepMt
         ODbLjMoX4GVfZDUdyhNc/R68Nj2Q6nE2M9cKGfLbffvuf4y6O8LH/RzFsgeOP0ZILttQ
         ursjgQDlJQZoNfG9UqKY8ovsuJyHcTLPamdN/ZuONtdXfAN7bDQ321ECn493vO8XiO4n
         lCGg==
X-Gm-Message-State: AC+VfDx7PvTisKy23xdlIWqy2trmwBchZEr3jOpM2oVnJ2WUgsY1tbb+
        IBWE0hOqKeu+Lzes7YmccE35JAGiMEA=
X-Google-Smtp-Source: ACHHUZ66E5xQ1pFlhH9hTQ/GfyGTCvYtMqutozOdHk2Kcwq1UQsEDu1ZgP9K2ZkQwtWoZN85zkZyBQ==
X-Received: by 2002:a05:6a00:1594:b0:643:53b6:d841 with SMTP id u20-20020a056a00159400b0064353b6d841mr792923pfk.2.1684452053798;
        Thu, 18 May 2023 16:20:53 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id q23-20020a62ae17000000b0062dbafced27sm62129pff.27.2023.05.18.16.20.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 16:20:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] monitor: Add latency when decoding BT_HCI_EVT_NUM_COMPLETED_PACKETS
Date:   Thu, 18 May 2023 16:20:49 -0700
Message-Id: <20230518232049.1656554-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518232049.1656554-1-luiz.dentz@gmail.com>
References: <20230518232049.1656554-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds latency, min-max, and median information when decoding
BT_HCI_EVT_NUM_COMPLETED_PACKETS so it works similarly to --analyze:

> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 256 Address: XX:XX:XX:XX:XX:XX
        Count: 1
        Latency: 23 msec (2-66 msec ~19 msec)
---
 monitor/broadcom.c |   3 +-
 monitor/intel.c    |  51 +++--
 monitor/msft.c     |   3 +-
 monitor/packet.c   | 488 ++++++++++++++++++++++++++++-----------------
 monitor/packet.h   |   4 +
 monitor/vendor.h   |   3 +-
 6 files changed, 344 insertions(+), 208 deletions(-)

diff --git a/monitor/broadcom.c b/monitor/broadcom.c
index 72da56da2124..80c95e91db0a 100644
--- a/monitor/broadcom.c
+++ b/monitor/broadcom.c
@@ -706,7 +706,8 @@ void broadcom_lm_diag(const void *data, uint8_t size)
 	}
 }
 
-static void lm_diag_evt(uint16_t index, const void *data, uint8_t size)
+static void lm_diag_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
 {
 	broadcom_lm_diag(data, 63);
 }
diff --git a/monitor/intel.c b/monitor/intel.c
index c29b547f414b..bdb95b7a79c0 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -793,11 +793,13 @@ const struct vendor_ocf *intel_vendor_ocf(uint16_t ocf)
 	return NULL;
 }
 
-static void startup_evt(uint16_t index, const void *data, uint8_t size)
+static void startup_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
 {
 }
 
-static void fatal_exception_evt(uint16_t index, const void *data, uint8_t size)
+static void fatal_exception_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
 {
 	uint16_t line = get_le16(data);
 	uint8_t module = get_u8(data + 2);
@@ -808,7 +810,8 @@ static void fatal_exception_evt(uint16_t index, const void *data, uint8_t size)
 	print_field("Reason: 0x%2.2x", reason);
 }
 
-static void bootup_evt(uint16_t index, const void *data, uint8_t size)
+static void bootup_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
 {
 	uint8_t zero = get_u8(data);
 	uint8_t num_packets = get_u8(data + 1);
@@ -911,7 +914,8 @@ static void bootup_evt(uint16_t index, const void *data, uint8_t size)
 	print_field("DDC status: %s (0x%2.2x)", str, ddc_status);
 }
 
-static void default_bd_data_evt(uint16_t index, const void *data, uint8_t size)
+static void default_bd_data_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	uint8_t mem_status = get_u8(data);
 	const char *str;
@@ -928,8 +932,8 @@ static void default_bd_data_evt(uint16_t index, const void *data, uint8_t size)
 	print_field("Memory status: %s (0x%2.2x)", str, mem_status);
 }
 
-static void secure_send_commands_result_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void secure_send_commands_result_evt(struct timeval *tv, uint16_t index,
+						const void *data, uint8_t size)
 {
 	uint8_t result = get_u8(data);
 	uint16_t opcode = get_le16(data + 1);
@@ -973,7 +977,8 @@ static void secure_send_commands_result_evt(uint16_t index, const void *data,
 	print_status(status);
 }
 
-static void debug_exception_evt(uint16_t index, const void *data, uint8_t size)
+static void debug_exception_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	uint16_t line = get_le16(data);
 	uint8_t module = get_u8(data + 2);
@@ -984,8 +989,8 @@ static void debug_exception_evt(uint16_t index, const void *data, uint8_t size)
 	print_field("Reason: 0x%2.2x", reason);
 }
 
-static void le_link_established_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_link_established_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	uint16_t handle = get_le16(data);
 	uint32_t access_addr = get_le32(data + 10);
@@ -999,7 +1004,8 @@ static void le_link_established_evt(uint16_t index, const void *data,
 	packet_hexdump(data + 14, size - 14);
 }
 
-static void scan_status_evt(uint16_t index, const void *data, uint8_t size)
+static void scan_status_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	uint8_t enable = get_u8(data);
 
@@ -1014,15 +1020,16 @@ static void scan_status_evt(uint16_t index, const void *data, uint8_t size)
 
 }
 
-static void act_deact_traces_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void act_deact_traces_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	uint8_t status = get_u8(data);
 
 	print_status(status);
 }
 
-static void lmp_pdu_trace_evt(uint16_t index, const void *data, uint8_t size)
+static void lmp_pdu_trace_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	uint8_t type, len, id;
 	uint16_t handle, count;
@@ -1116,16 +1123,16 @@ static void lmp_pdu_trace_evt(uint16_t index, const void *data, uint8_t size)
 	}
 }
 
-static void write_bd_data_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void write_bd_data_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	uint8_t status = get_u8(data);
 
 	print_status(status);
 }
 
-static void sco_rejected_via_lmp_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void sco_rejected_via_lmp_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	uint8_t reason = get_u8(data + 6);
 
@@ -1133,8 +1140,8 @@ static void sco_rejected_via_lmp_evt(uint16_t index, const void *data,
 	packet_print_error("Reason", reason);
 }
 
-static void ptt_switch_notification_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void ptt_switch_notification_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	uint16_t handle = get_le16(data);
 	uint8_t table = get_u8(data + 2);
@@ -1157,7 +1164,8 @@ static void ptt_switch_notification_evt(uint16_t index, const void *data,
 	print_field("Packet type table: %s (0x%2.2x)", str, table);
 }
 
-static void system_exception_evt(uint16_t index, const void *data, uint8_t size)
+static void system_exception_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	uint8_t type = get_u8(data);
 	const char *str;
@@ -1741,7 +1749,8 @@ static const struct intel_tlv *process_ext_subevent(const struct intel_tlv *tlv,
 	return next_tlv;
 }
 
-static void intel_vendor_ext_evt(uint16_t index, const void *data, uint8_t size)
+static void intel_vendor_ext_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	/* The data pointer points to a number of tlv.*/
 	const struct intel_tlv *tlv = data;
diff --git a/monitor/msft.c b/monitor/msft.c
index 38af6722e6d0..096fedd59317 100644
--- a/monitor/msft.c
+++ b/monitor/msft.c
@@ -299,7 +299,8 @@ const struct vendor_ocf *msft_vendor_ocf(void)
 	return &vendor_ocf_entry;
 }
 
-static void msft_evt(uint16_t index, const void *data, uint8_t size)
+static void msft_evt(struct timeval *tv, uint16_t index,
+			const void *data, uint8_t size)
 {
 	packet_hexdump(data, size);
 }
diff --git a/monitor/packet.c b/monitor/packet.c
index 39d1f70310e4..67d1c7acff33 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -34,6 +34,7 @@
 
 #include "src/shared/util.h"
 #include "src/shared/btsnoop.h"
+#include "src/shared/queue.h"
 #include "display.h"
 #include "bt.h"
 #include "ll.h"
@@ -202,11 +203,14 @@ static void release_handle(uint16_t handle)
 	int i;
 
 	for (i = 0; i < MAX_CONN; i++) {
-		if (conn_list[i].handle == handle) {
-			if (conn_list[i].destroy)
-				conn_list[i].destroy(conn_list[i].data);
+		struct packet_conn_data *conn = &conn_list[i];
 
-			memset(&conn_list[i], 0, sizeof(conn_list[i]));
+		if (conn->handle == handle) {
+			if (conn->destroy)
+				conn->destroy(conn->data);
+
+			queue_destroy(conn->tx_q, free);
+			memset(conn, 0, sizeof(*conn));
 			break;
 		}
 	}
@@ -9969,14 +9973,16 @@ static const char *current_vendor_evt_str(void)
 	return NULL;
 }
 
-static void inquiry_complete_evt(uint16_t index, const void *data, uint8_t size)
+static void inquiry_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_inquiry_complete *evt = data;
 
 	print_status(evt->status);
 }
 
-static void inquiry_result_evt(uint16_t index, const void *data, uint8_t size)
+static void inquiry_result_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_inquiry_result *evt = data;
 
@@ -9992,7 +9998,8 @@ static void inquiry_result_evt(uint16_t index, const void *data, uint8_t size)
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
-static void conn_complete_evt(uint16_t index, const void *data, uint8_t size)
+static void conn_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_conn_complete *evt = data;
 
@@ -10007,7 +10014,8 @@ static void conn_complete_evt(uint16_t index, const void *data, uint8_t size)
 					(void *)evt->bdaddr, BDADDR_BREDR);
 }
 
-static void conn_request_evt(uint16_t index, const void *data, uint8_t size)
+static void conn_request_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_conn_request *evt = data;
 
@@ -10016,8 +10024,8 @@ static void conn_request_evt(uint16_t index, const void *data, uint8_t size)
 	print_link_type(evt->link_type);
 }
 
-static void disconnect_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void disconnect_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_disconnect_complete *evt = data;
 
@@ -10029,7 +10037,8 @@ static void disconnect_complete_evt(uint16_t index, const void *data,
 		release_handle(le16_to_cpu(evt->handle));
 }
 
-static void auth_complete_evt(uint16_t index, const void *data, uint8_t size)
+static void auth_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_auth_complete *evt = data;
 
@@ -10037,8 +10046,8 @@ static void auth_complete_evt(uint16_t index, const void *data, uint8_t size)
 	print_handle(evt->handle);
 }
 
-static void remote_name_request_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void remote_name_request_complete_evt(struct timeval *tv, uint16_t index,
+						const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_remote_name_request_complete *evt = data;
 
@@ -10047,7 +10056,8 @@ static void remote_name_request_complete_evt(uint16_t index, const void *data,
 	print_name(evt->name);
 }
 
-static void encrypt_change_evt(uint16_t index, const void *data, uint8_t size)
+static void encrypt_change_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_encrypt_change *evt = data;
 
@@ -10056,8 +10066,9 @@ static void encrypt_change_evt(uint16_t index, const void *data, uint8_t size)
 	print_encr_mode_change(evt->encr_mode, evt->handle);
 }
 
-static void change_conn_link_key_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void change_conn_link_key_complete_evt(struct timeval *tv,
+						uint16_t index,
+						const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_change_conn_link_key_complete *evt = data;
 
@@ -10065,8 +10076,8 @@ static void change_conn_link_key_complete_evt(uint16_t index, const void *data,
 	print_handle(evt->handle);
 }
 
-static void link_key_type_changed_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void link_key_type_changed_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_link_key_type_changed *evt = data;
 
@@ -10075,8 +10086,8 @@ static void link_key_type_changed_evt(uint16_t index, const void *data,
 	print_key_flag(evt->key_flag);
 }
 
-static void remote_features_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void remote_features_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_remote_features_complete *evt = data;
 
@@ -10085,8 +10096,8 @@ static void remote_features_complete_evt(uint16_t index, const void *data,
 	print_features(0, evt->features, 0x00);
 }
 
-static void remote_version_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void remote_version_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_remote_version_complete *evt = data;
 
@@ -10102,8 +10113,8 @@ static void remote_version_complete_evt(uint16_t index, const void *data,
 	}
 }
 
-static void qos_setup_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void qos_setup_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_qos_setup_complete *evt = data;
 
@@ -10119,7 +10130,8 @@ static void qos_setup_complete_evt(uint16_t index, const void *data,
 	print_field("Delay variation: %d", le32_to_cpu(evt->delay_variation));
 }
 
-static void cmd_complete_evt(uint16_t index, const void *data, uint8_t size)
+static void cmd_complete_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_cmd_complete *evt = data;
 	uint16_t opcode = le16_to_cpu(evt->opcode);
@@ -10215,7 +10227,8 @@ static void cmd_complete_evt(uint16_t index, const void *data, uint8_t size)
 	opcode_data->rsp_func(index, data + 3, size - 3);
 }
 
-static void cmd_status_evt(uint16_t index, const void *data, uint8_t size)
+static void cmd_status_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_cmd_status *evt = data;
 	uint16_t opcode = le16_to_cpu(evt->opcode);
@@ -10267,21 +10280,24 @@ static void cmd_status_evt(uint16_t index, const void *data, uint8_t size)
 	print_status(evt->status);
 }
 
-static void hardware_error_evt(uint16_t index, const void *data, uint8_t size)
+static void hardware_error_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_hardware_error *evt = data;
 
 	print_field("Code: 0x%2.2x", evt->code);
 }
 
-static void flush_occurred_evt(uint16_t index, const void *data, uint8_t size)
+static void flush_occurred_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_flush_occurred *evt = data;
 
 	print_handle(evt->handle);
 }
 
-static void role_change_evt(uint16_t index, const void *data, uint8_t size)
+static void role_change_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_role_change *evt = data;
 
@@ -10290,8 +10306,57 @@ static void role_change_evt(uint16_t index, const void *data, uint8_t size)
 	print_role(evt->role);
 }
 
-static void num_completed_packets_evt(uint16_t index, const void *data,
-							uint8_t size)
+#define TV_MSEC(_tv) (long long)(_tv.tv_sec * 1000 + _tv.tv_usec / 1000)
+
+static void packet_dequeue_tx(struct timeval *tv, uint16_t handle)
+{
+	struct packet_conn_data *conn;
+	struct timeval *tx;
+	struct timeval delta;
+
+	conn = packet_get_conn_data(handle);
+	if (!conn)
+		return;
+
+	tx = queue_pop_head(conn->tx_q);
+	if (!tx)
+		return;
+
+	timersub(tv, tx, &delta);
+
+	if ((!timerisset(&conn->tx_min) || timercmp(&delta, &conn->tx_min, <))
+				&& delta.tv_sec >= 0 && delta.tv_usec >= 0)
+		conn->tx_min = delta;
+
+	if (!timerisset(&conn->tx_max) || timercmp(&delta, &conn->tx_max, >))
+		conn->tx_max = delta;
+
+	if (timerisset(&conn->tx_med)) {
+		struct timeval tmp;
+
+		timeradd(&conn->tx_med, &delta, &tmp);
+
+		tmp.tv_sec /= 2;
+		tmp.tv_usec /= 2;
+		if (tmp.tv_sec % 2) {
+			tmp.tv_usec += 500000;
+			if (tmp.tv_usec >= 1000000) {
+				tmp.tv_sec++;
+				tmp.tv_usec -= 1000000;
+			}
+		}
+
+		conn->tx_med = tmp;
+	} else
+		conn->tx_med = delta;
+
+	print_field("Latency: %lld msec (%lld-%lld msec ~%lld msec)",
+			TV_MSEC(delta), TV_MSEC(conn->tx_min),
+			TV_MSEC(conn->tx_max), TV_MSEC(conn->tx_med));
+}
+
+static void num_completed_packets_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	struct iovec iov = { (void *)data, size};
 	const struct bt_hci_evt_num_completed_packets *evt = data;
@@ -10314,13 +10379,16 @@ static void num_completed_packets_evt(uint16_t index, const void *data,
 			break;
 
 		print_field("Count: %d", le16_to_cpu(evt->count));
+
+		packet_dequeue_tx(tv, handle);
 	}
 
 	if (iov.iov_len)
 		packet_hexdump(iov.iov_base, iov.iov_len);
 }
 
-static void mode_change_evt(uint16_t index, const void *data, uint8_t size)
+static void mode_change_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_mode_change *evt = data;
 
@@ -10330,7 +10398,8 @@ static void mode_change_evt(uint16_t index, const void *data, uint8_t size)
 	print_interval(evt->interval);
 }
 
-static void return_link_keys_evt(uint16_t index, const void *data, uint8_t size)
+static void return_link_keys_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_return_link_keys *evt = data;
 	uint8_t i;
@@ -10343,21 +10412,24 @@ static void return_link_keys_evt(uint16_t index, const void *data, uint8_t size)
 	}
 }
 
-static void pin_code_request_evt(uint16_t index, const void *data, uint8_t size)
+static void pin_code_request_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_pin_code_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void link_key_request_evt(uint16_t index, const void *data, uint8_t size)
+static void link_key_request_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_link_key_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void link_key_notify_evt(uint16_t index, const void *data, uint8_t size)
+static void link_key_notify_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_link_key_notify *evt = data;
 
@@ -10366,20 +10438,22 @@ static void link_key_notify_evt(uint16_t index, const void *data, uint8_t size)
 	print_key_type(evt->key_type);
 }
 
-static void loopback_command_evt(uint16_t index, const void *data, uint8_t size)
+static void loopback_command_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	packet_hexdump(data, size);
 }
 
-static void data_buffer_overflow_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void data_buffer_overflow_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_data_buffer_overflow *evt = data;
 
 	print_link_type(evt->link_type);
 }
 
-static void max_slots_change_evt(uint16_t index, const void *data, uint8_t size)
+static void max_slots_change_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_max_slots_change *evt = data;
 
@@ -10387,8 +10461,8 @@ static void max_slots_change_evt(uint16_t index, const void *data, uint8_t size)
 	print_field("Max slots: %d", evt->max_slots);
 }
 
-static void clock_offset_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void clock_offset_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_clock_offset_complete *evt = data;
 
@@ -10397,8 +10471,8 @@ static void clock_offset_complete_evt(uint16_t index, const void *data,
 	print_clock_offset(evt->clock_offset);
 }
 
-static void conn_pkt_type_changed_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void conn_pkt_type_changed_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_conn_pkt_type_changed *evt = data;
 
@@ -10407,15 +10481,16 @@ static void conn_pkt_type_changed_evt(uint16_t index, const void *data,
 	print_pkt_type(evt->pkt_type);
 }
 
-static void qos_violation_evt(uint16_t index, const void *data, uint8_t size)
+static void qos_violation_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_qos_violation *evt = data;
 
 	print_handle(evt->handle);
 }
 
-static void pscan_mode_change_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void pscan_mode_change_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_pscan_mode_change *evt = data;
 
@@ -10423,8 +10498,8 @@ static void pscan_mode_change_evt(uint16_t index, const void *data,
 	print_pscan_mode(evt->pscan_mode);
 }
 
-static void pscan_rep_mode_change_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void pscan_rep_mode_change_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_pscan_rep_mode_change *evt = data;
 
@@ -10432,8 +10507,8 @@ static void pscan_rep_mode_change_evt(uint16_t index, const void *data,
 	print_pscan_rep_mode(evt->pscan_rep_mode);
 }
 
-static void flow_spec_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void flow_spec_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_flow_spec_complete *evt = data;
 
@@ -10451,8 +10526,8 @@ static void flow_spec_complete_evt(uint16_t index, const void *data,
 	print_field("Access latency: %d", le32_to_cpu(evt->access_latency));
 }
 
-static void inquiry_result_with_rssi_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void inquiry_result_with_rssi_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_inquiry_result_with_rssi *evt = data;
 
@@ -10468,8 +10543,8 @@ static void inquiry_result_with_rssi_evt(uint16_t index, const void *data,
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
-static void remote_ext_features_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void remote_ext_features_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_remote_ext_features_complete *evt = data;
 
@@ -10479,8 +10554,8 @@ static void remote_ext_features_complete_evt(uint16_t index, const void *data,
 	print_features(evt->page, evt->features, 0x00);
 }
 
-static void sync_conn_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void sync_conn_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_sync_conn_complete *evt = data;
 
@@ -10495,8 +10570,8 @@ static void sync_conn_complete_evt(uint16_t index, const void *data,
 	print_air_mode(evt->air_mode);
 }
 
-static void sync_conn_changed_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void sync_conn_changed_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_sync_conn_changed *evt = data;
 
@@ -10508,7 +10583,8 @@ static void sync_conn_changed_evt(uint16_t index, const void *data,
 	print_field("TX packet length: %d", le16_to_cpu(evt->tx_pkt_len));
 }
 
-static void sniff_subrating_evt(uint16_t index, const void *data, uint8_t size)
+static void sniff_subrating_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_sniff_subrating *evt = data;
 
@@ -10520,8 +10596,8 @@ static void sniff_subrating_evt(uint16_t index, const void *data, uint8_t size)
 	print_slot_625("Min local timeout", evt->min_local_timeout);
 }
 
-static void ext_inquiry_result_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void ext_inquiry_result_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_ext_inquiry_result *evt = data;
 
@@ -10535,8 +10611,8 @@ static void ext_inquiry_result_evt(uint16_t index, const void *data,
 	print_eir(evt->data, sizeof(evt->data), false);
 }
 
-static void encrypt_key_refresh_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void encrypt_key_refresh_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_encrypt_key_refresh_complete *evt = data;
 
@@ -10544,16 +10620,16 @@ static void encrypt_key_refresh_complete_evt(uint16_t index, const void *data,
 	print_handle(evt->handle);
 }
 
-static void io_capability_request_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void io_capability_request_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_io_capability_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void io_capability_response_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void io_capability_response_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_io_capability_response *evt = data;
 
@@ -10563,8 +10639,8 @@ static void io_capability_response_evt(uint16_t index, const void *data,
 	print_authentication(evt->authentication);
 }
 
-static void user_confirm_request_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void user_confirm_request_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_user_confirm_request *evt = data;
 
@@ -10572,24 +10648,24 @@ static void user_confirm_request_evt(uint16_t index, const void *data,
 	print_passkey(evt->passkey);
 }
 
-static void user_passkey_request_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void user_passkey_request_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_user_passkey_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void remote_oob_data_request_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void remote_oob_data_request_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_remote_oob_data_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void simple_pairing_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void simple_pairing_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_simple_pairing_complete *evt = data;
 
@@ -10597,8 +10673,8 @@ static void simple_pairing_complete_evt(uint16_t index, const void *data,
 	print_bdaddr(evt->bdaddr);
 }
 
-static void link_supv_timeout_changed_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void link_supv_timeout_changed_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_link_supv_timeout_changed *evt = data;
 
@@ -10606,16 +10682,16 @@ static void link_supv_timeout_changed_evt(uint16_t index, const void *data,
 	print_timeout(evt->timeout);
 }
 
-static void enhanced_flush_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void enhanced_flush_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_enhanced_flush_complete *evt = data;
 
 	print_handle(evt->handle);
 }
 
-static void user_passkey_notify_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void user_passkey_notify_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_user_passkey_notify *evt = data;
 
@@ -10623,7 +10699,8 @@ static void user_passkey_notify_evt(uint16_t index, const void *data,
 	print_passkey(evt->passkey);
 }
 
-static void keypress_notify_evt(uint16_t index, const void *data, uint8_t size)
+static void keypress_notify_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_keypress_notify *evt = data;
 	const char *str;
@@ -10654,8 +10731,8 @@ static void keypress_notify_evt(uint16_t index, const void *data, uint8_t size)
 	print_field("Notification type: %s (0x%2.2x)", str, evt->type);
 }
 
-static void remote_host_features_notify_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void remote_host_features_notify_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_remote_host_features_notify *evt = data;
 
@@ -10663,8 +10740,8 @@ static void remote_host_features_notify_evt(uint16_t index, const void *data,
 	print_features(1, evt->features, 0x00);
 }
 
-static void phy_link_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void phy_link_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_phy_link_complete *evt = data;
 
@@ -10672,15 +10749,16 @@ static void phy_link_complete_evt(uint16_t index, const void *data,
 	print_phy_handle(evt->phy_handle);
 }
 
-static void channel_selected_evt(uint16_t index, const void *data, uint8_t size)
+static void channel_selected_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_channel_selected *evt = data;
 
 	print_phy_handle(evt->phy_handle);
 }
 
-static void disconn_phy_link_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void disconn_phy_link_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_disconn_phy_link_complete *evt = data;
 
@@ -10689,8 +10767,8 @@ static void disconn_phy_link_complete_evt(uint16_t index, const void *data,
 	print_reason(evt->reason);
 }
 
-static void phy_link_loss_early_warning_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void phy_link_loss_early_warning_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_phy_link_loss_early_warning *evt = data;
 	const char *str;
@@ -10721,16 +10799,16 @@ static void phy_link_loss_early_warning_evt(uint16_t index, const void *data,
 	print_field("Reason: %s (0x%2.2x)", str, evt->reason);
 }
 
-static void phy_link_recovery_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void phy_link_recovery_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_phy_link_recovery *evt = data;
 
 	print_phy_handle(evt->phy_handle);
 }
 
-static void logic_link_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void logic_link_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_logic_link_complete *evt = data;
 
@@ -10740,8 +10818,8 @@ static void logic_link_complete_evt(uint16_t index, const void *data,
 	print_field("TX flow spec: 0x%2.2x", evt->flow_spec);
 }
 
-static void disconn_logic_link_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void disconn_logic_link_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_disconn_logic_link_complete *evt = data;
 
@@ -10750,8 +10828,8 @@ static void disconn_logic_link_complete_evt(uint16_t index, const void *data,
 	print_reason(evt->reason);
 }
 
-static void flow_spec_modify_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void flow_spec_modify_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_flow_spec_modify_complete *evt = data;
 
@@ -10759,8 +10837,8 @@ static void flow_spec_modify_complete_evt(uint16_t index, const void *data,
 	print_handle(evt->handle);
 }
 
-static void num_completed_data_blocks_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void num_completed_data_blocks_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_num_completed_data_blocks *evt = data;
 
@@ -10775,8 +10853,8 @@ static void num_completed_data_blocks_evt(uint16_t index, const void *data,
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
-static void short_range_mode_change_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void short_range_mode_change_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_short_range_mode_change *evt = data;
 
@@ -10785,8 +10863,8 @@ static void short_range_mode_change_evt(uint16_t index, const void *data,
 	print_enable("Short range mode", evt->mode);
 }
 
-static void amp_status_change_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void amp_status_change_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_amp_status_change *evt = data;
 
@@ -10794,8 +10872,8 @@ static void amp_status_change_evt(uint16_t index, const void *data,
 	print_amp_status(evt->amp_status);
 }
 
-static void triggered_clock_capture_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void triggered_clock_capture_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_triggered_clock_capture *evt = data;
 
@@ -10805,16 +10883,16 @@ static void triggered_clock_capture_evt(uint16_t index, const void *data,
 	print_clock_offset(evt->clock_offset);
 }
 
-static void sync_train_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void sync_train_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_sync_train_complete *evt = data;
 
 	print_status(evt->status);
 }
 
-static void sync_train_received_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void sync_train_received_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_sync_train_received *evt = data;
 
@@ -10829,8 +10907,8 @@ static void sync_train_received_evt(uint16_t index, const void *data,
 	print_field("Service Data: 0x%2.2x", evt->service_data);
 }
 
-static void peripheral_broadcast_receive_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void peripheral_broadcast_receive_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_peripheral_broadcast_receive *evt = data;
 
@@ -10852,8 +10930,8 @@ static void peripheral_broadcast_receive_evt(uint16_t index, const void *data,
 		packet_hexdump(data + 18, size - 18);
 }
 
-static void peripheral_broadcast_timeout_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void peripheral_broadcast_timeout_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_peripheral_broadcast_timeout *evt = data;
 
@@ -10861,8 +10939,8 @@ static void peripheral_broadcast_timeout_evt(uint16_t index, const void *data,
 	print_lt_addr(evt->lt_addr);
 }
 
-static void truncated_page_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void truncated_page_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_truncated_page_complete *evt = data;
 
@@ -10870,21 +10948,22 @@ static void truncated_page_complete_evt(uint16_t index, const void *data,
 	print_bdaddr(evt->bdaddr);
 }
 
-static void peripheral_page_response_timeout_evt(uint16_t index,
-						const void *data, uint8_t size)
+static void peripheral_page_response_timeout_evt(struct timeval *tv,
+					uint16_t index, const void *data,
+					uint8_t size)
 {
 }
 
-static void channel_map_change_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void channel_map_change_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_channel_map_change *evt = data;
 
 	print_channel_map(evt->map);
 }
 
-static void inquiry_response_notify_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void inquiry_response_notify_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_inquiry_response_notify *evt = data;
 
@@ -10892,15 +10971,16 @@ static void inquiry_response_notify_evt(uint16_t index, const void *data,
 	print_rssi(evt->rssi);
 }
 
-static void auth_payload_timeout_expired_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void auth_payload_timeout_expired_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_auth_payload_timeout_expired *evt = data;
 
 	print_handle(evt->handle);
 }
 
-static void le_conn_complete_evt(uint16_t index, const void *data, uint8_t size)
+static void le_conn_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_conn_complete *evt = data;
 
@@ -10921,7 +11001,8 @@ static void le_conn_complete_evt(uint16_t index, const void *data, uint8_t size)
 				(void *)evt->peer_addr, evt->peer_addr_type);
 }
 
-static void le_adv_report_evt(uint16_t index, const void *data, uint8_t size)
+static void le_adv_report_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_adv_report *evt = data;
 	uint8_t evt_len;
@@ -10949,8 +11030,8 @@ report:
 	}
 }
 
-static void le_conn_update_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_conn_update_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_conn_update_complete *evt = data;
 
@@ -10963,8 +11044,8 @@ static void le_conn_update_complete_evt(uint16_t index, const void *data,
 					le16_to_cpu(evt->supv_timeout));
 }
 
-static void le_remote_features_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_remote_features_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_remote_features_complete *evt = data;
 
@@ -10973,8 +11054,8 @@ static void le_remote_features_complete_evt(uint16_t index, const void *data,
 	print_features(0, evt->features, 0x01);
 }
 
-static void le_long_term_key_request_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_long_term_key_request_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_long_term_key_request *evt = data;
 
@@ -10983,8 +11064,8 @@ static void le_long_term_key_request_evt(uint16_t index, const void *data,
 	print_encrypted_diversifier(evt->ediv);
 }
 
-static void le_conn_param_request_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_conn_param_request_evt(struct timeval *tv, uint16_t index,
+				      const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_conn_param_request *evt = data;
 
@@ -10997,8 +11078,8 @@ static void le_conn_param_request_evt(uint16_t index, const void *data,
 					le16_to_cpu(evt->supv_timeout));
 }
 
-static void le_data_length_change_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_data_length_change_evt(struct timeval *tv, uint16_t index,
+				      const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_data_length_change *evt = data;
 
@@ -11009,8 +11090,8 @@ static void le_data_length_change_evt(uint16_t index, const void *data,
 	print_field("Max RX time: %d", le16_to_cpu(evt->max_rx_time));
 }
 
-static void le_read_local_pk256_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_read_local_pk256_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_read_local_pk256_complete *evt = data;
 
@@ -11018,8 +11099,8 @@ static void le_read_local_pk256_complete_evt(uint16_t index, const void *data,
 	print_pk256("Local P-256 public key", evt->local_pk256);
 }
 
-static void le_generate_dhkey_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_generate_dhkey_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_generate_dhkey_complete *evt = data;
 
@@ -11027,8 +11108,8 @@ static void le_generate_dhkey_complete_evt(uint16_t index, const void *data,
 	print_dhkey(evt->dhkey);
 }
 
-static void le_enhanced_conn_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_enhanced_conn_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_enhanced_conn_complete *evt = data;
 
@@ -11051,8 +11132,8 @@ static void le_enhanced_conn_complete_evt(uint16_t index, const void *data,
 				(void *)evt->peer_addr, evt->peer_addr_type);
 }
 
-static void le_direct_adv_report_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_direct_adv_report_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_direct_adv_report *evt = data;
 
@@ -11069,8 +11150,8 @@ static void le_direct_adv_report_evt(uint16_t index, const void *data,
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
-static void le_phy_update_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_phy_update_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_phy_update_complete *evt = data;
 
@@ -11173,8 +11254,8 @@ static void print_legacy_adv_report_pdu(uint16_t flags)
 	print_field("  Legacy PDU Type: %s (0x%4.4x)", str, flags);
 }
 
-static void le_ext_adv_report_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_ext_adv_report_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_ext_adv_report *evt = data;
 	const struct bt_hci_le_ext_adv_report *report;
@@ -11261,7 +11342,8 @@ static void le_ext_adv_report_evt(uint16_t index, const void *data,
 	}
 }
 
-static void le_pa_sync(uint16_t index, const void *data, uint8_t size)
+static void le_pa_sync_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_per_sync_established *evt = data;
 
@@ -11279,7 +11361,8 @@ static void le_pa_sync(uint16_t index, const void *data, uint8_t size)
 	print_field("Advertiser clock accuracy: 0x%2.2x", evt->clock_accuracy);
 }
 
-static void le_pa_report_evt(uint16_t index, const void *data, uint8_t size)
+static void le_pa_report_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
 {
 	const struct bt_hci_le_pa_report *evt = data;
 	const char *color_on;
@@ -11341,14 +11424,16 @@ static void le_pa_report_evt(uint16_t index, const void *data, uint8_t size)
 	packet_hexdump(evt->data, evt->data_len);
 }
 
-static void le_pa_sync_lost(uint16_t index, const void *data, uint8_t size)
+static void le_pa_sync_lost_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_per_sync_lost *evt = data;
 
 	print_field("Sync handle: %d", evt->handle);
 }
 
-static void le_adv_set_term_evt(uint16_t index, const void *data, uint8_t size)
+static void le_adv_set_term_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_adv_set_term *evt = data;
 
@@ -11359,8 +11444,8 @@ static void le_adv_set_term_evt(uint16_t index, const void *data, uint8_t size)
 			evt->num_evts);
 }
 
-static void le_scan_req_received_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_scan_req_received_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_scan_req_received *evt = data;
 
@@ -11370,8 +11455,8 @@ static void le_scan_req_received_evt(uint16_t index, const void *data,
 							evt->scanner_addr_type);
 }
 
-static void le_chan_select_alg_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_chan_select_alg_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_chan_select_alg *evt = data;
 	const char *str;
@@ -11393,8 +11478,8 @@ static void le_chan_select_alg_evt(uint16_t index, const void *data,
 	print_field("Algorithm: %s (0x%2.2x)", str, evt->algorithm);
 }
 
-static void le_cte_request_failed_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_cte_request_failed_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_cte_request_failed *evt = data;
 
@@ -11402,8 +11487,8 @@ static void le_cte_request_failed_evt(uint16_t index, const void *data,
 	print_field("Connection handle: %d", evt->handle);
 }
 
-static void le_pa_sync_trans_rec_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_pa_sync_trans_rec_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_pa_sync_trans_rec *evt = data;
 
@@ -11421,8 +11506,8 @@ static void le_pa_sync_trans_rec_evt(uint16_t index, const void *data,
 	print_clock_accuracy(evt->clock_accuracy);
 }
 
-static void le_cis_established_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_cis_established_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_cis_established *evt = data;
 
@@ -11444,7 +11529,8 @@ static void le_cis_established_evt(uint16_t index, const void *data,
 	print_field("ISO Interval: %u", le16_to_cpu(evt->interval));
 }
 
-static void le_req_cis_evt(uint16_t index, const void *data, uint8_t size)
+static void le_req_cis_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_cis_req *evt = data;
 
@@ -11461,7 +11547,8 @@ static void print_bis_handle(const void *data, int i)
 	print_field("Connection Handle #%d: %d", i, handle);
 }
 
-static void le_big_complete_evt(uint16_t index, const void *data, uint8_t size)
+static void le_big_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_big_complete *evt = data;
 
@@ -11480,7 +11567,8 @@ static void le_big_complete_evt(uint16_t index, const void *data, uint8_t size)
 				sizeof(*evt->bis_handle), print_bis_handle);
 }
 
-static void le_big_terminate_evt(uint16_t index, const void *data, uint8_t size)
+static void le_big_terminate_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_big_terminate *evt = data;
 
@@ -11488,8 +11576,8 @@ static void le_big_terminate_evt(uint16_t index, const void *data, uint8_t size)
 	print_reason(evt->reason);
 }
 
-static void le_big_sync_estabilished_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_big_sync_estabilished_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_big_sync_estabilished *evt = data;
 
@@ -11506,7 +11594,8 @@ static void le_big_sync_estabilished_evt(uint16_t index, const void *data,
 						print_bis_handle);
 }
 
-static void le_big_sync_lost_evt(uint16_t index, const void *data, uint8_t size)
+static void le_big_sync_lost_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_big_sync_lost *evt = data;
 
@@ -11514,8 +11603,8 @@ static void le_big_sync_lost_evt(uint16_t index, const void *data, uint8_t size)
 	print_reason(evt->reason);
 }
 
-static void le_req_sca_complete_evt(uint16_t index, const void *data,
-							uint8_t size)
+static void le_req_sca_complete_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_req_peer_sca_complete *evt = data;
 
@@ -11524,7 +11613,8 @@ static void le_req_sca_complete_evt(uint16_t index, const void *data,
 	print_sca(evt->sca);
 }
 
-static void le_big_info_evt(uint16_t index, const void *data, uint8_t size)
+static void le_big_info_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_big_info_adv_report *evt = data;
 
@@ -11546,12 +11636,13 @@ static void le_big_info_evt(uint16_t index, const void *data, uint8_t size)
 struct subevent_data {
 	uint8_t subevent;
 	const char *str;
-	void (*func) (uint16_t index, const void *data, uint8_t size);
+	void (*func) (struct timeval *tv, uint16_t index, const void *data,
+							uint8_t size);
 	uint8_t size;
 	bool fixed;
 };
 
-static void print_subevent(uint16_t index,
+static void print_subevent(struct timeval *tv, uint16_t index,
 				const struct subevent_data *subevent_data,
 				const void *data, uint8_t size)
 {
@@ -11584,7 +11675,7 @@ static void print_subevent(uint16_t index,
 		}
 	}
 
-	subevent_data->func(index, data, size);
+	subevent_data->func(tv, index, data, size);
 }
 
 static const struct subevent_data le_meta_event_table[] = {
@@ -11615,11 +11706,11 @@ static const struct subevent_data le_meta_event_table[] = {
 	{ 0x0d, "LE Extended Advertising Report",
 				le_ext_adv_report_evt, 1, false},
 	{ 0x0e, "LE Periodic Advertising Sync Established",
-				le_pa_sync, 15, true },
+				le_pa_sync_evt, 15, true },
 	{ 0x0f, "LE Periodic Advertising Report",
 				le_pa_report_evt, 7, false},
 	{ 0x10, "LE Periodic Advertising Sync Lost",
-				le_pa_sync_lost, 2, true},
+				le_pa_sync_lost_evt, 2, true},
 	{ 0x11, "LE Scan Timeout" },
 	{ 0x12, "LE Advertising Set Terminated",
 				le_adv_set_term_evt, 5, true},
@@ -11669,7 +11760,8 @@ static const struct subevent_data le_meta_event_table[] = {
 	{ }
 };
 
-static void le_meta_event_evt(uint16_t index, const void *data, uint8_t size)
+static void le_meta_event_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
 {
 	uint8_t subevent = *((const uint8_t *) data);
 	struct subevent_data unknown;
@@ -11689,10 +11781,11 @@ static void le_meta_event_evt(uint16_t index, const void *data, uint8_t size)
 		}
 	}
 
-	print_subevent(index, subevent_data, data + 1, size - 1);
+	print_subevent(tv, index, subevent_data, data + 1, size - 1);
 }
 
-static void vendor_evt(uint16_t index, const void *data, uint8_t size)
+static void vendor_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
 {
 	struct subevent_data vendor_data;
 	char vendor_str[150];
@@ -11713,7 +11806,7 @@ static void vendor_evt(uint16_t index, const void *data, uint8_t size)
 		vendor_data.size = vnd->evt_size;
 		vendor_data.fixed = vnd->evt_fixed;
 
-		print_subevent(index, &vendor_data, data + consumed_size,
+		print_subevent(tv, index, &vendor_data, data + consumed_size,
 							size - consumed_size);
 	} else {
 		uint16_t manufacturer;
@@ -11730,7 +11823,8 @@ static void vendor_evt(uint16_t index, const void *data, uint8_t size)
 struct event_data {
 	uint8_t event;
 	const char *str;
-	void (*func) (uint16_t index, const void *data, uint8_t size);
+	void (*func) (struct timeval *tv, uint16_t index, const void *data,
+							uint8_t size);
 	uint8_t size;
 	bool fixed;
 };
@@ -12243,7 +12337,24 @@ void packet_hci_event(struct timeval *tv, struct ucred *cred, uint16_t index,
 		}
 	}
 
-	event_data->func(index, data, hdr->plen);
+	event_data->func(tv, index, data, hdr->plen);
+}
+
+static void packet_queue_tx(struct timeval *tv, uint16_t handle)
+{
+	struct packet_conn_data *conn;
+	struct timeval *tx;
+
+	conn = packet_get_conn_data(handle);
+	if (!conn)
+		return;
+
+	if (!conn->tx_q)
+		conn->tx_q = queue_new();
+
+	tx = new0(struct timeval, 1);
+	memcpy(tx, tv, sizeof(*tv));
+	queue_push_tail(conn->tx_q, tx);
 }
 
 void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
@@ -12283,6 +12394,9 @@ void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				in ? "ACL Data RX" : "ACL Data TX",
 						handle_str, extra_str);
 
+	if (!in)
+		packet_queue_tx(tv, acl_handle(handle));
+
 	if (size != dlen) {
 		print_text(COLOR_ERROR, "invalid packet size (%d != %d)",
 								size, dlen);
@@ -12332,6 +12446,9 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				in ? "SCO Data RX" : "SCO Data TX",
 						handle_str, extra_str);
 
+	if (!in)
+		packet_queue_tx(tv, acl_handle(handle));
+
 	if (size != hdr->dlen) {
 		print_text(COLOR_ERROR, "invalid packet size (%d != %d)",
 							size, hdr->dlen);
@@ -12379,6 +12496,9 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				in ? "ISO Data RX" : "ISO Data TX",
 						handle_str, extra_str);
 
+	if (!in)
+		packet_queue_tx(tv, acl_handle(handle));
+
 	if (size != hdr->dlen) {
 		print_text(COLOR_ERROR, "invalid packet size (%d != %d)",
 							size, hdr->dlen);
diff --git a/monitor/packet.h b/monitor/packet.h
index 55ba854ec1f7..8c47a542bca7 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -31,6 +31,10 @@ struct packet_conn_data {
 	uint8_t  type;
 	uint8_t  dst[6];
 	uint8_t  dst_type;
+	struct queue *tx_q;
+	struct timeval tx_min;
+	struct timeval tx_max;
+	struct timeval tx_med;
 	void     *data;
 	void     (*destroy)(void *data);
 };
diff --git a/monitor/vendor.h b/monitor/vendor.h
index 9430f3736818..996ed44cb18e 100644
--- a/monitor/vendor.h
+++ b/monitor/vendor.h
@@ -25,7 +25,8 @@ struct vendor_ocf {
 struct vendor_evt {
 	uint8_t evt;
 	const char *str;
-	void (*evt_func) (uint16_t index, const void *data, uint8_t size);
+	void (*evt_func) (struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size);
 	uint8_t evt_size;
 	bool evt_fixed;
 };
-- 
2.40.1

