Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297193232
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809685; cv=fail; b=mm4rNzJTFGAr5EHd1dvwbImQF7RTP/qK+Yt6SbymCd8Gb3WsXkGI+qdODcWlV4fDUgtTfGJI8PRf2nLfue+Vq+WM25JoCWM62rtFJUg/MPB5CN5kGspDjBo9zIYlLfrRY3+SXhXth6HFDAru8QAZ7G//b2Vst++sQWH+F939I5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809685; c=relaxed/simple;
	bh=CPS1bLm+DcUxUKPUH9cKB0aGvXEI1d0uEh+nkM97vao=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sUx/Mwc5pEs89RfhByB4hNIktVJjTuU7qh+sN1oPUAAbRQOjQtYdQ9C9woVPTGgO30b00dhsUJGA2uLRZ51fOb5qKMp0xfUdoulGJCU1vzuavTR/C9HoLeekiA5YKQ9W9qzmOMkvK08LOZDukoWbC9W5Wq7ACqlgJ47SnnY9kMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=epqukeOl; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="epqukeOl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drSroAofEzG+hqfKO6SG//LVPhHa68e9y1HgedFPVsiYiC8wQhoRQfuBwePg4kWOQPGmR1ZyM3zNcC6SuwodCAqDDB32xtA3Pq2yrCPQ0JKpIKmZB7eSW/wHcCO0BXCXYsthjVMSFLdiMFiW2aZADN7BH5m7+d96O3yqLn6bkzIZ4iwW1BvnQQkEixNanvwzXM9S1TMESB6NAEptqMrciKFg/dQeiLCEESyqdHt95sO2iSBOuL05vi/xpdA4oAkoy7X6q9qau4c12ejm6YjIwEqJKGVcQAzUUkGPzX4o//qbbVg8QGWv1wICnpXDuRukpric8xe9qvFg+a/Lm5qw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16p3DBzvprA9QVznZSKyCz9S98B23zzV1xvwxBCdBt0=;
 b=KYi31v8XS1qmW06lKhdRZWAcx8tKFhGeImBBrHkvtXm1dZz9Vc2iVTltHzzqAQngggF5NsLszu5NOAVvD+wtueWJ2ox18az+sHyXnsKRs1QUwT9Ri+W5M+iHtAo1mrqYu99ny1o8jt0p221mGoCoq7gmDwKO+sL6UojtxUY8UhRPIUSpEG8eCHbrbjxDyqFiw+Y6JYXJOLZYvMKRmr+UbI9rGgEtlW4lMj+TvNvpTflqPTTO9p24h6Tfli3ZKe2gvS9HhMyY+PXugcCU23C6EX9v3r4CcFPt0zZUJyTua0PNcOklArpLlvKX42i2J9X5OauYYR1g62qjt1oVz2Oj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16p3DBzvprA9QVznZSKyCz9S98B23zzV1xvwxBCdBt0=;
 b=epqukeOlXJeEzqZcy4eVCaxNqWEm06YvGUzC6nUM4o+09jUnVc2el/4YxcsNiutFMnoNqvtpY6SUeU0Ym4JCenRtMxLXTCTXM/c/SWLQPtaeMFYXEfd+UrCtWg4vfTClgAeIpuXq2kiN7h8bO79dBUt4CPNG7bBab3fOkWryuX7a/QDbaezfw078kmhZDmiaSLGhbmWuIo44emEGcOMUrlJ56bLoHA9qV84g/Uy/JmEvG6Murti+V9NOTS7hI6EmVTUFW6g20nw33nGpZqFjd6b/sYWBg2Y5HiisqFWtgFuySSS+R9IgExbHM0kwWS39lvV9ufjROFrlgv898UjTUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB7191.eurprd04.prod.outlook.com (2603:10a6:20b:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Thu, 28 Nov
 2024 16:01:20 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 16:01:20 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/2] iso-tester: Add test for ISO Broadcaster Receiver Defer Reconnect
Date: Thu, 28 Nov 2024 18:00:59 +0200
Message-ID: <20241128160101.15187-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::10) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: d8888873-00ee-4b77-3768-08dd0fc5e608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fz0G2fxmr6jvkazEZpMf0wSzSo8Sy/JP+QyM9xmokG48xOPaL7niDecOltkO?=
 =?us-ascii?Q?abFPwKgfl/1w1IJVikdhrwEUw4XT3LPw3kKdEfxpWOZVJGnYkGfElPTIcjCX?=
 =?us-ascii?Q?lrPjU8IBpR3sMvErj8dQLthWcvD6lBNPMSMZYQY6c+N+0eMX6lxlYP3Ac+zg?=
 =?us-ascii?Q?eZjfLcNPc2PQgkIdRQF3LPUSt8kXLfxh7IRw1eyBuaduy9PB3Hv/aMOsbadw?=
 =?us-ascii?Q?NWp5talh+GIX8IaBRElJ9QodTvOlUQID0mxl+QnWJhHBvSJoLLHy4/KPHrah?=
 =?us-ascii?Q?0fj3zo7WtkPz2kOCFFD36b+cqgCqrNJMXv6pfwjfSn2VURKs5q+WRjuOfuIg?=
 =?us-ascii?Q?pCQouufkWmDaU6kspYmbtPeJ/+LemJ6khFa5M76dTRisraNnFQRQrX33H30+?=
 =?us-ascii?Q?dg2fxKCO88D4kUa7kxVJYxqp0E+fzjRcQhumY6SabN9Lm9omsf5h9Ym8bPRl?=
 =?us-ascii?Q?gCFux6cF/kcY+hcpZk7gKLbjgDHQRR1N8+mjK2lmw1HVRdSRDJ3ahfdHY9XB?=
 =?us-ascii?Q?av1hWmAa2w0PNIBKzlLaol0w1i15pNhwJ0+D8e9YbEUcj2kTez7gRK2gxihH?=
 =?us-ascii?Q?jXUcpcjxgEUIVtOc0iJaRjyKMDTjzjF8E+qnJLXHp9sFXYo9twIUYAqipPHb?=
 =?us-ascii?Q?gLdvg2GlZ3nP5rGeHRfbUM3nX2LH+A32TdNRJIZHvTw27bG+zKJS8RfjW8nx?=
 =?us-ascii?Q?Kp9uOoohSPcdKehIZlvySqi95984WKvIE/twaYsymKIqldvRNEw4+m8w8ykD?=
 =?us-ascii?Q?yN0TsjQXZ/0rVyBct70w+eQt001xe7Uep1mn9KBpLmIIjffiM0CIH2YNsbf7?=
 =?us-ascii?Q?BbjoZ6JQIjXt+KJ7JbvBU4RAwfam1+rNaoLe/PaBxguRk77NvY7sNmLcQZPX?=
 =?us-ascii?Q?i8R8i/UGNDMRXmxDb9Sp5Ly3DtOOUubj8OFOZZBucyiL214+Mdfk3WG0kF8G?=
 =?us-ascii?Q?D6whG4VNMYVtnVPn7rfRV3aZz4jl48QMFsvAnuagPHEkNQQTZy45IxJRh+zk?=
 =?us-ascii?Q?XqpL7dlTxnaYycYAUIJGE3MYrtkfyZZIDZGsoF9ADZJmn0n91RiRBEOELm+u?=
 =?us-ascii?Q?TeLjj2YrqYfAuFF0zuRx5yqeWx5yxL80w3+DHdQGnqxcAXXSs6AXwQPPk4lj?=
 =?us-ascii?Q?+xSlCtfRnan/9k1j7Yj9N/0nrLsdvbaS1frNgxiSXfkbssqPvyv/4gGZEXEK?=
 =?us-ascii?Q?dW2gM6RebSRjhCndhNNJusMei7yW9CBe+cgGIIsqROnMx7qGpa+liuyY9HuT?=
 =?us-ascii?Q?H0MlmrwhvT0iBGOc/qSiZ26YGmhEH1BpEpSW+vrwZ9BBn7PckmewqPquh4Go?=
 =?us-ascii?Q?HGLtyAiLpyG1Jcr+IcBaafSDEVsEznSWl2TBgvr+He8H63/Aizus+MZSKkaq?=
 =?us-ascii?Q?QG5y6Xs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bQ6RmmsvIqHAxJeazWNFz+sYEcVim/njUZx1pWylRor4/a3D596Z0nYAYGlE?=
 =?us-ascii?Q?/JfjuNk/WkKHMUZp1rnDD//GkjOrTHON6TzIKO8pRL5RlJhVFcNngbxlJu1r?=
 =?us-ascii?Q?ES25uNe44SmDK3CX8L+K8molG7eBSov7UQt6aA7NapOC3iwRLrwDeNyN5888?=
 =?us-ascii?Q?G9IEGasVriQt1QE8lkwQ/KTLAb7eaCelWj+Cz/ufXQ1/PTlAEO2G6tFcMJDr?=
 =?us-ascii?Q?riNgmaCBobQJo5eet7IfsZ1Uk93uKY6WNnXOJI8yZ53ud/SRRGX+lJVPilcB?=
 =?us-ascii?Q?JybT7E4fxqyFC6DS/Oik+1yO9N+8px3eMVebmUPDlqFYwGvs51Z2xyv5kL1l?=
 =?us-ascii?Q?NsZ37bDfaQAZWUJRkI+cJGBB/mG9lPYGDELQnOlsNOHV1HXIs2VAYdJPKbBZ?=
 =?us-ascii?Q?vduSEB/jz31NImEjERN9diaWPyoM0hWQaZsvXLMn1t7A8+S2lYEbbTAVTurQ?=
 =?us-ascii?Q?0XbdLOQ78ERupmMamLAzUPwZd/rvoYGVKv3eOyZML1NYMskixtD3CI0l2qyD?=
 =?us-ascii?Q?s1KJq/UWDm3/C4tw8kHrG2srpqNkY2SbWrTU8IyiLUzviwhJrXNp3dUYX13d?=
 =?us-ascii?Q?W/lXafpE1i5VV70MZd544Ss4EUEhhMpPlLBdAg6RMB55Z+uhmhz/h+jOJrNd?=
 =?us-ascii?Q?qX/IZXdp7E9iM07aPwQNDigtxTjiKdKG7rgGyTEiP1uN/+VqYkibstvFRVHI?=
 =?us-ascii?Q?act/ubST4dUyj2t/ZZPP6mDaiUYp5OvquG/ooC9lxx3JSy4BS7WixXd3DX67?=
 =?us-ascii?Q?rADwQqtXnJsLasV8JUP/RDEtlfIC7lXKZ9DM972AABqhq+Bc8h/3bxdGtjEU?=
 =?us-ascii?Q?Sg6dSh2mXeD5ge48qEcd4hJCdY6/dvQ/9gQijqV4wNCdNmu+TBPqLG/2NLmo?=
 =?us-ascii?Q?8Im5wlWyHN77ewfXZH6th7ZBHSu86dbYW5TC/rpBKj65nzSTPVKW+ljTDEN2?=
 =?us-ascii?Q?u0Y5sUEFLk9DLbUju5f7Dui0VmVJBR49r6MdPrrSTmgRGadZzE/oVNurNUTI?=
 =?us-ascii?Q?uxbVSwX3DwSWqvFRHG6+dBzmZQj6Fp4Ytf25IuJiIqEuMxP0dGLBSybWRaSO?=
 =?us-ascii?Q?oYpRvu1XCNFA/qCunisWff5tvZ2wugXLwqM2uBprVAOLLqdBV6xnn0DY36/N?=
 =?us-ascii?Q?8sVsVDjOKSkweqP3n3NJ5iMDR2e4jd66qpKjNWynKnjp4lbWtSwh16RNkkvd?=
 =?us-ascii?Q?Wv21J5UNeSj/cTrOfB2TLSBUJQ1kVTfw82+4gO7XdJCGmqFwa2eWa65j5BYs?=
 =?us-ascii?Q?lYkBgT0e76BipBsP3uc75l/Ve5TbADM/fb0iBKrYpR8Ndf2ON5C5vD69b7hU?=
 =?us-ascii?Q?LKs71u5+5tyPETLe1QxK41k6LizrgrZzPmR+nKfQx5yzeg8VPjaOn5Y8ut5c?=
 =?us-ascii?Q?d2yHWiiVWIBMx0R5kaiW1iaFgXi5zzZMyN+AS8ndhhEZAdOJ2b2hlnEjiIoH?=
 =?us-ascii?Q?Hnp+N2bP6MSi/gnRdtFRKmOD2e4HmbMXB3YJIR+iF7bxP/6gdwGzSbdpS/Ee?=
 =?us-ascii?Q?EvzQE7bv/W/Z5vLoEfKRL50RhYWxxGbCnvYoJQL3eEasEUIVgw54pzBYTVbf?=
 =?us-ascii?Q?tCrtR2XIrad5lIcEdsBsrtqjVh0B06speyKc5DBGDr6PkslnstcKbuTlyXYD?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8888873-00ee-4b77-3768-08dd0fc5e608
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 16:01:19.9993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQGx0uDoH3gcKBUv2vdRqjNNecoEMba1TD3NWAzPBCufDmd8oOb+G9Dnt1tpnvLLWQID/2SgrH+whkJGKzYSVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7191

This adds a test for a Broadcast Receiver terminating BIG sync and
re-establishing it, while keeping PA sync alive:

ISO Broadcaster Receiver Defer Reconnect - Success

This depends on the kernel support added in
https://patchwork.kernel.org/project/bluetooth/patch/20241128155405.14910-2-iulia.tanasescu@nxp.com/

Iulia Tanasescu (2):
  btdev: Unlink local BIS before removing
  iso-tester: Add test for ISO Broadcaster Receiver Defer Reconnect

 emulator/btdev.c   |  3 +++
 tools/iso-tester.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)


base-commit: 5014920870d92ac6f616a4eb9ba757bbf538fb22
-- 
2.43.0

