Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF691552F7
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542185; cv=fail; b=cWzIbPr5QlDKkYGhDHFbm3AMqj1RbWLsoOKrZm94qzZEeudAKStOz7nYMAlXjznjmAF3K+HoH6HLVkxwJOneq76W/mBlSDTu0PfjrOKmY/9uXVCOmZ6tnlJINh+PEeRFoY1NPDRb2QD4LiWlBIJZu5w8U6BwMMv5VbM60NQE4yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542185; c=relaxed/simple;
	bh=dfAEbepBogGG50oThiFd2t8ItcAlO6d2c2mkUxV8Kpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oQBxaCZixgqCAE+ojkIu4K4on0JCb49Uzo/DIL34NtwDUZbL8q226EpS6HKTw6b+XNJvcbTsDIJS5TrRrPKt3srwWlXLcht/9gumTdv1Ez+h1eQrAfDCx7O7wco7FL9hBhHkxFvnC6E72+qoseDnzIYXZCvUrkFCrbKE0q5W1d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WmsksZFK; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WmsksZFK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izwEmzSfL5g6o4hmLPeIl/60XzAUcvpzqoXXsS54RfTWVIwdRXzpbM4ksdkP5TXaP7gSoGuaRAsl/nXPngMoXry4wE4bDOGvHHaSSoJye4r2/yBwzESP96pykCnUUSiO82xCf0T1y/k7dOm1DnWSKKSGRWV6wy5a111dfmVqD5Qej1s5Fd/Tuw8i4rQH2h2rmy5gYx8ku59R3fv0FSGtIgCoKBhh4+Fa4betjC/Bo3W1mXUGkYDRF/WzTqBkEK27v6NTcNZfQJPkufrxcEUcuI1XpnFqo8c6mIr1jBMnbmIp2Lj67LupOjhZHb3dBcREwmPen1sNz/U8DDMo3mW86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ltwxP8dwaacvkxdQhzspCiOzWCuk+AaeT5+lNBLBCU=;
 b=kJ3o/X3L8+fvkUImnPS62P2v5XdR1PgkyBYYS3SK6vfIex+AtWAGYwQZFv4BAEad2gEEA/CBDxPVQfHnqfj3ZJifjyy4ur7VjTRk8v8iNldrdJ13epWh/TVoZ1XEFOG6xHGLNvtA+FSe1nvkC8TFG9YUGG9GyM3M8JVlafltykKHiM2jrzmSpTcPm2M5AHFvEgY4PwGseOVNsjULlQV0P7VTnQvpKT8HuiLdhATxXBTdF4Py2pgICc7/iplail3BM1w7rgbQWD1buziKVqyvf+iHPA9hcWB7DRpHb/w1qfKxTboIqU6eGMDEFSEd2nfzbhh6O+h3nDHGperY8DNtLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ltwxP8dwaacvkxdQhzspCiOzWCuk+AaeT5+lNBLBCU=;
 b=WmsksZFKQJ1JsQIfmgmYOl0LeIb/bT02+6FjpfSjr76dQYGcIywZjPVE4L+OhzT0xuMya9w03edmlrGK59eBfGpTRrIQHzA+sBUkuoBJczzkGixyiRLNXUKkJTFDlYZ77ZfbxfjNoU3WoB1l1BcEveNaKp7kDIiOLFvutURA464=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7105.eurprd04.prod.outlook.com (2603:10a6:208:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 15:29:42 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:29:42 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/3] bap: Parse BIG handle at endpoint config
Date: Mon, 29 Jan 2024 17:29:26 +0200
Message-Id: <20240129152928.3904-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129152928.3904-1-iulia.tanasescu@nxp.com>
References: <20240129152928.3904-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0040.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 51bb573f-2398-43b8-da49-08dc20df1d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	adDSJH4sApRfrGh4sjaJUdYxsj+utM/ndu7h9RKOEor0TSTzRDt67jCoglvisbSOIzUZnJbaR3vtiH5mBKiSicQg5xIBPbQZ6/miwyL7g9oGl6vMkgq4mAPvoBRYSENmExGbfmn+HwGCONegBT3fs+EANfaMvJB4qfWv8/rRqQaavbU8f3V3iZV5SsytEtKLlpCb1vI+nGz/qVTp1viU+Fz3HcjWRFu6OgDmbtdkbldjVXpYpbqqINRYzIwWAO7wwfntHFfG1V6EwIdy4blkupMBXtzUYYAMypJYJMLbq9NFLb+lGYUgtr0QeV+6Z9ssxIywnj7FBJO2GspP7xM7VqGhip3mmeZTRnUTMqmvcPp1Ml1jQ8AzOFXUkPHSEaKySAuGJ7yn/JTrQJYN4kkF226QCZQXsfXIM/pH9pcZoh5LYUdR3tl/IrLOQCwb3QMbrwN1lvAdGbeagPUnNjYYMF+r8gL2vQMy7nTLoYUokuyBizMO8Y2RdS/ltrRUAL40g50qOGXXMYxxyE4r5Yyg3rSSXJ96Ujsu5AxbSwbiMxtiBXozAMFFHb5DafaG+HxS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(6916009)(6512007)(38100700002)(2616005)(1076003)(66556008)(8676002)(8936002)(4326008)(5660300002)(44832011)(4744005)(6486002)(6506007)(2906002)(66476007)(478600001)(6666004)(41300700001)(316002)(66946007)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vJRqtNZ5gbso7zLYuSr3sfgDrllJFKF20Am4TaziI13PCfGCGTh4Mu+vXCBY?=
 =?us-ascii?Q?ZTr8Ydjj4ffRMs6EFuzTcs6W9G2xAN5+hMe0y9gI6r2sr9LWdgmFfZGqXcmz?=
 =?us-ascii?Q?gApul4uoCnbULrFbOhVrSQWYbvkakG/eM4Ju6HD9YivQLlJI9+MqFZyN4YjL?=
 =?us-ascii?Q?FdkTHDwx7IGJouuICBDFsZs9C2QTJfGlsn7AF8zAuSMpkA70HWEWDeuiBLuV?=
 =?us-ascii?Q?5W/RHqBKGU1XSa4buQYrPUuVv/XIOIm06UFFrBSrnDWChAFhFxPbXLgZJ7v6?=
 =?us-ascii?Q?7juMXMVKHPy0hgvWV+qOv2QJFG3Ip6XdGULEls8WilejdfVVK71I3FPtmpcY?=
 =?us-ascii?Q?sxSovxA+nxdra6tLnmAekNTuujuIysnsZ+JFp77Uj0isPJknw8FULNDcY9/Z?=
 =?us-ascii?Q?K0kphzrtox/89exK+k7TrCTqoEgRxAmo+kOS7vKECL4yldKHKHr42Rna3EFD?=
 =?us-ascii?Q?TNHXl/jLirHziEKXwuMZ5CUTbPCKzIFyhZ2/nyJfvaliukPoMQQ9DZGGDn6A?=
 =?us-ascii?Q?D9IY354Ap8giPP5MnCBzdAXDepDyryh27OwoDtLK5wHnRYV+iLU1r+Jx6Vf4?=
 =?us-ascii?Q?nhjl3DtKaDpXELQmIjWzwBo6VSrboqiBHJxWYouYAcsd2mKNcfxFNKo+CKB1?=
 =?us-ascii?Q?CKavDAFpzSPxpndMT32NScZNhcj1uyV/DwSmsyavFziwSNkLhdnTqmV8ENW1?=
 =?us-ascii?Q?QH6tDpzbV2x7xDVVYKcAvRITg+kvdSG6IvlzzDRhf3APNQ6VTnSxdjg186qP?=
 =?us-ascii?Q?8uMwUHLv5wnsJiHx3v9+PpOUO33XqDXfYuiO80WmmrrHlw6n3FiMLENMSDLE?=
 =?us-ascii?Q?jKCMdZ3UGssSHNzvu51YoegjqphE6GPBJzV+BV2q1VLdZ5If7/FTHvfMl5Ek?=
 =?us-ascii?Q?NuSF8P6HDUABiUNEwCfNQJw14VQ7E9mTznKSgvEISm8Cl/a8c7jdJAHZyqRi?=
 =?us-ascii?Q?goM1f4KlxSlc1vH8H2aUiOuTpeFWc58gsxMtXw9NIt9gOJQ4+5Ei2dGl5ADU?=
 =?us-ascii?Q?M6eaXTbRuopI5UH0u4JQgb2gtCN7ruXqUgrKTXxbvNVHVR6glHc1X0Oo/KwA?=
 =?us-ascii?Q?F4y4GB1KXOZOEakCMnwOfQZDW2BxcbK5QTJlLqFqZvFfHzflPjvMXwkzXAL3?=
 =?us-ascii?Q?92+dOqDaqKkjMtshEm8nAx6ATgssPQb5Fuk5JGeE/yVLocnfRN2bE7FwUUSV?=
 =?us-ascii?Q?W0m2vjF4sKACoNloaVqkLZcACkeGEmJFTVLkEPFFOrmNDiW1yJQXbvERQEOm?=
 =?us-ascii?Q?btMgVSuJcoGFfrpiNsc417BBYO7IuCL8vAAwfaZidhGEhXo/01/B2QW9UgPm?=
 =?us-ascii?Q?xEGFHNmZYu4qlmsZm12FG6FmVTJXNHMnOHv0eewA25KuMJw75BP+QX7LkLjO?=
 =?us-ascii?Q?+4cmzxOLD03BZHtQuC2P4TdavbhtXntLZw4pvj1WnEyxSlLriwx5dQ9KTizD?=
 =?us-ascii?Q?ENKQiOiNi1E1ZG895FMuEEH5YMnin2GWPQK33Y5L3Id5+UbOjtJUFFA2Gork?=
 =?us-ascii?Q?SJS64o/djHWjysbfOEJgHed+cG0zeeE7oIKw1yvzt+pyfFokPUobdSQpPM9G?=
 =?us-ascii?Q?h3bS9AaMLjKWXR0fdW36HdT+yuK0H0NcqTYmWy24lIQOoFwrWCNeiEELaXUs?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bb573f-2398-43b8-da49-08dc20df1d1c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 15:29:41.9304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmGtDAkr2HWRRKmd+dw26GlamCjrySIcAgE6QCMNCm85PfvNmSvUlqUyD/Ka2p/6Ud/MwGRgQMTK7BaHc9ukHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7105

This adds support to parse the "BIG" key in bcast qos parser, at
endpoint configuration.
---
 profiles/audio/bap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 007e19f21..7faa6be7f 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  *
  */
@@ -610,6 +610,11 @@ static int setup_parse_bcast_qos(struct bap_setup *setup, const char *key,
 			return -EINVAL;
 
 		dbus_message_iter_get_basic(iter, &qos->bcast.encryption);
+	} else if (!strcasecmp(key, "BIG")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.big);
 	} else if (!strcasecmp(key, "Options")) {
 		if (var != DBUS_TYPE_BYTE)
 			return -EINVAL;
-- 
2.39.2

