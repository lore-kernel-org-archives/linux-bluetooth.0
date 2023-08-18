Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7993C71150
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Aug 2023 13:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377189AbjHRNgn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Aug 2023 09:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377186AbjHRNgT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Aug 2023 09:36:19 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6807D3589
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 06:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnP4W71qN+yJJrZMF1che956uY8WWg+u8GXNZGwspVcak+0I1D2roAk6gXZv9IL5FR47Mc5ugSPbongG+MZbfys1Xhc6CN8ryVDiGonz8EEhxJa6wItatEA6/gRyWiZ4t+HlOZ1xtg2IZVwYp4KaeqVfjOrM5SPunF2jUBK1Qpfyj4u8SMDDqYZMJsn6rU2GmSnnamt3WSPamygEmEJQwlHEy1sZEsbu+Iagqk3r7waULKOPqa4k/ZXIZZ+MV4N5Nj/I3abwDht+e0hpKVcHnnBCdt7czj0l4KTfgqTX6OD39g+AIt+/dnLpaaexGbPA35kD75nWEw90p72Bxk3MVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXmtftrW/2VWGBk7IfB0xlBTGRWpm1Prk2Q9r0xxnhM=;
 b=GWWpImt6LUDASyvCje/WHIYiHhA4kxWtXzkbPdAVinsF5d4OkvpKgUkB6ZJ64HWvr6JRCYFfkLczT9Cws8gcpyOpBzDh0MkSrKS8D+XG7ML6M1THpcyQJlz8SHr3/bdf/JxalMSFQbtozgEnMC3CalGtEDyHYlHfCDnsOfR+8sRlvF61BIFTOr8w/RW5plbhV2nbxmPjri0WYYnNZecUJyQ/NcDioUvDR45wEzTusrHP+2sFn0mx8GJaVvVmofKBh4WOJHHJI/EaORvGBpPyE2bTEEJ414VRz00+cZSL6WqlrUj4bA+LFdT5FQ/WMY3KbDwabM3wZLTI0TImXcJ9eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXmtftrW/2VWGBk7IfB0xlBTGRWpm1Prk2Q9r0xxnhM=;
 b=bCDTTHhuOqCrg8z2eq/wH24S90k1XqHylS0SUR7li02eb11gijfHJvEqYai2dODlINUBSNj1vAK7R8paiFbjnmAxu1MpZyE41o7FJAlaOnyg2qLMxH4uHXn0JyOEkawlD5lj0BNYmXQtzSFAV9ywCR2RcOnTPYPugb8kEpXr25A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AS8PR04MB8263.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 13:36:17 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c%5]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 13:36:17 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH v3 3/3] client/player: Update Codec Config size in BASE
Date:   Fri, 18 Aug 2023 16:35:52 +0300
Message-Id: <20230818133552.20673-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818133552.20673-1-silviu.barbulescu@nxp.com>
References: <20230818133552.20673-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0132.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::37) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AS8PR04MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9c6e2c-55b9-4f95-b837-08db9ff0196d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JzFNiOTAv7KUtonpoGvalBG+Ko4GrT7a73iPs84jZLRzhZpGRj1paPjJV4XFF+jD37XYDaf0PNdjg9fqib1dXdMBlAHQ0rGVXkNMbF7EpRA1PZ0rHagzCgIp+0y1QShmpRuwmAMtsgF/IH7NU90d5C36BrkwnS0TkLld2YDkiAihHarrpK2Qv36Eq/+04LVul5swkrO/uwhRVI0h2PwA/SlKipE5Xvf8+CVczxCZjPq/k4oA4nj8I5enjrJDm0VwbV5kwgWB5211msOmj47TJWVun++fh3gK72nP7FoFYGoxgphifDAaKqcQuRWc6IMtHX3nHLd2wj2rpZ66g/iZE/N5BLo1Vtw/aQogVWAO0MqkZDbUhb74ZH00b0RSh524EjoMFxhO3Q88WI9+GBbJ9qEFYjqEIWIucCLXZy2hc53cfdmwSpDnsnhap2U7EKpDWdbU5Cn8Dun2M/C49NwF6CO1+Kc6xxZfWcOMbHuoy1m52xJ+GxWz+b0GzpRLx9PHdvgpXdfoBSW5DZ31Qcxdi84FsueoavteQPqJJCTJ1jBzLS+Es95utu+Vkfa7C/9XXIBiTZYhpfqs5BfVvNGlFEXhwVEOSF2Qi5RDEOvigZ+yDaFfkeafdnOZTUOWUcc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(1800799009)(186009)(451199024)(86362001)(36756003)(66476007)(66556008)(66946007)(316002)(6916009)(478600001)(41300700001)(38350700002)(38100700002)(6512007)(6486002)(6666004)(26005)(6506007)(52116002)(1076003)(2616005)(15650500001)(8676002)(5660300002)(8936002)(4326008)(4744005)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AOJVNx+uRDjXBLyxx/mKlFGZyncKbuqcLYV3elCKX3BbFzrbMSeOXZnoTAYS?=
 =?us-ascii?Q?ZBSV9A7/ITebWfdWAxkTRwAccdKKv6MwrucWzbNdBEM9d/9xzynkA9JN8HJW?=
 =?us-ascii?Q?tYFijzTHimRqyhqld9v9ALNUDtiwXZJy5JxM1JVc3qcc56gfBLhVZO/Xuwp3?=
 =?us-ascii?Q?rxy8r3nbKsYi7wrBOO8iTyW5469CNXLBOOs05m3ypZeoIEcHsQB2WuSKJZmL?=
 =?us-ascii?Q?Rv/K/Hnu/KjYdp9gyBRreDYFRjBz4baSXuM3Wfsc39og2S79MXxeY5fTzEXS?=
 =?us-ascii?Q?yGulYHhylMUvnZ6qdJNQ7w2IVbjysyhmEPBttzCkJAHyjo/KCVntWdSyg1Jk?=
 =?us-ascii?Q?AHK0d9jVBW/EzCu+EDMZ7kw/vhvuFiUDSA/vmQyXZzWegg9wyjCMM2tzZ6tv?=
 =?us-ascii?Q?GfdjBh1ZH/mkVLU4KtObZye8fiLhvMMfBs+XQH0XeNXp/19Djfz6KJWdRtsG?=
 =?us-ascii?Q?XPLCSDwuiNxINhv6fcj2GJjTAOWmtXI02xgJA1aXIhG12wGnuVpJKIfPtr7i?=
 =?us-ascii?Q?r7zZ7ch6/GST3Mjf7oiH4aLAu06cU0RhHbYnzBNzjfGDP1wNR2jAS55lhsg/?=
 =?us-ascii?Q?6z4g+akGYRNHfauVdWDNTGsV+V6w/kabZydAzg7wFcztyY5IJFrehZjSYcx1?=
 =?us-ascii?Q?DLKT6zHQkE+MkEsTjFGyWg4HAhQVt8vF6DAMfAQR0q+qcJTF1qqsevDW3BtV?=
 =?us-ascii?Q?44HdRvxuAnOBgF65Jv1dMckup7NrdTgIguMEnmpJG1Z2lHxjqAbYvlewlRfo?=
 =?us-ascii?Q?xy4GE3lXe2z87kklA7UMeUNsT9pM3mtpwaRF6DuFDjPCcBKSGJF9S25EPheP?=
 =?us-ascii?Q?QuJ+4Z3cpoNc+rt6IbawxHw9I/FOReylWru+uxTlBSZQnLLj5eJz8c/z24uN?=
 =?us-ascii?Q?5B9Dap331OjJWuGWMY/TgeLjhOxJGTSiRAxflVnReZlcNsuu21Vv9j51PJ+Q?=
 =?us-ascii?Q?3gECTvDdeYkD+ZAsrCYPunckV7XaiXGdhr8w8zQ2T3eZ3kj5tByfEfQqo7Iv?=
 =?us-ascii?Q?FhfcDiDG0qv1GDqFshOouqyI8edKRIJJCnkA3AWmuGhaW1FROfWVyho6QsDl?=
 =?us-ascii?Q?1MXS7rMde2ul3T2iwQHQm3oXVpm0p92LoHB7fpfQsvo+Q3t8+Rfr6KetX4xL?=
 =?us-ascii?Q?xeZ2tEWJCbpNTjsRs4utrcEIlT3zKVxbgNy0fGsnXPxS3FMf401DT4RYD0h+?=
 =?us-ascii?Q?EvDCNbFwm7w3f87EKvXNmImL87SFIt7FjMcUABXpjzY/2Y6pMJRyGsQHlkq+?=
 =?us-ascii?Q?fmKkZ45vsU8qKBzh0B9ZIDhgp5JNtFzQx2f2rBV7T+gdDxbkUZ1H5edmdsQA?=
 =?us-ascii?Q?37Lb3P8tx0meqK/Ty3dKgt+EYOuJsl4vJe4q9A3xeTNbxsEfZ6MaYfaTlJhQ?=
 =?us-ascii?Q?vjJf1yZ1DmlX5rVJpyTgGjYqFvdX7N1WVc0G464jxD+djPl6RNTErYlY6sFe?=
 =?us-ascii?Q?l2WzaeREJUTZYBC1rY72XakfNr0ULjmjWbFkpV2HWCAED3Lk2OUWxvhpHPET?=
 =?us-ascii?Q?IyOVELFtFV2KU9N+QWDNky+pevNJkFuDpu9OiOkEFe2sFrPMuSpvsqncWjKj?=
 =?us-ascii?Q?+/ObHAs+Q0G8pJNahWNLoGYja2t/wH4d+2D26mhmskW6Nv0Pgc+kEjNB7zgS?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9c6e2c-55b9-4f95-b837-08db9ff0196d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 13:36:17.2304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skjpMedF+/sS+CQeFWnQaWfkniRtewJjoCzPs3vIqIurrvffsyAfqiyB07ksOPok+vsxHVMro/RU3xrJrjxTPjELG2PbabU173RddoVuuIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8263
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

client/player: Update Codec Specific Configuration size from the base structure

---
 client/player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 3611a8dfe..97ad4dbf5 100644
--- a/client/player.c
+++ b/client/player.c
@@ -111,7 +111,7 @@ static const uint8_t base_lc3_16_2_1[] = {
 	0x01, /* Number of Subgroups */
 	0x01, /* Number of BIS */
 	0x06, 0x00, 0x00, 0x00, 0x00, /* Code ID = LC3 (0x06) */
-	0x11, /* Codec Specific Configuration */
+	0x10, /* Codec Specific Configuration */
 	0x02, 0x01, 0x03, /* 16 KHZ */
 	0x02, 0x02, 0x01, /* 10 ms */
 	0x05, 0x03, 0x01, 0x00, 0x00, 0x00,  /* Front Left */
-- 
2.34.1

