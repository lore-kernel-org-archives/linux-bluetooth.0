Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62912D05D
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344919; cv=fail; b=ZbYw2oiHv9gglG/p7P/4anj788R3N9a9f1RsWHDTU85Ki/oXpRpFUHpaSMUnWSXk7+MmUsiapPAihkzBFbtihhVeQbTn3z0q57GZAaxMgAVXhbJhkS0tDCpxEs5p8hNTjOqbQ/nM+p+lHUMjUx7o0OlDu8yZhwG4woAPEaVRLkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344919; c=relaxed/simple;
	bh=/hx7ZISOegEZsUaFUWVJFw6mtvE0wI4d3g0eBJ53ygM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pqNdAOANhuhoUNYx0QjW7kQbdSay+dCLIKA9L/75xVunSxdSHSu9D91bd4MWAD+QgkS0fwcVNyJZszkOEIW2fVHj3ikM+TpHSBLc8wQQS6PCQe2m3Vojh6Ai0+UJ95ayht8fMHpy9dXbs9hKElXndUoZeneYKSwe1O9IKcZ9l7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=egbWWbNq; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="egbWWbNq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9RufnY2759oZKLowVWoocwGIt/nu4PLqNkzP4T9xFvPmLmI0lx/sJtGKmrVhLFBy8hx0ZmckJ6hPiqtknGNqdkshYxKO0QBvcQWxuxuDv3HAdWFbOsn5HO5smJArgrUNWbFx5eV6hc+1eg6J/ImjNY0igAlvZiI7J/ON1zqWohD8ugrI04OVawhMid4uwRan4WHixA3e7mCsuVUeIvc5w1ap4W5QaVXDbXQGUEny6jnpR8L3picUgya/7LuEu1gWRRGKKvREHApAPDIjnbdueN59BEBvnWV7mkZLR+1hnf5U5y0YbXQsojq9X1UZTZZKBQJ4mxSDQGCWidkzlGksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqsxrNcgQE7NAo52UFrnM3JQuwMs564JBweaORdV7pA=;
 b=FsW1rRUlxUJAgP3NFoRgPomVY4Dd9ijFZyFq9X+vIseBIf895lNH2XaWHUrS99O+KfBJ02Kdxsx849FBZDcOzixrU0g5YssRBG7mjO5Kt6BRq95CdwX8ZLuyFJD2jTcZuueRlTagIsmEwmwdLX/myPcKYTv8uby/geuVvhl0ugltCQNOwq5unqbMQF9q3Vj2g5UoijhEsBJBSWzJAg+ov+D9Vi7DQxNqwI00ZoOXwlzHBUSbR1WzbtdLM51SlA8fCiqL4HjVHKYTIskUYIIWekfFGMgiCQjDOEeoVJ+YSVeGoLsn+t/I5+w6+17My73tK0+ocADdKwO9GidYpkWr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqsxrNcgQE7NAo52UFrnM3JQuwMs564JBweaORdV7pA=;
 b=egbWWbNqd0S2X2eMX/VYV983GiiOGqtRHCqcoApSLqvzW0UjeZXwEyOvWm5XLta6tl1X2fRViwiBcTpKjy7+8lY1pQi7VxMA0qwa91B1PSSFW94HT1CCAxP+xqOpCn95nTlPMDg1Cj5/V2S8lflwuvAJcGyCyGbSwwRc1SPll2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AS8PR04MB9141.eurprd04.prod.outlook.com (2603:10a6:20b:448::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Mon, 19 Feb
 2024 12:15:14 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 12:15:14 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v3 0/4] Update Sink BASE management
Date: Mon, 19 Feb 2024 14:15:05 +0200
Message-Id: <20240219121509.5702-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0026.eurprd07.prod.outlook.com
 (2603:10a6:205:1::39) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AS8PR04MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: daeaf2c7-807e-433c-5cfb-08dc31446d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kbhXOA4aTm8ait7h4hRHqmnUx3hWYE6eUOmU98C47TX6k4hk3/KBKw4krnmc2KWNf/DJEeyLGjDV4MXfPy8xQvq56lY2IUrszjW3sM2XHOwjtYAA1LAwIhWEEGkOPJ/TbDZA78X/SU97pDYtPeEyCJDPe0uv4p37wy2Ij2RA0i5gqy68zuIvpXiQGWN57K4d/utl8zTvhIdLUrnHOtaHjAoHX/Hw9x2Ycf7wYRbRqdCsaPJ0k/xwsVkcAH6sAeo7SeJDoudJ75HyTLorAKTHKA5fn0gAjcKQfolBGF/QNCbKOBwKWJm2Ak6vEJBaQZCBeiGEvU1QQ2KJnEreTLo6kb1ldbq6UXDqM6JRPCP6e5RlLxGxAuwSyF543eJohR88pJzwQ14lemw73DZMkx8HjbgEW3ZneFsDDC3Rj1lamLzIU+DL3952prY2/PNJHmzxiH3rnXEHu47d7kOrry2fSUf5Wkp7MEDvW6kKfgWsgQYOGY1h4ZfDUHBaNUYP45+d3WOW0AKLVricQhVQV98+8skZ9lSXTE0p3ay38EbewPE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1eIyUch+kWgOME/GZFGONNmliZgdq06CJROL2hNABKoB5Fp5mrkbAc2GlaO6?=
 =?us-ascii?Q?wNHLF0JDTDJnS3VGRkO85ElhreZXElZcDu25CrVER8tPJDB//SE/zCLCCoQw?=
 =?us-ascii?Q?X6JBRzmlrMKvWKydl7Q6++S9v0pgTKtU9Ii+tMOyQOqmWBvhnUpYhSoM7HSY?=
 =?us-ascii?Q?LCb3q840cYCseERC4IFcdtOXGz4b+M5WwlwZkPvP//TFo29qyo3S6kheBPn+?=
 =?us-ascii?Q?QTlberj7YLm+gsFeph3uuA2DUaeMbAl8ZZL1oXawQhpQYV3Le3h9ilJw5jj6?=
 =?us-ascii?Q?VRz1khG3x3OtJx49xPy5ceVboI4TRQXzt4+yoFuvMfziQJUw+Hepd90wyTdg?=
 =?us-ascii?Q?8u6uUeUrUOx9QHcnl25cUOo+KgXGLgd7FNaAhleJ+AVU77AGM/smEQiTiov8?=
 =?us-ascii?Q?0KPAwS6jpuxUx3Hpx0/Hf70z7JwBBxxcIgOBDxVIGBtTW2wdH0mGNRiLclhg?=
 =?us-ascii?Q?ZJpSodfx32CFoA5D7Px10l82FxhzGJODvCyTClDEMnX4oNthRYfi6Z3aZpvl?=
 =?us-ascii?Q?9KTJtjJebCM/e2enSgHTlwRgssxXMTA3ShZNbBJK2XZtiVKHYp40NMVnY1Y9?=
 =?us-ascii?Q?Q81/7zrSspk26uzVbCxcXhzdB1I5iknaaAHnCg/S43lYH7wPGLQPM8q2Ib2W?=
 =?us-ascii?Q?ADPSpQEIbWVGqSGWWgvXOOwbuNnYatN0cpedMDc2PCiafTK1b4T4CKkP2ZkK?=
 =?us-ascii?Q?tt2sEJH4Tb7fyAtCF3k1Y0gXE3skcZSFXPSMvVsKsl9hkZ7/UJsIwmO4rLVX?=
 =?us-ascii?Q?Y4XlUVt7njd/zIcSzkYS5yVVlMLP7WAlWRTl601MWbhfcgghi06ueWvRuts0?=
 =?us-ascii?Q?BFL39ib3VEZ2bcw3vNbnfVxqQ3I2b11Ylu/N4Tp1r5AERtx/5APjTJ/zK6Xo?=
 =?us-ascii?Q?HJc7xt/qk9QzbkU7rCXzYIHuqsGbynMiTTiQyCnJR72D0FUqak4DqLUK86yx?=
 =?us-ascii?Q?nEf+lkRPktR438lD5+Gx8F24NItGIz9XTOEQ46QtGz/HaRAU2Fjw/+/WjFY3?=
 =?us-ascii?Q?iEcSklyUtS1tPEhz5Tu6/FY2zYdYjjHubNTNBVvtcrSM2eEaMIYfRWFPTsgc?=
 =?us-ascii?Q?Hh/X6068hbweza9xUSMLW82guBf0vR80sDyOyiIQSUmxGYNA0Gkd2SHG5C1F?=
 =?us-ascii?Q?4epebqPHEdzj+f5lySXqkSbh47uP9h8dlc6clhTyvCalo6MLRkRXHAB8uEOF?=
 =?us-ascii?Q?PhttFX8lbM5Os7ud/mIVJZR5p46Cr2Et041F79btUon2vsUHUraRrnoX2uua?=
 =?us-ascii?Q?knmNQnCOiVzZRwvyzvN7vUbukm7yBGs3DeqNP7s9lPOJ01P8oeyizqzAL2lY?=
 =?us-ascii?Q?05ZQepiz1FuMsOwHcld3kdtRLBGHetvH515eZsrUdWNkIYsMXGYsDn6rWb+W?=
 =?us-ascii?Q?uHq4F7AhDrcWkD0zU58U78cEmzzX7V510HyyOSoxVR7gl18AMi79G6rUoV2d?=
 =?us-ascii?Q?x54ruhlcd6a+GSD42Z397FfY6oho2ctXbqE/ljUExq2bDjD/wXHuAwd9+HgD?=
 =?us-ascii?Q?AvJ2adAG1MQLwLWKVBtLaOv8hHQK+HKzpqnqLX4hh66c/P9mHd1QdzyL1TVg?=
 =?us-ascii?Q?Vvno/N8vPiDCP16og7uVA72FhcCEWastGaoYFSpdUM9pQ/pMmXdAkAUYBAHc?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daeaf2c7-807e-433c-5cfb-08dc31446d67
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:15:14.4400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syLgpiesVniclxedffE0GX+E0kLxXMH3P9+OsKb402KKohzhGgazeQ4C+zfQtO/vSojcHYhcW6ODfvmuWqzCGqktDtDR85JlRDIIv3IfVsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9141


This patch refactors the flow for the BAP Broadcast Sink.
After discovering a new Broadcast Source a short PA Sync will be tried.
Depending on the BASE information present in the PA and the local PACS 
capabilities of the Sink, one remote media endpoint will be created for 
each compatible BIS.
Configuring one of these endpoints results in creating a stream and a 
media transport for the corresponding BIS.

Idle timer.
This patch introduces an idle timer, responsible for processing PA Sync
requests. One request is possible at a time. When a broadcast source is
discovered a new request for short PA sync is enqueued. Also, when a
SetConfiguration is requested for an existing BAP broadcast source
endpoint another request is enqueued.
The timer runs periodically and peeks for requests. In case there is no 
request in progress the timer marks the already peeked request to 
pending and starts processing it. When the request is completed, it is 
removed from the timer's queue, so that the next request can be 
processed.

Andrei Istodorescu (4):
  shared/bap: Add API to convert BASE into bt_bap_base queue
  shared/bap: Add API to convert parsed BASE into pac data
  shared/bap: Add Broadcast QOS copy functions
  bap: Do PA Sync for each BAP Broadcast source discovered

 profiles/audio/bap.c | 546 +++++++++++++++++++++++-------------------
 src/shared/bap.c     | 552 +++++++++++++++++++++++++++++++++++++++----
 src/shared/bap.h     |  38 ++-
 3 files changed, 839 insertions(+), 297 deletions(-)

-- 
2.40.1

