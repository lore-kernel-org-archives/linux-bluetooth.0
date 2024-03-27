Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0512EBD8
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555828; cv=fail; b=gcjknRZ4zVukqmXC5bVmawFUUhswPvurB0fiou+MPhwLP9fV0kbk9KwiwmO3uo05PV76zZF5pvcSN52VqFQVzM+IOnwtS7EU3kDfR5raycoRfKK87/D9yRsnd0cMRA+Y4f/mX92QF/Sed2VoxFk3gISZ8A8Qgg0+q3d1KJOkvtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555828; c=relaxed/simple;
	bh=G5+h8u3ZcIOtpzOMx08v7sBarE+IhOe8WdYwEUpTwf4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sna8J3BC9CFP0OBTVjPKseSFNHhdTKoWHG7UydxsIk6lCamsrezNCUKhTNNFig4i9+eqjZBF/CFOozTWzEYdIV9N7vpWIY66xQ0RhdtDD2H2Yk1cS3wJvVBHwTUUzW9XE+gNDGBODFqKXH3ReDp5cWQHHYCSFaDSFznplIPWDOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bSURe9Px; arc=fail smtp.client-ip=40.107.13.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bSURe9Px"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8Gp+RBG76bT/3rxhix9Dk4CAVC5h3hm2lVvkrlz2S2DqY6Dn/Oj6HdlyAnaEz7USJoXOk04I51EOzF/p/E0Yevyp7FIpMciX5jxJh2RldeTYmMBK38WjSt0G0ZGGyhwRgOBR+kEzjt54LFMD7uaAfYUdPd+d2F2Q47pNwwQLzU5CXyNuCzXGGACXtpMcd5MJQsYsr2fDkjmms5z5Q4VT2oCbmUfei9Knxk9tWlATHic4op+L59w1+UmacXTZUUjH+NLBCP9vILcOud63wFA3J7imFkUuPYqQhvELyE07FBVuYLRtuAgP9T0Wb6/lJ5M0aYL9K5Qu4D1XyuYzkKujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxfPXGnOvdTwirNoKMsntUu6frKid3hwRWbI7XtSw8w=;
 b=IJTCFXRq7IlFlxuolZu0Haek9u8bWz63cwt1S2asCsoAnPbtPy3qPzC9Isj8hIh3OSCCn6Navth/cPTuq4MsxTOZiuDePzJ/MivD8Qcnga4Ow5gkLGAK72Cd4gALAPrRRkT85R8OashsppYXMAro0Fe7kMNsNlXwoxPrWvrdWT8UwLENud+HwiHitGGti/MR6DGyMq1jiSUVQG3A67qCeEJ1zq7xJUR0+vzEJY0kPTYXUUDUQ/gYqB/cg+vsjbC4gzZKbdoM4xT6aj0dACkmKqBcjr+yM4o+VWS3niAOED/5hhF2murIL+/FlRgDLkFmw/2uuSBqbhNyJz2q5neulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxfPXGnOvdTwirNoKMsntUu6frKid3hwRWbI7XtSw8w=;
 b=bSURe9PxnvjopUNr+nQfK1hADzg0hOPWvq0SIVrITIwm5YQBWoSgh93qGUJMRPyzkWynWYzJnYCV51I5zVgM8YACvHay+7xB80sBX/i1DTJyUn+/9AmmnckzeJMhoVQTZfoPWcZ6tdrcAJtZnlK+1gReCED5Qx6cxhCdbXQCUeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7648.eurprd04.prod.outlook.com (2603:10a6:102:e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 16:10:23 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%7]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 16:10:23 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/2] Remove POLLOUT check before bcast defer accept
Date: Wed, 27 Mar 2024 18:10:17 +0200
Message-Id: <20240327161019.3078-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0247.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: b79b0f58-9def-4a5b-3301-08dc4e78680f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xf9Ix11Up5iP/b7K8OKbQbeQSGeXmEX1ZlXX7yl5x8fIl+Z9/gPjKGWoQPffCH1e18YhqMTXr74JCKt49RMPc7OjD0OE+a6xqAm5km7eOrpt0ZcDlJ8zC1lO4SlV8fHIQkTp/UHsPwR1ww6giW1xjjl8NC4PIhA3luA/P1Qa5KR1oMfY5XmX62+bVC0c4jh3IGr9HeX5sZ10k2nZ6YUdSMkqMLDNKyQ8UTG/VX4wfsvfYzdNFXTLsjDFKPTOLQBAjpeQfjRq2wvFwNaCI7bZCJcKAupbaW533Jb8VqSYfvDaBLjnbYW+kpLs3xvJZhjVOJiMZhU2PTLYuBKJuyZXNkIjIT/6s6BAiJZ/vm0KAM6R3xLoRMDattz7crOpSno4QrZPPP1mkV/0noBiwRTE1JX94RfE2prSIt3qn5gWf41EjCYQ9UxAwIdD7kZFJToiy1eFBABiZoxeXoPuVDjXHcJ9+JAWHegYl9aGXTiZHIJNdvF1i7FAEzJD/9s5v90n2Z4iIVUAEUUw2LobMi+Y8uawgwxuf8yVeliONt6YP4Wo+3Zcbuw0MNpM9FTUD/xthT1NO660HFn9641n93373XW2nSRlJGBQNmuy5at/tyJY0TugYNzbqZgvUUGVKTwXBJNro3H/zliCUfKo2tZ0zh/cZvxySb7I2zxH+zNu/Ys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M2X8CdPIUBONXWzKIb7Kl/iLpGdq535NBjLqJO6WFVlWVWdwSrg2M/dre6R4?=
 =?us-ascii?Q?xicd7SgyGCcqEZezu2jLsvEF8XxAsTwQewFyipn5IECy9j7OWVuSIE6uSk79?=
 =?us-ascii?Q?jN3oxu/GR/vrpd9CrgRNtjmtEyrGRjhip2HEZXZNpBafXsuHFznNlwhLkhT4?=
 =?us-ascii?Q?7Cnh92Mv5XpeD0LrJoeUWei10wPNLWZa25U4cfUr6J1TI8QG26KmC6p0fsDz?=
 =?us-ascii?Q?GMmqkfEQTaHQiQxj7h58ObfonUGQ6mbtUeE+0dxx5jcsAMBwtZxjC3+IXKQ2?=
 =?us-ascii?Q?SIFc6Wlttj3YzAtBhfCKmNGZiN9a04er+4frFfsGNrUST5WndKnjXbldHtUK?=
 =?us-ascii?Q?jjJUmmurI7VbG6iDG07mJzc14IUx6YKDFylFRD9W6MIHqTUWN8n4yoKDYzH3?=
 =?us-ascii?Q?DcB9MdnrkOVgEn/tAcImiSAYkzNJqPGc/31JzkyxzoMvy4GvGACyR/L5TM2L?=
 =?us-ascii?Q?5GbynW5DjorP/pq8YT6lOVmJ5g4L+6UJXZWAzUtBEK3d7LCv5LASI+sKSQqz?=
 =?us-ascii?Q?8+vQ2SsiNQ5Cv0clKJ47K7qb+Y8wwg2RtFuuGDZZc5kNPh8EmLNOQ4z5ZHQN?=
 =?us-ascii?Q?lXlvYLbs1HTqmfUvMWsUtaZItM2Esl+mu79yZAcfsUNQ8ZzfQYHhdpPINRfU?=
 =?us-ascii?Q?MtKYlOg/DPBF63Kr8DuSIGBgALgftjg7YzhD9++mqR2RFj9XHSm+ZsQPMxDM?=
 =?us-ascii?Q?DLBUPa573e3BpCVXWCLKgYLt/9xbmS/daoaoKJowAj5fH3UPxTxZduz0uDc6?=
 =?us-ascii?Q?I99+5f0EWhScGp5IJb4JG86qYK/ugzc0r7luryBiswBeRNQemYEzgiRQng08?=
 =?us-ascii?Q?AYfZ7c4ntdEvwsGaVVv8APoGSrCJjbQ5iugGZF5W9Z8liBAhBlUrHcp7siTl?=
 =?us-ascii?Q?7lML7+Arf3KftzFTFqFGoSXJ1v2R3Hq5lTbA6W2hHsHH/TsMEQJbceOxnYqc?=
 =?us-ascii?Q?QQOpsp9px19s8C/mljJauBqxTJ8e8Q8ajV5SqtaGmH1U+P7kXm5+qmJesfp8?=
 =?us-ascii?Q?uezHflrxZR5HhvTCeOU6mMNi8gBE/tgY9CkesywV8nu3wz6cmR6KVcWaugox?=
 =?us-ascii?Q?8BmZCH0qP3eIVxVqEdmNGOiIRQ71ZEbKiUiMSwL5uLHmBkrgK1p7hkkxa5FP?=
 =?us-ascii?Q?s34IGdvvX2P+9rTyAMzVEX9qcH076G5cC1I8g9is7eFGBOU/Phpm3Ogyc2fQ?=
 =?us-ascii?Q?9cv4TNpc06SOqgHpAGYM2MRrIK/EslrA7n1B2cq4zdD0V6zaFd5gcuUimCq/?=
 =?us-ascii?Q?NjAsn5UgLPvaXEDYd5JNSo/SfAkmbfC2UtsYdakP6t9nD6c/mHV8+UxcGJb5?=
 =?us-ascii?Q?wPI+1FI2Ts3rXi+YoBHsc+ATOpNWSpYJFUwy8wO45jURvLsffDe33DnFFqQu?=
 =?us-ascii?Q?y4HXZq17uvX9M1V5VNDWtf5Q2P0cpOg2eqD/bZ/reNPOqlK9momARiyBeReL?=
 =?us-ascii?Q?THWqChiPU4gA28w5bg94Kf19VAyL9kwIUFvCQ2DHG0Dpr0PL4TfywVFoEb6L?=
 =?us-ascii?Q?PGXcy3oRv23yliGSVPkXIfNxguniPVYi5CzQAB+95Wtq+yDLtk6zPToYWDzO?=
 =?us-ascii?Q?5WVonMvTPHjbRWzQ2K+QYsubvvVr38iL2jVJxq+jbHdAfrozd4elBIh73/dn?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79b0f58-9def-4a5b-3301-08dc4e78680f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 16:10:22.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1QFiMvWEM3A1XVWMP6HHBLtjPreWj8eplZMzELC1H0aj4IRWTiSKVAeRWvF3ZkO6zwTi9P39A5hv+hNtBVjQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7648

This patch removes the POLLOUT check on a broadcast child socket before
calling "read" to accept defer setup. The check was inherited from
unicast, but it is unnecessary for broadcast, since the POLLOUT event
is never generated on a broadcast child socket.

Iulia Tanasescu (2):
  btio: Remove POLLOUT check from bt_io_bcast_accept
  iso-tester: Separate iso_defer_accept into dedicated functions

 btio/btio.c        | 18 +++---------------
 tools/iso-tester.c | 45 +++++++++++++++++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 25 deletions(-)


base-commit: 41d6c4e1c92fc6e0757b0f71ca5062671ff55235
-- 
2.39.2

