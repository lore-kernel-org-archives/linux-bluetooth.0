Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105718E364
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925171; cv=fail; b=LkENkrAZm/8Cz/efDozKptBqKE5s5usegNH+tvOLNigIr2Yr5R1wxtvhVKVoNaErJV1GAVdIdX4Mx0H2MO/JVGrLWdKVp3FUnSgGeqEI+QQJDpuboJfhX5nI0hTmsfYKlzae86wZjtjLyqeHGYEw1vzEAHdN6kN21DkSqoYRdVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925171; c=relaxed/simple;
	bh=Pzu+gROpzRbssfrGnlhWMqASjJFJFEjMo3gTgOVB/ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uH5YBB+FBD3LSLfIIOO7dsPkW++SwkUVSae0LloG/axa4+MMbas0VQGNvfsTXb1Iuw4EtLIfoYgjKTVqPR0bRiDuPaj4uYcaV5SwsZgQcAvO6yVCqYvXij4dGAU8wxGpkcEJDlyzmlCQFVy8JCkgCflqsT0E8gtkP4MxUZ4KI3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UM2Zp+DN; arc=fail smtp.client-ip=40.107.105.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UM2Zp+DN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHgKtm8kcKZPO6//VT92W/oYY3QaDNzysunTIYzFR5HShzmkelPSVNEjnTLLd5gwyyRGntfl7RuR8h+1afpfVlNNK6lBFTZNAOibpLXTkX+3swxLRFtUsJL+DtZBEdw5WA1NVDrRgU7tb+R6sEfRE9NgfSOHV9bebOX5eZ58387k1Dv77+nIJI7lMLNoDf5BOkgEYyb5YJEgnFuKxWcPrTXBvOu3YQ/Qoarnmkwz/jBy3jwZ6xoez57WiPZIOhB48Evob2aQipa0vQKywkfqD1qhW2phNcSSN/uYHop60xEFSnIR/24tFwZ+1UL1a/nKuk/DseuTCN9SRfMrrRS/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/NjdNHeOpBYHMjUGREWAFxeLGDEAPTXZnS8eJbUT9Q=;
 b=dvlRBcZkAoS2SOyE+yiYtFi7jPTqCI4Y38uhar1xm2OSdZuAwKLaXZxGzvfNLtOW/PcsWRvJT4A11DrsLO75FCQ/vo6x0iyKObNI6yTkBtF3da25RaW5nzRQKAyqMsJu58V2HR11k2RmkzhKUcJXyUvQC+n/eJcHX4lp+12Fqdd+gtYQo68nc6ircRS3LYwEcjbM4sAg28CweinBivv2ryQaMx3fBrpH/BkD66pixDr2E9hQyBS7ZkrhamY2EJWSsVOrtMSpvKAanHISFBBNbvcsl0d/drOy9q7ako7P9Zo+0wMRi0SKajxiIMtGej3XK8RaVZ8zOmDKYy0vTBMOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/NjdNHeOpBYHMjUGREWAFxeLGDEAPTXZnS8eJbUT9Q=;
 b=UM2Zp+DNJ0cxvpExWb71VJWDk52bBucw7NuV9Xy9aSFAnr8xSALnPle9owYKWm2zigeF99TJs9QKXSFdts++1CdYDp7V1eE+KYbJ+sT95+F0KyCGvBYnzG0SJzBbtLIp3HScsx8dX1ZvpLiSNht7g04ro6oeC0ZxA+KYZGhDfnyvLlb3LziC/EnQ8MBnoP6eQmVFviOn/L7MdU9XMup9eYLnjTonJMp1UArQuxvSI/KsE77gO8Gup2EuAxWlbqOP7EFE8elAjGygNsFASxqjSSxNfW0DSEyIXhk7Ajt/ulvOgd6TKVw1Fu11N/z7HUZttX1E6SbitqYUjtYkB9qX4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AS8PR04MB7720.eurprd04.prod.outlook.com (2603:10a6:20b:299::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 09:52:42 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 09:52:42 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 4/8] doc/media: Make QoS property readwrite
Date: Thu, 29 Aug 2024 12:52:02 +0300
Message-Id: <20240829095206.91150-5-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1e079d39-29f9-46d9-fc81-08dcc810536f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0+1xx83RzUOqXp4DLr5dtjsU4jFdrDzMA9uhPNXyte7ai5SrBHH5Px+ppJO6?=
 =?us-ascii?Q?fDbEUs6e9HNCVeogdC5MJOugI9sO8fydpKZARNemV3zyeUJPbzTPYaiSz8wS?=
 =?us-ascii?Q?lNH3LTSPitp3uHcj+JWhL9ORvvX77BnI2v0Bv+FVuUmDBuXk1ItP4mmTsSfY?=
 =?us-ascii?Q?ttqQOFiEt6SPZSqL+NLrIvY0zTUhwZCJ8KnWzIZ2xqGnP0akK86mQnB17yw0?=
 =?us-ascii?Q?QXCPdEy91FPcryrNZER3DNitDBfXODJh1azY3v/8kMoimMZE0zZxoyLjOKET?=
 =?us-ascii?Q?3S1uwdXQDWfiGekp+opn7TAGV7T+NBULm957+gwet0fKmOEs3WLIVA24roYO?=
 =?us-ascii?Q?Un2Jl2/P9b/2CXyjxfMz1t0KWUpSYOMLfKjZLP/N6d3/w1li7D3YqO5fpSDO?=
 =?us-ascii?Q?chZnlsJdMt+hABpzCMeCBqnGyk9VCNXcWaCWTliguVnDy5iQmT1vv4vHAu6X?=
 =?us-ascii?Q?8vpjh1pgd/RgndPn1EV8Mrm37baAvNYA4iZZZ1EQVRGaov6B/BqjbwtizNZe?=
 =?us-ascii?Q?FtOgP9rngDeayvsDAERj0kmL5dcqLK2lQSPnRxDChmREzz7Sk7Qa2LZomt+n?=
 =?us-ascii?Q?iemoHfwHvxVCxxjPL29HVD1vw+xePohEbpKTSg0W/A1MQWszo1OK8rLRZbJ0?=
 =?us-ascii?Q?szQJ8sT2H2CrtufoAEVKzup/7I/LLFel+2d+V80voWKgSrBX3mHp57TsPPZZ?=
 =?us-ascii?Q?MKEm1+l64uVSGAibwFeG+AeUIowCOPvlcr/PG2pSQxdb/vHDoXmhnOjSCod6?=
 =?us-ascii?Q?9ojcmlmt8t7Fnixc8vmNjUNeT3VCFGPEF/AM8ZhO4P1W9fFc9476orlteJqH?=
 =?us-ascii?Q?43tbqmz01sb96+PY2D+AC+qjC20JDII8PNJOrZuhjN3xaopO7YMXEQHOML7o?=
 =?us-ascii?Q?AOH8FuEKJ+LYD85+H5Jz8a0OsZ35SYBPpX6t+/dEdevlWWj01m3IcPgCXU9v?=
 =?us-ascii?Q?n33nFA6ORABQOVLbFH1SqSggXh0LVb8O/TRVhsgraRz5JYw0JcwCt3mQH/hQ?=
 =?us-ascii?Q?WZM7IyHcPDC/Hv4QeNWUpSTnLcXl+Zppb0sCsH3Iaf4oHAVoZ//6B5R/GDdF?=
 =?us-ascii?Q?QFFO9JcRR1AjhovROh6N08U/fmVn/rB0M+cdZFsKd4LnZOJaRn9tebgE9CDp?=
 =?us-ascii?Q?ZIITbVZ6xe/x5NwydS+wYEcSshVX4rnYF7W9MgaItSrRw5AeU/lxwO87o27q?=
 =?us-ascii?Q?xM8/ZLqgp8lsFy7IGMnUygWTuM0TLlGIfa4w4nAn9YSMgLGvTz+wuxFbw7su?=
 =?us-ascii?Q?VkVCXvP6e0HyjgtxMDb0TJDTUB+18qvgLyuo9V29rw+zaK9F9LhcPpjJjX8W?=
 =?us-ascii?Q?FQ0Q+E24oGkA/KSGg+M33TumEuLx0V5uaQZUE+2PXL29NrtEXw+jty89sndH?=
 =?us-ascii?Q?W3yWQ8Nh09q4d7Q4+bm/RkgTGcM9nWLpAfBcW/YinxI9EhLhYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ptx2Jb3pCURSEGSE+Z+jUQbki5iCiB6ghCZNOt+qZziRaWGsZVmVt6LYdd++?=
 =?us-ascii?Q?DKyo6UpZ0p7FEqViG25+dV9UG5UVahD4PZeD9hmE6+VKcFYlKFn8xQaYLZAM?=
 =?us-ascii?Q?b2xJPkoOoX7WGsh3hUo1nCByM/Lwqp2zZEne/jdkvPLwQyS6oQVCK8eIF7Oz?=
 =?us-ascii?Q?2gyroqcryjD+ZRtMAx3RU7s0ypcY+UuUHJPLhYfj4uvXt+0I04h5/5h0yHWS?=
 =?us-ascii?Q?0TaSaEvMXW4PotAjEKtuX42AjF2F1DTV+dACI90gh+hiWbtRh19HQ7dqfMZN?=
 =?us-ascii?Q?6HeLSjFApV+EOJtnryqm3tVF3j1AqDNzfZQkVZYv/uSL1hBh9y+v5ix9rdWU?=
 =?us-ascii?Q?2JTc0ZtqjqpHQDSUoCqePo8DvNIIFcacoc2fAOr/SFwWWPopwm5PpzeDtx7H?=
 =?us-ascii?Q?eRLoW4CMvjAzrs1/pzzyEE9ICJtP2ti9cQrr6pDqn04NolSjvox8gbpnnPnL?=
 =?us-ascii?Q?1XId9O83fYEqLLTIraaTAGi6ivOA3aYrlCoJ3mfeG2L/RT3Gpu2JsSlepTNf?=
 =?us-ascii?Q?H0mnaya8luxgVfVJUDp7QJV+l9mxfI5xtNQsH5f8lFwNvR/NPh1t+BVwrxWX?=
 =?us-ascii?Q?zFVdXqei+GwiDD5XzR0tMqSA5nPyRmh/gatxA54aIbQoQ3sIJ2aHGGfH+vhG?=
 =?us-ascii?Q?NZYyGgVnfX0TKm1RKG0Is/eUV3zJxiWjzQA0OgjkbSmnZ6qWqSVsg+kGzIqW?=
 =?us-ascii?Q?hd5p6eHVYm/Evr5prOZViroMd/WPxqSw64z/Cy4dbuPZuKasGf8mw0XSiUDf?=
 =?us-ascii?Q?NacLASD05FzWrPj0wfZRix9Z+j4Of/9Kh/rlJwq9cSlKQMjH3744NYij/ngr?=
 =?us-ascii?Q?IInJR7Q88J8Nip8JSavlJ27NL/IHcQnTpY1AEeHjWtNJoPZc8jViYHNAM9th?=
 =?us-ascii?Q?eWq4OCkiIXEhaBWPIY3Q/73ZsaeEb8JSxyjqdcg7BRYWcDeD6Ih6I3HQsJso?=
 =?us-ascii?Q?apxFHDbgvl59TmDBSQQOG/APxh68PqFwWNnpekABy8+f/jofc2VqurhWhLLS?=
 =?us-ascii?Q?xMZzWciH69ssILjb6dR8tbfnbHgB+T/WlohujFZ999VwGnVtWbYIThBYLSKG?=
 =?us-ascii?Q?9u7D3HGDW5UttYdHD5B6eFy5co7CwneGhed4WK0OBB9/QaYwjzY/Z2tVWj+V?=
 =?us-ascii?Q?Q+zCCB5OjCJeAX1+RfwVHG+sQVwwBGsG4e83MYot/m4B7BgwhQieSo5pg4CI?=
 =?us-ascii?Q?IzctyemjwadMDGTm1qzndL/ZUmsZkJzuUSvQGyF3wNJWU+RoLaQ4uYVGIs1+?=
 =?us-ascii?Q?F4WgxOjbjYYEi0LyQ9wMvVG/noPd9DMZ5jOL0mKEgZGgHOGeYZV44zxIU1PA?=
 =?us-ascii?Q?ZaQsqc9Ll81ANbehylE95rmmV3CmKMEdQjAFr8Gb0qUDUJvSzVTqZkSDN8e3?=
 =?us-ascii?Q?Phdyck+uMnW5FeF5DfLsXGJYsYx0cavdcdlMYiGR2IH7Q3lQ7anwg9LhC9ow?=
 =?us-ascii?Q?y+Imfl5NAPD7Fy5YvnTjtKF8/CTHSL2kjZl9Wl5Lv1fLBCwNnCzCpU3TwP1S?=
 =?us-ascii?Q?+o7hb6IAChKAMhinRXOzh+Mj67MjDvBTQ03TMoMkdtbkWL8muiDRLHj66vWp?=
 =?us-ascii?Q?onW8kU3y0jLPHng8l0vmLTz84KtzIRKwQ/68L1o0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e079d39-29f9-46d9-fc81-08dcc810536f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:52:42.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxCEnIxpEENYEhnOGvwepFIgnU+yC8F+XJBu8ol2NG+k7uGf/v+2/imR+yq7QdFJL7ggq64mNoVMRklLnOU+aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7720

Update the QoS property to allow for write, so that fields such as
BCode can be updated.
---
 doc/org.bluez.MediaTransport.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index b53c0cd26..4d998b2a8 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -149,8 +149,8 @@ array{object} Links [readonly, optional, ISO only, experimental]
 
 	Linked transport objects which the transport is associated with.
 
-dict QoS [readonly, optional, ISO only, experimental]
-`````````````````````````````````````````````````````
+dict QoS [readwrite, optional, ISO only, experimental]
+``````````````````````````````````````````````````````
 
 	Only present when QoS is configured.
 
-- 
2.40.1

