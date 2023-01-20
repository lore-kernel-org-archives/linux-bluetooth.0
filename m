Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA07EC38159
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Jan 2023 19:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjATTrs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Jan 2023 14:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjATTrp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Jan 2023 14:47:45 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047C79514D
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jan 2023 11:47:44 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z20so4265557plc.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jan 2023 11:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzdfakTuAPx7tVH2yr/EkD8r7k/ihvRVL2xTJJZbWko=;
        b=HTI6w9JC2Gl7CdDz5IL5RA0FrEVIg1It1Bwj4hvp+T8oawyndH4DtCMwpNK9OW+B5b
         9UsxvdAA76GByxO3DORpuYUDTxDpoK+1Nd74MqE1s8FP03I09yCI86W6al1+JDOmnG7Z
         DoRlKHACvo20aTas+jekDKySs/wl2u/gl2IcJkeGVJh8bCS8enaKiob400HBPKPe5t5R
         HT5AO1S3oQWd2rIdW+v+F/iCGc9kaFObchSppxkbf1r0IXTU+7d9vK3XM5f00/Cpzu48
         W0OAO/kRWLK5vUXji5FRVJK+ymkyd5IXDF9/ILYNpFqwS45PetRZhTvAltEPVRgDb7nW
         g9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzdfakTuAPx7tVH2yr/EkD8r7k/ihvRVL2xTJJZbWko=;
        b=0zsSBOmNI3rjf6UPbcmJWxD10pF82uSGzDf5b0xzCxg981UEqo1LUjIdqdEElOLfbJ
         4+0MDf0gaXYqL9crNem8N67lEkdxK/dLSlJXOr0bk029xgBc6pVnaBpqgdRw7rDudZ1L
         S26ZaHCVOwLSpochBCwsm9oS2gEuDnWp+ObXDLcrb1CGy/rLFAV5by0y1hNZSIdlGhv/
         GNKKJjDfRBtyobXAHOzau9+pkmp+w0C5dX4ngZXyfn8X9XhIkj6W9xGA6UK1QRnJL7U3
         Cmqbw8RmZnVcZzSyHxOrc1sV/7nKrpcEG/R846ZposZLYIfuqjwnowwQbxRvvatThRag
         OQFg==
X-Gm-Message-State: AFqh2kryveGEpGbpW5vweHAv0g3Ri1ZVY9qkr+AK+a7qsNCQYl++x5xP
        8Gf7aLU3L4H+JWMO25omsLcGQnRHxn5dwg==
X-Google-Smtp-Source: AMrXdXs9D3Dn2Hi7zEddk/uLzY1LXAiHRCI9NhaCYJOtuZ9tThZNRVSHaaeZPZw4UoPXeSJxbi8vLg==
X-Received: by 2002:a17:903:185:b0:194:dd86:587f with SMTP id z5-20020a170903018500b00194dd86587fmr6335362plg.54.1674244063023;
        Fri, 20 Jan 2023 11:47:43 -0800 (PST)
Received: from fedora.. (174-21-24-126.tukw.qwest.net. [174.21.24.126])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b001896af10ca7sm5149967plg.134.2023.01.20.11.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:47:42 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v2 07/11] mesh: Add Mesh Private Beacon server
Date:   Fri, 20 Jan 2023 11:47:27 -0800
Message-Id: <20230120194731.90065-8-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120194731.90065-1-brian.gix@gmail.com>
References: <20230120194731.90065-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

This initial server supports only the Mesh Private Beacon and returns
"Not Suppoerted" for Get/Set of Private GATT Proxy and Private Node
Identity beacons.
---
 Makefile.mesh         |   1 +
 mesh/prv-beacon.h     |  36 +++++++++++++
 mesh/prvbeac-server.c | 123 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 mesh/prv-beacon.h
 create mode 100644 mesh/prvbeac-server.c

diff --git a/Makefile.mesh b/Makefile.mesh
index e18a169eb..63f085de1 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -36,6 +36,7 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/pb-adv.h mesh/pb-adv.c \
 				mesh/keyring.h mesh/keyring.c \
 				mesh/rpl.h mesh/rpl.c \
+				mesh/prv-beacon.h mesh/prvbeac-server.c \
 				mesh/mesh-defs.h
 pkglibexec_PROGRAMS += mesh/bluetooth-meshd
 
diff --git a/mesh/prv-beacon.h b/mesh/prv-beacon.h
new file mode 100644
index 000000000..7be7a01c8
--- /dev/null
+++ b/mesh/prv-beacon.h
@@ -0,0 +1,36 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+struct mesh_node;
+
+#define PRV_BEACON_SRV_MODEL	SET_ID(SIG_VENDOR, 0x0008)
+#define PRV_BEACON_CLI_MODEL	SET_ID(SIG_VENDOR, 0x0009)
+
+/* Private Beacon opcodes */
+#define OP_PRIVATE_BEACON_GET			0x8060
+#define OP_PRIVATE_BEACON_SET			0x8061
+#define OP_PRIVATE_BEACON_STATUS		0x8062
+#define OP_PRIVATE_GATT_PROXY_GET		0x8063
+#define OP_PRIVATE_GATT_PROXY_SET		0x8064
+#define OP_PRIVATE_GATT_PROXY_STATUS		0x8065
+#define OP_PRIVATE_NODE_ID_GET			0x8066
+#define OP_PRIVATE_NODE_ID_SET			0x8067
+#define OP_PRIVATE_NODE_ID_STATUS		0x8068
+
+void prv_beacon_server_init(struct mesh_node *node, uint8_t ele_idx);
diff --git a/mesh/prvbeac-server.c b/mesh/prvbeac-server.c
new file mode 100644
index 000000000..9e70ba2b6
--- /dev/null
+++ b/mesh/prvbeac-server.c
@@ -0,0 +1,123 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <sys/time.h>
+#include <ell/ell.h>
+
+#include "mesh/mesh-defs.h"
+#include "mesh/node.h"
+#include "mesh/net.h"
+#include "mesh/appkey.h"
+#include "mesh/model.h"
+#include "mesh/mesh-config.h"
+#include "mesh/prv-beacon.h"
+
+#define NOT_SUPPORTED 0x02
+
+static bool prvbec_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
+				uint16_t net_idx, const uint8_t *data,
+				uint16_t size, const void *user_data)
+{
+	struct mesh_node *node = (struct mesh_node *) user_data;
+	const uint8_t *pkt = data;
+	uint32_t opcode;
+	uint8_t msg[5];
+	uint16_t n;
+	uint8_t period = 0;
+
+	if (app_idx != APP_IDX_DEV_LOCAL)
+		return false;
+
+	if (mesh_model_opcode_get(pkt, size, &opcode, &n)) {
+		size -= n;
+		pkt += n;
+	} else
+		return false;
+
+	l_debug("PRV-BEAC-SRV-opcode 0x%x size %u idx %3.3x", opcode, size,
+								net_idx);
+
+	n = 0;
+
+	switch (opcode) {
+	default:
+		return false;
+
+	case OP_PRIVATE_BEACON_SET:
+		if (size == 1)
+			period = 0xff;
+		else if (size == 2)
+			period = pkt[1];
+		else
+			return true;
+
+		/* Fallthrough */
+
+	case OP_PRIVATE_BEACON_GET:
+		n = mesh_model_opcode_set(OP_PRIVATE_BEACON_STATUS, msg);
+
+		msg[n++] = NOT_SUPPORTED;
+		msg[n++] = period;
+
+		l_debug("Get/Set Private Beacon (%d)", msg[n-2]);
+		break;
+
+	case OP_PRIVATE_GATT_PROXY_SET:
+		/* Fallthrough */
+	case OP_PRIVATE_GATT_PROXY_GET:
+		n = mesh_model_opcode_set(OP_PRIVATE_GATT_PROXY_STATUS, msg);
+		msg[n++] = NOT_SUPPORTED;
+		break;
+
+	case OP_PRIVATE_NODE_ID_SET:
+		/* Fallthrough */
+	case OP_PRIVATE_NODE_ID_GET:
+		n = mesh_model_opcode_set(OP_PRIVATE_NODE_ID_STATUS, msg);
+		msg[n++] = NOT_SUPPORTED;
+		break;
+	}
+
+	if (n)
+		mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx,
+						DEFAULT_TTL, false, n, msg);
+
+	return true;
+}
+
+static void prvbec_srv_unregister(void *user_data)
+{
+}
+
+static const struct mesh_model_ops ops = {
+	.unregister = prvbec_srv_unregister,
+	.recv = prvbec_srv_pkt,
+	.bind = NULL,
+	.sub = NULL,
+	.pub = NULL
+};
+
+void prv_beacon_server_init(struct mesh_node *node, uint8_t ele_idx)
+{
+	l_debug("%2.2x", ele_idx);
+	mesh_model_register(node, ele_idx, PRV_BEACON_SRV_MODEL, &ops, node);
+}
-- 
2.39.0

