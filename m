Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20432F1984
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255667; cv=fail; b=nEmB6C430WPh+lNBivvlI2Ft502NNro0oxMD/srqcrKg3VwAZMdKTckLKC4hFVMmXB/lbDDC+oIoLGLXhcCIvycCn5HgXvBKuPJWaJRhw4g1+y76zF0JcVU8LNx6u3ECDCqa6UmRgaqMdEhERB71TPkwNKePpSSmM3OXd7uAsKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255667; c=relaxed/simple;
	bh=kyi/OKzYNg+MHLZYwPTZhYGR48b6aw1qWf7ACN8/Pi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pmujbu76Tqet6tGiBUQuekfiiWxKCq9kZ2foTYIYmb3u4YJgmUP74x6/+JOBwZ/GJyX/LpcQhi/VPdqOxFXtY/zbTa0ND+2j0T/jdVCYcVGW6cE4UlPJaIxEn4aNzBD6kXFCJt0wb/WyECSNq+aDlYXFDL7KOgy6AEXnAV2xBJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=asKo5O88; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="asKo5O88"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCj0MU4Cg1kcoA1QQfOZCUOWALXsJbgMa7XaVCNQoId0DzVqD4MVOHmOo6FB86Njuupt6Ftpt6ReFv9TF/J1rBSj5Qwk+ykOYRTZ2wFdEKjaK2YN4YXIojjyI+2Slq3c4KWjIN4dE+n4TKTE8YfGL8bG3DRkj8GP5O4XcND18dDBCvIQXRyshVdlqjlex9XCic4zTA8ulv9ccETuixM7tAcWQdzrj5uHqKa12ZVS/xGroVcaHMX0fDS01tynZs6J/hDyGauaIgbpbJV2v3SeX2jLAfL3uNcag5hvs/4UbeHgqQ93CoGez3TKLtEn2Md82ngq0YnNCLFHVjiZswSDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1vtIAvrYUbObgC9OY0ggfMz3xa01T6WyMYZHun7qUY=;
 b=g8F9PXrigoYTSaaqQVObj5FmOGFGYLZ26hkTFeccFR/sAEmYs0DkmqBYIwxVfmCdqkp8UTGEyhWHvDLjr3RmXsHhRUNW1MJyWynDqg5sV66R44GDOZ/qrPaiuc9U5uk7B2DvFRN6hjREN9eWKpB2HkUS3tSaGByvIFl3uH5KOY365vn7FFJgAY8tyvMhUJ/jiv25yvD/N8rCAliEl6RGNZ1oDhEmKR4jU4ddOiZCBjxvd/wlpd8B0xQnC0/d3VMyb+5LbCzTQMWfsVLrFYncMwsTTMHkywiGErCi5AkJO0eHzTrWe7rOEjBCWRZQIcPAmrE+VlHHFdVnEgqBEuooag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1vtIAvrYUbObgC9OY0ggfMz3xa01T6WyMYZHun7qUY=;
 b=asKo5O88SRXqEd9NRWmBd9mngKAlvH9RebxHD4ZGhJtUAE+egnIf+gyV60c6TcLV8lw+veapXh/4d64PkF2QkP0WzvTAErvwaQafuylwIsjC5qLQXrOnVx+jaklm/EQZVVS36TUrCTsmjm+uT8xaGRFUcRdFvcbtrJiCzwbA6ac=
Received: from DU6P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::29)
 by AS8PR03MB9863.eurprd03.prod.outlook.com (2603:10a6:20b:53d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 17:40:59 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::7b) by DU6P191CA0003.outlook.office365.com
 (2603:10a6:10:540::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 17:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 17:40:59 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 19:40:58 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 1/9] mesh: net-keys: more uses of BEACON_LEN_SNB and BEACON_LEN_MPB
Date: Fri, 11 Jul 2025 19:39:17 +0200
Message-ID: <20250711173958.25689-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711173958.25689-1-ceggers@arri.de>
References: <20250711173958.25689-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009527:EE_|AS8PR03MB9863:EE_
X-MS-Office365-Filtering-Correlation-Id: 88345a56-1ff5-408a-d59c-08ddc0a2191d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dBQWsRKcOBcpYcwX5cqPbxkdeY9b7Lfa7/5Nf+bFrJWmqGPweRsWhddxG9i6?=
 =?us-ascii?Q?F5uFq6k0tEDaPwTWOqK5m0ecoFLStpRBNV91ucCmhW5yUnTHUcqf2ARRnDAz?=
 =?us-ascii?Q?FPHekjIIVLX8lwwdmO8UzHTInXrUvDSJrThrjVF7Bv1CNnxjyojYeVV63Z0+?=
 =?us-ascii?Q?DoiPrQdFkY0oWUaTcFSF4oil3WAzzcMkpkePpbmSkRH9jtQI90V8j1roTxrf?=
 =?us-ascii?Q?RsnG6QmU6tcRtBsD/oARxbEiJwDlGImbDVRpZ4ub6ys8PXobFOJcJgdSLndx?=
 =?us-ascii?Q?jNhmmlNrn5uuo/qE7tH6xuk+RvsBQmsOEPZ7MgbkQwYHMll4vdc/uX3XKr42?=
 =?us-ascii?Q?z1IswHTvTu/+qNaGmvJflwtQEvF1wMq6AGD9XFPZrFVb8EnyQgHyF1KDW8o3?=
 =?us-ascii?Q?i5Q2apA2z0G4TI/2BZkWZfRvlXDoqtLHZ2uTP5lruv0iMvTLyn9KFz0zCRl5?=
 =?us-ascii?Q?lxClrcYn49JQdEuc0cix2Fo8XPQfVeBeUZ4UMN9qPoUBX1trJm0yj9bnVB2x?=
 =?us-ascii?Q?xftRHCoh6Uw4WOuD8UUWO0uqWT5xIzdgqqLdyFPW5Zr21STSVmELz1BPKgWD?=
 =?us-ascii?Q?v3URDhGRdq6A75xxKO6P/v0y1PwNLXY9Gi8fPWV9Rg7swsYt2XIiXMThpvnf?=
 =?us-ascii?Q?lvjY3mBAT+aDurIN4jUwxXtisgKXePVdIhUZhMOkSNk4I/t25OSmRrVRl2+N?=
 =?us-ascii?Q?3T19yLf/VsStMwmtNS4ABHMcpJ7RQudl1OgwcgwlSHEeop7EXveeZoHsbj86?=
 =?us-ascii?Q?6n796smUurwSguwk7dR6pXlRTCL6T618xY86WxMjgXDCq0apJLfNIHUU/Rw9?=
 =?us-ascii?Q?HqmETSiQLnVQwnfGLM0WeP2RIPMad1iLxacCeh0jM9mW5Y1P0FIEgrrNkO7j?=
 =?us-ascii?Q?QoSKSKic96xDdi2LF3RwZEBc2/04JvuZeUUmIgbg84ReNI8RXjA5WgOCh474?=
 =?us-ascii?Q?prOnIgWwzJeSMpONUAeysuo32FK+u1ETaalxdf02/U8jkIGlBURmUQRPg+Nh?=
 =?us-ascii?Q?G6NzazXhw6qiXQ+ZrI1MUcatwOx5IDdyRtDmxUPdQUsU5a1QV7L9kwQypZ/G?=
 =?us-ascii?Q?CjSO2OgoO8jn+/foE76gRSlBbaC/Sb1y6r8LUFr7kQtAnp9Nde9aYavasCSD?=
 =?us-ascii?Q?fvzCp5iYb2Z04jwAIyvSIm2bwHAXF281RAmRMIHTceXa2BStO3Q3E+UtkIam?=
 =?us-ascii?Q?vTELtlz9CAcxoQlhMTZ7mPm4zHPQDoKhLAvEFzUJdQIp9hqywKyAsFqmyRxG?=
 =?us-ascii?Q?12b4Hz35XAy1aEP+5pMvo/9tw8hUXZspdOqxJAXRm4ARGcpT1otBMfdVkdtw?=
 =?us-ascii?Q?kubNKObgBBow+kJO4ebaICjeW6o5l9yarVzaqtLu1AW2b+p3yEEz5YscuRGs?=
 =?us-ascii?Q?wIPIcNho6SmTBZAACkRUR7lBtnukWaKRcDb3m0xIQVjJ50kDBnCdZi/lPGaA?=
 =?us-ascii?Q?zHbu3sZ1Ug9mcFtzWxk93qhg1HkFXhJSYLNQHO1ssPNHePPBNuScKXBbOV//?=
 =?us-ascii?Q?I1H/xXhlCF5D+RVOVQ41h1LkLb1dODepQuZQ?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:40:59.4368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88345a56-1ff5-408a-d59c-08ddc0a2191d
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9863

---
 mesh/net-keys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index a10f93ccb03e..22ab5b626a84 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -442,10 +442,10 @@ static bool match_beacon(const void *a, const void *b)
 	const uint8_t *incoming = b;
 
 	if (incoming[0] == BEACON_TYPE_MPB)
-		return !memcmp(cached->data, incoming, 27);
+		return !memcmp(cached->data, incoming, BEACON_LEN_MPB - 1);
 
 	if (incoming[0] == BEACON_TYPE_SNB)
-		return !memcmp(cached->data, incoming, 22);
+		return !memcmp(cached->data, incoming, BEACON_LEN_SNB - 1);
 
 	return false;
 }
-- 
2.43.0

