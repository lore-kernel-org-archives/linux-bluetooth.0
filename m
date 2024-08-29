Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB218E037
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925161; cv=fail; b=XDNafNuDjiz1l4U+S7fV0Y4JwmwIv7aTutvLerewjDQyPlVaZIcaxjtYk+4MlVAB6ut5B+LxmdCcVtEJG3L8R2XWuiSgi24Sinhm1DMEV5FniluSdKqY6QGlpeuoj3RamQSrQeEg+03eyYeVJumWUWBI+DiWgT2EsweWJ+yaJnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925161; c=relaxed/simple;
	bh=jJx/HJ4oyiZSbsojYq9nWLI8CC0iSABsdLsiDvBv9lM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CLBmqxqfetmACK/KH6ZlTXGU/845SU+rWkJ0rha0adlYL2vcqcErd0OfuWEpAVnCbmgfbtx0AacgH51zd+SzSJz0j6QPQDJTo6/vTFbU1DfyndG/iypaOXagp7TdBI27IFYTKaWckPWdN2H7V04LtNQi3WUcIb21DkOf1/yfnTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MYXFzFgj; arc=fail smtp.client-ip=40.107.105.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MYXFzFgj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0Q/OfyUvDlQ+7At0p69KXDRfF/gUNAL0iHBGicYpD0VEFWB1LMj1z3Xo7zTA7P7aAG1NPf185k0yEpKhIdo1rl0BP4ITJpXi3EpzVEpiJ0xl0hkoPhcmLgHoINKpIhOnaWxF11bKycQt1qaT4qjn027LMG0OKabcPVK0egzn1xEK9URUAi5Jkpji7KwJ9Krrt5enEB5gV/ElI/P6d7/djeHbGgs0191LvcAd1yrSr5j6SEYOQR5SiKj1P9McniDKLstN4q9cyIhGjWwUq0yEYUMCdoPoklx+ttcSEtCXUy2cuYI+s6UJuPvGqL6SHtN+DyMc1Cx4NAU8dqW/vQtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC94fB2eIIipFeark4V+xoIwA31K9XXoqF6QVedwCx0=;
 b=hQLJ2TtQt8i115FzX6OhbHdrmD+4BE0R+FE4Rg+yc9hrS3gVi1YBMAfPhVqkvtn1T+JEDR6qPMUXjPo6Dw55iqbz0xObGlA1D3ZapZrJT+haTVYgcas87jl1GeGTRRpQ3uYfen5OTsSvcIjM/Zh5i3yupMYUYJOqETt27JaJjQjqfxDyY0WDgevpxmA0kAMep8vBNlgpIXudtT8rEi/zyr+yslSRyuhF0wsGi1TfU5coDiFQDw54cEjcEnDUaZb4rEoYsjkJMie3DqpVMjh+CZt8HvgPZubF+XwSNRLsNM5B9xDx9YmSgHVdE0LiAPq/YvOMcBCNhjD/mo4H9n9fWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC94fB2eIIipFeark4V+xoIwA31K9XXoqF6QVedwCx0=;
 b=MYXFzFgjWkJ1G2iubWeQIk5S46KNz0rYCZOyxCAB18Y6LJAV+/QYDzgIOFryL4oOcHXlHO2nuJbQu9nFXPbusqnNO5F6WDHlMsq+MUPgl9PgMEou9XPvQtyBxHkCvlXmy/op6JJrZVbf7QcY5AzgZlCg19Nk8wv8dhMQG1y3SQoGDdVq9qBjGOAlPkSjAj3MTrVhbijeZX0sR+NOBNqXYRwHqtUrKjRQa1PqkyPMqVdiQHqVyxfwlD+uvymHRO1nhP2g4gHH8xRXo6XPWjh3wdTomTYgmSqK+ST1JNlEbRQh0leXxFvHGCpsXDxF4RjZae/DNzklnT8ORRnRNR+MoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AS8PR04MB7720.eurprd04.prod.outlook.com (2603:10a6:20b:299::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 09:52:37 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 09:52:36 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 1/8] doc/media: Add Encryption and BCode fields to QoS property
Date: Thu, 29 Aug 2024 12:51:59 +0300
Message-Id: <20240829095206.91150-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
References: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0196.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::22) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|AS8PR04MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: b6294c98-5d84-475c-1367-08dcc8104fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r0iIuQuaeUH3FdBcKOqZcuVAlH3t7YWpxLmTo7NKkg0sgbeRpdPTI5Tr8F+/?=
 =?us-ascii?Q?pnM7aeZGpf5ZqLuUc5wHd97taOZCAKp37I6OszB8X3HCaMBBDqs7uMnSUO8Y?=
 =?us-ascii?Q?CFJKGYGvH5lH/pb9Rx9stHP2LRm2QD6HHTmcKXe/19iN7OrkfNDX/Az+uGWP?=
 =?us-ascii?Q?OkQ7RqNPx4KslZ0VG6HR65kiv1zd4NFq2szfdfzHPYpOCpL1fet/lvnBXOcl?=
 =?us-ascii?Q?Xkr6Z9Wnkrsjwa2tv5rOFHPc5L3R7Ekg/SOab2ewvhkoA/fDi0/Y2qsk6H+A?=
 =?us-ascii?Q?td9PphF5rKZ5e2nYC0Wasw0CsCvqG6dqDcXnR6yIzQ7MmYk1z4aVPyVF4ptF?=
 =?us-ascii?Q?jYceJtGESgkK8pvDIfzh/32DpwhtCZnpWmedFu+FNw9V3stI2dp0tKU08dSV?=
 =?us-ascii?Q?jKSK75xiC+hjQ//b1SC9aZzrvFVWuj8IE7PhzzhG84ckkM1+Rg0v0J3T3yHu?=
 =?us-ascii?Q?WAU3/5vy4n/kGe9TTwe+K+ZtomjVgOTQ9/ptAwiQpKAi0v/2ivk/pOgKWlkX?=
 =?us-ascii?Q?mKGTcwu2pbHXI9JIT+lon7KadwlWczhmknIY2IMms6S/muzKK92Fqg/Ll2Y1?=
 =?us-ascii?Q?GzLOB3QC7mDv6A+UO5V5ji4+sUPTgVYfMftaqc31SXhX2bm+Jd0Gf4SRCQDY?=
 =?us-ascii?Q?ChBXX7ABh4UZP3Q8de47R5si5GHqkaGAFRf1AgSyax/hasWkrws8GNa3YTMh?=
 =?us-ascii?Q?CTq6VbZunBi/MJZAGBQY1CQ9jytKw9iGR6s+UsUxjwImmIUaLmfJzRZgd8cQ?=
 =?us-ascii?Q?87LEHsmkdVhimE9jYWgHJZ9k5Ap5OFVuzq65U6l7X7jVjDAiVIjhkhKtlgbr?=
 =?us-ascii?Q?zo1pZGLRWPmJZz5C/i1EYayAa3YOV+Wq9urg85YmEgBC9ukvbnTsiVDLJwbj?=
 =?us-ascii?Q?ls1kTvaBdavsS99fyGX+OkCw36kJcYw1Hu8yZ5xB7iyxtu4mvWI89SkeV0DM?=
 =?us-ascii?Q?S6+WiP+QKW64lHIbqAUd8zYbrKq53Zo9m1uDWbtvb6PLSihi1ZS3MnM1GBMF?=
 =?us-ascii?Q?TARLHBuw0BfIFN9m9ncsZxJB3pIUygqlUCmn/KWbRv+mE7tli6XlzcjPz0N6?=
 =?us-ascii?Q?vy0Hh1x9bt3Qb9umqprGSnrgt1mv2oDoxy5XjpwkduUEjy4szXJH01HbizDe?=
 =?us-ascii?Q?MUpcNQAy8x0HGQ1+bWHMQvldUoavjWvfZz+F5Z9oqmLvoWSAyXmLgMceuYA1?=
 =?us-ascii?Q?/+dfIiX7AM1WlyKn/MjJC2xrQPfdCICuD2pft/JtGfCtGGfC2xSkzZRc5jWa?=
 =?us-ascii?Q?S7LkqEVjAMjqEwLvVV4qXpWwTPVdtx8kWnHJYtj3IISh/CdagDOUEwo4CYsh?=
 =?us-ascii?Q?KSkC8Jdh5n0xXBPEBcssxaIzyVW/LO3X9omISPGL/eROn6lF6GfHip3hFid0?=
 =?us-ascii?Q?u6wZuHR7j6ETv38pCzy94i+76inBy87iOHkusW3IGplJIkFzFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dau85gRJAhG3itS/KCR8Uv1FtEmhHi6tVGMpBgzMhBClZIcxoEleegIhsz/c?=
 =?us-ascii?Q?/uGasghvbwDl+s+AO0Uk9aP1Md+7FRvNYWx4JzZTuYKAsGBDhFM4UfQGhnJV?=
 =?us-ascii?Q?vC3kCvDDtN4hNdEtMGuPwA6eYWdFsx0/J0cNsATSDV00iY3F3XvhmSJ7e+Vb?=
 =?us-ascii?Q?XavaYoeXp4E//QY0j+nRwb0hEFRbTB0HsFeWbC3VFKMd6yzimoGu5KuIs9NL?=
 =?us-ascii?Q?Bzjd6i3ndYTPhHZQVK76EeIQhH9vL1vaSFY9rOMmeENYV5W/pyBbq0RIijI3?=
 =?us-ascii?Q?AfLO6ld5EHfA2gvaEp6Vbyik2DJaZJp9dqFGxJGrQh8z8U5c7ZA+Tda23LTl?=
 =?us-ascii?Q?DqEP9rN5Tu/8OfR3nwhKSJoGHawkxmpplZfQRSo/OdUm/FV3Xq2J7Bb9yX6S?=
 =?us-ascii?Q?KTv8Jfbp7LaIu1w4w5bAogTSeJU2IudcZqe6QEM+PYmwGNoCOuu4AsqHc6fA?=
 =?us-ascii?Q?7IcGpGhge/yuJAWR1KuUBYptH/ODE/wy9DL6+6cj9nJQ33winqF89i4TvKVH?=
 =?us-ascii?Q?n8lWl6xqxu1NdFbcT7QC9ig7Z2llGdGexazn7USRH3MbRVWnZDQmJm0P/t6x?=
 =?us-ascii?Q?bSU4yWFvhUfzzUwtSwD8LyFvr4oXqCBiHM6GIpU7CWfeOXTo0Bv1LFZ/topL?=
 =?us-ascii?Q?G5C4p1Kv7Q238Eypffy+J+ED0yysL0TjpLMX2aclLQ5j1WJS7auqS3wSLksz?=
 =?us-ascii?Q?qrfU88O/Dr70rtyP6yo3UDAkRyvEyBvj3utqfj3c0xvl220EDgDmgAAaAp/I?=
 =?us-ascii?Q?zWVSLpkO4yoUWyiOGYwDZ7V+ioax59VGsm2LfrNFbaI4axPNsBmLU+NMGHdN?=
 =?us-ascii?Q?CMI7+BpVN4BDXNr0fJzwGEopLhTFcXmRFYnV/8d4T2qRi/hWcpmBPndMGTvh?=
 =?us-ascii?Q?DmdRCfEUlW7gEms++qv5B9VywtJ3BpkXkBIfYFXs3PXuLPhYzPsKLrUupOSs?=
 =?us-ascii?Q?atIlRL5pLn06Tu1fQHVhTv1joGvGbImajhMgvfTdQBqEh3jY3x8cz32Hm+Tf?=
 =?us-ascii?Q?g0WY2S9SitWxqrrMsbcZYtOImGvE1mHLcv1yblofT4kTrHZnG0357Y0aeiP1?=
 =?us-ascii?Q?78JMS7jkMZ/EnAKf6rk5WiyDT5PopPoQBQz3j5qMuc4yWYevbu3Dgvl/B41m?=
 =?us-ascii?Q?lf/nH0RyuNgocgPXUERAl3+t/kHr3XoKtFnPmVwzz9hpvV+fMZrNU4OpVou8?=
 =?us-ascii?Q?R7hHqAknI3GJBQgiVv5+FfeNu+aXZigNQkzfw30SuR2elbPNn4WzBWpKFo5W?=
 =?us-ascii?Q?btE2E1TKdpKpX/PiA4ZYDnZ2PKbY9Yakib2qaEwe8pRJfTyUeW2XuLu6BRSO?=
 =?us-ascii?Q?WPKQFmnTqIYI3iqjfLgHNZmtOW2gS31GGznEzAbcqQpP3wP+9L2W6hMGGG9u?=
 =?us-ascii?Q?MRvwWo5fX/nAkxc+HdFYlVbn74al2uJfk7/u24UBp27ZwbJGGlw2MsE1oz9N?=
 =?us-ascii?Q?UR/9jQUj+XowspchpJjPsvma8wzsybNIh3bPFb6VEctOHPYE0UxS0S6SHGnX?=
 =?us-ascii?Q?n4fczswj9M1QucC2XoFPRp/HVtnafNiT93RsGN132hiFncZOEoOq69f6JBjl?=
 =?us-ascii?Q?y5CQwPFRhbEnHn5PSB1se2CFOFsaziUdEoDhdVmb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6294c98-5d84-475c-1367-08dcc8104fda
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:52:36.7238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wpcxJIFeC+1WPOrGa5UF1XI8UHErmLQHUbBbj1p9DNHjdF7Rv0AqKEJoGGC8tT22BGigXVg/Oyktg6n9AkFWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7720

This adds the missing QoS fields, Encryption and BCode.
---
 doc/org.bluez.MediaTransport.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index eb3e04ae2..b53c0cd26 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -242,6 +242,14 @@ dict QoS [readonly, optional, ISO only, experimental]
 
 		Indicates configured framing.
 
+	:array{byte} BCode:
+
+		Indicates the string used for encryption/decryption.
+
+	:byte encryption:
+
+		Indicates if the stream is encrypted.
+
 	:byte Options:
 
 		Indicates configured broadcast options.
-- 
2.40.1

