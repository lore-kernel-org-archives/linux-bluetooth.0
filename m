Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF8316A392
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844319; cv=fail; b=JJwIYV4pNYYkMmaWCEEeGTXVaBFfYLukDDcIFS5YIjptE2GejNA5is+xJ77gkNx3X6nKO2S/4IKA2bWKafa1LGlVf0ah5WwNRo3vX9k5xdUPAu8TYC/lGvd9Y951h5AnwZMW3QNkDTNaATFiYVtjHP3AfcScpKMZcS2hUEffzUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844319; c=relaxed/simple;
	bh=2IWcgAJ392oW1J8/RAk0QtGlA6VE+Ak4CLe9EBBQs24=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Gb3QufnViRbAxr4X0FloY1CrhLX4qAU+7JbhFIwZ1lOup/mOWCEAdKz2kSJxNiCU5s+Grtw62F7S1G7ZYnroEIJlhv3/l8waZaPleHfhY6h7gjmCmXiairIbOefRAfdHE449TGp/CZcSrresC4udR+6j8Uo+h5H4qhxgf+zSego=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=L6vQMqUu; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L6vQMqUu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5A5T8eGtqSQ1vcc5W8KAVNF803fV4jzx+87pLf8MGoZgtSDAFG3hrfFWmOe9ghfaE3Xg3e37i8GC986vKXkfD2WHnqaPLPIaNrgg3kkLVU15GbFOk9wJoN7aiegp9y/C/qmHCqKObm3308ovB/JQesgRXjlWZfh4uGX6wkXUIItTmmWDjqaBqTvd3KwU9ttP2L3ZF1OiKodXSNNi5BqFmokJLL2aytT3SDIr2ollQQ+bWtwbJKbcWE8UHTOWCvypuOl1DWx++EI3TrF5+zOZT51Wxl7Gnq1ottF+wM4vL8ocksgiYy3cNjVxrZtuUxhb6fK1oRmDkjqoHjyuZW1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcYpobg98xyXz3WqcZbTjYg9PSgBMn/Isi+0cTeDyAA=;
 b=oHiOAVHoWtLkE1oFcv9IBOi0WSg3eHicbxbiJkKvMub7TLAvkScmk5s5Pzn8rXtV5nT0HJdWLgH+KRv5H0l+rxB8twRAXcaEqdw3+lK22m3uizawB7KrqahUoQuqS0pdcPa1KI2T71uGi0rKkcmPM8hjiPD2sYlSVuvcbtlUsRmh/jNpYTxRg3VNP2lSj3StD8jyyHFjMq7INoNcv3jrXv/YnH4XtY6xwK5KZ4kpR715j5K+h0jYk47L8BtO36Q1C3PgJ9Pq5SrKyzJztOO7m8oienRJaWx9LtbWMT4ZRWaid99qzHvUJZW2XwQckHV6L7SZo78FbR/wJAPAWP415A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcYpobg98xyXz3WqcZbTjYg9PSgBMn/Isi+0cTeDyAA=;
 b=L6vQMqUume8FWy/oud9U4q6Fm0jbntw1ESz7AAfqkN1iJa4gPi3KgGw3KMpb2WnCvjHhb8eVH/N0L3cGUCi4+VblaCvJUfxI56JKlmE3YHYtrDT7R5NG4/2wRpNtvjEslx12GpC8+lvXDOkrefbedYR1754axNjoGJN+9YTzq1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8947.eurprd04.prod.outlook.com (2603:10a6:20b:42e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 14:31:54 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 14:31:54 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] doc: Add initial MediaAssistant rst
Date: Mon,  1 Jul 2024 17:31:34 +0300
Message-Id: <20240701143135.45677-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::24) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cb865f-9130-45b2-7e88-08dc99da8e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/pfuDnby/OU/czsiCeusyK5s2lGmG/b6pdbRlVXyPsgQQWXuYPybO5MIAOJt?=
 =?us-ascii?Q?fIJxuuWOO7bQ5U9eF+NFBAUDavZG82+4hidoV9qTas6dr7q8Tt2TpxBVCI2X?=
 =?us-ascii?Q?IV85IJha6aCu/G8Oc3Ez1mDviBBDky2oA1igzP3RrvuwLWMKUNJuecCD7ulo?=
 =?us-ascii?Q?tr5XAgScQh9E8avN43tIbgbegqw9MyHsf6wF8UnUR2UiAnwBhHjRWPMFTPmq?=
 =?us-ascii?Q?OSAVKdbQ7mAVfNTJg4AwFLoxltmrV1IwZmpOUsQ28TP1vAtXQzaDyKwG2P7C?=
 =?us-ascii?Q?uWgNmg301cBlOFGXgXdHWU2gtSwAFTf2DY0V2tBeKsbTfWLJwXaoDEZErkCK?=
 =?us-ascii?Q?60uF1hDdtjtTiIVdu9Y/a27BcJDvAlQHBkX8YUGaaa0pjbeKQqBCpCrW5dhk?=
 =?us-ascii?Q?09jDk+uuRfjf0M/UCiit/d7z/Zko1lVvEdT9e7XYnMvIODgo7miEkdhVGzi9?=
 =?us-ascii?Q?aZ8VGw/L/7Gmpms+j2MMPnIVvNuoRZoN/G/vnSxchIXRVe5/DyPy41N+9v7Q?=
 =?us-ascii?Q?ciJgg0s/gIP7IaRv79217wC0ShZSwAYTvRHUW+QpcellpYGnEm8tSzLQiTP3?=
 =?us-ascii?Q?JxRubYWmkJqO3rV3pcYLaKYggeZUq/zZoPq6YVi1PQtp6aOeZD+0TWdIEpR7?=
 =?us-ascii?Q?G8KJ/vRB64BzsnNG/GLp8Q+CT2Gaet4lk3KVsIUvLkWywZL/GaQxir3ussjB?=
 =?us-ascii?Q?kcycaOYShdhWnUM5zXRlpIDZCyALqGbFqCNB6e4HqXw4olLhtXMxXa72PDNu?=
 =?us-ascii?Q?8p5XKEG2RVDA4+tz43agy2mQxlZKyH5WK2L5Ufd9+/8XaGPDeAc9rsh5KmIE?=
 =?us-ascii?Q?fGVEB8Kk1yy6XWDzVRKwCAKGJ+u5BC7WBpNnCDIGlbNtXsaEPpk/c74PHYnJ?=
 =?us-ascii?Q?tN0OJdQ0ZQ3Qd+38/lpXKacJqoyH5n4Gxuu3xGZC4cCMGg+qqgUQ/CAhmvUe?=
 =?us-ascii?Q?7Yg1i8coAiZ6b3ZPhuMQY3Iinhlbvr2LjL/VFHSadbWn7CqJbHfoB9Hg7QGH?=
 =?us-ascii?Q?P2iVStQqSyJXVBmfOkXoolcRUui/2ReP38l/+e8LWJJk5C3uVxnqTYENfut5?=
 =?us-ascii?Q?GzkoG1FUzVd8JeRe0zJJGwo46tVQu2lsT1R8jtbG4lfwdHNoR7YiqZmugwK/?=
 =?us-ascii?Q?AsSU2uL/pCXLKkALPMwrF8h9I1b4GlQINsnJeHXxP6IpL1ZFclxK9Dla3GAl?=
 =?us-ascii?Q?OmigqgnImXycAcrUytyHzIfOJQfI3LSdW60lD+7UN84cyGnpuVn6yAdSDb6H?=
 =?us-ascii?Q?r4eeODTqszAg10Haf+9EekxY/4UFuzp88MIM6+gQsVeIVhWXl5hwhXVAkUwS?=
 =?us-ascii?Q?PWToo1bEMZ9q89aaH6htInTFnnetD3Fn/uyu6Ywzybpnfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hJy+nzUXWGJSLfHGyMr/N9J3ptfCHgtBpH4YvqJTlTa/DuGqewIIoiWrucUb?=
 =?us-ascii?Q?qYm0ZQd00jpp433ww+asv/HxKXRqWQTZfPsA/TFooYDgPMSbYjVSZhrmggjj?=
 =?us-ascii?Q?xtV8m5semcffzSvd63Rxhj/fTWfV4stVEdXaiBUWCa+HE7ASKv3JarA9FMIH?=
 =?us-ascii?Q?dT6OZIWgOatdjLl2ZReJtqFoLTofRX/XVZfgaoie9yLNYrcyRzWFE1w1W4Kb?=
 =?us-ascii?Q?eoWV0piGfGl6oQlIFiICOSTsqoBZyK/Y6+xZv88qR1/ZKV07/fc/No3Tw5ms?=
 =?us-ascii?Q?me6tLzjthMBORoMEjuKYBxbf5SVT3ycu1V1jM1PklRzyMocG0xrSh54e8Jf1?=
 =?us-ascii?Q?wYZq/uSvoXEXckevl58LaHiIFeAY5rSzbUO/aIYHVqkZgZg/p/36aDcI6vMl?=
 =?us-ascii?Q?GFI4KowzWQptmw99cJlodij0xAtks3YkQ6RVxbvM7w60X9W9JJ0KIk1AOeOo?=
 =?us-ascii?Q?9qKO+RsYyUtyiL1+nAMiu5KDi3ME3BN7Bh+MRPFmJp7U/zll5m3UiQzoooKA?=
 =?us-ascii?Q?i5GITMv3WVoG/mzCg23G9bw0twxGbtk822MZMCf1nDPRWFlb18zClZ5qDnqi?=
 =?us-ascii?Q?qfY2E9rr0G4Q1fL2PKR+ZFZmMs0fFbcV8VWptmp1C/wAqEwbPCdqYsWu3939?=
 =?us-ascii?Q?Wa9DSvAyCbS7O0X/8PR4hCLVc8RIF/2URCqkesV8i/3w2nHz3GxrZUN7Aow4?=
 =?us-ascii?Q?kMYXcg+TzSazbkIvYtLX6xt8xbG4gqQes+ftLJcfVpV+iJDpn8G/2ABb0ed5?=
 =?us-ascii?Q?fzcoviscdUYbXTsqVC6uetFIr8cKq9oVQ145LrvmOUSAfPPCWidkCnXV7tCE?=
 =?us-ascii?Q?Pc1wH1jSnfLVryoB3F99w/YspU0ZRs6VvLuD7ff2rHXwflMdwV8bmQqfa/ew?=
 =?us-ascii?Q?ZKZ7OabMK2BoRia2HePhOlR26IkzNDGOlRwNiu0RBwKDCk1n2xgrelSsolxy?=
 =?us-ascii?Q?MhBSOcoAt09c51sPXPahLmT+re6lTv9dOpREfBYWNLDhZpieGVmWsFD1lDuU?=
 =?us-ascii?Q?u2zp2OMyns/wqxa+3kwbpzWH51UYlfCE1e+H64lZlU5VF2GUxQ5UmhtflPNr?=
 =?us-ascii?Q?K736SY0wnV++7TUXoUKktINv+pejvUbtCqRjezzTnR02PmNbU+l/AOU0Ls8S?=
 =?us-ascii?Q?20D/xQRxMqAz4/HMtcIHIa6IiJDNZMVDAr98DdMZ4tB2kndN+Db6sJf2Hp9R?=
 =?us-ascii?Q?i2hXnwnADlxn4NuVFh354d/ZLClP3VESa7Wh2GIMesjKwuaCW+ToRZ7JgKlO?=
 =?us-ascii?Q?lqLAbdiyhBailZTPtIBCzlioG73DigbGYmSQ4K3ygK4yGDg4IK0AIGoFgPCG?=
 =?us-ascii?Q?/mTeTa2+9giZ6KFM7MUgoDzR/o2vA+xUjbVtwIhYl/6FyPVgRhw7GoBmtXil?=
 =?us-ascii?Q?RK6HuO+rGPCOwoB+fmBim7qUHrvtVA6QPnFaI6qkhKEIxsvc2sGqEFizkTCe?=
 =?us-ascii?Q?9gBCutWCL4k70POhCtTsnzY8/BTaHAIv9ouMEeRcHEzkfY4+MsiDempJFmlj?=
 =?us-ascii?Q?7XJSbRo41TfxVqncneLisK7+nGejVgSOr53M/o8GcHuF4t7lVibVI0ALpWE7?=
 =?us-ascii?Q?SuTdyGxl05LvyyZxvzmMCdkH1QfwDG+XmnE8LwzGQMU5dQq0HTLylWifNxiy?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cb865f-9130-45b2-7e88-08dc99da8e0a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 14:31:54.5485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkLwpiQ5KrkI9FVKLJywkpLd5cDuma+1g+vkL2Zyup3V0VNEZ/yoHqOC8En+vSa+VwU1K0FD0ZTJiGTnCqaQ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8947

This adds initial documentation for the MediaAssistant D-Bus API, to
be used by a Broadcast Assistant application to interract with the
BlueZ implementation (BASS Client).

Iulia Tanasescu (1):
  doc: Add initial MediaAssistant rst

 Makefile.am                      |  6 +-
 doc/org.bluez.MediaAssistant.rst | 97 ++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 3 deletions(-)
 create mode 100644 doc/org.bluez.MediaAssistant.rst


base-commit: 7e028287ae1a94b47093cfb328645ae1c74a2ea7
-- 
2.39.2

