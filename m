Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA091DA60D
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449046; cv=fail; b=AdJoyvxR7v3IcVtdC2FsOO/UdDmyRhzAZq4/WUpF7IAkA8uoXS/qu/gXCpj+vp5x/yBeEaSoeHKCC1KCxpYZ7wTGGzlmWxh91ew4EEsIt+qVzf6HwvONueR2EYgZ/LB7KIsH1JgT4DwEGO/BXsIw3jH4nSO/JD4sLbGUEK6/al8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449046; c=relaxed/simple;
	bh=WeE6GlWeI7q4aMA8JhE+jWtk6ZGY9TlMjrJWCDJMw4s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RrCFN58teALBTmBI9l0chP53P/veYmxYh3GsI3aiPpBNEEUMMmrxsKrsObswit49YuWn+hWz/c0ZhjL2utBd5QaESpt5jS6MRl+KMBkegFaVlqNjAaeiwEoYYyuRcsCbxI4yzWp1ROrGkDPtqsmmWADDR5xABb5gWjovwugXpQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=GuSMWdfO; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="GuSMWdfO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqurujuzxvZeShD8aBBzx5a1Y0z7YmhE/4/dDESQUfGwKyiGvmrHPJoG2nG5ToUtm3hjxqpVj5jVn3ly7/Ls2BeVnxOaIhPZLwQu8QVDtPwF4ibRG2DdqazrI/js9rGSkd25GOLmjWcgXfNYiLbAcHIun/c2lJPbXFsTa454P7eLLKD93/nkIG4zH8xyxUSx0q3jUlofxdhnu9OSJmC7yc9fobkp8ULCxA8t78FSe72DzeYiFAopWWkTxp6HEsSDqc8J6MzUStyXF6qXXVIu+ZFobIB7H1Qe/VPoQLdJy0X1JTIpGPELJhF1OVcqtRL2q2sVV5Q28WqeIzpU3rNzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPs7FNXZXcRGcec6KdgkSb4MY0IOBFVLYSRl4Qrr4vg=;
 b=GP19UZ9S85Pdq3Lay1VwOswAfsDPzJS5qWUxR/gpqGOYJU4/wMgT5iS8bV43CGsDHgBaPgj7/zydU777TkVTGsJTEOy7XfU3mIZSZ2/dg+E70OFDdkVlMnK+eiT0G4Z5E8Vx/3WAR2VWK0WS1O2Fesqbflnal0cG1Iu/EeBEbLo/od+KCUPnoc0RPUyzPYVkZ5qvdVvw/u6AHtxle+yRCAtFQVepWBlh4j2vAN93PmQ+fO56CW9duopcQNDrLLFadTc2GRKvFIfzakfGvhIiZXvC8VuJrs9zHGvQ96OaCdEPmV0ZCpv0RCCdOv6flHAqw4ZTh2Cyld8MLM8SE59HuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPs7FNXZXcRGcec6KdgkSb4MY0IOBFVLYSRl4Qrr4vg=;
 b=GuSMWdfOegAtE4Qv/7YSt6rYk3ne+hPdTl5kG4NguA0lN19aJWMxKt2zgjG0PzzzLxGCv0a6Uij0oMF0H3R/DH9gHMDi3O59lxe7w2M+i3UPsYI03AQKovM1DdUOEaeVnADwR6JO3CZGp5DXAGawMcscoLwYlc6nFRz8v3LavlE=
Received: from AM6PR08CA0003.eurprd08.prod.outlook.com (2603:10a6:20b:b2::15)
 by DB9PR03MB7657.eurprd03.prod.outlook.com (2603:10a6:10:2bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 12:43:58 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:b2:cafe::bb) by AM6PR08CA0003.outlook.office365.com
 (2603:10a6:20b:b2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.26 via Frontend Transport; Mon,
 5 May 2025 12:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 12:43:56 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 5 May
 2025 14:43:56 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ] mesh: acceptor: fix endianess issues
Date: Mon, 5 May 2025 14:43:43 +0200
Message-ID: <20250505124346.6621-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A796:EE_|DB9PR03MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d98f650-69a3-4ac4-5ac7-08dd8bd28066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0VTdeYnZHYtU7SQqwaD8nay+BQcmXwNNs7nwXdckit8MZ2VvSLbL1uiSqlT7?=
 =?us-ascii?Q?GwBDOq//59HC3POf4uef+9dgJz19R+18eBKu0hPQ+5uBdxu66faFvFUImAkr?=
 =?us-ascii?Q?xcd7TvWl9nEbdYtMiFNLpJEMlH5jKvr38PCYtZxOlFGJRwd+3nofQB++vxf1?=
 =?us-ascii?Q?BEIU5X/NV3Y0+rkL6bPxod54FRo2BW3gZpvZSUU2zQkf0GR/PTrJoeiJO2qm?=
 =?us-ascii?Q?yngI2eHqWH+e9kbgvIwtnEdHFSMyJXz+kXcNv/vv06zbxz/fy7J+5rI17iDt?=
 =?us-ascii?Q?+tblnoANptkLHzgYvDAirVb3pBEJfqmaB7PFOZ06vQxXCG9D66FVEqk/SCWe?=
 =?us-ascii?Q?OMSCQ3++Gyxe6IeMbzgqdwdmWioy4q0a0B4gPtaw8zRV7LGIQ92tFJOjuhfM?=
 =?us-ascii?Q?9aTnE7WoQJecnYh5FlCxJyERsnn82b9SnUcJwy8ouuVfUXx2Sk+mgUJV2CDj?=
 =?us-ascii?Q?z6N/WM+5TGYnMo13ALheC9/tfHhZDDC4TAODpRkVa2xHdeFxLxQBvFMLIc9o?=
 =?us-ascii?Q?iXqmiY4gf0tvRxtO7w/8kd+rF3DRc3z4p51+RyntEiBGBaeoT7jdKUD6focO?=
 =?us-ascii?Q?VF9OW+wAvAjiDbq66uGHONKguvnFsNkxPgzCU7/KxjuempmLfBr7e6wvvigK?=
 =?us-ascii?Q?K5rrpstZqV7d9+c/y1CPeUwgh1gdfCDUb5KrV0MuMrbbZLENgs2G29PgZOaq?=
 =?us-ascii?Q?EyM2LxccKwMAbFtH0N6BGk1dGMb7X3Aufh6Y3TR91FqpRKOQ19oYSw11KCqN?=
 =?us-ascii?Q?Ssbs8lkAMnlePhkihV9grkaBOGTIJNzGi0uN0Pwa0/3uf7xzfr32dt1JzeF7?=
 =?us-ascii?Q?sJdUqiLlKqybTwIPiMFE726Wp1rjJoj0xsVWPwd3m4J+ZscBTL4jqTAVyDVz?=
 =?us-ascii?Q?FtTtRAPiLv+jTonncNAMsU1yemcQ6Uur96/sMEgW13/7wXEiMZEWhbdBt9Uu?=
 =?us-ascii?Q?YuOL5ZoHvyNfcisl8/NzZrDKG9a3HsHqb7AvSRVgrot6BNNxGPvVtxhv5GKX?=
 =?us-ascii?Q?DCdStA7w1dWQIqrMAXofxB6L/maztN08cjDlUU6IRtb9bEQ6nuAN7ob/5luW?=
 =?us-ascii?Q?9d4HHc9ZkpaPSadibpd+DNB6JcVkhxfmdAIoWKBvMcHAyBN+3qKfp1O7SGfV?=
 =?us-ascii?Q?bXsFjE2CLnlkTeeojJAiwRtFnyY5b7AMYT8rELwr0SAWFrrLcZB5EhfbzmpB?=
 =?us-ascii?Q?7+uxTagXRA1Msl7urPe7wdhtsJ+2YEivpndwOh42YrpQupykyIRUKBcFx2jG?=
 =?us-ascii?Q?Xc+b7Nv3TJLc4+8+qozwXaNQIIrM8S8SkGQ7C1sCWJpU7gvGnXJWO9bvzbvC?=
 =?us-ascii?Q?3K6TaM4YGMlhgc5GalTJ0nha6167V0J8v3sUanVZOznwAZ0ph6obHmY7+ogf?=
 =?us-ascii?Q?XgkAhY6PG6L/gpsKxH8va4/rhSByehADN/MsB8D0ab7MYxCUnuua92YNtm/Y?=
 =?us-ascii?Q?4Y6kxkVRH0DRMQMYVItWSC3bECqsMJS/oZGBcr0NawilS9LeyQNlg+9RhHr1?=
 =?us-ascii?Q?fBLpRUa8GL2hpA5vnJFNHvUWM6UFwXTaLBKM?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 12:43:56.9650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d98f650-69a3-4ac4-5ac7-08dd8bd28066
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7657

Members of 'struct mesh_net_prov_caps' are in Over-the-Air order and
must be converted to host order first.

Fixes: 838ddc931263 ("mesh: provisionee: Check prov start parameters")
---
 mesh/prov-acceptor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 241345bdd1ea..0ea9bb84cf36 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -408,14 +408,14 @@ static bool prov_start_check(struct prov_start *start,
 		break;
 
 	case 2: /* Output OOB */
-		if (!(caps->output_action & (1 << start->auth_action)) ||
+		if (!(L_BE16_TO_CPU(caps->output_action) & (1 << start->auth_action)) ||
 							start->auth_size == 0)
 			return false;
 
 		break;
 
 	case 3: /* Input OOB */
-		if (!(caps->input_action & (1 << start->auth_action)) ||
+		if (!(L_BE16_TO_CPU(caps->input_action) & (1 << start->auth_action)) ||
 							start->auth_size == 0)
 			return false;
 
-- 
2.44.1

