Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7509943179
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150597; cv=fail; b=eGigHCco4hhQdmqZWfLr0QPq2yx3wsugoo/6eadN73Q9TsuQz6VzeGbuL43Hcd6GW1oLgieImRbLODcoE5DrI3KyIsF16zX8724/j5EhSCT009N0GmN2wodcc52HqzywDxHWRMmGfbLs964eAXCfzHch73HP64YpI/91h1JeGCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150597; c=relaxed/simple;
	bh=jJx/HJ4oyiZSbsojYq9nWLI8CC0iSABsdLsiDvBv9lM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnXrJzPKa1eiNc1VMmu+ejOwrv5Rmg+TxrO5WFDUaToNLEcEZlcemLqopV2xYlineCZoe4pA0KrGPlrg4FGbRsYGXHR9fJMbjcjgfCoNVgeEmTVx8AmXSKJs3dYDL2sOS5COOdsgrYcDXbiqpwmL2MDIl0R/vE2kXgU4kqnWS90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RERrtHUV; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RERrtHUV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg2Dq7eNCOVgm4vwsQxaQW4tH1SiU7Ouu6k2wVqErYju2dPWnkRGywYnSKy3j0G1cOdLfeAYGzgWjOqepHCbi+ihmhtUEgN5GO5v0eOy/v/EkWFzgJ+BVvQMUtsDaSt4gMszmhTtyg86gKX6OO6LpqIjt2+LfCJQfC9F4c86RM/5+WBBcrqMV0Eq9Udn/79FEmTNOFZwX6dwCCi/hXDvOZzyL66AxZoxhtqr3rL2u4bJuPezVoJ9xpASVSDxj1rFC7f9TzZ4M1wF5UL3nNtVLQstyNEJJVF5WVaxi07SY6bw3HTl3e4GeZVttr9TtXq5vSd2rYhrEGM9W7yYYJ+tOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC94fB2eIIipFeark4V+xoIwA31K9XXoqF6QVedwCx0=;
 b=Qpo8h+nHpTSJeKn1AFfG3NbeUUS7eu2CLAm2y4cw8BEyz/jB91PBQVfBq5iArZLKv7jdIt694PvulmpCxw41LUpcTiND6JjuMmH7Ah8+RNHXtzVZzWwdPVruz+xvj3EJ/v8hEI2ox3Ds55UEMaq1t+qXjWKArBsh21l1N4LaHIPGgGSLg6ddSh1As+CEYqKDZkP/N+3vDzq5+HTb74fSrzwSVCsa03+sGxJz1TfjnMEM1Hsc3RnoSTc9l7nOCZ/Qr1LByQ+Ab7YfwthKaXY5pzRrUGB0URHWiodS08RZRQzNJPP2OJItLiASp7AxxDEknAVR0cMeAJVywfs0oPXyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC94fB2eIIipFeark4V+xoIwA31K9XXoqF6QVedwCx0=;
 b=RERrtHUVx0HiqtnXzf6vG1qMviYYfSEV89ROycAtPn5SevYZSW0hT618qycJe/iG/qHBghXt06ZERhhEaunkaTkq02lCkzJ7E356Y9hL0IJzlXZO4OYly1NCl1bpidcE2Ai9cQ/lfy8bAFy5Bds7LbXu9Iu9fPAfSBB1sjxmcvSB3I2rDRHtlJM+uggmVCx2fYxYi+fYOgX0VgGQAGG635e72svN5DFBSgm54VwOe6h2guPHj97eSLlFqyNpQTVGmhiKzBVs3W6Qp+E9yeXYunnGdgmtXCZfIWbgyDh6X7IGxM01L3hZa3C4vzOtg7Q5q06FQTYE851XSD7DeTAAKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Tue, 20 Aug
 2024 10:43:12 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 10:43:12 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/8] doc/media: Add Encryption and BCode fields to QoS property
Date: Tue, 20 Aug 2024 13:39:11 +0300
Message-Id: <20240820103918.24246-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
References: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAXPR04MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d427067-18be-4695-7063-08dcc104e3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D8JUnf52j+K9qOoPHr9WqToy6DdvVqfCKp5L56T5aLS5pJSiwnHB8SMJZFGF?=
 =?us-ascii?Q?wgSHH6JiO1yi/HTMhQKQWHO64G5iPR+LHEO9U69Bi+3xu71AU1lI/kFyubFy?=
 =?us-ascii?Q?Ivw39y2i/XZ7fQtrvRb7D9iC5pjqzCnmtrF2S37hJc88+mNH9v6QtkG+UVSB?=
 =?us-ascii?Q?GxxGQYnuQbVPhR+an8uU1RJe9xneZ3RDHCYFoAXv8kCBk6ZvTKssDNHkqHzZ?=
 =?us-ascii?Q?SBOciVGoFcAF/W2VH/QtWsdFHMjf0SZh2EthMFC+rzUE3GogTytOCZs5H3MS?=
 =?us-ascii?Q?54FSo8CoFx+9L5seuYQyb1wPuB+KZ+R9+G/4JGCxpn9IW2HONOfYS/FC9DLm?=
 =?us-ascii?Q?s2BHt2czKnEp2cr8RASptdLiOejajsWOyUSZce+4sk9960KkebiFlRLa954V?=
 =?us-ascii?Q?PV9LIP0/5PCFSLSaI8HunDdQJtZxehnJdNZdgtdlZQluRe45D6gHtpPd3FqR?=
 =?us-ascii?Q?wVKU14gHjfx0YVLCJhjrJpP9n1nn2lu1lbPG6ryQyEJ+jYKktFAhD/IyKdo5?=
 =?us-ascii?Q?Ba8NTcCIiFsS/HhMotigqW8X2Z0gJycy1WeYfzvKoqNItH4DRHNc1cpi82KS?=
 =?us-ascii?Q?8B4WjV4Dzy5IVPmHQmXnt0Ki281ZF9MeD7TziqVxBp6ylnGAK1juPa+C9vlT?=
 =?us-ascii?Q?JlWkRo5VmUVRqwlxMtvgCqZfrlv0nnyLZx1KBBwEUZ4LBZJs0MGo+U/p+fKw?=
 =?us-ascii?Q?mxp7xPwtShBd8TYPYdyhhsI8ITMOlQ4/yMo2hg1LtUD0R6Y5Av87hQed+Lu7?=
 =?us-ascii?Q?1KDAInBI0hl2PLqTKlumzuDaZIo9i0EDtEXgfk3ny1g7NSTZ4dyLm2ZIhd3J?=
 =?us-ascii?Q?G0TpUAiRFzUkjRPYF/kQnq+FfCBC6x6SiQZAddoWdnRUH0/t6/Mz9WqFTvjS?=
 =?us-ascii?Q?REvRb6OPvLs9AIdLrQYs7LG8Iq2GiGC/tIFIogPf8QiQL3XFHt8UOiOtWMzp?=
 =?us-ascii?Q?/cBBsMvA5Ju5RRAYXPSAW8173OLrrk7rl5XSnfGPjJMq4l3BkoriyEty9itW?=
 =?us-ascii?Q?rUS9VF6/2XAycc68CwGPWkFGBHir1KoXLVSvShdTa55afv33s+H6aL5WDu9j?=
 =?us-ascii?Q?yr12VXfy2n0eyAQr+oH81CLdgBDxc4fuvqvF1b+JYO/dDN4GnizefPEabuZz?=
 =?us-ascii?Q?QbrnjUky2GDJTcfYnDQnkFDYPnmmBmgn9ngH2Abg47APOK6Z5PjByQ74lbCQ?=
 =?us-ascii?Q?VHm/6s9ffLcpuVgSlwGHVnCEcG9/kPA5Kp/2vJBs/7yBNsdhJTm+6Y/pTcrE?=
 =?us-ascii?Q?UuVpgj763slgZBcXHFv7v+TEVEcRj8cOWnpmXFsV8i5HdTKueQN41cH0MMsg?=
 =?us-ascii?Q?4l/BPzmyUCY0ErnY8eZMAHMZdBWlCZ8qKjVZNqI5xsLJ2twEzLcNQahnz3zt?=
 =?us-ascii?Q?j5MnGysqM2yTI9V3xWdW3LuVnU7ZFedr18Fsath0BciqNm+nyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?adzmaT3pNarc86ePmt8yAHdha2RozX4cnXLz1UMBGQIUK1atxJz+3WrDl4EK?=
 =?us-ascii?Q?vlo+dZNgNHpAAdMjfA7cIIo3ob9DMWRIT045AxJgWCW/T1/yuC9GFgHWyVvM?=
 =?us-ascii?Q?3qwtDrkbNwKBJ2KFtynhJQb/037rjm7QlM04t+qZv4G60tjaQIq5ZNDpTKUy?=
 =?us-ascii?Q?JkCcGkBLxzErMVIMJzlz/Mgk+crCQbSMurn1Grx6qwq2gpP+WkafO3x0ow7F?=
 =?us-ascii?Q?Cg4ucKEWlQbLjjpREvYWJrJBGc4KR1kFtK8bn9RKcmQHF6uZ6dD3ruw5Ffjd?=
 =?us-ascii?Q?B0B8R5/azCxak3oa17ab3fPuOP1paiKMbzWVz+IOBusFs0ggqA2kHYlft6NU?=
 =?us-ascii?Q?dzjCyymm+iA2k7hGSc5Hd5uOnmqKS5wjU9ujaCqX7iz2+Mt+LlVNGpgY2/ZJ?=
 =?us-ascii?Q?RuLQCxrpuL2ZJNgaCxzDTPrmfTAF3JBSZCh2+KolSNRIE6s+pZPhmGd9d7r5?=
 =?us-ascii?Q?KCfnyRFZfywDJowS2YQCe8gcaI0WrVi7mgoaaku5728RqCGlG59ipnmOEuXj?=
 =?us-ascii?Q?W9SJf0wZf6CsoffV0tdX2HPSMgc5HuzAgI59OxCSV1HE31fi1Ti3tIFDtXwz?=
 =?us-ascii?Q?QHhLt6O/5civ//1H3oMWxD0pZqTUAESetD5fQTpEZYw5vh8QqO1YHncHXnqe?=
 =?us-ascii?Q?1zt1v2NL1bPCR3bpqnXx8YhPeD6EA5vC3VTwRFMGz5uBsnALi4znT5xmZoQA?=
 =?us-ascii?Q?RLy9rnKcURY+3nvHuUrobMMdWpcQjVHwkDO3cKRPD5nGHNHkJgEy7TUaFhqj?=
 =?us-ascii?Q?imHvMcknPFrwA2nA4JC7och+qyIjPh2dXbYq3v4l4x1MOqrx03oyIk5H1/ri?=
 =?us-ascii?Q?cb8JBHGvZcHgRyexCBoNNCfdrfIyjL16fHq8EONmPYuLVBSWZHqfKM3DVSNk?=
 =?us-ascii?Q?cUO/gExYHeoT+WrSctYaFNKuLdd/k7Zx2E1YVKsRa8g0iM8vBfIWefMz7cn6?=
 =?us-ascii?Q?uUfApH0NbrSyFvdO55d9ujH5q4AbZqUxL3p1wpAyui3npWHf67oVNlLt+QmM?=
 =?us-ascii?Q?kFmX690r6UmwGRRRhlBNkO3/Nm+WgsG73UfSsa3H2nz/wJVRH3J42fpZXvdv?=
 =?us-ascii?Q?1aZ/78/4J6X7ERqObrIBYrlcXIkZp3tkcqhMJFvqlExb2EXoktSB1xuB5ick?=
 =?us-ascii?Q?8q7UKttBVTEtKIDgYCGNbsiplR+GStaOzcWaU+haYSXn+3GdJsQ3D5+qrfxz?=
 =?us-ascii?Q?WQjsAPqd6DPmGm3G+K2GYEInCPzjCC36P3Z7N3fmkuoaQyanBIEXwh0bt/LL?=
 =?us-ascii?Q?4DQOOt8OVgu56AqW7F3dOrEv0grPZQ6Nl8ncMn1TsHYpqf3mW2Wg+zeXflk4?=
 =?us-ascii?Q?iF6PcFI0RU70hKN9Rk3cWsVM9Uz0qw/ulY8/tkHTqCFvleFXYM+lJe9+xYvf?=
 =?us-ascii?Q?5LR/8LqGV5C+aDNM53m0yWUFIEDQOrkfDcd5GHp2w0T6Pzgdniikjq3QBwEV?=
 =?us-ascii?Q?KnALyxq0RpMs1HThVZqIa2A1JjqeiviWRdeFllbPJclE2Rg3cPzhwlaRmRDc?=
 =?us-ascii?Q?bYqmnAfTIgYW4y7VQ4ktDYUUnp6I6e3vFD851N03d8WIKQfxKFONcMPWfRBb?=
 =?us-ascii?Q?6qW0y77+LotkI+7fdbhmc4tBcq6SEWXNTGwaJ1LV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d427067-18be-4695-7063-08dcc104e3ac
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:43:12.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtGQn13yNIy124kqcBaQ/7PpV1NY8wmPEaR0N7Zxr2IL4PU1XsYL765aJw+uEU9yJkIWi2Jw6TGaS4GodlW1IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641

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

