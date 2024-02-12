Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2783D540
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755147; cv=fail; b=dzhuW0o5rVfxZXdoyd8OjTgFKgvBzoBDyQudxmB16e2VRWrOdfzyV9LFbBSsouTMDseLyptOj6PGAYbXLaKWPH/2aHlR30IWLzVxXPeTr98xouafouoTNwEA42Je5+dt5j41lGoXVzEyTin4HJ1hS4byyePO37gjiHOqGEAaPNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755147; c=relaxed/simple;
	bh=mfsxZfQKPG29m0NQm0XoIqzzGqXZSXyGUSncIemUQjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dxNjQv7Atk/9dCa7HhST0g2JZR4NyV+ZicNjTlO61xgyyVP1NP8kSbO9/rH9gsGlMx/qeQPmFsgeuYwXot2dLQ3jS9iyuBY3m8bRYMx+OtriExbBn6/LhUDGKKu7Wm1bwA1eravTo3pfdDo7De6mL54h+QeWA4m5+ybKuaLsMXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EhzwtA4Q; arc=fail smtp.client-ip=40.107.105.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EhzwtA4Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgektMlZ5TaZwc96asLaOEAfQKhNj8E31v0IlbQUEeE23506aZvHIE9o8yxf+LncXdZYsV2aifmVelMk+U1rxW7WS/9tCx7p0KtKPg/4pz8kPSIMQrm6AOxdEWpcmF7j+KXsLDqZTwvYRxbW1x74jLNPXb56b9q3CTUpxp3HIe7KphUo+YbF9vxodDcEIulSxZU5Ek19bOWcHY9lLJIDsCAjFmBPYWg8+Z9/YhoW2by38tltL6MaqxKYkbch58/6I9n7blqy272N3vlelrPvygBVMwKtLTOz3cFqIJm2wwiJp5n0HZJhPENqsFC8O8mgTSSIAmFWLY8r6WYA/Pa53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Dgf3pqbI29lTmb5CEaFMyyFNgXJvBvak95/NF+U2jE=;
 b=XBijbP+6GsfD8HzBo73S0kbwuhYsxz6VUF66Y6xbYsWHTDeZlexeLBAWbiiQcYxJQ7r9Zry4eFLBEv7xbsnILxs6uaMtO4jlYRioX+mym3EpwNCN5Z8Hk9l30InaoYxfrUWTPwFc5ClU0wa4VRUILepC5K0edf9W2QugELe/V0oi9VMFaMExiJixcxsO0yiVnuogSdXYQs6A+ygpw4k8SCdkJhnDbg5qQBQaUjjyice3On2R22WDqllCjEEDihZHz9g5Tc1Xa86U1AO6Aje7XLx0srlVK/aBg1P6XLYKVf+RruWcEpawfpUuF0wegMpEHGIWDv74WRVF2LyLY0BWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Dgf3pqbI29lTmb5CEaFMyyFNgXJvBvak95/NF+U2jE=;
 b=EhzwtA4Q++MOmpdamjdVCGhR/I7ve62oYmWHDNjjVRrL+gzBm0ydcIpAfNLuWVyxr1Ng0ci/sGrUEwAIZXIxVxWGaZxh2H/iVlDmEpKNqRSfAgKCd/ZBzu0QHg32MxCNKXC1BU2f9q5rfm3XxmHHSAj97aduuUPiMo/rTl1ohoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DBBPR04MB7865.eurprd04.prod.outlook.com (2603:10a6:10:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 16:25:42 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 16:25:42 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/1] shared/bap: Fix wrong value used when extracting LTVs
Date: Mon, 12 Feb 2024 18:25:37 +0200
Message-Id: <20240212162538.32207-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0126.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::23) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DBBPR04MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4e72ee-cf31-4c3b-e93d-08dc2be741a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JGPI9WKvLcZX3YNg2X3VZ6Z8CbtPr2oPu86ALUfRiXaO/yXzQYCRPF9EBU4SKjMOM5wr7POb6gv8ourOo1FaU1Ii5bBdFaN8Pad9ScOTkxPYw73dFoXwax0c5nQkC0uYyI3Gc9vxoIcA6YgKjjtfyFCOy7L6pyLJPvo8bHTE9fbEH+yj4j1xVyDmbh0qMKS0hcMHV02Gz90kvsVkopg6Jm49IEBC4w6skvKCWa5Esdvsls9kJDIHvCqJkCYnRKaN0Pp05AJg+qlZa6V9CMe3pZfkA/9nOjCj/wYl8fVNiElphFpxgFVc7MJLyqT9KBRrjJlPxlIZoS0IUJadSCkaXgkkoCg/ft3u3Q+MrS73aFiFKHnOFwYL9gszwWzzNnj9PrHItQ8tvUBc/St6lSwy1wuJkUJZl9Dl7fL3PxhY8+tNdTQTlC+8SMc4ZNTf+dwlV9wvYm/Ktr5vEcJLrm+QXIyIGCRqxZ0j6a5f2YBkXWRByKfk2WcWRajIFon4AePHxYqtF5BIWYPCOAof+CJ2V7VopSbQGvSZc4rtAM3v9Il2EF42rFRkss0Ow/ZPelFZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(8676002)(26005)(1076003)(2616005)(41300700001)(4326008)(2906002)(66946007)(66556008)(66476007)(6916009)(5660300002)(8936002)(478600001)(83380400001)(6512007)(316002)(6486002)(6506007)(6666004)(86362001)(558084003)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sowHBwekuHs0dqdzT9jJ/k2eAHPztCepaFL8lEYksJdhRB8mcj0EtyO3mAYx?=
 =?us-ascii?Q?Dc5WeVbSWEZKO7KAc1ogI3fRLzmRpj19WP0tCyZHkv22wNKhWiWjkgbhGRI6?=
 =?us-ascii?Q?v213peXXV/s7FjAJZ66c/94PwojXEwTwIzuQuVETAK71oitZHgj9ujVGPLKi?=
 =?us-ascii?Q?F080ylt552uPTyIaNTVs+15d+Ub3kVsH7CBLRiQUdaaPVCEEDvnVJUxt6boz?=
 =?us-ascii?Q?atFc20QayNrUWM3uQRYgUT9ozZjHaQcnyZR70pAZmZKc86rSGTgqyiScCnTF?=
 =?us-ascii?Q?df+cB1MQWZuq7nXn3nsoskQDHzGgy4ZknAM0aQKpBiCr/80GWAFh4pqYssLX?=
 =?us-ascii?Q?q+NbZCNOal3TKIFnHBVi1+8L5HAx5MQkR3TKJF4qkRHZGq/sDaqux9dTrs+n?=
 =?us-ascii?Q?tJz499PKjLm6yRVZ6zirW3wHvLhiN9jDzC3n1saq8osiB9s9hq6kIT/B2Sk8?=
 =?us-ascii?Q?24o6wtoOKdaEYqV2WKcB1asnlhLrFuwEIv8TZY5LF5gJKKdeFLfaazBgIHGX?=
 =?us-ascii?Q?DWeyJE0VApDmarcZIahqZ3OjR3CA+jcHZJB/LjxHC3fW+qiQHDXu6NbCZgri?=
 =?us-ascii?Q?3gk+h6WBWLPIFEVubX101ElYqwIWNr1wcFzrMg4vOrTZMiesT7LVUwgQtYWO?=
 =?us-ascii?Q?+y4ii4uSJjK415yqqfPhpnO0kchuuz1dkkPpH5T9MA/J1pYYZ4KUOnBtwQ4m?=
 =?us-ascii?Q?BeVHkJEIs0js4hWD1BcTKunQNgc/l47yg/Cqh28uPhFv2oVHfBZplYV1VIZM?=
 =?us-ascii?Q?ThJ45muuGnt1tQTzn+8mLZOQVtVbLefEL9Tki2Yv881wMyvO7io2gWCc5kq8?=
 =?us-ascii?Q?o5y/VcomT5PVoIu64puta8JOjmPn3dsNrLbxmYP6QUdZDn4I8gc3zX9EEAv4?=
 =?us-ascii?Q?K85HW+6whtmKJls4rs64LYnp07h9D+INorRTVstNi75JUe7Qgc8iVzZfOPXR?=
 =?us-ascii?Q?LJDkXz0/iIPEd3p5dL4alsLeaj5RsMAkqu/m57rRgZrrO+0d9i4IhcuSLCb0?=
 =?us-ascii?Q?3ZcElMa0sP/ZWP6Dv9Zz/DNzMgc7QVoMKuIesU6fBakOPnCnJWXawsPOdCGe?=
 =?us-ascii?Q?ovqS1F/MOxNLwoQ2ZVEIWVKhBKfYp5uI7Va4f82G6MfBKiKu6URdQ4cALJW2?=
 =?us-ascii?Q?0bRXl2/077F4FwfeK7++cSipaXEcWfrMzwfF7KFV/AH4oys7qxM9AxhiDZHx?=
 =?us-ascii?Q?0ORFXhpFLVDT2dD6sE2zovnmzwXT7KtSbj4h0EDPM2zlIvMiwXVmdv3Ce/AT?=
 =?us-ascii?Q?HI2jd7DMHSYVqZgLqpP3Qo79HSVLQluFNohHxOE7MRmqGSNvJl2LY5lMnw3M?=
 =?us-ascii?Q?wuukCF55uyQdLzdywgNS/FWj6y8sBELmOLzRVCD0henvholou5dkYJ5KHkYe?=
 =?us-ascii?Q?9jwFseN+ZESMplvOj9ITcRjeyskSLYBxVl/PAZ3PFYoovz44UfJLfO0RUay+?=
 =?us-ascii?Q?yTuRAcrGRf2eHQupIuYRSjfwivwW/IncII5ZJZ61KDERvLI64OH5jHQpz1G6?=
 =?us-ascii?Q?kGp09e6ZfRdfNkx3mCpeW4AaoK0/33vbHV3Td6CaK7l+I93MzqPR8pytjHcg?=
 =?us-ascii?Q?/opzlTwGwrQzGa74SpsKfztwGxcH9hf++3Utcf2xiCAnDvQmAeHXHhLT1sGn?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4e72ee-cf31-4c3b-e93d-08dc2be741a3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 16:25:41.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIvjSmibdPExxA7G9Zbklmu8pDGtGolvYyiIocdjhlfoRF0y0LkHYaNMX8fI4dgeBnOPjif+UvGwJ6WvFmLrAJYSxU1pB0yeDHoLbXQ/Iao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7865

Fix wrong value used when extracting LTVs when generating BASE

Silviu Florian Barbulescu (1):
  shared/bap: Fix wrong value used when extracting LTVs

 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: c1851987ca2c6e41d1e0e166e959b754e369c254
-- 
2.39.2

