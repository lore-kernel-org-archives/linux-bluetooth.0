Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F3253F0A
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380680; cv=fail; b=W5P6/XDRQfPtSgld/+6E2uTiJZjzs/tl7cOJvPgZUC5DPEFYwtxPH1M1QfUPQnVuFpfk1K/GDixI5Zjbja9tgr4oACCy9Uiofkh9Cir61BmOVXd7i0rZwuck3GEEH7Waxy8IkjxqIA6PtKMF6La5Mxp/aVhb53dL+qMXkYo0sxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380680; c=relaxed/simple;
	bh=3So44Es/hyYkUXxc/2pEJYsNbUHecRoSpIGpLL/h8OY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcogppWrqwROyoAe4hub+gdo3a7RDvAP09MX5U9mzDdxcx0pvqrmx9qI1Yng0nCjG9fYPm9PKzlmX1Ku9zPv+VldpDehaEiKMWNQnKgaMx82maHMP7rl42aDcu/v4FH6i0pqWgV4+hzo8dJ3xIYhAv4vnMjKCkPjoJRmUvfCOdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=UU9NghSr; arc=fail smtp.client-ip=40.107.159.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="UU9NghSr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTYpGjKZrtnLGB+LupJdG/xoSku9RVPPjeZLjQ4t757/wEEL+iZ/96Y4JCTIDyCKPBjC5vRrH91KRTxpIpd7+GhjTsNVLJp3R7kU6ksfYPCAgLKLlkLjaXUF66JKWqT/i6jWKVhX6BVLqGahU1HBYGmZPyEBikYSTAQYX+G9kXM72hxMwuSCP6HNlGS0N8515CKXN8BGAeORyTZuMkIPF8pXt+T4KCIG7TpseklElj/KpNIOONAaj8/uYntMQ7zEg3rD8LnkjBTll9mTEL+3GajJe9G6TTEtfc4vgK+ai2jdHWhmSu7ytKZ0IKKPHDuXfaoRE/2psUdlhH5V7V3kqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVkYIxM5z3Csw3gO60KpQP0vzv/EIwU68h1ezzmXBxo=;
 b=vC3zk+evhpWAddo15RUUrxkmgoCylnNIHhM3pr5bcCqaLS7RfErmxzQ+Fc/RTn5nXvlsvHMNuVkyXnHKJz6Y0XiytmSbBLMZapnZgRDOHseBASe8Yj6wODzIT07v224v2eC856MmicgeJ4lxSsKln4Kz6AJQpLUtJZ/fOXHRsmFPG5s5YTYcpwOihWzUIwX1OQACkbI1uZztjonzcNKKUBgcbqcz5TisXQ7E+rzEN5/OKGXDQLnYaerwmj7YSY44klSE1gKdAAmUSBZJylL5EZopNOTve3fXSN7KtbM2pVLmsULRn/oRP7uVg0hzhG9uCXwBB02I9h3hRMAv+MRNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVkYIxM5z3Csw3gO60KpQP0vzv/EIwU68h1ezzmXBxo=;
 b=UU9NghSrww/jFGUlURRfgne4azgPcPquzGfhxjAnI+0YSZE32fe8wnR3y/xuYUKj5QzaEonXsvAKglTM0HF0cu+HAeOtNqqSL24Bco10Isyo3qI91NhkT43z9wCBxaJTowvrR0l/JOhozcJC0B1U9vN0c6asFbatJwWttqLrUgY=
Received: from AM0PR01CA0142.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::47) by PAWPR03MB9132.eurprd03.prod.outlook.com
 (2603:10a6:102:340::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 10:37:49 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:208:168:cafe::7b) by AM0PR01CA0142.outlook.office365.com
 (2603:10a6:208:168::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 10:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 10:37:49 +0000
Received: from N9W6SW14.arri.de (10.30.5.20) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Wed, 19 Mar
 2025 11:37:49 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 3/5] tools/btpclient: include <time.h> before <ell/ell.h>
Date: Wed, 19 Mar 2025 11:37:22 +0100
Message-ID: <20250319103724.10433-3-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319103724.10433-1-ceggers@arri.de>
References: <20250319103724.10433-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|PAWPR03MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: b0638c80-e991-49c1-5dc9-08dd66d2186a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WTJJGuV5q+11NJT0hHAo7zyaEt/vHC3gbjzRXPOxF2IjjkDKgfSak68UhyrR?=
 =?us-ascii?Q?JkzDys8A+4/2y+sG1zorobdQUfrkSek+mVq0YrLdM3xCWDAdVvkGxCsaAXjk?=
 =?us-ascii?Q?9OMt0PC8Owesh9bNz5ZeVrIA/+Gft1dXyBIfmf2hgLWBwhpnY7R6jqd5miD0?=
 =?us-ascii?Q?3TSUQTthUjybktZ94DCFKqXzKCqvUldfVe8KmUXpLluQA+dPegjURX3qGHN5?=
 =?us-ascii?Q?fFLDcr5y3gvTKyDtVuotG3xfbMMr49Tm7z2SsPe7DRex0cTsCEtiikiVVjt8?=
 =?us-ascii?Q?KfpcA2uh+EdErLEYn3nkZ9vN0dU6c/B7Ho/uXJKOESeVGrXoNoCdaT6wJa0T?=
 =?us-ascii?Q?wPdAdQVrMegfvnqXZ9fxr2Hx0MdnQiZu1gSFL8BeYrn9VIjxYM8IkdskGyIJ?=
 =?us-ascii?Q?kLI6kRdGsyzhcx5UXurYtME5GlFpBJN9EbRkVkL5yoqO4ZCR4kq1O0UNvLvJ?=
 =?us-ascii?Q?5cB3lPGiOh9ZGOAzizZXozxtxc4+tPEzOiD4q0wDvjVC7O80+UCLpPM/IG8J?=
 =?us-ascii?Q?zMEuJd/pZSl3jmzcg4HiAUreGMoZhpYjR3BOFRgf4HzLd6w/nNwvg2otwUPc?=
 =?us-ascii?Q?WxDUVS9XMZ0ekLwJGrPK9JOvHY8Y4HfIdfIwCreS5TTy5W15Y/m644pSSRAP?=
 =?us-ascii?Q?0ZzHuD/O02bSL3HX2Q9ujUV+a0Es+IzUmlkAbSMgZOwQCmYbvk5iTOHMeoJ9?=
 =?us-ascii?Q?KFVnGvjP1X4Rv73dEv17dPIwbsMo2KLLepLob/fsoqyGu/k8SNfv/YjRObG/?=
 =?us-ascii?Q?mAefOAUXZYWJQ8Xd2FB3l7eszr+FvAAzb5ceF0AdKBmlHFFyBRT3eHxd5MVt?=
 =?us-ascii?Q?4xZeL1QPbIEwcM7KK5je7UpxxT1KyR+K96px7St7LdVca4pjX9UnbNj7ViPO?=
 =?us-ascii?Q?ZYhRsn8lh0AOfjODmax3XeHuYsVz1h//IT2m8A0wlt0UfYlMocPFbJVacHMZ?=
 =?us-ascii?Q?UhIw39xTKoD7vnYkkEkveQwdKoNxWGRnr+eELpeXOH/PaobzbokrdAyuGoa+?=
 =?us-ascii?Q?LAfvo8NH3pIjwMY5cB6/SNX9khxmadCvsef/929xEzhMd34utFV3qmn1u1EY?=
 =?us-ascii?Q?tDIWlTsg9GYSVlT0HPQvMLccHxoFa5ipbnB0wWlI5EGEt8ViP0f9EAqMt9C2?=
 =?us-ascii?Q?rDBWEXjbyyKMwTP5Kb7IRx0Mx+eW6vw+Ly31uzTI6H7TMyDkQo6BlYDhJ5IX?=
 =?us-ascii?Q?bki0RgNqxCfGgjm6OOGEJVSg2iX5gne8p3pSQ95fE9Y/B01laVbWb9Fqs6Ah?=
 =?us-ascii?Q?7aJu6ItL/cC+TY2oVskXJPbxwDL09BPFnGto3jkBdPh4nMvw0yhxCxsDvowr?=
 =?us-ascii?Q?rkY+pt3VrFjuzPTVZQrLHbJmvZeYundgh2s24cmndJNgh/9qIOlTIxT0DNEo?=
 =?us-ascii?Q?+5YTp+QpOY/BPZHh+x+gWRs6gvbj1TMvAQwBjOYigi83k+jt4QLfti8e9Sin?=
 =?us-ascii?Q?4vQAvsi4BwU=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:37:49.4174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0638c80-e991-49c1-5dc9-08dd66d2186a
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9132

It seems that there's no guarantee that 'struct timespec' will be
available via <sys/time.h>, so include <time.h> directly [1]

[1] https://libc-alpha.sourceware.narkive.com/yb0aXzSp/defining-timespec-in-time-h-or-sys-time-h#post3
---
 tools/btpclient.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index bdfff5df83c2..055270edb51b 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -17,6 +17,7 @@
 #include <assert.h>
 #include <getopt.h>
 #include <signal.h>
+#include <time.h>
 
 #include <ell/ell.h>
 
-- 
2.43.0

