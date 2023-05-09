Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EA4C77B75
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 May 2023 23:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjEIXf6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 May 2023 19:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjEIXfz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 May 2023 19:35:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E674230
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 May 2023 16:35:46 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-51f597c975fso6078450a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 May 2023 16:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683675345; x=1686267345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+1RyecnQEGEHYoOnWxmIGeSklxSG+vsAqT3FxCndg4=;
        b=H9Xqdnl/QH361gJpk6khbFxQy67XDNCvJY0SNRlmrJ/Eu33u92ZqzvpAEGJSptzpIf
         AswLlCQq8wDxNJ95L5M2e6LLXBkuYgsIr2p/8djrTyYyc80i3FnoDVRUYaCKJcHJV3RI
         CQy0hI+5uq5TmKvFfPBrTQmYSo8DiSdmrCikBKZmtBL58FxrDBbY4qCF2PgHGp7DfCXm
         BBqvhqVnaa69bvmQOZN3ZcHMDfzLleqmQkzFXDwAfyeGpL6De+BmA+CS77fSaiM2S0vJ
         n0XRNnAomAC83EtLLW8bA7JM3Ook3g+F7COIalQcG3qEhPfs6A2nbZIT7vnNo5yCR1Cn
         AEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683675345; x=1686267345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+1RyecnQEGEHYoOnWxmIGeSklxSG+vsAqT3FxCndg4=;
        b=Qf8x8rdA3vCLPmhHVT9IFpVRoQsEzeOVSVdvxZgrv7fPy3p+BVoU0Vsx7nCddzopDx
         vZaMQz1sxzmveZb2TUqeLNLYtmC8xgokx0S8Ti9LlhQtBCxxTfkhrdg88vSpySYGvGCK
         +BXg2Dw/iYBbYh/EexbQG/hz5VqA28Lzzi5DIQEub8CyMC7kO1v57Z0ylfl0XW1TV9Lr
         vjcWIDiKfOdiG3cVeTOarvGIrrr+OL7vxJfCEoDSHIiwTv1R7Yvl+zFAMfdK1hS1kweC
         VQOgn/gOp2wkKid6y7nh/MiLJGH0i2073aWasohJdSwW2qN3q6B5ARIrleeMZa8xzUGO
         9PKQ==
X-Gm-Message-State: AC+VfDwQEHLthGV9Uj9i/BNPLBpIjbGTrDQGFFQFw5jUUdtGBPLKclBY
        FpvdJKX4mU07HpSkUF7SC4fp4+tuaHA=
X-Google-Smtp-Source: ACHHUZ7aLHzTqtB6PQ2TKYRqawWNiE8pKZK3CXBGxmizEAkwll/f/gKCKf1XXCzFDQ+LgTJObLrtUg==
X-Received: by 2002:a17:903:41c1:b0:1ac:4162:5922 with SMTP id u1-20020a17090341c100b001ac41625922mr18441042ple.66.1683675344868;
        Tue, 09 May 2023 16:35:44 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902eb4600b001a67759f9f8sm2205235pli.106.2023.05.09.16.35.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 16:35:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] monitor/intel: Skip packet/error counters if 0
Date:   Tue,  9 May 2023 16:35:40 -0700
Message-Id: <20230509233540.3418541-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230509233540.3418541-1-luiz.dentz@gmail.com>
References: <20230509233540.3418541-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This skips printing TLVs related to packet/error count if they are 0 and
also update the of TLVs:

> HCI Event: Vendor (0xff) plen 188
        Vendor Prefix (0x8780)
      Intel Extended Telemetry (0x03)
        Extended event type (0x01): Perform Stats (0x05)
        ACL connection handle (0x4a): 0x0100
        Rx HEC errors (0x4b): 3
        Packets from host (0x4d): 375
        Tx packets (0x4e): 375
        Tx packets 0 retries (0x4f): 354
        Tx packets 1 retries (0x50): 20
        Tx packets 3 retries (0x52): 1
        Tx 3DH5 packets (0x5c): 375
        Rx packets (0x5d): 400
        ACL link throughput (bps) (0x5e): 533419
        ACL max packet latency (us) (0x5f): 36875
        ACL avg packet latency (us) (0x60): 19441
        ACL RX RSSI moving avg (0x61): 65329
        ACL RX SNR Bad Margin Counter (0x62): 1M 59 2M 0 3M 0
        ACL RX RSSI Bad Counter (0x63): 1M 1711 2M 0 3M 0
        ACL TX RSSI Bad Counter (0x64): 1M 1024 2M 0 3M 0
---
 monitor/intel.c | 129 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 122 insertions(+), 7 deletions(-)

diff --git a/monitor/intel.c b/monitor/intel.c
index 416f52503ebf..bdce882dd49f 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -1257,11 +1257,9 @@ static void ext_evt_type(const struct intel_tlv *tlv)
 		str = "Disconnection Event";
 		break;
 	case 0x05:
-		str = "Audio Link Quality Report Type";
-		break;
-	case 0x06:
-		str = "Stats for BR/EDR Link Type";
+		str = "Perform Stats";
 		break;
+
 	default:
 		print_text(COLOR_UNKNOWN_EXT_EVENT,
 			"Unknown extended telemetry event type (0x%2.2x)",
@@ -1287,6 +1285,10 @@ static void ext_acl_evt_hec_errors(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	print_field("Rx HEC errors (0x%2.2x): %d", tlv->subevent_id, num);
 }
 
@@ -1294,6 +1296,10 @@ static void ext_acl_evt_crc_errors(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	print_field("Rx CRC errors (0x%2.2x): %d", tlv->subevent_id, num);
 }
 
@@ -1301,6 +1307,10 @@ static void ext_acl_evt_num_pkt_from_host(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	print_field("Packets from host (0x%2.2x): %d",
 			tlv->subevent_id, num);
 }
@@ -1309,6 +1319,10 @@ static void ext_acl_evt_num_tx_pkt_to_air(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	print_field("Tx packets (0x%2.2x): %d", tlv->subevent_id, num);
 }
 
@@ -1317,6 +1331,10 @@ static void ext_acl_evt_num_tx_pkt_retry(const struct intel_tlv *tlv)
 	char *subevent_str;
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	switch (tlv->subevent_id) {
 	case 0x4f:
 		subevent_str = "Tx packets 0 retries";
@@ -1346,6 +1364,10 @@ static void ext_acl_evt_num_tx_pkt_type(const struct intel_tlv *tlv)
 	char *packet_type_str;
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	switch (tlv->subevent_id) {
 	case 0x54:
 		packet_type_str = "DH1";
@@ -1387,6 +1409,10 @@ static void ext_acl_evt_num_rx_pkt_from_air(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	print_field("Rx packets (0x%2.2x): %d",
 			tlv->subevent_id, num);
 }
@@ -1395,7 +1421,11 @@ static void ext_acl_evt_link_throughput(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
-	print_field("ACL link throughput (KBps) (0x%2.2x): %d",
+	/* Skip if 0 */
+	if (!num)
+		return;
+
+	print_field("ACL link throughput (bps) (0x%2.2x): %d",
 			tlv->subevent_id, num);
 }
 
@@ -1403,7 +1433,11 @@ static void ext_acl_evt_max_packet_latency(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
-	print_field("ACL max packet latency (ms) (0x%2.2x): %d",
+	/* Skip if 0 */
+	if (!num)
+		return;
+
+	print_field("ACL max packet latency (us) (0x%2.2x): %d",
 			tlv->subevent_id, num);
 }
 
@@ -1411,10 +1445,55 @@ static void ext_acl_evt_avg_packet_latency(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
-	print_field("ACL avg packet latency (ms) (0x%2.2x): %d",
+	/* Skip if 0 */
+	if (!num)
+		return;
+
+	print_field("ACL avg packet latency (us) (0x%2.2x): %d",
 			tlv->subevent_id, num);
 }
 
+static void ext_acl_evt_rssi_moving_avg(const struct intel_tlv *tlv)
+{
+	uint32_t num = get_le16(tlv->value);
+
+	/* Skip if 0 */
+	if (!num)
+		return;
+
+	print_field("ACL RX RSSI moving avg (0x%2.2x): %d",
+			tlv->subevent_id, num);
+}
+
+static void ext_acl_evt_bad_cnt(const char *prefix, const struct intel_tlv *tlv)
+{
+	uint32_t c_1m = get_le32(tlv->value);
+	uint32_t c_2m = get_le32(tlv->value + 4);
+	uint32_t c_3m = get_le32(tlv->value + 8);
+
+	/* Skip if all 0 */
+	if (!c_1m && !c_2m && !c_3m)
+		return;
+
+	print_field("%s (0x%2.2x): 1M %d 2M %d 3M %d",
+			prefix, tlv->subevent_id, c_1m, c_2m, c_3m);
+}
+
+static void ext_acl_evt_snr_bad_cnt(const struct intel_tlv *tlv)
+{
+	ext_acl_evt_bad_cnt("ACL RX SNR Bad Margin Counter", tlv);
+}
+
+static void ext_acl_evt_rx_rssi_bad_cnt(const struct intel_tlv *tlv)
+{
+	ext_acl_evt_bad_cnt("ACL RX RSSI Bad Counter", tlv);
+}
+
+static void ext_acl_evt_tx_rssi_bad_cnt(const struct intel_tlv *tlv)
+{
+	ext_acl_evt_bad_cnt("ACL TX RSSI Bad Counter", tlv);
+}
+
 static void ext_sco_evt_conn_handle(const struct intel_tlv *tlv)
 {
 	uint16_t conn_handle = get_le16(tlv->value);
@@ -1427,6 +1506,10 @@ static void ext_sco_evt_num_rx_pkt_from_air(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	print_field("Packets from host (0x%2.2x): %d", tlv->subevent_id, num);
 }
 
@@ -1434,6 +1517,10 @@ static void ext_sco_evt_num_tx_pkt_to_air(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	print_field("Tx packets (0x%2.2x): %d", tlv->subevent_id, num);
 }
 
@@ -1441,6 +1528,10 @@ static void ext_sco_evt_num_rx_payloads_lost(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	print_field("Rx payload lost (0x%2.2x): %d", tlv->subevent_id, num);
 }
 
@@ -1449,6 +1540,10 @@ static void ext_sco_evt_num_tx_payloads_lost(const struct intel_tlv *tlv)
 
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	print_field("Tx payload lost (0x%2.2x): %d", tlv->subevent_id, num);
 }
 
@@ -1508,6 +1603,10 @@ static void ext_sco_evt_samples_inserted(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	print_field("Late samples inserted based on CDC (0x%2.2x): %d",
 			tlv->subevent_id, num);
 }
@@ -1516,6 +1615,10 @@ static void ext_sco_evt_samples_dropped(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	print_field("Samples dropped (0x%2.2x): %d", tlv->subevent_id, num);
 }
 
@@ -1523,6 +1626,10 @@ static void ext_sco_evt_mute_samples(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	print_field("Mute samples sent at initial connection (0x%2.2x): %d",
 			tlv->subevent_id, num);
 }
@@ -1531,6 +1638,10 @@ static void ext_sco_evt_plc_injection_data(const struct intel_tlv *tlv)
 {
 	uint32_t num = get_le32(tlv->value);
 
+	/* Skip if 0 */
+	if (!num)
+		return;
+
 	print_field("PLC injection data (0x%2.2x): %d", tlv->subevent_id, num);
 }
 
@@ -1565,6 +1676,10 @@ static const struct intel_ext_subevent {
 	{ 0x5e, 4, ext_acl_evt_link_throughput },
 	{ 0x5f, 4, ext_acl_evt_max_packet_latency },
 	{ 0x60, 4, ext_acl_evt_avg_packet_latency },
+	{ 0x61, 2, ext_acl_evt_rssi_moving_avg },
+	{ 0x62, 12, ext_acl_evt_snr_bad_cnt },
+	{ 0x63, 12, ext_acl_evt_rx_rssi_bad_cnt },
+	{ 0x64, 12, ext_acl_evt_tx_rssi_bad_cnt },
 
 	/* SCO/eSCO audio link quality subevents */
 	{ 0x6a, 2, ext_sco_evt_conn_handle },
-- 
2.40.0

