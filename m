Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351955E59
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Mar 2024 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648133; cv=fail; b=DvEXee+n+tvejRGYQDEs1e6a5I1wWoJ4p5PxnxOIF648HKqZFdKvaYB0DyynIDF3z2Y3EJKgDeE6i6PUnAw/KwhZ9BgP88cLgh0vwt0rY1z1F1s1eNPC3ED4LrVuA6VzfCWdGKasgdxFFC3vs+SnHvlKvmTT7kJqyIRj4axPz2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648133; c=relaxed/simple;
	bh=EOY+q42yiUIzKV9KAS+3LcaITvLTPTffx/Cr5Y2rmno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gUKoO/sj6DQqeNWOsPgY1ofHQuU54QiludNVzD90quVUjHA8plD5Pd5Uh4U0zkcW2r4vM7qUS99nwiM1m6CZ5ND7DqQGGz6YcA10wApoBl/5pEKYXlfd1TcD/wLyGk7fHjlTQQFjn3cK6DBnvypF6PNDHLPtCAf1/uoLBlbSdIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DyCxPEa6; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DyCxPEa6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0b1Ghtr5Oa77+F4hM0nTvQFwd+bnxFNvmIb1/6QTUBGU1mY2uSBd/2gZ9U/cwst7Eq58ywgYqkh20Qg/tCLpVbU5PilEp4Q/O5dgAxfk6jnwBB9iX0IaSDopq4OZy9lN7ux5U+NFmCfJqssgSvaC76PKwd+kCZczZ4/TCRT8j6rvRhZU57E4tXpesb4u7TKCcqQAVZzIK384/vc3ANFmEZzxvEtublRgjBM4LJLXgFhs2unOUgVsfqH4rNFB8nP8YBr17tSV2oCL9iaMnaHfpA1WvGp8QJ6rvsLz8vBljOPXMVsSkLtaN0gGr1/huWhm2qMwOY2bIVlvAoRsQ2K4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NL8CSzM+BlYwpJ6uUJGL3p/BkqAjdMELRbrSq7CRv2I=;
 b=guVBnwUKCr9Q2ZYMi0srFOpadTEQaomIkX2Cb9ZZWxiRkcP0/61ZdHekszOwNNWGQwLeJabEIDEefWiNTRQbsd3WBlCjZsQ65P8WBLLz0yvgV5A4CVQ07c747+MEJifT0ELPvmB4nqAQsySwYYv0UikUZXaywGhi9sXySi5ueLKh88//20SnwGvW6zLmYVeX9IQS5eC5T+DXhRDO0MsrcTwEyuryw08wXXLzsq19PcLBWmypmA2C0LX+9Z04uMlajwlWe1FqdCa1ereHhZ3/+kQyDCDq41E4NqhpRyFiFxDTWphP7QL2xT52nja+xDhT+E9+JX0cw+O3HAbf27xsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NL8CSzM+BlYwpJ6uUJGL3p/BkqAjdMELRbrSq7CRv2I=;
 b=DyCxPEa6h7MGeGxxqxDmYEF4042+y/YOlLjU1yEaenTNnW1pHPcrFuCK3LbTZLGZarFr/onrbJZ7hCnWZzuHyIk94L1BzFu+aQbAOwRQXI2ZYUc5D9SyFLjeTa1bLCyC3vgRlus0ALum5CpbB9fTVFKGYQH+gihC/nMQ1FMByuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by VI1PR04MB6814.eurprd04.prod.outlook.com (2603:10a6:803:138::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 14:15:28 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 14:15:28 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 1/1] shared/shell: Fix heap use after free on exit
Date: Tue,  5 Mar 2024 16:15:21 +0200
Message-Id: <20240305141521.132865-2-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240305141521.132865-1-andrei.istodorescu@nxp.com>
References: <20240305141521.132865-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0046.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::27) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|VI1PR04MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 8884ebda-4aa4-457a-5769-08dc3d1eb535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1zlxcu4U7H1aOakT9Vzp+t7dnrKCYEVcuPMY9r+HxANQHPlavSIclOxtwskAwjRIY0HfVV83vZacXxnvzcdPxhzJX+SCxnlzTmCai46uTQEZkun/ZoZ40tLQYB6Pr2nBlFCCTuhd0sDksN1XDAZWT7NARZSRGQiyeXKSiegOboHhtkH3Wi600/V/8Kfe2/s9AyVDNY/Z2cOHKviH3lxr9Q+FdL7TH1nfhs1y7/OX30cVn0FrXpbQ3bwip51fLIx/9v3hdNFkN+iA3xq1SYOSqYlQTWhwfWTIvBPH2mKJkhKXlAeNxvZgkXA0I/nPMB/w8LyQ5SYC440ki7undBaWbcc+y9TRmFqtS9n+1QfMZXD9GCzMsN7mvCXXd7Xs2S5A20Ln5HSDVGSrT8/Ar39kyoD6GSdQO54zglPnIkdhcrM1k9T9IPpkZCkTfBtGL3mwO9qrqFaOq0Frw43cTkVadnk2vPVOLdRxcZ0WhmsXky0qEPeSVa9RXZRWVt5Q+4BWLnmUpcFsTCyKJ2iUy4AnosINvN8nvwXDZ5vhpwz/z+tqiN96vWSsSMVoyzCXPqI0epryUCMynrUN4D6AuKkE+AwGNhgEvg/3FvYLrwX2sn0ME++N9KdCJM7/UQ9aHDy0nDZEMjnu37Bw5tXf6EMeW5FvzBgqgOvdVH1nEJtZMwI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uHpRcX9JTLyTlIFCSXlfaqxpfqpNEPXvJ4xN7kGs/JXjcWG1KT9aGryyfKAG?=
 =?us-ascii?Q?m6WKsv7lkmoFjJQFNsN5+E9EAGp34PzjhzxFdolJ6Dpy+3V56Dyy+OQth0Md?=
 =?us-ascii?Q?aGRPjOj2W8oERM1k/BRpx5ESSYYHWAWVg6M78FuigDlB32zWgIJ5MkQIEpCe?=
 =?us-ascii?Q?+ukTBYWWq5RT8SHdQ/eFOEXM1Nv295K9xNd8MGc9lIozoC+Kd71SmhF0x9Om?=
 =?us-ascii?Q?X7VP63TQiJYOuD+tmRaM9vusX1qIWNqtGB++ZrYxKvaRS6In+iDfEjQrLAoL?=
 =?us-ascii?Q?yip/bh+rt7mBzCx9tOTQ1WUBXp7zAYODaTqZhZ+Pw+oyKGUeTOpLYGpRXZ+0?=
 =?us-ascii?Q?MCNIzYBoXZ52yNVaCK7gbawaF3b7el4ZYllYNWjlS1uV6tXpUktU4PIw3Pdp?=
 =?us-ascii?Q?EYOl03DM20xBK6Fj+E3WlzV9V6q7GBk0E91s0nIj4kYwntFOTlvzrgFHuS15?=
 =?us-ascii?Q?jv7vGgQm9EXIvpsgoqRFvdMoEwZX1PuH2zXlbjBbf/JR+578taSH4GJitqCJ?=
 =?us-ascii?Q?Ny7EVuoio+Kta8C+7ZMJT0SJsixlT7OO760EP/Smqq927sEzGnCEWnM1y7fd?=
 =?us-ascii?Q?Qp42bpLSsk4xOZK16Wj7HhGjYo5/zh3RSA9ZpByo6D6wTvO9HNK9EozMAbI3?=
 =?us-ascii?Q?cX4AH++dtJmcfqUL/MeRA1O3qrAhLncfYPOHaklKP1OHLjAJXhz+bAToTGKm?=
 =?us-ascii?Q?fR9zKbHUu8zvK7ylqh47payx66sH9k4zzQhAAGSqHVDUL8eeEw2lTt8DbEWZ?=
 =?us-ascii?Q?cqDL7+m8ARagXtxSVlPMzOixIjLjhxm9VZXmqr5IJ0x8yfPdz0KTJ3BmGWUI?=
 =?us-ascii?Q?bzpSkoUlqLXnI0+EZ7c6mqp0Mp5yvLtDwDncXk4u5GPA9bSAbYdeYED2NndP?=
 =?us-ascii?Q?9TTqsJ+Vr14Of5RQTq5FlA9Be1tYwLQ6cA6lp4U5oNNr+It+rjpXpEVbtQvo?=
 =?us-ascii?Q?72fsAxYcMvQ6YN8H9TayXhIvyShI/dO21oCMVvo8VLcQWUJY3fJHGcHENe10?=
 =?us-ascii?Q?8XAjFHgCTTadfb04iWUsLO3MfyGuOQsV+UCBoD4+fmIz6rtaYsRhrcWXuZ+4?=
 =?us-ascii?Q?TBwxp0IscRRYFwL0Ea6dqxyYJZWh8MONOsKtM+FiOZxAOQek09a3zaomRMov?=
 =?us-ascii?Q?GnYZi+kIdsnZS6K+emhMK8dGj1NmRVfYhe3lyXkC6fsnqRKIclnUwZbZz726?=
 =?us-ascii?Q?eBs2X+b2ukwDakb95hzWaE/cTCKf1rr//t3X8Ayn905/k5x4PqIJLwj45i4p?=
 =?us-ascii?Q?oYErF7s5UImtHhvyEKOxtbj4jBz3Yi2d0wGHYVOUIU/L3pPKpgpklXTu1NcS?=
 =?us-ascii?Q?vT9eN2wDNpk64xRoYv++JLcB8SuDChUVPe8HmxdrZJOBoRIDpnclf2ya/MRz?=
 =?us-ascii?Q?7huzJ/pgqQ4OSmV/GsUJpqgrWfJ0+xFKEqY9DXOuacBQnGiynuhsGX7XhA43?=
 =?us-ascii?Q?B1XxMdDYzs2XtmmyUMfCFPRmbY8yvWopPsj3BD/w0BP3GwlOIihbjoc4T0GE?=
 =?us-ascii?Q?wiZJ7t6GEt0ZMcaVd3CpenzPNZr2fPX9XNVxs0DUnwbTDEnJ3puunbrlgXQx?=
 =?us-ascii?Q?VIUQqC+Xh/IktjBlzAPUW7hXnkDyQVkzLO9D3nUMbVHRlYFK2X2JgD67QBTN?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8884ebda-4aa4-457a-5769-08dc3d1eb535
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:15:27.9246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cE89YKBiqqlZnIB977wn/RMJYL28CjEKpTU3iCZXNERs0EFsg0YocHbiW6WciKrWET1JX0bp1O8Kj6aC7UfXbOCyXIqJyvJjye4NBGlcTHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6814

Set the value for data.inputs and data.queue queues to NULL after
freeing, so that further processes won't use already freed memory
---
 src/shared/shell.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 68499b464b69..7bcfcff3ee76 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2017  Intel Corporation. All rights reserved.
- *
+ *  Copyright 2024 NXP
  *
  */
 
@@ -1362,7 +1362,9 @@ void bt_shell_cleanup(void)
 	rl_cleanup();
 
 	queue_destroy(data.inputs, NULL);
+	data.inputs = NULL;
 	queue_destroy(data.queue, free);
+	data.queue = NULL;
 	queue_destroy(data.prompts, prompt_free);
 	data.prompts = NULL;
 
-- 
2.40.1

