Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A813BACC
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372822; cv=fail; b=eQVz3oBVQt1J/hCcjQzNsiZAPEII5at0IED8jkZ+irQ7gNbK0cGb4AM5NdN7PTuKdmEaFxymF6gmenDOrb+OnYI+att0c48POKTzc/SalAXfSzpdRLtojGRv3JtJs1YyyzrdIwajZSfQ3W5siYrsQcYcvnraQ+QeApNKtg6YzU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372822; c=relaxed/simple;
	bh=L3grQiVIS9vlb9NWLFRdIGkpwCC3HB2GhTbEWkwLmsM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OZTwSJspKSS3xjQAz5nob8lGYx9n/1INBUdOjVGgmL3WH3MmYyuywbJAPsw7ZZDIeGZZV+OrbyvkJsp74larNqDBhqG+X06zlQee5LBYsUBaK8HaEdrA9WOmWjolIO3LQ+IabgpV2tzKRe0naLcv3MZTjMovNR5LcsYSu2PQGVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sj1Q05bR; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sj1Q05bR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cr29r4cfs0DFQQxx8iy+CUMBY9u+6VA/HNEgv+SqzFtXyixw9YOeYWEyxPltbobM/daTCsiz6Sok7sHjsradfhMUcYOJcTAazlH83p7nIRgtP07pNu4bG2Ecko8Eo5Tzuc3+M6GYiiL6ZA0Ze8GKxXyRgW6+iFlD/d6RIDoZbs2YjCZA2ympw22ELkUWKVrmX2mz9lJnq3N1JdOglkrI8UuAB39yXI1vyFUT2mQ5YuH+h8Dtlt/5oN1oAYdvr+yPQBAkNTcC09VUiXDWpLPthbsYaXvfIbMQK1y26XbQ+h+gLBwPrMVT4iOKDMXxYQ05Y8zGGZNHH4PQEeeNSaaVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=br4K8DduEb/7waohFEDJ5bWvCsPHZr7NrnOBb+Hy9dw=;
 b=oV5fDtLOjuXMUEdZn1V3JuDOLHWT0aOPx2x3qfPmSCcv6VMzjcrnNYK3Zgut7aDo8OhzqzH8wItzqKvUtDIrLSZOILp/ZMul0ALViibhtbUruAIEdIQDCct3HRRSZuCvwUzt2sgXDslfb+IaAMDh3T3SHi0niXiwSLCAZ5qKkigWTWTElo/fKFOIZhZpUlQ3pH5HD13bla9kEVx+nXvjZHcHGWkiNBpZ+D0Ui1nj7XoLitG3ZnTx5VveDp3Ij1kXD/2/lh/exxnaZx+1uowQlDf+d3SXSW3nDkRibPzHC40NbMm6k7fiV6iutf4JwEacNXD7IjNC53gozvsF6e2yzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br4K8DduEb/7waohFEDJ5bWvCsPHZr7NrnOBb+Hy9dw=;
 b=sj1Q05bRwkmJIhrN6DoqpowNwwmP91s7Bf8xANQc2+igyphhJbje1cvt8XAosuiqorzjjh7htiVKqBZChr+Kw5Hfp+v0xB9CJ/KC58Fe+n6TZhPkNzNHPMvv39EZ+f058ioUt9V0h3LrOjrvfR3U+je67rjxz8EYidPxDb2UOlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AS1PR04MB9238.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 13:20:17 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 13:20:17 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] bap: Fix setting adapter address type for unicast
Date: Mon, 25 Mar 2024 15:19:09 +0200
Message-Id: <20240325131910.324811-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AS1PR04MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f460af-ae30-497e-a4c2-08dc4cce500c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DEKOUj2RAGR/43J0Fi2mWx1rgF+OWTd3RAbWsmfCsW54xF36JcSrzoTsnJ3wQZKnZw95s6sPeBFcXwJjvkHH5ZdOn0/QMg9N0Dt11WG2V49ZpcBiasMN4fbHryqAIEjmrX5pkJuG+2coTIm3TJhAaD/UPGn9xrfjFDPSK2U8ogPSerlGr62u4rU++N8W7V+3k0+h1m52jPT8lPIDr3S1qSS5kcFtmpfsgWN4XMnoxwQB1Bc1SrieqgMYIS50/ZuFy/QoenGr+Z0lvHJrjvD+bwQBp59KJl/xHwZeo72FnjmUbDQC/FjezQ1iulYH+UdUU/mS5xdoUtczA6hneMf3zb1cPq0wL9+eesPTkygvGvWNvmyn3d2MM1WAEoo+dOl6tybr6JycTFccUqCzctOaFnoIT2XlqwRub0v9pufsAWs7hhvB7aEYoeSrfbny3nQW57V0DIjdEXiuSs7MHPClA3DLBUUdWVLqYjRviJzzedldLhzyYxpvvvwjVmj+d9iple78qohh6HNOGk7EO/rPXZuO5R54QcaTKaWFbohduKE6dXCGmwsrxLso5mJXUyTa+y64IgQZjlWARwiFfM0Sf4tHfMGm9zijm3wNT0ERRMaziEuv0oVCQzp74iy5ZwExPdV1aTdKkpBTuRaAzOTmYFjId8hBeveZZo477B4Go5KH8uZ9xHjojBfBHD/XF3LotTSQc+t+XA4Qn2QEZskFT/NRtgisiTnqB2nOdemBIEg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CnVwIwznUp/1Zs/JMgjuCwCWmgYpavVZ8hhaVKf/wuuOhWnBwcd/d2jN1Vye?=
 =?us-ascii?Q?QK9WAU0xyKcKyaVqLvyadR7fdHtgphygCKc4hII+9hqICwKskbpCk/1AZnoq?=
 =?us-ascii?Q?QOl9RFVfKbgVvaSK8xr+HNVqbF49ubKvqQxFlXX66PDIinpm4Pf4xtfthYF3?=
 =?us-ascii?Q?DbRuDv25pc1SSWX+jmnPqfbgZaQhbgWUWLh+jq4Tyndonu4cc8PhzOwYQYvw?=
 =?us-ascii?Q?R+Usv/6WJ4W7QIHhytUh6a2npZqgGpHMtK8X0+7d/RfyQ0vCX80iCeJlK9QT?=
 =?us-ascii?Q?AaHyNcoPXhGkk/OuN5qBs9PeDz6HO8FCAFhz3AbBxk4qvtZTtvQiTiLmWbDA?=
 =?us-ascii?Q?+EiwtKHAe4q9nEY+qMSpeiiS00xII28Z+1s6yPMqFrcxCHyKNg7XMao8XbWn?=
 =?us-ascii?Q?bh5R8VRFBDOxQZVukP6n+gXbupvdRdy0HBmRRyWd/p/Ap95HPEHoghGejvCe?=
 =?us-ascii?Q?7VtiRaQ7rzhOXHRbltO6OBBOsb70BDn75O2uG2jsctpatDdR94wffWF2XF9S?=
 =?us-ascii?Q?Uwf05W8joqw9p6Zp0mXFdi0NLi9hcDev1/q1HOu4wzCyCk/6sYtHLP4t4AC0?=
 =?us-ascii?Q?uMK+fFzVV/Cyy879oSr1FY3dDR6PFxW56RCACowhxZ9ygYMrsqMKcCzlfEkW?=
 =?us-ascii?Q?h/i/TeN11Hj5X5j3MiL+OUR0PhxTpenlNe/KZ/zenuooNwivLN1WR8EeV7oV?=
 =?us-ascii?Q?CrzqYUpn0sZuBFU6eqQ1NNORMO8ZnpE+xSruH4DP1UXhWzLl6POlxZf84Jxm?=
 =?us-ascii?Q?lrfzlFJi/9hAerZQtV8MCdQ6+PCm3MNjI8Z8rQB/quKGzSq/8YWtQlfQXtgP?=
 =?us-ascii?Q?YvsPLck43MYLBp1aUasi7NaX83hDxWYWnB7UT8rmiFd/0mzOw61xZGku0sTn?=
 =?us-ascii?Q?epjelH4TnEJJsI/86bAnXBCT//MI3rUlpUEjTMerGWWm1rhtoXoE8gl7svKP?=
 =?us-ascii?Q?uqEK/6qjWti/ATcpx6gfZSj1l5wsAWnG2J2Ts6en241/o7szMq4ZuDjIgWeC?=
 =?us-ascii?Q?jnW9lJbc5E1rRwl9IqltT1brlp2BP3D3WS4wjHK8qb71Z3iRIi4You+giI+T?=
 =?us-ascii?Q?KrMVSbxt3ssNGuVtlke6a8Z54pKU/62fe5BwRYyBEQoXesfciIiqB2QE5yU2?=
 =?us-ascii?Q?nmf9xQ/FT+CFJOphn1LkvhcJohMm8u4U1bkrXPj0vV4+fzq6PbhvCOlVJzKT?=
 =?us-ascii?Q?Q0fdpNYwD8jMTTm+l5/HtGRyYbtntBNn0Yorbho+fasJurv7BnywERRNM0aa?=
 =?us-ascii?Q?qUZIv1TRSxX0yy4L6DB0YdoM9jI7ziy+FWcZhs+sglp08D6V2RYTB1CUFnxI?=
 =?us-ascii?Q?RBHfb9f+bPAWQY6/VCROV/QD3YSKBiLl0hCpmLDGFl1B8Emdj/iQ6uokNHn+?=
 =?us-ascii?Q?ERuh1SkuRPvtno4n8I0BMw6gFQKOvIeJhUyY+7R5QXcVe2dYl4Yw52KWGJ2i?=
 =?us-ascii?Q?Ujddp7rMv709WAVsghp8O4Qkn6Kfaqc0914xMyjFz0lJd5bpanm/f//JP/aE?=
 =?us-ascii?Q?m1BA7lU1PwfaS+EMuWc5E1dlCOxFm5+jH6kw0X4sKAD/cfbOo4RmHHlbYJDe?=
 =?us-ascii?Q?ToN7iDVykL1JYqHD4SHuGNZe+BOfz3UrJujQyLOW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f460af-ae30-497e-a4c2-08dc4cce500c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 13:20:17.1984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NwROgKrg8EzM1CamdRb5YXv5hCkKqeffgi1tEIEGPNdFu+cCxqiiBIT0Z7LJ0aBanFDi/endM4r4QdVAHgRTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9238

This fixes the settin of the adapter address type for unciast
scenario. Currently the address type is searched in data->adapter
however, this pointer is null and leads to the crash listed at the
end of this message. Instead, the address type should be taken from
the adapter variable, which is initialised using device_get_adapter
at the beggining of the function.

==321444==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000016
(pc 0x5601d284e03e bp 0x000000000016 sp 0x7ffdb164b740 T0)
==321444==The signal is caused by a READ memory access.
==321444==Hint: address points to the zero page.
0 0x5601d284e03e in btd_adapter_get_address_type src/adapter.c:545
1 0x5601d27a3f78 in setup_connect_io profiles/audio/bap.c:1860
2 0x5601d27a3f78 in setup_create_ucast_io profiles/audio/bap.c:2053
3 0x5601d27a3f78 in setup_create_io profiles/audio/bap.c:2106
4 0x5601d27a57cd in bap_state profiles/audio/bap.c:2143
5 0x5601d29d30df in bap_stream_state_changed src/shared/bap.c:1250
6 0x5601d29d71e2 in bap_ep_set_status src/shared/bap.c:4395
7 0x5601d293d592 in queue_foreach src/shared/queue.c:207
8 0x5601d2975c84 in notify_cb src/shared/gatt-client.c:2257
9 0x5601d2964217 in handle_notify src/shared/att.c:1012
10 0x5601d2964217 in can_read_data src/shared/att.c:1096

Vlad Pruteanu (1):
  bap: Fix setting adapter address type for unicast

 profiles/audio/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.39.2

