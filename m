Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013005.outbound.protection.outlook.com [40.107.159.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620014AA9
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979690; cv=fail; b=A5neQ+zQp9RyBLBk7X2B7UYG3a2d+Hu4/oMorZMuUhJCN4oKceDaZMlbNrsujE05/gwNqn45F+DbUNCGMYX/TU3KpAL38+XL/fm2TYjSGsPebux7zuTzlMZeMtIOMUPJjs4OMt2xDVEhMpSd7Kj7m3p5V8S7Ir8joHWh4WfZJ6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979690; c=relaxed/simple;
	bh=oUQ7EGd0JcFjoWio2dz5cnkYLHOkeX3oP0U+kUtFH5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXhj7p1/qYf+Eg/ClyTjCZmLFePy65ivwk3gAdtkEHwVAYeqOLNYdS/JSJy3m+JsTDQso21Vo74IFza/saaip8IdWBneHkSO9sQStubxkLumn97CYjr86NvufLvNvCClOKGkbinBy5o2bibCQFjlmgyggSZpeX6u73wYaOLylBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=cthThfBT; arc=fail smtp.client-ip=40.107.159.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="cthThfBT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVJQrjhIERHdCAQt+dXWdyxYxVa1fOsjd51GOU15pDP/UB8GMMsDDXYSWCN+K1TT8og2jSGPmMlbIKmxyD5l5Ww473en4GLtYEDE6mES/ilPx3HoLBaXO83krP+9GuN9I6OlZEG+1qJl0CVVbq1uOpan6b5Q1o+eHxZiRyA9ZvikrNhLbKdrB63ANGRUNccc+slZgDmPvCAHUEnk8mP2rBuVhHuyynwxYGlbPQz3S5p44xCjLRIH7yTdR87KIeUNyHNvUSXveNeiqVHNb5mLlSKcT081ggLyVCblWc+US8RgcIaR9LMjrkMHXw9FluMkGMpoYdUZklRgCuV8RvVgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHJ2tznuQGXq/PLcxiqo3jnjW+6MzfCXAoaykKRsg0U=;
 b=cbghN9/MexH5kDh/u+M+a4ymP09erTFMj0CYGGvokLFMbkgFaXnsSICK6RX8e13VJzY3OJQzfxgwZDXdbglsCqz2fOkTSly9VhQUc/eFfxuMmJSZ+4gxKm/JRE7ckFSvymsEbFX1x17G4YNqnv6/qtPgt/YxPJnfpURBzvDoSq1PvWDmPRLGy+sduT1PWODwtenLuBxyCoZxStDGDeOOwJaZaPM6zJnFQQYjLeZs0BetqV5AZ2b7HLPggV4s/Bi0Ed2W+hYBd/HM7pVUEMQOzvKf8SyXAcRmN0Phg8reJ0rAuy0mJcI3Gk5Dt7c9KctYUP/2US4X8/Tlb6cLJNkc2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHJ2tznuQGXq/PLcxiqo3jnjW+6MzfCXAoaykKRsg0U=;
 b=cthThfBTWQ1zyTye+kn8sFbF+ZJk/jBluiyPx6XYi7Oxc9+4UlBJDUVXS3sv4d/tkkTT6Snolv+L0quVt5Cnj8vv22u9yHrM1COB13Ym2P39t7dsuw3jl/vicXyXZF3+4tSKm3ac23ThMgakouBc0YxiDBYljXQGrDSvaGwvR18=
Received: from AS4P190CA0013.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::15)
 by DU0PR03MB9225.eurprd03.prod.outlook.com (2603:10a6:10:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 13:01:21 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:20b:5de:cafe::6) by AS4P190CA0013.outlook.office365.com
 (2603:10a6:20b:5de::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Tue,
 8 Jul 2025 13:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:01:21 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 15:01:20 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 06/15] mesh: model: remove dead function prototype
Date: Tue, 8 Jul 2025 14:59:38 +0200
Message-ID: <20250708125947.11988-6-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A63:EE_|DU0PR03MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: be948c7a-a729-4840-ec82-08ddbe1f8953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ycOGELY5P8G5Yw2nj5RIhicqOmpI+pdV5Qbn/SAbvOdn3pLUpq8szB41uU2W?=
 =?us-ascii?Q?R9K70TkSJJm90ntpStMwe+W2I44/dSqiIFmzCwmEVN9WNj5EGX6P7/cdBQOr?=
 =?us-ascii?Q?VcUWs+KA2YNzkjnZpTaYpvWonzO7kPWXZe900RtZS6ZV+kVO/djVtD5gFP20?=
 =?us-ascii?Q?+ayz3z27Ll7nlfvFP25h6GRQR2cZzDTPzMhUno8EZgUh7Yw+a3SgmvmaD3sX?=
 =?us-ascii?Q?LfQEPEyjzF0KWRjjVXZEL4gjuTa5TgqNst1YS2b6k8h6SurppjIh+OMNv0rJ?=
 =?us-ascii?Q?dGx7Lo7WnhblriWeuGHVYciDXITIP2x5Yx8yPbIib7VJ3MVtyk0dpzy/gVy8?=
 =?us-ascii?Q?zryS1Lgugy9fSWF2jrXoWgx4LTFShzx8d0/ZMMv02IH4PpaYWqsU14n3eVDp?=
 =?us-ascii?Q?APgOeqYOUeAIGUw0oVg8NcSowj89PhkaUQGK2UNhZdQPk5VYvv23DhtbkngI?=
 =?us-ascii?Q?3Eg2DYD3vWyR7nEzsmez2ycMSUhvODDshvxqWaS6+tCX07K0WD3yICrsbuuH?=
 =?us-ascii?Q?o1qXN7N7bWk6OhRaw0JHwDe6vJvP2H1Xyj29pO84jBdqeEV6AfLYRy3sCEki?=
 =?us-ascii?Q?sOhzWnN3WjQTWrv6He4Io/n2f5c32C4Pc8q52UEXmzANnsJXULgrNX3HiDSy?=
 =?us-ascii?Q?MtE74GczZ7EPhzpTqNkw4TdDE7kePh5q+1QSiUkJhR+JtqX76yIh4S0LfbU3?=
 =?us-ascii?Q?BE4x4ciKSPWZ3V9bW/6smK+Aw9Yf1Ne5AoSGt0INo23Phmvgb/3XMrUXIdAn?=
 =?us-ascii?Q?HdTJT1fai/VQiBvQy1/J0YAQD3H1ybFalulZptiyiKn5jS5UBLdC/yEdJunM?=
 =?us-ascii?Q?z2aXnXcpPwEoTjT57VFuDbyGG+OYQ57hGDVZ+e1N0SwqGOIruOYXtLr0kWZB?=
 =?us-ascii?Q?YZkV7Y9pMs4JTvNazUmKUXLzc/C6sVNQcExktWM96DUtOZDrCpA2IECtZ+x6?=
 =?us-ascii?Q?znzn2Ja7v3tYKc1ANF79aCJ3nqkefud9QACB5o6rWZYE4YxO0Gmb3GUq+91f?=
 =?us-ascii?Q?Cw6+PEDznOm7EbWukCB5ofDJgu5Q5RBF3KroF//0oplm4cHeerdGE4z1c0LI?=
 =?us-ascii?Q?Mv12vRYx5HNpSmisZG+08g2ZRmagEwlyV/eZo6Ic6ngMwc/Ui1BWtiH1NYeS?=
 =?us-ascii?Q?bBf3vRYxcYR5OIuj//2seS745d2clqyufPN/LAEU9sNp2d+355CJdKQpyFZb?=
 =?us-ascii?Q?OEhS29/oGSGjkRI+soAYb3M/4JTnGAhgpAOYjz0joN6zw5lOhoM+wKuErYiJ?=
 =?us-ascii?Q?wo6esidYHmvB82H09aoq25mGugb0JvQe3gnJ3ocPOCNL2ZNDWx6OjX6Wkx33?=
 =?us-ascii?Q?VpySXhNdMxhL8CMUj9cWDd4QtavxaEO2rBgMCU42nAiXoMJ/JZqB3sDh0VTe?=
 =?us-ascii?Q?lT5cQBCU5Uo/z/AQFWylK09HRTLHEr19hviecbvaMbGUcPk6zOdJ8CVJ+fGd?=
 =?us-ascii?Q?MGUQMll+kdYhxivmSNDKPWDfyuQLVdQo8yfrpVrQAWsTf2Gc70t1Gggu3lP6?=
 =?us-ascii?Q?yhCJz07eNJMsQkCprCfPnULbL9+ULLzP/f9N?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:01:21.3312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be948c7a-a729-4840-ec82-08ddbe1f8953
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9225

mesh_model_cfg_blk() has been added in commit 6fbc4c83e134 ("mesh:
Header files for mesh access layer and utilities"), but an
implementation has never existed.
---
 mesh/model.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mesh/model.h b/mesh/model.h
index 8df4f205f2cc..6e36ee4c6332 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -101,7 +101,6 @@ int mesh_model_virt_sub_ovrt(struct mesh_node *node, uint16_t ele_addr,
 					uint16_t *addr);
 int mesh_model_sub_get(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
 			uint8_t *buf, uint16_t buf_size, uint16_t *size);
-uint16_t mesh_model_cfg_blk(uint8_t *pkt);
 bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 			uint16_t app_idx, uint16_t net_idx, uint8_t ttl,
 			bool segmented, uint16_t len, const void *data);
-- 
2.43.0

