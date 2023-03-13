Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA5CC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 19:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCMTIp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCMTIo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 15:08:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DA829E0B
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 12:08:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so12764123pjp.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678734500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3z5xDcWJpB9Tq/QGJoMLyZF6EOzA9AFzFfd4EtOanc=;
        b=Dx9CU5jxgWV+UEu9kr2LvIyaGlF8XEYZ1vAHHaXxE44xoGx1gVnMjAD8wYDznf+rjt
         ojEVBTBc1RZsVF2/IpZU7DOOzlV/sFm64vr/JhHMXqAMkSfUp/Sgk7gcw4nb1dPKyc1C
         5Op/DuyQIz1mCDQ5FPwxWV9qwCLGfAMXUvSP14ozJVIb3NbHNOsr4RLCpJcvqU/SOnuN
         Ww+3kItBPOpp+e/J2QpNtUIzLLqpuCnjlkUfoQa+kAaJ8PNNCdXnRtH0r6nww0kq6R/6
         KTw1rv/R8hXOIsJ9OTQPj2xKbx9dH6+AAXYOlSFy3jAgQJgAzsSwoAo2hkC4Yw96wm83
         yYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678734500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3z5xDcWJpB9Tq/QGJoMLyZF6EOzA9AFzFfd4EtOanc=;
        b=QrI3t1Mx/neH2sKkoo6YWnxF9cw3Y5H7C0W6/qI5GRbFbU1V8kXQ9eCLquy98LNBe7
         vjq2MqJokraFZposp+FVkE8HmVorRPAov7BHE53x/Lsz92+OEWNlbwBNnSiJt8xN2wmf
         Dibui7eXKtDxPYrrRPSjFw3itCuakq3yw4+TJn+Qa5OvFpdHABDPqjQQ/9Wm682EFUti
         gckLY5kXYA8vGZTrQNNprzBXvYyfubeRnutD5pDoW15IUtVS+0CVvFp/k/R5g3E4HWnH
         kKLwSD0f1mh9O/VJiJDLfpA9PWv5S8TxdiabKtIFCknWDHKKKGZ3+XrZ1wv99ozPSlwG
         qeQA==
X-Gm-Message-State: AO0yUKUxCVp+l2UsnSqtkxE/B9afBIa6x8NCvmlz4rQzd4zSx38jG5Sf
        UgCO/J+tPcJZe+5Tglwn8HwDfPldZno=
X-Google-Smtp-Source: AK7set+RqxhZBfiddiK1ZppHFLcZ07Fcl5KauHhY1bEK7aKeInvVnAaRi06ydzrdRMOb+OQIspIB8w==
X-Received: by 2002:a17:90a:e7cd:b0:23d:9a3:f571 with SMTP id kb13-20020a17090ae7cd00b0023d09a3f571mr4096440pjb.20.1678734500488;
        Mon, 13 Mar 2023 12:08:20 -0700 (PDT)
Received: from zbook.. (97-113-12-200.tukw.qwest.net. [97.113.12.200])
        by smtp.gmail.com with ESMTPSA id ke4-20020a170903340400b0019f3e35194esm228884plb.64.2023.03.13.12.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 12:08:20 -0700 (PDT)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, brian.gix@gmail.com, inga.stotland@intel.com
Subject: [PATCH BlueZ 2/2] mesh: Loopback unprovisioned beacons
Date:   Mon, 13 Mar 2023 12:08:08 -0700
Message-Id: <20230313190808.48102-2-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313190808.48102-1-brian.gix@gmail.com>
References: <20230313190808.48102-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Because the daemon explicitly supports multiple nodes, we need
local Config Clients to be able to see local unprovisioned devices.

This loops the unprovisioned beacon, so that local Provisioning servers
can see it.

Fixes Issue: https://github.com/bluez/bluez/issues/341
---
 mesh/mesh-io.c       | 54 ++++++++++++++++++++++++++++++++++++++++++++
 mesh/mesh-mgmt.c     |  2 ++
 mesh/remprv-server.c | 24 ++++++++++++++------
 3 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 233f4b328..c941cded0 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -19,6 +19,7 @@
 #include "src/shared/mgmt.h"
 
 #include "mesh/mesh-defs.h"
+#include "mesh/util.h"
 #include "mesh/mesh-mgmt.h"
 #include "mesh/mesh-io.h"
 #include "mesh/mesh-io-api.h"
@@ -42,7 +43,10 @@ static const struct mesh_io_table table[] = {
 	{MESH_IO_TYPE_UNIT_TEST, &mesh_io_unit},
 };
 
+static uint8_t unprv_filter[] = { MESH_AD_TYPE_BEACON, 0 };
+
 static struct mesh_io *default_io;
+static struct l_timeout *loop_adv_to;
 
 static const struct mesh_io_api *io_api(enum mesh_io_type type)
 {
@@ -183,6 +187,9 @@ bool mesh_io_register_recv_cb(struct mesh_io *io, const uint8_t *filter,
 {
 	struct mesh_io_reg *rx_reg;
 
+	if (io == NULL)
+		io = default_io;
+
 	if (io != default_io)
 		return false;
 
@@ -224,6 +231,44 @@ bool mesh_io_deregister_recv_cb(struct mesh_io *io, const uint8_t *filter,
 	return false;
 }
 
+struct loop_data {
+	uint16_t len;
+	uint8_t data[];
+};
+
+static void loop_foreach(void *data, void *user_data)
+{
+	struct mesh_io_reg *rx_reg = data;
+	struct loop_data *rx = user_data;
+
+	if (!memcmp(rx_reg->filter, unprv_filter, sizeof(unprv_filter)))
+		rx_reg->cb(rx_reg->user_data, NULL, rx->data, rx->len);
+}
+
+static void loop_rx(struct l_timeout *timeout, void *user_data)
+{
+	struct loop_data *rx = user_data;
+
+	l_queue_foreach(default_io->rx_regs, loop_foreach, rx);
+	l_timeout_modify_ms(loop_adv_to, 500);
+}
+
+static void loop_destroy(void *user_data)
+{
+	l_debug("Free Looped Unprov Beacon");
+	l_free(user_data);
+}
+
+static void loop_unprv_beacon(const uint8_t *data, uint16_t len)
+{
+	struct loop_data *pkt = l_malloc(len + sizeof(struct loop_data));
+
+	memcpy(pkt->data, data, len);
+	pkt->len = len;
+	l_timeout_remove(loop_adv_to);
+	loop_adv_to = l_timeout_create_ms(500, loop_rx, pkt, loop_destroy);
+}
+
 bool mesh_io_send(struct mesh_io *io, struct mesh_io_send_info *info,
 					const uint8_t *data, uint16_t len)
 {
@@ -233,6 +278,9 @@ bool mesh_io_send(struct mesh_io *io, struct mesh_io_send_info *info,
 	if (!io)
 		io = default_io;
 
+	if (!memcmp(data, unprv_filter, 2))
+		loop_unprv_beacon(data, len);
+
 	if (io && io->api && io->api->send)
 		return io->api->send(io, info, data, len);
 
@@ -248,6 +296,12 @@ bool mesh_io_send_cancel(struct mesh_io *io, const uint8_t *pattern,
 	if (!io)
 		io = default_io;
 
+	if (loop_adv_to && len >= 2 && pattern[0] == MESH_AD_TYPE_BEACON &&
+							pattern[1] == 0) {
+		l_timeout_remove(loop_adv_to);
+		loop_adv_to = NULL;
+	}
+
 	if (io && io->api && io->api->cancel)
 		return io->api->cancel(io, pattern, len);
 
diff --git a/mesh/mesh-mgmt.c b/mesh/mesh-mgmt.c
index d37aeb5ac..fe4ff1b9b 100644
--- a/mesh/mesh-mgmt.c
+++ b/mesh/mesh-mgmt.c
@@ -82,6 +82,8 @@ static void set_exp_mesh_cb(uint8_t status, uint16_t length,
 {
 	int index = L_PTR_TO_UINT(user_data);
 
+	l_debug("Status: %d, Length: %d", status, length);
+
 	mesh_mgmt_send(MGMT_OP_MESH_READ_FEATURES, index, 0, NULL,
 				features_cb, L_UINT_TO_PTR(index), NULL);
 }
diff --git a/mesh/remprv-server.c b/mesh/remprv-server.c
index 85af65dcc..6a9efdd47 100644
--- a/mesh/remprv-server.c
+++ b/mesh/remprv-server.c
@@ -292,13 +292,23 @@ static void scan_pkt(void *user_data, struct mesh_io_recv_info *info,
 {
 	struct rem_scan_data *scan = user_data;
 	uint8_t msg[22 + EXT_LIST_SIZE];
+	uint8_t addr[6];
 	uint16_t i, n;
+	int8_t rssi;
 	uint8_t filled = 0;
 	bool report = false;
 
 	if (scan != rpb_scan)
 		return;
 
+	if (info) {
+		rssi = info->rssi;
+		memcpy(addr, info->addr, 6);
+	} else {
+		rssi = 0;
+		memset(addr, 0, 6);
+	}
+
 	if (scan->ext_cnt)
 		goto extended_scan;
 
@@ -314,16 +324,16 @@ static void scan_pkt(void *user_data, struct mesh_io_recv_info *info,
 		if (!memcmp(&scan->list[n * 17 + 1], data, 16)) {
 
 			/* Repeat UUID, check RSSI */
-			if ((int8_t) scan->list[n * 17] < info->rssi) {
+			if ((int8_t) scan->list[n * 17] < rssi) {
 				report = true;
-				scan->list[n * 17] = (uint8_t) info->rssi;
+				scan->list[n * 17] = (uint8_t) rssi;
 			}
 
 		} else if (!memcmp(&scan->list[n * 17 + 1], zero, 16)) {
 
 			/* Found Empty slot */
 			report = true;
-			scan->list[n * 17] = (uint8_t) info->rssi;
+			scan->list[n * 17] = (uint8_t) rssi;
 			memcpy(&scan->list[n * 17 + 1], data, 16);
 		}
 
@@ -334,7 +344,7 @@ static void scan_pkt(void *user_data, struct mesh_io_recv_info *info,
 		return;
 
 	n = mesh_model_opcode_set(OP_REM_PROV_SCAN_REPORT, msg);
-	msg[n++] = (uint8_t) info->rssi;
+	msg[n++] = (uint8_t) rssi;
 	memcpy(msg + n, data, len);
 	n += len;
 
@@ -356,12 +366,12 @@ extended_scan:
 			return;
 
 		/* Zero AD list if prior data RXed from different bd_addr */
-		if (memcmp(scan->addr, info->addr, 6)) {
+		if (memcmp(scan->addr, addr, 6)) {
 			scan->list[0] = 0;
 			scan->rxed_ads = 0;
 		}
 
-		memcpy(scan->addr, info->addr, 6);
+		memcpy(scan->addr, addr, 6);
 		scan->fltr = true;
 
 		if (len >= 20)
@@ -372,7 +382,7 @@ extended_scan:
 
 
 	} else if (data[0] != BT_AD_MESH_BEACON) {
-		if (!scan->fltr || !memcmp(scan->addr, info->addr, 6)) {
+		if (!scan->fltr || !memcmp(scan->addr, addr, 6)) {
 			i = 0;
 			while (scan->list[i]) {
 				/* check if seen */
-- 
2.39.2

