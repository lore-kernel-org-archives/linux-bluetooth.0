Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2074.outbound.protection.outlook.com [40.107.241.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866712F379
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827146; cv=fail; b=T7hcn485P2Js8DsxUOAvNFvsOG+EBj+HQat9s7pnXaALTYi7tGtRcFgMMld3oHYVKJBFhCtaHtxtIlSAgCaTDorIiW+IdNLT2Nb7K9o1IxP7lzLtk9USaF8llPRaiP56YK6n6tus7ZWBd4x7TGPOzopWKNDkW+GcjBzqOTCOsCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827146; c=relaxed/simple;
	bh=6Bn67gr6xaWS+u6i/GHtumjLfbkKCWzzXmKROC4+h8s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CTLBBqmVR5bjRPdIhSAykxKIuqJkQZegvCHcpBZD7qeWYj5Z/gY+86Xz39CoUK3hq/ap6nialOtoMPCIPyKVBU6ukNDQJFAN2lTarQ5sv3v1qX+2WqwUZWyTDnxXE1QeCYbeF++1C9/BpXBmXrBU6dJ8V6/aXMRWDIK7b52SrXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=N/kfsDc6; arc=fail smtp.client-ip=40.107.241.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N/kfsDc6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSo9ck3uYcGcZAviIGORUk7i2VfqioH73ySYNMHHZsDMP1XoURCLegFqT6fhQK1X1Uanj3e3wxvg4pJZMtDC1cQZ4HC9zE9JdOCFj/L6/0n6pP6qOH8bsrwWcmT5BcB9hCrNB03R999/t+30bqnu0cKXGFmmcsFByApPkSr/ixIh2+JlCiVuXZtcFEGCw76adX8FbCmAzPPGNuU2WdDiMwnTrShJo2l9q6sQ8THprvhtLo9Cok+EhRwntAIH4kT8uHBcKV38GC2Krf0KMhBl6afGCRvUbgSVj+CzmLUVI8y4sR/oYf5BSTdb8czFVFh0PZF2bOM3aa1m+8I02iUk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7973x8C3F07/PAvt9bKf4+Uohbk+JFT4/DZ3e1K/eAY=;
 b=V6fMdXfb+04GwygNq0YsdI55ikQ8jPIpoD5QR7HMPh5kllKgg7KI3Dw3pxioh4O02QlfRA6TSu3CVl2AqEXuZJWvgbpxwxPfEnAGAfA2+OD7kCOWyW0+mjuBsmCdtx/zg8aEmzK3pm2qW+mhuARF7hlqHOabkfyxslCin0pnVlrq8N98Up4eAVFnbVnoAJPrkCQTTK3SG29IduKRZE8UF4sHdMGOjlqQ5mynmQdyoztvAqJ+NMyOZokkFI33Acsn//QTGCchCGp0y4AB9PLCX6YkuqupcJVwmU1xpHI1wbVUH3FA6HsEjuJsckJw0Txp+B0I3S37Nd6jNwzWkSUU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7973x8C3F07/PAvt9bKf4+Uohbk+JFT4/DZ3e1K/eAY=;
 b=N/kfsDc6o32bQvkuPP6678y1pG4np/qTaM7+gikTuLuqnLjgqQRiPRrfYkhDKEkA0MfhPnmdexjRfdlQmZxp/jFnYFqftY1fGt+9gg/+CpEDX/7Q7suOIkDBoREvnf26jju/7W51mYqmTkmwwBNxqrNzEDu9J2jpDsUMN709eB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by PAXPR04MB8141.eurprd04.prod.outlook.com (2603:10a6:102:1bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 15:59:01 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2%6]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 15:59:01 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/4] client: Add scripts to start broadcast source/sink
Date: Thu,  7 Mar 2024 17:58:46 +0200
Message-Id: <20240307155850.68395-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0902CA0036.eurprd09.prod.outlook.com
 (2603:10a6:802:1::25) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|PAXPR04MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e35e7c-2eb3-4ba6-5239-08dc3ebf819e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kd4zKtRDrfld6dTU1/Evb/uiWZF+cQIHcaao8MQe9OS6+HCoxs27VgaBnVxHg5Jswmvf3ib8EZzth0O41hs49/ox3DsrRA/dSIPiRZP8GbUZnXSy5w/KAx6NiWvpb05w7Jb6bRL9UD9vK9/DvU08+xzJGmdzJRgzT4uA1Rh3EOZmmg9NpYitk64Rn4r7BakSCLe5DI6JdHwryoZWf5KynsBCgdzFlttIJuUiEpQpr9fVK9Dx07kbWub1TR+2d6KDPYiAt2dvYi/YEw9HrYxrLnRB0tBTVO9KGQ4qYyt7xZBIGxyth7GHTgLsT4AgIDYf9SOELhcuyhVkzwNkUCJ3jgJcowTnK49W0wbFE0bKn3iuuoXL2vMudmTfFAbsiNLg7iat3nA/yDzf08c3lgSbBicWVBe7tiSTtZV+ANghxCyny2DM4qCfcH+L0/GZEtcMD+I3GwecmK9Thj2mkUoPRE26OPrny83UJ/kRvd32TWk7ZuXPw3cDcybuio94Nrq8hdbOjLaCecKZI3VN+d8aQw3xWTtRMC0yW3BFAU9V3XxUNtTVwf4Y/jGacpD7Va/i9IS3LRHsfvjcsom78gbnnL8y87iH2bgKTGtM58H2t2ueVNpYV8e0kApCtURUVHKMTH1N6Hwl26VmIlKoGjY/HAwjRocMTdAHPWGKlDTZU/Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SLPEhvTp75lhrToK26bvxyx4dAVrZv3Uuckd1PwK6y4DPfrUUmfP6DxNpL5S?=
 =?us-ascii?Q?ihVVp7zkULEGLtad/znX2y3Frh74oBVCtZEW/3Wu/Kf5KFNKQtMHvXp4GWYV?=
 =?us-ascii?Q?8p0c31iqZnkgSn/fUmFKUSPkxs36m1aWH/pKskxbBXvWZt65SxFPnVwDQfD6?=
 =?us-ascii?Q?dGtOOl4JXIcd/sl7a4BtE/k7W2dl6uF+hya+MN7xSlDt7PTl1nczgPxUAWhC?=
 =?us-ascii?Q?plbzBFT08VC5rEw43jjiiVj/2aEdXb6OpEf8lUXHEeGKmjNavwsnhjXnZ4mx?=
 =?us-ascii?Q?GRqH5JOEywURu+wS5uCvnSxwHfEOaGCA8aUiM/s0a6QXUdSHmzb9Z30/7DXy?=
 =?us-ascii?Q?6acYe5N+cZ35MkLkQfGJWVZMz9GLKITeRcimS+XjUOfAzWgnhsDShHbuUij0?=
 =?us-ascii?Q?18rm3Rsl2uLDtkM25LI22KakgpaWc9cFVzIvHqF63ghIwfWbYyrq1VLJj7Z5?=
 =?us-ascii?Q?nQ7iztsIJgkwWp0lSMVF1sWR0DLkdJlKuEi9X/ZXE8wIrLYbH0dpCf9L3/MQ?=
 =?us-ascii?Q?dU0icg/1Q2N2q2mywNDEyO6g42XhEpKswYoFq+0rGU0Fku+s1ICZyy37ycvD?=
 =?us-ascii?Q?3Xx9zlRK/txVhLwa5w+wszO9a5TTmY7phf/yDDTZbGt7YB9z9t7trZpbOe+k?=
 =?us-ascii?Q?pJN73T8HVZMM4tG8VNfLRe68aDuAf/1NcU4PV20z3D8/YUodj6DMR4/jWvIE?=
 =?us-ascii?Q?yOAg30LrHuyC0UDRpDjozgRFQz/5aJOGFolXbz1OuxjqZgU1C4sShHRDyT3R?=
 =?us-ascii?Q?sHrVMsmHew6UJF2Q7LX2VhX7NaUD50R9IdmwaRQbDXS8VKR5dRDH2UieaL3s?=
 =?us-ascii?Q?GV4QTI2bOHRLq7b1Ooo6emo7iK2XoiazOvCNppqPng+rPRPzTnoTPvL33sle?=
 =?us-ascii?Q?axcenND/UdZZtcd0KdGGEH92r4UcyUcjMftHOPTPajai+oesfT1VKR/3JQew?=
 =?us-ascii?Q?LyvlXHxbTLPuMkR8XIBq3ygO1De4yfEisiwemaKtjQmf7ml1Ilc0mKmaeHax?=
 =?us-ascii?Q?loMPaRvi6Rv4eugC5VVR98+BdHU5SpV+YYoOsKQiCeWlV+qsibdowy1e2Ejq?=
 =?us-ascii?Q?T6o6YPX1FOBVc789tPxLyUWcOvrefoNiPtUx2Nt6SMex/UHvjLOinkbiuYol?=
 =?us-ascii?Q?+q7YXhnFQikLSs4gUZKh+haMn3RWb0rhtx8Fkf6zowMRYX7nXRhiuD5YMkft?=
 =?us-ascii?Q?CU2nmLBitR5sC5Q67TRNti5/VoSYDpyBepM/qRBZzD64Qk3BfYWvmS7jIKq4?=
 =?us-ascii?Q?GvOJ0zvdVlZ0PpGj5ajX6q1AWCJb44jP0t0WDHjBJJ/dfFi2YkRGH+Xb2ohk?=
 =?us-ascii?Q?IdvZ3noulmZ3EZ757UR1G3GWn9sWkNrsvACQhX6H3bavQkwhOcCct+mcYT5d?=
 =?us-ascii?Q?as10MHsslR4QrAsrkTccgxaGBgUgQThbf94LZu2Q20WOkfe/w3JorlPJxWJu?=
 =?us-ascii?Q?v/sQC2Uk8G1PjD8qm3h1UAiK1l1QmvquKUGGc92J54ClIGUKOJROzi4VlmCu?=
 =?us-ascii?Q?rXWGggkzAPMbbxPOVvJH8bINjkVI9/Y1hkIvkD763ZxVbrcaxmF/WY25Ry1E?=
 =?us-ascii?Q?/+TsXC+emd/WvChO89H2wNivw0bV19I6+3tzSPO0DmchaIbEfX8dNKVQdPoI?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e35e7c-2eb3-4ba6-5239-08dc3ebf819e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:59:01.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jh2Rso061oPmOTmTry+Gr1Hg/tTKaTNHnX2wl0/JAF/+rTGrMPIP29A2ak3NeW/IG4TxM5B1skBjfx6uZDU/7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8141

This patch adds some shell fixes and introduces bluetoothctl scripts
for starting a broadcast source/sink.

Iulia Tanasescu (4):
  client/gatt: Quit shell after user input has been processed
  client/adv_monitor: Remove shell quit from adv_monitor_register_app
  shared/shell: Add fixes for the init script scenario
  client: Add scripts to start broadcast source/sink

 client/adv_monitor.c               |  8 ++++----
 client/gatt.c                      |  9 +++++----
 client/scripts/broadcast-sink.bt   |  7 +++++++
 client/scripts/broadcast-source.bt | 11 +++++++++++
 src/shared/shell.c                 | 17 ++++++++++++++++-
 5 files changed, 43 insertions(+), 9 deletions(-)
 create mode 100644 client/scripts/broadcast-sink.bt
 create mode 100644 client/scripts/broadcast-source.bt

-- 
2.39.2

