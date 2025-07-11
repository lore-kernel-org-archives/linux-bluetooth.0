Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D512F2374
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256813; cv=fail; b=KpdMQNmFmy8zD6j5TOeYZgmpR2Dxd44F0+1YwhZlKOLtabd+WOD6HKlCFiqzeVlGb0hKFaFN8QPCcvCI5bHjCb5dTvqElFG+AcPlVEftlMlq39rd9Fl7rCS++3s7SdWNPJo7eoZqt7peFEPZ6EXosQafIbXP/0vD2YarZB2DUqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256813; c=relaxed/simple;
	bh=N5VX0ZGZCaGKH3x6+5zsoIZeLej3BTUGRGqC8Av1TCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l03M9HQkG8/frujoCDFDUNX2LUZj63+Wft/wuUhI3mUuI5gxuUMOIOFp6H1zzlwJwVHlP+96wRtRtQf8wSd1zx5slyQKfYWYfa4pCYArCaX0Ux1W8TFZVuUjSNFL/q8RVty6+DQH1zzuOQNdukLODci6FKfkjCzR8DrGDYN3O98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=nYP1SWUR; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="nYP1SWUR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfSwtv2GLiSdFgq8cDqvoPAvO9M6aN7k+mQcXHlpTlu+S80urwM/vhi3aT+fyqdKYR7piiZIW//4F3UtmIU1mmlskCko0LaeHBek7F9q2YgDdnXRsJPwlAadZgJ1ZtMBs32ZmDlnFeZsK/Wg47rj5z5AWOfF4kRGdxH7h0sHdkx18Vi/iH33GqvB4dHptBIKntpSmjGdFBa/xuAuCYzn9qMBXQPyx41DRXCMEzSMJY8apVaHdgjYTqRTwChxBcqVnMyH79t27LbuJ4yCoeKYErNAdRZ2TVUL/bN8sYtCuLPuVrSCltL2da8SO9LGlrW3EDIl8lz05Lq8XjS3KniaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4oWG1QFo+8daxAWcnyZzLW3eTvJUk/3YKhMiMFms1w=;
 b=xuagFyCkJdY3LGyMYPq+v7W996bjE/XsldKVYqxUfy3G6SAYsQEcNHEYXeBeXZsEd53Tm2Wt8cITFU6Rpq/FcAhRiUc3pXXhExaHIEVbezAUnLrPQrvORieeMdz6iwEetbt6pPl54ZPeo4BSJKRTFAd8jwwPzRV2cqFlJeWMkb2w+A03sfKMmOaKhxgCqamI4FsVUyUUEwhhje0UjJli1rZ9rORd3V3IgeXs0f/hRdt/VfW2gljRkJFtll3vYmNfMbNvfcPdhnOytaKhbZy45o+hO7CIzvTnluA/EVLVpQlw7CcL038bb6QlhDRw43JUceS4GmTJdkS1JN+ke7IcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4oWG1QFo+8daxAWcnyZzLW3eTvJUk/3YKhMiMFms1w=;
 b=nYP1SWURsSs9u1jf1oqvCxljc91BUvyDv8qAqNQ3p8lAeibyoEPLMUA+hgebmRZG+OARwTk5lJHMId3CpYOhe6PQDzS33qIQBxA5BX2/Bi33R9AfTDFjG8sy+yseldmIjZjIWxWn3SUHRQwH+lUUvR06EDwak8zbjNRPGBRCgAA=
Received: from AM0PR08CA0002.eurprd08.prod.outlook.com (2603:10a6:208:d2::15)
 by AS4PR03MB8723.eurprd03.prod.outlook.com (2603:10a6:20b:58e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 11 Jul
 2025 18:00:06 +0000
Received: from AMS0EPF000001AB.eurprd05.prod.outlook.com
 (2603:10a6:208:d2:cafe::f8) by AM0PR08CA0002.outlook.office365.com
 (2603:10a6:208:d2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 18:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001AB.mail.protection.outlook.com (10.167.16.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 18:00:06 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 20:00:05 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [RFC PATCH BlueZ v2 4/7] mesh: gatt-proxy: support for proxy configuration messages and filtering
Date: Fri, 11 Jul 2025 19:56:54 +0200
Message-ID: <20250711175842.28860-5-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AB:EE_|AS4PR03MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 8389c218-8218-4297-8867-08ddc0a4c4cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gXDM34hG2i8/YUGePOYhevXErfAvpiD0TTJwxdmBRo7BNB59QP7pIsxdGjHP?=
 =?us-ascii?Q?QRwQDYc80dCfhNESFpW/c0MaZrHsYBXQ4A9Op/mtB+1TaHY5S5ABmhubxKzP?=
 =?us-ascii?Q?3+6m29b7tdIsHTY3Bvknn9RaR7SxFy2aTAHMzK0gkSXapYAFWONfepkXT/yN?=
 =?us-ascii?Q?dGu3W+ar1ajSCrW8miRSRSTWQ3u4B3a8SLhCLYRhrR9rxL6T6vnCwFpGvM5q?=
 =?us-ascii?Q?5wYCO82ISQkbkjIy866+WUHyEWMbU+cEnODvFgnPbKNY85KF5f95bKq+07cr?=
 =?us-ascii?Q?tkKcOZfIFCx669MhT/Ur1zhWKv6I/dCl8TmST7ecp0Q+gBW+FjonvHX7j2BU?=
 =?us-ascii?Q?aPLfbWPe6i+EKWzAMmhK0OjJOZUvogayBbfhe5pFPgJX+S0ZcGz6FXCrdxHI?=
 =?us-ascii?Q?5HpQpuAzomqN1QcJiSWI2piYFFof2bSpa6sy32ARcSwfYmnH+45I28W+oS9k?=
 =?us-ascii?Q?gg13I1RgnuMgE1oEZPhlEJjmRL8Z8Bv75BYB4FrKqqHBMTPeqKFhImWHFXz6?=
 =?us-ascii?Q?frlHvwiXnn/Q/78kOBa/2yDnFCkJNE4/ZLpKx+37I/+h/0nZW/5l/Q2FRUeC?=
 =?us-ascii?Q?Qj1p7CwoQ+zDr9jnz33KpDuz2dDfT04KefgFX0pad+56sNtvYSmMuwDAyPrL?=
 =?us-ascii?Q?MIwljufwe9eF5oBi6WvQ9mTyb8kUZILqlAcNvz+V/mGq2gpR7S5t/tv/wj04?=
 =?us-ascii?Q?duyRKwm70kZXeP737/bUIRtZRERK5uymfjwZFEogxF/P9/uvQ/E6EGdoJntZ?=
 =?us-ascii?Q?9JHzdljJuyIcev6w/d7QPW2XjzgbAQQcgtAJc6V5xRGvJSabELXH398+EPRv?=
 =?us-ascii?Q?z6/ZHO4fcmK5+wjehG6AXXLY78nZg+aT5MARgE/3jyn+xVqPNOwvWQKblGkh?=
 =?us-ascii?Q?2MSCXHl5bhuVuZkiY3SKlprVbneUfSQaVmdUQmFCoLd4eMAovSQbKvNMmoBY?=
 =?us-ascii?Q?DE1m1tiFEDlfLOMP8KvQIYKWBEzW4/PiK4VL1fuV1uOy9OSGoxZiNC4L1Bfz?=
 =?us-ascii?Q?/aY9kIJoNVJOkmYX/062Xv6RzmUvNtAMddH4C4FU5khP0RVSDGecBid8Jt4p?=
 =?us-ascii?Q?OdG4W1EVJtGkGOzWypYB0e1NMimKDAXV4LwcGPMXzMVAqTKltOM4qN8xnPgp?=
 =?us-ascii?Q?eRbSckJVgXtcCtd2W9PFIBkJhZPeuVZe7QDFa7l6adRNGdFZPjnCXY7RfWDi?=
 =?us-ascii?Q?7ABfnjoUn8LDFS4yOtwaMeFmzt/EgN3od8jvOX+AXalvaGYTa6t0KWOp2TuS?=
 =?us-ascii?Q?80Ygori4YUJB4uE5eWFYhZ9dvEWljyB3ABIMszPVLPp4fyKJ1YNB9Qp2Ig7x?=
 =?us-ascii?Q?a08szuR1IS7Fgoj2XI4Vsz+oLM5lV5u0R9whrO7s4kpD12hzKeWDUO2GVzUT?=
 =?us-ascii?Q?tuCzSMGVwycYXknSOQ6ooLiZ0z333emLqXz6h12ReCRDixUreGemQp4u6sz0?=
 =?us-ascii?Q?vQAB65WBbK6c8bkpSdcTZO8NPbM/l/eIfefX144HH571oC93Wps09Kz6bMib?=
 =?us-ascii?Q?1CP2/B4zxF5QfWrOeOLfY3nXyzjt/wbmu+Do?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 18:00:06.5081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8389c218-8218-4297-8867-08ddc0a4c4cf
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AB.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8723

Implement reception / responses for Proxy Configuration Messages
(MshPRT_v1.1, section 6.6) and proxy filtering (sections 6.4 and 6.7).
---
 Makefile.mesh         |   3 +-
 mesh/crypto.c         |   6 +-
 mesh/crypto.h         |   3 +
 mesh/gatt-proxy-svc.c | 182 +++++++++++++++++++++++++++++++++++++++++-
 mesh/gatt-proxy-svc.h |  16 +++-
 mesh/net-keys.c       |  56 +++++++++++++
 mesh/net-keys.h       |   3 +
 mesh/net.c            | 104 +++++++++++++++++++++---
 mesh/proxy-cfg.c      | 168 ++++++++++++++++++++++++++++++++++++++
 mesh/proxy-cfg.h      |  19 +++++
 10 files changed, 541 insertions(+), 19 deletions(-)
 create mode 100644 mesh/proxy-cfg.c
 create mode 100644 mesh/proxy-cfg.h

diff --git a/Makefile.mesh b/Makefile.mesh
index 8a190f75de9d..d39bb17eca70 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -41,7 +41,8 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/prv-beacon.h mesh/prvbeac-server.c \
 				mesh/mesh-defs.h \
 				mesh/gatt-service.h mesh/gatt-service.c \
-				mesh/gatt-proxy-svc.h mesh/gatt-proxy-svc.c
+				mesh/gatt-proxy-svc.h mesh/gatt-proxy-svc.c \
+				mesh/proxy-cfg.h mesh/proxy-cfg.c
 pkglibexec_PROGRAMS += mesh/bluetooth-meshd
 
 mesh/mesh.$(OBJEXT): ell/internal
diff --git a/mesh/crypto.c b/mesh/crypto.c
index 451be81d2fb3..a98836349517 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -590,7 +590,7 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 	return true;
 }
 
-static bool network_header_parse(const uint8_t *packet, uint8_t packet_len,
+bool mesh_crypto_network_header_parse(const uint8_t *packet, uint8_t packet_len,
 				bool *ctl, uint8_t *ttl, uint32_t *seq,
 				uint16_t *src, uint16_t *dst)
 {
@@ -630,7 +630,7 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 	uint16_t this_dst;
 	bool is_segmented;
 
-	if (!network_header_parse(packet, packet_len,
+	if (!mesh_crypto_network_header_parse(packet, packet_len,
 					ctl, ttl, seq, src, &this_dst))
 		return false;
 
@@ -843,7 +843,7 @@ bool mesh_crypto_packet_encode(uint8_t *packet, uint8_t packet_len,
 	uint16_t src;
 	uint16_t dst;
 
-	if (!network_header_parse(packet, packet_len,
+	if (!mesh_crypto_network_header_parse(packet, packet_len,
 						&ctl, &ttl, &seq, &src, &dst))
 		return false;
 
diff --git a/mesh/crypto.h b/mesh/crypto.h
index e4bbe4343223..43d4ffaa5023 100644
--- a/mesh/crypto.h
+++ b/mesh/crypto.h
@@ -74,6 +74,9 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 				bool *szmic, bool *relay, uint16_t *seqZero,
 				uint8_t *segO, uint8_t *segN,
 				const uint8_t **payload, uint8_t *payload_len);
+bool mesh_crypto_network_header_parse(const uint8_t *packet, uint8_t packet_len,
+				bool *ctl, uint8_t *ttl, uint32_t *seq,
+				uint16_t *src, uint16_t *dst);
 bool mesh_crypto_payload_encrypt(uint8_t *aad, const uint8_t *payload,
 				uint8_t *out, uint16_t payload_len,
 				uint16_t src, uint16_t dst, uint8_t key_aid,
diff --git a/mesh/gatt-proxy-svc.c b/mesh/gatt-proxy-svc.c
index 27cc22c0572a..4100578a9f0a 100644
--- a/mesh/gatt-proxy-svc.c
+++ b/mesh/gatt-proxy-svc.c
@@ -10,17 +10,21 @@
 
 #include <stdbool.h>
 #include <stdlib.h>
-#include <string.h>			// memcpy()
+#include <string.h>			// memcpy(), memmove()
 
 #include <ell/dbus.h>
 #include <ell/log.h>			// l_warn()
 #include <ell/queue.h>
 #include <ell/timeout.h>
-#include <ell/util.h>			// ell_new(), l_free(), l_malloc()
+#include <ell/util.h>			// ell_new(), l_free(), l_malloc(),
+					// L_ARRAY_SIZE
 
+#include "mesh/mesh-defs.h"		// UNASSIGNED_ADDRESS
 #include "mesh/gatt-service.h"
 #include "mesh/mesh-io.h"		// mesh_io_recv_func_t
-#include "mesh/net.h"			// mesh_net_attach_gatt(),
+#include "mesh/net.h"			// PROXY_FILTER_ACCEPT_LIST,
+					// PROXY_FILTER_REJECT_LIST
+					// mesh_net_attach_gatt(),
 					// mesh_net_detach_gatt()
 #include "mesh/net-keys.h"		// net_key_fill_adv_service_data(),
 					// net_key_get_next_id()
@@ -47,6 +51,9 @@ struct gatt_proxy_svc {
 	bool txing;
 	struct l_queue *tx_deferred;
 	struct l_queue *rx_regs;
+	uint8_t filter_type;
+	uint16_t filter_addrs[32];
+	unsigned filter_count;
 };
 
 struct process_data {
@@ -117,6 +124,136 @@ void gatt_proxy_svc_deregister_recv_cb(struct gatt_proxy_svc *gatt_proxy,
 	l_free(rx_reg);
 }
 
+void gatt_proxy_svc_filter_set_type(struct gatt_proxy_svc *gatt_proxy,
+							uint8_t filter_type)
+{
+	if (!gatt_proxy || gatt_proxy != gatt_proxy_svc)
+		return;
+
+	/* Behavior not specified in MshPRT, section 6.7 */
+	if (filter_type != PROXY_FILTER_ACCEPT_LIST &&
+					filter_type != PROXY_FILTER_REJECT_LIST)
+		return;
+
+	/*
+	 * MshPRT_v1.1, section 6.7 - Proxy Server behavior
+	 * If a Proxy Server receives a Set Filter Type message, it shall set
+	 * the proxy filter type as requested in the message parameter, and it
+	 * shall clear the proxy filter list.
+	 */
+	gatt_proxy->filter_type = filter_type;
+	gatt_proxy->filter_count = 0;
+}
+
+void gatt_proxy_svc_filter_add(struct gatt_proxy_svc *gatt_proxy,
+								uint16_t addr)
+{
+	int i;
+
+	if (!gatt_proxy || gatt_proxy != gatt_proxy_svc)
+		return;
+
+	/*
+	 * MshPRT_v1.1, section 6.7 - Proxy Server behavior
+	 * If the AddressArray field contains the unassigned address, the Proxy
+	 * Server shall ignore that address.
+	 */
+	if (addr == UNASSIGNED_ADDRESS)
+		return;
+
+	/*
+	 * MshPRT_v1.1, section 6.7 - Proxy Server behavior
+	 * If the Proxy Server runs out of space in the proxy filter list,
+	 * the Proxy Server shall not add these addresses.
+	 */
+	if (gatt_proxy->filter_count == L_ARRAY_SIZE(gatt_proxy->filter_addrs))
+		return;
+
+	/*
+	 * MshPRT_v1.1, section 6.7 - Proxy Server behavior
+	 * If one or more addresses contained in the message are already in the
+	 * list, the Proxy Server shall not add these addresses.
+	 */
+	for (i = 0; i < gatt_proxy->filter_count; i++)
+		if (gatt_proxy->filter_addrs[i] == addr)
+			return;
+
+	gatt_proxy->filter_addrs[gatt_proxy->filter_count++] = addr;
+}
+
+void gatt_proxy_svc_filter_remove(struct gatt_proxy_svc *gatt_proxy,
+								uint16_t addr)
+{
+	int i;
+
+	if (!gatt_proxy || gatt_proxy != gatt_proxy_svc)
+		return;
+
+	/*
+	 * MshPRT_v1.1, section 6.7 - Proxy Server behavior
+	 * If the AddressArray field contains the unassigned address, the Proxy
+	 * Server shall ignore that address.
+	 */
+	if (addr == UNASSIGNED_ADDRESS)
+		return;
+
+	/*
+	 * MshPRT_v1.1, section 6.7 - Proxy Server behavior
+	 * If one or more addresses contained in the message were not in the
+	 * list, the Proxy Server shall ignore these addresses.
+	 */
+	for (i = 0; i < gatt_proxy->filter_count; i++)
+		if (gatt_proxy->filter_addrs[i] == addr)
+			break;
+
+	if (i == gatt_proxy->filter_count)
+		return;
+
+	memmove(gatt_proxy->filter_addrs + i, gatt_proxy->filter_addrs + i + 1,
+			gatt_proxy->filter_count - i - 1);
+	gatt_proxy->filter_count--;
+}
+
+unsigned gatt_proxy_svc_filter_count(struct gatt_proxy_svc *gatt_proxy,
+							uint8_t *filter_type)
+{
+	if (!gatt_proxy || gatt_proxy != gatt_proxy_svc)
+		return 0;
+
+	*filter_type = gatt_proxy->filter_type;
+
+	return gatt_proxy->filter_count;
+}
+
+void gatt_proxy_svc_filter_pdu_rcvd(struct gatt_proxy_svc *gatt_proxy,
+								uint16_t src)
+{
+	if (!gatt_proxy || gatt_proxy != gatt_proxy_svc)
+		return;
+
+	if (gatt_proxy->filter_type == PROXY_FILTER_ACCEPT_LIST) {
+		/*
+		 * MshPRT_v1.1, section 6.7 - Proxy Server behavior
+		 * If the proxy filter is an accept list filter, upon receiving
+		 * a Proxy PDU containing a valid Network PDU from the Proxy
+		 * Client, the Proxy Server shall add the unicast address
+		 * contained in the SRC field of the Network PDU to the accept
+		 * list.
+		 */
+		gatt_proxy_svc_filter_add(gatt_proxy, src);
+	} else {
+		/*
+		 * MshPRT_v1.1, section 6.7 - Proxy Server behavior
+		 * If the proxy filter is a reject list filter, upon receiving a
+		 * Proxy PDU containing a valid Network PDU from the Proxy
+		 * Client, the Proxy Server shall remove the unicast address
+		 * contained in the SRC field of the Network PDU from the reject
+		 * list.
+		 */
+		gatt_proxy_svc_filter_remove(gatt_proxy, src);
+	}
+}
+
 static void gatt_proxy_svc_send(enum proxy_msg_type msg_type, const void *data,
 								uint8_t len)
 {
@@ -144,11 +281,40 @@ static void gatt_proxy_svc_send(enum proxy_msg_type msg_type, const void *data,
 	}
 }
 
-void gatt_proxy_svc_send_net(const void *data, uint8_t len)
+void gatt_proxy_svc_send_net(uint16_t dst, const void *data, uint8_t len)
 {
+	int i;
+
+	if (!gatt_proxy_svc)
+		return;
+
+	/*
+	 * MshPRT_v1.1, section 6.4 - Proxy filtering
+	 * The output filter of the network interface (see Section 3.4.5) [...]
+	 * can be configured by the Proxy Client. This allows the Proxy Client
+	 * to explicitly request to receive only mesh messages with certain
+	 * *destination* addresses.
+	 */
+	for (i = 0; i < gatt_proxy_svc->filter_count; i++)
+		if (gatt_proxy_svc->filter_addrs[i] == dst)
+			break;
+
+	if (gatt_proxy_svc->filter_type == PROXY_FILTER_ACCEPT_LIST) {
+		if (i == gatt_proxy_svc->filter_count)  // not found
+			return;
+	} else {  /* PROXY_FILTER_REJECT_LIST */
+		if (i != gatt_proxy_svc->filter_count)  // found
+			return;
+	}
+
 	gatt_proxy_svc_send(PROXY_MSG_TYPE_NETWORK_PDU, data, len);
 }
 
+void gatt_proxy_svc_send_proxy_cfg(const void *data, uint8_t len)
+{
+	gatt_proxy_svc_send(PROXY_MSG_TYPE_PROXY_CFG, data, len);
+}
+
 static void gatt_service_notify_acquired(void *user_data)
 {
 	struct gatt_proxy_svc *gatt_proxy = user_data;
@@ -157,6 +323,14 @@ static void gatt_service_notify_acquired(void *user_data)
 		return;
 
 	gatt_proxy->connected = true;
+
+	/*
+	 * MshPRT_v1.1, section 6.7 - Proxy Server behavior
+	 * Upon connection, the Proxy Server shall initialize the proxy filter
+	 * as an accept list filter and the accept list shall be empty.
+	 */
+	gatt_proxy->filter_type = PROXY_FILTER_ACCEPT_LIST;
+	gatt_proxy->filter_count = 0;
 }
 
 static void gatt_service_notify_stopped(void *user_data)
diff --git a/mesh/gatt-proxy-svc.h b/mesh/gatt-proxy-svc.h
index 2b0c9d7ec21b..0abb85d7109f 100644
--- a/mesh/gatt-proxy-svc.h
+++ b/mesh/gatt-proxy-svc.h
@@ -24,5 +24,17 @@ void gatt_proxy_svc_register_recv_cb(struct gatt_proxy_svc *gatt_proxy,
 					void *user_data);
 void gatt_proxy_svc_deregister_recv_cb(struct gatt_proxy_svc *gatt_proxy,
 						enum proxy_msg_type msg_type);
-void gatt_proxy_svc_send_net(const void *data, uint8_t len);
-								
+
+void gatt_proxy_svc_filter_set_type(struct gatt_proxy_svc *gatt_proxy,
+							uint8_t filter_type);
+void gatt_proxy_svc_filter_add(struct gatt_proxy_svc *gatt_proxy,
+								uint16_t addr);
+void gatt_proxy_svc_filter_remove(struct gatt_proxy_svc *gatt_proxy,
+								uint16_t addr);
+unsigned gatt_proxy_svc_filter_count(struct gatt_proxy_svc *gatt_proxy,
+							uint8_t *filter_type);
+void gatt_proxy_svc_filter_pdu_rcvd(struct gatt_proxy_svc *gatt_proxy,
+								uint16_t src);
+
+void gatt_proxy_svc_send_net(uint16_t dst, const void *data, uint8_t len);
+void gatt_proxy_svc_send_proxy_cfg(const void *data, uint8_t len);
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index ab724f9cfa1e..1a2cd39421c1 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -78,6 +78,15 @@ struct net_key {
 	bool ivu;
 };
 
+struct proxy_cfg_msg {
+	const uint8_t *data;
+	uint8_t len;
+	uint8_t *plain;
+	uint8_t plain_len;
+	uint32_t iv_index;
+	uint32_t key_id;
+};
+
 static struct l_queue *beacons;
 static struct l_queue *keys;
 static uint32_t last_flooding_id;
@@ -255,6 +264,29 @@ static void decrypt_net_pkt(void *a, void *b)
 	}
 }
 
+static void decrypt_proxy_cfg_msg(void *a, void *b)
+{
+	const struct net_key *key = a;
+	struct proxy_cfg_msg *proxy_cfg = b;
+	bool result;
+
+	if (proxy_cfg->key_id || !key->ref_cnt ||
+					(proxy_cfg->data[0] & 0x7f) != key->nid)
+		return;
+
+	result = mesh_crypto_packet_decode(proxy_cfg->data, proxy_cfg->len,
+							true,
+							proxy_cfg->plain,
+							proxy_cfg->iv_index,
+							key->enc_key,
+							key->prv_key);
+
+	if (result) {
+		proxy_cfg->key_id = key->id;
+		proxy_cfg->plain_len = proxy_cfg->len;
+	}
+}
+
 uint32_t net_key_decrypt(uint32_t iv_index, const uint8_t *pkt, size_t len,
 					uint8_t **plain, size_t *plain_len)
 {
@@ -284,6 +316,30 @@ done:
 	return cache_id;
 }
 
+uint32_t net_key_decrypt_proxy_cfg_msg(uint32_t iv_index,
+					const uint8_t *pkt, size_t len,
+					uint8_t *plain, size_t *plain_len)
+{
+	struct proxy_cfg_msg proxy_cfg = {
+		.data = pkt,
+		.len = len,
+		.plain = plain,
+		.iv_index = iv_index,
+	};
+
+	/* MshPRT_v1.1, section 6.6: Proxy configuration messages have CTL=1 */
+	if (!(pkt[1] & CTL))
+		return 0;
+
+	/* Try all network keys known to us */
+	l_queue_foreach(keys, decrypt_proxy_cfg_msg, &proxy_cfg);
+
+	if (proxy_cfg.key_id)
+		*plain_len = proxy_cfg.plain_len;
+
+	return proxy_cfg.key_id;
+}
+
 bool net_key_encrypt(uint32_t id, uint32_t iv_index, uint8_t *pkt, size_t len)
 {
 	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
diff --git a/mesh/net-keys.h b/mesh/net-keys.h
index 512347521547..b43157df29bc 100644
--- a/mesh/net-keys.h
+++ b/mesh/net-keys.h
@@ -26,6 +26,9 @@ uint32_t net_key_frnd_add(uint32_t flooding_id, uint16_t lpn, uint16_t frnd,
 void net_key_unref(uint32_t id);
 uint32_t net_key_decrypt(uint32_t iv_index, const uint8_t *pkt, size_t len,
 					uint8_t **plain, size_t *plain_len);
+uint32_t net_key_decrypt_proxy_cfg_msg(uint32_t iv_index,
+					const uint8_t *pkt, size_t len,
+					uint8_t *plain, size_t *plain_len);
 bool net_key_encrypt(uint32_t id, uint32_t iv_index, uint8_t *pkt, size_t len);
 uint32_t net_key_network_id(const uint8_t network[8]);
 uint32_t net_key_beacon(const uint8_t *data, uint16_t len, uint32_t *ivi,
diff --git a/mesh/net.c b/mesh/net.c
index 911f781ef75c..9a04aa5120c4 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -27,6 +27,7 @@
 #include "mesh/net-keys.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
+#include "mesh/proxy-cfg.h"
 #include "mesh/mesh-io.h"
 #include "mesh/friend.h"
 #include "mesh/gatt-service.h"		// PROXY_MSG_TYPE_NETWORK_PDU
@@ -192,8 +193,20 @@ struct net_queue_data {
 	bool seen;
 };
 
+struct net_queue_data_proxy_cfg {
+	struct gatt_proxy_svc *gatt_proxy;
+	struct mesh_net *net;
+	const uint8_t *data;
+	uint8_t *out;
+	size_t out_size;
+	uint32_t net_key_id;
+	uint32_t iv_index;
+	uint16_t len;
+};
+
 struct oneshot_tx {
 	struct mesh_net *net;
+	uint16_t net_dst;
 	uint16_t interval;
 	bool frnd;
 	uint8_t cnt;
@@ -2303,17 +2316,20 @@ static void send_msg_pkt_oneshot(void *user_data)
 	 */
 	mesh_io_send(net->io, &info, tx->packet, tx->size);
 	if (!tx->frnd)
-		gatt_proxy_svc_send_net(tx->packet + 1, tx->size - 1);
+		gatt_proxy_svc_send_net(tx->net_dst, tx->packet + 1,
+								tx->size - 1);
 	l_free(tx);
 }
 
-static void send_msg_pkt(struct mesh_net *net, uint8_t cnt, uint16_t interval,
+static void send_msg_pkt(struct mesh_net *net, uint16_t dst, uint8_t cnt,
+					uint16_t interval,
 					const uint8_t *packet, uint8_t size,
 								bool frnd)
 {
 	struct oneshot_tx *tx = l_new(struct oneshot_tx, 1);
 
 	tx->net = net;
+	tx->net_dst = dst;
 	tx->interval = interval;
 	tx->frnd = frnd;
 	tx->cnt = cnt;
@@ -2324,6 +2340,7 @@ static void send_msg_pkt(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 }
 
 static enum _relay_advice packet_received(struct mesh_net *net,
+				struct gatt_proxy_svc *gatt_proxy,
 				uint32_t net_key_id, uint16_t net_idx,
 				bool frnd, uint32_t iv_index,
 				const uint8_t *data, uint8_t size, int8_t rssi)
@@ -2347,7 +2364,9 @@ static enum _relay_advice packet_received(struct mesh_net *net,
 		return RELAY_NONE;
 	}
 
-	if (net_dst == 0) {
+	gatt_proxy_svc_filter_pdu_rcvd(gatt_proxy, net_src);
+
+	if (net_dst == UNASSIGNED_ADDRESS) {
 		l_error("illegal parms: DST: %4.4x Ctl: %d TTL: %2.2x",
 						net_dst, net_ctl, net_ttl);
 		return RELAY_NONE;
@@ -2508,7 +2527,8 @@ static void net_rx(void *net_ptr, void *user_data)
 	if (data->gatt_proxy && frnd)
 		return;
 
-	relay_advice = packet_received(net, net_key_id, net_idx, frnd,
+	relay_advice = packet_received(net, data->gatt_proxy, net_key_id,
+						net_idx, frnd,
 						iv_index, out, out_size, rssi);
 	if (relay_advice > data->relay_advice) {
 		/*
@@ -2527,6 +2547,48 @@ static void net_rx(void *net_ptr, void *user_data)
 	}
 }
 
+static void net_proxy_cfg_msg_rx(void *net_ptr, void *user_data)
+{
+	struct net_queue_data_proxy_cfg *data = user_data;
+	struct mesh_net *net = net_ptr;
+	uint8_t out[MESH_NET_MAX_PDU_LEN];
+	size_t out_size;
+	uint32_t net_key_id;
+	uint16_t net_idx;
+	bool frnd;
+	bool ivi_net = !!(net->iv_index & 1);
+	bool ivi_pkt = !!(data->data[0] & 0x80);
+
+	/* if IVI flag differs, use previous IV Index */
+	uint32_t iv_index = net->iv_index - (ivi_pkt ^ ivi_net);
+
+	net_key_id = net_key_decrypt_proxy_cfg_msg(iv_index,
+							data->data, data->len,
+							out, &out_size);
+
+	if (!net_key_id)
+		return;
+
+	net_idx = key_id_to_net_idx(net, net_key_id, &frnd);
+
+	if (net_idx == NET_IDX_INVALID)
+		return;
+
+	/*
+	 * MshPRT_v1.1, section 3.4.5.1 - Interface input filter
+	 * The input filter of the interface connected to the GATT bearer shall
+	 * drop all Network PDUs that have been secured using the friendship
+	 * security credentials.
+	 */
+	if (frnd)
+		return;
+
+	print_packet("RX: ProxyCfg [enc] :", data->data, data->len);
+
+	proxy_cfg_msg_received(data->gatt_proxy, net, net_key_id, iv_index, out,
+								out_size);
+}
+
 static void net_msg_recv(void *user_data, struct mesh_io_recv_info *info,
 					const uint8_t *data, uint16_t len)
 {
@@ -2566,6 +2628,25 @@ static void net_msg_recv(void *user_data, struct mesh_io_recv_info *info,
 	}
 }
 
+static void
+net_proxy_cfg_msg_recv(void *user_data, struct mesh_io_recv_info *info,
+					const uint8_t *data, uint16_t len)
+{
+	struct gatt_proxy_svc *gatt_proxy = user_data;
+	struct net_queue_data_proxy_cfg net_data = {
+		.gatt_proxy = gatt_proxy,
+		.data = data + 1,
+		.len = len - 1,
+	};
+
+	if (len < 9)
+		return;
+
+	l_queue_foreach(nets, net_proxy_cfg_msg_rx, &net_data);
+
+	/* Proxy configuration messages are not relayed */
+}
+
 static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 {
 	struct mesh_net *net = user_data;
@@ -3080,6 +3161,9 @@ void mesh_net_attach_gatt(struct gatt_proxy_svc *gatt_proxy)
 	gatt_proxy_svc_register_recv_cb(gatt_proxy, PROXY_MSG_TYPE_NETWORK_PDU,
 							net_msg_recv,
 							gatt_proxy);
+	gatt_proxy_svc_register_recv_cb(gatt_proxy, PROXY_MSG_TYPE_PROXY_CFG,
+							net_proxy_cfg_msg_recv,
+							gatt_proxy);
 }
 
 void mesh_net_detach_gatt(struct gatt_proxy_svc *gatt_proxy)
@@ -3088,6 +3172,8 @@ void mesh_net_detach_gatt(struct gatt_proxy_svc *gatt_proxy)
 
 	gatt_proxy_svc_deregister_recv_cb(gatt_proxy,
 						PROXY_MSG_TYPE_NETWORK_PDU);
+	gatt_proxy_svc_deregister_recv_cb(gatt_proxy,
+						PROXY_MSG_TYPE_PROXY_CFG);
 }
 
 bool mesh_net_iv_index_update(struct mesh_net *net)
@@ -3214,8 +3300,8 @@ static bool send_seg(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 		return false;
 	}
 
-	send_msg_pkt(net, cnt, interval, packet, packet_len + 1, false);
-
+	send_msg_pkt(net, msg->remote, cnt, interval, packet, packet_len + 1,
+									false);
 	msg->last_seg = segO;
 
 	return true;
@@ -3268,7 +3354,7 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 		return;
 	}
 
-	send_msg_pkt(net, net->tx_cnt, net->tx_interval, packet,
+	send_msg_pkt(net, dst, net->tx_cnt, net->tx_interval, packet,
 							packet_len + 1, frnd);
 
 	l_debug("TX: Friend Seg-%d %04x -> %04x : len %u) : TTL %d : SEQ %06x",
@@ -3433,7 +3519,7 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t net_key_id,
 		return;
 	}
 
-	send_msg_pkt(net, net->tx_cnt, net->tx_interval, pkt, pkt_len + 1,
+	send_msg_pkt(net, dst, net->tx_cnt, net->tx_interval, pkt, pkt_len + 1,
 									frnd);
 
 	l_debug("TX: Friend ACK %04x -> %04x : len %u : TTL %d : SEQ %06x",
@@ -3522,7 +3608,7 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 	}
 
 	if (!(IS_UNASSIGNED(dst)))
-		send_msg_pkt(net, net->tx_cnt, net->tx_interval, pkt,
+		send_msg_pkt(net, dst, net->tx_cnt, net->tx_interval, pkt,
 							pkt_len + 1, frnd);
 }
 
diff --git a/mesh/proxy-cfg.c b/mesh/proxy-cfg.c
new file mode 100644
index 000000000000..5a9439f4d941
--- /dev/null
+++ b/mesh/proxy-cfg.c
@@ -0,0 +1,168 @@
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
+
+#include <ell/dbus.h>
+#include <ell/log.h>
+#include <ell/util.h>			// l_get_be16(), l_put_be16()
+
+#include "src/shared/ad.h"
+
+#include "mesh/crypto.h"		// mesh_crypto_network_header_parse()
+#include "mesh/mesh-io.h"		// mesh_io_recv_func_t, required by gatt-proxy-svc.h
+#include "mesh/gatt-proxy-svc.h"	// gatt_proxy_svc_filter_set_type(),
+					// gatt_proxy_svc_filter_add(),
+					// gatt_proxy_svc_filter_remove(),
+					// gatt_proxy_svc_filter_count(),
+					// gatt_proxy_svc_send()
+#include "mesh/mesh-defs.h"		// UNASSIGNED_ADDRESS
+#include "mesh/net.h"			// PROXY_OP_SET_FILTER_TYPE,
+					// PROXY_OP_FILTER_ADD,
+					// PROXY_OP_FILTER_DEL,
+					// PROXY_OP_FILTER_STATUS,
+					// mesh_net_next_seq_num(),
+					// mesh_net_get_address()
+#include "mesh/net-keys.h"		// net_key_encrypt(),
+					// net_key_decrypt_proxy_cfg_msg()
+#include "mesh/util.h"			// print_packet()
+#include "mesh/proxy-cfg.h"
+
+void proxy_cfg_msg_received(struct gatt_proxy_svc *gatt_proxy,
+					struct mesh_net *net,
+					uint32_t net_key_id, uint32_t iv_index,
+					const uint8_t *data, uint8_t size)
+{
+	const uint8_t *msg;
+	uint8_t cfg_msg_len;
+	uint8_t net_ttl;
+	uint32_t net_seq;
+	uint16_t net_src, net_dst;
+	bool net_ctl;
+	uint8_t rsp[4];  // length of PROXY_OP_FILTER_STATUS
+	uint8_t rsp_len = 0;
+
+	print_packet("RX: ProxyCfg [clr] :", data, size);
+
+	if (!mesh_crypto_network_header_parse(data, size, &net_ctl, &net_ttl,
+					&net_seq, &net_src, &net_dst)) {
+		l_error("Failed to parse packet content");
+		return;
+	}
+
+	/*
+	 * MshPRT_v1.1, section 6.6:
+	 * - The CTL field shall be set to 1. [already checked]
+	 * - The TTL field shall be set to 0.
+	 * - The DST field shall be set to the unassigned address.
+	 */
+	if (net_dst != UNASSIGNED_ADDRESS || net_ttl) {
+		l_error("illegal parms: DST: %4.4x Ctl: %d TTL: %2.2x",
+						net_dst, net_ctl, net_ttl);
+		return;
+	}
+
+	l_debug("RX: ProxyCfg %04x -> %04x : TTL 0x%02x : IV : %8.8x SEQ 0x%06x",
+			net_src, net_dst, net_ttl, iv_index, net_seq);
+
+	msg = data + 9;
+	cfg_msg_len = size - 9 - 8 /* NetMIC */;
+
+	if (!cfg_msg_len)
+		return;
+
+	/* process request */
+	switch (msg[0]) {
+		case PROXY_OP_SET_FILTER_TYPE:
+			if (cfg_msg_len >= 2) {
+				uint8_t filter_type;
+
+				filter_type = msg[1];
+				gatt_proxy_svc_filter_set_type(gatt_proxy,
+								filter_type);
+			}
+			break;
+
+		case PROXY_OP_FILTER_ADD:
+			if (cfg_msg_len & 0x1) {
+				int num_filters = (cfg_msg_len - 1) / 2, i;
+				uint16_t addr;
+
+				for (i = 0; i < num_filters; i++) {
+					addr = l_get_be16(msg + 2 * i + 1);
+					gatt_proxy_svc_filter_add(gatt_proxy,
+									addr);
+				}
+			}
+			break;
+
+		case PROXY_OP_FILTER_DEL:
+			if (cfg_msg_len & 0x1) {
+				int num_filters = (cfg_msg_len - 1) / 2, i;
+				uint16_t addr;
+
+				for (i = 0; i < num_filters; i++) {
+					addr = l_get_be16(msg + 2 * i + 1);
+					gatt_proxy_svc_filter_remove(gatt_proxy,
+									addr);
+				}
+			}
+			break;
+
+		default:
+			break;
+	}
+
+	/* prepare response */
+	switch (msg[0]) {
+		case PROXY_OP_SET_FILTER_TYPE:
+		case PROXY_OP_FILTER_ADD:
+		case PROXY_OP_FILTER_DEL: {
+			uint8_t filter_type;
+			uint16_t num_filters =
+				gatt_proxy_svc_filter_count(gatt_proxy,
+								&filter_type);
+			rsp[0] = PROXY_OP_FILTER_STATUS;
+			rsp[1] = filter_type;
+			l_put_be16(num_filters, &rsp[2]);
+			rsp_len = 4;
+			break;
+		}
+
+		/*
+		 * MshPRT_v1.1, section 6.7:
+		 * Upon receiving a proxy configuration message with the Opcode
+		 * field set to a value that is Reserved for Future Use, the
+		 * Proxy Server shall ignore this message.
+		 */
+		default:
+			break;
+	}
+
+	if (rsp_len) {
+		uint8_t pkt[MESH_NET_MAX_PDU_LEN];
+		uint8_t pkt_len;
+
+		net_seq = mesh_net_next_seq_num(net);
+		if (!mesh_crypto_packet_build(true, 0/*TTL*/, net_seq,
+					mesh_net_get_address(net)/*src*/,
+					UNASSIGNED_ADDRESS/*dst*/, rsp[0],
+					false, 0, false, 0, 0, 0,
+					rsp + 1, rsp_len - 1, pkt, &pkt_len))
+			return;
+
+		if (!net_key_encrypt(net_key_id, iv_index, pkt, pkt_len)) {
+			l_error("Failed to encode packet");
+			return;
+		}
+
+		gatt_proxy_svc_send_proxy_cfg(pkt, pkt_len);
+	}
+}
diff --git a/mesh/proxy-cfg.h b/mesh/proxy-cfg.h
new file mode 100644
index 000000000000..b41cbd512c05
--- /dev/null
+++ b/mesh/proxy-cfg.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  ARRI Lighting. All rights reserved.
+ *
+ *
+ */
+
+#include <stdint.h>
+
+struct gatt_proxy_svc;
+struct mesh_net;
+
+void proxy_cfg_msg_received(struct gatt_proxy_svc *gatt_proxy,
+					struct mesh_net *net,
+					uint32_t net_key_id, uint32_t iv_index,
+					const uint8_t *data, uint8_t size);
-- 
2.43.0

