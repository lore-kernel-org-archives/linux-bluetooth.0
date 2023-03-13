Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260A8C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 20:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCMUBq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 16:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjCMUB1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 16:01:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DA389F39
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 13:00:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p6so14300783plf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678737652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MVNLeBvAvSzlm3VdrDn1usvmGJZ6oO2XlMGOfduWrM=;
        b=E0O4NJuswJk4d/vI13vRe1Uv5UStVLwpn3UmJDVgPlByG9zN7DQ4NFj1DoOzE5EzEW
         3CfEgP470HOJtYnjWuWX9nTZkDLlUNMcnmwpaayPeiD+Isa4NlRMpI2xQb5S3p+srd21
         SWepzrj6iU4WwsJsRk3GdJikclMIEkJ8tndUEGKaPKSanGeCz8HGZcSZGHu5nWvDaYYw
         r44NyfnBX9k+nXrH+PxyCa8hvHbEjIpkGfX/l6rW4ZELyQSMahzraSsJNSPAYjcg0TNT
         xn6Xd9EU+qIaAD1X06i/ElEp/Zmwn+siZCTHs1vZyh4xQuanoaQRrGmhdvprV1Bm/G/w
         L7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MVNLeBvAvSzlm3VdrDn1usvmGJZ6oO2XlMGOfduWrM=;
        b=aKWKOgXIQhZCAWyE3V/XwXPCJKAx5j3Wg7YfB23gYioksjL46BFarxzxyKG/Zkaibj
         s0U75G2zkbQnIGxy093s1WfDXNsaED+6K87Un7Z2He5eqiYA96uj0+rlklz0vqkGuyh3
         IjXz4S7ebcPVUzK1eAij4Yob/SHbHxr3POP0yaJYBMH8W4QvbdHN4SqQZSIzhasFaiIA
         1dtKYOEm2vd+j4bGmG1W9K+LJLXbkk4NudeVmrSGv5kFobmkdaqSXS4hET4e5koAKu6/
         yFDc2ZOa6o9h9xg3h8Gj7/WoqUYSFUtHkONumgJ6g4vhaNkUFYAgnQzKTe243OgpAJuH
         N+Kg==
X-Gm-Message-State: AO0yUKVKzKr1JjrCRmbHMg79biMlFJtJwbB/nVtaJ4LQsFRpDzjre3Lm
        ojbgOIr7lthqwJT9V25mNxk28R17dAY=
X-Google-Smtp-Source: AK7set8n9xChrNnz8jFYrVaGWp5JVBFGkM4P3SM1aj7/SgQC2xAAp6vMnqUFTzSYolG6ahvPn6OKwA==
X-Received: by 2002:a17:902:d4cf:b0:19e:500b:517a with SMTP id o15-20020a170902d4cf00b0019e500b517amr41787601plg.69.1678737652480;
        Mon, 13 Mar 2023 13:00:52 -0700 (PDT)
Received: from zbook.. (97-113-12-200.tukw.qwest.net. [97.113.12.200])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b0019fcece6847sm227519plb.227.2023.03.13.13.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:00:52 -0700 (PDT)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, brian.gix@gmail.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v2 2/2] mesh: Loopback unprovisioned beacons
Date:   Mon, 13 Mar 2023 13:00:48 -0700
Message-Id: <20230313200048.50855-2-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313200048.50855-1-brian.gix@gmail.com>
References: <20230313200048.50855-1-brian.gix@gmail.com>
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
 mesh/remprv-server.c | 24 ++++++++++++++------
 2 files changed, 71 insertions(+), 7 deletions(-)

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

