Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944EC3C3C
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908770; cv=fail; b=L3nAEiqmFmGND9hRECV7EycOmMyNGMzxo0TNkq+fdf63rKAvGGf0D1VUiCDyAowOVzpOkNpYxU3sTzTtXz/ZoGkIvUdyUcVb4H/5kCcm0c8Zm3BFlFcUzRm/M+oT/6vNqsJhHXK/3QUQT4kFRnNjV33+5YKQ7QVF61Ozb9PyQPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908770; c=relaxed/simple;
	bh=Ry9EloPSngdimNiGH3L0DLSZNWI6aFa8JaPdJ253aC4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ckbDAWmesoalqaJZsDER2axfsD/N+iRSQAtwgpFOrZbzHly8EKaBZSitjxtskQ8eLGzvuE0UArG/Owm6niaqfQy2kNJ6zqVcDqIVt9hl/HGwwVSIYHzymuBLwH0jxCwML5vXmo1nUdhvndFRxYfUk0fH0h/IZz3nbp1MzD8vstY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=afjPSxIA; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="afjPSxIA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jg7TK/mxcXhYrYtyVzllMh7CsDbr+PuaD0hb6TcF10UswS20UBVVgyl85HczTd0qw2iBGoxo6ODi8mQ3QUv1+1xIa/dJ48v8xcqB9S4x/6T+zprLYIW85bYVEN7/VhHj97lEmj1nhM2UipdEV8mTzshNSSLy0+mnQri3Hri6WobTxgone/wUdsEpAUGdwkwiataVphadIrspXOJkMwTw2ecbSKCQm7hCnUhj684uoycIrbp/pDZ71NOTx5A6xzl47GMov0oscksEi50ZhP7njp4pnu+as7+dKT2BhUNfGH4VMoRkD7zz2k6AvLPwlpcuMUnhTi+2GXPI2ENGPrzpSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqpYmgwbAjaqKmi4tRMkFaDZ6ng2+ujzvsOcul91EuU=;
 b=n5dgh22idPsOcFlvSGgDWRa2uPXabGyRihEWnf6rJJJhkRPNVVlWnPItaXE5LQXoL9VHqnDLM30CFLKUaq+QFGsceRIaScoYVKaPDRR6JG4ZJ3Lp85qCwPO5afRanCi4FRgHj85DFzRpjWpNOPIvd5yJI95kkhH9QZf2JGKGcCDWSeaXUYM2LvMoa4eodk5mOGfq9WKGAbA7QtaeKwFaVInPsvaqXu6g17v8/+nrnn2p38AslmjFIjGl3MijqgkEz4P8PeVRcx4YbnkB3Ol1CaF6aN+jRU/mtrtuxxNHr8Ieb9N2WY+scPSsjZzBlnd3cH9dpJXA4ypMX+oUmkcuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqpYmgwbAjaqKmi4tRMkFaDZ6ng2+ujzvsOcul91EuU=;
 b=afjPSxIAiE9B1SVINDhwt2a7buJwnwt63SlpEWsG0AoCw4L9coAzwoHri857wMvMCODBC8khUZ0S0kfIEvcTGixjXjZzsBb0pA66yn31C3HZtFlNVsYWnl9to2PT1pVeTpBCvvKAfoqmVI6rUiadJqLRItX7bINDZY0TZdyqLF5oFV7HhMUuL53VI4e6qpSWA+q5w0hL0TBYGPYz06nGM+l1FI2IJ09+NpHFkfiZsomizlyu6Y731LYWGVmgqiR0snO0iAVunnxPiK6yE4an2F2vTXDnvBMUf+6R4UlCpPoAuCA8Jyt2jzWGQnYiHiFETwX2qkpHjxEKcxX2KsWXpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 11:59:25 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%2]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 11:59:25 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 0/5] Add 'broadcasting' state
Date: Thu, 25 Jul 2024 14:58:49 +0300
Message-Id: <20240725115854.234781-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PA4PR04MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: a98e6d05-a315-422b-1680-08dcaca13a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?817/Q5hWXPufn7K6nKmt2p87yJxIegwzp7K0Jir4VK7ECv/6E1QxOT40IDIT?=
 =?us-ascii?Q?tO1oi0lJbcOytg72Hb1NcrfybszrgZf34TJjy3ijXTJnZWK2heamv38W9o9q?=
 =?us-ascii?Q?mXYF9ljr3e2LNKLqdnHCCydLKJXQDMmWZLPMKZkZz+OYjmzQsjw+iKTiixTq?=
 =?us-ascii?Q?V1FZ4j03E5eGDK/qlVfwfpDYJHLPw4yAVqLSGVqc+rQv55fEJFCCmIzpbRAC?=
 =?us-ascii?Q?+QRgmZNTUmGbEFCIj++9wz5v8bazVTtOJjitM9bj+bc/LJOQEsHfo3P/ot2D?=
 =?us-ascii?Q?l18Pp0sv6ntNitrud9L6utQWk8cg6YUd1YVUJMT0a64vBb4KArz3i4Lbl79t?=
 =?us-ascii?Q?bLwEtpZdk8T5RHXHaCt6QZKZdGgwcKnSvdHWqIrTSM7qV7knGzEKmGfJbF76?=
 =?us-ascii?Q?njGizoQ0qOww+S+X7X6BczUawbSFiPb7WJa9aMnxSRR3GvCET3a2GZA5ellQ?=
 =?us-ascii?Q?WVIf5jq1iATMNlRFZ682Ynoky6OwbnFnReaiDyE3nH1MlnGCUQxQjArP4EYM?=
 =?us-ascii?Q?09Q2HM9d9tbJm2KmyHgulNlDEI5YiL/V9Vqhq06u7vTzFl9mwSX7MR04CGSu?=
 =?us-ascii?Q?/8Vox5u/WwOZ6Frp1Of1q5WOun7hgQlGlrj5KUAzXdpJosU4qpzNK0uhtrO5?=
 =?us-ascii?Q?/nt/Yl5xpZsn0ddYR823mjXZNSFSQMrVwI78l5xCAdUGdQWEJ/HKheMvaD0o?=
 =?us-ascii?Q?U0/0Er90kGJeurwyCVbGjm3146CfjbC2iSH0yd4JwyWPP7UEzjBkrHKZciD7?=
 =?us-ascii?Q?193XV3trdWNuEzML/KehTnnyb4YIv1Mj6KM0knoRPXsXphcVHLHtvxdAauFX?=
 =?us-ascii?Q?70DqJfpCkq5UR7erNQEHo9Oktx0+zi7i56AM2Crji8Vocd0Eg1fuJH+zG7Qk?=
 =?us-ascii?Q?UEW1nGpubXKWp/NgfIUGVYJIdPnilQOQxtjhlrWt8jsc0K72Wdmv6PL8roRN?=
 =?us-ascii?Q?s68J6S8H8vZg3qmzTPdLHnh5C74aHA8sn+zk3MrokMfxMexggg/2FEV5yv/4?=
 =?us-ascii?Q?V022rNA0DKZ0yEXiWGVUR9RSUdU2+Uj32ewltBGfCEoxHyOruPeegHLriut9?=
 =?us-ascii?Q?UdSc49adG1LcZyPoYekmZK44KMLLfsx7Sm9QfkBEdn4lsNVbrPyhC894HaZc?=
 =?us-ascii?Q?4sulZzrJs1uS2yBorMS2wBwDz18Ckszxu6PfVFdoYooON14EhLfpL4uc7XhP?=
 =?us-ascii?Q?O/Ke1b+vJ812Dk7yY93QCSGxIpz1ebocu6wZ46ZPZRLWTtfCjFO0GdhoA5Il?=
 =?us-ascii?Q?6uaHC7BEmuMAHGSckysDWKoCBay2RN6+sgXHhgArkhHLpPej1wc8BSkBFFdr?=
 =?us-ascii?Q?jl6z2Lv08fHIXoELU+PoomdLm+Fhezqg7bRtHNA07W9NOIAuL0Gz4uPaVEn7?=
 =?us-ascii?Q?K+PROKykt1BK6qKb3u/GbFTK6bmW9Lk3y663FFA2/8mqiNrQng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZAO12WNVPpkld/e4KCiStDxMjsw44IRsoHh/1I9XHN5qoztjQJSwdLYegE0W?=
 =?us-ascii?Q?WMaCqGSPC3THNEfaMpzlfQ6TsH3C640uFP9ZOY/tUw7n97i/PmgMXka+WKrT?=
 =?us-ascii?Q?/04N9bJffDlL35eWtZVE/k00i3SBqo2c2yCSsD68TQuLnZ8LOxCv3d5FQTW0?=
 =?us-ascii?Q?bcEyVngwx0COBNF6Ds2RA78lbQNv4ZfMCZAwSVC0div6QaiQ5ZoX2JcGYDP8?=
 =?us-ascii?Q?3phiQztCDFPxYSYILLiDgZaa06UHD4DIfzVrXV82robR06TZFDlkf+xyj7C9?=
 =?us-ascii?Q?/JgtZGXN/IJS6axBZh6Ogi3ADYcV8xMCgixesKB23EFsPU1ImESHhDyXOK0c?=
 =?us-ascii?Q?LrgDlV+hRxK2J2WqTfii+SXyTeUer8BSHMI62JdbujQdsQ4Eem5ZV6viXBKY?=
 =?us-ascii?Q?zHkc2yBPrFQTdLHa2A9o49BPj9L/beyX8BZtzKrlhnPJVVtKCBVlhx0xqArZ?=
 =?us-ascii?Q?WuZGWf2Mq03cYhLvpjKoUhygAX/GqiApsKUGCPlq0WYykffkPXUmVHXG8KQC?=
 =?us-ascii?Q?BM/mHCsJooJAZIqoJMtiUzRFz38KscvWf7EBx5xUAMpqf5nGrXluIhgjQgKL?=
 =?us-ascii?Q?8NPJ+Knw943OHbMgJ6HHVyGxLljbeHOkWweaOVasca63SEd0l+Zo4+VL4MEY?=
 =?us-ascii?Q?eF6Mg3iXaq0GaEpCHBS/JOQ9Dq91YTQu5ETxwh7GUVwq84yXcnpf7W1O9feS?=
 =?us-ascii?Q?dZeumcjYKUHuCU1kBq/5aE8M3wKrQ/ki0rZjNb9aLesqv2+9FSuFRa8G0XM5?=
 =?us-ascii?Q?DNUCgzgcMvOK8Byjv5FMJ+aAoQ4fwCUmW+l3P72OykxxcWNnG/uoAx4cCJ6K?=
 =?us-ascii?Q?oV4+XRh/MKIdU7dkkvhTUBAgtB8lX7F1g6eIGBRR2NcHUTpkJiUC2FUDWy5M?=
 =?us-ascii?Q?2pSiZuIFPJmd5L/5xp+5GmDj0P4EW3V1LVgk/1jIrQ1KPrfwmt//G4y1OOGH?=
 =?us-ascii?Q?0LJbEmHW9aklIRTXxkxNOSwi1SB1C2yjUIrksxQ9yMiUU2xf2qm8ffH3B8/0?=
 =?us-ascii?Q?DdoK5/gqJdyZlXsXDZ/rHyol+Vkb3IGvt7dl8Ygg/vP+Trvxyqc8ygjs4Iun?=
 =?us-ascii?Q?Q0pQxTkfKLTH98dryRLJgLE5fjiwqfR2xiXZAPU3PucNWQ4eqc3T79o/N7ZD?=
 =?us-ascii?Q?X1Mol21l5CO/ifiJYrAkL1cA+kNUS0cfM/7uJZk/v3JJH0o+RSQY4zGpa7bX?=
 =?us-ascii?Q?Qvt5zviJAT3OJhueMO5tdBs5ErrzqU3sN5wjO6jVvALvPdLvAmbgrUGLuAhG?=
 =?us-ascii?Q?NOBkMsroJSZCKedaUOB75vRNGS+OH/4yev360JrVSSzs2xDq5vDdkR3N6xtK?=
 =?us-ascii?Q?zteyYICDrN8iaPUL013iI5H8uiFi04edWCyRTGPl2bWwD0F6tVZhWmqEQXsX?=
 =?us-ascii?Q?NY8ffTAcrm4BXLIVjXK8C81KQVVrk0CuaC85gwbim5ZQZ5KylnXsTB9e/2wC?=
 =?us-ascii?Q?zHqK1o2h5RvImN60DyNrdpEhNWuKXihf00lws7pE35xBXMAm8Mp5qyDwR+e2?=
 =?us-ascii?Q?QfsNAsTw4eKmo8mws0wWUcmAVYGR/hcFUz4XIODHXdPLeOMuZ350IWH/L/DD?=
 =?us-ascii?Q?0zeThq+Ock2k1+U8VDfNLuxIMrboqDGsAok5N+KP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98e6d05-a315-422b-1680-08dcaca13a78
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 11:59:25.2664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jzSYlATMKZi2BZidkNUEWcegyLxFfn+bWIqfznNIXDskH0gGeHui5I6cyxFkue5WXzbp8c7PKl+dKWQT+66OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661

This series adds a new 'broadcasting' state for transports created by
the Broadcast Sink device as a result of scanning a Broadcast Source.
Such transports will remain  in the 'idle' state until the user
selects them, at which point they will be moved to 'broadcasting'.
PipeWire detects these transports and automatically acquires them.
 
The transport selection is done using the 'transport.select' method,
that this series implements. The user can thus select the BIS that
he wishes to sync to.
 
A PR has also been opened for PipeWire, I added Pauli to CC so that
he is also aware of this change.

Vlad Pruteanu (5):
  doc/media: Add 'broadcasting' state and 'Select' method
  transport: Add 'broadcasting' state
  transport: Add "select" method
  client/player: Expose transport "select" method to the user
  transport: Broadcast sink: wait for user to select transport

 client/player.c                  | 52 +++++++++++++++++++++++++++++++
 doc/org.bluez.MediaTransport.rst | 16 +++++++++-
 profiles/audio/transport.c       | 53 +++++++++++++++++++++++++++-----
 3 files changed, 112 insertions(+), 9 deletions(-)

-- 
2.40.1

