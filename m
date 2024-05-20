Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5020328
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716200428; cv=fail; b=BmJTR2yYVmNT49fbPToMUE8NcrGidUd7GrN4yrGFc36Pbm+aUwmg3E2j3aF2jH3wFiyfKpNkWZSyOEHrWxZbyh7Wqc0NKCoghFjwe9Z8YgtTMM6XQ8PxPaJQBE47GOpZlFEmX9FM3V0Vdhh4rVFTokoPN6LMpEpXBBtUauy0Sog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716200428; c=relaxed/simple;
	bh=FOasu9Y6pX9bjhAK+wGK2iP8axmzlOkWMUohqCkVHo4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BQSSfoC6vq7nMC4UrzC8A6BClFI9eLTB/Mp91hxlWP+TVA+jICK/n6F+BYVzAdKSI9HEed43p1xCeY2ZD1KsoQCFO+4b78jg7DvAtjSBNm5QMgECOe5I3Rt+UeTaaGkwPtGp5OrLN1ikQ1GLjXEGWFxKmXsilVcx1cHQNq47tos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pGGixY6h; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pGGixY6h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVJQbMjjkEFHRZk/UGEPrLjvuuHVeEd7Xl6lWy/eKZGdllOXutLAR4FSg6spPEpB9rcvTNVBycolzUXI+0eIjBvM4d34iv2pfiZ1cxbw/Nz9tor3m+wY00Q+sYneQYAKPVGiCQUsJ4wVIZxM8MhCG/3dHGxENsjcgxH3Ath7WnMAQGYAkoL78TDcsJXrime1HS2gvb3Y/BHU+REhoYHRcAbtc/3zs0x+Y+JmjE00p2+riB/e1OAhPwwMQ9bmbKybA2HUvTTb6qXbiIiTiuGs1krHS8fFp0jNTKU+vP7VxVgcY4dzAN29OTPFJ9TqaPfJSTbxTh8uaRokQQLguYR5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUbfNm3HNi94iYiStLcyDYbBwqtJUmQjlTb7xl8Dlmo=;
 b=MrlO8sPsqmNqoG8c4eY6K4it9Rr6FK5TCf75J4DXFIUcOaDKx2UZZnaybR2ayobU8YHCh0N3TZyvqsGyLzbAD0UIPvjoFMopVzbQELU4kvkGQmT/ucJEXc3roQJjcFG9sZ1J4Z0L+/L3nPzZ9pgdZrHssBitaW3Emj/kAgxX1ekoUJKiMw1NojHiwQLwFip9PjGqVRXOyGCmvk9a3HBFax70q9U9Q/DTYTpGxe9iDj7wYkBOMrMpK4CDM1PVxT1jZiIZlj40job+Go7+q6VrTyCxMVvVgheRAyTIKVPolnEMkfoPo+d6gFh3ZuYomBOuCptHMLkx46MLBpklgMIMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUbfNm3HNi94iYiStLcyDYbBwqtJUmQjlTb7xl8Dlmo=;
 b=pGGixY6hEWGOyyJIVAI6VoFucW51yNY6bLRyog9NmyVVjYkyuw1cs1GaGzoASKmoz3EARf5Uv2Glal9VrsPcfiEzhx8vCvRLQHmVzk0SFsOsB1a0aV1WoTQwPxEkUOmq1oWJEapaFPC+i1Ao8QWIzEtgdXX6HX7Tz3BHfUcT0nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU4PR04MB10911.eurprd04.prod.outlook.com (2603:10a6:10:58c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 10:20:22 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 10:20:21 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] test-bap: Add Broadcast Sink STR one BIS tests
Date: Mon, 20 May 2024 13:20:13 +0300
Message-Id: <20240520102014.24236-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0013.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU4PR04MB10911:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb3d499-607a-404c-5381-08dc78b67426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DdxxvVzi2NNCPAf6ravGz37mnUtIMAVGA5OCYHGT47cQGTPJTwT2EewmuE/n?=
 =?us-ascii?Q?0ZHXKkMSNyT8Kz4tv9snEPyed7Vkr9Aplr0ubeoavS5wai+BaWYYUc0VzFpM?=
 =?us-ascii?Q?YDHQlsVh38VwyKgZlkXA1ux5jpgiWn8xC0ZtYHH56xStPFeQI83V51NkGd5r?=
 =?us-ascii?Q?v7bUDPyZY4WuVltU+Cddcf2EhohhpdN1CYlrC5Vy4Pcq3bfc3eq8HfwjXnyf?=
 =?us-ascii?Q?nkGA8RBzK7dywVPW/RpUYm2z2OLLXKLxIX7CitEqB4MfXNbR+0kYiiqNJAeG?=
 =?us-ascii?Q?fKbSAeh4njvikHvAWL2FMhe+OQqqKJa0GhRnmD+S/0zuLdLMcNUDJ8m3j2vI?=
 =?us-ascii?Q?oDgM00D5XpAGx+q13NmV2vTtT9eSVgVdyNOg+Yj83l1pTflzvkGocm+V29gx?=
 =?us-ascii?Q?UDn5qotOji7CKDRVzo0zQRTCeaRnmmNOeDJbPsO5SSvT6/kCcmVikspp6abh?=
 =?us-ascii?Q?E7oYK7vi+QrO3PmXrN3gIjKP1F9uNLd4LsrRWsoS+Wsj6E6nbSnQliD/YYFn?=
 =?us-ascii?Q?1Nv81FHIYyZdmlOg3RytF8FZIxfHtwaG5ajkiBC7Ktxx+vNPt7Kf4SUk7H07?=
 =?us-ascii?Q?u03YdxzeZxPhufZwE/TCimmLR1k95ZyfMf7bK7FqzB/fsuyjUnR4d4VU4RVc?=
 =?us-ascii?Q?x6XklxSCQppgJIBd5EZaoAWOVyhmPHp985kIvzNBGabIojnZw9+A3UyqN1kv?=
 =?us-ascii?Q?+3D6uZkrZx2Va85iujqGL3aw+BEKOZ2HajOuoU8w3XHjr3z43MloiORX6jCq?=
 =?us-ascii?Q?6e/dCB8rCmNbe+z9G8rNRwIliaGWFLH96ZFfEJC9+z5xyFalUfg2veOnkPTp?=
 =?us-ascii?Q?CbWbtysiQgmvCKPBfOrYQm0IxQy25rzq/XGbUrU5sdlm29iSrs3HAmuKmokK?=
 =?us-ascii?Q?SPhYA6YCISP1cySLuS4hDOuUiPG7yrGwPX9i7TkPYWxtAGamiuR0y9mXueXF?=
 =?us-ascii?Q?+efg0hZxJEhVrvRWSniKeN2SwfAY9JNOO7ovz0I0M778wC/+8Mr0ibNmsEKL?=
 =?us-ascii?Q?7KyCMQ/kSjBBcYkkRWDJ51Un9KWJho2d8wZWOPkyQc9C+oRSp5Gr0k6PzmBf?=
 =?us-ascii?Q?0WkaiaNQG7qarv8lr0BtRgzK+i+lg0F6O2qzD2ZHJS1ucD6wvms3TW+Z+JbU?=
 =?us-ascii?Q?QE9wpMeU58Mj10/GsRSWtjJj8DXmxeCqUvcwaFk/bKi9z+rVpy/bo/qlY6Rh?=
 =?us-ascii?Q?iq+u7wwtKcZzRGYXebqtFqEpiOfarYcZys36WEggA3pvPDNOW/YPaei2Psls?=
 =?us-ascii?Q?iJ2dan5Mr1puKFkVfBtESfU9YLlVdk/TCSn1nnE00w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6cPo2SebfDypkw+wCIrpXzAsDNuEU6M+DUnWqQFyJ+//9iff6XHuXZbD/fDU?=
 =?us-ascii?Q?k3830IeN+pSy8XJPSL7RvNZmF6BVN/eknQe+aoizrGguHhsD0bNUYWaGAfNK?=
 =?us-ascii?Q?1AkmegAyMN4RXFlyiYCOrjylOx7TqvCwN5QC4iZCqvLfv8u97tCs7c4+tAVt?=
 =?us-ascii?Q?rkQPpgHEMVKRmfhIP8S8Z3E8c5T2qMZNMxug5yqpJafThmTRLhwR22paYYPz?=
 =?us-ascii?Q?ZzB3r96N1BJnzTEqZphoXyZfMGypgjbW0BTUtDeE4Lvcz+Qv7WDTcXAJDZx3?=
 =?us-ascii?Q?/2qySrFBbdrifXsqrJPYwYgEWc0oo72tBS7vcKlk0CSp0LFYrCVpNKFpfEPO?=
 =?us-ascii?Q?0tMQs0v4sCyUcAWBBzjjvxF4toAd4BGz/ycT6MeS4ovHtE3ihlnbFSC4FP4y?=
 =?us-ascii?Q?vTJ5LRvP6qaf3Xgjg1DfYhxHezEd8yoHsX58UcR7DkBk1/pINu1N9bMmEltZ?=
 =?us-ascii?Q?nQPf5wZov+Vi4jOy0OBZIsvrSGNgv2Q3WQpuPEgTG/5BmF562c9T+sjyaBQt?=
 =?us-ascii?Q?rDoQeCdcOACm1au/02x6otr4OUFqqwulE6jfup3vMQRMWvds5R8n75Y9V3ht?=
 =?us-ascii?Q?UatzjzXYKyjU6VZOiisZ5YSLcm8kgys9QulBGGm+dY5To7OCzyp2FzaJydBs?=
 =?us-ascii?Q?j3dJNGUL9wr0UVtEDcf4UAW6B6OS3yCINg+4PaPH9m81dozZFYYJPI8IvJRo?=
 =?us-ascii?Q?9JfHBm2GGaRzHPYmLalkGoAm4vAU8FLtHYNY4ezdD9v4mh7RwWE7XCF3uGQf?=
 =?us-ascii?Q?Uj+o8fOHmWtx4pNWzD/9RH6sa94Q5BL+mqecMPNcDCboKy8Nu+HMOX4zz3tO?=
 =?us-ascii?Q?/pgVWDXbE2Hm7ukc3o+gTy2cJKdWpz7EpHqHGXXHBmbgwr/zIn3eA64I3zeH?=
 =?us-ascii?Q?/96lfLYgJzFP7IDMletKsCt/D4Q4DB7e32I/NaRWY142ZPQEMycY26cJVMvU?=
 =?us-ascii?Q?4FhZSNuTYfUVyPBjw67s7hXNHVeZpnrNtjPwhTxlRzIfZO7ILvPjfMa2jueQ?=
 =?us-ascii?Q?wWa8OqcPeExN49/Ajw67lOZR84pBSFy7n2B9zLc2gyYv7OMDi91KiD7p52j1?=
 =?us-ascii?Q?+6wNCIAVwW1JFFS8cswbp+eQA+XyH4wq9pU5l+R3TSFm7HXUpgwg9BEtAQBW?=
 =?us-ascii?Q?TqzjX1o8rvZs3CEVXdLCacdKpOngDiCIsX5Hmmd1jBVX/TITZZpWoBAIKjag?=
 =?us-ascii?Q?YMj8pwKBppaIVRZuo1Rzqwq0bEUnyz1lfyKjuYfrRaw11ed7vridxZXUNhr3?=
 =?us-ascii?Q?xZBYJszn+1OyPWbjQUONgR89mZyoMXr25UljCiGlABn8lVz8y7aFsb6syuPM?=
 =?us-ascii?Q?oQPhIlAx8B96+FGwwXgkQGWACd1KSiGP8cY002NwffbGJqi2qqLoFH3ffL3d?=
 =?us-ascii?Q?AdGL5L5CTGhIhgUl8dehdEgBa56RGo/byWOZFgc5xVU2ZNyTdYx2gkRyqJ2D?=
 =?us-ascii?Q?knxfM51M6JeLn7XWFoEVYAspi0AuFVlXoRRvdKTulqjvMBYQNtOS24FjLWAN?=
 =?us-ascii?Q?oxgxEvyeSNO4gkm1qaacCHZcSR5CMrcBCIiKDQAxsgXBGK3+Mj1C7FCkNK/k?=
 =?us-ascii?Q?oye+NhIaBAwueyQxhCwcltrWUnJdqVnZqpa11ncpBRFrcly2JL62JwzCE3QN?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb3d499-607a-404c-5381-08dc78b67426
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 10:20:21.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMkck2gM+PkW9l9PzXeAY3vnmrwmlxt7SUkxmim9GwULlYDFnKpdo+qWUsoA73UJfMxZLfY2YSM1kJZdaGM9jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10911

This patch adds BAP unit tests for Broadcast Sink Streaming with one
BIS (4.14.2 Broadcast Audio Stream with One BIS - Sink - page 189).

Iulia Tanasescu (1):
  test-bap: Add Broadcast Sink STR one BIS tests

 unit/test-bap.c | 209 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)


base-commit: 62d38d6c9ef4017ff6a84af0a9cd9242a7f6a211
-- 
2.39.2

