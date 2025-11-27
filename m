Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013001.outbound.protection.outlook.com [40.107.159.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87DB1F12F8
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247373; cv=fail; b=PZ4RoTtSBRrcU+5dKLlhQ2lO/7uoiiggYAZas+zevy9MIFIVbiNPd29tT06zig1ML1I39FsQrLE/gN2YJriwZuktO/Rjvft8n3jKpNcYEM/W89I3NkOai5ttMb8743pqLSDZ6P+bEtYXrOxfKeAqV9hHktvK7bIZeVVRF7YIjhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247373; c=relaxed/simple;
	bh=j+7N2OXfJ8Jn1qf5QlfW2kthDT6etovfwWiLmP2wO70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rnFU388qfHSGRyy4i2AwULhIll9hqM3iYFqGTH6Uxy1KKnaAvkn0wn+MFUm/LxyU/+B2ELRcAfJVg7hUr6YXsD09UIw1DQBiybR93xqkSNGA6lHFKpSk4Ftyvx5nmB1pLne9w8nGLPzR6llmw1LIktshJDrF2+kMZ0Qt2uSde2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis365.onmicrosoft.com header.i=@axis365.onmicrosoft.com header.b=El6eGJUt; arc=fail smtp.client-ip=40.107.159.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis365.onmicrosoft.com header.i=@axis365.onmicrosoft.com header.b="El6eGJUt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQRjG5TjZ4h3SSa+bnhU/FkJ/LiFbv9wwPT5nitDEAsnaMXBjdSq66CzfY5dzJsyVcxYR+a1aI87vApTQG3hJOzZuJhPJRdZ9SeI5r6qn+oRFFtTsVDN6FatjdO9WLNNtofW5J0AEyFiFx7K5+vY4SNyNWCS/G1riyyNcn+XeFkpsdjg2yLNwFdZ7Q1/X8MGNxodjz9aLd93Dbs8Dk4cNzluQiTSixab6kHFqWLzBcLnhQ9+TVR0NHFh24c8hNKmaJjcA+VKM6R4knzDiJ6/B2HXJ9GpbEflvkl91KhGpa8kkeeccl2KqzxZmfCJupg6JG3xbfZSeAwS8/ruBzYdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDEHH1M6dEDrY/JwK9rsiUIkpPfkdCa3GkyWANW9DuA=;
 b=V9Ho3Kg/UPZZxQhH9rdLiCA2nPvJAtmq2iZq9xF8Nbm7s+8aJ7H5rxncdREs8jAeB9GFskfd0Q/vW9Ep4TAQdmDl0nsWH6kWwiFB5q1feaDbSUBqtHPZbbOEhqK0DbtUAIoiCY2066m3t1IXIOCyUwfdTiiFAKvMiVzU8acUowYUOoStgYM9G6oHXkr3WMC01kZiJnVdDtl7mo5gk9K5rE5VQomsY7SQSrM2dqIOuAkN7UyXfpEZoiUgWkg0taeDsxHb9XYMotaMOoXBrbsho8DjpDPbB0mpgfOgeJDIP9MCJfPrHPW+dZKo3DcGJSeUFXMmvwVOepy41TdvrT1tMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=fail
 (p=none sp=quarantine pct=100) action=none header.from=gmail.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDEHH1M6dEDrY/JwK9rsiUIkpPfkdCa3GkyWANW9DuA=;
 b=El6eGJUtKcCftUTnPEyg1A3+me9oJPM/4Elk+HDv/utSZbscMc9QVOCR1rIeoKM84tRlcarUVLAWtHmMS68eDCDs7N7X9Z+za7P1wmI8urdHpPOHO5Oe+L3PbKKH8lTTctjhoU2Aci+07XjsdC/4DzhGbF+ogqXzaIhxfmaox24=
Received: from DU2P250CA0016.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::21)
 by DU0PR02MB9268.eurprd02.prod.outlook.com (2603:10a6:10:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 12:42:46 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::1b) by DU2P250CA0016.outlook.office365.com
 (2603:10a6:10:231::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.15 via Frontend Transport; Thu,
 27 Nov 2025 12:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 12:42:46 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Thu, 27 Nov
 2025 13:42:46 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 27 Nov
 2025 13:42:45 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Thu, 27 Nov 2025 13:42:45 +0100
Received: from pc51392-2240.se.axis.com (pc51392-2240.se.axis.com [10.85.128.86])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id C872496C;
	Thu, 27 Nov 2025 13:42:45 +0100 (CET)
Received: by pc51392-2240.se.axis.com (Postfix, from userid 0)
	id C4FF7422A8CB; Thu, 27 Nov 2025 13:42:45 +0100 (CET)
From: Sebastian Forslund <sebastian.david.forslund@gmail.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Sebastian Forslund <sebastian.david.forslund@gmail.com>
Subject: [PATCH] main: Validate the AdvMon scan parameters correctly
Date: Thu, 27 Nov 2025 13:42:44 +0100
Message-ID: <20251127124244.410438-1-sebastian.david.forslund@gmail.com>
X-Mailer: git-send-email 2.39.5
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8E:EE_|DU0PR02MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f747da-019f-4815-3acd-08de2db27766
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7093399015|82310400026|48200799018|36860700013|376014|61400799027|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CTbO1PavJAkKcG6LvGiePHWMsnxrFHq9u8nN+AoJmKNrsQNd5Z0+TEbgCMii?=
 =?us-ascii?Q?Yil86wCHzn2kdCigAmBt7Gr9Jwqrg+SMHKexunWZxpepsbYh2l7a76NMoDMb?=
 =?us-ascii?Q?HbVt89YHsCePqDFRnkAq9drO9ErUfpFHrxBrY4Q3h/E8ITtoj4npZ0FwEk5C?=
 =?us-ascii?Q?5WKGV54WjP1CYP9WOzcT78NfBhaq8P+43GiN08GOHcrIssH5qq31WC6xZrQ6?=
 =?us-ascii?Q?TyEAmjpTXbVX/YUKuABOCHOBP5HjZP2Kie8t0su/pnxMunFK8EXGwtdzMA4k?=
 =?us-ascii?Q?z5QK3i7sn8up1vwi2yZ9NGhA/50CpGQZw82jLKSlHOXYPWR4ClptL3x+OtEj?=
 =?us-ascii?Q?W23KdkpuS4BrJXrf7w8cXw2QPLqvVBiItD13DBLX/n46tQZKNz9g6YYHWthy?=
 =?us-ascii?Q?M2Z9vXhBkzcq+nQU3a3CAqPCfC56eT+kuTklF77p//f/R/rdEkIsOPmniRid?=
 =?us-ascii?Q?LWSWMQWZev9zl8qfBHoictdfMSDfMHgcSyeSJvGISoKk5vqgPd3l3yVUxpAq?=
 =?us-ascii?Q?gjohMEEaXfB1CqHZkAlzi3K6PQIXC2HSb75miZF5FlK1hN9Ft6pGJdPZGEUz?=
 =?us-ascii?Q?DAC/pE/N8ySEJfm4AJlr6bHpGjS7l8QCp1gPZZ/YplbWv+A2gwu05I5SLr+5?=
 =?us-ascii?Q?aaEJ+33CoucR5apcCUeXrhbBFtf/26QK66B0MZB4Xz5+Z5PNfwD4zWACTPNJ?=
 =?us-ascii?Q?PCMiqCkWDxT5EWv6EV5Nu5U4luRrg0sLSCywaMm23UnbRdM9ayo4q/aZWwt9?=
 =?us-ascii?Q?5Vo7aLM1pQXntmh13/yd6q3amrjC+6Cr0iNupoe9y4KD3MVrkD+YO0zxaUef?=
 =?us-ascii?Q?fz+Zx/s2aI9zVs0/fIAAsY/UxmYUk2oFlJEquKm/p9rGZr29RaiPAz+Y3UeQ?=
 =?us-ascii?Q?nHppfSUak6bo6O+vFlvxF7CKtPvcstb6Al7LdqVma8ZgFrKTkfuCBs3GRViJ?=
 =?us-ascii?Q?Ac0AkjoCn39xzZTSul3YBylWSjFBYqgqssh6GROeYMs1jCwYDjgsIhz0GLXu?=
 =?us-ascii?Q?/c0MTAffzRpmYCFmYn4zk7C9Kwk1i6Rx92Gn0WHFj/Hf/tZ0XwdI0aJITIIH?=
 =?us-ascii?Q?dxkHMtI7gh+Nt74p3Wqakuc0xpmp5APzmn+kD+oXQKQN1h5norqX8hP12X4I?=
 =?us-ascii?Q?dJ8pZPgOrz1xsXomt9Yc6j5NBJwuDEGztj5pUixos0TSKjjLsVWARMoFSBgb?=
 =?us-ascii?Q?OqZSDvDhoJWKluxaMC5jRnRNaI2SqJ4epR+MZsU/bVGsioLWKK9Y7liAr2yd?=
 =?us-ascii?Q?zEWg2Lwywvkl3TBne0KXDG2cmaxfn/61lX7x6efyCrrKsrOCxwS3H07nNjD1?=
 =?us-ascii?Q?MgwQs1cMbTHnPf9UfT0Mb3jYGSZJaEuHtYmgSZMJlS+l4PFjugAbzqp0IUw0?=
 =?us-ascii?Q?NSUJKQrW4VGv9Mfabpu3Y0AMZkwtRp+ySuAiisqCKkr/N5R+WQVwqA8MhLNC?=
 =?us-ascii?Q?gy2jYxIoybHBIeXcvLHFJpmR6lDn/eo9sbAxCsjTg/UJdYqFPrTH16xaMa8f?=
 =?us-ascii?Q?d75eWMtxHNz01Q7qGlLwAfm+UCvFY3M9w3jBxciRlVzk9woWSgGW8Uva+VP9?=
 =?us-ascii?Q?+DAvu5t+Cci9xqshDYQQrUzPLUM9HJqDyii8JHX1?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7093399015)(82310400026)(48200799018)(36860700013)(376014)(61400799027)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:42:46.3301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f747da-019f-4815-3acd-08de2db27766
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9268

The strings used for validating the main.conf parameters are different
from the ones used to fetch the values. Change the validation strings to
match the code and comment in main.conf.
---
 src/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index 1c7390e63..558bf2888 100644
--- a/src/main.c
+++ b/src/main.c
@@ -120,8 +120,8 @@ static const char *le_options[] = {
 	"ScanWindowSuspend",
 	"ScanIntervalDiscovery",
 	"ScanWindowDiscovery",
-	"ScanIntervalAdvMonitoring",
-	"ScanWindowAdvMonitoring",
+	"ScanIntervalAdvMonitor",
+	"ScanWindowAdvMonitor",
 	"ScanIntervalConnect",
 	"ScanWindowConnect",
 	"MinConnectionInterval",
-- 
2.39.5

