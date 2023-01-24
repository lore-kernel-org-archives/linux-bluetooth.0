Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208AEC61D97
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 20:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjAXU0w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjAXU0h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 15:26:37 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6280F4F368
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso15189289pjf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1a3aYIMG+q2Z8SGiFbGIaEZYG93dx1y1tHc6w6IZngM=;
        b=JBGxsSgvQYY7CWgP4HPbhxpri6Ai8IKiS4Cer9ymlosH0xmez/jszX/9E4xtJSLOnc
         ThOCmSd2QfWkf+3TF9DL4zqOD/MO3W0xPjq6pbXyX8snFQRy7iq8le1lZ+yCKXMF0xnI
         4rZMhIHo4wJi/V0b8T6nL/54EtZHg/t7FaN1DoHby8z+XrcyKYPJ3cSzo5kg3Ta/MunE
         O5g5LG+uMRkYeJO824HgrzjU6j/WyjUiSGrBXRGFvzbEI753qbJ7vOkpY0ATYntaO0qQ
         rM5rvLN3ZTMhmla0Q3Ba0PIwft9B/O9mMxpc14bv5BfKEpJjx42oLzMpISgB8Tze2h59
         CsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1a3aYIMG+q2Z8SGiFbGIaEZYG93dx1y1tHc6w6IZngM=;
        b=wrrG+8FUA6FUx5SrpM6/T0aGlGXGR4sdBvDVEvL41vrHu/OWRMolJDwa8x9aDIbhHZ
         TYznXTzrcdMcJ8DjwdbQh9iUgWZ+nVC3SZ1cgPTGnR7xGBD7ZSsx/SiSBnsix2tPYYYp
         NcRazjpS02ni5uvmsTJRFa1FzvQDCJzotNxH89bBS8cXLdWShJ6Zgj/TpaV6aOT3ib65
         fwK6HfAPO2e7GDJLd+slFKQKJ/mxJ8dKu9AGwfyHlDD+oiJrvKEN4x+7w0h3Y0TUiLXY
         FdVJiM9Y8W6nPC4bMFASnPWul6vnR4D2oV7ClysyKiqFH75aXN6hFAUbfz8KTSEfCr6L
         IVzQ==
X-Gm-Message-State: AFqh2kqk1S4kitIp32K50/GqRdJdVTJxdruLt6DI9HV4DpVxZwXzU1D2
        WHxSoe7RFxArHSDlSXdvgU8K1ZvNDQLBYA==
X-Google-Smtp-Source: AMrXdXs1dz0Aawvqy27qsxZRTPSITDDvBkz25wn9vu48jcHkAx0XboWh/6CqRGAzaMDBPoGQgc8V2g==
X-Received: by 2002:a17:903:1355:b0:194:4339:112e with SMTP id jl21-20020a170903135500b001944339112emr26821925plb.60.1674591987233;
        Tue, 24 Jan 2023 12:26:27 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id ju21-20020a170903429500b0019600b78487sm2108099plb.33.2023.01.24.12.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:26:26 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v4 07/13] mesh: Add Mesh Private Beacon server
Date:   Tue, 24 Jan 2023 12:26:10 -0800
Message-Id: <20230124202616.310544-8-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124202616.310544-1-brian.gix@gmail.com>
References: <20230124202616.310544-1-brian.gix@gmail.com>
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
index 000000000..78ab94eb3
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

