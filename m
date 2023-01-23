Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6E9C25B50
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Jan 2023 19:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjAWTtN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Jan 2023 14:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjAWTtB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Jan 2023 14:49:01 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC1836441
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 11:48:49 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b10so12704286pjo.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 11:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdkWNN5xfRheWct+35hGqDUCaKNywAbxYOWcT27fHGI=;
        b=dj2WadGETafdgES+YRGK1lxQJOFQPsoLBrnnFBJeLJ4K7XA0Bs4LzBlxjshVIX5ro8
         OgKyjvs48WySEULw5DqfjbcDCbl07+d7akfXa318wLA49NWY9nw49S6gGrwLNNlNA1Sw
         rCCB5tJTAu+9AECUQdOU7s2DnF5GdTGvDwzdBlbT/iRVNsQdnGujVQJxVo4tGMTIaYMj
         LvnAqj4K2RajLr7VeO2r0SA3W3CJ3NtBgGfFlcNpJ5aqnPzKm9mhXMnpArAUZtQDX2r7
         8pqRiVVdjRG8U5/yCMX2aIb7DNewZXpjMJmx3GE+zFQOxHxN9piRdjewemSe0ssfk+ZD
         dy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdkWNN5xfRheWct+35hGqDUCaKNywAbxYOWcT27fHGI=;
        b=xX6rZLhJ256Dt4yMeJF06oVRCmTj6cR4MFwVoVLXDZ0Bw8CzhrAtEmz3knTqtACTq1
         bpvFhNvL1NLAv1OCeq3XpIAUrzXswaXqLn7/L8h9naZ6ZJhNWYBWX+pDK7SaZs01mubj
         l6G89ikY1hRYgwmhkJVLdhcZvF6/8n8S+E6jUQwZzLWvplVEa9AqDAY/ypnWRa7oPlaq
         9K+gfRmHD+1GyvCaW7pKzkTTrNeLyrLxCkdxBv+Hk06dgDjCx+l5DLcwmtQfC83v/VjH
         jIHiUN6Lze9NxF0+fdCAtT5UhZl1IKRmuYjg1Og5Pcm/m/dhKHvA2TAy6nrI94fkzzcR
         m2/g==
X-Gm-Message-State: AFqh2krYiHYdQfZ9dUGj5Te5ZR1QO37+/i4wDSA4/Y8/BP9l34KkWLTt
        L8jIC678OhEpQiVWlNkD9Xl2/lJZ54piyQ==
X-Google-Smtp-Source: AMrXdXuzDhrPkZ/rYd2LFpT1vJQEOZjKJDbxOnZF5Zank18inzcN+ta0DDHbcBhOP6yoz05tfzGhew==
X-Received: by 2002:a17:902:c1d2:b0:194:708f:6483 with SMTP id c18-20020a170902c1d200b00194708f6483mr26535759plc.57.1674503328861;
        Mon, 23 Jan 2023 11:48:48 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id jj5-20020a170903048500b0017d97d13b18sm97068plb.65.2023.01.23.11.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 11:48:48 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com
Subject: [PATCH BlueZ v3 07/11] mesh: Add Mesh Private Beacon server
Date:   Mon, 23 Jan 2023 11:48:20 -0800
Message-Id: <20230123194824.257351-8-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123194824.257351-1-brian.gix@gmail.com>
References: <20230123194824.257351-1-brian.gix@gmail.com>
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
index 000000000..f3a6eaa82
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
+		/* fallthrough */
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
+		/* fallthrough */
+	case OP_PRIVATE_GATT_PROXY_GET:
+		n = mesh_model_opcode_set(OP_PRIVATE_GATT_PROXY_STATUS, msg);
+		msg[n++] = NOT_SUPPORTED;
+		break;
+
+	case OP_PRIVATE_NODE_ID_SET:
+		/* fallthrough */
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

