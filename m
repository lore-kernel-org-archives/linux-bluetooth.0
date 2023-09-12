Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82B1CA0ECA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 07:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjILHDk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 03:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjILHDj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 03:03:39 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88D1E7E
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 00:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUanrmuSykX5OK2XsgSoUDLUYeUEPflL0fkpuQ013Prf8JrXw7gt4+/LsFW2P2JFHGyXE2u25/As4BYVYwF1jqXeT5v9DU2SbEf9cL5xy059yBU8h7VIVavbMJPMiPXJvSaLTuZ+kEo/gnq4lNryKCotkhOob8ThtphlQ/0MBIHtZ79S6zuMALbaq8wc8/nAkI3dMv9MWyVNgI+4EuuBcrZM3biKwV9lT/0PgUW4YYeDCLdUuJ9j+EiLn08OJutj0jns2ck+SFfSoUwktLJPKg6dMc+mXXRdYILSDtN6bwcHw6kv3VCwUaqqhOFVtXcb4YaPMxokoS3cx1+3Yq+X1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUnjU2GFrCO+6vadPVQ67FVFcx5DWwAQMRagY6thIQs=;
 b=Cy4xyzP1nxfkdeVEbJJZLsVO9g23N05iNBO7BKKuKRPLcpPnXccZoZ0qZUaSF7TvFsgGF/XPF6+uai7PBFQTD1o5ljAkdxEgFpOVER5KXaep8qdI/mgU8/K1y587zK8HMTH6PX8tHVpBT+H+bgcte8mdJkmbJLHmPCUc+zYvwnoQc7qfyi4BfAT7IFe+f4Shn3diIErTpksJNmZBULwY1KJ8phaASzdYIqre0vZ7MoAJwN0Oy1BbYFW7fQUFryZQM9yj9HkDuHv/mWNv+bAhsS8uzYa4UXdGf12rH6zS08VY+BQdOXYzp4oCy/aGTQGZZLlTdR7/ty4uy/ME01c/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUnjU2GFrCO+6vadPVQ67FVFcx5DWwAQMRagY6thIQs=;
 b=p3es0Txm9td4nvTU9k0eNyW8L/SQnzvNs1frcWAw9TPfnInn4rt+OLRPOgbqU20As3QIORKL98S/f550XtQZxd/RHdDf11MrM4rj2TBmsNgumUN32NoWgJxMxCcXrrutjpPF1P5k1nRfl+ny0PG5bQe4TZvQ0whtZDk8+kl06zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by DU2PR04MB9084.eurprd04.prod.outlook.com (2603:10a6:10:2f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 07:03:33 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 07:03:33 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] monitor: Use proper name for CIS bit
Date:   Tue, 12 Sep 2023 10:03:18 +0300
Message-Id: <20230912070319.1224301-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16)
 To PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|DU2PR04MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9ad3c5-23ce-468c-ca70-08dbb35e606f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBSd3az4B77nFy54pM3QADYcXAoFXGn/VITu5ulClwF/0urJc+kBfSz+SqXWiQQztyUc/RQXaLjRlGcmD7zMEUdjFCZrqJEEPYbYsKz9+OduxtDvnZ2vuJxmNgF1txYkb9/wMe9Vw1GRgxemugP0+K4fxugcoKvuo1pBELXiesBvOVYDGZ0ivZLYA+S+VbMli/aWP7VWGz6/r2VrmoJyPui7By/Ldpfj4D1q67W/hBi9rb0MWz8GfMdqMadICFoH4IsweV3oc3TISnS0u0qccrU0urf1qmzBYyD1hDTsfFJWb3Im2TCGfBBHQ8vnqe6w3Pvddh2tkeK3wAmTx3nsjtRaCjroLi7ao6/NZodb+j3GBRg7ueGhu+KTZid/QHlFGlCLlRcirF8Y0rKLnctmZgo2LFJF72RsTfA9KV+DXJQrp7jf3Ed0xCtatXxDNyw7L4tUfGKsKO0p/daJGKjzerwsjUk//qJiOBawN+/6SEIwQ/dv2SsZKNaEd6sbArMXjlNxA4DktZROejK8yTKgPYahf8yvjlL6ACM0A7Rkbo6CjjPIiIAqs9g5E5jonUJfWhwH/vHKYUhliQIjocM74PyWoBdv+euZ1An9THWN12w/M6vzySTPhf77tgTQZB/Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(186009)(451199024)(1800799009)(316002)(6916009)(66556008)(66476007)(41300700001)(66946007)(478600001)(38100700002)(38350700002)(558084003)(86362001)(36756003)(2906002)(44832011)(5660300002)(4326008)(8676002)(8936002)(26005)(1076003)(2616005)(83380400001)(6486002)(6506007)(52116002)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AA0d7HfmsJQ4CqkNiZXF+vgDsKekJ8paExqEkQxC+H1XVBaHp2tLHTjLqYO8?=
 =?us-ascii?Q?mxnSNNuBXn4/Z62dgyYYAnWgln5cWQp+WM0S1ndju3GxUigqiXYB8o0T5D9Z?=
 =?us-ascii?Q?WhSQeFwWJGpQcmo7FW8Y2pQ+/6Uq6ubzln9+2EQmZ5kRl9dVSFYmFeqPxfy/?=
 =?us-ascii?Q?vfh0jLh9zvPySRGSwY9edL4gmMbJHojJooBLW0p6huaKX+tS7G47WnXc+wSt?=
 =?us-ascii?Q?R4iPeUW1Uwxg2FRFZ5VWYiA7kRPx8lY/50SRLFWVK8rJvbT43SvJm4Cy3RNS?=
 =?us-ascii?Q?l0Piwsv5q7I/0kGyUq+XxVq6dNaZcHARyp5pvqRgAR8SvAoieHi4tW6u5lZ/?=
 =?us-ascii?Q?lrRZxQ4orLs7Ty2VW52zXNBfsHpuRVoH2dHSP9NepWCSBe9A4gh/ZyN3oeaJ?=
 =?us-ascii?Q?vBA2kgTCHbh085wsf4bFmzrh3KcMLeJ1jJsRol9n2X6CV9xvpzq+3NIKpKAE?=
 =?us-ascii?Q?i04HO7KqEheXnQYDFDCLDLWagzRs1FRnX/x3yEOVna2F2CaH3JDqiAM090cY?=
 =?us-ascii?Q?nIzoX2/SNeod1ct4S3VK6eqAFhMNcs+NbJpIi17fpIfTvcZK07JmFXBLKZDk?=
 =?us-ascii?Q?FcbGSia95anjmQZWPbr+J70+yZWBM5ZxMbFx1VBdF+OVOniG+F4VH8jNsond?=
 =?us-ascii?Q?R0rSet5GwAJm8Kb6ivEKkS/Mzvf91ncoLUiCdD9eVXa5EO/SEMFwlZFRf4wT?=
 =?us-ascii?Q?X1srio0r19Na+ZcdjyOmBRVYl7pglia6hNmmX9k3lPKHLneGiJPMuzF6khKx?=
 =?us-ascii?Q?W7RG3c43MrEbzpK0pzBEc2mauLXIBcgRt8A3C7Svy6L5GQ0ntgCkt/bEttWv?=
 =?us-ascii?Q?yJ8Qyt4PWBOhvq6GM/thucmRZHs+eYVF8CAhcRzRZhlgkXZDpDEli/gmmvnJ?=
 =?us-ascii?Q?8ylRhMNo48XMXNdEoecvDVSc+LVJ+zpsbnMqJ+uZYa1R17XHW00T2tLhSlEO?=
 =?us-ascii?Q?DXLn1tNqiupk1AleLqsT9qAEjQucMu8yPk9kmA8rhr64JM1z85Hc/Jlg7qft?=
 =?us-ascii?Q?1wkirTogC+UubLzGorZKRTBmtqmubxwBcYLNX1OZr5VC8GO7Yd+zkgvVbo5k?=
 =?us-ascii?Q?wqjIYBgcIPRB4O4B3Oxc8YKRlw8+lMzMuSlUuLUuj5dexAsWwBY+fWpPuJxS?=
 =?us-ascii?Q?IycY+qJ979J7KKzwM6IQjOTtQnbRhLWwYOFpXBh/FlQ4Nc403+WzhchsCu0k?=
 =?us-ascii?Q?/TwA5acMANdTisfiL3NHpEdF0EFk2m3a4cxxKKz0Zo8RMfbzela96FkzkkR3?=
 =?us-ascii?Q?haTeYt+pgZh0Fahu/b3pPTtq0IUPBA1Rn2JujF7mLi2Oj4djXWmF5E/JNwcE?=
 =?us-ascii?Q?3uVCktPNwnGnpQKskm4k1HXnSS67EBdOMVFFRR+3dytK60peM6xFl+5eKAE/?=
 =?us-ascii?Q?fGSQMKPaag+vtuukn+wJ6X9Ya4G4yZKV1IjYCcv1eAUy4GATusEFONp+bdaK?=
 =?us-ascii?Q?pR3udjHIGvYHkD21Pj2OFFC7JFcnk/wSTiJMBJG/ryJD121+bvNqdYSfmjj+?=
 =?us-ascii?Q?Xs7KJEyamSyb6x93tSWNb6DZjzivsZ1Frysjfkx9va7r/g4omeuhTtZ98BXK?=
 =?us-ascii?Q?u/in+tUdHs80f7XDHgkJJ9OG7dxRSI8h7fILTzt7Mn9tYStoGPr29csdaMQF?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9ad3c5-23ce-468c-ca70-08dbb35e606f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 07:03:33.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpxeM6JugGDBlouz1NgNMpNavTD6D3YMnIEaOuUwkAswcAuTqRTt1KwpugmkKq1a4Hp4Ky61T85PZ6Hns7vjjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9084
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the Bluetooth Specification the complete name for bit
number 32 is "Connected Isochronous Stream (Host Support)".

Vlad Pruteanu (1):
  monitor: Use proper name for CIS bit

 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

