Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5812AEF1
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256860; cv=fail; b=R6VVB1vOtWPBfxbo4lKl10aj9SvyTkegZbCbdUaiOZ2QC56KlsUTouM93rcVxIDkR0g+VwX2awaOoWO+Qq78PDwaJVgFaN1vWH1yw5HhuiBlAIyCFDQeZpODIRUX/7oJeVrRYwjtKd1s+nZfUAE/wkjOyaCKn/7aTWVY9rkfXmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256860; c=relaxed/simple;
	bh=3ajZewgRcbjJR90DKy751seOU2YY4DCFw6tYjawjLTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIkFZyNCs4fs665zJdIJFW7GEhRrzAq7gcC6UpEw597ObPLrQj37334BEBfF97bxIKRj9G580G031EKWK7P3k/pI8KohAAb/iyPFSgtmUnCGNekWqsPmSn3EUSX6p0tCitA0jovzFmgGeNdnrwBlQwvxVO5hBtyuNMbu1762Q+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=W57sR62P; arc=fail smtp.client-ip=40.107.162.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="W57sR62P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdLkLkuWfV9MJXYHRgFL1+I+pR5zEZ3DGVlWERgrFvY0NhKJQHuMCUhc6rQ4ko9SRRp13ympS0boFm68Arro4idmqR6YmJEoqWq98u5qVIia6hDH2gTKCTDYAaDPOLqTVR33X3o8e+0J7zFZ5gHiNlNBUarpI/vOVjJu01d7OVs4z9d6eYUIEV0apVy6a1kPvXOiTvy5cBYqURNl4ekJBjdYClpKQiSiBmDsvRjbz2G7QLEtvb0WzBKdk4RXkfBAAUA4i1MqsL5xIXumfWx/4rFIL6q8x+PGLt/5gNvA/fthSC3xuJYomaneo2tL5nns7PPbGMHhu1rU76voE/uaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAw7sAvUE5pL1RhE701SC0nkKQWYUPcI2PYYdOG0ePs=;
 b=VnzOlGuZEQNxCJhg1UxWGHPPm8S4UaKVQRf0fbg/oe3Sm2ERLA2rioU1cN3hFhAQVozm/dj5AEe569CpG7+xwaPA/OQIM425AOT4VsrsNNSY/bxgYp3m/zHlJyKRNFGmAJWNbXeiqnRJivhCHCt0gE3JyyOUrQTLeyZ2tM21EWCfp7h50vPN7Ydxs46NcqMwY5JhO95L8K3uc2nKU8+R479mAH3xuDOAYbTls3dbvsieFfY1Hzudig1yWhNPbaRiR+R63jONiemu8/nI6/JW9oMbBqS1dJPwTJvQ35l1ChPiXf+S35hFdxF0bVZPYbLKdCa1CslgSLBuWawbSFh+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAw7sAvUE5pL1RhE701SC0nkKQWYUPcI2PYYdOG0ePs=;
 b=W57sR62PbmBs+ORJgFHjCrXhEdnFuZijxPxfXa2YwY8NoayLpEANRy48Fi4EiwEjSo04U8mwIYNFKhwWtceqVqdE4NjpxJj+vIZyp7XK0n8XApeY3VKoLtmPQyaVqYXsk/xpJvhc7RjSiKgM7otTDTj5h+9/D7IMkMhJbQ/H7MU=
Received: from AS4P250CA0020.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::9)
 by AM7PR03MB6577.eurprd03.prod.outlook.com (2603:10a6:20b:1b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 11 Jul
 2025 18:00:54 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::99) by AS4P250CA0020.outlook.office365.com
 (2603:10a6:20b:5e3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 18:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 18:00:52 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 20:00:52 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [RFC PATCH BlueZ v2 6/7] mesh: net: proxy relaying
Date: Fri, 11 Jul 2025 19:56:56 +0200
Message-ID: <20250711175842.28860-7-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A8:EE_|AM7PR03MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da0d943-52c9-4357-1336-08ddc0a4e073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ir9sNWC6tDhQA1wurUG9vMXz22GTW78P7j09UdARq3WFHwW21udT5i5UG17E?=
 =?us-ascii?Q?44foQgMFAFshSKPdKWj4l7stC4ppR4YDG3MwsDackZbH+zdHbO9TiE/OfBgt?=
 =?us-ascii?Q?WV/Qs3V7NeYs/EgyYDkOkw3ScxBld9FoCSBjWNt+a13mIexgh0WSN0BmzMhh?=
 =?us-ascii?Q?ADhFsfWSzMioHBcApJYUbLAevw/CvmbfKEb0XgekoGVx9QM9yTDpF0WJ490g?=
 =?us-ascii?Q?BgWzoZWsoiRfxM+lVwoUA9iGzzJ36vTrfLXEWgeK5R9xouo4eXEDZOEy3FER?=
 =?us-ascii?Q?Fh96ALeTSWfj9SsMN58/JOAU3VAr6UsEU6Q+gR9YQotZXroPwxwMvGlZJlgs?=
 =?us-ascii?Q?o3vuasmWG/8z95qXaBgvjIGlUi/Edy5EZeB9hYCvf3GQKLAubus9ZD3K6Awj?=
 =?us-ascii?Q?wQ2lebZHB8w+riC1wmEuji9e2+PuU/o04rZLZ5nK9Gv1neNyY2FnXPK9XiqU?=
 =?us-ascii?Q?lXXrNAyqWpjEbjA3FN53LnShA4AVAE8ZtukhaUnJnwp14bVhTCcyACWFJzKU?=
 =?us-ascii?Q?V7inWitUBTAiKZAd5UBA+CNGIAgrgK+mwJn6IiB9BxZ51OfGrP2TtTwTvSCg?=
 =?us-ascii?Q?c+HJ5vX+4WLWKYrVX83GADP1vo21oFMsPRwU0/KLQTYB6v+FhckcsuyA7FF/?=
 =?us-ascii?Q?Iu146EdFW3GzeM1TSjZpwaWC9LRUvyNOrslsammUpb7BraOWnstu6El4ne68?=
 =?us-ascii?Q?mDAXrXTPBre1sqaXkzpoJIbRga1b4PNzSRDWcmm9Xy5vr/A1IG+FkXdVeWJw?=
 =?us-ascii?Q?jm1fEW2C2I8iTepSLc/Krvzg05GlJcTMNg09fm/kqfiuVxUSyQW/gWNSCI59?=
 =?us-ascii?Q?nfEPi3ALBwosPLEm5Tg6sLYPc//zNj4H2VF7if1reIal8LcgwQAVbgCF1gFt?=
 =?us-ascii?Q?GIPsbLPfrW7YxTpBW+KDOMZqEofb3fGjYVpP39lifPMfTilyFuTNccFfYrrk?=
 =?us-ascii?Q?fL9+I8ZcXLScjqhE8qnEpOPGYM94bXzuuICoicUnJihKnQq41TTYpxV9R5Fo?=
 =?us-ascii?Q?3yZo023CPB/FZ7n5oYo8XEELh5xFDyDt9D84777PLjWYfeR1c3hLbQP5oPWR?=
 =?us-ascii?Q?VXIGQe1xEVrhmqXS8LD6rPUoKqCqIIhjuGlEOhSrWy0lNPBA3obYlLCGrEQ6?=
 =?us-ascii?Q?iyhpt77A1sKxV/Zol8faPWMWHdq+jsAjuArrZBFfJGrYsbmKjooiWRt9V5+5?=
 =?us-ascii?Q?MHmbu0bSAwjB3svtdxHLv+8bo4vudPhKyPfeiEuz9JYKQ0ILlHS8g+IK2pQ2?=
 =?us-ascii?Q?6IZjmtUK6zMN84o1Mp0CjpMOfHsMLvunGyFKvMAjwWBOFuzRLb5S3aySYv38?=
 =?us-ascii?Q?AEoKw9dw+TmN61vZFFnLGhrvT7m50OZ0Yn7tBJGt0Mbs3rRQK9YeVT/b43yz?=
 =?us-ascii?Q?CkAXeibv7GBVjRfhOwwtzNCYHBAJ+XQtn4VC60MEBVC/r5n0g1/49yUizlQh?=
 =?us-ascii?Q?xmXhboKSsTdfhOGYmL9M5V2w9wwCLiLxv4CwB3X4BlvzQudpqQbVMUd/8BRI?=
 =?us-ascii?Q?D9YtTgt/RixAIUUIZ19gcjz0gzG1IpJOB7tI?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 18:00:52.8844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da0d943-52c9-4357-1336-08ddc0a4e073
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6577

Implement retransmission of network messages according to MshPRT_v1.1,
section 3.4.6.3, table 3.13.
---
 mesh/net.c | 52 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 9a04aa5120c4..97591a5323d1 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -183,10 +183,12 @@ struct net_queue_data {
 	struct gatt_proxy_svc *gatt_proxy;
 	struct mesh_io_recv_info *info;
 	struct mesh_net *net;
+	uint16_t net_dst;
 	const uint8_t *data;
 	uint8_t *out;
 	size_t out_size;
 	enum _relay_advice relay_advice;
+	bool proxy_enable;
 	uint32_t net_key_id;
 	uint32_t iv_index;
 	uint16_t len;
@@ -761,12 +763,7 @@ bool mesh_net_set_proxy_mode(struct mesh_net *net, bool enable)
 	if (!net)
 		return false;
 
-	/* No support for proxy yet */
-	if (enable) {
-		l_error("Proxy not supported!");
-		return false;
-	}
-
+	net->proxy_enable = enable;
 	trigger_heartbeat(net, FEATURE_PROXY, enable);
 	return true;
 }
@@ -2343,7 +2340,8 @@ static enum _relay_advice packet_received(struct mesh_net *net,
 				struct gatt_proxy_svc *gatt_proxy,
 				uint32_t net_key_id, uint16_t net_idx,
 				bool frnd, uint32_t iv_index,
-				const uint8_t *data, uint8_t size, int8_t rssi)
+				const uint8_t *data, uint8_t size, int8_t rssi,
+				uint16_t *dst)
 {
 	const uint8_t *msg;
 	uint8_t app_msg_len;
@@ -2364,6 +2362,7 @@ static enum _relay_advice packet_received(struct mesh_net *net,
 		return RELAY_NONE;
 	}
 
+	*dst = net_dst;
 	gatt_proxy_svc_filter_pdu_rcvd(gatt_proxy, net_src);
 
 	if (net_dst == UNASSIGNED_ADDRESS) {
@@ -2487,7 +2486,7 @@ static void net_rx(void *net_ptr, void *user_data)
 	uint8_t *out;
 	size_t out_size;
 	uint32_t net_key_id;
-	uint16_t net_idx;
+	uint16_t net_idx, net_dst;
 	int8_t rssi = 0;
 	bool frnd;
 	bool ivi_net = !!(net->iv_index & 1);
@@ -2528,8 +2527,8 @@ static void net_rx(void *net_ptr, void *user_data)
 		return;
 
 	relay_advice = packet_received(net, data->gatt_proxy, net_key_id,
-						net_idx, frnd,
-						iv_index, out, out_size, rssi);
+						net_idx, frnd, iv_index,
+						out, out_size, rssi, &net_dst);
 	if (relay_advice > data->relay_advice) {
 		/*
 		 * If packet was encrypted with friendship credentials,
@@ -2538,8 +2537,11 @@ static void net_rx(void *net_ptr, void *user_data)
 		if (frnd && !mesh_net_get_key(net, false, net_idx, &net_key_id))
 			return;
 
+		data->net_dst = net_dst;
 		data->iv_index = iv_index;
 		data->relay_advice = relay_advice;
+		if (net->proxy_enable)
+			data->proxy_enable = true;
 		data->net_key_id = net_key_id;
 		data->net = net;
 		data->out = out;
@@ -2601,8 +2603,10 @@ static void net_msg_recv(void *user_data, struct mesh_io_recv_info *info,
 		.data = data + 1,
 		.len = len - 1,
 		.relay_advice = RELAY_NONE,
+		.proxy_enable = false,
 		.seen = false,
 	};
+	uint8_t ttl;
 
 	if (len < 9)
 		return;
@@ -2616,16 +2620,28 @@ static void net_msg_recv(void *user_data, struct mesh_io_recv_info *info,
 
 	l_queue_foreach(nets, net_rx, &net_data);
 
-	if (net_data.relay_advice == RELAY_ALWAYS ||
-			net_data.relay_advice == RELAY_ALLOWED) {
-		uint8_t ttl = net_data.out[1] & TTL_MASK;
+	if (net_data.relay_advice != RELAY_ALWAYS &&
+					net_data.relay_advice != RELAY_ALLOWED)
+		return;
 
-		net_data.out[1] &=  ~TTL_MASK;
-		net_data.out[1] |= ttl - 1;
-		net_key_encrypt(net_data.net_key_id, net_data.iv_index,
-					net_data.out, net_data.out_size);
+	ttl = net_data.out[1] & TTL_MASK;
+	net_data.out[1] &=  ~TTL_MASK;
+	net_data.out[1] |= ttl - 1;
+	net_key_encrypt(net_data.net_key_id, net_data.iv_index,
+				net_data.out, net_data.out_size);
+	/*
+	 * Table 3.13 in MshPRT_v1.1, sec. 3.4.6.3 states that (if proxy is on):
+	 * - Inbound messages from ADV shall be retransmitted to GATT.
+	 * - Inbound messages from GATT shall be retransmitted to all bearers.
+	 * For me it seems not to make much sense relaying incoming messages
+	 * from GATT back to GATT.
+	 */
+	if ((gatt_proxy && net_data.proxy_enable) || !gatt_proxy)
 		send_relay_pkt(net_data.net, net_data.out, net_data.out_size);
-	}
+
+	if (!gatt_proxy && net_data.proxy_enable)
+		gatt_proxy_svc_send_net(net_data.net_dst, net_data.out,
+							net_data.out_size);
 }
 
 static void
-- 
2.43.0

