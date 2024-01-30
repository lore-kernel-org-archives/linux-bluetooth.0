Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1E482D76
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629464; cv=fail; b=LPqumggMiZwJwNdOlqHG8k18cOF+Fl2auXW+O21El6yTrn2HyilvkbInCXfWi10LwJEpSSSkUGdAjGjjhyJW7tkRJ2fhle2j9wJma12isW6WTWS6F8CYfh+PkDSb0XNTfDhq7JpGy+qmCeyyYiOaBHVhNojXxq6X5BmSQda8RaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629464; c=relaxed/simple;
	bh=dfAEbepBogGG50oThiFd2t8ItcAlO6d2c2mkUxV8Kpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NsCbN/guNOUhfeIsA5sNe9c1rqjUJXIDUrSAEQvco5vT/2DvzERl8Av5gai68WrQMowYyMUs40/57I6z7VEf2BfW29KpKYER1wy6weDvscVAdgSd5sgIWjv+S890Fi1VWPZTsadFjk7JmJh1kUZtuu5T8OmYwSNtnzdOdNQYaso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jTGK27xB; arc=fail smtp.client-ip=40.107.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jTGK27xB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ms+UbhRMEgvryrv0xH1iuHuKfFvINDSIzLl1JaqgPczTjQqvXxBGnJT8Nz3h1xFo3EqivR0Lsq6oNoMddOG/6wem7eoXKfNog2QHGWmmmv2FCHUtIogrJ/ayhrrHrq6BZFDvruJMbBhCxtWqsUXQKbWADtxN8MCL2rl0S/uuU6aWbctJtr1y4ihaM6SgmQHtg/7F3+egLSyAsqo2uvPBGswhozZ45L3jGKhKRF9E5JomDi/yASPk4yWz/3bKFn55XFZ80VtEaXTPPx4A0OX5oaQ+Wmgr3TVhXSygt4imEgiLXj21xIl9qT/x2ar/ed+ZvAgT7+FpxY4sGcUEiSRKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ltwxP8dwaacvkxdQhzspCiOzWCuk+AaeT5+lNBLBCU=;
 b=OyiB4qE8qiQEXPppNCSwJDThJALkWqfeHghknhRLsytibCh7eZsvmJynZdCHKfBqn0EZUTvg6OG4SbxVOoIcACIQCe30tXs2nVboxhoW/mYGO/7viNHlxxerQjaX9AVcw3thZHOf1c+NN2oT39XcyXk/sPkNUy4bhbp5ngB/HGeaKjJWB1nu+k2tdLcTb9ESIo3XsPXuBPT7gd9FbCDzFtxLFOnvSEPtg0E7yPQXhxpF/M6oZX3SgfzSXZ/wZoCYUc0lcUNx6cfqez/JJp1LE3ReflRot1mfzUIaMIktQ/UslmNYSuhkepNSYfr63XEXOcyUSn0dvGJ/UJHtqF9K2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ltwxP8dwaacvkxdQhzspCiOzWCuk+AaeT5+lNBLBCU=;
 b=jTGK27xBSuiNpRCRtUJ4lAQrue2otc2kJvIHCLZMRFI9OyQdPijWE4Gv+emlSDwAGm0Z43Z8mriphxOA3eGtsG+nIBZgbiNaaXSWLN5Tc7e9KpRth8FsXxXTy5Pz4aqbDCRc828YOgIED91BSPl6En9tG08idKHJaUfGqocwRSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 15:44:20 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:44:20 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 1/4] bap: Parse BIG handle at endpoint config
Date: Tue, 30 Jan 2024 17:44:09 +0200
Message-Id: <20240130154412.3157-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130154412.3157-1-iulia.tanasescu@nxp.com>
References: <20240130154412.3157-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: a1386abe-83da-4104-9fd0-08dc21aa533a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o/ScD9exsqidJBonHFUcejcnTc+o0xTxjMH1RMJJls72TK8IpyMkhVS+4JMuj1G6B2zD3yFRv4wonCh0nsk/MmHvFk2EdHaVfU/0OPsafx7Pq1w/7xr45m5TmMK8oBktlVqpY8x6Rv07BZUidDOXZrsKOAhlP6RUD0NxcoFYpjhmp3zq4et5x2gxhELyJ/dwufgGoejGy6nB7Sco/hRfuYvDPlEe/jMMV4rGQx18lVYsXHnDhtgfJpcR+EdwY10Ykp46EDIjf4z9ShqDslFGlbQL9xrxDayDrUsl6B/OWxthczIR0By6DI54r0CUClmD6YrUWyEtda99f4zw8+eqqdE4YRJB7iR+NwqXXCf7hm8scZx7XFlAN4lyhbCNnN4KDuFNNohHNSokZsHVxkdmDuvsxvwAt9Mowrv0338sfhX5+Lr8/tIxUm60W8w8IFDkIMmTx4C7EX1aE+o6FVhqqNmEH94/oBiv2lhbRfrmMFvkppxPF5mo+kEI3l/+n2kVB4S4ZhpJPRo8lR4WNjaAo9RpYi442S/zK80SbDif2Rv7LUZOgy6U0rb4+ZD5TNXY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(1076003)(2616005)(41300700001)(83380400001)(26005)(6666004)(478600001)(6512007)(6506007)(6486002)(2906002)(66556008)(66476007)(38100700002)(6916009)(66946007)(316002)(4326008)(8676002)(8936002)(36756003)(4744005)(44832011)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YpvT5s7DWxnBDziGmeQr4Y8p49ZSHzBI8iLUMFY+OLUZCgC3Ez+cUMZuuNer?=
 =?us-ascii?Q?jmfUvzFIaAy+C+cpQCpYPdO52YxFoA7d1ZBLNEfMAjLAzZE8NTG7g5UzC+3p?=
 =?us-ascii?Q?4EnyNtnIMF32YJ+g9NV4P600X/+BKOR2k3fVnfzHt+1sN2/gxG77OAobW0HU?=
 =?us-ascii?Q?92PNTHtcX3jydY0Zfa1HDkLIz/LyrkrN2SoUsC7y3hBFTyFdJAfv8YwWtgnz?=
 =?us-ascii?Q?AMC6UfmXpTy+l2pshrURaFeV8hz0mx90aZf5iyiTWFkWyUH8moNwgKAQFpJj?=
 =?us-ascii?Q?+RVjzx/oO3OkYz4LP/VeVDEnGFIO+F/qU5jrr6/uaTMSINmfT3ovA1+3Kb5X?=
 =?us-ascii?Q?Oef4783JiW6SSfclSxapdmQau+QPQhqgZgHOv1p0jllcONSY4dAcv/cfYqtp?=
 =?us-ascii?Q?zQpbgKJ3AaYBy9f7lrlL1LoHPs+ArJoGI79PCs6S/6r6bKQfFZpCmSelqxfd?=
 =?us-ascii?Q?STnRXAJZeX27F6FEcitbkZQv/IrwrB2heS2OZ+lF+hYop+98xFBE1pvSsfZg?=
 =?us-ascii?Q?1zaEJ6+r42X02X+arwQx49T0PeVZc2h6DyZNTbrcZqOeoW27JMxKlzFX18mc?=
 =?us-ascii?Q?CVlLLtwvAOXhmXVSymPpTPeZTQmM2ybuW4Y+J3S4G6hQDAzG+KqqGNzgmcTi?=
 =?us-ascii?Q?z32mqKT9RS0BzYazucnmcdUaOE7zdlxrUdjqIO74QKG9g4E5bF3DMxKt0A6Z?=
 =?us-ascii?Q?wjC4Fv9NiQojqCVaYXXJBR18CE7geMAaq6yA0knh7OA++vKyQa4Am6cjX8DP?=
 =?us-ascii?Q?H70tvU0tsnndfhuqWyU6zEMzAm1kkNNhsjQV4EnlcmchnFLUJrVZUibDPrVn?=
 =?us-ascii?Q?GUj79mGeoNYV8ujdhO5tu2yByZPmx5JTe53R1pxLFvkQWxXnrsnHRV6AoRWB?=
 =?us-ascii?Q?EwDoMd2BAcssNKp0eLaWJckfDqO0v+n8Wv0+uhl5L8OmAGjIg7K8R5QteGc2?=
 =?us-ascii?Q?P1S17JqhMrc3mow5OrMC75NtjLwaKTUt1J93/CvBNgiBBTallES4HnXAUXgr?=
 =?us-ascii?Q?Opbi5tZVjn6wCCGr7CieA2O+eGSDxusvcMuGuXbRz0+3nRK7RpxMHTr4ha0V?=
 =?us-ascii?Q?/IiO0UAXYIGr96UmGv+dt2eZDkP1wfkFV9twsgvvsXqpl8IsAhDK9SPXvZbU?=
 =?us-ascii?Q?iaOObzQSyl0G4YanIcc1CQ+h4hRfk+SIy0aznBQ5jUhVLLLrQcEG25zLNM8t?=
 =?us-ascii?Q?5DznU2V+xVnIprgdOJgkK8FFUOV4BR+eSLssuGmd1Xoos5i5PgRa/5AgVRCE?=
 =?us-ascii?Q?IoFQar8V5EAvCcJAAotbinI6CyKyBbKT2mh+T8ufs1wEHdwuwG9kFaA/I8ZI?=
 =?us-ascii?Q?kO7wxFN0GqAZkOJobhw+5/PEKwOqovJ5/aKCACfS1FohlbttKdGRBZqlEz1n?=
 =?us-ascii?Q?OFu63CkjrYmPee96cKgBEhGWq/vQaWByqZPOJJMp69c+uEaopG03CADPriyz?=
 =?us-ascii?Q?TuFQa3bUoqWagRQf5vxo8j8VCs3eC3Y+4KLxDnOyDXE9QY4Z3sLyIKkikJiH?=
 =?us-ascii?Q?uY9GyJJLwMXnocsm/NYF0WZSbl7+E3K82+W0+yuMpyoI+Fh4A+9vrrcCDKYO?=
 =?us-ascii?Q?sH6wh2EA/2eWboO83Eg5+meBgzukUxYIEqBNdaL2NQPVWcyb5/a7wzIW6xjS?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1386abe-83da-4104-9fd0-08dc21aa533a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:44:20.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFUFnjxihHLnnMcqzNc07w4JVniF4doN1w1dgcMQ7Sa83rXTrSi/C5NWUghSiBF1MaF2BivgazVfZXW1Evqmzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773

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

