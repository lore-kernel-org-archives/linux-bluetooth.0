Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DDBC678D4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 23:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjASX6V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjASX6R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Jan 2023 18:58:17 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB924A1002
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:11 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m3-20020a17090a414300b00229ef93c5b0so2668230pjg.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7W3LfSBf/mkUWkLjn16mRREFx2jOwVQCLxQxqg0jyw=;
        b=K1V/CbESG7ZxfMtzFUjcfkJYIjkLZ2x2SVTO/NWauiWF7IPH95BMxS4mgIkmzILEiX
         NikAfjmNv7m/v64Po37lVykROgOTufj1Yy89JgADRiMjsrXQ+Pa8aox/yWb7rDr5ZkJG
         vr13VsFYctbtN9qvcgU4xfnZH/wHIGOAFA8R9d6++LXbVPtlUy2SgsrtpRBR5KcwhA6i
         IPiXAtQCVsZkpO9RWMn7wwUKP3I8WP0DtiJH1tR5YbAinsJFYx5hD5UxNmCVTAPnRsgc
         dD0r9H7ferKCoyzsj1C6mrOtGXUTqvVnkiMPQbgs3sBJXXl9QW5hrKDxMKANGzlNMNbY
         mkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7W3LfSBf/mkUWkLjn16mRREFx2jOwVQCLxQxqg0jyw=;
        b=WYa6oPclIzevGLYP5dATaw3YEyHnCOGdXtDFGOcqjD9fLEoCGaG1SXSIU4NTQEfoRc
         PzhQTKaUfMWYE96OnE3GImlBrFDD9bWdhvaJDEm5yPN1Wp09QsmUDH7WwODcJAtmo/C3
         eySwYajK4BRE8Qvu8KoX01PHoSDprcTayYf59WZ8qMHYGiTIYKyfaj6EXqQVmqf7URea
         utT9a7q0YCn3QB5Tv+Yrqmuv5zjA1D2aTbwyqj3pVenC5ZlcJAumAwbXaWnQqKSEy8kT
         SjMjwlJX8WrfAK0qsH0LsRlXym2Hvs3FpNZu4wrKEvpfkwTP4LVCWFhhDPfQwWbFST8+
         7plA==
X-Gm-Message-State: AFqh2kphr5gMLASisyuyqqn51EiQl8LQ8wQyJJjbbbF8BnnLXxkdMbO4
        jzmYULahQBvkwQ79CnA++o5aB17vwAthcw==
X-Google-Smtp-Source: AMrXdXuVpbe8mJxO1Rid7J7IsA8HCF5a7r0fF/jMOlYK773IWGRca9tnjM3IIzrT1lAb3kcyiOcP2A==
X-Received: by 2002:a17:903:32c8:b0:194:de51:9af with SMTP id i8-20020a17090332c800b00194de5109afmr1729566plr.22.1674172690538;
        Thu, 19 Jan 2023 15:58:10 -0800 (PST)
Received: from fedora.. (97-113-173-242.tukw.qwest.net. [97.113.173.242])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b0019460c34839sm14826373plc.185.2023.01.19.15.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:09 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 07/12] mesh: Add Mesh Private Beacon server
Date:   Thu, 19 Jan 2023 15:57:50 -0800
Message-Id: <20230119235755.46002-8-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235755.46002-1-brian.gix@gmail.com>
References: <20230119235755.46002-1-brian.gix@gmail.com>
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
index 000000000..4d33f2823
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
+		/* Fall Through */
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
+		/* Fall Through */
+	case OP_PRIVATE_GATT_PROXY_GET:
+		n = mesh_model_opcode_set(OP_PRIVATE_GATT_PROXY_STATUS, msg);
+		msg[n++] = NOT_SUPPORTED;
+		break;
+
+	case OP_PRIVATE_NODE_ID_SET:
+		/* Fall Through */
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

