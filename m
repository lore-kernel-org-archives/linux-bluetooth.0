Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE3317623E
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988642; cv=fail; b=PwlRVgXqMN4cB4+LigKSs0u/TWFaglF7OyDdOV0pGH0vA4EuGwkFIYCxXuObxUlvjbtGrOq5CVYZUA5lwSX6tQDJiM/inUi0w1faD2DkItGdLumKBYA0Nrpcw9G+abpDj2jFGF8vaXrn6tebR0440+pyZzJjxRtwQGEXj2EGkvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988642; c=relaxed/simple;
	bh=BqLbTYKqcDLot7E3oex6L55d+zLEnW3/HKvcqsjnajw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sXO8uRAcAbTVTHaPAlMqVFYvfPTShDpcu4NJayHKCwCTQZoXP2uNWvppDdF0q/zhfCE+NdM2/YJW5xcn7kSCsAR+zu/iAZ3JeQZCOwx47PZZXdXG0G0IDCLnRBXOQ0VNCxAJ6q8mumSlYvp9iagRTUnpEBMb/NsTx+/t3DF59Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TY4hhL1F; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TY4hhL1F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcsUnMUgFjetFI6erw1W0xyOci3xWdpBGUy8kPFYSyEvo1C0f787r2ITnfXK7Ypbo/p+8g/9OA65L8jcuU4bSqZAL8GdGMZRdcFvZD6bRuuBEDZSfjbr5OxhhFXoSMuhzITLiaf5E0qpciACg7D8Bfm57Qtoq3+3tkxRDd5d1Guir5GFcsxLjorqsacF4m2CJi3Zg/cWjE4I83rcMqGXUZiOsZlwkxeyMSvEQ/TzSVcX5YC2gAgjaRG7Xj7PAdPFMIr9NxKCsq5h25RaRcdI5XnQvGCkKOronqIjXfXPcf+vlCDGNBdKVa0qFiBU/O4Hhrcg+rKAbIoaj6UW9j8PPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kLPQI19knCv6npzsDQFRy4oawArFq7KJYWh37GLexU=;
 b=I5a7jn7lLehHXR27EM+nrRKwiRewbJs5H+Ev+JFfdq0WBwenjPikJ/rCdfgQDUrqhJWLmn3JowU1Mbv2FFhHYRQIeoy9VbpdW2iK5dyLSdngnW78r8btBubfz2rTmHev40llgnH/KRqcan5i3hAAC6oa8K0diWru4WTd6FC95EDEB+WhfJN3bRdGF6AHWsOVxmqwx3Z+iCNuml4OKv2vLb4NuDX7gFX05erbQfhfMoDBVk8P4UQYilybW0Q3NV6GztWLTSAyVLl91+lL24Q0+9HxdQ6W77OcycByRrbx6pZiUfr+Ty3W+p/RzKzk22niUSNxKj0AlR7Xq8lk03N8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kLPQI19knCv6npzsDQFRy4oawArFq7KJYWh37GLexU=;
 b=TY4hhL1Fpk3BfOror/GZM5n/EbOnGUHnnaVRhqqMloomu2lqD62wO4rwUOtSfBGp+Lj+v8hUDMfuhOtu8jvJqBookaj3d2rZGE7+oN8bjqsSeXvNKjwQTI9wQPLQh3bJYgsHYkehYhcFAk2N3Yy9Gg1ArLu1tlonSUi+xXOSTwo3HV1CEV/qzmhlsv0W98kiC0QhqPpO6Y9vI9eXJ+W8tVM4shHqTJL/AeVqnucBEOUYOE3YH7Uhl2SkSxGz6anqqLo3xpsz2oS22cWNZOO0astV8kMjU7FGDMfw9QMOYYAmpgHrBfSdi0irXGloUKb0eA9A3YeCyDE1D+hqD/xoKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PA4PR04MB7887.eurprd04.prod.outlook.com (2603:10a6:102:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 10:10:36 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 10:10:36 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] bap: Update default sync_factor
Date: Fri, 26 Jul 2024 13:10:14 +0300
Message-Id: <20240726101015.263668-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PA4PR04MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: a69cdcbc-08bc-4551-578b-08dcad5b3189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h0sy7ISxW07TtcQxLz97LhsXxqqLgxiGrKxdvkRF0EeYwSpuBlXCJWhNfixF?=
 =?us-ascii?Q?4efLm4Hs3YjgsVmfGiVbC/2ZopkHYyNXmXPEMPTFhUAC+0tDX/vFzBB3PGus?=
 =?us-ascii?Q?GTYkexj3dGLeTkC3J+XiiYkLTD2IpwPxINwpEsYQc9EmK4W0dlxu+HHIKYOP?=
 =?us-ascii?Q?Vc/g6CMEzef4qWj86RQhVjrmHwVQ6lOyFbeyShPYSJwPRqU9es2pQn5CB8kg?=
 =?us-ascii?Q?yLiM87JNnKGUIISiE0jTBbVYZGdpeA2V50W7hStKTR2Pn+rlquirOl0tpauF?=
 =?us-ascii?Q?sxc+G3YKA5/BMqkJJrQBO6tWGlzGfUYxMWSJXtJGfwg0jFn+b/SQxVztAnD2?=
 =?us-ascii?Q?WCXXutZQWlnH2swIqkKZaESVpyPbsUCqg8vI5YRKPeEi6f3yu5+qOGSKvn3O?=
 =?us-ascii?Q?SS8kGRWL/iWXTw59dpvJYnjiZV+g+W8u8IHtvI9YBBS5u76uDhTg9otSGxyT?=
 =?us-ascii?Q?rTvcJKROGGvkU+ojA29jAksBhTtzYGrjeAFLHSHW8RG68RHRcfoWNACeybbE?=
 =?us-ascii?Q?+OL/Y86VF32O5YWbqP63j+2+5IcoHVr5dLlKTUKCrYatvL0eRySzZso+Ox0h?=
 =?us-ascii?Q?5pAa9cLf9uvcvBYQmib5WkaFPW3afvsgNfI15Cljpm+NDuQ0vEzkucdRVcwg?=
 =?us-ascii?Q?dYnNH9W64F4WeLWPyd28kDFbK8wqnFiw5sX0a+Q5N9gdzwOR93ipSluq+ye/?=
 =?us-ascii?Q?DQCS3+ZfU3XoQunJt3L8OVepvGCcs/iOSNTG7Z4EQT2dIJnIOi1LDuznsnJc?=
 =?us-ascii?Q?4DNhDPq84UKsJGsBTZ7xrT19CAvQ5vuZjBb1Ifsa49Ml4AjvkM95Z2pLiOUE?=
 =?us-ascii?Q?PUCMMykeW+Lw/cSUcZGXqE7kxHI63P2hveXyvIedm/n0Wf+ZGmPw8FAJ7/wy?=
 =?us-ascii?Q?vgUmCZFK+I2TErGSPk9dsl1girAdurZ4HzinWgEwbc57JLpEkzY+ktYWjncb?=
 =?us-ascii?Q?XxILC01oEc5yHW2usjGSlPmqC5Avw2ni+/lPUzx0CSz8P5zQ7A4WgAEW5EWz?=
 =?us-ascii?Q?TbNxu9QNGdiiG9w5MXSNVrvc/Ed2lXOMicHkIREfptgtQCHMV5ScLjmfgFcN?=
 =?us-ascii?Q?0q9fYG/EgrWdJE7u9EreQkUPwQ+PdqBwLywUOScsTLNelP+4d1FebJRivcTz?=
 =?us-ascii?Q?kuoJbMljMDQuMqFiBUOh1q3SVnqLsr4kcTNvqlbnvUtSOMizM4yuCZnu0Uhj?=
 =?us-ascii?Q?4zLmfWCWTOcQy5CCdX+U+uQzCjB4dPWewJBMGJ8NM1Yuv1cugri0gfaxUW9e?=
 =?us-ascii?Q?P+I20Ld9MphPiZWrjXVRazzMHScKUbgxa0IIpd5EApU99hItPOl1AR1S6YtP?=
 =?us-ascii?Q?0+du1liJMkQnDsmMh8I2fFTcXAO6q1p6KccGsPgmdFWZiZbum1l2Gfh9rq/j?=
 =?us-ascii?Q?GMFxI2JTOcIvIusPTZ/WWmapOnzLKq6asdmy2cRkYVcSRy+9OQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZzTTN4JyV6AQKlr4H718GL3JsSfm2BNDzs0TadZTM+gKIGitm8c7QjWMN+Pt?=
 =?us-ascii?Q?NnZQa/m/jiZrEJVyTDBt4M3zweQVL/o0BrKMt36bB5hCgA5VSJu3rDgscOtw?=
 =?us-ascii?Q?erH2d0OCgztSdqiJp9QSYeZIrcNATOWwWTL6S4THs+XFTrx7BVgZeMAr8wTo?=
 =?us-ascii?Q?2Qpl+fV23W9SHDSTCbZax0ATI9n9ZC9TPNkjmBiB5x5DiU/BbkJL/LyAbVGo?=
 =?us-ascii?Q?tdvEpN13HmkYpRqe7z/uGPg2nV21nsiTZFUMnx20YAoohq1RaWMOVcvfDGgF?=
 =?us-ascii?Q?wjYLxHeql/fCop9ZUT+sTRLvXjNuhRsK3MWkw8kRmAcD/B6CAQwUjLW2jOwy?=
 =?us-ascii?Q?Bp9VSwg/u4eGw05QqM/yH6Nwu9fXQqMy4ZaljlRBTwiWFrTIC2BJ6tcb0kLt?=
 =?us-ascii?Q?cVdzEFIzFt6MREEf0DpD3nbfoerxkmtcxOXynP2aRLxkM9JFoRLg9C4gxbQs?=
 =?us-ascii?Q?N18LasE3/+qQdE7e1PeLyFLtSbjZxpc1xD1WIFZEU8y7GLVAMdPBBbED9sNB?=
 =?us-ascii?Q?YOicn45vp0yWIhzuWNB+ma1V58XJnCuzztqFxwiO6f4q7/A+a/IfyRYA9DEa?=
 =?us-ascii?Q?igJZW06uGDyBJAGQxIOGe5Xp6dU8rtNcsfe13LAgwVp0lH/IX5MICF7IOyif?=
 =?us-ascii?Q?WNxdUbW0F21DgU1+4GXa6hCZaJxI+1HEtgWm6Nxxfr61Edh0o+tOIFWOkmWM?=
 =?us-ascii?Q?LKsKYEiCC7Gnf3dyhVfke5AdpDE34+O2wZJb/t/r0Tjkqyoznj+eezDImCT1?=
 =?us-ascii?Q?rQdRZxUvzTekZW4lFnNbMXl5VX+bnYNToD4VlICZA3schyInfiMnkO9/Xzk+?=
 =?us-ascii?Q?4e9HMEDD3CwsMauMrhEUod4oKBr9f3LpKoZe/A46l44RHCx9Yc/WNkTXaKzx?=
 =?us-ascii?Q?KiB4ELHBfaGm3y7sSxFcNqdylOR60u5MCnQ2XXzO+/TPDCKUzOAkqaMqUmL1?=
 =?us-ascii?Q?CgeFZL3nqSECxQZKWTBtuRUSEoxmkaUk11rvrueETu21cQMJNR1+bNEmDuOG?=
 =?us-ascii?Q?apwRFDdGmpmkxgtUfzUhQqfbsF9WZQeenql31mFwzpO71MgE27W25n7fHVAp?=
 =?us-ascii?Q?LTLEs26V7aQLeZBIvCyFWl1cZ4Ig9Ff8G4/7aQ5fzSMDI0UfdgsogATS/EMt?=
 =?us-ascii?Q?bOAVCns5+BGEaMp5kpUAeHr1vXYtUi5DnRpITLxO4l2ZRxQ+l2TaEwfqai8+?=
 =?us-ascii?Q?LhnAwnSDergNqFdTVEOu9x+gMJ+sObQCHbWoxqjNO4AZa4hGZplGmdl3SlBy?=
 =?us-ascii?Q?jzhU+AY6HzN0CBntzG29qLQfvBtT0V/1TLE1BcVE7rSRI/4tV/cn/TH0IW+1?=
 =?us-ascii?Q?0TS+pbiR0jJsepekfVF6CFCIjFCUSvxeTMCYiPp2bwfE5bsFZqwMGIsJDRMO?=
 =?us-ascii?Q?+hnX/9jZSVFbsO1R9Esjy8ckAnprbY542vl/NODa6vvf6zqvDgO23Msu3cEy?=
 =?us-ascii?Q?6OUaWdv5zj62jZUmFzi/AueoJrakYbZveJtQdKmF7HniqXS/MdtD/VK1apXd?=
 =?us-ascii?Q?Xjl5Gxjsm25PMreK0bG2DD+1QLbbIQTIX6/QronKLSLly7j24MMPGFxtRILn?=
 =?us-ascii?Q?R/K6qbRa1brlTD4uYd6QE3kYjR60gwpWgArR5oO5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69cdcbc-08bc-4551-578b-08dcad5b3189
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 10:10:36.6675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15N5uaeXHcgQCqTghSi3i8rfOdtSQpfvd7zzMFd8dVgosg34pmTdL3NyoEuOS/dNE5oDXBcb/XFrjn7Xyqnq1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7887

Formula for extended advertising interval set by kernel for Bcast:

interval = (qos->bcast.out.interval / 1250) * qos->bcast.sync_factor;
sync_interval = interval * 4;

According to CORE SPECIFICATION Version 5.4 | Vol 4, Part E page 2451,
the extended advertising interval should be at least 0x20 (32). Thus,
interval should be at least 8. If qos->bcast.out.interval = 7500,
it follows that the sync_factor should be at least 2.

Vlad Pruteanu (1):
  bap: Update default sync_factor

 profiles/audio/bap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.40.1

