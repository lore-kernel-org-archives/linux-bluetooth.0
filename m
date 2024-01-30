Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E7E85C62
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629470; cv=fail; b=SoLrXvtt0gapQajOUQCVg9f4s4DrSSXWk1vWGnuPEzCdYg05XU/hbytsu3HZXzAwRd4+x5+wXWznHPsYODhCpuCB7FyQhQknmMIc53/lLhoyiZWsy274++KvR43M+LqB6nmIDfwvkfk4+TyZJFM9kRmIY5qKHuPZnUO0u80fjDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629470; c=relaxed/simple;
	bh=HZSp5Wk4BqPgdT5j8HBfem+nO11dmKiXy5H4djWoBQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hLpwyp+YLeTq44g7cnLE47RQY3GnlTtn4S/mOHtrUKcOWTupeIY8BLZNEd69pw8Y6Kp1sHyMitcV5cC0pU7IGCTrEYXreICW1Tih7UuyhBGG3dhQaLpocZhjUcIELH1f96YUyAt0P/3yoqkhYR2sxIiocDn89XDqgCovo+hI3RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ay0C3jbh; arc=fail smtp.client-ip=40.107.7.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ay0C3jbh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFnC7nVjGDVm4WA7ZK2LzZHkoK6ZxWpVMdA6TpToTD3zUX24qSkusf2B97LD/5qFOA0eTiKshoBhaogCmu/fSVQS44macHvqmk1+SFl/XJe9zC/W+l+VmdzALecvA7ug+iLHlHL49M3PaAAeWMs11J2vS77xD8Ilr+1rue0RmAcVlB6B0C+ATuVOsusr1tRsJeH2zhiV+is7aCBK+tt9W8KwOzx98uUWanrFKx/mOsi3ub9JONPblRyr2SEyCIyq0wYjzpyiIAiwD5r9MoGXUsJ+ys6yZRSzAO6YypgdR6bjeMYVKJQoZ3Zyw2qhslrZpTfb2Fg9wanaJLxsNR4hIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL6TQy0ZUNVyI8LJeLo85cFS8yJhPc8+20WIHD4o86U=;
 b=Yu6h68HvphnwkgIzSXbDYPP6QMY4nSx0GawFFtengU+38ypGOBgCvAYxJixE7t+m6ILfKvFWk4fZl+BQSQo6NbguqkU2XdGWziezy1BvZqInE0SFR00+UyMTIedOkXV+2A7tFNaS0q7E4bkq5opFOGWXUFZhVKEsI3Qv9ho0eA1jhbzK8PkrB8f/xJyUuiVTY6fiuNp9dBc3COedJcEWCyuwp8i3MqnuE2dBp2ar8/dekuSk7gxIogd6eRG0yvYIYGHdjKdhPwfX1kfs+q85txX5zJRKR/2yIkj/MotBoTKQjPMp4E5SMG2ZBimcv4eu8Bceq7z5dF7fa+mJyOskjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL6TQy0ZUNVyI8LJeLo85cFS8yJhPc8+20WIHD4o86U=;
 b=Ay0C3jbheHFomBpaeS/tUW0zBOO621FsS7kMs4RLp/sW3B5Ugw/1UwifvILRA8o7AUkTZWv3qTPhBUhF6lnW7uc2PkFb3DoXtzavAYF1czgK641hzul/7LLA35VeuWWZPPsHPwvQP/Fywale719hpnT/G9lCCsK8Ja4ds1qi9LQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 15:44:27 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:44:27 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 3/4] shared/lc3: Add macro for Channel Allocation LTV len
Date: Tue, 30 Jan 2024 17:44:11 +0200
Message-Id: <20240130154412.3157-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130154412.3157-1-iulia.tanasescu@nxp.com>
References: <20240130154412.3157-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0004.eurprd08.prod.outlook.com
 (2603:10a6:803:104::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: ae18b18b-3955-422d-a983-08dc21aa572f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+jjVCJaN/U3i71Wn35/xrbbBa2CX7tuEyijbjUlDdrSe2lstKYwOaU+dXZy1lLI1ZeNFWR2s22+gh24pcQwDuWGaSZe8PigvAKS/ahbLeufNpAI1ur39yAIhYRbsq+lpfdMyqP7pPhUVHSI0gNVm17yRyxOHkP3zJAS+Hj2txS/xCywgKYVHNx6KLaJCNbygXBKOqEUgIAzvZPRR8t7+yOU/ukPCyxbt+t0c9MROeCYSCqAkEN+7nSeB8HUGMqgTWOHc4Vvq7nMWP+1yhKtgNJxKmBNFhu/KoHwp2/be2cv76u+XIajZbM5/5sbNBblLMkyr2ylN8XHaIg8t1YuVUQTrMJYVzALRQLqamUCTF4tNplWbHWcjkIjQFFy15nJWAg6WpcX+rkRlP74xUkZe8Q1K8BEOqJnyMe+FqtotbDRN3E/QbNQAwswQ6wOIku/0ph1xByBkmRAWwR8X3CYZXtDoU8Ag61c174CEQ+TYlO5yrjA5P5QxMfVhylTnumNrv3Q0phhM8g+TxhxWNDv15yq+zHnlIuSwTZHlp4NshNuBjmYAXt+UK68T/y4z4fjt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(1076003)(2616005)(41300700001)(83380400001)(26005)(6666004)(478600001)(6512007)(6506007)(6486002)(2906002)(66556008)(66476007)(38100700002)(6916009)(66946007)(316002)(4326008)(8676002)(8936002)(36756003)(4744005)(44832011)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FPahT+/NYDAVumAq9cwyxjSB+ZHYtkxMCgoNwwst6Xz+O503UZWmuNWeDw1f?=
 =?us-ascii?Q?OnAZ36LwUigvZ84roTO8LnzxmAgstsOE6W1MY/WCehhYcMblj0YPqOVqMiC0?=
 =?us-ascii?Q?wCMAIECgvLzF+Goh4sjChSqemc8sjwcKmV6qV/QefF6ekuneCPb8qOxK0nQ2?=
 =?us-ascii?Q?EHsg8cMlEgw4rPcCyo+G3db0IYv2+BcNeFviZEYIGgs3Js/JRSEsiAHC2lBr?=
 =?us-ascii?Q?M+FvQBOzbyykm7E/f9A6WBX0bNswwox12SJzLxiBZxHI2auJ5MctF93XLV9x?=
 =?us-ascii?Q?EtE5koyn+sNIvAYshcHyjyaWAiJams8U+OT4VOzJTEvqdqbb3nmaUR3XezFr?=
 =?us-ascii?Q?saowJMHy4WawYfp/LXdVBd8ZYDR8UyEkD6lRViWU9Rp52E2LzV4B74640F2W?=
 =?us-ascii?Q?OMZN7ZIweMStPYaMrgxGCzKWkdRmQ3V+IEgfIc3WvCDWB6hLP08IOWCoJw+t?=
 =?us-ascii?Q?3jsPLUkce2j35tTkXR6vMHNBX2bgO/0UitH0IvczxM247Lxcn+cvvNvd0sG9?=
 =?us-ascii?Q?Z8KjSKMtk6JMltDmUmXpswWR02GLgo4c7t5ARbMjXo+xn3hBqxkD285ToH/O?=
 =?us-ascii?Q?8JkE8BTXV+0LOWTbuqayNAOhrROJEt5VxiyxGffOYFYVW2M3xPpmJlVJkRhH?=
 =?us-ascii?Q?Yefxir347b7ZIaBj8weVvBdV7tntEL+lCfsdjuTaHnH8q6/PUTdG1Bv6OJvs?=
 =?us-ascii?Q?Gu64sXGuLJgpO9Lu89F4yYSBD9I2yFQ3sQleZ56Gp6HM18Thrtcv09Hhphey?=
 =?us-ascii?Q?rGHrtE4T0CxZHUZuIYjchA5Ne5sGw2Yw0L3rNSwxG+aJYRSiQ07RXeAZpFk9?=
 =?us-ascii?Q?PNgTigH6Xvn1ZzlZVdL2OcJ4/v39UjmXCaO8+3xaps198NhAFsUy58N/7pY8?=
 =?us-ascii?Q?erYSSMfgzwBvdI/ZmxmeR3lPCZ6qyvdxPHFAIt2JYvhGkodpLV9VoezVO8BL?=
 =?us-ascii?Q?ptH85BBTfkiF8z2tWv9tzqdhpsaeaTUd0lKh81XJCWl4OVKep9JAlAizIPSO?=
 =?us-ascii?Q?hbEQxkF21JuAObDaEn9YzKO1CI9Jzd56L5ODDpxHmrPVfiQeANbDX14aqXmj?=
 =?us-ascii?Q?4oPRrgN1rTUx+nbAeBo54SOlYQFFuE+ANbd3JFKCHW+ZhnlH5DWYP+4wRjWV?=
 =?us-ascii?Q?FR8BY8OSpbbcCHgsjgjSuLCdDJ9T8VD1VlPl6V9EEJFlasX7nGgdthD2COZI?=
 =?us-ascii?Q?JZ2VVwU1IDy/g0YjkipBi/JnKc+0OoFOQgcxdyFvAjEqb0FFywvX6Dq7v/UP?=
 =?us-ascii?Q?3GbG0+LERaZauZJbSlfup6bfv8NV+WZhCCuZVGH4ouHSP9u0w0F/JKOj9ghh?=
 =?us-ascii?Q?OTBtcB7rAgGCwkc2rBOkHvmtRMZDZtETOevDOhE92imFHpl/wfz+xadAqyDP?=
 =?us-ascii?Q?bijsHONe5mp75FJMMpDvP9/EbmVN5wHEJQrFO2eiBVxyMkHD1sXi7Ti9MMSZ?=
 =?us-ascii?Q?3g458BQGdhIw6Qcggic/r5wS9QhENguqta9itZvItkROLBXzk0OUat/1znEo?=
 =?us-ascii?Q?PenF68Vz99qNn1b4k27UqGv77+g9ScZZaZ0ilJvlv92G+agGCgzVcjkbl7SG?=
 =?us-ascii?Q?atiTcdaRwomxMj9VE1nOJMG8GDuPK+WS6sZVIV7pja3QrnQc4tBgyRo1sj/8?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae18b18b-3955-422d-a983-08dc21aa572f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:44:27.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FsEXiBWfXY8YeMiOfT6bEXgTl+WpJbqNDUq264t0Ygts5iG1Wciz8NKlwamHsS1lLcy4b6xBR9i9C38REz3IIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773

This adds a macro for the Audio_Channel_Allocation LTV len.
---
 src/shared/lc3.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/shared/lc3.h b/src/shared/lc3.h
index e6b043699..4ca3c6898 100644
--- a/src/shared/lc3.h
+++ b/src/shared/lc3.h
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *  Copyright 2024 NXP
  *
  */
 
@@ -75,7 +76,8 @@
 #define LC3_CONFIG_DURATION_7_5	0x00
 #define LC3_CONFIG_DURATION_10	0x01
 
-#define LC3_CONFIG_CHAN_ALLOC	(LC3_CONFIG_BASE + 2)
+#define LC3_CONFIG_CHAN_ALLOC		(LC3_CONFIG_BASE + 2)
+#define LC3_CONFIG_CHAN_ALLOC_LEN	0x05
 
 #define LC3_CONFIG_FRAME_LEN	(LC3_CONFIG_BASE + 3)
 
-- 
2.39.2

