Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E75EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 07:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjFWHqN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 03:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjFWHqJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 03:46:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6582955
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 00:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZsrrTT/X1vw9vZxd0F99WbIJ9c+lLgysXltGqwLh5cNXdBDZElVXIFnXVDw5EPFk28euvlP4HxSC0iiQeuRwHlVXepnQfYAszW5f+L4i1fypY42KbIWBq+R7WWuWcHT+IV/ryvq1D4795U+o5+7mkw5zUdMaaPsZ8Kez74082pU6OsQdVM/kpcjuZQ5epaePhBk7H/YM4rUBOib2kserxjCYX26f2Ua0f1g8XfWIezEZHKxqYlgYzC/ZyaCE/1KEPt/PxvQb9CqMoaViOjF67E/lr7wQXWGcIwqh6m77yNODgx4Eg2jXAJ3U8DILig+uegEH/n2Qn8pfFspPcrSow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWgymzdXMNnP9VRraF1vlwYddbxu8ZEm542rwG3Yd8I=;
 b=CPtU9J0Tn8r32gTjEMNbtwTFN4r5djZ6scK+YU0WYHyEo5v866JCnsT0hx4P2Dy2EVnXktzF/lxhYQYsFJ1f6OFwBPfKZHf7mBwqYi1qf491fZDw4aE6ySBuWHorG709/aaw4dNuyZ0jOQnSkaap7SZLHVDCbaKssID1uzNj2C2FLbmDj9u/12u+xdxOXXRrF9VTUsRhIU6Kqir309dqhvFf9ZuGQ41zMyMk83HetoN8KrQZTRsGnlwF22PJ2gG+ZkOCAXY90zRoRiyGWlS+L9+koU1zyVX6QYi3lhDSIUMuusIkBw4GJdDXSNvoTelVMGRSO7HuonjO2LRvtoacpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWgymzdXMNnP9VRraF1vlwYddbxu8ZEm542rwG3Yd8I=;
 b=sNyEyEU4HaYxy9JOSbIU+hY8JtoGypXG+gYNZmlgorcRF/rK8u/5ESEEKYloZ09meZgtxIYBdkGGoqXFtUhV1M2c6/Y8mLNmzc6Q9cEN5q4ml9Sl/pgHDzMpHh4eFe6bsiN8uu0SePpu1r7tehVP4TRVgDCVDKQ7wVksSIKcLd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB9925.eurprd04.prod.outlook.com (2603:10a6:150:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:45:03 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:45:03 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] isotest: Add check after accepting connection
Date:   Fri, 23 Jun 2023 10:44:05 +0300
Message-Id: <20230623074406.16522-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB9925:EE_
X-MS-Office365-Filtering-Correlation-Id: 899b2f3d-695c-4584-914b-08db73bdc148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sokLKUXUpiw/xU8Ic/Vw2U/l+fp6xgTiOKVHvLq/eDFU8QSXMilfOI1w0+adybusAxyRvIoiL4rhA8JcS9TDyXgVfxGyVypWgvZjStplgo5TemsUsWP1u06R682fEjBWw4bmsDvSyl9E30H9fASjdtghjpwyKojZDSc56pkQnfq01eYh3fmXZo/I3XDUF8SC1Yq/MMWe5CERL8GhXXShSQEV9ciWCvCMHTCuPBHZ4be6B/HrCSR0J1+mQnayXXXtV1/NnaY3QVHxzpo49R4Ee7BtHksfEhUvtu+14XBJuGP3YWWzsECHUvUafFeqGFZL5niV90IVAcMj7VMBqkpb9wsoeBKzwdiBtTsQQq+9NSj7sTAHXstVETum2UbDcICEPBSpqVap2ftZ1RGSDgqg5EDyyqkqKqHXDejWMln35tNgUzDe6xLfYoADDEc+PwI7jFKCtuDji7OoCkvJ/3xYkqM26M6tc4hjQXeYamd86UWC5TN1T0ArHzVPh/0OaLkQs7LY9zQHk7j5VldnGztdAWtYlhi422eFqP5lwnkS1Du8TbBgUZd2e5Q5tSLF92gGk9IvJsPKhNUq0kRuYrSEBAM1YHXip3DREFEApvPlI/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(26005)(1076003)(6506007)(6512007)(186003)(2616005)(4326008)(316002)(36756003)(6486002)(966005)(6916009)(2906002)(66556008)(4744005)(66476007)(66946007)(41300700001)(86362001)(38350700002)(38100700002)(83380400001)(52116002)(5660300002)(478600001)(44832011)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LtdQqDlUepTEfx/0X+/z/AIIQczWlA270rZoqr6Ye27VSuJL/mDc5VZMYQRu?=
 =?us-ascii?Q?F23rmUVIZfBqEmIjQVplWbA/Rk06YY3zFGS00v/9i4ZuyJKrfuLRyqM3QBJs?=
 =?us-ascii?Q?tijo72w+c4iIo1qIkOFqeQY4Dupp8RRh9b9reHbV6JY0wZqUxyGmCSdOxAPK?=
 =?us-ascii?Q?VWHwPBR3LvYI1FL8uM42adF3h1U/w8EmIyO3CPQ0kbZNlbTlnMrRTSaDz57T?=
 =?us-ascii?Q?sbfABMDdU9iyCVxsgoVgS9d4gXlqNsu4NiEUf5Zky/v2R4hTfQPx/hO6Enek?=
 =?us-ascii?Q?yKumvxaaqpPB2Ac2w/Z7RHt2IgICtd9JP+CjlcUsvo7kv8Fv9xRzbq1/V24n?=
 =?us-ascii?Q?5tMIkRYDIaaz1pruXzanygaLZ4uixzFKNVIbXDZkLO4qPDLU4eXlokOlYxjd?=
 =?us-ascii?Q?3y9xaxtIDZQXBZcsXTLyW2syOb7l/wGsDBfmKFJRdnNKbZZNbkkZdITLbyL3?=
 =?us-ascii?Q?+93DdSWlmhGuP0eeQizfaSORmpzu3SaftVowM9DqwTeb4s3VL0wiTmWRAEiT?=
 =?us-ascii?Q?1NYmtBjehzWuGoy7F2hy+gOtqporI00fOyR1nDRxDPCLXLtolZYJVNe86SU5?=
 =?us-ascii?Q?sWmmmXMCLeBeEmHj18Mt1e4oAIxdw1jp+rseIZi1PsUnfSz9cl+rBQpwccRR?=
 =?us-ascii?Q?ynW3FzxBU88uwGZD66EJQH27YqEZRSdiKzcIuOr4XWkIXOD+nQ6xGOaBeJ2D?=
 =?us-ascii?Q?w/7J8WYXO93OyBmZPjaa8IJ40VSaaXUVcAKRA9mmbj4gMkK3veCzU2zFyqO8?=
 =?us-ascii?Q?dn3usKLcz9bjlyFK+xUknyG9JamowuU+2NjZ6bH8+g/AE5UX39aoQV/+jK/0?=
 =?us-ascii?Q?xd+OaG9aZEKJ3G0rWFxGUFQBrisWz3D8ziPgHTuUrQinLxmmcOazi+SFYbZ9?=
 =?us-ascii?Q?EDZ51c+kBJcjhj+UA1liZ+mzuWL9xJ3LpCs9ZjgDRIvhIZ434MJWpPROyY9R?=
 =?us-ascii?Q?ZvjljB0iJUw81FYmCpXdC+/7zJPop1nPIRQsrcVt/jp4LSpudZeqJ/4wS6GE?=
 =?us-ascii?Q?kvhA2PciXeDj/MpqhYl0AuaEqFYNlOsSQ0v9kotGJsShcGdAmoHnnNHDLPGf?=
 =?us-ascii?Q?piWrJbHmApEMFUU/PnY+YRzzIS0+3wfMXuwx91DxzTw4e2gNRcw++ObJ5TZi?=
 =?us-ascii?Q?evAhJkMnnP5w/NHTLs2CSQTjNoc3RDZsnj0O5Di0/fmhhau8HKYDulqGCgKa?=
 =?us-ascii?Q?cu26s5wilEWfHfaxYdWc742b4sEbboKntI7MqlvRn5bUkI2GGdHApRRrrKm8?=
 =?us-ascii?Q?4a6PnQn1QZaS+SK5axfMtb2rWotCXuzTJDwgPnShVxws4WwQYjx2u0v8Rb3B?=
 =?us-ascii?Q?Zw1RvB3r2B63Sy/ppkvbAC/Q50GGXHJcmLw4/8wgIdRQj/2OJfpEfe4WR8QR?=
 =?us-ascii?Q?jQYgBtBqiBftbGKSiHSTBdRTZkxlNmxrBFxlo1g00ufDI5x17+KCNHEYetZ+?=
 =?us-ascii?Q?8kBiAkzdOLAIEmnfOGYGKWW9QeTSUHobaw8wwQ9ijpWYup1vC/A+uvTj2+X7?=
 =?us-ascii?Q?cBIbB4PIapwa6zTwMsJgXHKQFIGSQ4BW1/xTJjCyCwbziFrqZZpLYSkpMOP1?=
 =?us-ascii?Q?y79S5AxDVh7vo6PYvxB6z4K2y/zNHv1WKq17gCC0NUsbPOe0rkbWrgGG+cCC?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899b2f3d-695c-4584-914b-08db73bdc148
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:45:03.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfJsMGLPDXEtJbCr3gxTvvLwHNQvaKweYJuEyj5khXpcJ/A+pQnrXAxflQOgQ0hyJpXfWtWkTOKiDU+0wqjDgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9925
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This checks for the POLLERR event on a newly accepted connection,
to determine if the connection was successful or not.

This check is related to the kernel update introduced by,
https://patchwork.kernel.org/project/bluetooth/cover/20230623073842.16466-1-iulia.tanasescu@nxp.com/
where unsuccessful bis connections are also added to the accept queue
of a listening socket, to indicate the fact that BIG sync failed.

Iulia Tanasescu (1):
  isotest: Add check after accepting connection

 tools/isotest.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)


base-commit: 37042ca9c6ddcdbbb0899b3d62238935cd53f443
-- 
2.34.1

