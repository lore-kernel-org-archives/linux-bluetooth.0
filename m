Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021C3156C5F
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449908; cv=fail; b=dfbZWO5Hk7XQGbItu2uZQiWbYCVoyefiXXYgOs0fhVyx5ZJX+smQORDOZmoWM6kTecPyJ8bar1swsyvNdj4g7kBO04fauh38pBHK5eyE/APAzIEA0aoVPENbbz5UfLpIx4uUeLVbqBZBiS/tQ2BRSgiPVI3+EiK77aqE0Ib6lFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449908; c=relaxed/simple;
	bh=FL0cUW0EAtpzEtRQi0hgAxNWQWbInjeG2FmpVLrKWM4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Znf0BRwOQQGA1L2H274HBuCJAG2QvhSybocaZutIfEozk4+OPraKC+RQqQAI8wOjLJobNyakIQ5BQ2WXu1ESlUbOVp2SfHumZ1qBC25qjSuA4T8Aq9OTrImmaJpact0cjj67wJxw8ZMRBp2t5v5n5SlurNZneRwC7Igyflr+h2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hkPEiTnG; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hkPEiTnG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjIo4eZVulqm/oCpAex0i5bjuqbQHOROIls+8fFAeOEjh6BMCPaazQ/EgrC6QRPd+QRsr0oq/iSeTQ+x7dJBZKGc9XyidJLU9LqZs9fuEmEYRWcjscv05rCFMqSLjqzxlb/0QoM9SWyd4fbftR8k+TS704/54TXTPPYkI5AeMJz1NFd9IhdEGlsVuKm2N0MgUdeYO56EM4as9EMduEy1cK2tYr3iCVQ1BCWDd20Ux5JfWuv7K2+ff8oS0Z0Sx8xUjfPCPVlKXPbXVbp83tJYaaZPA7exXv0RxVc9vV+PRiYxcfiGcTfjKU4BFTSYfBezOppAEH7ef2v/jjQ1d3Ig1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyqY4Dg44qmIlUhmCwjwmVxWzMOdnSp/nnZYCC1g/X4=;
 b=XDhE2OzRftH9YecbBV/xE0dHl0JqpKFycvmEEAEiNzW4R05stzR1dkvWFviwrteRZcs8j2LPVW0VES0zczOK9B72AcXBMGeX0xI2/hnVfPHcEKSbS971g7xOZ7ntS8WZS5cL1GfjX8zB6cfx5j5OtSyDpcsnUi8gpDo8a3v4csSkuvdHAbE5YHnqA/bEI+Nz3bEah9NhLIu39Yt7tM1AKCJbaMq2pnKokRz5QzRi/5u5E2tAfSgE3KVaBwUAzA1dbCKMAFoQ+M94QwpUZvT8GLvsXi+bQPsrn7Y7Pqp81SnFPObzm2kh4vbOdtEFYbbUzi68I3goOLFlXRE7OxQcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyqY4Dg44qmIlUhmCwjwmVxWzMOdnSp/nnZYCC1g/X4=;
 b=hkPEiTnGXdWWy2nS2Uw2qFT5RiONYcvdcslqGlMaODAhzv9rXFDsW80j8AhdMvdmZaFxFmIlK0L7vetyR/1clWAbmK3veRliBerIbsm1vZFzaFaAPwE3MqWlPwb3N3MyZC+upTfkfeyajIcVtGUi3c5HlWY4yI97XeUeB01IfOV/lpEFdGQyUcIMI2DcGNDcgoHOxWUCnla4tM1VCAx8+VnP/uOH1UjuH7p+BelXK4jIrh5ycZezUaGoovC1Nrbv/Be+iFCp9S2w7zrx+Svv0/Sskn54S/8r6sjaNf811LRXJaZeazs5Z6hJ5msrje0LcaNcMBEuggn1zLpoc4xN0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA2PR04MB10215.eurprd04.prod.outlook.com (2603:10a6:102:409::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 08:31:43 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 08:31:43 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/5] iso-tester: Add tests for Broadcast Receiver sync to 2 BIGs
Date: Fri,  1 Nov 2024 10:31:14 +0200
Message-ID: <20241101083119.4510-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:205:1::46) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA2PR04MB10215:EE_
X-MS-Office365-Filtering-Correlation-Id: cd34be5f-e747-4863-06eb-08dcfa4f9d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dtpcb3kbHf4TB3hXzU+8k44x2ygIzFWBCMfrsnEaKlhI3boLzYnCqqX0Ita4?=
 =?us-ascii?Q?pU5RPQLjD1QnyjmqkDD8gMzFa4TPwqNeSKdq2cEKveLFwb/E514tfC6VZcF2?=
 =?us-ascii?Q?+oL0ue7arz5fJ9z47sAlIX8qkiO+vNbe7tekUy2VSEz/od963OLIlXYZ2rPB?=
 =?us-ascii?Q?50tM1qk+Eht+21OIRyy8Ib/QjiGCN0Pcv6VPA4yl2IHtg2pBH7KgdRa79TUj?=
 =?us-ascii?Q?JAGVpL+So+pn36Tb9oo7Hm+MqFEM/6yHlosykmzGza3CKD0C1wzlxatP5ZDx?=
 =?us-ascii?Q?I8sq/zGpLMHHFz0pRmKB+Y6xPFS/PmHWHFhn7RQqeo2ztHVcM/6EXgbDyoQ/?=
 =?us-ascii?Q?hgYLra+oA2ovpml06pp1bxCS5Mu7ab+WkRCT4dO0qlRC2A8J4QcIbt0ZOxjM?=
 =?us-ascii?Q?zaoRenRJ1T3F+8aYrwQLJh6BFMwiMLj+BhNfj+AWm3Ydc1zFlyrQg5fXm48w?=
 =?us-ascii?Q?JiNDwhY9O3ZHgms0BGXm/ap8pZ+BqqEJPt4jMZBIIKViuBiR9sN5OjSFQpVw?=
 =?us-ascii?Q?kNFZb5Hy4TMmfTXZQfrvguxwrSda1At0o+tOtV0kZW8mqvMtWdZW07bCHjR6?=
 =?us-ascii?Q?FuMGpsef/GxU6h9qHZVAOU3Sxe7NRQZmZayQfuAEzRGr35khMf9EH2lNy6Dv?=
 =?us-ascii?Q?zEE6lzD8ND2u0l0zLNLbxASvT2pzLyIjru8fSxu3li9y04eoCN5ICwVU8OXG?=
 =?us-ascii?Q?tkCaHhuJYJnG2K0OU6FpXyElN5tZTQ8qpcI7bkyvE8dRQsjwCqG7n75XcJuS?=
 =?us-ascii?Q?W3sqcLVGvAk1vRqB1ybB1YjWXMKEZeTr2bbRI3hylbnhZ+kuKvMVfBZvhAja?=
 =?us-ascii?Q?b4e7h5mlVwuTT7ir8KT54d67rk8mBJbpdo4C+C1bxlxYk2NQ9Mws8yrwLuV7?=
 =?us-ascii?Q?s/9PjrJGG6J5++4nrCiCmxuOdprlmUyMkELLgYVUTAat/boXu8V8GCmEAN6V?=
 =?us-ascii?Q?VEhzr/fk7xhUSRi/FMjf5N91EYEjE24dCO/rSteRIrhY+JiQWNER/dF6jc6R?=
 =?us-ascii?Q?Ka5mKPDkPSoT4VP1Ub3U9XkgXddPW3bV4ZnJaj1Nojk9mL4ECXZkmVyvpAkw?=
 =?us-ascii?Q?SiNLaJq+JdCPK+Z+g7ibH3ahWjpeeWzXlWXjpSpv1tL//q410pwngFPZdo5t?=
 =?us-ascii?Q?votwDQAQbYM1HQ1CisUPrLjv2sS4RaTzHGUt6Wcb79+ggCdC7eaaTqHBZv0F?=
 =?us-ascii?Q?wvXWm95kQwywCzOWyBo6VaoxCKKO0DyRoBxZanc3PHuDfgpXVhRl9fnoMJE7?=
 =?us-ascii?Q?1prMQtgzYVvNMMu2E6eOKYujwDZTuIEcLSlkbWnsbxM32q4mkd5c+NnkzkYa?=
 =?us-ascii?Q?rGzPhn8vQUcWHVxANEn/nF79lW0UyO3Qn0Wwtv0/0PYdGqSss14oQ42S9b5v?=
 =?us-ascii?Q?/q+E9TrTYvt3Ed0nkX4yJDdXC1t6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LguXEi/VNS9c9aGHFLHG8RdzMaPmKlJmHwY2qpRedK28Qz0aQ78C/J4L7YK8?=
 =?us-ascii?Q?lNIId77jzTaVzCBp8vcbsciyMHh6qM+oyfu43IGCZ7IWiR+7JNxhB0N+jVK+?=
 =?us-ascii?Q?wUYJkbWEr7rG5oCyf/ip4df3ziClriJBSyNFiiLbVIBSAF13ESeaVRxLVRC/?=
 =?us-ascii?Q?LNFmZwy+v1t6fAJrAPPGnuZVyFwrV0cvZ1i7sJOeSgX34boaj6RusCZmnv/4?=
 =?us-ascii?Q?b4thaBBWS3EC9If5VVvw3EUyUQ9FPxR7gq89RSt3wCshdPPh/EB8OypJBMyN?=
 =?us-ascii?Q?eWbts/sxm+o90l/SiA35V/VaIaPiAipSmjolDqMdFWuANgCP2Q+ru/TESH/K?=
 =?us-ascii?Q?xZ/DPvzEgSlllYFsuU1MplVf4o+jPtsE/d/GCnhneyKxz5z6TxpOvq06QdBg?=
 =?us-ascii?Q?IYMVozcUrM9aLgqDioQnpoHg//AfrrbDSNtlZQ17/SbojnGE4c4BHcrOgd/L?=
 =?us-ascii?Q?fZ9dvgMbs+4efP7rD8PcvSZlreQTtHcrtAsE7K+0JxHXMEBUiH4/91ngNtMF?=
 =?us-ascii?Q?t7/yfXwFk6LFEHOmA2MpoDFIjGp1th/KSeetjx8SRH2Hd9ycuPg1Xf2vRa+H?=
 =?us-ascii?Q?6CI1Z2lue9lcNpdQKCCIBaAw/ycGPfdSXifN+q6TaRxuU8AGPCEjxk+gNRra?=
 =?us-ascii?Q?m7ZWMRkzUWemNWRy8X+LWPV1gAKY6ZpKYMbenuZl8ZqAJ7jxY7d9vZskSPgD?=
 =?us-ascii?Q?4d5QL4HedCnUB00/FXCXI0P5Z6PK2mWQN7fyDoXMFqu0pGTBNFjBsW9rMwV+?=
 =?us-ascii?Q?u5DWmdLgslJ9ZFH0vCTkcYuGVyv6ZuBZc3pK5oWiW21lvDbdNa6Zg7UO8uBC?=
 =?us-ascii?Q?hBKmoGdOetW19O8LUgbWR4/phdj79G6Rkac2aXAe7Z1jTQAcUM32uivNpyLM?=
 =?us-ascii?Q?j7dESAiUzIyzXq+Ub56j9S/QrsfYpL4UwGQwEiawE8nEQuvserm7ZvkVI46a?=
 =?us-ascii?Q?c5qZ2aW7zYI6bUTOXqgdkGGMXl5xzGy9f3p9Ah1upnoWWatSGoWg4z95+s45?=
 =?us-ascii?Q?hqcrezDlkHzNGd5nVoTsPJf9n7VTx/IShvzMj0pYWtMLlns/lPIp5UmGmOwJ?=
 =?us-ascii?Q?eucXuhNhYAnLdhw+UpxcQeyQSJHlwAY42GgnflZEUZgQ7VrAGukYjnm/73xv?=
 =?us-ascii?Q?jZXUt22Df3zGu280MCXoWthz7an3G7AwlFAvw5fCyTkFH/2wr6edxXvZyo4e?=
 =?us-ascii?Q?20a7SkM83tKa/dFiVTv9uLHAzKr0XWxb54b3lyFdUYcnmkp7nLlZdueKYx3x?=
 =?us-ascii?Q?EN9yh0ocfiNGvoFNvVCGpd96Ca0hXe9fT2F5rs+lHcGCNLFvsXm4g+UJ2r1u?=
 =?us-ascii?Q?6Dh4rZYzqARt3b5nZ0SoBClCRHxP9y4HuJH9fBgpMHXcDu3RZgCLe0C3PAU6?=
 =?us-ascii?Q?Rv7rZ6cD3YK1IhRUsg6MwpMfLS7plgM0zFTzL1YH+YwSweGBc0LLhZrl33iI?=
 =?us-ascii?Q?NJtoq0Nok9og0zQR08kCeO8yw3KIaE+GDwgOC2/89En0jxeVKMEsZervYDgt?=
 =?us-ascii?Q?/cdWxuxdBCLBYim7iEdN7IXUmtkOTjYmW/vIa+gB6hOcTUDIKRNcxG11L7W7?=
 =?us-ascii?Q?gC6M8kPgXt6gTuQYkBYjs0qXTP8vIRx547XVRz2k3xkYBsNsuOPL+faq7pf0?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd34be5f-e747-4863-06eb-08dcfa4f9d75
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:31:43.1880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noTlrPPocBWf5UQyMt+oK9AlV3IQvNUy3RMATtOWdNLs6GprlV0ObRZPAsWWGGQMxeeslsVHL18+rOTOUq+Odw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10215

This adds new Broadcast Receiver tests, for a Broadcast Sink
synchronizing to 2 Broadcasters, with and without defer setup.

ISO Broadcaster Receiver2 - Success
ISO Broadcaster Receiver2 Defer - Success

This also adds emulator support for creating PA sync with
multiple trains and for sync with multiple BIGs.

This patch depends on the kernel support introduced by
https://patchwork.kernel.org/project/bluetooth/cover/20241101082339.4278-1-iulia.tanasescu@nxp.com/

Iulia Tanasescu (5):
  btdev: Add support for syncing to multiple PA trains
  btdev: Add support for syncing to multiple BIGs
  iso-tester: Fix memory leaks in iso_accept_cb
  iso-tester: Add test for Broadcast Receiver sync to 2 BIGs
  iso-tester: Add test for Broadcast Receiver Defer sync to 2 BIGs

 emulator/btdev.c   | 233 ++++++++++++++++++++++++++++++++++-----------
 tools/iso-tester.c | 177 ++++++++++++++++++++++++++--------
 2 files changed, 318 insertions(+), 92 deletions(-)


base-commit: 9e0bc3e63c924037fb483f3b1f08e5348399f8a2
-- 
2.43.0

