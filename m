Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37DD271A7C
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379489; cv=fail; b=fbYqNj6GWv3KB9fEhj+MQTqMQYeCT4fd3MT848x2ApSvXhcs5GmyRofLEA/bJjlpkjOCb/INk5cI342HVmYINn69/GSxT3I2EaCoUMgcuhsOOyzOy7g1wzAN02gDEg52t1/9mHJuvpS5lVpS6mBo//xmaUhBa3SivMA4hUKw3tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379489; c=relaxed/simple;
	bh=NkP2VaWzYX0EOoUY4jrL0GnCzxA7fW2OaKfN28aJeNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ar8ZlaifRxbNn26Z7HmAee1TRfB+fClA3Jw/Zoc8gS2rYoPOO8V6exSJak/pILInkC/pLpE+FziQl5dEixPPDrZWx1OlKlpIgxAvMhexodVUKksyEouIwQkviP9l4hX1sYRKAP2fZaGucOekwNRDzzLfDFzaigxQS7poOxvuGvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=MelODGBv; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="MelODGBv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaMRx3/es5W9ReY/4QS2fUR/yT0Urs0PdCMZT+3SSYZ9+r6s4+DKRlS/uscAjrss3ITJunyZ3GhChD9muS6hbxvmJZ5vunIW4x/zUzsyA1/NFB3wwhaZeWkNA2IdHPi/f51SK4fhF0fbGiey6PRJnE6GHLfdloZhpJoJQyjleQFawCisY/i4IwuKjAzjMIGtQUAB3lvt6Bu9Bkzg1YvNLNbqlcgw8fxnxPthZSdQJJI7c6lPXkEESRgR+E9/Z0PzsB8/yFwoTWdEBmKYY0jVRDVurjUmnsgGTLEAU/FySzt3eafEHTDeTFuvyp86/YL2heKPAgsI/d5mx1mwnM0cdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MT8nKKqLhx4bTsnXiAGLL5jXe4lKzFoC67R4oxJSfzg=;
 b=PjHzEmtAZSikjoQFicLXoiT0W0E/kKGbfyk5Yo2lj7C1/BdQ0Y1olQVihGG+cwhtJltVYDXvYjQD3AjvvdAnRomcjFa1yTCV91OS5KMAfaKiKajx3BCZiZnsrY/UESwvmADHxPGVaYecc7nQHP5syKBa5h1DAnnkXeFu+NSY2w4Wd1Ma3ZnM04MKplMBGXfvMI4qWPCkholjkERE3wWRhhEKP5cKXOGvbSpwSNh4QnEPIP0rTtHoQMHaGEQ6GEa7P8NzIHG37jF2h1R4+AUBDCYjFU6VtQbaBo8mkUjsezu9aiQCC2DCmAQ7e/Ogqy0nX9VrVB+3fsD6SRoAG2pVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT8nKKqLhx4bTsnXiAGLL5jXe4lKzFoC67R4oxJSfzg=;
 b=MelODGBvkyq9wsFAALg/JJkNeYKMb5gggmED9QmnOdL0xgtAn7Ab5Ix0UnRt5IC7XSmGvR9ue7E3jSTzwy4lBDF+Ra0wpj94QkDSZ7aQW4/0GjJQVGViNMtOBDFA74luCBNi51Y9Xgk2XQr7Sfk39sIxA34Yz/zfvC51l+I7XoM=
Received: from DU6P191CA0024.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::14)
 by AS2PR03MB9049.eurprd03.prod.outlook.com (2603:10a6:20b:5f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 1 Jul
 2025 14:17:59 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::49) by DU6P191CA0024.outlook.office365.com
 (2603:10a6:10:540::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 14:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 14:17:58 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 1 Jul
 2025 16:17:58 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 2/2] mesh: node: remove dead function declaration
Date: Tue, 1 Jul 2025 16:17:39 +0200
Message-ID: <20250701141739.19128-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701141739.19128-1-ceggers@arri.de>
References: <20250701141739.19128-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FC:EE_|AS2PR03MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5687cc-a90b-4065-1668-08ddb8aa14a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pa4YtQAB2D3Ws4iFB9lMwxW+c5md8T0k/hDdmecWlHaYi5XQCLi6RLyA7Haq?=
 =?us-ascii?Q?0KbR+z5W7SQVF0kAQebs5GK+wRNGqTIrkf+/JxVEsicxwYajttTr/7L7ZNDF?=
 =?us-ascii?Q?QUoc6Cb+5LcXhEOOhEGBAjjo+fFjImiM7zkVIxhyRtuP1D8Mrqbt8h7M8ClR?=
 =?us-ascii?Q?s7bkN62bz13osVawxCCuYbo7sWkarlRIJK75Ht5cWU2AXxVk+1GM4YfOvhHq?=
 =?us-ascii?Q?Bhe9TPjd8SrSKHIw4Rvyu+SAUlT5u3yv/EVR7PUVHIeqQTSsTHEIHl936SNT?=
 =?us-ascii?Q?M4iijdIDaycZ+RMLFA6jB0shCYoQ2SyWGAN1P3K1cJNH2G9jBL/3fAbOeZre?=
 =?us-ascii?Q?x2bNvRjegMi4LUDvk3tJszEoWRy7CcWs7tS+XJ8Kc6retRun3iqPdae0oy5o?=
 =?us-ascii?Q?aLQbrspzLzHW5sBP0pB/2HwCz2kedk8htMZAqlEdjQHYvV4fTkNkxogt5Brx?=
 =?us-ascii?Q?LGXSzWKSAyTmSRvAPm3IIk3X904/RTF+4sB67rXlosVYOYFJX8GtQwI5EFPf?=
 =?us-ascii?Q?vRshRLc5am4CXOeSXlX3xDMvK6X5hH7Hr1d8s2rnM9RfzVz05nSoiJD3eVdQ?=
 =?us-ascii?Q?CLSLLA2SRQP5DNzDBmVeT1enJUlSpuLSPPMmo4klrKSi6T/hed5IfHDZ/f3f?=
 =?us-ascii?Q?t7zVcpx/sDea4MCM2emT7+M9bueZYOwoenK8db+F+OjXGqZixIHe1VqdSkOw?=
 =?us-ascii?Q?rJyMLslZ0Md350/OsoQcfxfhlPvPUrAUkxwJKqstKrz7HpReU0Qmj6p0HgXe?=
 =?us-ascii?Q?WAJOdDVA7jt1CKtzKd8Jt5oqMxHQEW/USpeFJpmMeExbudSqL+OvM0Dy7R0C?=
 =?us-ascii?Q?eLof4EBYmpU9xYgBV9LiK2cPITN9+eE2LrutG//UR3zk1zoxf61pJuDGkg6C?=
 =?us-ascii?Q?oyob1QeG9C4nk45+hUMtjkclPK95n0eOaFFJyDOAkwqTZ6zoODd0EirfvFHx?=
 =?us-ascii?Q?IG7H/hyVTW+lHyxYlBjG1W8FiBXZ3vM+XhdC8EyECF0WxFFeWgRKBi1eB52j?=
 =?us-ascii?Q?a7TtSBY0qJe0XtIhOJzKiFLhvZaa/ODKEI2ofiy7I4nG+ZshhE1wM2wG147M?=
 =?us-ascii?Q?jk4sjzVXeB7QQD2ar3sm7S3wTkNXcWGmMLZSTRmAM3jBYm8/RIXuE43Z+VOY?=
 =?us-ascii?Q?OEBcjOblaJTVjUN7hSGqdQDhrHXYcjPWwJou+TaU3/PxqGrfnkORivYYY63v?=
 =?us-ascii?Q?nlCe3mkmDbz9q2B1cAIeycEUBcEZStfh2rJtRvXEApFcbBQcvwcWPjn/mHfQ?=
 =?us-ascii?Q?dyCUc0h3oVCsS7opqzxK0MwYZGLYDHrwxgZCyCDFu4esKfBsEa+cJikSwV0w?=
 =?us-ascii?Q?J2oCXFFVqM/fcDf7+HNnrrwKe0iRQ3kM1Xm7DcBZiD+j5DWclO+sZp8TZsQ4?=
 =?us-ascii?Q?RqFPF0VLULrBaSDVToj2Dq62kxEUO/xPOfFX0m5nf/uzs5TvhG/50CK7sB+D?=
 =?us-ascii?Q?5uBVviClqMBwYfkNaU1vtvjdKdNM8jYDIR5WMrfvGv1KtJ/yP7Iy6dBb0brP?=
 =?us-ascii?Q?bHRxy6Ao62SImpRAX1miC7SCoSBp5h3q5uTN?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:17:58.6201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5687cc-a90b-4065-1668-08ddb8aa14a7
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9049

node_attach_io() has been removed in 7cdc215ff5a1 ("mesh: Add
finalization of a newly created node")
---
 mesh/node.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mesh/node.h b/mesh/node.h
index cba51cb93bbb..136173c8cee1 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -75,7 +75,6 @@ const char *node_get_app_path(struct mesh_node *node);
 bool node_add_pending_local(struct mesh_node *node,
 					const struct mesh_prov_node_info *info);
 void node_attach_io_all(struct mesh_io *io);
-void node_attach_io(struct mesh_node *node, struct mesh_io *io);
 void node_attach(const char *app_root, const char *sender, uint64_t token,
 					node_ready_func_t cb, void *user_data);
 void node_build_attach_reply(struct mesh_node *node,
-- 
2.43.0

