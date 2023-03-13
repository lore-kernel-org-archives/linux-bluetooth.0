Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C913DC6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 23:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCMXME (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 19:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCMXMC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 19:12:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6807A7D578
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 16:11:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h8so14675987plf.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 16:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678749116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSJ5IFBTCyMHhXVWZQpJVazwGAUGCJIjW7DbCc0qKOg=;
        b=QkNiLqPROWexmORbY+4U/Db8RFfvq2F+5ktU8dWs400K7QeABvqpwgh03k4FHt4TV7
         JXfACDOTq6J3C9usg/PJ5HDjYCpQaPkPNdC1CmMhB2xeS9v8R5kMBxCeC2PHqR5E+1HW
         Qt+OYoRtYQ6Wj5A4pnEwShDyj7YutWuDWF9CPah4dwSDkjo1GVJ3UMFK5eG6VZvnNtV0
         UBT7PhPbsEl3Lbj3OgwCpuYEudYwCAUwmUY7S3smkqi7JEWwSu8M4rVfWrtjYuCKfJb/
         JRI9wZFW+s3QXtypqL/UTEH6aJu8qJ3Ni3CX6KuQxbxrRTyrxhdTBOMWPRPkU7ZX+9JU
         ZcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678749116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSJ5IFBTCyMHhXVWZQpJVazwGAUGCJIjW7DbCc0qKOg=;
        b=xx+fTa/SSHNgR4T6YoCNyQMGfKxwiCAtp95i5c0C5ZPK3598BW6UPrhpU5pYStj5MJ
         27+t8LTQf264B9QT0kThJQwnNZcaBaXjMF6rgDUiKjfkpEec6aGfubKZZ2WH3GCw5gLN
         XXI94F3WE+BTaESP2sFgyJZ0DmhTWGKeB1ZPgniUEIMBYxvdMRtnGImrm+GNAJKMQirx
         xvOUo7UwQuwMlJwnD3IHTBhJNPV2nED2VP5+bD2IBqqpfh6BUYl4jLavj0lgm3MNjyVp
         V/BXexuC4RbmOD5kROK9A5Pe9Le+4AVvxaEpZzEz0zEZLBu3XygY3QeSPuFEenMZLxLj
         Hxpw==
X-Gm-Message-State: AO0yUKWAg145uG+8unpl8489OYp+G4iDVRIXYKQXClpG5cdetE2vCGLT
        j16GAz2uqAK0scX24HtfJ0gVhpmo058=
X-Google-Smtp-Source: AK7set/E3vqNblKNeG0x5c3hWulqnHNcoAyHg7EIgqF90b5VY/aMPO3kFifFUKpJdbHmlQwu5gqTTA==
X-Received: by 2002:a17:902:cec1:b0:19a:8866:921f with SMTP id d1-20020a170902cec100b0019a8866921fmr46832045plg.54.1678749116246;
        Mon, 13 Mar 2023 16:11:56 -0700 (PDT)
Received: from zbook.. (97-113-12-200.tukw.qwest.net. [97.113.12.200])
        by smtp.gmail.com with ESMTPSA id kv8-20020a17090328c800b001a04f0ec697sm375350plb.65.2023.03.13.16.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 16:11:55 -0700 (PDT)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, brian.gix@gmail.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v3 2/2] mesh: Loopback unprovisioned beacons
Date:   Mon, 13 Mar 2023 16:11:52 -0700
Message-Id: <20230313231152.59147-2-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313231152.59147-1-brian.gix@gmail.com>
References: <20230313231152.59147-1-brian.gix@gmail.com>
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
 mesh/mesh-io.c       | 52 ++++++++++++++++++++++++++++++++++++++++++++
 mesh/remprv-server.c | 24 ++++++++++++++------
 2 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 233f4b328..3e68dc090 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -35,6 +35,11 @@ struct mesh_io_reg {
 	uint8_t filter[];
 } packed;
 
+struct loop_data {
+	uint16_t len;
+	uint8_t data[];
+};
+
 /* List of Supported Mesh-IO Types */
 static const struct mesh_io_table table[] = {
 	{MESH_IO_TYPE_MGMT,	&mesh_io_mgmt},
@@ -42,7 +47,10 @@ static const struct mesh_io_table table[] = {
 	{MESH_IO_TYPE_UNIT_TEST, &mesh_io_unit},
 };
 
+static const uint8_t unprv_filter[] = { MESH_AD_TYPE_BEACON, 0 };
+
 static struct mesh_io *default_io;
+static struct l_timeout *loop_adv_to;
 
 static const struct mesh_io_api *io_api(enum mesh_io_type type)
 {
@@ -183,6 +191,9 @@ bool mesh_io_register_recv_cb(struct mesh_io *io, const uint8_t *filter,
 {
 	struct mesh_io_reg *rx_reg;
 
+	if (io == NULL)
+		io = default_io;
+
 	if (io != default_io)
 		return false;
 
@@ -224,6 +235,38 @@ bool mesh_io_deregister_recv_cb(struct mesh_io *io, const uint8_t *filter,
 	return false;
 }
 
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
@@ -233,6 +276,10 @@ bool mesh_io_send(struct mesh_io *io, struct mesh_io_send_info *info,
 	if (!io)
 		io = default_io;
 
+	/* Loop unprovisioned beacons for local clients */
+	if (!memcmp(data, unprv_filter, sizeof(unprv_filter)))
+		loop_unprv_beacon(data, len);
+
 	if (io && io->api && io->api->send)
 		return io->api->send(io, info, data, len);
 
@@ -248,6 +295,11 @@ bool mesh_io_send_cancel(struct mesh_io *io, const uint8_t *pattern,
 	if (!io)
 		io = default_io;
 
+	if (loop_adv_to && len >= 2 && !memcmp(pattern, unprv_filter, 2)) {
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

