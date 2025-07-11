Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011027.outbound.protection.outlook.com [52.101.70.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4A41760
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256767; cv=fail; b=rMJg++WW7t3UtE4vOKLlj0NWyERR8LCfRG71pJKkABuBMCZQDjoL5f9lw3pAO9vJecdsqFMMBqBBEcoRZFo5cwr23FDdWCzRdJb3NA0yDQo3HSuSRoblxWbF2Pxk546Hluji+QQ/JFfWfhLOraO4WfJzIFHnWBvCenazjx6n6Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256767; c=relaxed/simple;
	bh=4FzsdV7DJJn3s/EdqEiNVyXCsSBovLCxGFy96Hf8mwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6m0TefRTSjGwHstUakjsDhrPNXjKV4GyFDuYaliCrnzVa9kmv4urif92CNbVUhwnDxaHS9ZdWw967U+bVi6yGp68hJffYR94oCZNnOLpUwiayLV90LOm7flgC942NX+lV9xaXSjQ/h24BTOwetMTUBmc3kzOPRTh6McTwwLq20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=hiYs/QrU; arc=fail smtp.client-ip=52.101.70.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="hiYs/QrU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyYRKRWxCxAbq4veqWOndYwd+u67C7dfgNp1AnMKj14WE+qI6hjizBdcgCDN7C1SnY81HaruUwzXf9usLVl0YoV3w7v2+AsZZNAhJ1oaYdGCWYcfzM2OIcruZQy7E9sbjvBH2XuJRRup26uR3XS8rkAnm3d3voyLS2P21OKLSVrDCYlrGnyR6EMjsP0R/0N0cJYh+niEsg3lgzHrL+/tWgAN1mDOye+VJ5Pw9WiFUt3zG10JMq8YjwZH7JfdbdDyTfY+qgcFjZ3sfOvKFHc5hKLu4Z20EFxQM+xo1gh0Cg5zLwJaxEoR/MGE1aGQ+lIx4m389nvNQMikYHHyIm+Nag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rOrYegmstlEBc7nEjrVyE6kG0wNXIW5p4DtYvqvfOY=;
 b=sEGCdcy3zWowNTcWpcRIK/KFENBjaqRrsTp5GN72WyI9TYA/8EdbatNzCzDgvbgYmINTTEwbMtf/i+r2xLXtGG0er03dnBn+L5x6S7r+CUwwedwOxjgjOzMQ5S8G5pblUVDEjFTK8qZaVJMdmxCL8fFzrJ1aJLBK8/m2z5vKkFsefqMQC5A3uOk1gM5pMr4kSTy+ImMA9KevKKsxDZWPsWTawceLFP/hkb5gnLqHiHYWy2RNmvwLbkvctMqLWyEwYPf/5EKGlEudqKUATOolPbOLeOAYNBqccUDAn3PFLWJ/7vRyENNmdNJBs3/Of/SZnjJ6v0dozi+aFMConENdvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rOrYegmstlEBc7nEjrVyE6kG0wNXIW5p4DtYvqvfOY=;
 b=hiYs/QrUf0vJA/s8PX8+stzq3TRb5QSDGpu7+swEvag5DNKjJhSv/1KDo7isF+Nhb8zPaq9yEl7uRXlER90sMbKFcZhk/MRVmBuYrIeCtGDTMFv+FJhHmaccgD6AUmPcn29hjkOM7TExTKNTDPi9a1fqruyv+s3EhC/UlGuEgjA=
Received: from AM8P189CA0002.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::7)
 by AM9PR03MB7267.eurprd03.prod.outlook.com (2603:10a6:20b:26a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 17:59:18 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::78) by AM8P189CA0002.outlook.office365.com
 (2603:10a6:20b:218::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 17:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 17:59:18 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 19:59:17 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [RFC PATCH BlueZ v2 2/7] mesh: add support for provisioning via GATT
Date: Fri, 11 Jul 2025 19:56:52 +0200
Message-ID: <20250711175842.28860-3-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AC:EE_|AM9PR03MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e06f4eb-97f9-4cd3-b397-08ddc0a4a7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OE5zHM8BDZw8Aa+jkS+HSF4GmnoGoc2MQ3zHcfklSEcyWUayphYwPZjjGRmu?=
 =?us-ascii?Q?WUmWzfalbbe7apv6/4hP4+S6AI3UpFjMpWe3GmIkJ4iRIHucdY3iQL7mvnZR?=
 =?us-ascii?Q?+a1VHWfprOZ9r9vMNrynIV2TwwChoF/IuLs4HLecwMwV7NM6Ge5aHPN4fJ7n?=
 =?us-ascii?Q?ordiv/Onl0Rf92rRho+5Anf4syAvsOakxYQioDMNOsa58bKgM0//onW9gtjh?=
 =?us-ascii?Q?8QjZTzsPdcFfT28WcK9eo4UZETyX3TMQjrcUh9FT+NOk8P/dIEWtifobmv5e?=
 =?us-ascii?Q?SXNAyIG2sMvy7cmDAUXuAUqpvlkMgLjTt7+NSJqN89H4r4f4BJTsmTTiRMUd?=
 =?us-ascii?Q?7AvqqX/mxw3ZKsuHF6oSLzEMkzuB/oGMewJa/W3EUOUPlfsdfO98+j/99+el?=
 =?us-ascii?Q?mxDYCOukI8vL1R/BLihLZdWLOhCUghUiu5ZdsfDaxkmyfgaORndKCfGbKPEG?=
 =?us-ascii?Q?i9dIC4N2rFNwFV8hN1ek0NX2udgXX8s/tSFHJ4RqzA3Cd7X78FgXf2CHMP4m?=
 =?us-ascii?Q?qwQwTZb8kj1mA8jyPqEbck0YgSUoUQ+KE75G9gJRgbXGL4IMjSdUBHXpEezK?=
 =?us-ascii?Q?jBFBlIrdjKyJscbsorlLEbmwXtrH7HSdByUVTFVVi8AfHb8GsXzXqRFgIOD1?=
 =?us-ascii?Q?/pkEcJck9QetRZPCbPBagr/7E0PL8h5SGHfQmvBn3Ddx6a6SbSspjuuL0B8g?=
 =?us-ascii?Q?rUlf7GMBt7ywD2PHUxJqQoDtFwgYp8VqRyocm5z7agNQTyZVDvJBwXCKKga/?=
 =?us-ascii?Q?BiptmCmFs/1zahv2cDUKyGq5ClXyFF6o5IhU5AxPQCPhImcRIVz7/chB+kgO?=
 =?us-ascii?Q?JyH3uKiDqW57GvLYYp5aftJmxZI7TuMP3EQSF6GExQzBY0hHzEe7EAqHIJJb?=
 =?us-ascii?Q?f6Jrh2/SXfmcyQQNBxXlSXTylYDpQVupcNBSFfxqPpVP7uHMaWpigMT8ZN7E?=
 =?us-ascii?Q?5VmEgTm3V8hNoAK97s/192+RIizH/eZD1IWlVTy584duZKGV69vNiSNvAKDj?=
 =?us-ascii?Q?l3XyVgfjgdZZEk5lVvV5i7SQIQ+kyBeGLDJswrsdSTDRQXnQaP97TSzLLw8z?=
 =?us-ascii?Q?h30L9bUC+h0rWX+DE48GZslv735H+swnwimLvJRWZthTJyH+qxZqme9RWgMm?=
 =?us-ascii?Q?eGJxlOiwQyEn2PHXU2A0UL67LGnBRQWCn/c75tsNVwfjJ7Sx5QkcqBkrh4j/?=
 =?us-ascii?Q?tr+Tc2l36zNmGH3SWeAn91BI2+ejr5amQYyKh+3Ne1ihCSMJK0ew2HeIGM6+?=
 =?us-ascii?Q?FFTFGup8JYr7dHHJRkKHVBecM1TbQu6ilSEa4BUout79Rv7tAu0gjTzV9+ej?=
 =?us-ascii?Q?j29lLAGV9G7enK754G/BlZh2daCHjqs/FzEudVp4NZon572KjMsqL0eO7Us3?=
 =?us-ascii?Q?zfDuSMDk2GZIl3teZROtdc73sVXZBv2R8wBrYjAAqwhWrV90dHcxE6o3+3Ff?=
 =?us-ascii?Q?iOJiKjU2TA20hWK+S9kHTgeq05QDT8Yb58Hd9XO/KZzQxiscvjcqQOQrPvBi?=
 =?us-ascii?Q?Z5BUCSxpycpOm20hqxRiWeTR0HgXpSG0zcZG?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:59:18.0775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e06f4eb-97f9-4cd3-b397-08ddc0a4a7ef
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7267

ToDo: Consider moving dbus_client instance into separate singleton, so
that no destruction/construction is necessary when switching from GATT
provisioning service to GATT proxy service (see next commit).
---
 Makefile.mesh        |    4 +-
 mesh/gatt-service.c  | 1193 ++++++++++++++++++++++++++++++++++++++++++
 mesh/gatt-service.h  |   54 ++
 mesh/pb-gatt.c       |  173 ++++++
 mesh/pb-gatt.h       |   20 +
 mesh/prov-acceptor.c |    6 +
 6 files changed, 1449 insertions(+), 1 deletion(-)
 create mode 100644 mesh/gatt-service.c
 create mode 100644 mesh/gatt-service.h
 create mode 100644 mesh/pb-gatt.c
 create mode 100644 mesh/pb-gatt.h

diff --git a/Makefile.mesh b/Makefile.mesh
index e4c9fa6a32e6..700d64fe9293 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -35,10 +35,12 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/prov-acceptor.c mesh/prov-initiator.c \
 				mesh/manager.h mesh/manager.c \
 				mesh/pb-adv.h mesh/pb-adv.c \
+				mesh/pb-gatt.h mesh/pb-gatt.c \
 				mesh/keyring.h mesh/keyring.c \
 				mesh/rpl.h mesh/rpl.c \
 				mesh/prv-beacon.h mesh/prvbeac-server.c \
-				mesh/mesh-defs.h
+				mesh/mesh-defs.h \
+				mesh/gatt-service.h mesh/gatt-service.c
 pkglibexec_PROGRAMS += mesh/bluetooth-meshd
 
 mesh/mesh.$(OBJEXT): ell/internal
diff --git a/mesh/gatt-service.c b/mesh/gatt-service.c
new file mode 100644
index 000000000000..9fdf54d9031d
--- /dev/null
+++ b/mesh/gatt-service.c
@@ -0,0 +1,1193 @@
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
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>			// memcpy(), strerror()
+#include <sys/socket.h>			// SOCK_SEQPACKET, SOCK_NONBLOCK,
+					// AF_UNIX, SOCK_CLOEXEC, MSG_NOSIGNAL,
+					// struct msghdr,
+					// socketpair(), sendmsg()
+#include <sys/types.h>			// struct iovec
+#include <unistd.h>			// close()
+
+#include <ell/dbus.h>
+#include <ell/dbus-client.h>
+#include <ell/dbus-service.h>
+#include <ell/idle.h>
+#include <ell/io.h>
+#include <ell/log.h>
+#include <ell/util.h>			// L_ARRAY_SIZE(),
+					// l_new(), l_free()
+
+#include "mesh/dbus.h"			// dbus_get_bus(),
+					// dbus_append_byte_array(),
+					// dbus_error()
+#include "mesh/error.h"			// MESH_ERROR_INVALID_ARGS
+#include "mesh/util.h"			// print_packet()
+#include "mesh/gatt-service.h"
+
+#define GATT_SERVICE_IFACE "org.bluez.GattService1"
+#define BLUEZ_MESH_GATT_PATH BLUEZ_MESH_PATH "/gatt"
+#define BLUEZ_MESH_SERVICE_PATH BLUEZ_MESH_GATT_PATH "/service"
+#define BLUEZ_MESH_CHRC_DATA_IN_PATH BLUEZ_MESH_SERVICE_PATH "/data_in"
+#define BLUEZ_MESH_CHRC_DATA_OUT_PATH BLUEZ_MESH_SERVICE_PATH "/data_out"
+/*
+ * Advertising should NOT be handled by provisioning's object manager, so
+ * we cannot use a child element of BLUEZ_MESH_GATT_PATH.
+ */
+#define BLUEZ_MESH_GATT_ADV_PATH BLUEZ_MESH_PATH "/gatt_adv"
+
+#define GATT_MGR_IFACE "org.bluez.GattManager1"
+#define GATT_SERVICE_IFACE "org.bluez.GattService1"
+#define GATT_CHRC_IFACE "org.bluez.GattCharacteristic1"
+
+#define LE_ADVERTISING_MGR_IFACE "org.bluez.LEAdvertisingManager1"
+#define LE_ADVERTISEMENT_IFACE "org.bluez.LEAdvertisement1"
+
+#define GATT_MTU 23
+
+struct gatt_service;
+struct characterstic
+{
+	const char *uuid;
+	const char * const *flags;
+	struct gatt_service *service;
+};
+
+enum write_value_type {
+	WRITE_VALUE_TYPE_COMMAND,
+	WRITE_VALUE_TYPE_REQUEST,
+	WRITE_VALUE_TYPE_RELIABLE
+};
+
+enum link_type {
+	LINK_TYPE_BR_EDR,
+	LINK_TYPE_LE
+};
+
+struct write_value_options {
+	const char *device;
+	enum link_type link;
+	enum write_value_type type;
+	uint16_t offset;
+	uint16_t mtu;
+	bool prepare_authorize;
+};
+
+struct acquire_notify_options {
+	const char *device;
+	enum link_type link;
+	uint16_t mtu;
+};
+
+/* MshPRT_v1.1, section 6.3.1, SAR field */
+#define PROXY_PDA_SAR_SHIFT	6
+#define PROXY_PDA_SAR_MASK	0x3
+enum proxy_pdu_sar {
+	PROXY_PDU_SAR_CMPLT_MSG = 0x00,
+	PROXY_PDU_SAR_1ST_SEG   = 0x01,
+	PROXY_PDU_SAR_CONT_SEG  = 0x02,
+	PROXY_PDU_SAR_LAST_SEG  = 0x03,
+};
+
+struct gatt_service {
+	const char *svc_uuid;
+	uint8_t max_pdu_len;
+
+	gatt_service_notify_acquired_cb notify_acquired_cb;
+	gatt_service_notify_stopped_cb notify_stopped_cb;
+	gatt_service_rx_cb rx_cb;
+	gatt_service_tx_cmplt_cb tx_cmplt_cb;
+	gatt_service_fill_adv_service_data_cb fill_adv_service_data_cb;
+	struct characterstic chrc_data_in;
+	struct characterstic chrc_data_out;
+
+	struct l_dbus_client *dbus_client;
+	struct l_dbus_proxy *dbus_proxy_gatt_mgr;
+	struct l_dbus_proxy *dbus_proxy_le_adv_mgr;
+
+	/*
+	 * ToDo: Check whether acceptors timeout complies with MshPRT_v1.1,
+	 * section 5.2.2
+	 */
+	struct l_io *notify_io;
+	uint16_t mtu;
+	uint8_t *sar;
+	uint8_t *sar_out;
+	uint8_t msg_type;
+	uint8_t sar_len;
+	void *user_data;
+
+	gatt_destroy_cb svc_deinit_cb;
+	gatt_destroy_cb adv_deinit_cb;
+
+	gatt_destroy_cb destroy_cb;
+	void *destroy_data;
+};
+
+static struct gatt_service *gatt_service = NULL;
+
+static bool notify_write(struct l_io *io, void *user_data)
+{
+	struct gatt_service *service = user_data;
+	unsigned int remaining = (service->sar + service->sar_len)
+						- service->sar_out;
+	unsigned max_size = service->mtu - 5;
+	struct iovec iov[2];
+	struct msghdr msg;
+	bool more = false;
+	uint8_t sar_type;
+	int i, count;
+
+	/* Note: One extra byte is required for sar_type */
+	if (service->sar_len < max_size) {
+		sar_type = PROXY_PDU_SAR_CMPLT_MSG;
+		count = service->sar_len;
+	}
+	else if (service->sar_out == service->sar) {
+		sar_type = PROXY_PDU_SAR_1ST_SEG;
+		count = max_size - 1;
+		more = true;
+	}
+	else if (remaining < max_size) {
+		sar_type = PROXY_PDU_SAR_LAST_SEG;
+		count = remaining;
+	}
+	else {
+		sar_type = PROXY_PDU_SAR_CONT_SEG;
+		count = max_size - 1;
+		more = true;
+	}
+
+	sar_type <<= PROXY_PDA_SAR_SHIFT;
+	sar_type |= service->msg_type;
+
+//	l_info("remaining=%u, count=%u, sar_type=0x%02x", remaining, count, sar_type);
+//	print_packet("notify_write", service->sar_out, count);
+
+	iov[0].iov_base = &sar_type;
+	iov[0].iov_len = sizeof(sar_type);
+	iov[1].iov_base = service->sar_out;
+	iov[1].iov_len = count;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = iov;
+	msg.msg_iovlen = L_ARRAY_SIZE(iov);
+
+	if (sendmsg(l_io_get_fd(service->notify_io), &msg, MSG_NOSIGNAL) < 0)
+		l_error("Cannot write notification data: %s", strerror(errno));
+
+	service->sar_out += count;
+
+	if (!more)
+		more = service->tx_cmplt_cb(service->user_data);
+
+	return more;
+}
+
+void gatt_service_tx(struct gatt_service *service, uint8_t msg_type,
+						const void *data, uint16_t len)
+{
+	if (!service || gatt_service != service)
+		return;
+
+	if (len > service->max_pdu_len) {
+		l_error("Frame too long");
+		return;
+	}
+
+	if (!service->notify_io) {
+		l_warn("Not connected, dropping TX message...");
+		return;
+	}
+
+	memcpy(service->sar, data, len);
+	service->sar_len = len;
+	service->sar_out = service->sar;
+	service->msg_type = msg_type;
+	print_packet("TX-GATT", service->sar, service->sar_len);
+	l_io_set_write_handler(service->notify_io, notify_write, service, NULL);
+}
+
+static bool svc_uuid_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct gatt_service *service = user_data;
+
+//	l_info("svc_uuid_getter");
+	return l_dbus_message_builder_append_basic(builder, 's',
+							service->svc_uuid);
+}
+
+static bool svc_primary_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	bool primary = true;
+
+//	l_info("svc_primary_getter");
+	return l_dbus_message_builder_append_basic(builder, 'b', &primary);
+}
+
+static void setup_gatt_svc_interface(struct l_dbus_interface *iface)
+{
+	l_dbus_interface_property(iface, "UUID", 0, "s", svc_uuid_getter, NULL);
+	l_dbus_interface_property(iface, "Primary", 0, "b", svc_primary_getter,
+									NULL);
+}
+
+static bool parse_write_value_options(struct l_dbus_message_iter *itr,
+					struct write_value_options *opts)
+{
+	const char *key;
+	struct l_dbus_message_iter var;
+
+	opts->device = NULL;
+	opts->link = LINK_TYPE_BR_EDR;
+	opts->type = WRITE_VALUE_TYPE_COMMAND;
+	opts->offset = 0;
+	opts->mtu = 0;
+	opts->prepare_authorize = false;
+
+	while (l_dbus_message_iter_next_entry(itr, &key, &var)) {
+		if (!strcmp(key, "device")) {
+			if (!l_dbus_message_iter_get_variant(&var, "o",
+								&opts->device))
+				return false;
+		} else if (!strcmp(key, "link")) {
+			const char *link;
+
+			if (!l_dbus_message_iter_get_variant(&var, "s", &link))
+				return false;
+
+			if (!strcmp(link, "BR/EDR"))
+				opts->link = LINK_TYPE_BR_EDR;
+			else if (!strcmp(link, "LE"))
+				opts->link = LINK_TYPE_LE;
+			else
+				return false;
+		} else if (!strcmp(key, "type")) {
+			const char *type;
+
+			if (!l_dbus_message_iter_get_variant(&var, "s", &type))
+				return false;
+
+			if (!strcmp(type, "command"))
+				opts->type = WRITE_VALUE_TYPE_COMMAND;
+			else if (!strcmp(type, "request"))
+				opts->type = WRITE_VALUE_TYPE_REQUEST;
+			else if (!strcmp(type, "reliable"))
+				opts->type = WRITE_VALUE_TYPE_RELIABLE;
+			else
+				return false;
+		} else if (!strcmp(key, "offset")) {
+			if (!l_dbus_message_iter_get_variant(&var, "q",
+								&opts->offset))
+				return false;
+		} else if (!strcmp(key, "mtu")) {
+			if (!l_dbus_message_iter_get_variant(&var, "q",
+								&opts->mtu))
+				return false;
+		} else if (!strcmp(key, "prepare-authorize")) {
+			if (!l_dbus_message_iter_get_variant(&var, "b",
+						&opts->prepare_authorize))
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static struct l_dbus_message *chrc_write_value_call(struct l_dbus *,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct characterstic *chr = user_data;
+	struct gatt_service *service = chr->service;
+	struct l_dbus_message_iter iter_data, dict;
+	struct write_value_options opts;
+	enum proxy_pdu_sar sar;
+	uint8_t msg_type;
+	uint8_t *data;
+	uint32_t len;
+	int i;
+
+	if (!l_dbus_message_get_arguments(msg, "aya{sv}", &iter_data, &dict))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (!parse_write_value_options(&dict, &opts))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
+					!len || len > service->max_pdu_len)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Incorrect data");
+
+//	l_info("chrc_write_value_call(type=%u, offset=%u, mtu=%u)", opts.type, opts.offset, opts.mtu);
+//	print_packet("WriteValue", data, len);
+
+	if (len < 1)
+		return l_dbus_message_new_method_return(msg);
+
+	sar = (data[0] >> PROXY_PDA_SAR_SHIFT) & PROXY_PDA_SAR_MASK;
+	msg_type = data[0] & PROXY_MSG_TYPE_MASK;
+
+	switch (sar)  {
+		case PROXY_PDU_SAR_CMPLT_MSG:
+			print_packet("RX-GATT", data, len);
+			service->rx_cb(service->user_data, msg_type, data, len);
+			break;
+
+		case PROXY_PDU_SAR_1ST_SEG:
+			if (len > service->max_pdu_len) {
+				l_debug("Length exceeded: %d", len);
+				break;
+			}
+
+			memcpy(service->sar, data, len);
+			service->sar_len = len;
+			break;
+
+		case PROXY_PDU_SAR_CONT_SEG:
+		case PROXY_PDU_SAR_LAST_SEG: {
+			if (len - 1 > service->max_pdu_len - service->sar_len) {
+				l_debug("Length exceeded: %d", len);
+				break;
+			}
+
+			memcpy(service->sar + service->sar_len,
+							data + 1, len - 1);
+			service->sar_len += len - 1;
+
+			if (sar == PROXY_PDU_SAR_LAST_SEG) {
+				uint8_t sar_len = service->sar_len;
+
+				/* reused by gatt_service_tx */
+				service->sar_len = 0;
+				print_packet("RX-GATT", service->sar, sar_len);
+				service->rx_cb(service->user_data, msg_type,
+							service->sar, sar_len);
+			}
+
+			break;
+		}
+	}
+
+	return l_dbus_message_new_method_return(msg);
+}
+
+static bool parse_acquire_notify_options(struct l_dbus_message_iter *itr,
+					struct acquire_notify_options *opts)
+{
+	const char *key;
+	struct l_dbus_message_iter var;
+
+	opts->device = NULL;
+	opts->link = LINK_TYPE_BR_EDR;
+	opts->mtu = 0;
+
+	while (l_dbus_message_iter_next_entry(itr, &key, &var)) {
+		if (!strcmp(key, "device")) {
+			if (!l_dbus_message_iter_get_variant(&var, "o",
+								&opts->device))
+				return false;
+		} else if (!strcmp(key, "link")) {
+			const char *link;
+
+			if (!l_dbus_message_iter_get_variant(&var, "s", &link))
+				return false;
+
+			if (!strcmp(link, "BR/EDR"))
+				opts->link = LINK_TYPE_BR_EDR;
+			else if (!strcmp(link, "LE"))
+				opts->link = LINK_TYPE_LE;
+			else
+				return false;
+		} else if (!strcmp(key, "mtu")) {
+			if (!l_dbus_message_iter_get_variant(&var, "q",
+								&opts->mtu))
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static void notify_disconnected(struct l_io *io, void *user_data)
+{
+	struct gatt_service *service = user_data;
+
+	if (service != gatt_service)
+		return;
+
+	l_debug("notify_disconnected");
+
+	if (!service->notify_io)
+		return;
+
+	/* avoid recursion */
+	l_io_set_disconnect_handler(service->notify_io, NULL, NULL, NULL);
+
+	l_io_destroy(service->notify_io);
+	service->notify_io = NULL;
+
+	if (service->notify_stopped_cb)
+		service->notify_stopped_cb(service->user_data);
+}
+
+static struct l_dbus_message *chrc_acquire_notify_call(struct l_dbus *,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct characterstic *chr = user_data;
+	struct gatt_service *service = chr->service;
+	struct l_dbus_message_iter dict;
+	struct acquire_notify_options opts;
+	struct l_dbus_message *reply;
+	int fds[2];
+
+	l_debug("AcquireNotify");
+
+	if (!l_dbus_message_get_arguments(msg, "a{sv}", &dict))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (!parse_acquire_notify_options(&dict, &opts))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (socketpair(AF_UNIX,
+			SOCK_SEQPACKET | SOCK_NONBLOCK | SOCK_CLOEXEC,
+							0, fds) == -1)
+		return dbus_error(msg, MESH_ERROR_FAILED,
+						"Cannot create socket");
+
+	service->notify_io = l_io_new(fds[0]);
+	l_io_set_close_on_destroy(service->notify_io, true);
+	l_io_set_disconnect_handler(service->notify_io, notify_disconnected,
+								service, NULL);
+	service->mtu = opts.mtu;
+	l_debug("AcquireNotify: mtu=%u", opts.mtu);
+
+	if (service->notify_acquired_cb)
+		service->notify_acquired_cb(service->user_data);
+
+	reply = l_dbus_message_new_method_return(msg);
+
+	/* l_dbus_message_builder_append_basic() cannot append UNIX FDs */
+	l_dbus_message_set_arguments(reply, "hq", fds[1], service->mtu);
+	/*
+	 * file descriptor for bluetoothd has just been dup'ed and must be
+	 * closed here in order to get disconnect event after GATT notifications
+	 * notifications have been disabled.
+	 */
+	close(fds[1]);
+
+	return reply;
+}
+
+static bool chrc_uuid_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct characterstic *chr = user_data;
+
+	const char *path = l_dbus_message_get_path(msg);
+	const char *interface = l_dbus_message_get_interface(msg);
+	const char *member = l_dbus_message_get_member(msg);
+
+//	l_info("chrc_uuid_getter(path=%s, interface=%s, member=%s)", path, interface, member);
+	return l_dbus_message_builder_append_basic(builder, 's', chr->uuid);
+}
+
+static bool chrc_service_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+//	l_info("chrc_service_getter");
+	return l_dbus_message_builder_append_basic(builder, 'o',
+						BLUEZ_MESH_SERVICE_PATH);
+}
+
+static bool chrc_notify_acquired_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct characterstic *chr = user_data;
+	const struct gatt_service *service = chr->service;
+	bool notifying = !!service->notify_io;
+
+//	l_info("chrc_notify_acquired_getter");
+
+	return l_dbus_message_builder_append_basic(builder, 'b', &notifying);
+}
+
+static bool chrc_flags_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct characterstic *chr = user_data;
+	const char * const *flag = chr->flags;
+
+//	l_info("chrc_flags_getter");
+
+	l_dbus_message_builder_enter_array(builder, "s");
+
+	while (*flag)
+		l_dbus_message_builder_append_basic(builder, 's', *flag++);
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static void setup_gatt_chrc_interface(struct l_dbus_interface *iface)
+{
+	/* Note: "ReadValue" method is not supported. */
+	l_dbus_interface_method(iface, "WriteValue" , 0, chrc_write_value_call,
+							"", "aya{sv}",
+							"value", "options");
+	l_dbus_interface_method(iface, "AcquireNotify", 0,
+							chrc_acquire_notify_call,
+							"hq", "a{sv}",
+							"fd", "mtu",
+							"options");
+	l_dbus_interface_property(iface, "UUID"   , 0, "s", chrc_uuid_getter,
+									NULL);
+	l_dbus_interface_property(iface, "Service", 0, "o", chrc_service_getter,
+									NULL);
+	l_dbus_interface_property(iface, "NotifyAcquired", 0, "b",
+					chrc_notify_acquired_getter, NULL);
+	l_dbus_interface_property(iface, "Flags"  , 0, "as", chrc_flags_getter,
+									NULL);
+}
+
+static void register_app_setup(struct l_dbus_message *msg, void *user_data)
+{
+	struct l_dbus_message_builder *builder;
+
+//	l_info("register_app_setup");
+
+	builder = l_dbus_message_builder_new(msg);
+
+	/* Object path */
+	l_dbus_message_builder_append_basic(builder, 'o', BLUEZ_MESH_GATT_PATH);
+
+	/* Options (empty) */
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_leave_dict(builder);
+	l_dbus_message_builder_leave_array(builder);
+
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void register_app_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+//	l_info("register_app_reply");
+
+	if (l_dbus_message_is_error(result)) {
+		const char *error;
+
+		l_dbus_message_get_error(result, &error, NULL);
+
+		l_error("Registration of GATT application failed: %s", error);
+	}
+}
+
+static bool gatt_svc_init(struct l_dbus *dbus, struct l_dbus_proxy *dbus_proxy,
+					struct gatt_service *service)
+{
+	if (!l_dbus_register_interface(dbus, GATT_SERVICE_IFACE,
+						setup_gatt_svc_interface,
+						NULL, false)) {
+		l_error("Cannot register " GATT_SERVICE_IFACE " interface");
+		goto error_return;
+	}
+
+	if (!l_dbus_register_interface(dbus, GATT_CHRC_IFACE,
+						setup_gatt_chrc_interface,
+						NULL, false)) {
+		l_error("Cannot register " GATT_CHRC_IFACE " interface");
+		goto error_unregister_svc_iface;
+	}
+
+	if (!l_dbus_object_add_interface(dbus, BLUEZ_MESH_SERVICE_PATH,
+						GATT_SERVICE_IFACE, service)) {
+		l_error("Cannot add GATT service");
+		goto error_unregister_chrc_iface;
+	}
+
+	if (!l_dbus_object_add_interface(dbus, BLUEZ_MESH_CHRC_DATA_IN_PATH,
+						GATT_CHRC_IFACE,
+						&service->chrc_data_in)) {
+		l_error("Cannot add GATT Data In characteristic");
+		goto error_remove_svc;
+	}
+
+	if (!l_dbus_object_add_interface(dbus, BLUEZ_MESH_CHRC_DATA_OUT_PATH,
+						GATT_CHRC_IFACE,
+						&service->chrc_data_out)) {
+		l_error("Cannot add GATT Data Out characteristic");
+		goto error_remove_data_in_chrc;
+	}
+
+	if (!l_dbus_object_manager_enable(dbus, BLUEZ_MESH_GATT_PATH)) {
+		l_error("Cannot enable object manager");
+		goto error_remove_data_out_chrc;
+	}
+
+	if (!l_dbus_proxy_method_call(dbus_proxy, "RegisterApplication",
+						register_app_setup,
+						register_app_reply,
+						NULL, NULL)) {
+		l_error("Cannot register GATT application");
+		goto error_disable_object_manager;
+	}
+
+	return true;
+
+error_disable_object_manager:
+	l_dbus_object_remove_interface(dbus, BLUEZ_MESH_GATT_PATH,
+					L_DBUS_INTERFACE_OBJECT_MANAGER);
+
+error_remove_data_out_chrc:
+	l_dbus_object_remove_interface(dbus, BLUEZ_MESH_CHRC_DATA_OUT_PATH,
+							GATT_CHRC_IFACE);
+
+error_remove_data_in_chrc:
+	l_dbus_object_remove_interface(dbus, BLUEZ_MESH_CHRC_DATA_IN_PATH,
+							GATT_CHRC_IFACE);
+
+error_remove_svc:
+	l_dbus_object_remove_interface(dbus, BLUEZ_MESH_SERVICE_PATH,
+							GATT_SERVICE_IFACE);
+
+error_unregister_chrc_iface:
+	l_dbus_unregister_interface(dbus, GATT_CHRC_IFACE);
+
+error_unregister_svc_iface:
+	l_dbus_unregister_interface(dbus, GATT_SERVICE_IFACE);
+
+error_return:
+	return false;
+}
+
+static void unregister_app_setup(struct l_dbus_message *msg, void *user_data)
+{
+	struct l_dbus_message_builder *builder;
+
+//	l_info("unregister_app_setup");
+
+	builder = l_dbus_message_builder_new(msg);
+
+	/* Object path */
+	l_dbus_message_builder_append_basic(builder, 'o', BLUEZ_MESH_GATT_PATH);
+
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void unregister_app_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct gatt_service *service = user_data;
+	struct l_dbus *dbus = dbus_get_bus();
+//	l_info("unregister_app_reply");
+
+	if (l_dbus_message_is_error(result)) {
+		const char *error;
+
+		l_dbus_message_get_error(result, &error, NULL);
+
+		l_error("Unregistration of GATT application failed: %s", error);
+	}
+
+	l_dbus_object_remove_interface(dbus, BLUEZ_MESH_GATT_PATH,
+					L_DBUS_INTERFACE_OBJECT_MANAGER);
+
+	l_dbus_object_remove_interface(dbus, BLUEZ_MESH_CHRC_DATA_OUT_PATH,
+							GATT_CHRC_IFACE);
+
+	l_dbus_object_remove_interface(dbus, BLUEZ_MESH_CHRC_DATA_IN_PATH,
+							GATT_CHRC_IFACE);
+
+	l_dbus_object_remove_interface(dbus, BLUEZ_MESH_SERVICE_PATH,
+							GATT_SERVICE_IFACE);
+
+	l_dbus_unregister_interface(dbus, GATT_CHRC_IFACE);
+	l_dbus_unregister_interface(dbus, GATT_SERVICE_IFACE);
+
+	if (service->svc_deinit_cb)
+		service->svc_deinit_cb(service);
+}
+
+static void gatt_svc_deinit(struct gatt_service *service, gatt_destroy_cb cb)
+{
+	service->svc_deinit_cb = cb;
+
+	if (!l_dbus_proxy_method_call(service->dbus_proxy_gatt_mgr,
+							"UnregisterApplication",
+							unregister_app_setup,
+							unregister_app_reply,
+							service, NULL)) {
+		l_error("Cannot unregister GATT application");
+	}
+}
+
+static struct l_dbus_message *adv_release_call(struct l_dbus *,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	l_debug("ADV Release");
+
+	return NULL;
+}
+
+static bool adv_type_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+//	l_info("adv_type_getter");
+
+	return l_dbus_message_builder_append_basic(builder, 's', "peripheral");
+}
+
+static bool adv_svc_uuids_getter(struct l_dbus *dbus,
+					struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct gatt_service *service = user_data;
+
+//	l_info("adv_svc_uuids_getter");
+	l_dbus_message_builder_enter_array(builder, "s");
+	l_dbus_message_builder_append_basic(builder, 's', service->svc_uuid);
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static bool adv_svc_data_getter(struct l_dbus *dbus,
+					struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct gatt_service *service = user_data;
+
+//	l_info("adv_svc_data_getter");
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', service->svc_uuid);
+	l_dbus_message_builder_enter_variant(builder, "ay");
+
+	if (!service->fill_adv_service_data_cb(service->user_data, builder))
+		return false;
+
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static bool adv_local_name_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	uint16_t max_interval_ms = 1000;
+	uint16_t duration = 1 * max_interval_ms;
+
+//	l_info("adv_local_name_getter");
+
+	return l_dbus_message_builder_append_basic(builder, 's', "Test");
+}
+
+static bool adv_duration_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	uint16_t max_interval_ms = 1000;
+	uint16_t duration = 1 * max_interval_ms;
+
+//	l_info("adv_duration_getter");
+
+	return l_dbus_message_builder_append_basic(builder, 'q', &duration);
+}
+
+static bool adv_timeout_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	uint16_t timeout = 1000;
+
+//	l_info("adv_timeout_getter");
+
+	return l_dbus_message_builder_append_basic(builder, 'q', &timeout);
+}
+
+static bool adv_min_interval_getter(struct l_dbus *dbus,
+					struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	uint32_t min_interval_ms = 1000;
+
+//	l_info("adv_min_interval_getter");
+
+	return l_dbus_message_builder_append_basic(builder, 'u',
+							&min_interval_ms);
+}
+
+static bool adv_max_interval_getter(struct l_dbus *dbus,
+					struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	uint32_t max_interval_ms = 1000;
+
+//	l_info("adv_max_interval_getter");
+
+	return l_dbus_message_builder_append_basic(builder, 'u',
+							&max_interval_ms);
+}
+
+static void setup_le_adv_interface(struct l_dbus_interface *iface)
+{
+	l_dbus_interface_method(iface, "Release", 0, adv_release_call,
+						"", "");
+	l_dbus_interface_property(iface, "Type", 0, "s",
+						adv_type_getter, NULL);
+	l_dbus_interface_property(iface, "ServiceUUIDs", 0, "as",
+						adv_svc_uuids_getter, NULL);
+	l_dbus_interface_property(iface, "ServiceData", 0, "a{sv}",
+						adv_svc_data_getter, NULL);
+	l_dbus_interface_property(iface, "LocalName", 0, "s",
+						adv_local_name_getter, NULL);
+	l_dbus_interface_property(iface, "Duration", 0, "q",
+						adv_duration_getter, NULL);
+	l_dbus_interface_property(iface, "Timeout", 0, "q",
+						adv_timeout_getter, NULL);
+	l_dbus_interface_property(iface, "MinInterval", 0, "u",
+						adv_min_interval_getter, NULL);
+	l_dbus_interface_property(iface, "MaxInterval", 0, "u",
+						adv_max_interval_getter, NULL);
+}
+
+static void register_adv_setup(struct l_dbus_message *msg, void *user_data)
+{
+	struct l_dbus_message_builder *builder;
+
+//	l_info("register_adv_setup");
+	builder = l_dbus_message_builder_new(msg);
+
+	/* Object path */
+	l_dbus_message_builder_append_basic(builder, 'o',
+						BLUEZ_MESH_GATT_ADV_PATH);
+
+	/* Options (empty) */
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_leave_dict(builder);
+	l_dbus_message_builder_leave_array(builder);
+
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void register_adv_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+//	l_info("register_adv_reply");
+	if (l_dbus_message_is_error(result)) {
+		const char *error;
+
+		l_dbus_message_get_error(result, &error, NULL);
+
+		l_error("Registration of LE advertising failed: %s", error);
+	}
+}
+
+static bool gatt_adv_init(struct l_dbus *dbus, struct l_dbus_proxy *dbus_proxy,
+					struct gatt_service *service)
+{
+	if (!l_dbus_register_interface(dbus, LE_ADVERTISEMENT_IFACE,
+							setup_le_adv_interface,
+							NULL, false)) {
+		l_error("Cannot register " LE_ADVERTISEMENT_IFACE " interface");
+		goto error_return;
+	}
+
+	if (!l_dbus_object_add_interface(dbus, BLUEZ_MESH_GATT_ADV_PATH,
+						LE_ADVERTISEMENT_IFACE,
+						service)) {
+		l_error("Cannot add provisioner LE advertising service");
+		goto error_unregister_le_adv_iface;
+	}
+
+	if (!l_dbus_object_manager_enable(dbus, BLUEZ_MESH_GATT_ADV_PATH)) {
+		l_error("Cannot enable object manager");
+		goto error_remove_le_adv;
+	}
+
+	/*
+	 * org.freedesktop.DBus.Properties is required for building
+	 * propertiesChanged signals
+	 */
+	if (!l_dbus_object_add_interface(dbus, BLUEZ_MESH_GATT_ADV_PATH,
+					L_DBUS_INTERFACE_PROPERTIES, NULL)) {
+		l_error("Cannot add LE advertising properties");
+		goto error_disable_object_manager;
+	}
+
+	if (!l_dbus_proxy_method_call(dbus_proxy, "RegisterAdvertisement",
+						register_adv_setup,
+						register_adv_reply,
+						NULL, NULL)) {
+		l_error("Cannot register LE advertisement");
+		goto error_remove_properties_iface;
+	}
+
+	return true;
+
+error_remove_properties_iface:
+	l_dbus_object_remove_interface(dbus, BLUEZ_MESH_GATT_ADV_PATH,
+						L_DBUS_INTERFACE_PROPERTIES);
+
+error_disable_object_manager:
+	l_dbus_object_remove_interface(dbus, BLUEZ_MESH_GATT_ADV_PATH,
+					L_DBUS_INTERFACE_OBJECT_MANAGER);
+
+error_remove_le_adv:
+	l_dbus_object_remove_interface(dbus, BLUEZ_MESH_GATT_ADV_PATH,
+					LE_ADVERTISEMENT_IFACE);
+
+error_unregister_le_adv_iface:
+	l_dbus_unregister_interface(dbus, LE_ADVERTISEMENT_IFACE);
+
+error_return:
+	return false;
+}
+
+static void unregister_adv_setup(struct l_dbus_message *msg, void *user_data)
+{
+	struct l_dbus_message_builder *builder;
+
+//	l_info("unregister_adv_setup");
+
+	builder = l_dbus_message_builder_new(msg);
+
+	/* Object path */
+	l_dbus_message_builder_append_basic(builder, 'o', BLUEZ_MESH_GATT_ADV_PATH);
+
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void unregister_adv_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct gatt_service *service = user_data;
+	struct l_dbus *dbus = dbus_get_bus();
+//	l_info("unregister_adv_reply");
+
+	if (l_dbus_message_is_error(result)) {
+		const char *error;
+
+		l_dbus_message_get_error(result, &error, NULL);
+
+		l_error("Unregistration of LE advertisement failed: %s", error);
+	}
+
+	l_dbus_object_remove_interface(dbus, BLUEZ_MESH_GATT_ADV_PATH,
+						L_DBUS_INTERFACE_PROPERTIES);
+
+	l_dbus_object_remove_interface(dbus, BLUEZ_MESH_GATT_ADV_PATH,
+					L_DBUS_INTERFACE_OBJECT_MANAGER);
+
+	l_dbus_object_remove_interface(dbus, BLUEZ_MESH_GATT_ADV_PATH,
+					LE_ADVERTISEMENT_IFACE);
+
+	l_dbus_unregister_interface(dbus, LE_ADVERTISEMENT_IFACE);
+
+	if (service->adv_deinit_cb)
+		service->adv_deinit_cb(service);
+}
+
+static void gatt_adv_deinit(struct gatt_service *service, gatt_destroy_cb cb)
+{
+	service->adv_deinit_cb = cb;
+
+	if (!l_dbus_proxy_method_call(service->dbus_proxy_le_adv_mgr,
+							"UnregisterAdvertisement",
+							unregister_adv_setup,
+							unregister_adv_reply,
+							service, NULL)) {
+		l_error("Cannot unregister LE advertisement");
+	}
+}
+
+static void dbus_proxy_added(struct l_dbus_proxy *dbus_proxy, void *user_data)
+{
+	const char *interface = l_dbus_proxy_get_interface(dbus_proxy);
+	const char *path = l_dbus_proxy_get_path(dbus_proxy);
+	struct gatt_service *service = user_data;
+
+	l_debug("Proxy added: %s (%s)", interface, path);
+
+	if (!strcmp(interface, GATT_MGR_IFACE)) {
+		service->dbus_proxy_gatt_mgr = dbus_proxy;
+		gatt_svc_init(dbus_get_bus(), dbus_proxy, service);
+	} else if (!strcmp(interface, LE_ADVERTISING_MGR_IFACE)) {
+		service->dbus_proxy_le_adv_mgr = dbus_proxy;
+		gatt_adv_init(dbus_get_bus(), dbus_proxy, service);
+	}
+}
+
+static void dbus_proxy_removed(struct l_dbus_proxy *proxy, void *user_data)
+{
+	const char *interface = l_dbus_proxy_get_interface(proxy);
+	const char *path = l_dbus_proxy_get_path(proxy);
+	struct gatt_service *service = user_data;
+
+	l_debug("Proxy removed: %s (%s)", interface, path);
+
+	if (!strcmp(interface, GATT_MGR_IFACE))
+		service->dbus_proxy_gatt_mgr = NULL;
+	else if (!strcmp(interface, LE_ADVERTISING_MGR_IFACE))
+		service->dbus_proxy_le_adv_mgr = NULL;
+}
+
+struct gatt_service *
+gatt_service_create(
+		const char *svc_uuid,
+		const char *chrc_data_in_uuid,
+		const char *chrc_data_out_uuid,
+		uint8_t max_pdu_len,
+		gatt_service_notify_acquired_cb notify_acquired_cb,
+		gatt_service_notify_stopped_cb notify_stopped_cb,
+		gatt_service_rx_cb rx_cb,
+		gatt_service_tx_cmplt_cb tx_cmplt_cb,
+		gatt_service_fill_adv_service_data_cb fill_adv_service_data_cb,
+		void *user_data)
+{
+	static const char *flags_data_in[] = {"write-without-response", NULL};
+	static const char *flags_data_out[] = {"notify", NULL};
+
+	/* Only one GATT service may exist at a time (MshPRT_v1.1, chapter 7) */
+	if (gatt_service)
+		return NULL;
+
+	gatt_service = l_new(struct gatt_service, 1);
+	gatt_service->svc_uuid = svc_uuid;
+	gatt_service->max_pdu_len = max_pdu_len;
+	gatt_service->sar = l_malloc(max_pdu_len);
+
+	gatt_service->notify_acquired_cb = notify_acquired_cb;
+	gatt_service->notify_stopped_cb = notify_stopped_cb;
+	gatt_service->rx_cb = rx_cb;
+	gatt_service->tx_cmplt_cb = tx_cmplt_cb;
+	gatt_service->fill_adv_service_data_cb = fill_adv_service_data_cb;
+	gatt_service->user_data = user_data;
+	gatt_service->mtu = GATT_MTU;
+
+	gatt_service->chrc_data_in.uuid = chrc_data_in_uuid;
+	gatt_service->chrc_data_in.flags = flags_data_in;
+	gatt_service->chrc_data_in.service = gatt_service;
+
+	gatt_service->chrc_data_out.uuid = chrc_data_out_uuid;
+	gatt_service->chrc_data_out.flags = flags_data_out;
+	gatt_service->chrc_data_out.service = gatt_service;
+
+	gatt_service->dbus_client = l_dbus_client_new(dbus_get_bus(),
+						"org.bluez", "/org/bluez");
+
+	l_dbus_client_set_proxy_handlers(gatt_service->dbus_client,
+						dbus_proxy_added,
+						dbus_proxy_removed,
+						NULL,
+						gatt_service, NULL);
+
+	return gatt_service;
+}
+
+static void gatt_svc_destroy(void *user_data)
+{
+	struct gatt_service *service = user_data;
+	gatt_destroy_cb destroy_cb;
+	void *destroy_data;
+
+	if (!gatt_service || gatt_service != service)
+		return;
+
+	destroy_cb = service->destroy_cb;
+	destroy_data = service->destroy_data;
+
+	l_dbus_client_destroy(service->dbus_client);
+	l_io_destroy(service->notify_io);
+	l_free(service->sar);
+	l_free(service);
+	gatt_service = NULL;
+
+	if (destroy_cb)
+		destroy_cb(destroy_data);
+}
+
+static void gatt_svc_deinit_finished(void *user_data)
+{
+	struct gatt_service *service = user_data;
+
+	if (!gatt_service || gatt_service != service)
+		return;
+
+	/* l_dbus_client_destroy() must not be called from dbus context */
+	l_idle_oneshot(gatt_svc_destroy, service, NULL);
+}
+
+static void gatt_adv_deinit_finished(void *user_data)
+{
+	struct gatt_service *service = user_data;
+
+	if (!gatt_service || gatt_service != service)
+		return;
+
+	gatt_svc_deinit(service, gatt_svc_deinit_finished);
+}
+
+void gatt_service_destroy(struct gatt_service *service,
+				gatt_destroy_cb destroy_cb, void *user_data)
+{
+	if (!gatt_service || gatt_service != service)
+		return;
+
+	/* avoid recursion */
+	l_io_set_disconnect_handler(service->notify_io, NULL, NULL, NULL);
+
+	service->destroy_cb = destroy_cb;
+	service->destroy_data = user_data;
+	gatt_adv_deinit(service, gatt_adv_deinit_finished);
+}
+
+void gatt_service_adv_updated(struct gatt_service *service)
+{
+	if (!gatt_service || gatt_service != service)
+		return;
+
+	l_dbus_property_changed(dbus_get_bus(), BLUEZ_MESH_GATT_ADV_PATH,
+					LE_ADVERTISEMENT_IFACE, "ServiceData");
+}
diff --git a/mesh/gatt-service.h b/mesh/gatt-service.h
new file mode 100644
index 000000000000..96b3eff2f3dc
--- /dev/null
+++ b/mesh/gatt-service.h
@@ -0,0 +1,54 @@
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
+#include <stdbool.h>
+#include <stdint.h>
+
+/* MshPRT_v1.1, section 6.3.1 */
+#define PROXY_MSG_TYPE_MASK	0x3F
+enum proxy_msg_type {
+	PROXY_MSG_TYPE_NETWORK_PDU = 0x00,
+	PROXY_MSG_TYPE_MESH_BEACON = 0x01,
+	PROXY_MSG_TYPE_PROXY_CFG   = 0x02,
+	PROXY_MSG_TYPE_PROV_PDU    = 0x03
+};
+
+typedef void (*gatt_service_notify_acquired_cb)(void *user_data);
+typedef void (*gatt_service_notify_stopped_cb)(void *user_data);
+typedef void (*gatt_service_rx_cb)(void *user_data,
+					enum proxy_msg_type messageType,
+					const void *data, uint16_t len);
+typedef bool (*gatt_service_tx_cmplt_cb)(void *user_data);
+typedef bool (*gatt_service_fill_adv_service_data_cb)(void *user_data,
+					struct l_dbus_message_builder *builder);
+
+typedef void (*gatt_destroy_cb)(void *user_data);
+
+struct gatt_service;
+
+struct gatt_service *
+gatt_service_create(
+		const char *svc_uuid,
+		const char *chrc_data_in_uuid,
+		const char *chrc_data_out_uuid,
+		uint8_t max_pdu_len,
+		gatt_service_notify_acquired_cb notify_acquired_cb,
+		gatt_service_notify_stopped_cb notify_stopped_cb,
+		gatt_service_rx_cb rx_cb,
+		gatt_service_tx_cmplt_cb tx_cmplt_cb,
+		gatt_service_fill_adv_service_data_cb fill_adv_service_data_cb,
+		void *user_data);
+
+void gatt_service_destroy(struct gatt_service *service,
+				gatt_destroy_cb destroy_cb, void *user_data);
+
+void gatt_service_tx(struct gatt_service *service, uint8_t msg_type,
+						const void *data, uint16_t len);
+void gatt_service_adv_updated(struct gatt_service *service);
diff --git a/mesh/pb-gatt.c b/mesh/pb-gatt.c
new file mode 100644
index 000000000000..797dd7361ee1
--- /dev/null
+++ b/mesh/pb-gatt.c
@@ -0,0 +1,173 @@
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
+#include <string.h>			// memcpy()
+#include <sys/types.h>			// struct timeval [required by prov.h]
+
+#include <ell/dbus.h>
+//#include <ell/log.h>
+//#include <ell/timeout.h>
+#include <ell/util.h>			// l_new(), l_free()
+
+#include "mesh/gatt-service.h"
+#include "mesh/net.h"			// mesh_net_prov_caps, required by prov.h
+#include "mesh/prov.h"			// mesh_prov_open_func_t,
+					// mesh_prov_close_func_t,
+					// mesh_prov_receive_func_t
+#include "mesh/provision.h"		// PB_GATT
+#include "mesh/pb-gatt.h"
+
+#define MESH_GATT_PROV_SVC_UUID "0x1827"
+#define MESH_GATT_PROV_CHRC_DATA_IN  "0x2ADB"
+#define MESH_GATT_PROV_CHRC_DATA_OUT "0x2ADC"
+#define MAX_PROXY_PROV_PDU_LEN 66  /* MshPRT_v1.1, section 7.1.3.1 / 7.1.3.2 */
+
+struct pb_gatt_session {
+	mesh_prov_open_func_t open_cb;
+	mesh_prov_close_func_t close_cb;
+	mesh_prov_receive_func_t rx_cb;
+	mesh_prov_ack_func_t ack_cb;
+//	struct l_timeout *tx_timeout;
+	uint8_t uuid[16];
+	uint16_t oob_info;
+
+	struct gatt_service *gatt_service;
+	void *user_data;
+
+	pb_gatt_destroy_cb destroy_cb;
+	void *destroy_data;
+};
+
+static struct pb_gatt_session *pb_session = NULL;
+
+static void pb_gatt_tx(void *user_data, const void *data, uint16_t len)
+{
+	struct pb_gatt_session *session = user_data;
+
+	gatt_service_tx(session->gatt_service, PROXY_MSG_TYPE_PROV_PDU, data, len);
+}
+
+static void gatt_notify_acquired_cb(void *user_data)
+{
+	struct pb_gatt_session *session = user_data;
+
+	/*
+	 * MshPRT_v1.1, section 5.2.2: The link is opened on a PB-GATT
+	 * bearer when the PB-GATT Client enables notifications.
+	 */
+	session->open_cb(session->user_data, pb_gatt_tx, session, PB_GATT);
+}
+
+static void gatt_notify_stopped_cb(void *user_data)
+{
+	struct pb_gatt_session *session = user_data;
+
+	session->close_cb(session->user_data, PROV_ERR_UNEXPECTED_ERR);
+}
+
+static void gatt_rx_cb(void *user_data, enum proxy_msg_type msg_type,
+						const void *data, uint16_t len)
+{
+	struct pb_gatt_session *session = user_data;
+
+	if (msg_type == PROXY_MSG_TYPE_PROV_PDU)
+		session->rx_cb(session->user_data, data + 1, len - 1);
+}
+
+static bool gatt_tx_cmplt_cb(void *user_data)
+{
+	struct pb_gatt_session *session = user_data;
+
+	session->ack_cb(session->user_data, 0 /* don't care */);
+	return false;
+}
+
+static bool gatt_fill_adv_service_data_cb(void *user_data,
+					struct l_dbus_message_builder *builder)
+{
+	struct pb_gatt_session *session = user_data;
+	uint8_t oob_info[2];
+	int i;
+
+	l_dbus_message_builder_enter_array(builder, "y");
+
+	for (i = 0; i < sizeof(session->uuid); i++)
+		l_dbus_message_builder_append_basic(builder, 'y',
+							&(session->uuid[i]));
+	l_put_be16(session->oob_info, oob_info);
+	for (i = 0; i < sizeof(oob_info); i++)
+		l_dbus_message_builder_append_basic(builder, 'y',
+							&(oob_info[i]));
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+bool pb_gatt_reg(mesh_prov_open_func_t open_cb, mesh_prov_close_func_t close_cb,
+		mesh_prov_receive_func_t rx_cb, mesh_prov_ack_func_t ack_cb,
+		const uint8_t *uuid, uint16_t oob_info, void *user_data)
+{
+	pb_session = l_new(struct pb_gatt_session, 1);
+
+	pb_session->open_cb = open_cb;
+	pb_session->close_cb = close_cb;
+	pb_session->rx_cb = rx_cb;
+	pb_session->ack_cb = ack_cb;
+
+	memcpy(pb_session->uuid, uuid, 16);
+	pb_session->user_data = user_data;
+
+	pb_session->gatt_service = gatt_service_create(MESH_GATT_PROV_SVC_UUID,
+						MESH_GATT_PROV_CHRC_DATA_IN,
+						MESH_GATT_PROV_CHRC_DATA_OUT,
+						MAX_PROXY_PROV_PDU_LEN,
+						gatt_notify_acquired_cb,
+						gatt_notify_stopped_cb,
+						gatt_rx_cb, gatt_tx_cmplt_cb,
+						gatt_fill_adv_service_data_cb,
+						pb_session);
+	if (!pb_session->gatt_service) {
+		l_free(pb_session);
+		pb_session = NULL;
+		return false;
+	}
+
+	return true;
+}
+
+static void gatt_destroy_finished(void *user_data)
+{
+	pb_gatt_destroy_cb destroy_cb;
+	void *destroy_data;
+
+	if (!pb_session || pb_session != user_data)
+		return;
+
+	destroy_cb = pb_session->destroy_cb;
+	destroy_data = pb_session->destroy_data;
+
+	l_free(pb_session);
+	pb_session = NULL;
+
+	if (destroy_cb)
+		destroy_cb(destroy_data);
+}
+
+void pb_gatt_unreg(void *user_data, pb_gatt_destroy_cb destroy_cb,
+							void *destroy_data)
+{
+	if (!pb_session || pb_session->user_data != user_data)
+		return;
+
+	pb_session->destroy_cb = destroy_cb;
+	pb_session->destroy_data = destroy_data;
+	gatt_service_destroy(pb_session->gatt_service, gatt_destroy_finished,
+								pb_session);
+}
diff --git a/mesh/pb-gatt.h b/mesh/pb-gatt.h
new file mode 100644
index 000000000000..49d95974c4ae
--- /dev/null
+++ b/mesh/pb-gatt.h
@@ -0,0 +1,20 @@
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
+#include <stdbool.h>
+#include <stdint.h>
+
+typedef void (*pb_gatt_destroy_cb)(void *user_data);
+
+bool pb_gatt_reg(mesh_prov_open_func_t open_cb, mesh_prov_close_func_t close_cb,
+		mesh_prov_receive_func_t rx_cb, mesh_prov_ack_func_t ack_cb,
+		const uint8_t *uuid, uint16_t oob_info, void *user_data);
+void pb_gatt_unreg(void *user_data, pb_gatt_destroy_cb destroy_cb,
+							void *destroy_data);
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index a83636280dd8..b3c538359a66 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -27,6 +27,7 @@
 #include "mesh/provision.h"
 #include "mesh/remprv.h"
 #include "mesh/pb-adv.h"
+#include "mesh/pb-gatt.h"
 #include "mesh/mesh.h"
 #include "mesh/agent.h"
 
@@ -100,6 +101,7 @@ static void acceptor_free(void)
 	mesh_send_cancel(&pkt_filter, sizeof(pkt_filter));
 
 	pb_adv_unreg(prov);
+	pb_gatt_unreg(prov, NULL, NULL);
 
 	l_free(prov);
 	prov = NULL;
@@ -801,6 +803,10 @@ bool acceptor_start(uint8_t num_ele, uint8_t *uuid,
 		/* Always register for PB-ADV */
 		result = pb_adv_reg(false, acp_prov_open, acp_prov_close,
 					acp_prov_rx, acp_prov_ack, uuid, prov);
+
+		result = pb_gatt_reg(acp_prov_open, acp_prov_close,
+					acp_prov_rx, acp_prov_ack, uuid,
+					caps->oob_info, prov);
 	} else {
 		/* Run Device Key Refresh Procedure */
 		result = register_nppi_acceptor(acp_prov_open, acp_prov_close,
-- 
2.43.0

