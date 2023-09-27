Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7007BE80A92
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 06:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjI0GYx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 02:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0GYw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 02:24:52 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ED097
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Sep 2023 23:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDphb3vhCdSb8huIEvavBgvznL5uoMS3Lytu5vlrw+JME5eb0XoTQmfMzbrVJBDiMrmdAghT+IArX4XB1dr3DhML9lKFM1uF6T6/p2eyOLxEyhEacE3XELCxahvsuTX7E4uP8ucgu0aLKXJ3CUNgrHT+s9wTeRYjBb3WtE3OwRuKAYoYeKDpE3jLSzYAFDOjEvrY5VeNUT2idUUtKweikuIhg2w9NZ9Cjt0VZULs1hn6Vf0j/g7XMCqlrAtw0/2AOeF5oZhSDQPAVbpF7QJfjLUFDv2LS/Akkv95Bgykn4eZgD6gislN6yvjTV2nDSCQ/5ePbP1u7PEeG48TikY8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dbdTBK/9Z4KadnDga/f3becL5GDSlqGSXs2PMT+heQ=;
 b=Fiyp2oL4hvI2psFCndtPjkIkoNExAN50yvdeR9mfONIp9GDwC5Sh4qPP5r4hZtcbhqIEoGT6UMbAlz6WtA6lG+LLlcwsJC8dXeI0kYW/qvlQsTNMy4pl+HftTS1RypHDMKnKjgV2uIXjIIZg7nn3RGQA9XrCInCho33zmSfXYn5riyjlfpJyuVtpC5YrfjxPk3FSD0oBfqWYu/nx87sNdrIw7gsnvBmK26qLtlOlu+/Ws4T0gowV0hU2+frhz3xeAhhT8nYiZq/nAoXAjZtPhhi4W6JkbHEj1AaTBtj+KO3tbX5vujgyUjAYsKwyladn1Z9IX7a4Bo9MJGvmPKTvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dbdTBK/9Z4KadnDga/f3becL5GDSlqGSXs2PMT+heQ=;
 b=qi9Ajv0Pg2qtuCST56f3ne/dAvUGXTdHNgc4JvzEtIivSTM9n/+9Gvimx20nDUtmP3zeL+MMte27PZQIEW2Qqu1hXhaUlAvwNZqFOlmphZ84hU0u14vzSw4G4iCk+Tg4tL56g3sSMy3Q8dYr3GGeNYl0l6K50VDdHW+3S+SbXZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 06:24:47 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::20ce:af06:5cc:a1a4]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::20ce:af06:5cc:a1a4%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 06:24:47 +0000
From:   Andrei Istodorescu <andrei.istodorescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        iulia.tanasescu@nxp.com, luiz.dentz@gmail.com,
        Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 0/2] Memory leaks and memory used after free fixes
Date:   Wed, 27 Sep 2023 09:24:34 +0300
Message-Id: <20230927062436.6306-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0020.eurprd02.prod.outlook.com
 (2603:10a6:803:14::33) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|VI1PR04MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f248d6f-752e-4c24-2a9e-08dbbf2272a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMdlnIdCHBdymzXRo7NZO9cfpHsYUQNuDt3eXjyuuYRaYd+3576S+FpCYua+KRS5NNG+kN7kTd4mTWC1S8XnK9EFqToM8hgyXDhuNR2bwB3sFryacQz0cLp4tOBzuWt8cB/pLmxrRHJG1etKSD9+JbGKpCvvkHkGAw3I4OsBr9vnRMDd5ICd/H05KommTisN757K46Zu7/8KwtsSV99RTXmWQ3f4fNroUQcVVfh8gMhBr6wInGqwFtsaSvAGHfui56IfTN0GY+CFqwh6CZZGtTrd6lP4jSpFq3NChZgzZp/xN8bnZ9dFSns0rKWGbBdodRnX+kRK3u5TcyDRabT9UCRFTCLbREh9ZgmF0Y+kR2h4KRA6C0As6a6U0WSzviiWX7l4c6EsQBDKxdSCoDLqcYp6sMctZ5LVXGB/5+FzJGg8vJe9B9JoW7tIeuKVBWcOSv+bHgsEMjl5ewQnymiXx4McTRwqCU3NcSuvFUz5ZSJ/UHE2OZMFa/jz/A79Qg8Vwzp/TjGzullgmsuPHcCqUl5E3gPTUgmRZWZKMXgDREDdFI44t0oUNkubvNHtOrW8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(4744005)(316002)(5660300002)(83380400001)(6916009)(41300700001)(44832011)(8676002)(8936002)(36756003)(2616005)(4326008)(66946007)(1076003)(6666004)(6486002)(6512007)(6506007)(66476007)(66556008)(26005)(86362001)(2906002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kfbdcqyhx27Zo12GZcLkxtXS/S8YU+3ZCLax6zvJYRnxPASaW40wOC8+gh3r?=
 =?us-ascii?Q?xSyoVmLLhW2SEdI45j6pDYB12qWLcMbKWclJOvremmH8OqANYIAmKAZrqTAP?=
 =?us-ascii?Q?EJOHCEqtwXEIT72IKmxD/VHVE6klQ4keHS1rkm4xFi8edlG9KMCBIZR2vqay?=
 =?us-ascii?Q?PhiuPHCboITPgb2ZwYWiy1pw6MxbHiS+n2eUqHyqf957tpPVM9REa0OBrjJU?=
 =?us-ascii?Q?C+FkuAE3Blm+Koe8HNxORqz6GyRgvggu4If2sRM5pFGGzu/7fCA+etIc8997?=
 =?us-ascii?Q?dkQDKiZyIvvCGVMq3y3nT1oKlYzxyWpmdFPp9I98dSVIpZW7BfIDfGMaEONj?=
 =?us-ascii?Q?kjYSDsJxpDjw7P67KDrVDL1Clg8mbtYoOWgaTd+RPi1Q8OWbLSZsaNZ2/ACG?=
 =?us-ascii?Q?u2SPgRQ61jPVglE7D/afp4WwBdT0LkOQfOH/YxEYOcQmo6YZEVISk2qvSpLk?=
 =?us-ascii?Q?PUJ3fRevv+w/nTRGMYxb1bLwwnoiD9TZcXdioMgzNuGTbmYvuzw78xZe+5Im?=
 =?us-ascii?Q?gkRaxNPOP/CMkICsdi4hzPOZ7NiBFk1uxaRRT4hH7OZJZVNyv5SoqCPPIqr2?=
 =?us-ascii?Q?DnPOoRN6JfhmG+UltfF3vvmgx6hkfCpZhCd8IVuL8PkJ7Cng3yExtHcriEhi?=
 =?us-ascii?Q?nvM+mv59R3aBykBx3Hx2oEc8YjotxiZmlOOXNfbNWl72cFBHuF+8yFEQelWn?=
 =?us-ascii?Q?3iNQLAU1s/tJBIhmctsm/RUNRrE12PSZZQZ8aGbYdeHgoolAScZJVaLF6FuL?=
 =?us-ascii?Q?x8acOQCNr0DdZq0uPGT/1b1C4eP4Z++bQK/Y7tGRd5I1yb8JZ2QIB0Kz3bMY?=
 =?us-ascii?Q?cgJ6TxG/N+RxGQWCDv8/knuHrDUDLCFEGbRxlP2XDL3VUlAIE+JO1tDHgKSV?=
 =?us-ascii?Q?xGXGVSLQfGqXXDtlU/ymOFQJHvNG+0O9rWAWJwnDEg/YTZ+HM//YOvE3PwL8?=
 =?us-ascii?Q?m8IYChfppD6rcBsvLD31a4v/9INnnBgF/a20ZFObUup9Hird0TZhyyUoSk7t?=
 =?us-ascii?Q?NSmyC0tUgkw1RCWjZz7ln/2EFzQS8T8yxOC0YV6FzxTyPzwPflSJmojbm3cM?=
 =?us-ascii?Q?D9LlKU2HhrtDiraanGhPzrAWjBv2pZprqfc9xmHtIkDEO6CFcMA/y52lNqi8?=
 =?us-ascii?Q?zNrF6+9VKtkMHfrtTz0tjGU9qRzo82LLOhCu0XwOi7G52wb82p943DS1iuZG?=
 =?us-ascii?Q?7257qiIq7GFR7C79u0dUKyeHKT/5QEEtfEwm5Aeif8bQo5tbTpJyFO58ZIEf?=
 =?us-ascii?Q?BJDwp+PE6v9o4exJalj4jZL14Roif26fGYscoURn97NYTqREa4YWcmXYdovB?=
 =?us-ascii?Q?bUmYBd7tPsccqrB5HtINqJ7EXME6ohUItRq/URvvV092EmCGyhYH48vFkxj+?=
 =?us-ascii?Q?uSZKfVCOCXjwZdUSFR7Fsv71oSF66nfUHm9YkV3rBzF+e+lUnC2mrYot+VXW?=
 =?us-ascii?Q?/X3Ujzx/r3vvBFWiQqXrrQWRg5CwPNVt0lwgBhMQhIXC0FeVyZ+uyBl3dRWd?=
 =?us-ascii?Q?IQpf7/0EmQHeeLvr+IWebbKCDoSzSfXEf4jBZZepyviDpRk8ElXWhL/MEK5S?=
 =?us-ascii?Q?Sp4gCxyZNV92daaxleI3aCMebGe8O7kvJ0uq2A2MYElYsJlVO6XCUGCnQLxV?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f248d6f-752e-4c24-2a9e-08dbbf2272a5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 06:24:47.7475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+mWVxm9mzSLa2UbDtpcsrmdThuiuOGVaumcrGGfnd6Isz1ea8i5f46ZouTv0/igi8Pi2VR/kxzIdUwxFf2U2omrafsE552XNuaknSVqCNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes memory leaks and usage of unallocated memory.

The endpoint is initialized after allocation, so that it will not
contain random pointers.
Rework parse_base and parse_array. Add missing unregister in
bap_exit.
Set the lpac in the stream to NULL as it is freed in another place and
will result in a dangling pointer inside the stream.

Andrei Istodorescu (2):
  bap: Remove memory leaks and buffer usage after free.
  shared/bap: Set stream lpac to NULL after removing the stream.

 profiles/audio/bap.c | 66 ++++++++++++++++++++++++++------------------
 src/shared/bap.c     |  4 ++-
 2 files changed, 42 insertions(+), 28 deletions(-)


base-commit: df658c6c4ab5bd5ec4a8a3f8faa36e0d0a5f906a
--
2.39.2

