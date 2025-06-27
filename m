Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA223182B
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011336; cv=fail; b=RXIZ8WZwl13lDiPQPLL/FSrt2J3iaruHDLf+fhfGxJx/I//1hJIydWJwD2FBiDoTt+8PJv0SjLZpNGYBRJIl+g0/cBzlqCiLEczvxheQOgbRKKBjPDZSrMqpu5JepkmTRmpvPif43iSguglvgOuP9/l1Rdfro9F+AA2lmD8idqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011336; c=relaxed/simple;
	bh=TDH/GiqfwOhH5aOrDpSOyXaiuml1ZU8SyiER50j9vSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIN58cVWAhpbA8ztNhXeOHl9FNPH2pK3LG6taWAhM4sOWPF/Y3WVhe2tMX7DJ/MABdPDfM8TePdd+FlfYZQ7bCbW9FMDDz8qk7tycFVvz6S/TvwgB8R6ybpNvfgUlWW1uF27f4BFWFTYX0Nhix6W9Z0UO+L3g37Bwf0SCStV6SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=aG1WaQbR; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="aG1WaQbR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZbv/v+HDHdc2g84RzlHPAlJhOOBdRzBwTSRLs0gwlpbO7CLsELjxxcY4K3KLlugfbVApgxE9KY2UjbRiFXxloRsQ2yCmrfMu8BAePOCnOymtzEM3omAY+dx3/hOPQQEAAu2ZzY2oPihIG8mQcyi/P0Fe0YuwZZz2cIPL9sd5dmWYD+yBWAqcksGcSTORmCSBz9NXbHMUEvCbc5AgtV5r95TlsYN7ic0u2Yj1rFaGS/xLNpsO6/6XtB/x42ryvixDc128LGw5tJGdmrvIJ/ZdWCGYuix512GZZstfLKCpCfi+LDVM0NoY9qC3sbfLL2iPY256YXnKKGH6ZbMf0G7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEOHep2BRCwPj2DhW6lgMOsSnfUa3BJt64vJdI3MUg4=;
 b=CBdTUiMhHtNO9Nk23zhG9aK1Z+3H/w8rryReNzpmid/EAQj4FZYPfkipEMWAkiKXwUGkoH9shDXAPGl5vQ3ZiKQmyFh2hh1E4vY1AnrwdM8TgiqtKvM+9nuA/cq/3dkENcAaKx6OFNoZ1ufR1XSUy3QajC347lsXxBnNj+mrV7lFOMTCyxaDJ13KpsK3NO9yt+9onngsHV+xpudW3VhtOXcETRw4oD0LGv8o4kNBABdPNimOaCJwA6HR+PKA2qva62xKkf+gD2KZb/yrYJeCrRVWajcf6Ikze2DQhylrQEua+DB4IXa84cYA6MZJyz/R0+KNuyEW7TbvocSQyIlE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEOHep2BRCwPj2DhW6lgMOsSnfUa3BJt64vJdI3MUg4=;
 b=aG1WaQbRxs286rILsEnjXAX62CXtDyE+31WBr6ZFgZDOg/OOuJQulBs1u9U8LDEHr1dWEQD9wjqH+FWq8FYT/bSPur31KfUh2T86Qt/az7pD3VZDuDDf1BOvDkcE+YTBmk0VyxFkvWLQ0xlqTfrq778zp7DwfejXWcV8hf1j7mg=
Received: from CWLP265CA0429.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d7::15)
 by DU4PR03MB10622.eurprd03.prod.outlook.com (2603:10a6:10:58a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.18; Fri, 27 Jun
 2025 08:02:10 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:400:1d7:cafe::5d) by CWLP265CA0429.outlook.office365.com
 (2603:10a6:400:1d7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Fri,
 27 Jun 2025 08:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 08:02:10 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 10:02:10 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 8/9] net: packet_received: avoid unnecessary copying
Date: Fri, 27 Jun 2025 09:59:27 +0200
Message-ID: <20250627075928.19788-8-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627075928.19788-1-ceggers@arri.de>
References: <20250627075928.19788-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|DU4PR03MB10622:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a47bc19-db14-4f00-2d67-08ddb550eb4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eQq6gZrAnD/CqQe6uGvfs0wqml1g3q7Y85y0BHbQNPEGXS5ey0OBjBlBJE4W?=
 =?us-ascii?Q?wBwqeV0cOxSdZEY5sumiyqDBntXWhXvbukXSi9BnD06q5/M56xyJIQXQO1UO?=
 =?us-ascii?Q?JCZqJpVouzCML8/eEU+6YfQcROpDc2BuYg32oXMW6bf6oXomrGxZcCbHRliO?=
 =?us-ascii?Q?NZTfXBFBOKhIs1QeTHuOXIBJRO1zYkndZFDXVY26+yB6axgWJvJupoNA/pK3?=
 =?us-ascii?Q?8j/bTz1SA8y+82RM/+kY/1ZwA4rmG5v46WMflq61BlImVbC/F1OYF6KYdkS9?=
 =?us-ascii?Q?SpMEU8wla23UaKivxZbHcXa/pTAf1qMn3z7RKgzMuQpSJlxR4A9mKyW5sLmq?=
 =?us-ascii?Q?1m30l/xP5iupwShnOVCksUrYci13W6AYOzwWTjH41pckHRYiua0TtI4HxhgU?=
 =?us-ascii?Q?pseF4eyv0kkose1r6nD1Q0TjcdZRtDNtORBOrACo1OxC5qOMgjUU6EEqVaRc?=
 =?us-ascii?Q?8ksUJ3+teboaybiCzZFQIum4ID9AM8GQhTao7W/poQlAq2oriHv0cQzq0guk?=
 =?us-ascii?Q?L4znQV+z0wvo/0O8wUNzkypfnRc2yCKGE4ZmLo4rS2hWk8Y8G2QK5NGuO9Kz?=
 =?us-ascii?Q?CBowTvcg3otoCN8maRRmFXX0FOe2A+Tt+OA+Ux/ng5Vy5u6h3AZsujuUeZsj?=
 =?us-ascii?Q?ibuvQTKvvu1XrUuO4hDnoIlf5DFlNOPt0UT6xJTLvvOg6RlbJjrsfywZ+IoH?=
 =?us-ascii?Q?pfy+VwHLpg4bAdBMe0pDQUqxA55KvMYV/kiE7EYP+onaUuVagllG9kKczaxL?=
 =?us-ascii?Q?w72/V1dJgAv9PfSDDXhhFhW0AXKwjH2SrA8UCnlMo5FSkbmTW0czSjrg1jfR?=
 =?us-ascii?Q?QW/ZYYmT8+4Vkyr3bLZp2e516wHlyOcLAvLBvrrL+E5CA2c10qtgIkzKArHc?=
 =?us-ascii?Q?7DcVwdhKtt6MZn04KqL6XaWy7WO+PAE97gnUMtCn9jt0HhYj6kUlugKGAQPR?=
 =?us-ascii?Q?enkqnD3YWpWgMWuSdvS8uLRhZvtKJWtar/VYBfxNnzZrToHOluagFrGb9OrG?=
 =?us-ascii?Q?qqQIZGX86Hl/yOtLWRwuuO/qCm+02HtE1Ofdejy/YcKghrUOuXgWXZ0c84Mb?=
 =?us-ascii?Q?ly578Csz++OD1v3DeXMY3Wr7VOvoIrFp+Lw7qV3pmCTfSAkAUtNuks6N8ubF?=
 =?us-ascii?Q?9bBHDhLEU9ml0Jnjm31s64S6n6wpfRyRM3udIVybQ4P/bbnYq/JxlOVXaWOh?=
 =?us-ascii?Q?4CYEY4Eo3rfNhyTacJAAIyxrk8ZGSPwraFCEmtJMG1WMGM63PSrUrWO+PkUh?=
 =?us-ascii?Q?yINsLJKUDG77niesXkw6w2Tmpe5wmPZrv6Hd0z0naglkuxiFJ94mSmPm+MBY?=
 =?us-ascii?Q?f7W8hojeL9XZItKDnq9Cct1ohPZmwv2AkvBRz8OuYvyEhUdE9VkAUTRx+Qzl?=
 =?us-ascii?Q?Hf6of/32+X/+ZGYEzFVzp9VTgauRHN2feAErhLL+xqCkx23cU9vbX7qZcccI?=
 =?us-ascii?Q?pYitKWGfvVOH60ithrX2SrLZnq6DHaOWQ839/pMhdq8Inb4xnSKwij535Pfn?=
 =?us-ascii?Q?713wUHxoHwB7J0bLeRcZLdMA8sJEzuV49dMP?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 08:02:10.5849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a47bc19-db14-4f00-2d67-08ddb550eb4e
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR03MB10622

Since cca48f305b60 ("mesh: Fix Relaying for multiple nodes"), the packet
for relaying is assembled within send_relay_pkt(). So we do not need to
assemble a full packet within packet_received().

Additionally remove misleading initialization of 'msg' variable, the
value is assigned in all possible branches of
mesh_crypto_packet_parse().
---
 mesh/net.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index f26a63f178c2..1cf74c892ca0 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2324,25 +2324,21 @@ static void send_msg_pkt(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 	l_idle_oneshot(send_msg_pkt_oneshot, tx, NULL);
 }
 
-static enum _relay_advice packet_received(void *user_data,
+static enum _relay_advice packet_received(struct mesh_net *net,
 				uint32_t net_key_id, uint16_t net_idx,
 				bool frnd, uint32_t iv_index,
-				const void *data, uint8_t size, int8_t rssi)
+				const uint8_t *data, uint8_t size, int8_t rssi)
 {
-	struct mesh_net *net = user_data;
-	const uint8_t *msg = data;
+	const uint8_t *msg;
 	uint8_t app_msg_len;
 	uint8_t net_ttl, key_aid, net_segO, net_segN, net_opcode;
 	uint32_t net_seq, cache_cookie;
 	uint16_t net_src, net_dst, net_seqZero;
-	uint8_t packet[31];
 	bool net_ctl, net_segmented, net_szmic, net_relay;
 
-	memcpy(packet + 2, data, size);
-
-	print_packet("RX: Network [clr] :", packet + 2, size);
+	print_packet("RX: Network [clr] :", data, size);
 
-	if (!mesh_crypto_packet_parse(packet + 2, size, &net_ctl, &net_ttl,
+	if (!mesh_crypto_packet_parse(data, size, &net_ctl, &net_ttl,
 					&net_seq, &net_src, &net_dst,
 					&cache_cookie, &net_opcode,
 					&net_segmented, &key_aid, &net_szmic,
@@ -2418,7 +2414,7 @@ static enum _relay_advice packet_received(void *user_data,
 				if (net_ttl >= 2) {
 					friend_seg_rxed(net, iv_index, net_ttl,
 						net_seq, net_src, net_dst,
-						l_get_be32(packet + 2 + 9),
+						l_get_be32(data + 9),
 						msg, app_msg_len);
 				}
 			} else {
-- 
2.43.0

