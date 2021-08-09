Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9462C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 22:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD246101E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 22:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbhHIWuJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbhHIWuI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 18:50:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6DEC0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Aug 2021 15:49:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j1so30304174pjv.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Aug 2021 15:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=y+RSEjmtvT3+m2SS+ib166a8ULm55XL3JqmWHCKZeOs=;
        b=vYDxbVpRURACrQR0eOZm/Zm8rL3HbAt7BgBGFxZjxdBj61WWmne8qRRj7vDOpKZZ6N
         ohLiQaavthb/k34T+6mzGA0GjlrdRYRjyQMVUjRY7iDH+ZjoB2F2heF8VyhSz1WcULVQ
         6DX7F8sUVCFstxHmfhqpLJogKv6+bT/+hsfdqf9z1qTpS8cVcLaOuqLLsukWp1GlWp9u
         ifEmbllDBy2Lp+Ur6Rzk+UV+DV43J9+FHFwzTpS+QqJ2lG30NBgjC0fDlerE/RHbcxLG
         BH18WVaIsBCamAWkKZfW0EWIb1uXP4Gj8B/YwtdopV8KMWJ1KULpZV3cydCZ73Un7Da/
         w11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+RSEjmtvT3+m2SS+ib166a8ULm55XL3JqmWHCKZeOs=;
        b=Dp8iWiHDQH8zRvXWwnlLWGM7iTSzulH6w/peskGj+0lKROSszJjZwlwWPBgHUyETGx
         da3ZQN/or8RngKmlHAc6pmgVpGNDuyP8TrTAr+Ll3FbfQkj/wSNW5EyuJt6FIRDn5k5z
         gFI05XIe+pmCDx4iivBFMItlC9I+VQlcrIlIl9EWBgbx71bPvfcldeilioZQmgnnffVp
         Y9YKmAtpQTyk1zG5GGQeiO/g5wjd6bc8j4Cq+z7e0nEtOOwY16hHmKY5++xRVR72lgGT
         d70CMuk6p/m4l90maqu8gzNNrlZ38b1pZDaGWaZcmjIPv/o0XklbV6KqrhvG1nax6Rxf
         9uJw==
X-Gm-Message-State: AOAM533WHi4wvoZtb8hovt/6FuX7ho5ARWUQA9A9CEgsSes+7F0QP4Yl
        yjB04jRIK832cmjoob+QF5DJ3MF5Veo=
X-Google-Smtp-Source: ABdhPJx4D/jrEqkMsQtvwhIekXwdUJinzB7OBG2wbwuJ50vB8a3kf3Hy9VS9BdHgDLpsZIXJhe55Dw==
X-Received: by 2002:a65:5ac8:: with SMTP id d8mr444593pgt.34.1628549387037;
        Mon, 09 Aug 2021 15:49:47 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n35sm20826891pfv.152.2021.08.09.15.49.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 15:49:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 5/5] monitor: Make --analyze print address OUI
Date:   Mon,  9 Aug 2021 15:49:42 -0700
Message-Id: <20210809224942.225915-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210809224942.225915-1-luiz.dentz@gmail.com>
References: <20210809224942.225915-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes analyze.c use packet_print_addr which does take care of
decoding OUI portion of the address.
---
 monitor/analyze.c  | 30 ++++++++++++-----------
 monitor/broadcom.c |  2 +-
 monitor/intel.c    | 10 ++++----
 monitor/l2cap.c    | 60 +---------------------------------------------
 monitor/lmp.c      |  2 +-
 monitor/packet.c   |  9 ++++---
 monitor/packet.h   |  2 +-
 7 files changed, 29 insertions(+), 86 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index bee05f467..4755c6ca6 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -13,6 +13,7 @@
 #include <config.h>
 #endif
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
 #include <sys/time.h>
@@ -23,7 +24,9 @@
 #include "src/shared/queue.h"
 #include "src/shared/btsnoop.h"
 #include "monitor/bt.h"
-#include "analyze.h"
+#include "monitor/display.h"
+#include "monitor/packet.h"
+#include "monitor/analyze.h"
 
 struct hci_dev {
 	uint16_t index;
@@ -102,26 +105,25 @@ static void conn_destroy(void *data)
 	conn->tx_pkt_med = conn->tx_bytes / conn->tx_num;
 
 	printf("  Found %s connection with handle %u\n", str, conn->handle);
-	printf("    BD_ADDR %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X\n",
-			conn->bdaddr[5], conn->bdaddr[4], conn->bdaddr[3],
-			conn->bdaddr[2], conn->bdaddr[1], conn->bdaddr[0]);
+	/* TODO: Store address type */
+	packet_print_addr("Address", conn->bdaddr, 0x00);
 	if (!conn->setup_seen)
-		printf("    Connection setup missing\n");
-	printf("    %lu RX packets\n", conn->rx_num);
-	printf("    %lu TX packets\n", conn->tx_num);
-	printf("    %lu TX completed packets\n", conn->tx_num_comp);
-	printf("    %ld msec min latency\n",
+		print_field("Connection setup missing");
+	print_field("%lu RX packets", conn->rx_num);
+	print_field("%lu TX packets", conn->tx_num);
+	print_field("%lu TX completed packets", conn->tx_num_comp);
+	print_field("%ld msec min latency",
 			conn->tx_lat_min.tv_sec * 1000 +
 			conn->tx_lat_min.tv_usec / 1000);
-	printf("    %ld msec max latency\n",
+	print_field("%ld msec max latency",
 			conn->tx_lat_max.tv_sec * 1000 +
 			conn->tx_lat_max.tv_usec / 1000);
-	printf("    %ld msec median latency\n",
+	print_field("%ld msec median latency",
 			conn->tx_lat_med.tv_sec * 1000 +
 			conn->tx_lat_med.tv_usec / 1000);
-	printf("    %u octets TX min packet size\n", conn->tx_pkt_min);
-	printf("    %u octets TX max packet size\n", conn->tx_pkt_max);
-	printf("    %u octets TX median packet size\n", conn->tx_pkt_med);
+	print_field("%u octets TX min packet size", conn->tx_pkt_min);
+	print_field("%u octets TX max packet size", conn->tx_pkt_max);
+	print_field("%u octets TX median packet size", conn->tx_pkt_med);
 
 	queue_destroy(conn->tx_queue, free);
 	free(conn);
diff --git a/monitor/broadcom.c b/monitor/broadcom.c
index b144032c3..5ee4ba04a 100644
--- a/monitor/broadcom.c
+++ b/monitor/broadcom.c
@@ -233,7 +233,7 @@ static void status_rsp(const void *data, uint8_t size)
 
 static void write_bd_addr_cmd(const void *data, uint8_t size)
 {
-	packet_print_addr("Address", data, false);
+	packet_print_addr("Address", data, 0x00);
 }
 
 static void update_uart_baud_rate_cmd(const void *data, uint8_t size)
diff --git a/monitor/intel.c b/monitor/intel.c
index e9984bfe3..728bff587 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -233,7 +233,7 @@ static void print_version_tlv_min_fw(const struct intel_version_tlv *tlv,
 static void print_version_tlv_otp_bdaddr(const struct intel_version_tlv *tlv,
 					 char *type_str)
 {
-	packet_print_addr(type_str, tlv->val, false);
+	packet_print_addr(type_str, tlv->val, 0x00);
 }
 
 static void print_version_tlv_unknown(const struct intel_version_tlv *tlv,
@@ -535,7 +535,7 @@ static void write_bd_data_cmd(const void *data, uint8_t size)
 {
 	uint8_t features[8];
 
-	packet_print_addr("Address", data, false);
+	packet_print_addr("Address", data, 0x00);
 	packet_hexdump(data + 6, 6);
 
 	memcpy(features, data + 12, 8);
@@ -553,13 +553,13 @@ static void read_bd_data_rsp(const void *data, uint8_t size)
 	uint8_t status = get_u8(data);
 
 	print_status(status);
-	packet_print_addr("Address", data + 1, false);
+	packet_print_addr("Address", data + 1, 0x00);
 	packet_hexdump(data + 7, size - 7);
 }
 
 static void write_bd_address_cmd(const void *data, uint8_t size)
 {
-	packet_print_addr("Address", data, false);
+	packet_print_addr("Address", data, 0x00);
 }
 
 static void act_deact_traces_cmd(const void *data, uint8_t size)
@@ -1119,7 +1119,7 @@ static void sco_rejected_via_lmp_evt(const void *data, uint8_t size)
 {
 	uint8_t reason = get_u8(data + 6);
 
-	packet_print_addr("Address", data, false);
+	packet_print_addr("Address", data, 0x00);
 	packet_print_error("Reason", reason);
 }
 
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index f16f82532..083e53561 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2749,63 +2749,6 @@ static void att_packet(uint16_t index, bool in, uint16_t handle,
 	opcode_data->func(&frame);
 }
 
-static void print_addr(const uint8_t *addr, uint8_t addr_type)
-{
-	const char *str;
-
-	switch (addr_type) {
-	case 0x00:
-		print_field("Address: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
-						addr[5], addr[4], addr[3],
-						addr[2], addr[1], addr[0]);
-		break;
-	case 0x01:
-		switch ((addr[5] & 0xc0) >> 6) {
-		case 0x00:
-			str = "Non-Resolvable";
-			break;
-		case 0x01:
-			str = "Resolvable";
-			break;
-		case 0x03:
-			str = "Static";
-			break;
-		default:
-			str = "Reserved";
-			break;
-		}
-
-		print_field("Address: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X"
-					" (%s)", addr[5], addr[4], addr[3],
-					addr[2], addr[1], addr[0], str);
-		break;
-	default:
-		print_field("Address: %2.2X-%2.2X-%2.2X-%2.2X-%2.2X-%2.2X",
-						addr[5], addr[4], addr[3],
-						addr[2], addr[1], addr[0]);
-		break;
-	}
-}
-
-static void print_addr_type(uint8_t addr_type)
-{
-	const char *str;
-
-	switch (addr_type) {
-	case 0x00:
-		str = "Public";
-		break;
-	case 0x01:
-		str = "Random";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Address type: %s (0x%2.2x)", str, addr_type);
-}
-
 static void print_smp_io_capa(uint8_t io_capa)
 {
 	const char *str;
@@ -3038,8 +2981,7 @@ static void smp_ident_addr_info(const struct l2cap_frame *frame)
 {
 	const struct bt_l2cap_smp_ident_addr_info *pdu = frame->data;
 
-	print_addr_type(pdu->addr_type);
-	print_addr(pdu->addr, pdu->addr_type);
+	packet_print_addr("Address", pdu->addr, pdu->addr_type);
 
 	keys_update_identity_addr(pdu->addr, pdu->addr_type);
 }
diff --git a/monitor/lmp.c b/monitor/lmp.c
index 0d17f5c98..037adf2e2 100644
--- a/monitor/lmp.c
+++ b/monitor/lmp.c
@@ -310,7 +310,7 @@ static void slot_offset(const void *data, uint8_t size)
 	const struct bt_lmp_slot_offset *pdu = data;
 
 	print_field("Offset: %u usec", le16_to_cpu(pdu->offset));
-	packet_print_addr("Address", pdu->bdaddr, false);
+	packet_print_addr("Address", pdu->bdaddr, 0x00);
 }
 
 static void page_scan_mode_req(const void *data, uint8_t size)
diff --git a/monitor/packet.c b/monitor/packet.c
index 025b7e9b0..9e849acc0 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -713,10 +713,9 @@ static void print_addr_resolve(const char *label, const uint8_t *addr,
 	}
 }
 
-static void print_addr(const char *label, const uint8_t *addr,
-						uint8_t addr_type)
+static void print_addr(const char *label, const uint8_t *addr, uint8_t type)
 {
-	print_addr_resolve(label, addr, addr_type, true);
+	print_addr_resolve(label, addr, type, true);
 }
 
 static void print_bdaddr(const uint8_t *bdaddr)
@@ -3780,9 +3779,9 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 		packet_hexdump(eir, eir_len - len);
 }
 
-void packet_print_addr(const char *label, const void *data, bool random)
+void packet_print_addr(const char *label, const void *data, uint8_t type)
 {
-	print_addr(label ? : "Address", data, random ? 0x01 : 0x00);
+	print_addr(label ? : "Address", data, type);
 }
 
 void packet_print_handle(uint16_t handle)
diff --git a/monitor/packet.h b/monitor/packet.h
index f859fa945..34f988e86 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -37,7 +37,7 @@ void packet_print_error(const char *label, uint8_t error);
 void packet_print_version(const char *label, uint8_t version,
 				const char *sublabel, uint16_t subversion);
 void packet_print_company(const char *label, uint16_t company);
-void packet_print_addr(const char *label, const void *data, bool random);
+void packet_print_addr(const char *label, const void *data, uint8_t type);
 void packet_print_handle(uint16_t handle);
 void packet_print_rssi(const char *label, int8_t rssi);
 void packet_print_ad(const void *data, uint8_t size);
-- 
2.31.1

