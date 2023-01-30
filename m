Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0411FC636D3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 23:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjA3Xw3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjA3Xw0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 18:52:26 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A932DE76
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:24 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e6so5142357plg.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6x8iDv3n3QmZU6gO771CCS9s6JsSEmUGZoOr7PVM2w=;
        b=es3KOOw+0kfuY3UZYHPwdn157NDgPKmsfLPY1WySC/dH1AVEwYJ9+sCG9Hv6yZNs+p
         REDuZVhOZVMzb1iGo3gKDwOOj0kC5FqJAiqytpv3vp4qns23lYoTTcReH3jJ08UANcu7
         2nPF4MP7FTGX1rlKjWyNP1qcT+8Wa5pFE9gwI5Qgn/HXN7r978RtMC8oyXsCeRfLprOs
         Ge4n7cH19kG3+8dSUO4+pSvY5ylwUjlAOKca+ZoJRqFwaeFN/4iGxgdl11n6x6pxEsod
         v6+EYGn0+9MkiVD2WVodKF+GayF5WXrIX45mHi5hshKr0n7VDCsS2lUKNPfyFWOBs57j
         gRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6x8iDv3n3QmZU6gO771CCS9s6JsSEmUGZoOr7PVM2w=;
        b=iYEiW9rgi8iNK6VikKj977tlhsa1OWDJgucfYNcq+3SAbF8eiXwnSDRZKVgOcwvTQ/
         cVS/hxRUZR2pfKdg7SqxFSTWTPQVC0Qv/4CCt9U3/MOBGDHACf1rBzr1af/GyCwGIQv4
         L25VNbhDAKKnvTyagCSquJNYThgHvi1FOVSy8Qtzl43FLqUqRBF9XsdQzsjcx3sIZA4F
         FJVFTHvqzZ3B+fafEYRWdxNUWb+nxqzWWcjGu2hP71+HObDwXNVqvzwZqo2M7MXOtTLP
         lV/0aWBg9g5eyXCOEXn9ndM3scxD9awUPBzi3XR12+5mW5UmKolnKVb070jtp1SihXNq
         LnwQ==
X-Gm-Message-State: AO0yUKUNrzb0pzbBN5UkojiYSbOza8jBXAMPh+WPJinvSuqd1XobOmd+
        j4l74bT4GXcBoMXzG/nR2/tWYqBfryYNJA==
X-Google-Smtp-Source: AK7set/bBLnvObADPpqsDMfXuwRZwBaSjqCprJ7E9ktD+PBrk3L1yAz/05XhLtBz/6+rAOQwWN0cQg==
X-Received: by 2002:a05:6a21:99a8:b0:bc:8b91:69a7 with SMTP id ve40-20020a056a2199a800b000bc8b9169a7mr13974720pzb.33.1675122743425;
        Mon, 30 Jan 2023 15:52:23 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm2663948pgd.76.2023.01.30.15.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:52:23 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v5 07/14] mesh: Add Mesh Private Beacon server
Date:   Mon, 30 Jan 2023 15:52:03 -0800
Message-Id: <20230130235210.94385-8-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130235210.94385-1-brian.gix@gmail.com>
References: <20230130235210.94385-1-brian.gix@gmail.com>
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
index 000000000..1e69e7fda
--- /dev/null
+++ b/mesh/prv-beacon.h
@@ -0,0 +1,36 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2023  Intel Corporation. All rights reserved.
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
index 000000000..e712778f8
--- /dev/null
+++ b/mesh/prvbeac-server.c
@@ -0,0 +1,123 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2023  Intel Corporation. All rights reserved.
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
+		/* fall through */
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
+		/* fall through */
+	case OP_PRIVATE_GATT_PROXY_GET:
+		n = mesh_model_opcode_set(OP_PRIVATE_GATT_PROXY_STATUS, msg);
+		msg[n++] = NOT_SUPPORTED;
+		break;
+
+	case OP_PRIVATE_NODE_ID_SET:
+		/* fall through */
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
2.39.1

