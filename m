Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2104.outbound.protection.outlook.com [40.107.22.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8A74CB36
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726825; cv=fail; b=jefKglnXu4EMEYWjZPuPvTdpZe7KOEotHl8yhvk2xsWfqeS6Pj0+C96Ev9e5RqKP/L345D6u5v0cT/IWB+sFLZFzTHSZtMb+an1VAcubAFTUor3GlndL/0THyntpT7x6b6t2Qfb0dbZ0Kiiwiz5Nn9IMo6N7dpPYjqStWphKzzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726825; c=relaxed/simple;
	bh=GQMQjLU/91kkvPWuHaUfFNfYMZjeP9D9AvOrdSZJw3s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AD4SLgjfjyWwuFAwUqbEg6Eu0B05YlgUE7SFDwKtN+lW+tyFr8u5zxB5Ishea0zI5Dehl9/5xkJkmQ2FmU6SnFefl6C9haq2uAJhCaLG3MRbJH5hBQr+3dJuh5s+SmiGwhCk+X+u8Id8dZAEIexjADFdheXiAuZBT+bdp1LbTuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CAteTng7; arc=fail smtp.client-ip=40.107.22.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CAteTng7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pzb8U+kZ6/uvzrhxUWRXU3JUIyofj1YHQ8yfEBvNr6Nls+PDphFMfLKFPHnCCDWL5oF79gAjMu2a0Tqo9MmPQXj0MX+p49zCMN3w9QT6jN0WDg5+0EVPV1/0J5yiJs5ZEFdm96D0Ku4wT+wNhSh6PFeyMRobBahEzzF8sR7eigwPh2TFiOA1gMDxrQBKunELJ2SFOafrzIUkKzTKDh6bK+gwm/VPhnEu8kdBSkScDy+O1Ye+3tALy6e+OfwrMeHtEyRc5f5sVKtNZORO8CkoYOTb0a7cdz3TLVmYceq2rdFN1IeleLAjXdzPVawiiKMcSA/EJcHY/klM9k4THA3H7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHaDb+XPg4GX4eIyiRuTFCKDqOb1+UMQ8joliqkcDRk=;
 b=MmluZVhuusdUI7zhsSQyGYrUETwTL+ZGP7EyIxnVcHfh0qpQwfhG0WuM8Eq1iNq/f7uF3KeMcRQOVPa814mkVi+cX/DD1RNKUaLQoQ5/zM2hVQmzN++MttiPYCPsx6TaxCsXEehcjsk4iayKAV4ptn14Jsqe7dSO/20QQDh1WQTkE1HyZVphpRoemJOkDT7qL1bWwW8+iK0PYlzJM3ZYE6/EvBWnAazCPTK3brjpN1bqGCsQiGsLOQ9k8ml1yVXnqRqmJa4kmr13StEUcdM3adBjUB+gNeYgTzG6W2dvkgbuperUE2GZLcgvq1bmPrtVOcmSLyXkW5ooa5Et+PaMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHaDb+XPg4GX4eIyiRuTFCKDqOb1+UMQ8joliqkcDRk=;
 b=CAteTng7EmivN837t6nCwYBcjYpGU+IS3iZlCEf+J11XVrUaYOZ4os1XTz5HBgfcR/Kw6ZGQ4p+C0Rfylt7CTxzgogEfqOs+UktSxQVAf0fKGUoR44OURPewmJiMWqi9GJzSnByTCb9ROz3BwLU1oEmbMGsahArBV2+Qu1irGVA=
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by VI2PR04MB10222.eurprd04.prod.outlook.com (2603:10a6:800:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 15:40:21 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 15:40:21 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1]  bap: Remove entry of deleted device from bcast_pa_requests queue
Date: Fri, 29 Mar 2024 17:39:59 +0200
Message-Id: <20240329154000.6056-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|VI2PR04MB10222:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wgdydlyEZhLIWTuMOVSka7/zVeBVsNDqhG+F+CK3186bIqSn2tpMaRNj1kIRGb6bxhJVgXugNwFSeZcDki8qKfUxr8t1+i3v+6DL9XFvYxvk9dnMChCLpjizoBdsX8MoQg/Y1NED1wiVdlcDXK4rDThbIT/ZOLJiFLkhwsqOz0HSuluqZy5dPPi0mBQMsYIbssGQG75Idl0oalnub/wW45f2tXisRFtVAW+FCfIhIkSE5PgcaTFGjN9ChUq8EsbJPSdCpLyBeUHsaDSnQmb9REB4Le4ks3Zvf2Zeae6v/llF9nwhWrIOqxdP47ZTOrYjc2g3NQuwzMof9oC7Qeu1AQ2MPo0PJO/USyZce8JG4nKBi5PYbR4T0GK2Y1TutDkIOmlRBaulZcXh17+Y24H8JzYtjnV+NV8f2bV3euCugadsFUb8JYSbDfLx4oWpXG0G6PG5WE1PYIGRigIjOq4A3fLCQLRDRds6UeIEXR978qq0UgC2U5KetuORfY2Euy7j/XIPX7FGFWYO+Kq1bT/uddvEB8sVAjnq+mld+vXqnlq4XeOy7CfEBq8EceOA63k4pWZRGADPvoCvC4D6hfc7lM2neMlKJp7f3auFk2Yapjy+3hVvPJT43IjWpSHoF0m9fiaNHWsfL9HY8LBJp5npdTFVSbA6uCzlHoFph3ThfugbjawTLOnjGTBd7C9GssNNMe+yTk7rx4CaXbgONXAYzVFaJ0FSOpeF7yB4mWV0mA0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bew3gzBeQ71e01irk1/MmKE1j0kAdVf2yZfTC2YVeJx87sl4r3Fv8UiSibIH?=
 =?us-ascii?Q?rYX0jNttHoCDBoaqKWjSoJBzMMfiD0VZpScKf+PzTIWs5NHOHInGjtowguBS?=
 =?us-ascii?Q?H5fY4VchK/WNUR/BL3oNVdFj7ZyMgsMAf3J7aZNT1R2gn2nmZpnNavKNLyj+?=
 =?us-ascii?Q?/icij/N3DjDleHDdE8HuqcERHHkb9WHC8dO6hC7l0QO0+STbRGEmNm/B4ygd?=
 =?us-ascii?Q?fwyK2zdl/XjiO/ZjM/Q1jd4KwdtK4YoEiOyRxJ65ri9HvlEIeh2zjmcmQSPR?=
 =?us-ascii?Q?Hav6Yp1K01Us5UHW4KpoQz+XCP3TkGcYPvOeub9L265bmyP3MjjneDFgPlAU?=
 =?us-ascii?Q?DWcN/AR64xK/NvNoEZpJb+JdhA5o8WYLbROgbxW92YYUp3TeC2ljdPnU5AVq?=
 =?us-ascii?Q?XaGw72UWiwD8NNAwYFUwbewuL5APm9S8w4/RLRS8Kk8txsTZBsBD2VAkptfS?=
 =?us-ascii?Q?FPuU3+31Z77L5ryke4/alENsUCNpkDUV2Hyj4iJvu6KQWFQ3jHN9AI4aQnId?=
 =?us-ascii?Q?bld53E0efG0GZKjDXMQ/40QMKpLOmiVWgPiF4hSod+z83KVLbwhBe9JPizk9?=
 =?us-ascii?Q?TV1S4YxJdVNQgrhlSICEcSZ1S/EuTluNSbg4YmhhnD3UYtWK95RhU31J7Pt+?=
 =?us-ascii?Q?fJuJ+wJnZZ3RFCvo7mzKUdK0oDbxLf/47CF5KUJ/vUcqUO9LUU2QEEhZdih/?=
 =?us-ascii?Q?4RiHCzDH8UlVcGJkEcpci/q3gocOfaKFTnJ1gCJsYzqyNNKRy6No3th+32Sc?=
 =?us-ascii?Q?bmtPFuA99VyhkwwrAuoxR85j9uzY8yqq18wFpYENQVilpeF+tHUNDSURjRtp?=
 =?us-ascii?Q?LxzLLVhqLkudVwX5JcXHievyNKtJP4+bc6mD/Y/GPueJ8rViXdbp1+1Y387i?=
 =?us-ascii?Q?OwvkeoSHso6jcFrkarYI6m5inly3ecrvT1lm4BRUib4RUR6JGhzTg12/vUB0?=
 =?us-ascii?Q?r05hQz1k5UVnDLcJIndlo9WCPxhHrFcWl5VBL9EHPBa315seOExF3yR/KYdt?=
 =?us-ascii?Q?o9ztdKCIJTU8BAuS9NuH8rWu6jfu2GXkGNTyb6LHxPHdEtkENpENm5xZlmeV?=
 =?us-ascii?Q?2sCHHdQCQT+oSLr8Nhf9VOaVBuX5IFkGP+j8FccBQaHp5OXSIsFZs25fejhN?=
 =?us-ascii?Q?TSABYo+Wteoak2BaMj0nf7lMpnP8l/hCM7TP+Pimc32SBZj4ZCQOmvxp3Ol5?=
 =?us-ascii?Q?E3ByEkXjbH2/IX4yfJhp2mRGmRdHvmznacoeqLXuYYCnEzeAmO0T2N458R/Y?=
 =?us-ascii?Q?9dsat7PrkDTamXwxTT508DiGAcA31V78cs8ZpnKhSrxcqnB7JmqsSGmQPS7Q?=
 =?us-ascii?Q?+vg+ENOjCHegy1TuS7kfFSlg/fIcjVaZOZ+8hzbCD97bulAZcKJ5lTxBS2Yw?=
 =?us-ascii?Q?Y9TbTKVwQldEw3VV8r8pzRyeQfBlE6TpTJhvPVcFSZb5sjlC3koQ6oBJ8Z55?=
 =?us-ascii?Q?g/smHPpBHpR6zmJtgLbMFHovQ1OzitdwlF3QpB6Wp5n909BxKzFYuRQjF1kV?=
 =?us-ascii?Q?xeGQlskSqSC6MmMlWgKI9UtecBs3CMOhgVZlQc0qkC/yE+5vXCVVSYuqY4Nn?=
 =?us-ascii?Q?swRrphFYm0Zbt4vldt0RAopVzGZhBrWvkyBQLslS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ce263b-48cc-468c-e8f8-08dc50068ac3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 15:40:20.9807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWcgmNilisyh90dB59cjiLULHbREbo6SNJdTkQvjCCcKZMANldOYyQ1d+NbFRyeQYXK0/jpI46XQ4oJ1COsd5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10222

Currently if Broadcast Source device is removed it's entry in
bcast_pa_requests remains active. Thus, if the removal is done before
short_lived_pa_sync is called, crashes such as the one listed below
can occur. This patch fixes this by removing the deleted devices
from the queue mentioned above.

==105052==ERROR: AddressSanitizer: heap-use-after-free on address
0x60400001c418 at pc 0x55775caf1846 bp 0x7ffc83d9fb90 sp 0x7ffc83d9fb80
READ of size 8 at 0x60400001c418 thread T0
0 0x55775caf1845 in btd_service_get_device src/service.c:325
1 0x55775ca03da2 in short_lived_pa_sync profiles/audio/bap.c:2693
2 0x55775ca03da2 in pa_idle_timer profiles/audio/bap.c:1996

Vlad Pruteanu (1):
  bap: Remove entry of deleted device from bcast_pa_requests queue

 profiles/audio/bap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.39.2

