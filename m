Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012059.outbound.protection.outlook.com [52.101.71.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353C4128395
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271338; cv=fail; b=W9PalQz8lizxqEGF23CpFD56uKL357CvTgmtb/Z8By0RysjnmYUjxHR5vAzK8HCji2DA5XAEtMfoISJZXl/GbPDkIC1dSnBSTHsK8It2Ci2zTjAPO8ZJGcGeSJGot8sBwAOownfDn3gET/QyX64idZUYSSFMlsD54PnMGEJFciE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271338; c=relaxed/simple;
	bh=by6tVbSamzkDFbDggvq8zdDtzPAmQOIPU/vzZWffIEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckDy0jlkETeKv91A7gM9xoACOJFqLg/fxIkKXWZcCA2jvVKwLWsnKhS/gYVsmNGtcNZh5Lwrmnw0BRClOJWEz44kY0vs0ozX1MLczRBX7SVOajNyGyStDKYk3ffo0JlFZQlWjpu4AXIghlWOakcy1qa30VIaDlqpIFRPsCzMmh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=Su91XMcH; arc=fail smtp.client-ip=52.101.71.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="Su91XMcH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOcaVJC1L3+yTRq5NKCa5lMfDcoEWQrBWqdgw8Md3Ywo+9u9BuFh7f9cc0dYTj5AW5T35GZHPZDbvfHH+k47sWN/KLhpjzzTwFhfniKs0xkGzEpfW2Od4QJtojtXkOXb9OBMQvtnCVqas102eBq2tjKBhvfyNJsTvLClPXYp+a7mf+0I3noTM/OwV8P+9F33zVP6ACo23Q/JOhH0siCnXwrf3MZyOgAdtxO2+hB8Spym7o9k7q983rUYOGXaJMazzLFMoSXTpEBhbsZeAzifdlzLd+H1HJbevSCZb3qjjwJkb08aD27KpEneNPgGN9WLcDvy6+vdD57MwVcfzbPvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnYhv/p8R783aDyhqAhQrbhcXHez1W8DxTimyt23RDA=;
 b=R2OUsijPZy0PzSP1rySD6wb+oGfbXKMm4NTpDP7Sz17T612111clTU60xXWLGG6aX/SvpJ753qIhxkrapNeeYRD0zttl2FRc1qKs4KxUfolnJ0ZGbbwOJImaipelGF/v9NKmYb1bM61pHGCE7+7nX3BUW/nB2jEpP2hvf5vzQtLQEGPUz1LHWEZon+UgHeLcdjkd8fZG8rM4vI6gXhsYadr7f4uAlKNZAavtiAPPmeFNHERFI2EIDcJm+fc1qMevzJpe2ZRP3sUAg++iFiIERQTdHxNQ86ESS/t6NvUZ/RgNtCOh9vc0bOERSVt9RqkUKbVP9oxriQ7/LKEtoavA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnYhv/p8R783aDyhqAhQrbhcXHez1W8DxTimyt23RDA=;
 b=Su91XMcHHTU8tP3WGtub0jyj9ar6gj0uHGCGAcanjdjrVgJQgbG2DGTbJerySUWN3lrdbAJTCTl5o51DwW8u411s4T+1N+8V/FWo6ijCmhzI3TcP3BhAUmtiC3nsV0MWNFLF8hDFyg/43ObkANhntdYeyiZEhGwf+ycXj6YKURs=
Received: from DB9PR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::13) by DU5PR03MB10442.eurprd03.prod.outlook.com
 (2603:10a6:10:527::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 22:02:10 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::1c) by DB9PR01CA0008.outlook.office365.com
 (2603:10a6:10:1d8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:02:10 +0000
Received: from N9W6SW14.arri.de (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Sat, 12 Jul
 2025 00:02:10 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: <ceggers@arri.de>
Subject: [PATCH BlueZ v2 4/9] mesh: net: constify tx path
Date: Fri, 11 Jul 2025 23:57:16 +0200
Message-ID: <20250711220035.10065-5-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711220035.10065-1-ceggers@arri.de>
References: <20250711220035.10065-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|DU5PR03MB10442:EE_
X-MS-Office365-Filtering-Correlation-Id: b31f644e-9504-43fa-5da1-08ddc0c695ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?06FUgr0pU9qFd9YmLrzuTyxLoENvKKu1ud6vYfA6UskXhtxW12lG3diLBuOh?=
 =?us-ascii?Q?PEdVIZRcKnU0QCwV17CuR5bwamAkwa3R7r340IfhkjaEkiUHkQHpjy359z/n?=
 =?us-ascii?Q?AEaMbpkwnNdxU/+Evz4SNZKF655bveb2y+8lMFXE8QjV5eBQYMl2erFqGVEf?=
 =?us-ascii?Q?9UlnYzpCWWXZMjRiYHY3Zcsi4jSMIrvvT1wpJRCXurLnI70mq1DovlPz25ui?=
 =?us-ascii?Q?WZpYAWCYI1znjJmANwfpYw3ciehEmoOS7aUNbZRvURP4Zqd7BiFbHgBExCNI?=
 =?us-ascii?Q?bBeHbLL8c2X9GBEFdE1UJ/d5B9qCHpZsct60A0YesoJ8TJZVdIYVF94oj+eW?=
 =?us-ascii?Q?7BOIpnKXBycD1I5fIp5VNs4vEE7kV6yfBmvUa6WZCiDQYmLU13f95GkCDAYH?=
 =?us-ascii?Q?Sb2p6oHOR0kPjTEY4KHuxZOIa/rsz99yVhVVYQcT0MmOIc20SoQeroQmSIzM?=
 =?us-ascii?Q?oZ8TRoH1sF6ciLqZ68Ag+ogu3jK449g7XECVlX9qT0ZyvaYXGheURi6D5U0a?=
 =?us-ascii?Q?uc4KdxPI1OxdMZ9dTey6pxsHiYr7w0LNTqgDszIMUU9twIQcLN1IqXYJYvzG?=
 =?us-ascii?Q?CtmVnfGGj+s78YnTQmN+D4Hr++xBarz72kaoQ9IbG2jLJSAoFBvS8YKQTawj?=
 =?us-ascii?Q?YN7dUiJBq4KH6F1J4Xw8GlfQwAuMN+3NuzDlEETg3jS+4jpM4oEj9shW0dP1?=
 =?us-ascii?Q?3AynzvsBd98dfrXoQJi5TBWg0aZMQPfb5fh9hM/A/cuyM9ntRCqiQCnJXM5x?=
 =?us-ascii?Q?dydh9RpMgOmGalXdLN9whCRmzWKL5qmd9sbDzq8Q+/SslZ2lcUw/efdejOZ6?=
 =?us-ascii?Q?mwN6JwMtCdDrasqnESKXAy7K57HGkFTMcETsjPP8sZmDzUWA1M99QTEMNkTm?=
 =?us-ascii?Q?Y6VbRKyuckuL1Y3USnkHPvoEkmIEaUy3/T/mel1rmo8eW8Jqwy0ApBXEZS4I?=
 =?us-ascii?Q?DcgDQgvk0rR7Vtw2uS3ZefUGRPklEEktccO74eNhzKb8CWviGSsWzUPXPw1P?=
 =?us-ascii?Q?6S3r2tV6//ixNGcCwq89WaBDPwYKMnoN3/B6nB3x0I71fv3AwOVEdN3JCHOs?=
 =?us-ascii?Q?RGPIfM8HElbxtalxzjl2ghrzqHqlKTiOkWiP8KzjqB5aeTHRxU96gmavYizf?=
 =?us-ascii?Q?gzxTY9gZg/XyGttyeIbJy6lirrD5xNXN5rxA7yeB3KtziwBv+2MZB6q6fYRJ?=
 =?us-ascii?Q?HG2Edvm9nHHlbKVVoF9aUkY7ANeAKp8REzf0yM14IObxXNdprV2IRAPIT3C5?=
 =?us-ascii?Q?gBzQ3GekAJbkxRX6q+D5O/Yny6gRYP5zxOQNJXRcJRRgnCdT/1BI1Wsdywlr?=
 =?us-ascii?Q?b0D5uhXOgf04/yeQyJ6csmO20OecXKFB9VxQDgq8YyUjnOar0O0DmGVXVK9y?=
 =?us-ascii?Q?ocbIkU5WMmjFglt0lh5xrvbFp5c8kIFO6uUgXSSBF58UKVjvpgW19KPh8YDH?=
 =?us-ascii?Q?N0r17UGfdYtNkTU8p4MOWYWupDlvWQ8HVkr58AcbiT1A1kPtobqlydnTZaiE?=
 =?us-ascii?Q?+hv5W+pVcyC8U5o74rlzMmNDrbWPKiaGCv3e?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:02:10.7111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31f644e-9504-43fa-5da1-08ddc0c695ec
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10442

Although the first byte of network packets has the same value for all 4
'send' functions, it feels much more natural to assign this byte at the
location(s) where the packet is assembled, rather than where it is sent.
This improves the readability because send_msg_pkt() isn't called with a
partially uninitialized buffer anymore.
---
 mesh/net.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index b6ff11ffd777..496e4dd7fc04 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2292,7 +2292,6 @@ static void send_msg_pkt_oneshot(void *user_data)
 		return;
 	}
 
-	tx->packet[0] = BT_AD_MESH_DATA;
 	info.type = MESH_IO_TIMING_TYPE_GENERAL;
 	info.u.gen.interval = tx->interval;
 	info.u.gen.cnt = tx->cnt;
@@ -2305,7 +2304,7 @@ static void send_msg_pkt_oneshot(void *user_data)
 }
 
 static void send_msg_pkt(struct mesh_net *net, uint8_t cnt, uint16_t interval,
-						uint8_t *packet, uint8_t size)
+					const uint8_t *packet, uint8_t size)
 {
 	struct oneshot_tx *tx = l_new(struct oneshot_tx, 1);
 
@@ -3159,6 +3158,7 @@ static bool send_seg(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 	l_debug("segN %d segment %d seg_off %d", segN, segO, seg_off);
 
 	/* TODO: Are we RXing on an LPN's behalf? Then set RLY bit */
+	packet[0] = BT_AD_MESH_DATA;
 	if (!mesh_crypto_packet_build(false, msg->ttl, seq_num, msg->src,
 					msg->remote, 0, msg->segmented,
 					msg->key_aid, msg->szmic,
@@ -3216,6 +3216,7 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 	l_debug("SEQ0: %6.6x", seq);
 	l_debug("segO: %d", segO);
 
+	packet[0] = BT_AD_MESH_DATA;
 	if (!mesh_crypto_packet_build(false, ttl, seq, src, dst, 0,
 					segmented, key_aid, szmic,
 					seqZero, segO, segN, seg, seg_len,
@@ -3370,6 +3371,7 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t net_key_id,
 	l_put_be32(ack_flags, data + 3);
 
 	/* Not Segmented, no Key ID associated, no segO or segN */
+	pkt[0] = BT_AD_MESH_DATA;
 	if (!mesh_crypto_packet_build(true, ttl, seq, src, dst,
 					NET_OP_SEG_ACKNOWLEDGE, false, 0, false,
 					seqZero, 0, 0, data + 1, 6,
@@ -3457,6 +3459,7 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 			return;
 	}
 
+	pkt[0] = BT_AD_MESH_DATA;
 	if (!mesh_crypto_packet_build(true, ttl, seq, src, dst, msg[0],
 				false, 0, false, 0, 0, 0, msg + 1, msg_len - 1,
 				pkt + 1, &pkt_len))
-- 
2.43.0

