Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A052F2C50
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256799; cv=fail; b=lSedaZ7p5DTrbwImDJDa8OiY0i44MYJMefRfKx1f+aoLYkGk/D7LZheYTGfCemAhU0qbmrCNAzqd0xj95ZAnhGTxfwW42nAqNDTn0dh5Eq6SbOFqzxGhv7j0P6oF8B+gEe4ssTyat3xQIWhTgIQ+yVe52uVVZtfsVpZ2CMoZvCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256799; c=relaxed/simple;
	bh=phXAwev8AVhL2IasNlrOPMIrH7t7nPStnwQDlZCRS9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnxifft7Lgg1CuhpOm9baQ/7SD1exu3/ZGT46L/9uqbO4ZKw/ujdR2j+zju5A9VY9pO5IEiC8a7XMFfc1z9qwGQR0hLVzzMKnqhI8xlDbtHbR1kl7DcyKVRYvXpDcKjP6TicI1nKdst9yugREFnG2W3lFPrV5kIOffwR18GGRE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=qk/HDEjd; arc=fail smtp.client-ip=52.101.70.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="qk/HDEjd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mzg02BWjPzALI9u/RwcCZtY15dZBC5KdeDcSvjdrUG3vu0FCAAy0L4+ekwliRJNkI9CLigeAEYAYbynQnULgAnpUIwPzTME8GvxPwoJDCRS7FomNsUdB0uysdgja1xiMvEb5vonwzhZN/ks4X2nab8US4ycgx6s8cKNlBiY34rFLsoUyR4YRFFdn2w4WWNSX8Yja13YM0176BAR0wQj1Wp60L41miPSMeeL3SwJ/WTG0Ikvv0kz3OpJ/GkCIcyyW/M5jc8VbchLLrJ1d6tkIvwgyvmctJM+62AJcUqNqfkkvfK4pllNtPEf1PT0bthPoJN+ylyH6Hh9+yly6mLIv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCrPeqy2Q/EAc959r7PK6nfNn+oAYkxcL1pRXr1uUhQ=;
 b=LXUmHpYV05+qHednE0VJ/kBf+TU35oDPL/42+NUWCpnm3PClkedPsQ0y213m8N1FZ2Cum0BgXgp62nphCBl7bmZETzZxPPEvdj1QVh4T8lAhjvTn02xZ42i0hvrcIQoxh55f3tO8baieDq/J4C+I7e7b8TwExpqZc48vP0lAV8DNBd/fUdOjPw2s3JM6deTBpGD7JmDroSUI4R+QHc7eaP0j/5bpTDlWstQeUvcSDWnshmkf76xYzUf8QkjAosCKx+beZrWsGUenJ2RLWJGLtseSUPYaystTOSMpRhBgED3oIqEkVBwGn3UciEEgVKCleLFP0zcihfQEvndKaUpp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCrPeqy2Q/EAc959r7PK6nfNn+oAYkxcL1pRXr1uUhQ=;
 b=qk/HDEjdPfS5u5j/bL86hzNJp+4YkmAj91JUwZJ604dDUhDjiBpBaemJqIsux0RIPO4wlZWnrlNjR8l73uAN6FYc0qXI5HCknv6nTdmSzu4fgONQPqfjjjD+DEW/i/UUknDmj8v9ZAbwrCq8+GwHiJTmgaQWvY5J1nfoXUVJncc=
Received: from PR2P264CA0030.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::18) by
 AS8PR03MB9242.eurprd03.prod.outlook.com (2603:10a6:20b:5b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Fri, 11 Jul
 2025 17:59:54 +0000
Received: from AMS0EPF000001AD.eurprd05.prod.outlook.com
 (2603:10a6:101:1:cafe::76) by PR2P264CA0030.outlook.office365.com
 (2603:10a6:101:1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 17:59:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001AD.mail.protection.outlook.com (10.167.16.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 17:59:52 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 19:59:51 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [RFC PATCH BlueZ v2 3/7] mesh: add GATT proxy service
Date: Fri, 11 Jul 2025 19:56:53 +0200
Message-ID: <20250711175842.28860-4-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711175842.28860-1-ceggers@arri.de>
References: <20250701144647.19572-2-ceggers@arri.de>
 <20250711175842.28860-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AD:EE_|AS8PR03MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5e88f0-4fee-4be2-8e2b-08ddc0a4bc3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MtU48htePVaFrPIqHUzZl0ClQholKlJf/7+qJFLun23YLK62lsK2uJbqwPkF?=
 =?us-ascii?Q?yRhDgqF2lCUbK6jcfk+MC+MNwO8+CmHDRgo0Hu9Ga/md1cudtIbzu4Mk3bis?=
 =?us-ascii?Q?wOq3YRBuV35DdhgdbdH4IAloCRLKqHqm7FYGP/VcFEjSJRhVzDvLhQyiVqP6?=
 =?us-ascii?Q?iACw7iME3j3H2d4nRRl11jE0CWnInMp+3NEh4va4TFYrGb/X6tiEP1cuxDpY?=
 =?us-ascii?Q?vVnRYvd7rdUKGIYL5hVl9jko9FWr4sjl24HHCT4+Fo75kI9OhV1E5Ax1B64D?=
 =?us-ascii?Q?kWkli1ZVGnRVkf2dVUISOAiKdsx2RWytJ2ViJo507Klqga+hlYjAehY9WPCn?=
 =?us-ascii?Q?xbXjJM+ZHYvPCSKFaygSiKDHBv3aMvKT0n1jFmqPusY5Jj8UTTtG7h/o0ZAq?=
 =?us-ascii?Q?EDhp2iso4iKDhf1Htxqh3tjC+zR/kCtTbwtKgvE20C5vHmkBV/T+eZ1dORpX?=
 =?us-ascii?Q?zWqTD9TUNm5xLsFScv23wlJlo4a8/rYyu9I8LFeyv2WKIREN7kN53Jkd+HGc?=
 =?us-ascii?Q?7Up6z7NIHc1YprMHWnrhgM/jiC+1IGc0AxzylkfGg7iDDddnLnxAxi3Y48jT?=
 =?us-ascii?Q?r53WQ4IjFkXoRN41Gqqdj/95wI+tPOs2mE+dasxCdFG5E/+cNjeGd2gqNoXf?=
 =?us-ascii?Q?oyCd0M3CkTOTqytLVXRX/xmYcSN74uME5MryrrhVssD/H4W9wK5WuPeQrWdy?=
 =?us-ascii?Q?tu+KW5VYyve3MofLUog6NzRr+5E/nE0CoN3JiYbjs9tWDC3AlhlgR0vGlz1C?=
 =?us-ascii?Q?vAeodVXr17Nupxj13qcICnUuu/BdXKvptN/xxM+akXf5i62RFKZXPaCij10K?=
 =?us-ascii?Q?jwCi5Vcvfqxq0yBK7l2segmr4gKSfG4x8Uz/blsedivXfPx935bTBLYbhUF+?=
 =?us-ascii?Q?mYbatZEeHnfb2cYHi7RmS2QxND0cPrpxZB7iLHzW8YqyqsaUHI/hAowcm8C1?=
 =?us-ascii?Q?cxOdxOQtH/jCvs/l939IFTw92iVWQFATT4GUX4x2j5cDjgX/WtpjCaV2jUKb?=
 =?us-ascii?Q?NMw8D/mr9yehOk5qGuPyX6UPHoK3a73Mb1C6p5Lc/1rhd2/fV1yWINyRv8Wr?=
 =?us-ascii?Q?xJMZH4V0+sUOY8Qu0p+B9hlX76eaQuLJDPYgfsj5YGz3rCTDKPQI8lrR9+DK?=
 =?us-ascii?Q?n713LIaxRz7j9meUQ3b6Gw1N/Wskgv5Fto0WCpI2fBb5EWKj0zSz/BU2kLqy?=
 =?us-ascii?Q?/uUQe+8+iJXmG/PQAKpCd5D7AbvL5lszhm2O7m2cSo3pfvYYfEJj0aJvvBXN?=
 =?us-ascii?Q?K6fc2rQYEJj0Ph9gXAMV63Lmd50GW+R6tn4acSv3lmlKqD7dJ31Ma6JIvC8U?=
 =?us-ascii?Q?Rp61OWO0O1HCBEcHx9jZn99UA088y6JikrC7UF8yjl1eeqVT3Mf0pxoVRBI6?=
 =?us-ascii?Q?HgIIf5qqjG/YysFsIegcfnjtjBzQQ7Zz73sTI0u9iofDBc3PhwVOJ4+2MUJP?=
 =?us-ascii?Q?LiwWQuHZvAq84HCx4GDP2lVTMbPwI7DRMLQV9robH9MhKArTOnfxZvVyXJ1I?=
 =?us-ascii?Q?UtoNC1lBYBAE9Dwy212sImwZ1cGCIR82n1qN?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:59:52.1412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5e88f0-4fee-4be2-8e2b-08ddc0a4bc3d
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9242

MeshPRT_v1.1, chapter 7 states that GATT provisioning service and GATT
proxy service must NOT be active simultaneously.

This patch only implements the GATT proxy itself (so that a GATT proxy
client can exchange network messages with server). Relaying /
retransmission of network messages and propagation of beacons will be
handled in later patches.
---
 Makefile.mesh         |   3 +-
 mesh/gatt-proxy-svc.c | 327 ++++++++++++++++++++++++++++++++++++++++++
 mesh/gatt-proxy-svc.h |  28 ++++
 mesh/main.c           |   3 +
 mesh/net-keys.c       |  61 ++++++++
 mesh/net-keys.h       |   4 +
 mesh/net.c            |  72 +++++++++-
 mesh/net.h            |   3 +
 mesh/prov-acceptor.c  |  26 +++-
 9 files changed, 518 insertions(+), 9 deletions(-)
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
index 000000000000..27cc22c0572a
--- /dev/null
+++ b/mesh/gatt-proxy-svc.c
@@ -0,0 +1,327 @@
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
+#include <ell/log.h>			// l_warn()
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
+struct gatt_proxy_svc {
+	struct gatt_service *gatt_service;
+	uint32_t current_adv_key_id;
+	struct l_timeout *adv_key_cycle_to;
+	bool connected;
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
+static struct gatt_proxy_svc *gatt_proxy_svc;
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
+void gatt_proxy_svc_register_recv_cb(struct gatt_proxy_svc *gatt_proxy,
+					enum proxy_msg_type msg_type,
+					mesh_io_recv_func_t cb,
+					void *user_data)
+{
+	struct gatt_io_reg *rx_reg;
+
+	if (gatt_proxy != gatt_proxy_svc || !cb)
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
+void gatt_proxy_svc_deregister_recv_cb(struct gatt_proxy_svc *gatt_proxy,
+						enum proxy_msg_type msg_type)
+{
+	struct gatt_io_reg *rx_reg;
+
+	if (gatt_proxy != gatt_proxy_svc)
+		return;
+
+	rx_reg = find_by_filter(gatt_proxy->rx_regs, msg_type);
+
+	l_queue_remove(gatt_proxy->rx_regs, rx_reg);
+	l_free(rx_reg);
+}
+
+static void gatt_proxy_svc_send(enum proxy_msg_type msg_type, const void *data,
+								uint8_t len)
+{
+	if (!gatt_proxy_svc)
+		return;
+
+	if (!gatt_proxy_svc->connected) {
+		l_warn("Not connected, dropping TX message...");
+		return;
+	}
+
+	if (!gatt_proxy_svc->txing) {
+		gatt_proxy_svc->txing = true;
+		gatt_service_tx(gatt_proxy_svc->gatt_service, msg_type,
+								data, len);
+	} else {
+		struct tx_deferred *tx_deferred;
+
+//		print_packet("TX-Defer", data, len);
+		tx_deferred = l_malloc(len + sizeof(struct tx_deferred));
+		tx_deferred->msg_type = msg_type;
+		tx_deferred->len = len;
+		memcpy(tx_deferred->data, data, len);
+		l_queue_push_tail(gatt_proxy_svc->tx_deferred, tx_deferred);
+	}
+}
+
+void gatt_proxy_svc_send_net(const void *data, uint8_t len)
+{
+	gatt_proxy_svc_send(PROXY_MSG_TYPE_NETWORK_PDU, data, len);
+}
+
+static void gatt_service_notify_acquired(void *user_data)
+{
+	struct gatt_proxy_svc *gatt_proxy = user_data;
+
+	if (gatt_proxy != gatt_proxy_svc)
+		return;
+
+	gatt_proxy->connected = true;
+}
+
+static void gatt_service_notify_stopped(void *user_data)
+{
+	struct gatt_proxy_svc *gatt_proxy = user_data;
+
+	if (gatt_proxy != gatt_proxy_svc)
+		return;
+
+	gatt_proxy->connected = false;
+	gatt_proxy->txing = false;
+	l_queue_clear(gatt_proxy->tx_deferred, l_free);
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
+	struct gatt_proxy_svc *gatt_proxy = user_data;
+	struct process_data rx = {
+		.msg_type = msg_type,
+		.data = data,
+		.len = len,
+	};
+
+	if (gatt_proxy != gatt_proxy_svc)
+		return;
+
+	l_queue_foreach(gatt_proxy->rx_regs, process_rx_callbacks, &rx);
+}
+
+static bool gatt_service_tx_cmplt(void *user_data)
+{
+	struct gatt_proxy_svc *gatt_proxy = user_data;
+	struct tx_deferred *tx_deferred;
+
+//	l_info("gatt_service_tx_cmplt");
+
+	if (gatt_proxy_svc != gatt_proxy)
+		return false;
+
+	if (!gatt_proxy->connected || !gatt_proxy->txing)
+		return false;
+
+	gatt_proxy->txing = false;
+
+	tx_deferred = l_queue_pop_head(gatt_proxy->tx_deferred);
+	if (!tx_deferred)
+		return false;
+
+	gatt_proxy_svc_send(tx_deferred->msg_type, tx_deferred->data,
+							tx_deferred->len);
+	l_free(tx_deferred);
+	return true;
+}
+
+static bool gatt_service_fill_adv_service_data(void *user_data,
+					struct l_dbus_message_builder *builder)
+{
+	struct gatt_proxy_svc *gatt_service = user_data;
+
+	if (gatt_service != gatt_proxy_svc)
+		return false;
+
+	return net_key_fill_adv_service_data(gatt_service->current_adv_key_id,
+								builder);
+}
+
+static void gatt_proxy_svc_cycle_adv(struct l_timeout *timeout,
+						void *user_data)
+{
+	struct gatt_proxy_svc *gatt_proxy = user_data;
+	uint32_t next_adv_key_id;
+
+	if (gatt_proxy_svc != gatt_proxy)
+		return;
+
+	next_adv_key_id = net_key_get_next_id(gatt_proxy->current_adv_key_id);
+	if (!next_adv_key_id)
+		return;
+
+	if (gatt_proxy->current_adv_key_id != next_adv_key_id) {
+		gatt_proxy->current_adv_key_id = next_adv_key_id;
+		gatt_service_adv_updated(gatt_proxy_svc->gatt_service);
+	}
+
+	l_timeout_modify(gatt_proxy->adv_key_cycle_to, 3);
+}
+
+void gatt_proxy_svc_set_current_adv_key(uint32_t id)
+{
+	if (!gatt_proxy_svc)
+		return;
+
+	gatt_proxy_svc->current_adv_key_id = id;
+	gatt_service_adv_updated(gatt_proxy_svc->gatt_service);
+}
+
+void gatt_proxy_svc_start(void)
+{
+	if (!gatt_proxy_svc || gatt_proxy_svc->gatt_service)
+		return;
+
+	gatt_proxy_svc->gatt_service = gatt_service_create(
+					MESH_GATT_PROXY_SVC_UUID,
+					MESH_GATT_PROXY_CHRC_DATA_IN,
+					MESH_GATT_PROXY_CHRC_DATA_OUT,
+					MAX_PROXY_PDU_LEN,
+					gatt_service_notify_acquired,
+					gatt_service_notify_stopped,
+					gatt_service_rx,
+					gatt_service_tx_cmplt,
+					gatt_service_fill_adv_service_data,
+					gatt_proxy_svc);
+
+	gatt_proxy_svc->adv_key_cycle_to = l_timeout_create(3,
+						gatt_proxy_svc_cycle_adv,
+						gatt_proxy_svc, NULL);
+
+	mesh_net_attach_gatt(gatt_proxy_svc);
+}
+
+void gatt_proxy_svc_stop(void)
+{
+	if (!gatt_proxy_svc || !gatt_proxy_svc->gatt_service)
+		return;
+
+	mesh_net_detach_gatt(gatt_proxy_svc);
+	l_timeout_remove(gatt_proxy_svc->adv_key_cycle_to);
+	gatt_service_destroy(gatt_proxy_svc->gatt_service, NULL, NULL);
+}
+
+void gatt_proxy_svc_create(void)
+{
+	if (gatt_proxy_svc)
+		return;
+
+	gatt_proxy_svc = l_new(struct gatt_proxy_svc, 1);
+	gatt_proxy_svc->tx_deferred = l_queue_new();
+	gatt_proxy_svc->rx_regs = l_queue_new();
+
+	/* Check whether we have at least one key */
+	if (!net_key_get_next_id(0))
+		return;
+
+	gatt_proxy_svc_start();
+}
+
+void gatt_proxy_svc_destroy(void)
+{
+	if (!gatt_proxy_svc)
+		return;
+
+	gatt_proxy_svc_stop();
+
+	l_queue_destroy(gatt_proxy_svc->rx_regs, l_free);
+	l_queue_destroy(gatt_proxy_svc->tx_deferred, l_free);
+	l_free(gatt_proxy_svc);
+	gatt_proxy_svc = NULL;
+}
diff --git a/mesh/gatt-proxy-svc.h b/mesh/gatt-proxy-svc.h
new file mode 100644
index 000000000000..2b0c9d7ec21b
--- /dev/null
+++ b/mesh/gatt-proxy-svc.h
@@ -0,0 +1,28 @@
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
+struct gatt_proxy_svc;
+
+void gatt_proxy_svc_create(void);
+void gatt_proxy_svc_destroy(void);
+void gatt_proxy_svc_start(void);
+void gatt_proxy_svc_stop(void);
+void gatt_proxy_svc_set_current_adv_key(uint32_t id);
+void gatt_proxy_svc_register_recv_cb(struct gatt_proxy_svc *gatt_proxy,
+					enum proxy_msg_type msg_type,
+					mesh_io_recv_func_t cb,
+					void *user_data);
+void gatt_proxy_svc_deregister_recv_cb(struct gatt_proxy_svc *gatt_proxy,
+						enum proxy_msg_type msg_type);
+void gatt_proxy_svc_send_net(const void *data, uint8_t len);
+								
diff --git a/mesh/main.c b/mesh/main.c
index 5b8af4bc7345..079b3cbcad36 100644
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
+	gatt_proxy_svc_create();
 }
 
 static void request_name_callback(struct l_dbus *dbus, bool success,
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 98e6d23d3f87..ab724f9cfa1e 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -22,6 +22,7 @@
 #include "mesh/util.h"
 #include "mesh/crypto.h"
 #include "mesh/mesh-io.h"
+#include "mesh/gatt-proxy-svc.h"
 #include "mesh/net.h"
 #include "mesh/net-keys.h"
 
@@ -31,6 +32,12 @@
 /* This allows daemon to skip decryption on recently seen beacons */
 #define BEACON_CACHE_MAX	10
 
+/* MshPRT_v1.1, section 7.2.2.2.1 */
+#define IDENTIFICATION_TYPE_NETWORK_ID		0x00
+#define IDENTIFICATION_TYPE_NODE_ID		0x01
+#define IDENTIFICATION_TYPE_PRV_NETWORK_ID	0x02
+#define IDENTIFICATION_TYPE_PRV_NODE_ID		0x03
+
 struct beacon_rx {
 	uint8_t data[BEACON_LEN_MAX];
 	uint32_t id;
@@ -146,6 +153,9 @@ uint32_t net_key_add(const uint8_t flooding[16])
 		goto fail;
 
 	key->id = ++last_flooding_id;
+	if (l_queue_isempty(keys))
+		gatt_proxy_svc_start();
+
 	l_queue_push_tail(keys, key);
 	return key->id;
 
@@ -198,6 +208,9 @@ void net_key_unref(uint32_t id)
 			l_timeout_remove(key->observe.timeout);
 			l_queue_remove(keys, key);
 			l_free(key);
+
+			if (l_queue_isempty(keys))
+				gatt_proxy_svc_stop();
 		}
 	}
 }
@@ -662,6 +675,7 @@ bool net_key_beacon_refresh(uint32_t id, uint32_t ivi, bool kr, bool ivu,
 			return false;
 
 		print_packet("Set SNB to", key->snb, BEACON_LEN_SNB);
+		gatt_proxy_svc_set_current_adv_key(key->id);
 	}
 
 	l_debug("Set Beacon: IVI: %8.8x, IVU: %d, KR: %d", ivi, ivu, kr);
@@ -797,3 +811,50 @@ void net_key_cleanup(void)
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
index 49e01132cbf2..512347521547 100644
--- a/mesh/net-keys.h
+++ b/mesh/net-keys.h
@@ -38,3 +38,7 @@ bool net_key_beacon_refresh(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
 void net_key_beacon_enable(uint32_t id, bool mpb, uint8_t refresh_count);
 void net_key_beacon_disable(uint32_t id, bool mpb);
 uint32_t net_key_beacon_last_seen(uint32_t id);
+
+bool net_key_fill_adv_service_data(uint32_t id,
+					struct l_dbus_message_builder *builder);
+uint32_t net_key_get_next_id(uint32_t id);
diff --git a/mesh/net.c b/mesh/net.c
index b29e24f5d4a9..911f781ef75c 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -29,6 +29,8 @@
 #include "mesh/net.h"
 #include "mesh/mesh-io.h"
 #include "mesh/friend.h"
+#include "mesh/gatt-service.h"		// PROXY_MSG_TYPE_NETWORK_PDU
+#include "mesh/gatt-proxy-svc.h"	// gatt_proxy_svc_send_net()
 #include "mesh/mesh-config.h"
 #include "mesh/model.h"
 #include "mesh/appkey.h"
@@ -177,6 +179,7 @@ struct mesh_destination {
 };
 
 struct net_queue_data {
+	struct gatt_proxy_svc *gatt_proxy;
 	struct mesh_io_recv_info *info;
 	struct mesh_net *net;
 	const uint8_t *data;
@@ -192,6 +195,7 @@ struct net_queue_data {
 struct oneshot_tx {
 	struct mesh_net *net;
 	uint16_t interval;
+	bool frnd;
 	uint8_t cnt;
 	uint8_t size;
 	uint8_t packet[MESH_AD_MAX_LEN];
@@ -2288,17 +2292,30 @@ static void send_msg_pkt_oneshot(void *user_data)
 	/* No extra randomization when sending regular mesh messages */
 	info.u.gen.max_delay = DEFAULT_MIN_DELAY;
 
+	/*
+	 * MshPrt_v1.1, section 3.4.6.4 - Transmitting a network PDU
+	 * If [...], and the Network PDU is secured using the friendship
+	 * security credentials, the Network PDU shall be delivered to the
+	 * advertising bearer network interface.
+	 * If [...], and the Network PDU is not secured using the friendship
+	 * security credentials, the Network PDU shall be delivered to all
+	 * network interfaces.
+	 */
 	mesh_io_send(net->io, &info, tx->packet, tx->size);
+	if (!tx->frnd)
+		gatt_proxy_svc_send_net(tx->packet + 1, tx->size - 1);
 	l_free(tx);
 }
 
 static void send_msg_pkt(struct mesh_net *net, uint8_t cnt, uint16_t interval,
-					const uint8_t *packet, uint8_t size)
+					const uint8_t *packet, uint8_t size,
+								bool frnd)
 {
 	struct oneshot_tx *tx = l_new(struct oneshot_tx, 1);
 
 	tx->net = net;
 	tx->interval = interval;
+	tx->frnd = frnd;
 	tx->cnt = cnt;
 	tx->size = size;
 	memcpy(tx->packet, packet, size);
@@ -2482,6 +2499,15 @@ static void net_rx(void *net_ptr, void *user_data)
 	if (net_idx == NET_IDX_INVALID)
 		return;
 
+	/*
+	 * MshPRT_v1.1, section 3.4.5.1 - Interface input filter
+	 * The input filter of the interface connected to the GATT bearer shall
+	 * drop all Network PDUs that have been secured using the friendship
+	 * security credentials.
+	 */
+	if (data->gatt_proxy && frnd)
+		return;
+
 	relay_advice = packet_received(net, net_key_id, net_idx, frnd,
 						iv_index, out, out_size, rssi);
 	if (relay_advice > data->relay_advice) {
@@ -2506,7 +2532,9 @@ static void net_msg_recv(void *user_data, struct mesh_io_recv_info *info,
 {
 	uint64_t hash;
 	bool isNew;
+	struct gatt_proxy_svc *gatt_proxy = user_data;
 	struct net_queue_data net_data = {
+		.gatt_proxy = gatt_proxy,
 		.info = info,
 		.data = data + 1,
 		.len = len - 1,
@@ -3047,6 +3075,21 @@ struct mesh_io *mesh_net_detach(struct mesh_net *net)
 	return io;
 }
 
+void mesh_net_attach_gatt(struct gatt_proxy_svc *gatt_proxy)
+{
+	gatt_proxy_svc_register_recv_cb(gatt_proxy, PROXY_MSG_TYPE_NETWORK_PDU,
+							net_msg_recv,
+							gatt_proxy);
+}
+
+void mesh_net_detach_gatt(struct gatt_proxy_svc *gatt_proxy)
+{
+//	mesh_io_send_cancel(net->io, &type, 1);
+
+	gatt_proxy_svc_deregister_recv_cb(gatt_proxy,
+						PROXY_MSG_TYPE_NETWORK_PDU);
+}
+
 bool mesh_net_iv_index_update(struct mesh_net *net)
 {
 	if (net->iv_upd_state != IV_UPD_NORMAL)
@@ -3171,7 +3214,7 @@ static bool send_seg(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 		return false;
 	}
 
-	send_msg_pkt(net, cnt, interval, packet, packet_len + 1);
+	send_msg_pkt(net, cnt, interval, packet, packet_len + 1, false);
 
 	msg->last_seg = segO;
 
@@ -3191,6 +3234,7 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 	uint16_t seqZero = (hdr >> SEQ_ZERO_HDR_SHIFT) & SEQ_ZERO_MASK;
 	uint8_t segO = (hdr >> SEGO_HDR_SHIFT) & SEG_MASK;
 	uint8_t segN = (hdr >> SEGN_HDR_SHIFT) & SEG_MASK;
+	bool frnd;
 
 	/*
 	 * MshPRFv1.0.1 section 3.4.5.2, Interface output filter:
@@ -3219,8 +3263,13 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 		return;
 	}
 
+	if (key_id_to_net_idx(net, net_key_id, &frnd) == NET_IDX_INVALID) {
+		l_error("Failed to determine friend security material");
+		return;
+	}
+
 	send_msg_pkt(net, net->tx_cnt, net->tx_interval, packet,
-								packet_len + 1);
+							packet_len + 1, frnd);
 
 	l_debug("TX: Friend Seg-%d %04x -> %04x : len %u) : TTL %d : SEQ %06x",
 					segO, src, dst, packet_len, ttl, seq);
@@ -3345,6 +3394,7 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t net_key_id,
 	uint8_t data[7];
 	uint8_t pkt_len;
 	uint8_t pkt[MESH_AD_MAX_LEN];
+	bool frnd;
 
 	/*
 	 * MshPRFv1.0.1 section 3.4.5.2, Interface output filter:
@@ -3378,7 +3428,13 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t net_key_id,
 		return;
 	}
 
-	send_msg_pkt(net, net->tx_cnt, net->tx_interval, pkt, pkt_len + 1);
+	if (key_id_to_net_idx(net, net_key_id, &frnd) == NET_IDX_INVALID) {
+		l_error("Failed to determine friend security material");
+		return;
+	}
+
+	send_msg_pkt(net, net->tx_cnt, net->tx_interval, pkt, pkt_len + 1,
+									frnd);
 
 	l_debug("TX: Friend ACK %04x -> %04x : len %u : TTL %d : SEQ %06x",
 					src, dst, pkt_len, ttl, seq);
@@ -3394,6 +3450,7 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 	uint8_t pkt_len;
 	uint8_t pkt[MESH_AD_MAX_LEN];
 	bool result = false;
+	bool frnd;
 
 	if (!net->src_addr)
 		return;
@@ -3459,9 +3516,14 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 		return;
 	}
 
+	if (key_id_to_net_idx(net, net_key_id, &frnd) == NET_IDX_INVALID) {
+		l_error("Failed to determine friend security material");
+		return;
+	}
+
 	if (!(IS_UNASSIGNED(dst)))
 		send_msg_pkt(net, net->tx_cnt, net->tx_interval, pkt,
-								pkt_len + 1);
+							pkt_len + 1, frnd);
 }
 
 int mesh_net_key_refresh_phase_set(struct mesh_net *net, uint16_t idx,
diff --git a/mesh/net.h b/mesh/net.h
index 5200beb2fada..af581478412c 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -14,6 +14,7 @@
 
 struct mesh_io;
 struct mesh_node;
+struct gatt_proxy_svc;
 
 #define DEV_ID	0
 
@@ -249,6 +250,8 @@ bool mesh_net_get_key(struct mesh_net *net, bool new_key, uint16_t idx,
 							uint32_t *net_key_id);
 bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io);
 struct mesh_io *mesh_net_detach(struct mesh_net *net);
+void mesh_net_attach_gatt(struct gatt_proxy_svc *gatt_proxy);
+void mesh_net_detach_gatt(struct gatt_proxy_svc *gatt_proxy);
 struct l_queue *mesh_net_get_app_keys(struct mesh_net *net);
 
 void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index b3c538359a66..a374abb92083 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -22,6 +22,8 @@
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
 #include "mesh/crypto.h"
+#include "mesh/mesh-io.h"
+#include "mesh/gatt-proxy-svc.h"
 #include "mesh/net.h"
 #include "mesh/prov.h"
 #include "mesh/provision.h"
@@ -89,6 +91,11 @@ struct mesh_prov_acceptor {
 
 static struct mesh_prov_acceptor *prov = NULL;
 
+static void gatt_unreg_finished(void *user_data)
+{
+	gatt_proxy_svc_create();
+}
+
 static void acceptor_free(void)
 {
 	if (!prov)
@@ -101,7 +108,7 @@ static void acceptor_free(void)
 	mesh_send_cancel(&pkt_filter, sizeof(pkt_filter));
 
 	pb_adv_unreg(prov);
-	pb_gatt_unreg(prov, NULL, NULL);
+	pb_gatt_unreg(prov, gatt_unreg_finished, NULL);
 
 	l_free(prov);
 	prov = NULL;
@@ -705,8 +712,13 @@ failure:
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
+		gatt_proxy_svc_destroy();
+
 		result = pb_gatt_reg(acp_prov_open, acp_prov_close,
 					acp_prov_rx, acp_prov_ack, uuid,
 					caps->oob_info, prov);
-- 
2.43.0

