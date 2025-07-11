Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6357522A
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255769; cv=fail; b=bXE0yJb/9YXM6UPyBYdpA7FgHRC+XiVi1m8CHGc221z7E3/rvoYNiifgDEhTJ5K7CQkFkpP1Pc4L0JVmwuKwtihDg2S7tn/wJB+fJk4Uk6zH6HQe8dQeyWxHYCr657b7xKVztncprLZS9kkz7M+1dD6eu0Z/O7bbXaDH30U76LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255769; c=relaxed/simple;
	bh=8As/1xdGrwWjD3FV4KZrZ++VepW1P44sn1VP13dPJNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hch2QA27epHBDqB9u5dnZO3fzf9p4SDiVQGitPPbu7PuCHhGYkPPQroTcBaXBpJgxEjsJjvNEoAryLXNtM/kCS0KdyIUvg5xWy9Kdytkaf+hni/0Iw+kWLZE0JRwWFSZTOAc7Q31wE/pKLgEixM81HNp4Ig12Djm0q+ez/pnGKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=jsZ45J/K; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="jsZ45J/K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2GekPWHdi8IfzC55J3MPB4t8ZNgFBtdfymCB0QknZ6Mdl5klR6p0tx8EdTUlxXzgzQZlW9wCaGBHBzrxLt+x3FRUNMhVmxnJbliaxt2xHfJF5oh8Rfz7vHhHmxjKxVPYwAjTj7mml4jEueGpj1rT8UVviRPtQ8pW6JVmv4lRPGFuGfXrWgzs8mO4kV9SliO4DsIUonc0crmIgaXXPYzmhuQgoABXC77mN4UvMmawf4bw6+YEwyVhD44chpbokDBP/NADOMCFdMBFkf3jm6J1sLd+3X/TL5nGo0Ch2vJUlpeykRZTTGh6Giuq8LfmY6sKQzZhU8SvPfyMvcMSvt9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tDTxMuqkRe1LT2aFDhBInTNUMj6ttQA5fslL86AIBQ=;
 b=ZGlMZsRqnxPj1UlOCdyHCkMJZMJ2+RIWiSnCFQ/7SpHAOnz4Bxkw4llCCKgfGRlI+SKetV7QDsWRyhjbqnK+S4mceGRCJaJCCMk2DHbsDu35MOIvcwtzn8SpcUEpVu+SEqmdI4JEY4In7k8+sedQIGJczo6nPs6EkslKBuWmyij6uTQ4y5jgqOcjNO6YbOb3GJGcJbuBiGnT5ujYSzE5itpJyFmH4IC8ky5Skrl8wZSPtYDxULFHu+Y2J+dOEsCXIXwaxPYpO1NIkoLjRffDIC/sJitdIF9OI7Q5voj4YSTCYLnxugDcp4zyDCQjaQgBrGcba0ah3QzXjM2UmTFiOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tDTxMuqkRe1LT2aFDhBInTNUMj6ttQA5fslL86AIBQ=;
 b=jsZ45J/KrDmYrXm2wYUDouAsgIA4KWBH3FM3z9PniBt1S4MJ3Ow0jG/C5Al0NFO2tei6lM5iUjuvfymgSBmQutSTSeEzRtqcUQIdLK29yMKAGCAgk3EbQr1K51iCN4lOvCW0Pzb+ZrwmVysRQchVHkq2Tgdido7eK/hHygOgzeQ=
Received: from DBBPR09CA0008.eurprd09.prod.outlook.com (2603:10a6:10:c0::20)
 by DBAPR03MB6581.eurprd03.prod.outlook.com (2603:10a6:10:19c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 17:42:44 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:c0:cafe::d3) by DBBPR09CA0008.outlook.office365.com
 (2603:10a6:10:c0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 17:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 17:42:43 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 19:42:43 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 6/9] mesh: net: update comment
Date: Fri, 11 Jul 2025 19:39:22 +0200
Message-ID: <20250711173958.25689-7-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|DBAPR03MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: fea5b3a8-e4e0-4be9-29bd-08ddc0a2573e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UYaj8HMInNtEmWvdchLNYDC9W74tapqwi74UyJdP5AYY2I22y9POl7UELm9o?=
 =?us-ascii?Q?RppC7z9W0FdC576MWdZwS9JaYCSRtuv+P1wI/0PA8Uah8qoMyM13+FGViU/L?=
 =?us-ascii?Q?y6CS1eFjBrcYjX+48erN54JPskPMWN2GAXqL2TxSFBEqFaPmQnhBOqd1N1Jr?=
 =?us-ascii?Q?rvNRCjjtqdgLjEpi/CIUvBRahmD53vfOMTy5cz1mncJutdlJKTMjvQQepCTA?=
 =?us-ascii?Q?Q9F2zQaCBSOPtAfRV8fPv0hfLzHKBgVaxtBOn2fnNtl6xnE9Dj/VYmoKn2oL?=
 =?us-ascii?Q?rj+ypcJXhV4niP1jSvBs1TlliydSN1peRgtKnZw3WvZLBvIEz1byTnvA5hnb?=
 =?us-ascii?Q?kANbiAWhsWWq3LV+oEs3ZroCDRgdfhpxaqtkYSSJzBwE3tD5mYLK5AViD7P3?=
 =?us-ascii?Q?sck4VCtIPR/tUGGAR47rC9xIOgLcuZ2hnJjOlm4mem7X76exadbDuHhTOx2s?=
 =?us-ascii?Q?/nFsP7TXtrcBbUAEOybB8vGCSPyALpdIPBw2uoLYMZF9ZGVal06B3JLvwAc2?=
 =?us-ascii?Q?ygUyImkmnv65n9H3jUQTRHIzdFagsvTEDGLPPKpjAxiWmrErLaX9n1R4P6pz?=
 =?us-ascii?Q?5DxAt/URoPJWN/EiDvSZ1EKC/WDHGsb3ufF17ALWgRHnPTdG+0YagytgMU64?=
 =?us-ascii?Q?/RGH2c2OzOOxD7nssmDNr9B2EJKQ6WRbO7MIdkC2X9ShTkcc5LlWYFZjxz+i?=
 =?us-ascii?Q?HI27IRt77ewd8ZusgYdUuscClLEudmD3iEphXNkUyb1Ki/JwkUIkbBhvVCYa?=
 =?us-ascii?Q?vmAHuTJnvwMNEKiw+VU0isTpq41bk+06WXhEAFLsjwTSoRryNZhRVn1kpxlv?=
 =?us-ascii?Q?QZN6PTLf0wwv33pIRqN95M9+8XJ0kAp/2zkR6c7IS/D3MskQYwz0VxNQhL8E?=
 =?us-ascii?Q?4xtupHtDjqi1EgAfcmJ21JGi0WESDaVEjoJnlt+P/J0bML3WcZvcYlNeYL9L?=
 =?us-ascii?Q?ULTtLcdpOE+pjiqafESFafBhyDGKRFjHtXMficO9xb4Y0X2/VrI7DMs1/Vun?=
 =?us-ascii?Q?L9KPXMVnGQFSzHAyHoDbm1ksB10sWLo6dGQe9P12wITnR86H/2/zMqDiihit?=
 =?us-ascii?Q?/6ucl1lMUdI167pLeUbPT/sX7OA0YYMgHxPJw541fCSqT1ct9FXe6hIi+mRH?=
 =?us-ascii?Q?fPsi8XmkUHot1FCoNQwHf/DCoxHelk830cy6GIDHxcFFaZB1in0etVmnr12L?=
 =?us-ascii?Q?arzQWn2qWarNR2CLdDbVGpKJc8O4VDNtMs4n3sl6ocvmhZCjqmnmsHq1AcZ5?=
 =?us-ascii?Q?8Nus6Gtv+n1hwZTCEiwCpAUrt7qzSLiSudNDTKKcPEy37p1GLYOkJn4Y7wuK?=
 =?us-ascii?Q?M1pGaBAyHuvLL4Y/VO0NPF9ipbdZOddtZS8ILzJzWJPj0foX8pS8RbLQLBcn?=
 =?us-ascii?Q?3bod1vrDMfAjjp0aN//y6aWaipd83EUCCxYvwkOdZq0A/iCU/MvAP+hl6i+t?=
 =?us-ascii?Q?dOEAruFVRS7znRSfM1jh38bKgw6oK0F2iT7Of4jZH7+3SytzKWj3G9JQiyrz?=
 =?us-ascii?Q?RGQd6ZDfT+ePsbuwnBBLG6jBAsNUOV0M5Bdj?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:42:43.6675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fea5b3a8-e4e0-4be9-29bd-08ddc0a2573e
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6581

term 'master credentials' has been replaced by 'flooding credentials' in
commit 09f87c80f1d5 ("mesh: Inclusive language changes")
---
 mesh/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/net.c b/mesh/net.c
index 3a93f6624e8c..b29e24f5d4a9 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2487,7 +2487,7 @@ static void net_rx(void *net_ptr, void *user_data)
 	if (relay_advice > data->relay_advice) {
 		/*
 		 * If packet was encrypted with friendship credentials,
-		 * relay it using master credentials
+		 * relay it using flooding credentials
 		 */
 		if (frnd && !mesh_net_get_key(net, false, net_idx, &net_key_id))
 			return;
-- 
2.43.0

