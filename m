Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39AD1B0F0A
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381309; cv=fail; b=RXJLClC5qy5T0SL+4qf4Ba8YZYlOOu0ibDL2NVzVBohWwSiH5wzUNjf7xOex46JqpV+/VPz56NXIRfDfvTAZ2ge1u8kqkE1Vcar3dR9YXsUwQFJsDViMB7+j02Hk+Snef8PalNGxhpHB+7ddnqYHREn29KTcvamGU2Wic0sO224=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381309; c=relaxed/simple;
	bh=j/4L+l3HUJ/+ffHJ/Z05jFIECZs75SSNk+pSbqTgxTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6caqrXkhs+JYk+kRch4XfpO3qiX7CvuN4VbNyIT3NiOK1qZXCQtTJAoC8bs8HIylCCpuIFrvhJSqQqj67wzdOGbpuep8aMox2vYknAOUsLxZ5lGm0mYFfKBFg9F3h6UaxSjT04MoSnKMgTY8NBM36qhOf2632wuRA/Co3JnxLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=OE59Oe2K; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="OE59Oe2K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StvQm4pZjkdpMmesJmPqiWevsmb+jq2Dy0XEmt7TU7YFaZrXO2XUTcTTe3w1dqV5WQTznRrDWeNHEOqCHKWheJ0+3oRDL2l1IRsGFZz7W+mJb1Wu5C2z8++1zhTMI3KpH2Run9t08z8n749usG18MYZ1tLjud9rZkKKejLJeO+yrlmJz92FjxWi5YIwcvnOWhQPwjw2lwJd2cRpdr9p9AdcTgHC2Nu0Wrk31karfATj/vn2sheCy3/gsXpl1oIPknlSLpsZsCj8yJihlLIcHUVL8FLSPYPD/Q4wvi+SZVhl3dxD6fD9QWUd2Ln44m8E8HFCQvOiR/A43Slhv40GgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgn9b61VfVVlYwdRzqcLDAcCGEEUMFEFCnK2fqXRtjE=;
 b=X/Tyuv2a2s+k0/W8P2Vd5VxrnIZPcXavvROphil38SRxFE1vfSj2EmFSOGBFrjtIrAEqWSJfokBGaUJZ4t6qIj34swbez/xnwb5WKqGPsWVrH1t7TCqOQQZh1BSG8T5cKhqFxxh6gM3Bug8pPbxyJyQUPQYmNA9jUhAODPS2mEA7U958MxIabd8JCh4uDE9D+cXeDg83E2ju8S9V7y+FY3O5BGeb04hM07BxWq1texoKYWpjte21I/1unpo/uhGRlT3lqAXFgiX4pJXdPqKMFnEXKGgNf9WnYgjFm8s+RQBCpMINw9tFCpI/Up876F0LhYfY0rekOdeXBYM2Hp+COA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgn9b61VfVVlYwdRzqcLDAcCGEEUMFEFCnK2fqXRtjE=;
 b=OE59Oe2KGGUUs/mSrZoAS3N+JPyJsyImeLHf05PnWGRrLHLj5l4+wgj08KLxRbFcqGFgbw2u/xyPYzmIl1l1tR1r3R3iqSIWHpyJYFlNp08S8ym/wh95rTGiKBTwFxWWlWSp+ve9ie+KWKzxUrjK2y+aOD/WHJcHn9krnVVXK64=
Received: from AS4P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::17)
 by DU6PR03MB10965.eurprd03.prod.outlook.com (2603:10a6:10:5c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 1 Jul
 2025 14:48:20 +0000
Received: from AMS0EPF000001AD.eurprd05.prod.outlook.com
 (2603:10a6:20b:5de:cafe::f2) by AS4P190CA0005.outlook.office365.com
 (2603:10a6:20b:5de::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Tue,
 1 Jul 2025 14:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001AD.mail.protection.outlook.com (10.167.16.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 14:48:20 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 1 Jul
 2025 16:48:19 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	Christian Eggers <ceggers@arri.de>
Subject: [RFC PATCH BlueZ 3/4] mesh: add GATT proxy service
Date: Tue, 1 Jul 2025 16:22:23 +0200
Message-ID: <20250701144647.19572-6-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701144647.19572-2-ceggers@arri.de>
References: <20250701144647.19572-2-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AD:EE_|DU6PR03MB10965:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c5ccf3-2186-4bb1-69d5-08ddb8ae5271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m1HCjl5AXj1MQ0qhKZqZUc/q+zWENq1ONWUINgmZxXvV4cxVxO/v7o1pOcWB?=
 =?us-ascii?Q?cb+Q7OS4dX5mxTE3mW2s9PKJDczq/Fcjz/5g/zn0yZznoXNr1rU/AAaqlK1k?=
 =?us-ascii?Q?ti/PaZvLxdD4Z/+tQVNa2Eo/7nObSuXMsqfu2kScOY3Yr/W5ejh9STxiuamG?=
 =?us-ascii?Q?QyTEJmLivrqDJyaJLHJvtJca0qg/CMOOkJvfaqb1hiAUuPmTocntlNBC2erc?=
 =?us-ascii?Q?a2pSE1nldGT8ru7p5cDz4pd5YFZDMtV1WrJ4ugSnaEe9b6pBok6sE+IG0S7l?=
 =?us-ascii?Q?6n8yybF31quwJo3PUC4inqnJua57CyNMRZZ6+lLzx0jY/jkdNDWQfqWvnTQ+?=
 =?us-ascii?Q?FxJqB8YCmWj0T+kESHmFdKtEoTtMpaJNNBFXNdsTB0+fnIoSXT1eWlwhGnnO?=
 =?us-ascii?Q?lRNQppZ6bF+z+fgADsv7NCEbJHQeyR5ht7Sun4f7fBRvuJMxXPw9pwXgPzmn?=
 =?us-ascii?Q?VovZO0JudB4loN5RlvfUVWcQxfwzgAy0zberBBkygw1uRMAXqgzkUmtepip9?=
 =?us-ascii?Q?M6WlmYYv3ExpgxskpaDesORkIXLIk1ODN9d72xO3h1jmxpBJ5FK3KpSmlSz9?=
 =?us-ascii?Q?2jyxxt+pGNNZFQGft3I3OhE9CuY13eGTf1pwn03+cgLUxUJmIoGplSeXOc7B?=
 =?us-ascii?Q?GyQscudd4uySpRy7uBscJIac13zN1Y0T5YlwKp8U+q0/a1vTFrQYkD8B7jv0?=
 =?us-ascii?Q?2J6nfyxn2r6qtEV3UW9weIayFMsTfgG8L5UVeZvvFKNAqAfFz1D920k0sNgO?=
 =?us-ascii?Q?P1hzBnC7q8SNNy4wpd+nQlzRCc99bpR4hkpwz+1qJL/X0hWydjYLnW4CShdp?=
 =?us-ascii?Q?b4eEqtm6casqdlGEUT6Es2L1VJHrO7qYAXeNu/MZ6SI0IlHqpuwi5bT3cGG0?=
 =?us-ascii?Q?pxfND5gs2SfCE6NLjR7dO/nijJCwK7oOgv8ltLhbafMJ/J+TuhmxYgVXRu6J?=
 =?us-ascii?Q?PDfeQpt/HdUW/XU1V63+FEO7Pz8V1+taMJUEatKIkdOjq3WuFFsJqoA+CIEO?=
 =?us-ascii?Q?lZiPdxejUKL/6kpHK97f/LC2XDZTCl1+os2eOG3E2a4FcvBpbn5bjjfub0cZ?=
 =?us-ascii?Q?XvQEglNfuT6vwaw8pzxdd4aN33k/i30dxdusu2R9jhFNRV5ecsqBqJuqJ8P8?=
 =?us-ascii?Q?KY++5LXCfi+RT/6a7vzdH4cwPPUXTnTZNMnsdhHzBnpmEGy4faXAdy17hVW4?=
 =?us-ascii?Q?ChlwIvqYuJWd9D/1ePNBw+P60ZOUlqLGD0WMyf7F2klNTLS5snLM32hIQdW5?=
 =?us-ascii?Q?YDUjCI2IWh21p/cJzE3ORYyO1/MGyJJCkEEH8Dx1mLHexMSwb7Nhik4siSkD?=
 =?us-ascii?Q?1lYKFkYksmV2QM+dpfwhtuyVg3/ZJuKN6jskzTgomGJz+EzvvKsErTl8kxGD?=
 =?us-ascii?Q?56uubosHZPfHG/Kz+FCeghQ1ZQcsZAGdFq9xBgn+o6zYQobmCJZwtZ3IP7JV?=
 =?us-ascii?Q?3Y1fEsGmYLL9bI/wkPYArmQja8TwLLuIaxu1/16B5Q+9QbpjFERbE5q3Y4cB?=
 =?us-ascii?Q?XFRRfIKQwK61RItYMe7kYQihckXC2us7jr5B?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:48:20.3073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c5ccf3-2186-4bb1-69d5-08ddb8ae5271
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR03MB10965

FIXME: net.c: determine whether data shall be sent via mesh_io or
gatt_proxy
---
 Makefile.mesh         |   3 +-
 mesh/gatt-proxy-svc.c | 294 ++++++++++++++++++++++++++++++++++++++++++
 mesh/gatt-proxy-svc.h |  29 +++++
 mesh/main.c           |   3 +
 mesh/net-keys.c       |  61 +++++++++
 mesh/net-keys.h       |   4 +
 mesh/net.c            |  21 ++-
 mesh/net.h            |   4 +
 mesh/prov-acceptor.c  |  26 +++-
 9 files changed, 440 insertions(+), 5 deletions(-)
 create mode 100644 mesh/gatt-proxy-svc.c
 create mode 100644 mesh/gatt-proxy-svc.h

diff --git a/Makefile.mesh b/Makefile.mesh
index 700d64fe9293..8a190f75de9d 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -40,7 +40,8 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/rpl.h mesh/rpl.c \
 				mesh/prv-beacon.h mesh/prvbeac-server.c \
 				mesh/mesh-defs.h \
-				mesh/gatt-service.h mesh/gatt-service.c
+				mesh/gatt-service.h mesh/gatt-service.c \
+				mesh/gatt-proxy-svc.h mesh/gatt-proxy-svc.c
 pkglibexec_PROGRAMS += mesh/bluetooth-meshd
 
 mesh/mesh.$(OBJEXT): ell/internal
diff --git a/mesh/gatt-proxy-svc.c b/mesh/gatt-proxy-svc.c
new file mode 100644
index 000000000000..e24543de718c
--- /dev/null
+++ b/mesh/gatt-proxy-svc.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025  ARRI Lighting. All rights reserved.
+ *
+ *
+ */
+
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>			// memcpy()
+
+#include <ell/dbus.h>
+#include <ell/queue.h>
+#include <ell/timeout.h>
+#include <ell/util.h>			// ell_new(), l_free(), l_malloc()
+
+#include "mesh/gatt-service.h"
+#include "mesh/mesh-io.h"		// mesh_io_recv_func_t
+#include "mesh/net.h"			// mesh_net_attach_gatt(),
+					// mesh_net_detach_gatt()
+#include "mesh/net-keys.h"		// net_key_fill_adv_service_data(),
+					// net_key_get_next_id()
+#include "mesh/util.h"			// print_packet()
+#include "mesh/gatt-proxy-svc.h"
+
+#define MESH_GATT_PROXY_SVC_UUID "0x1828"
+#define MESH_GATT_PROXY_CHRC_DATA_IN  "0x2ADD"
+#define MESH_GATT_PROXY_CHRC_DATA_OUT "0x2ADE"
+
+#define MAX_PROXY_PDU_LEN 66  /* MshPRT_v1.1, section 7.2.2.2.7 */
+
+struct gatt_io_reg {
+	mesh_io_recv_func_t cb;
+	void *user_data;
+	enum proxy_msg_type msg_type;
+};
+
+struct gatt_proxy_service {
+	struct gatt_service *gatt_service;
+	uint32_t current_adv_key_id;
+	struct l_timeout *adv_key_cycle_to;
+	bool txing;
+	struct l_queue *tx_deferred;
+	struct l_queue *rx_regs;
+};
+
+struct process_data {
+	enum proxy_msg_type msg_type;
+	const uint8_t *data;
+	uint8_t len;
+};
+
+static struct gatt_proxy_service *gatt_proxy_service;
+
+struct tx_deferred {
+	enum proxy_msg_type msg_type;
+	uint16_t len;
+	uint8_t data[];
+};
+
+static struct gatt_io_reg *find_by_filter(struct l_queue *rx_regs,
+						enum proxy_msg_type msg_type)
+{
+	const struct l_queue_entry *entry;
+
+	entry = l_queue_get_entries(rx_regs);
+
+	for (; entry; entry = entry->next) {
+		struct gatt_io_reg *rx_reg = entry->data;
+
+		if (rx_reg->msg_type == msg_type)
+			return rx_reg;
+	}
+
+	return NULL;
+}
+
+void gatt_proxy_service_register_recv_cb(struct gatt_proxy_service *gatt_proxy,
+					enum proxy_msg_type msg_type,
+					mesh_io_recv_func_t cb,
+					void *user_data)
+{
+	struct gatt_io_reg *rx_reg;
+
+	if (gatt_proxy != gatt_proxy_service || !cb)
+		return;
+
+	rx_reg = find_by_filter(gatt_proxy->rx_regs, msg_type);
+
+	l_free(rx_reg);
+	l_queue_remove(gatt_proxy->rx_regs, rx_reg);
+
+	rx_reg = l_malloc(sizeof(struct gatt_io_reg));
+	rx_reg->cb = cb;
+	rx_reg->msg_type = msg_type;
+	rx_reg->user_data = user_data;
+
+	l_queue_push_head(gatt_proxy->rx_regs, rx_reg);
+}
+
+void
+gatt_proxy_service_deregister_recv_cb(struct gatt_proxy_service *gatt_proxy,
+						enum proxy_msg_type msg_type)
+{
+	struct gatt_io_reg *rx_reg;
+
+	if (gatt_proxy != gatt_proxy_service)
+		return;
+
+	rx_reg = find_by_filter(gatt_proxy->rx_regs, msg_type);
+
+	l_queue_remove(gatt_proxy->rx_regs, rx_reg);
+	l_free(rx_reg);
+}
+
+void gatt_proxy_service_send(enum proxy_msg_type msg_type,
+						const void *data, uint8_t len)
+{
+	if (!gatt_proxy_service)
+		return;
+
+	if (!gatt_proxy_service->txing) {
+		gatt_proxy_service->txing = true;
+		gatt_service_tx(gatt_proxy_service->gatt_service, msg_type,
+								data, len);
+	} else {
+		struct tx_deferred *tx_deferred;
+
+//		print_packet("TX-Defer", data, len);
+		tx_deferred = l_malloc(len + sizeof(struct tx_deferred));
+		tx_deferred->msg_type = msg_type;
+		tx_deferred->len = len;
+		memcpy(tx_deferred->data, data, len);
+		l_queue_push_tail(gatt_proxy_service->tx_deferred, tx_deferred);
+	}
+}
+
+static void process_rx_callbacks(void *a, void *b)
+{
+	struct gatt_io_reg *rx_reg = a;
+	struct process_data *rx = b;
+
+	if (rx->msg_type == rx_reg->msg_type)
+		rx_reg->cb(rx_reg->user_data, NULL, rx->data, rx->len);
+}
+
+static void gatt_service_rx(void *user_data, enum proxy_msg_type msg_type,
+						const void *data, uint16_t len)
+{
+	struct gatt_proxy_service *gatt_proxy = user_data;
+	struct process_data rx = {
+		.msg_type = msg_type,
+		.data = data,
+		.len = len,
+	};
+
+	if (gatt_proxy != gatt_proxy_service)
+		return;
+
+	print_packet("RX", data, len);
+	l_queue_foreach(gatt_proxy->rx_regs, process_rx_callbacks, &rx);
+}
+
+static bool gatt_service_tx_cmplt(void *user_data)
+{
+	struct gatt_proxy_service *gatt_proxy = user_data;
+	struct tx_deferred *tx_deferred;
+
+//	l_info("gatt_service_tx_cmplt");
+
+	if (gatt_proxy_service != gatt_proxy)
+		return false;
+
+	if (!gatt_proxy->txing)
+		return false;
+
+	gatt_proxy->txing = false;
+
+	tx_deferred = l_queue_pop_head(gatt_proxy->tx_deferred);
+	if (!tx_deferred)
+		return false;
+
+	gatt_proxy_service_send(tx_deferred->msg_type,
+					tx_deferred->data, tx_deferred->len);
+	l_free(tx_deferred);
+	return true;
+}
+
+static bool gatt_service_fill_adv_service_data(void *user_data,
+					struct l_dbus_message_builder *builder)
+{
+	struct gatt_proxy_service *gatt_service = user_data;
+
+	if (gatt_service != gatt_proxy_service)
+		return false;
+
+	return net_key_fill_adv_service_data(gatt_service->current_adv_key_id,
+								builder);
+}
+
+static void gatt_proxy_service_cycle_adv(struct l_timeout *timeout,
+						void *user_data)
+{
+	struct gatt_proxy_service *gatt_proxy = user_data;
+	uint32_t next_adv_key_id;
+
+	if (gatt_proxy_service != gatt_proxy)
+		return;
+
+	next_adv_key_id = net_key_get_next_id(gatt_proxy->current_adv_key_id);
+	if (!next_adv_key_id)
+		return;
+
+	if (gatt_proxy->current_adv_key_id != next_adv_key_id) {
+		gatt_proxy->current_adv_key_id = next_adv_key_id;
+		gatt_service_adv_updated(gatt_proxy_service->gatt_service);
+	}
+
+	l_timeout_modify(gatt_proxy->adv_key_cycle_to, 3);
+}
+
+void gatt_proxy_service_set_current_adv_key(uint32_t id)
+{
+	if (!gatt_proxy_service)
+		return;
+
+	gatt_proxy_service->current_adv_key_id = id;
+	gatt_service_adv_updated(gatt_proxy_service->gatt_service);
+}
+
+void gatt_proxy_service_start(void)
+{
+	if (!gatt_proxy_service || gatt_proxy_service->gatt_service)
+		return;
+
+	gatt_proxy_service->gatt_service = gatt_service_create(
+					MESH_GATT_PROXY_SVC_UUID,
+					MESH_GATT_PROXY_CHRC_DATA_IN,
+					MESH_GATT_PROXY_CHRC_DATA_OUT,
+					MAX_PROXY_PDU_LEN,
+					NULL, NULL,
+					gatt_service_rx,
+					gatt_service_tx_cmplt,
+					gatt_service_fill_adv_service_data,
+					gatt_proxy_service);
+
+	gatt_proxy_service->adv_key_cycle_to = l_timeout_create(3,
+						gatt_proxy_service_cycle_adv,
+						gatt_proxy_service, NULL);
+
+	mesh_net_attach_gatt(gatt_proxy_service);
+}
+
+void gatt_proxy_service_stop(void)
+{
+	if (!gatt_proxy_service || !gatt_proxy_service->gatt_service)
+		return;
+
+	mesh_net_detach_gatt(gatt_proxy_service);
+	l_timeout_remove(gatt_proxy_service->adv_key_cycle_to);
+	gatt_service_destroy(gatt_proxy_service->gatt_service, NULL, NULL);
+}
+
+void gatt_proxy_service_create(void)
+{
+	if (gatt_proxy_service)
+		return;
+
+	gatt_proxy_service = l_new(struct gatt_proxy_service, 1);
+	gatt_proxy_service->tx_deferred = l_queue_new();
+	gatt_proxy_service->rx_regs = l_queue_new();
+
+	/* Check whether we have at least one key */
+	if (!net_key_get_next_id(0))
+		return;
+
+	gatt_proxy_service_start();
+}
+
+void gatt_proxy_service_destroy(void)
+{
+	if (!gatt_proxy_service)
+		return;
+
+	gatt_proxy_service_stop();
+
+	l_queue_destroy(gatt_proxy_service->rx_regs, l_free);
+	l_queue_destroy(gatt_proxy_service->tx_deferred, l_free);
+	l_free(gatt_proxy_service);
+	gatt_proxy_service = NULL;
+}
diff --git a/mesh/gatt-proxy-svc.h b/mesh/gatt-proxy-svc.h
new file mode 100644
index 000000000000..5c640dc2c8ef
--- /dev/null
+++ b/mesh/gatt-proxy-svc.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025  ARRI Lighting. All rights reserved.
+ *
+ *
+ */
+
+#include <stdint.h>
+
+enum proxy_msg_type;
+struct gatt_proxy_service;
+
+void gatt_proxy_service_create(void);
+void gatt_proxy_service_destroy(void);
+void gatt_proxy_service_start(void);
+void gatt_proxy_service_stop(void);
+void gatt_proxy_service_set_current_adv_key(uint32_t id);
+void gatt_proxy_service_register_recv_cb(struct gatt_proxy_service *gatt_proxy,
+					enum proxy_msg_type msg_type,
+					mesh_io_recv_func_t cb,
+					void *user_data);
+void
+gatt_proxy_service_deregister_recv_cb(struct gatt_proxy_service *gatt_proxy,
+						enum proxy_msg_type msg_type);
+void gatt_proxy_service_send(enum proxy_msg_type msg_type,
+						const void *data, uint8_t len);
diff --git a/mesh/main.c b/mesh/main.c
index 5b8af4bc7345..b423fe70b8bd 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -31,6 +31,7 @@
 #include "mesh/crypto.h"
 #include "mesh/dbus.h"
 #include "mesh/mesh-io.h"
+#include "mesh/gatt-proxy-svc.h"
 #include "mesh/util.h"
 
 static const char *storage_dir;
@@ -94,6 +95,8 @@ static void mesh_ready_callback(void *user_data, bool success)
 		l_error("Failed to initialize mesh D-Bus resources");
 		l_main_quit();
 	}
+
+	gatt_proxy_service_create();
 }
 
 static void request_name_callback(struct l_dbus *dbus, bool success,
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 42d498ce0ede..62ea4208af98 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -20,6 +20,7 @@
 #include "mesh/util.h"
 #include "mesh/crypto.h"
 #include "mesh/mesh-io.h"
+#include "mesh/gatt-proxy-svc.h"
 #include "mesh/net.h"
 #include "mesh/net-keys.h"
 
@@ -29,6 +30,12 @@
 /* This allows daemon to skip decryption on recently seen beacons */
 #define BEACON_CACHE_MAX	10
 
+/* MshPRT_v1.1, section 7.2.2.2.1 */
+#define IDENTIFICATION_TYPE_NETWORK_ID     0x00
+#define IDENTIFICATION_TYPE_NODE_ID        0x01
+#define IDENTIFICATION_TYPE_PRV_NETWORK_ID 0x02
+#define IDENTIFICATION_TYPE_PRV_NODE_ID    0x03
+
 struct beacon_rx {
 	uint8_t data[28];
 	uint32_t id;
@@ -144,6 +151,9 @@ uint32_t net_key_add(const uint8_t flooding[16])
 		goto fail;
 
 	key->id = ++last_flooding_id;
+	if (l_queue_isempty(keys))
+		gatt_proxy_service_start();
+
 	l_queue_push_tail(keys, key);
 	return key->id;
 
@@ -196,6 +206,9 @@ void net_key_unref(uint32_t id)
 			l_timeout_remove(key->observe.timeout);
 			l_queue_remove(keys, key);
 			l_free(key);
+
+			if (l_queue_isempty(keys))
+				gatt_proxy_service_stop();
 		}
 	}
 }
@@ -663,6 +676,7 @@ bool net_key_beacon_refresh(uint32_t id, uint32_t ivi, bool kr, bool ivu,
 			return false;
 
 		print_packet("Set SNB to", key->snb, 23);
+		gatt_proxy_service_set_current_adv_key(key->id);
 	}
 
 	l_debug("Set Beacon: IVI: %8.8x, IVU: %d, KR: %d", ivi, ivu, kr);
@@ -798,3 +812,50 @@ void net_key_cleanup(void)
 	l_queue_destroy(beacons, l_free);
 	beacons = NULL;
 }
+
+bool net_key_fill_adv_service_data(uint32_t id,
+					struct l_dbus_message_builder *builder)
+{
+	uint8_t identification_type = IDENTIFICATION_TYPE_NETWORK_ID;
+	struct net_key *key;
+	int i;
+
+	key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
+	if (!key)
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "y");
+	l_dbus_message_builder_append_basic(builder, 'y', &identification_type);
+
+	for (i = 0; i < sizeof(key->net_id); i++)
+		l_dbus_message_builder_append_basic(builder, 'y',
+							&(key->net_id[i]));
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+uint32_t net_key_get_next_id(uint32_t id)
+{
+	const struct l_queue_entry *entry;
+	struct net_key *key;
+	bool found = false;
+
+	/* Try to find next key (after the given key id) */
+	for (entry = l_queue_get_entries(keys); entry; entry = entry->next) {
+		key = entry->data;
+
+		if (!found)
+			if (key->id == id)
+				found = true;
+		else
+			return key->id;
+	}
+
+	/* If not found, return id of first key */
+	key = l_queue_peek_head(keys);
+	if (key)
+		return key->id;
+
+	return 0;
+}
diff --git a/mesh/net-keys.h b/mesh/net-keys.h
index e73812481ddb..5a9d7868ab48 100644
--- a/mesh/net-keys.h
+++ b/mesh/net-keys.h
@@ -37,3 +37,7 @@ bool net_key_beacon_refresh(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
 void net_key_beacon_enable(uint32_t id, bool mpb, uint8_t refresh_count);
 void net_key_beacon_disable(uint32_t id, bool mpb);
 uint32_t net_key_beacon_last_seen(uint32_t id);
+
+bool net_key_fill_adv_service_data(uint32_t id,
+					struct l_dbus_message_builder *builder);
+uint32_t net_key_get_next_id(uint32_t id);
diff --git a/mesh/net.c b/mesh/net.c
index 1cf74c892ca0..a64cfbde6f4e 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -27,6 +27,8 @@
 #include "mesh/net.h"
 #include "mesh/mesh-io.h"
 #include "mesh/friend.h"
+#include "mesh/gatt-service.h"		// PROXY_MSG_TYPE_NETWORK_PDU
+#include "mesh/gatt-proxy-svc.h"	// gatt_proxy_service_send()
 #include "mesh/mesh-config.h"
 #include "mesh/model.h"
 #include "mesh/appkey.h"
@@ -2306,7 +2308,9 @@ static void send_msg_pkt_oneshot(void *user_data)
 	/* No extra randomization when sending regular mesh messages */
 	info.u.gen.max_delay = DEFAULT_MIN_DELAY;
 
-	mesh_io_send(net->io, &info, tx->packet, tx->size);
+//	mesh_io_send(net->io, &info, tx->packet, tx->size);
+	gatt_proxy_service_send(PROXY_MSG_TYPE_NETWORK_PDU,
+						tx->packet + 1, tx->size - 1);
 	l_free(tx);
 }
 
@@ -3065,6 +3069,21 @@ struct mesh_io *mesh_net_detach(struct mesh_net *net)
 	return io;
 }
 
+void mesh_net_attach_gatt(struct gatt_proxy_service *gatt_proxy)
+{
+	gatt_proxy_service_register_recv_cb(gatt_proxy,
+						PROXY_MSG_TYPE_NETWORK_PDU,
+						net_msg_recv, NULL);
+}
+
+void mesh_net_detach_gatt(struct gatt_proxy_service *gatt_proxy)
+{
+//	mesh_io_send_cancel(net->io, &type, 1);
+
+	gatt_proxy_service_deregister_recv_cb(gatt_proxy,
+						PROXY_MSG_TYPE_NETWORK_PDU);
+}
+
 bool mesh_net_iv_index_update(struct mesh_net *net)
 {
 	if (net->iv_upd_state != IV_UPD_NORMAL)
diff --git a/mesh/net.h b/mesh/net.h
index d385ba16efdd..1389e5c78d15 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -14,6 +14,8 @@
 
 struct mesh_io;
 struct mesh_node;
+struct mesh_io_recv_info;
+struct gatt_proxy_service;
 
 #define DEV_ID	0
 
@@ -258,6 +260,8 @@ bool mesh_net_get_key(struct mesh_net *net, bool new_key, uint16_t idx,
 							uint32_t *net_key_id);
 bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io);
 struct mesh_io *mesh_net_detach(struct mesh_net *net);
+void mesh_net_attach_gatt(struct gatt_proxy_service *gatt_proxy);
+void mesh_net_detach_gatt(struct gatt_proxy_service *gatt_proxy);
 struct l_queue *mesh_net_get_app_keys(struct mesh_net *net);
 
 void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index f483c330953b..1d30f3593d3a 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -21,6 +21,8 @@
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
 #include "mesh/crypto.h"
+#include "mesh/mesh-io.h"
+#include "mesh/gatt-proxy-svc.h"
 #include "mesh/net.h"
 #include "mesh/prov.h"
 #include "mesh/provision.h"
@@ -88,6 +90,11 @@ struct mesh_prov_acceptor {
 
 static struct mesh_prov_acceptor *prov = NULL;
 
+static void gatt_unreg_finished(void *user_data)
+{
+	gatt_proxy_service_create();
+}
+
 static void acceptor_free(void)
 {
 	if (!prov)
@@ -100,7 +107,7 @@ static void acceptor_free(void)
 	mesh_send_cancel(&pkt_filter, sizeof(pkt_filter));
 
 	pb_adv_unreg(prov);
-	pb_gatt_unreg(prov, NULL, NULL);
+	pb_gatt_unreg(prov, gatt_unreg_finished, NULL);
 
 	l_free(prov);
 	prov = NULL;
@@ -704,8 +711,13 @@ failure:
 cleanup:
 	l_timeout_remove(prov->timeout);
 
-	/* Give PB Link 5 seconds to end session */
-	prov->timeout = l_timeout_create(5, prov_to, prov, NULL);
+	if (prov->transport == PB_ADV) {
+		/* Give PB Link 5 seconds to end session */
+		prov->timeout = l_timeout_create(5, prov_to, prov, NULL);
+	} else {
+		prov->timeout = NULL;
+		prov_to(NULL, prov);
+	}
 }
 
 static void acp_prov_ack(void *user_data, uint8_t msg_num)
@@ -804,6 +816,14 @@ bool acceptor_start(uint8_t num_ele, uint8_t *uuid,
 		result = pb_adv_reg(false, acp_prov_open, acp_prov_close,
 					acp_prov_rx, acp_prov_ack, uuid, prov);
 
+		/*
+		 * MeshPRT_v1.1, chapter 7: "A device may support the Mesh
+		 * Provisioning Service or the Mesh Proxy Service or both. If
+		 * both are supported, only one of these services shall be
+		 * exposed in the GATT database at a time."
+		 */
+		gatt_proxy_service_destroy();
+
 		result = pb_gatt_reg(acp_prov_open, acp_prov_close,
 					acp_prov_rx, acp_prov_ack, uuid,
 					caps->oob_info, prov);
-- 
2.43.0

