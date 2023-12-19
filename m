Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2052.outbound.protection.outlook.com [40.107.13.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E67472
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iM7TXpYD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3aYBo81GtmC0VP/BmAXM7DjUNBXM45edPxa0d11TY2CSwCp5xkgit0NfMUtpuuKN8rhoIvjEqqLkn6GzBsPFxcKr0d1mWHzLnjtsL7SOdeJ6FeEYimfPCBuS3jFjHvNOgXR9lPTiwPkr5VlJxQ5bZ8RloxHrLw6qJCbJyQWpzDASLsptlVXtANmlagst+9IoXZZM/ORU2g8wmuicvztyJKDrY6wvA4N+ht42pCXY73BNwVxCNJFL6GhSBxOXkGiE6IprE6nK4b+TUQ/v4Kf9R5etEZcrf/Yd5kvpZprv1glMxCJ7FyZy4Us9+0H8ECLvDBY7S79ntl2DdJCxtR+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLnx5xLLhxAd7ZteQMigJLp1k7X/GI6SIlPnJgmNfZ8=;
 b=ZWrL+q+p6hzLlQ4utX+zIGfSQ5lJvrvWH2WEsMQrqvCB/TSYnZL7JXjRjt74C32Rcnq+ziizhgGKM1aCu0nXNBO94vRlXuS2OyAAoV+Ip43q9Wk3w7gky7Q0vWG4jP4ZGGP3wlp33xQRu7ykWzfsn5aq22tl+6vpeES/d148nglPPLkOb+yEV2iFCz6jNKaiSS2RsqWvw2hgbRGdcRcg9VGelVsKEwH7wN6ZueS/+BufEsGw3Mn5pB5n3ZkOqncim97dyv3fj/bB2QgC9RqsyR4KK5PAk6j1ITAI0jiHWYW8YLRW0qcJLJpvxZbuPHeW5LVrgRNkTPJVOKIKyvFyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLnx5xLLhxAd7ZteQMigJLp1k7X/GI6SIlPnJgmNfZ8=;
 b=iM7TXpYDZppwF1BWzKBctvy8+eVDb5M2eerFa5jhmVdub0y6mZ5AHcgYlUwPVvGsadbUXdUKAkRml3g1REnOXkfGNeg0kho/yNHSorSK2mqnu3u3XHU2hxv0K5U8AWWq1+OBGlZbYJeAPgKQCdfN1HAMHx7Ir9pxxEe+Vqdy4Pc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7709.eurprd04.prod.outlook.com (2603:10a6:102:e3::11)
 by AS8PR04MB7717.eurprd04.prod.outlook.com (2603:10a6:20b:292::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 06:28:37 +0000
Received: from PA4PR04MB7709.eurprd04.prod.outlook.com
 ([fe80::9f65:a4bf:7753:21bb]) by PA4PR04MB7709.eurprd04.prod.outlook.com
 ([fe80::9f65:a4bf:7753:21bb%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 06:28:37 +0000
From: Vinit Mehta <vinit.mehta@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: vinit.mehta@nxp.com,
	devyani.godbole@nxp.com,
	nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v2 0/1] mgmt: Fix crash after pair command
Date: Tue, 19 Dec 2023 11:58:00 +0530
Message-ID: <20231219062801.307-1-vinit.mehta@nxp.com>
X-Mailer: git-send-email 2.42.0.windows.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To PA4PR04MB7709.eurprd04.prod.outlook.com
 (2603:10a6:102:e3::11)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7709:EE_|AS8PR04MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: b0504c1a-11c3-48f5-c392-08dc005bbbcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lPVgPgHodXhs0PYUJYJovjoh7ax6gVjx4BX+iWeVXl1g140lNf/WbJOTIOdD3cP76iHDjy9d8po7Op/6PfYrpVKJEdeRAl2jMuXEvm5DEC81DomTztLnjU5Cc5/n+vkZ4A1tDDdiz384IMnztli5AC2gfOEHTFRDQ5IY1ohWTJa6CNlplZmlW2d7QQDqfoPASg1TLvQbd3GDeoFTBKrv4sXwOxf441UqGe9xme0dEjBqNDkQpQzR3stxEy7XgUT/YwlWtqhmhsCOYEnebMBgRuIy6Ap+sv19/wqP2Vqdchyujez4Mo65AGQDGQvhCTHfEZ9tljY2zx9VDQpJynJUHPnbSf1pVLYB3nxTNIiUS34R5Vuod5tqzPjStTMRXd4poeIxE09gZlbzWcCcLRw+Q2GrgDaILl3884zx19ONnSNDTa8yqcXocADHHCRtS0ZhqOBVA8ic45yB5DVV2aTEpDOloS5WDNc7mIBC28Wa7ALFXMoRDjhrcamYIIe98Ojl/Gbwc0OmdTNIzVCkL0VvTJm6Ub5XCwHxFDl/TqJ1Ajyt8IJtBm0EfyjEU2do6TRw4U+8CqqNNySohesrkejZK2g7l/2uN/S4itJ2vFT5G56fbivvxzmTfsAepMMCKgXa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7709.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(8936002)(8676002)(4326008)(6512007)(6666004)(6506007)(52116002)(2616005)(26005)(66946007)(66556008)(66476007)(478600001)(6486002)(36756003)(38100700002)(83380400001)(1076003)(86362001)(6916009)(38350700005)(316002)(4744005)(2906002)(5660300002)(41300700001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/75+18nvzqcofnQvonDKdJZ+JvLmtEIo0ZIpAJWma2dKHtzLaQC/Wp2wRy3i?=
 =?us-ascii?Q?WzpKUEIUjde8C/qHojDoCRk0thKOFw4JYOh8eNxEG1RBsoKgpJMyJ6ZwIMi9?=
 =?us-ascii?Q?5GfRUvcvZYciSJswhOFlOIS9DljFCC6LNEbdQlpcixofKZPYOlFPzuHFZdRn?=
 =?us-ascii?Q?5Ost8S4lSMZShmmsSnpq5g9jaMAC7zpHir0woif3cAgnohFZJuEUgm4j6EZR?=
 =?us-ascii?Q?VNx+lSLa6hu/p6SpxAxWcK5FcIXVIJWrHmMn7KOJwTQRJcfp/K6lLd+bRp/o?=
 =?us-ascii?Q?kbaVc9CS1mHxBraPgXVB6WTaiu6wTwFRyuEfm2Pi/mPPqLpmCRPNDjeZE0Fg?=
 =?us-ascii?Q?R1Q3UKbYxzNiaqIj68M05x6LujRAdS9Gg2LP43i8CMsMafZ0nFo+Z5+dF+jO?=
 =?us-ascii?Q?yJdbpueZ1UzXomrXcMlJOLh1KN+vuFzvZe1G3Pt4jnoCxu/GkQo6DuWHtt7U?=
 =?us-ascii?Q?+4b+v3+v0t24iMlTy5XiSvnyqNWilTpZCpHxlecwQBsYTJ52Ma0kqdFM0U9a?=
 =?us-ascii?Q?1YOyzBJEeybxK5xJQb7orQ7mtqmMZ2rCLk4gufx7JqCorv1IDXXfdjXDcc5v?=
 =?us-ascii?Q?wxOO32wARS4GJL9uQ3Whvz+ErNZwGND59bIoohjkQ4TcXZDv0vbR41FK2B+n?=
 =?us-ascii?Q?gFMY3kTCwQ4UatjY8xxjzoXujUJmJYpLiJiroP+lXP7k/IoEab2uDXYMT0Vp?=
 =?us-ascii?Q?mJ5Sn1upAEDiAmRykQdaWsE/bC5GEOWE+9Yzb83xLqnz5BzqQzwTEC5uwBHw?=
 =?us-ascii?Q?vzdOiJLFSrqH6czR0N7gF3Il+56rFtKQCAx9sLrzfBkp5LNI+AktRDyTnWVF?=
 =?us-ascii?Q?vyJVnOd5oTof6bQIknE03jh4RrBA2e1fCYo2oLSuDXdXOj754sPEkP1Qr1Wi?=
 =?us-ascii?Q?L1UljT39/h9gAfRil7jH3Z10n/fAJeORzvQvGM4OOGIsxsyiFTNvA6031Ym5?=
 =?us-ascii?Q?PEsHMWQvwP4aXF1ez/4UUtHLovNswsmXIYoTXqjbQX7ksN4QwkSTjinYocLg?=
 =?us-ascii?Q?coAiFzoe/zo30LhPA8Jet0+jbF824NQce0IDgmAbjjPaHDIwFqIHzcr65pMa?=
 =?us-ascii?Q?+Rybceeff1fiVaLUITPLswaQsO78FJ+iahzehHevEkeJL99B1bmyP6HycEf4?=
 =?us-ascii?Q?+lddMYaqd3jnCtJKF/SpbS7DKSTeSM7RlV6TweOhar1mfYmYRoOXMVIGuFsy?=
 =?us-ascii?Q?47buIfBMXUMxsjRycNGlzS9FokHRWUw5s0SwceRYJ3uBMxNK8bLISHj/0Grc?=
 =?us-ascii?Q?s0X/aXjADt6BUj8p3/0VwYyZb2MM9eCI98zM/JF1UQi0nQNddPMr8y89wsm6?=
 =?us-ascii?Q?QEGkEa0ygO5zucOkvhIC5drLya6ZlHHA1MaHQwP0TMD98b7RoT9ku4GM8RZx?=
 =?us-ascii?Q?V4RZ2bzJEojBnztx9iFF6jOPPXniI/a01QIvZ9cbeck8i4wZBGLGKR6Ritjv?=
 =?us-ascii?Q?hJxO5P3oAF7SmfjDFfCV5mktPvlk+KQcOR5H01ocjl6acxz9C3lJvL97soSJ?=
 =?us-ascii?Q?77nM6lqJ2SPbaJDj/GLLNCyoMMVUc9vlzaRrjp3kKSzSdbT1TSQfmO7UzyBV?=
 =?us-ascii?Q?KXVn8BGdCrDX/Yf4jgfVqvGIHS/KZ1h9Wdn3DDfJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0504c1a-11c3-48f5-c392-08dc005bbbcb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7709.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 06:28:37.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fH0afNC2K8uQJmRz5sZuM+fTBAPcSTJrz1+JLmFFJe7G1OPoW5KEFeRf6B7zLRBG7WDUn/cZo/W9zJAl22GnBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7717

Hello Maintainers=0D
=0D
This patch fixes assertion in bluetoothctl client process=0D
=0D
After pair command, if the user doesn't provide any input on bluetoothctl=0D
CLI interface after receiving the prompt(yes/no), than subsequent CLI =0D
command will trigger a call to DBUS library function =0D
(dbus_message_get_no_reply) with a NULL message pointer which triggers=0D
assertion in DBUS library causing the bluetoothctl process to crash. =0D
The change is done in confirm_response callback to trigger a DBUS=0D
API error call only if the pending_message pointer is not NULL so =0D
as to avoid the assertion.=0D
=0D
Thank you in advance for your review.=0D
=0D
Warm Regards=0D
Vinit Mehta

Vinit Mehta (1):
  mgmt: Fix crash after pair command

 client/agent.c | 15 +++++++++------
 client/mgmt.c  | 12 +++++++++---
 2 files changed, 18 insertions(+), 9 deletions(-)

--=20
2.42.0.windows.2
