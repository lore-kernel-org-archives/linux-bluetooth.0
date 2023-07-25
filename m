Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB58CC001E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 13:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjGYNsT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjGYNsF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 09:48:05 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5639100
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 06:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGJCqHIk2XO1PX056nfeX3XyIpMg2GRVamXkkVa5EjZ5+9o8dWpYdVjuTjQ4T93KdO8AEq7bo1CPnLZdkpYGrdfyjcDxMW2bZ5NnqDSno+ubDQLj6yp9yViX2p2c3YBsigpYCQz43sRyqRVgQowJkyPCNYH4pxuWUn9kB/YNgniuGRCL6eD9FQA07RNKwBhe6DeOUB9LbNUn2Tz4D716pE4giGbvzJg7dn9mAs3cwF/OXnGnkEFWhiDvDopz7+K7eKmQl2PK25MemxtLpk2S5/cW60t+NHui41Gj5hXJ/ukJMTxoxEl5h7FFErzHcrf0Zyya/clqhYKT4b2NaN1EEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v77dW3Rd1d+ag8HTw0QHLsZXs5kV/QWAiBGcduNZ++I=;
 b=ClJOPyUquKT8STxw6V0opOcCYSkZodzeQxN4OGjZIk2h4uBCYIF7EhU9DsrHk4g53q0Y80dr/eR3FWo6EsSn/nBeU1Y0/5DYS1G4FgneNcCqg3AwfEY6qe1Jv1OO7Amwx3zG3/kJT+oNvAXVrUMk0e/kUW/JQUSKvk0NP25GRT0wg3mdiRF/1J6jC3yTLe2Y5eKLK5q0YZGQlLVY46KyVh72/lnIiv8XhO2qPN6OOcKvzUS69w+EelyEUhNNciCEcnHGWcd7VLxVJX7lwaGPZNcQOEFoBX+IoSOnTYIXz1wmDJ1R+9IoJjrUH5JOeR0N0MeCNQ8TVVo5hZYmvjUD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v77dW3Rd1d+ag8HTw0QHLsZXs5kV/QWAiBGcduNZ++I=;
 b=s+3sDu/Rha6hYpSBXKZIRghk9rhTLxCBFhTiVIJRgHUPtCfZWUUCIdq6DXQ2H9/cpShSEVT35M4SMtRJM/msHdPnwg9rkAT1stgpNtKZCw0VaqKsgnIQpolQapFLRR4/Hie/YYkOjiGmjM0faU4hF4vHV4rYjaHPKRfFchPVkvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by PAXPR04MB9593.eurprd04.prod.outlook.com (2603:10a6:102:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 13:48:01 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 13:48:01 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, pav@iki.fi, luiz.dentz@gmail.com,
        sathish.narasimman@intel.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v4 0/3] Fix the crash observed with VOCS
Date:   Tue, 25 Jul 2023 16:47:39 +0300
Message-Id: <20230725134742.51651-1-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0037.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::8) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|PAXPR04MB9593:EE_
X-MS-Office365-Filtering-Correlation-Id: f42bb216-6bc0-4990-99d3-08db8d15c304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FsAY2a4qcbJ2+N+GExuFnfjO7rYx/suP2sS9AdMlOulux2byQSPfdX24ZpxKtcvETF6LJaSvmvZH1LdmkMaYdsTCqnhtkioYUDVOJcqopHbdKHD5uJXiEfTon5phnX9IDUw8Oy1GqvUbd4G4vW3IF9R2J0qbnaAYmFSxnM21XMPb5ghU7f8DqJRcZfBCkQGhGZWzRzTMidf6CGVRMlsw5qwshTSr3WL+79Hs1+qgbIa++P87cvhqDQ/5qOSLjhoByVaCHOnNAQzhj54wiPXLpfrnajwOiB0PvnbEnNrSt+UHV+xnX9PUiGd/tsVRIrRAWxh2v+cW+/ezqyq7p1Xsqi44XftFEv3Xgg6LceVYzX5d//dkVR11l4NK3C75YGUitz42sbd+XhG7/FQi7gKcC96txYTXZs+mi5zmYTGjNugJ7Xt0S6UfXefSbvPxkGyv6tNZ2ziztaayMRG1w2KneBc8iQz6iIAP9j/9mbIIURSrc5Ik1mo9+1XT3zUqmG5vA9Nk5MnSXSSZ6YcL1Tmi593Gq8ARn1hXYSlVeEtz+xFMJiekZNv21jkQEnmqIPtn5n5gM6ui10RuV1ugXbDPd+xNVGC4zEFSyn+FLPIwgiM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(36756003)(86362001)(2906002)(52116002)(478600001)(38100700002)(38350700002)(186003)(1076003)(26005)(2616005)(6506007)(55236004)(5660300002)(8676002)(41300700001)(6666004)(6512007)(44832011)(66946007)(6486002)(966005)(66476007)(4326008)(83380400001)(316002)(66556008)(8936002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NkKm65eoGx3sI0x8Z8M/hLqtmOOhSAAkD3rAD8MFmPDsZcupfAlubuT1fBFu?=
 =?us-ascii?Q?mhxnJHL9BidtrVGwsw5eCfv60GpvhJzz3uQzrTQneivco+J8GIqYtpEWGy3h?=
 =?us-ascii?Q?mTMg3KG2mbfcS65myapTHzgp2JT7dNkS7ebhzMPEjgqoheUerNmimxQ2lP9c?=
 =?us-ascii?Q?cGvJaEJRZ6EbcIsgzXB+uQMw30QvgPFc4yZdgUlp8bn3O3tLs20nQdXzMyOy?=
 =?us-ascii?Q?Ii0vMMh9HsG+zWHIXwZHikGokZRmMroiEH0reWAXgqNZxW2LqrCDrYIh6TsT?=
 =?us-ascii?Q?ECL7Jdq6t3t7tIlj5JM8x+5lSqPwOaQ0O09Z9TkIwiRMDCcmB5KO/qOtqpaa?=
 =?us-ascii?Q?8rHSh3uNzHzsTOHo0SxWuaWU46Xsa2fVxFaH/D7ZxdK3Y8RYJeFZDw3d8BQW?=
 =?us-ascii?Q?64xV2A1+05PJq6HZPwxTuwJCVoJZqG/LK26R32c/dVtIW/FMgmkw0xqxNpAg?=
 =?us-ascii?Q?jqZOc5yKy2XrRkMrWV4uLOeTyhUIT91avY5JakMcVVWEXmIl1Rx/9xpc5PtE?=
 =?us-ascii?Q?SmGzqkb+mq5oEQ4NOG6+XMtDKMDGu2tOFiRomAuW3pjKXBanOsGCsoDEV2R4?=
 =?us-ascii?Q?jnduFrBL0gFYjN4IU6+IjcnhNBVvE5EjYeurnkSBALe6kzZIAAcxLY4GpyxO?=
 =?us-ascii?Q?9NlyV8ZSYuKx/Vu6R0lFoa+X76DKWL5/maZFEeqMGQQExaj5Ijfj/mPWvLdM?=
 =?us-ascii?Q?CuYsfIOlCwmJdOW3VTeGie+g7lM33rnVx2Q36FPokoi+4a68xY8+Ku4xEUBG?=
 =?us-ascii?Q?6Sd7QHlE9Wd11vx9S6YyEkDRuK6XQF1XLi/np8085O2wEoLW6H3htLJ2qjDS?=
 =?us-ascii?Q?wedC53ycDHp0XfuQbFuXjnRhNlozKH+cFNqZaSgtKgCQMYSegEeFi6vallyc?=
 =?us-ascii?Q?Tk2pauJLTV3UCKdhkn7R/BFXhU/xAxbz+5vI7fdNZuZ2l8L35e1oe3TCY5AQ?=
 =?us-ascii?Q?mF0nBrg94ekt9knkfNNAv3sdWp/b+ILUrR9BE+eFN9plAu6PDQUN4RAEXfuM?=
 =?us-ascii?Q?bHiAzUOoTMwuS8/78FgW7AIFi4kUmdoh3iItcOHqttddvqrLWP4mnVKzQ5Ca?=
 =?us-ascii?Q?rd2fq7nE/nAZQtOJ7sf+HIP0rkdsAAxgVC2Vc1AWEnPtTkBR+C2j5GPbGRM6?=
 =?us-ascii?Q?VR+CYxUJn0eIQvzpKBYGM5xwJRlNp6w6a9dLxmvW/iQwsHVptQtSFxk1KGyk?=
 =?us-ascii?Q?pTQehZ8xUjOCuyXp8zajskaEIfCGcEsFp0J4xZXyDvadQanygz9ZzTdTWIlx?=
 =?us-ascii?Q?SONcTzW5wKi78i0Y9r+rBgBA9ZAThaeT6DA0wTwLgU0wGKKTj4YeZ5kHZAlS?=
 =?us-ascii?Q?Y3ZTxgcUZSGnKDamF95AxBmqr0Gh/HSAxuNqqWDcBw3xhXuEdMQB6uRiN/ux?=
 =?us-ascii?Q?ACj6i7lSogHKPHs1EaD+yIzGXHPklfJ2xbcJLEgwebpn3AAnWcAonoW9jQdT?=
 =?us-ascii?Q?H73FWbT39mA2qKYapnj2FC5mWV0cAHNkbhJx4ua76HdiTS6rGQFSXAli+MLG?=
 =?us-ascii?Q?15CMmJVGa8ixyPW0ggpvMdH4unoLV/cXy26127fUIBxtj5Mi+fYEjmm2ncnK?=
 =?us-ascii?Q?r1QUjqFSm7IX0LPvdJry7TGg6+LcsyGuiGFSWNOc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42bb216-6bc0-4990-99d3-08db8d15c304
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 13:48:01.0199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2M2eKbvL67/iGqsD52tgW3DCjc87JiJ6rajBuy2WrzaYMcNITeqFvw7pIENzMxfJLf+MDv1ykrAlCghl3zlNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9593
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers

This series of patch handles the fix for the crash observed with VOCS when trying to pair with LE Audio TWS earbuds and few other issues. 

A crash was reported for the following patch by Pauli Virtanen <pav@iki.fi>. 
Patch Link: https://patchwork.kernel.org/project/bluetooth/patch/20230612133251.194-4-nitin.jadhav@nxp.com/

Root cause: 
- There are two types of database- Remote and Local (rdb and ldb)
- In client mode currently the code was written to access ldb

Fix:
- Correcting it to access rdb has resolved the problem in VOCS
- Same correction is done for VCS.

Later to fixing the above crash few more issues were observed, these are fixed in subsequent patches.

Thanks,
Warm Regards,
Nitin Jadhav

Nitin Jadhav (3):
  shared/vcp: Fix the crash observed with VOCS
  shared/vcp: Fix issues of audio location and descriptor
  shared/vcp: Reserve one more handle in VCS for VOCS

 src/shared/vcp.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

-- 
2.34.1

