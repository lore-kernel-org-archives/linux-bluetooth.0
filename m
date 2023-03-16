Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FFEC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 01:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCPBQg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 21:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCPBQf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 21:16:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FF337F11
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 18:16:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o11so147486ple.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 18:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678929391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=94yMlbDzjaMILVDL5DimGkuhCNlfrbJ5xFedRs1rvno=;
        b=mnixd8rSXI/g02gzXyySMm6FrKypmeExczKlSMaX7UDPDfjuCLQo0ayrpGuwP/5qUR
         bVTqgVlxxaHOpxHKbW2ksO5kuLeNne7bjhhHrLmWm0iGgv5CufFjqI2QUO1+0VsUSIvu
         BeKgq764JE2Hp4AvnJcyeVfJBvyMG0YmtsDDs8BXYZdKlT9amghw/mQdvdECiPTPm/AY
         QOovnFX9c0vmF3Z6lyfowgK5pmE/pm1A3JhYBhQYM1NrpSbtWqaBfB09txCHoTZ6cMcm
         u3bwK2Ru8McA0wxB/KluzkHu41cnJbGit7idNJRvuNNywDRDIJOUlVkVEb8Ww1JzJ11h
         i+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678929391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94yMlbDzjaMILVDL5DimGkuhCNlfrbJ5xFedRs1rvno=;
        b=MvnXVDDt86ALbgNXA7lVJO4du1G7zu5Bg5jXRtFx4wbXxkjugaLKshLi9buKVwfIpX
         uO22cvKRsvvxOgaN5hmNfoKAD2fMPudVLkr1n0rcOKqRxvLnXMuLqGD6/qPBsxlDE7Ua
         VujzGL0pL+a5hZMqp++PMoYDx3Ne/IolcBe1GZ0no1va4h0kOZ0f8TnTz2ds5QQytqeR
         ZMjgI02IE886hLkOykhpj46ylFF0Ei73/0N2wcNll6nb7hQWggQTeCq6ml2F3rMTBUEI
         8yTSGAPu1Q3HNFwylYwRWBySnXFd2gBvMaEn6DCjDoa4ph+4qPIRGrIWesq2ZgWsLQ7n
         g5NQ==
X-Gm-Message-State: AO0yUKXwYdaW/Du8fboXJNrhaYfF0NEr5RBMU9IyqN4pi+GyAKa2qeuK
        aRQZmgvM3Smsa7Rt1U2CVSsyB2l2n5o=
X-Google-Smtp-Source: AK7set9lJSRr9HvOPnpshCf7zL+/FaoZVyK7R40kqT0vZSC5n4yP1xkEvD1XhKho5CbOnpXyjXxPaw==
X-Received: by 2002:a05:6a20:b054:b0:cc:63c6:8d3a with SMTP id dx20-20020a056a20b05400b000cc63c68d3amr1491315pzb.41.1678929390552;
        Wed, 15 Mar 2023 18:16:30 -0700 (PDT)
Received: from zbook.. (97-113-12-200.tukw.qwest.net. [97.113.12.200])
        by smtp.gmail.com with ESMTPSA id g3-20020a631103000000b00502ecb91940sm3914328pgl.55.2023.03.15.18.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 18:16:30 -0700 (PDT)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, brian.gix@gmail.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v2 1/3] mesh: Filter originated Provisioning Data packets
Date:   Wed, 15 Mar 2023 18:16:25 -0700
Message-Id: <20230316011627.27322-1-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The mesh daemon can process incoming mesh packets on more than one
controller, but if a Provisioning data packet that originated from the
local daemon is received by a different controller, it must be filtered
and disregarded, or it will break the provisioning protocol.
---
 mesh/mesh-io-mgmt.c | 58 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/mesh/mesh-io-mgmt.c b/mesh/mesh-io-mgmt.c
index 9ae1af05a..65994f058 100644
--- a/mesh/mesh-io-mgmt.c
+++ b/mesh/mesh-io-mgmt.c
@@ -82,6 +82,8 @@ struct dup_filter {
 	uint8_t addr[6];
 } __packed;
 
+static const uint8_t zero_addr[] = {0, 0, 0, 0, 0, 0};
+
 static struct mesh_io_private *pvt;
 
 static uint32_t get_instant(void)
@@ -110,6 +112,14 @@ static bool find_by_addr(const void *a, const void *b)
 	return !memcmp(filter->addr, b, 6);
 }
 
+static bool find_by_adv(const void *a, const void *b)
+{
+	const struct dup_filter *filter = a;
+	uint64_t data = l_get_be64(b);
+
+	return !memcmp(filter->addr, zero_addr, 6) && filter->data == data;
+}
+
 static void filter_timeout(struct l_timeout *timeout, void *user_data)
 {
 	struct dup_filter *filter;
@@ -146,7 +156,22 @@ static bool filter_dups(const uint8_t *addr, const uint8_t *adv,
 	uint32_t instant_delta;
 	uint64_t data = l_get_be64(adv);
 
-	filter = l_queue_remove_if(pvt->dup_filters, find_by_addr, addr);
+	if (!addr)
+		addr = zero_addr;
+
+	if (adv[1] == MESH_AD_TYPE_PROVISION) {
+		filter = l_queue_find(pvt->dup_filters, find_by_adv, adv);
+
+		if (!filter && addr != zero_addr)
+			return false;
+
+		l_queue_remove(pvt->dup_filters, filter);
+
+	} else {
+		filter = l_queue_remove_if(pvt->dup_filters, find_by_addr,
+									addr);
+	}
+
 	if (!filter) {
 		filter = l_new(struct dup_filter, 1);
 		memcpy(filter->addr, addr, 6);
@@ -177,7 +202,7 @@ static void process_rx_callbacks(void *v_reg, void *v_rx)
 		rx_reg->cb(rx_reg->user_data, &rx->info, rx->data, rx->len);
 }
 
-static void process_rx(struct mesh_io_private *pvt, int8_t rssi,
+static void process_rx(uint16_t index, struct mesh_io_private *pvt, int8_t rssi,
 					uint32_t instant, const uint8_t *addr,
 					const uint8_t *data, uint8_t len)
 {
@@ -191,6 +216,10 @@ static void process_rx(struct mesh_io_private *pvt, int8_t rssi,
 		.info.rssi = rssi,
 	};
 
+	/* Accept all traffic except beacons from any controller */
+	if (index != pvt->send_idx && data[0] == MESH_AD_TYPE_BEACON)
+		return;
+
 	print_packet("RX", data, len);
 	l_queue_foreach(pvt->rx_regs, process_rx_callbacks, &rx);
 }
@@ -205,7 +234,7 @@ static void event_device_found(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_ev_mesh_device_found *ev = param;
-	struct mesh_io *io = user_data;
+	struct mesh_io_private *pvt = user_data;
 	const uint8_t *adv;
 	const uint8_t *addr;
 	uint32_t instant;
@@ -236,9 +265,10 @@ static void event_device_found(uint16_t index, uint16_t length,
 		if (len > adv_len)
 			break;
 
-		if (adv[1] >= 0x29 && adv[1] <= 0x2B)
-			process_rx(io->pvt, ev->rssi, instant, addr, adv + 1,
-								adv[0]);
+		if (adv[1] >= MESH_AD_TYPE_PROVISION &&
+					adv[1] <= MESH_AD_TYPE_BEACON)
+			process_rx(index, pvt, ev->rssi, instant, addr,
+							adv + 1, adv[0]);
 
 		adv += field_len + 1;
 	}
@@ -320,6 +350,12 @@ static void ctl_up(uint8_t status, uint16_t length,
 	mesh->num_ad_types = sizeof(mesh_ad_types);
 	memcpy(mesh->ad_types, mesh_ad_types, sizeof(mesh_ad_types));
 
+	pvt->rx_id = mesh_mgmt_register(MGMT_EV_MESH_DEVICE_FOUND,
+				MGMT_INDEX_NONE, event_device_found, pvt,
+				NULL);
+	pvt->tx_id = mesh_mgmt_register(MGMT_EV_MESH_PACKET_CMPLT,
+					index, send_cmplt, pvt, NULL);
+
 	mesh_mgmt_send(MGMT_OP_SET_MESH_RECEIVER, index, len, mesh,
 			mesh_up, L_UINT_TO_PTR(index), NULL);
 	l_debug("done %d mesh startup", index);
@@ -407,11 +443,6 @@ static bool dev_init(struct mesh_io *io, void *opts, void *user_data)
 	mesh_mgmt_send(MGMT_OP_READ_INFO, index, 0, NULL,
 				read_info_cb, L_UINT_TO_PTR(index), NULL);
 
-	pvt->rx_id = mesh_mgmt_register(MGMT_EV_MESH_DEVICE_FOUND,
-				MGMT_INDEX_NONE, event_device_found, io, NULL);
-	pvt->tx_id = mesh_mgmt_register(MGMT_EV_MESH_PACKET_CMPLT,
-					MGMT_INDEX_NONE, send_cmplt, io, NULL);
-
 	pvt->dup_filters = l_queue_new();
 	pvt->rx_regs = l_queue_new();
 	pvt->tx_pkts = l_queue_new();
@@ -522,6 +553,11 @@ static void send_pkt(struct mesh_io_private *pvt, struct tx_pkt *tx,
 	send->adv_data_len = tx->len + 1;
 	send->adv_data[0] = tx->len;
 	memcpy(send->adv_data + 1, tx->pkt, tx->len);
+
+	/* Filter looped back Provision packets */
+	if (tx->pkt[0] == MESH_AD_TYPE_PROVISION)
+		filter_dups(NULL, send->adv_data, get_instant());
+
 	mesh_mgmt_send(MGMT_OP_MESH_SEND, index,
 			len, send, send_queued, tx, NULL);
 	print_packet("Mesh Send Start", tx->pkt, tx->len);
-- 
2.39.2

