Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093351F4CB2
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979803; cv=fail; b=lUVdQ0xEz20QBYvfQT2AYIp8oljwVeN1XbuDzYXCnmvp4q6ml9xFNz/St772YeVg585/GlWsuEHNkKvyTNCDtBxsCzoRN39viutj1ACTKjin21nsG2oF3EbuzwcsT40CJKsjt6tViQVfK/P7pS8QRIpFAoFzeRunQR+LdHxslBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979803; c=relaxed/simple;
	bh=yuKzIXzhNhovvzeQ2vFzy6vzCvb8KJ69ryLHdg9Zcps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xm6wFT3o0lmczLohjzHTDMfHJ2mR4RWoHjJBE1v+W4PUf096Bfl2BHSOVTQ1Zp1J0XEzk4J7L/S2amaPopBH5GjG68eVHu6PuNPfwO0SxSZlSAn2jSds+rPZZp8eiX+fh7i/pPpjPaLV9Fiv/IN7CRuOwp/vOc5XlfongpJ0WIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=M2m7i3kX; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="M2m7i3kX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHmYJqVea9MeKN4lEUMwIVY7QH1BPSIdXKWoaKyM6lboHtHoNOLZ/DPZCbk5Lge7vC4tYQh2N4Q3jZytkS5fbxsmYb7+efPKKGYHAbkI/xr3Pf8kkzhLcBjD4Deq5vIQM5aO8R86UussHm6FHDjihY4cHRAVNyLSdZRRvTIYD/SbdawnRPDtLHv7t51QTUjKUKuBDNzEGpdbtBE1fiGxklzPavt2ngIfnhtbFKUMqfOOZrC9QD7cmZvaOr6YHPGUkIPgf/qZdZYe11cfEB1Vyg0V7UEQ7RRypmXUFGBaq/KziYdbs3H4/OH/v/dxW8O4gxMv3JYhfgCCcj5vXC3EyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1kCz49gRE1E0m65AXMzLxxzAv5ahszOOFRhwukxG5Y=;
 b=QC+9SSYNOKFQ+FfpxQ5yLUrg8mlvhOZDbYVv+F+ABtFSYlTN5QyZg4Aq40UmyFmUc0FwnFGE5Pyy3MGpT9kL67FJ7xB8dztkkcRr8Ktthkcv2S6T+MUTUJ8FDf1hVB4fFGYRKiwK2rewH1M9XHEyEhXl0dkewnjS2wZ2fr0tq1u7AN18uMrp61A+DFBLlLXVnWsIk/Qcwlt4/8EmrvS0KqIjLqie/rXNHm4PMPnkBRKBD+FodVK0ANJSb3d5LaSf/7vkYRO3KhdphUcyk5oOxQPpCHa3Jq3+rm7DOvRE7SfQMgNQpsWYw3qpcIqor6OfzA3Hlengblu3ZxuJuwMfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1kCz49gRE1E0m65AXMzLxxzAv5ahszOOFRhwukxG5Y=;
 b=M2m7i3kXI+XOo4KtX/XlOl5x5zPhB6hwuN4ZYUaXn9UBhdXpBe2c3KBhrfjV5GerhR/BzQyW6HdUWi0MkoBH3zDhSinXE/uirh32VF3MkjWP7WbQn2q4i0GDMuDvCC/Fysho+gA2Wrxlsq7JzXrHbfItPjPmRsAhvAO7AeYDxME=
Received: from AM0PR03CA0077.eurprd03.prod.outlook.com (2603:10a6:208:69::18)
 by AM9PR03MB7236.eurprd03.prod.outlook.com (2603:10a6:20b:260::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 13:03:15 +0000
Received: from AM4PEPF00027A5F.eurprd04.prod.outlook.com
 (2603:10a6:208:69:cafe::77) by AM0PR03CA0077.outlook.office365.com
 (2603:10a6:208:69::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Tue,
 8 Jul 2025 13:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A5F.mail.protection.outlook.com (10.167.16.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:03:14 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 15:03:13 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 10/15] mesh: net-keys: introduce BEACON_LEN_SNB, BEACON_LEN_MPB, BEACON_LEN_MAX
Date: Tue, 8 Jul 2025 14:59:42 +0200
Message-ID: <20250708125947.11988-10-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708125947.11988-1-ceggers@arri.de>
References: <20250708125947.11988-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5F:EE_|AM9PR03MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aad659f-2fa2-4b1e-1f02-08ddbe1fcc8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fwvc2CFT5cjjkgorF+Xp3sK5dL0Zff5nnPgA0g74HiHa6W3QzkAj5hiGyPWi?=
 =?us-ascii?Q?NIzk41YIv+DLWjUBMO/fUkvYJfKqvrIl3PlFqKYylVcr7hYxBcrBcdZJnwuw?=
 =?us-ascii?Q?Xr2oPdiGwgvg4Bn1riaN+fzIQ7ENZ+AtvdAtl7KP0eNIO5YQlpcKH1NxK/ko?=
 =?us-ascii?Q?atRqMNmR5fb/fFL+d3IUoRx5EIB7CeSQVltsPDz18/e7llJU0IJ2UJ2fQvc3?=
 =?us-ascii?Q?ArSQrqQQApe1Z+k/c7inVlmRxsLHD8Mlr9/CsB1hnZiUKbOtxWeVsLW+Ycez?=
 =?us-ascii?Q?Z0XelMd3PwB7hhZEy1Eed61MmFswYzqpJC3vM7GpQOEImF4DjjHg7r82zXVn?=
 =?us-ascii?Q?veoNeYrMDCHQ2DguXoXoQkWkAGChjD0ErXsUEXbvC6ZOJU+qCuq3X4lg+Jxf?=
 =?us-ascii?Q?1I5nK2xt6UwlGfe7wNXz9CLEFtTee4s/7m/W+2mog4G9xsxDgoLh5jZ133cE?=
 =?us-ascii?Q?qYXYLKolvZTu1RD4IOAs4KUhtRpQGyWtQkRSDMLvAzsgUGnGtocu8iY6Ejuk?=
 =?us-ascii?Q?kLl7GYEvX48vMphIiBSw2u0GcjTZxZPYOIJk5DWMRjuxfJR9fOYHkg5bWbVA?=
 =?us-ascii?Q?GDxARmXeAQTOSxfTNPmLnHppaaVjR3xNsrwnuQ94zrVmAby2AS44iv2+FIn2?=
 =?us-ascii?Q?mipl8yF0aOxO9PGop6HmkF05T2qV3yUohChGicpmreEy1SpHIlOMDalQJBoq?=
 =?us-ascii?Q?OqHl3Su65tmxHVg0BOdcZ/ZZRkeoz4sirJqpYgTcI8plDrBTVYJdXZHb47Nz?=
 =?us-ascii?Q?EUxINqT6SD0wf8Cxxk+WhEc1Svz2jDi6gnrW6zU5bdqSABI7AdHp1DTshUIt?=
 =?us-ascii?Q?KLBTcGECEQ5lwvT4KBjYECQ2IAcanl++k5t8hgVOX10xuJHS9Guo0aKIszXC?=
 =?us-ascii?Q?SOtc6+yulcJ1u2IO+fSauUlRHvD1AK/hprIUBgseIdx/E+68lCnoDGHOJyve?=
 =?us-ascii?Q?dm2eZ8rXBJ3S0ZFKIK+mYHZRa2y8fmyahLvVRHVmNTr6+smKKQxEcWho8H4R?=
 =?us-ascii?Q?95hPrC62tGpG7xCdLxiixrHcS61IcAzshayYzwWwVr65RW9SUwoZrglXDUzf?=
 =?us-ascii?Q?IW7/+gSt0XX/5sKfGrERSDBGUE+xBHkjAp/tl3+azRwRYkAJPKCt8xQX9MPI?=
 =?us-ascii?Q?SfQ+P3SbZBUeMKkDxigVFLLxmOcJTz7umUZR+tZpvGMkLBaxxQOzKB48CGa2?=
 =?us-ascii?Q?XpTxrcoV5QRwW5mni8J+t3a1lQ/Scu0eZNtG+zcGkLhh2v5UyWLO/xLtHNpQ?=
 =?us-ascii?Q?quLer56GIsaNaLFN4g1Ob6y8pygzJemGGt7CyZd+43ty6+HQ453pjMj0Lcm6?=
 =?us-ascii?Q?pBOS/hdRcHYDxMz7H/3b1MOglr5+Ayg5KVX/3kZnHC7J4JcgdGz8aYfmicoT?=
 =?us-ascii?Q?8+B87uHGL1wrls/yjU++ir32/wVdWL1uXzGMQU6kjg3w8zRkqNmtKM1g+o53?=
 =?us-ascii?Q?6xBsGHsq7RGvntmStPUomK9G9zUed5JcGkij9zcSUroYkqTBdAIQTQW9idUR?=
 =?us-ascii?Q?3y0cdBBZPlUYh62vY3OhK/o8w49AQiGuhEPh?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:03:14.1195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aad659f-2fa2-4b1e-1f02-08ddbe1fcc8e
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7236

Lets introduce symbolic names before spreading these magic numbers over
more locations.
---
 mesh/net-keys.c | 18 +++++++++---------
 mesh/net-keys.h |  3 +++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 42d498ce0ede..a10f93ccb03e 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -30,7 +30,7 @@
 #define BEACON_CACHE_MAX	10
 
 struct beacon_rx {
-	uint8_t data[28];
+	uint8_t data[BEACON_LEN_MAX];
 	uint32_t id;
 	uint32_t ivi;
 	bool kr;
@@ -458,10 +458,10 @@ uint32_t net_key_beacon(const uint8_t *data, uint16_t len, uint32_t *ivi,
 	uint32_t b_id, b_ivi;
 	bool b_ivu, b_kr;
 
-	if (data[1] == BEACON_TYPE_SNB && len != 23)
+	if (data[1] == BEACON_TYPE_SNB && len != BEACON_LEN_SNB)
 		return 0;
 
-	if (data[1] == BEACON_TYPE_MPB && len != 28)
+	if (data[1] == BEACON_TYPE_MPB && len != BEACON_LEN_MPB)
 		return 0;
 
 	beacon = l_queue_remove_if(beacons, match_beacon, data + 1);
@@ -527,7 +527,7 @@ static void send_network_beacon(struct net_key *key)
 			net_key_beacon_refresh(key->id, key->ivi, key->kr,
 								key->ivu, true);
 
-		mesh_io_send(NULL, &info, key->mpb, 28);
+		mesh_io_send(NULL, &info, key->mpb, BEACON_LEN_MPB);
 	}
 
 	if (key->snb_enables) {
@@ -536,7 +536,7 @@ static void send_network_beacon(struct net_key *key)
 								key->ivu, true);
 		}
 
-		mesh_io_send(NULL, &info, key->snb, 23);
+		mesh_io_send(NULL, &info, key->snb, BEACON_LEN_SNB);
 	}
 }
 
@@ -636,12 +636,12 @@ bool net_key_beacon_refresh(uint32_t id, uint32_t ivi, bool kr, bool ivu,
 		return false;
 
 	if (key->snb_enables && !key->snb) {
-		key->snb = l_new(uint8_t, 23);
+		key->snb = l_new(uint8_t, BEACON_LEN_SNB);
 		refresh = true;
 	}
 
 	if (key->mpb_enables && !key->mpb) {
-		key->mpb = l_new(uint8_t, 28);
+		key->mpb = l_new(uint8_t, BEACON_LEN_MPB);
 		refresh = true;
 	}
 
@@ -655,14 +655,14 @@ bool net_key_beacon_refresh(uint32_t id, uint32_t ivi, bool kr, bool ivu,
 		if (!mpb_compose(key, ivi, kr, ivu))
 			return false;
 
-		print_packet("Set MPB to", key->mpb, 28);
+		print_packet("Set MPB to", key->mpb, BEACON_LEN_MPB);
 	}
 
 	if (key->snb) {
 		if (!snb_compose(key, ivi, kr, ivu))
 			return false;
 
-		print_packet("Set SNB to", key->snb, 23);
+		print_packet("Set SNB to", key->snb, BEACON_LEN_SNB);
 	}
 
 	l_debug("Set Beacon: IVI: %8.8x, IVU: %d, KR: %d", ivi, ivu, kr);
diff --git a/mesh/net-keys.h b/mesh/net-keys.h
index e73812481ddb..61340dbfd804 100644
--- a/mesh/net-keys.h
+++ b/mesh/net-keys.h
@@ -10,6 +10,9 @@
 
 #define BEACON_TYPE_SNB		0x01
 #define BEACON_TYPE_MPB		0x02
+#define BEACON_LEN_SNB		23
+#define BEACON_LEN_MPB		28
+#define BEACON_LEN_MAX		BEACON_LEN_MPB
 #define KEY_REFRESH		0x01
 #define IV_INDEX_UPDATE		0x02
 #define NET_MPB_REFRESH_DEFAULT	60
-- 
2.43.0

