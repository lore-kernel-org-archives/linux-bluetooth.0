Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAB128DB3
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515562; cv=fail; b=miI4gf3zkUL0+8UbjjtqqLD8VExvgfwEuS5Y2A71oh+Qa93ui2H6pWi9Lh2p47dBOL5DH60x8zWDtPIdObST9oJEzM50fdENkQnxmMQqHkb697Y+oDA7nfLawjuNrNn5d8/wC2W8SHZ3W9dI8tLbEaIZrLqvaA3/ZnWIMsegRh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515562; c=relaxed/simple;
	bh=hRU8r97Bc1Xw7OMTeC6wl0RlRyyd02oXTDCHUPTvimA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OTZx+6nyOHvwl2amW7usQEWGafz6E22+rnjJgv8dnr0wWwO8DZ8s5ZcI3d3vCX3lF57oj/p7WTqx8wvZTT32G05Z1Vn8M6wWS5E7CRuRQNKzZ9wGO0/ckvFkEaRSbVJ1r7eu2z2zlKI9hO5DhwSfmk2ajXfRz0ipPHi/tIWAyDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WeKrTYiM; arc=fail smtp.client-ip=52.101.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WeKrTYiM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm9sQBvUPVeI9o/qAwpSZZQuFHTAWI2E6z361b8Q2+cAIPMQYRZMcq2Fy6cd6NqCsoRGWn0PHPt737mbxZQ1rhQ0yzPbiAntrpO6KGbFUBPS3jb0wld7Uqff3bPXPGLvISBj+x4mRir8XwMuo9ZKFM5mo/lDmHC4aYcOw1X+kNl7co9UrBTRR9dmeBDLWWdLMwtFPQHB7cNoq7MoJfC9W3tD96FoVb9aMuzjZ35AopJ6T8JQTjdRQL2O+9CvgXSUjGw5qZXyhHcbJeOQw+y94g0y8ipwlO7QzFB6nUTuQ5GRPPVmi6hSxvqI1EtKMAQM18Z6b6InNvB9mlDNt6iO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1QtmgPTSlkNzgZRnFl9/R1F/3/hB6H4NwVjYE9oMxI=;
 b=GgZO6aJq45puh2/fgZfUmn54oCarNSk+kTM1jEVeliKGcx1Jgles/qO38WqMP6JIl1yvTTWbfyeEFxPds3lmOlfoSRLl/Ug37g+OYdN0mcww6cECpyFJXG7/GdmCOh4KeFStCP5kbNWlLlGWz/YDwwJSqMOPlzlxlnhXkDNjvBQMBgIxn/CR9MVNS06X/mSiOAeHmTlUUWpG+dBu0skPgb9OHrtMNO+bO+9TdC0CvfwcloaKBdpYNkjV9fTUke5QorfO3tFkV6ZH40NVtXhb95Dr37j4dNn7rMkrVJaLoHI593dhq30lpVy2eCXVmy/M0V3tb6rj93YvPKG5A8+dVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1QtmgPTSlkNzgZRnFl9/R1F/3/hB6H4NwVjYE9oMxI=;
 b=WeKrTYiMPeWpu8jLFoG+Kyt2dR9KFB9K2JP7Sd65kx7dXvLtx8jZ82JpK4j90f6MG6nIfFlC0VllPJxAjunIprZqrltaZAsRNr3PQelkRoPNSGEttcqpL2IjfrjdM8+qOjIV0CyhaQbbQ7ofB073o3syryhBIm3epreh3Zng8+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AS4PR04MB9505.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 08:59:17 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:59:17 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] bap: Wait for BIG Info report event before creating streams
Date: Tue,  9 Jul 2024 11:59:02 +0300
Message-Id: <20240709085903.125001-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::17) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|AS4PR04MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a1df6f-64c7-40a6-f687-08dc9ff569c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z11Avje+9GmQAe1/7U0YoQkLi3K/KdQ50wEwAn/nv9SDOx9R/KIAo+WasXjQ?=
 =?us-ascii?Q?NKXsS/T+ENear1seoZHvHS56oEkLngDCdLa75IN0rBYvW5mVdAARVhjkFx00?=
 =?us-ascii?Q?eQ9rVs8WK+cmkTWzTOI31vx+kN120GJFpDKsJ6sQAkHSjEyHLx6iamHUw6B8?=
 =?us-ascii?Q?rjPfHe88lIv9o9L/rQ6vxkEJlBBIoXaPoXnt/IdPxv00SnR3v3qI6XIKntZG?=
 =?us-ascii?Q?d5xUoISKphRQd2QnFHw8+sTjMt/v5PxF98qpqzjb8y0LN5hWzBnMcMAh43aN?=
 =?us-ascii?Q?GrIRLD/HVUk2Qn45SsRfziJr/XHgM6QuSr4NI7DDLqtD4rHHNi33n+oH9sJ8?=
 =?us-ascii?Q?EC4jfpF7tC7ArReJ7iRV5v+AbF/0xC4jCU94UjPmz6cFievkT70xwF8j7qXF?=
 =?us-ascii?Q?GA5ERQZV3Y85mqo8Y4mRbrB5TJA5fuUpL0ebDcVVrxJ4+TwBI98GCWXxN6iw?=
 =?us-ascii?Q?yrEVwCpzO97ISnrd56RWhOi/hpbPZp9XTRNY97DDRKbVv7i8iZkDSLFNiAJN?=
 =?us-ascii?Q?6DWD4aHe1YJD8SEHnuEu3fR/v3l1jxIbjDUOopBZW2mDuYsYOBP/LkCFeOtR?=
 =?us-ascii?Q?X0oMda/Px5qIYe8jjPvDWhXeQAhH3AD9suWsyzJbP3pyNwCHv/490EMzp0xx?=
 =?us-ascii?Q?MFljS2cGzGOtdRS6p2D3wli6YQsDKZFMtefdgRlK71P3wCrnJsK0Lbuf4t+p?=
 =?us-ascii?Q?TIqcmOozT0HWPtUhfUw4upC+dT5uNKYcjImJZ0JxbjhacHB9oi82ygfi/wkT?=
 =?us-ascii?Q?yk9NFAybesfNn0t5ZRJ8cRyicrNe08yxDrnOQ47dfpvKqIl1WhTgNuoUKo0c?=
 =?us-ascii?Q?tRhyY2ex/ueKy07wMQxY3IWr1WKrA4x44X1H9B4JppZwbmKlMmpAjIZfCjVh?=
 =?us-ascii?Q?oL+80yW0QL/V3orvNFDmrdW3d53JLuuVljfNo+3ADfVHolVexsRT69UnYL/+?=
 =?us-ascii?Q?HJUMBliZd5uT0qA5QMBPAuMBrkDdBts+HybXc8+pLXKiLyrX2deZ9AdgcFLK?=
 =?us-ascii?Q?ssKvLysWNpaKIgE952nGhYynP8ru9g4q7v/Ku8nCb6NTW/D0aMwn8c+eeVik?=
 =?us-ascii?Q?UdOd43hqALr/pq53magmT19u5oHOcA+nmupybsv/IFXAayeZPHc1qat7FxPb?=
 =?us-ascii?Q?NQ/wShyxe9EsbjFlCcktl0/NEgf4XSYo33OzlLg50KC91UeESyouhKFxv1Yz?=
 =?us-ascii?Q?Opt0Ab0pR3HFNt9qbzwfy1VMF8d8YiC4wlWr30SpIkuobXpfeB3gOdLBgSRM?=
 =?us-ascii?Q?8eOILgx6GwZgRk8hMOTHsbDNdAKLq75LYVjn3SJqiK4hyZrSmPvLL6hFZpAU?=
 =?us-ascii?Q?NpRD1iLzCM/4ycBeWL84hUc/qweyIuX6LhNysABloggHZ0QddK0VJq1nMnDb?=
 =?us-ascii?Q?iqEOgz5pGmCwUZLkVu02qbfJCuCt2tvgzMwlciCmWxajQSb3sQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YReVRXwI5/xSbmfZcepgfrGtGVUbRdkbv5ShcT9wQmmH4n3+6xILbT4vrPvm?=
 =?us-ascii?Q?azN+CCGsfg4iIQOnlCYzY7H0QRYxr+SrNIQh8K6sulN7P+VghPU9pjV0aITL?=
 =?us-ascii?Q?tV8axPA0INopr/VxR/o2AB4x+roYzP+1UXhMbhMcBJXGjBHCdUEJ7OQQzjbh?=
 =?us-ascii?Q?wWk7jUIwxkmd9xyM80HaZiV1pj7IGXV7f7335z920MdfEeHVqcB2HCAUlEAs?=
 =?us-ascii?Q?ePRnwAnk9GByg95yC8uVsDS5AbZbBMwSbjbBFZ1+V2pc1rbP+kGhcj29M9pV?=
 =?us-ascii?Q?9EoGOVX4Q429/LKw8Z9zgDmn67AmiYmc6Zt1FAH9yB6qQHMLzmjUxGf5ruuJ?=
 =?us-ascii?Q?W0XFt1XA6kWPbqSoKfuwxSXvvLXa30rs3hu6tyFJVImPtX5Bvpg2/vIs3ZQw?=
 =?us-ascii?Q?sHC+Llbeuk466zphr9xrlXsVWPWNTQdnYhRJjPF+FcdoLrRT7tNsx7WT175V?=
 =?us-ascii?Q?9EZ9cDZsNQ4ndjQKuQpP76CIu7khvxn7guSUJxH+X5eof35zR8siudkb6mqI?=
 =?us-ascii?Q?74es6WLMY6EYm6mbbjgcRCE8GKGBfl78KWBZQauZi7I+vR0Zt3d6Nh54Mz8g?=
 =?us-ascii?Q?lMYQ1Lnbyrt/5VET9TbkIDjXOpluuwuO+dLpVfJsiAcYIcz3DcMSvnFppPii?=
 =?us-ascii?Q?xS0Ik4YxiL5CfZdkjNSEcATAocvJWBH2giuj/WO4eqDL6jmR9lVeTMOGpeT6?=
 =?us-ascii?Q?lt4aZp9G7eBOkUG5b9DQoeTbcTit7SJl/zTVmdOaNu7ilGBvrov5r1Cterp7?=
 =?us-ascii?Q?g6JybOjXWD1xL06kYqJY07CGkK87gJrOdomau/zDe2SW1HNZmDvzDRYeV+Pf?=
 =?us-ascii?Q?QgGFMUyZ+DfObvO7ZmdQk/CdhGIePXOFEzqLX2HRQT8J8GTNWAbfIXBo+Y8Z?=
 =?us-ascii?Q?doRnZb4f2KL9SkNrD9Wuk2oUX2pPAx5qbn6grFTfk6pN4SklKO8LP4lR7xHs?=
 =?us-ascii?Q?B2tOZwuk/d5lWErb5sOY/PNPF0hDVZ4posYTpiaWS6j53MX5h+AVPRDipDml?=
 =?us-ascii?Q?+RKR9hSoZtoOaXiynZzSHKEUNFRMsjdVn0bsatsbUmV7SC5KsPFNhiFrch+N?=
 =?us-ascii?Q?TKx/p2Jvv3G2aLorrl8S8CUYpZchffsJl8rWNR9bK8FFIPbUEJf+2iZr6/Al?=
 =?us-ascii?Q?Z743v19Iti4phFFXbeyx6d1k8J8Fo7sK1zbfl2t3tMr3gu8U7UqY+l5zrRjy?=
 =?us-ascii?Q?7mY+lD1jsGFLuWMhdCBgy1bpMJmqqustzGzERzhyywIU9axM8AXnwj1HsuuX?=
 =?us-ascii?Q?ma/vXcYa6YFWdrQzjTHW/53+eCYDLceDFXYmDjpebfDABI/7CNOs0Uiz0e7Z?=
 =?us-ascii?Q?OM2K2k8yzzrCv2n5r9AnjLBbWMJB4sn1WfU+D+X8tbzXtk18sLe4+e1S4CKY?=
 =?us-ascii?Q?jgqSG449XxfU+N9jpAZeRdTyfaoBVuIaPNbXM6iZZsKkqO3dFWsLs6Vod40W?=
 =?us-ascii?Q?9ph630aMiR0p4Oq9aJUORf7pYl9MhpycwAO86qQpNtd50/ANEhM5VecXefSY?=
 =?us-ascii?Q?lMLrlBkUY1kpuWqiF3OiRUv4bbK1T/qcc9RUkOYgBoG+oWVRLIOqQ1rqp673?=
 =?us-ascii?Q?db3to1fK0kllyaADOezB2Q1J522DPibF6qS78qR0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a1df6f-64c7-40a6-f687-08dc9ff569c6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:59:17.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHG+v7jA0FNZpxI+dqU846A79fpbpmXCfiUGw2qgWGXXjuu5XLFd1Qwud9LWn107xG6vPummemLaYPdHPME8rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9505

This makes it so that stream for each BIS is created after BIG
Info report is received. This ensures that when the stream is
created the encryption field is correctly set.

Vlad Pruteanu (1):
  bap: Wait for BIG Info report event before creating streams

 profiles/audio/bap.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

-- 
2.40.1

