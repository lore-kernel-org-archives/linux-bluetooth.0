Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA47EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jul 2023 07:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjGDHmF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jul 2023 03:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjGDHmE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jul 2023 03:42:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDABE64
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jul 2023 00:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl1I2JIToguWwWuLxDydoQG65XbLrMfc/67o3qz2BL2tx5+/S/8NX30zYSlhVqJVIIK+y6yszO55PUgavZ8E1ikmJD3jxAvAhxcUSU3n6vLGHNzKVd2x2XAYuRA1AaSLUKqaKxZNjngpUSAdn74vZ1M4Hd8GHsi61QLZutkbhOxugIC4QehdDubr9SQGK+IW7YfZsqL+dvGGY1Fsqg33CBnG3DlD6oH1iHWFa14reMOCD9tHG7FcDpwkVfg/LksuO+3Vt6/NIuMlalHFAQfXEsk2XGV4550aSG6KVqDXvkK+J+BzG5is2+RvRp514JeklwSndy4s2u78ZzxRT7ve+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcJUE/Dp0TRcs/0Cjzm6qiUBK6X4Q5Lx7D233Tjjsgc=;
 b=QUNtqCJ0sLwOOZ4SwjZnATGbd0oSl5hYvlSAfrNOBozWAOwkn0opXB3tDmD+JTUGbEpo4OWBftd33rsWBU9emMQC/wRcQjJJC5ZUc5tyBArYM5myxsQQukThdALIHPAzYey+QwsmYpeHPhhg+B4NCFTjA9agwUINNVBq/bTT99rIuvW+rAvQ62btVGDtYN1MEb9MXPE7Tdk95EBMP43lMNMRi5O0NF2KWA7O27Js4TAWpW+MXCpxVPwjaawYFvYCzmsRsV10QCEcn6mEyRsT9oJ+MO7rcUf8Pu2oOQAhsDlRfNoOHUROZ7gaHO29x48o4tsTDz1ge5TrwazQ2iZJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcJUE/Dp0TRcs/0Cjzm6qiUBK6X4Q5Lx7D233Tjjsgc=;
 b=qM37FjCm1AXeq/n+yGO+eLFIMcI8hYCH3VSgZBC1u4/FN9uyoOO/KgcIwBTdpmc1h9YYljSYtuYeS6jnK0CEGThGSvEH5emUtEpFKET7wXsP4GPJujKav9w8LzdAUK3FF+taQ68l4GGNiXfD8lynjf9tUZPxrSCq0aY/iUMYYuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PAXPR04MB8222.eurprd04.prod.outlook.com (2603:10a6:102:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 07:42:00 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 07:42:00 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v2 0/1] monitor: Add decoding support for Sync Receiver events
Date:   Tue,  4 Jul 2023 10:41:43 +0300
Message-Id: <20230704074144.5587-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0171.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::20) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|PAXPR04MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a976b4-8387-4ef4-00f2-08db7c6226c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEkEoZxROwRlOrX22ymXDTXWQfGr8wLWnEORLZ+7dqXLptUNuQZlkL287slt7Bf84ETuIx4BQzsA7guxjef6gVm2PvYgijD2YT1FMtbR+fTA6Kd3IM0gDK6pRj8qYCNo99wPizSY9wO28V7lQSF0uaqD2AHsbeXv9NarxMJDQHAY1fb1AJee1J0bengk170cuEEwcsF04ZXAPKcl6IYJVuM+Ppolu55F9d15wTijp+tgDacFMDmMwIeAVBGWSBCUQYmiryIg8NAclwu2NBuMOP5nSzYzSZrKdFi1ceLjrUyVKzuKN+Vn5RafqOY5fFq4twQlOT/QmMeJ3T1FDkyT6rWRCh/YxGhAw4+mOZfpFMfl9ViDHnlh1CxFBYvvUDOtnqCeutv78xOhwGG+27FREbRJkZPKKvMksqJRb7thByMkivsmGK8un5gm5+gxQcY/KFdoFSW2q4YVxsJ0o3GOSZSB+XoSLiZadFa7onEx3br/xH8tEXYljCCuJtXVl6wOjwoYqoh/alXAmvpBfZDyR+kN3hM9/V4+2RIHtbqXBHqMENtOnEjZU4VtxTXlW2a8yN640OVsNsXULAfW08YYLQJAbuk17qHK6UapcNXLW8y0J/Js8Jb+pCDSKGJJSDjn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(52116002)(6666004)(38100700002)(38350700002)(6486002)(2616005)(186003)(36756003)(26005)(6506007)(6512007)(478600001)(4744005)(2906002)(5660300002)(316002)(66556008)(6916009)(66946007)(66476007)(1076003)(41300700001)(4326008)(86362001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zumqKl08J2DAQRueHs7Qr1cgzwwJiwsRWDcVsxne6mkZSzhImbwZQFXzgQBY?=
 =?us-ascii?Q?t9PEe+bPXj0Q300RvnZ4Gd0n04+qPxhF83WwFV/R+E3BIW3JJf4Wk4z80yLj?=
 =?us-ascii?Q?dqH06UzochZALMQV6zRxjLXGm45GT317n9u1DwK+Tkl9xp1vRZ85V5gJgwME?=
 =?us-ascii?Q?KWJ8N154/AhwzGKl8zK69HC7TCc/gnL4nFXg97W7+x9XtodMz3FdyV0z7gy4?=
 =?us-ascii?Q?cFGp72qvevZIQMBRe51orRgK1Nc3esiKiitARuz5SRXKTPcMDOrfNpRaJeW3?=
 =?us-ascii?Q?qkUuWWoz8S5KsrBp5LYcSUuzWA/oqepESABLYYSULfpryJtoD2fr4Qhw+2hS?=
 =?us-ascii?Q?3nYnsbWe1BbgWo1Wb1nc/OBowH4a0wKuf0U36hCnltePyRWk4T3gwLn0hm/P?=
 =?us-ascii?Q?zbn3bdHQ7jrp4ZYmjzTM3vmW3D2dgYwGAU0rlU80bjdruslIcDIbi/OUl7nC?=
 =?us-ascii?Q?lcZbZ2npgcTt+qKrEuh4mgyjlN9FxrSiNidLsMokfrkUVlaN20jKZkR6WHNm?=
 =?us-ascii?Q?rw6fSgCE3wPbgU1Y+dunMNXhOBhOaPadoaR/5O9dQ1nZ8AGoz6anxr0epnB3?=
 =?us-ascii?Q?9CQjRKHtq0JzS95KUDzu0IB/7OWjUu16spd6evo6NWMMNDv8uaO0nWdpFPQ+?=
 =?us-ascii?Q?YhxrZKo2m8u7+fq5IQJ6s2RySjophYK+ilzBD6mo4WqE5is43abGy8dvLSuA?=
 =?us-ascii?Q?OSc8iP+nYDq0oQ/mSWUtdbFJOc2HFGk9ltlFG08zVLYuOOvysBRBWtfqz87Z?=
 =?us-ascii?Q?qqp+CsfRwLIv0ExOF8hpIRcCZax4Zcb+AxubowZojbH2Fzu6/SLiAjSNbLMm?=
 =?us-ascii?Q?0fw2UuP6nCczwJwg3NqQ6vJ05z2v7hkxm33KOkJFrxOwNMZPzlOZ2g+14ivm?=
 =?us-ascii?Q?bgjap9mjkfp/RQjcg4X+WVQVlRgSJLopjFmRnVB8H0DOfQgush/PCJBbrbWh?=
 =?us-ascii?Q?ga8QI+ESltmLzlzIYD6iRksjAVD+TGALM+vmrooE41gdMlxWqKfC53O77B88?=
 =?us-ascii?Q?JLJmn5cRT3QFY12kEYpQmgdlGFIis43c7zISuMlMoJ4K3aksNikMuTbEY/Z8?=
 =?us-ascii?Q?vsMJqRMUrnptPJXJOY0XBnxZNddfUhGliwNNgzfP5XtAuMAWYDWJu7mSs/z0?=
 =?us-ascii?Q?CthrZW1qenA50q6pJBvDF8fzfYjcqeraW2jS3lEANuCC9TLQfhzevxjEqMI8?=
 =?us-ascii?Q?jJP/5uGvbrNOs//AZ8IUvtEsw0M/io7nkNVv4UwuigSnH3kpUvVs5YCtHOEl?=
 =?us-ascii?Q?UrVTPUUhP7Z2VqiO1bmX+4c8XJIWtpjlMiE0P3Zkzxt+fQCsLV+T6mD35bfa?=
 =?us-ascii?Q?DCWPXCiKld59FvLw1V0xB/bORFowCGehOd6y3XpoXSNpt+2QKI0JDtwq0klS?=
 =?us-ascii?Q?4w12jYwXKGPY87Ya4U8tDgBQfZ9G2AYAEfEDzby4hnWYB1L0kMx9fm0aHiHy?=
 =?us-ascii?Q?YKrhNQ+AyBMyK6o+lLH9vdLNmkIsTyLjESB9xzNyIUl3SnL1z8Xxi513Uk/L?=
 =?us-ascii?Q?oZnzgx59PLN/+fjI95hWC/99PmJXD8cEzSJUGWSXT8RwpfmBwBOM6Y8ZUrbO?=
 =?us-ascii?Q?+JUNPf1sk6PaoFHjJ+Aza13asfICPkq1LSK/0jjK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a976b4-8387-4ef4-00f2-08db7c6226c4
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 07:42:00.4365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kq/Z9Ai5Mx/oz910wvXsl/JQkGeaCOJ7GoMHgPB7+f+etcUNGAi3C1lbehy15BSUgsFJgELQPURjsXK6/lH5Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8222
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit adds decoding support for PA Sync Established,
BIG Sync Established and BIG Sync Lost events.

Claudia Draghicescu (1):
  Add decoding support for PA Sync Established, BIG Sync Established and
    BIG Sync Lost events.

 lib/mgmt.h       | 3 +++
 monitor/packet.c | 5 +++++
 2 files changed, 8 insertions(+)

-- 
2.34.1

