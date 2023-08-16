Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3228DC001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 15:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344018AbjHPPKV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 11:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344025AbjHPPJw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 11:09:52 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2078.outbound.protection.outlook.com [40.107.7.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309CD1BE8
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 08:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qdlw1fp16xDlgtB83XvNQ4imarx1jhJvmKA9MX4xDanT/xBsYfsWI8fWG7bE+Ipyom7DfFW0J4bdMuDn9lHa81Snx9aYsjhP83bOJ9rwaNROe2BFkLOFRA4PcLtHLd4lNlmorpJU4WzstrFZ1vGcXcRBDXQeiy4USkEzd2N2PJsrckqLnSKCO0UaJiCZb7pDclhh1epKcarO6GtYKQOdrS7MScUy6FO834s/ELVzf8GmG2R7dr9ZqoEQHYL+BN7+Eqihg0t2fXd8omiynSxmXQiYxSTnZNXWv6D/Wjyeh1KEMiCFLklBLERwvHVdl4fjDALX4UaxO8VxuB7OM+bSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3VLPyVDLo5kMN6I3N0l59zBXwrN3GeaTfMh6qCm/5w=;
 b=V5I6Hto1idft7nDEAksFjD/Z6FIBFy1j7yNTUafvzmQ8BxYBDvTJiBGU0ORT6rfhc70l3lfud9C9GF1kE5nTs3rUUL+/5Px3K3mG1hYKTRtlBplgomA0rX44FMVbsK/gM8OFddhCCKTt+faAE3d9/mPNzUYDtXoJHWI/O1HFyIPEvNNdMPPY0lKdEe4qWAWz5kqX4mHrVHSPjhsj2ZoCbNNiFe5WIViHs8wlMBhccH50IY578ojlzqKEHTCuORnX6Y5O6FJpV0jkiq2dtuOOlDiCiarf0qDw/tRPLD12UH6P9zxQWxzk7t4c4PCaGKJXRcynhuNiHqgn56av6hQOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3VLPyVDLo5kMN6I3N0l59zBXwrN3GeaTfMh6qCm/5w=;
 b=qr+/5rcdenlrpf0w7qxqpAoODcv6x884/mlSJIX5ZJcvfkQogyOSfPzVE+Tx8XAKQtjLJUE6Htwqm4zHNoDM5/ormCXioDAP2P9LfwXPQ1woAoj01GZ6GhFGMcwJpsBBi1hLGywwWlRtXuKptNHEmEH1VzgOLBjWO3f9WyUc4dc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB9189.eurprd04.prod.outlook.com (2603:10a6:20b:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 15:09:39 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 15:09:39 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] iso-tester: Add test for bcast receiver defer setup
Date:   Wed, 16 Aug 2023 18:09:16 +0300
Message-Id: <20230816150917.7896-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0009.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: 809f00f7-9e8b-4b18-d655-08db9e6acff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6UkRF0rfeJS/DWj6oBZ9lz+zoc1V+pdfNwPV7LQyX38KxqetYVbmxVFtryB6saThno/GFG0zppImJSX7kqM3IMpFCk9mBSCA2eb7XepvRYyG8o5ck0g9bFJ2yF3FZ791yLJgffv3eHznn4/2F/UgbInhG9dxhsaDhKYDOAodL4ri9WxVVtlVNbTXyPnpa184mdGykwY/c7zGqBzheU4PQWtJO1XkIKfpFzrdlyGA2FBvYBAkv4tOdIRtdHQTw6dnPPB/fxEgWoUXQEGXdDzh0WuMOlIPw5VxrrJDjx7QXxxzdnkiYq7jKj9F9MRThTDjzsKjlDVBrvdjh3Sbc2RVit+rmlJJOzzuppoiOpUzO/QddP/57nPqv9p22e4M+WZ6pycMQwR7WIWkb/hFpT7eyw9l4mi7mygD2zoRIXgUPqkRDSGuGJ+JwCV9byUzwFPQO8YqJWs4MCEXsozRKNNizXKTmCKySEAJr5MD8o8mTZI7Xw8EkGNMewr+X6FynBJBedhZquC82KSZKDFeK/9rP7SD6O6V/fAe6jFCE/F5b/4UqqcVXTILIeVzubY6gwsSWeCzvWw5AbpyXQmrxkTxDQQwuOkWqJkhJtF8M0P9gg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(966005)(41300700001)(5660300002)(44832011)(38350700002)(38100700002)(8676002)(4326008)(8936002)(2906002)(4744005)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(55236004)(6506007)(36756003)(6666004)(1076003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fRuM/UuAwpq1JwfaKaE0XYQlkAwmWL3Py81q/5QiROKLlZpt5yMl0kbLDjn6?=
 =?us-ascii?Q?ZC/E8YUlf79sF+/360H9Ji9ouI1rgj3o0COrPPWrC/UdFwnXHRrpvluQoQYs?=
 =?us-ascii?Q?ghsdo/h985hwuNTgaPY1H6p5B+2ZfUMblnCfmTA3BJfQHQ6+l1tW6M24AbGH?=
 =?us-ascii?Q?rLoVezkCblvBdJiwmib4JFVeTkLvXHbjvK7oR9rgjL4lJV2lQDmEVFCp9iXe?=
 =?us-ascii?Q?GgaPuRB1TOJlS2eJrMNoz6qPRQUO+sbeZFNnBhxBkC4tov6/WrAQmM1W6Uet?=
 =?us-ascii?Q?8gytEGlTTt4SIr8wnaInSmAzPqBkig/kpqO7SuYdEUD66O3yapcwx/2tliJn?=
 =?us-ascii?Q?5zwVerhNkh0/yBFqIPv5WNmNMFIPzKYfWqsPIQDm7iuodA4se9rEJIss/eon?=
 =?us-ascii?Q?k1C/13yJravqUiQ3B/Yk709cRbk9uhau5dnlkmXBzvjONjECtFAv0xqGcOnM?=
 =?us-ascii?Q?DYjLL4W5uwkZ54YxRGdGWovnTUU0Nt7tKps2EsnXOQkNlNuXWmi8qcsYlQAy?=
 =?us-ascii?Q?blW5DONjOYnkNXJ4oOT5e3dX4dOMMV3kSizmzLRTLM06wB8Mr1zyK75o1k/N?=
 =?us-ascii?Q?ygovuQrbXZKhMhTMkJOezA7iXp/UJ4OPs2Cop7qyWqzsEyD8czfA8vrdsYly?=
 =?us-ascii?Q?HvZfVwpiK3mpGk3H6DdgefO/O5w6hauL9md3m+5KO+u5zzoyhOLRSsu460l2?=
 =?us-ascii?Q?unwZnG/BU7HMeij9zKYoZWbnn+TMouy323/FeD74jwveRvqwXlAi0usJmYsV?=
 =?us-ascii?Q?NNMuvrWnRyKMFk05RnlIAnCML8/vr8GyWcomAOsYE0jSnG6RoQ2y8oZpKguA?=
 =?us-ascii?Q?K/bi1PVk5M1I8zSEDJofH63yfImw9enZu28AjXZUzrxKHGSFARExP2hLV7Gk?=
 =?us-ascii?Q?iIJgxpTjtu+qjl8/a+Dwynz1phwr4gup8AL3raXwAvOE81+6nN/ZgMIYRMUo?=
 =?us-ascii?Q?8TahzJcmNuvoNHLjtdqR04lz3jUF1RyDlN78NxQHkv+YCfv1GhvJfdfy0Qqi?=
 =?us-ascii?Q?gAvzoES4Gr1dcxymQKT+HNNPHS1FCkiwvszJ9DJy0T6u2pNdpKyhoUVvfQEe?=
 =?us-ascii?Q?OJSIooMN+9Ops7mNaHcSfKgLs10J1Vc+srDjyAkWSd0R67572fpN8jFJn5PK?=
 =?us-ascii?Q?8oTd3n3CrxA3UTH0qsltJ4c1KiZ6MUbqPHRhSBIA5wEIhHt1YiiI0W5WCDbP?=
 =?us-ascii?Q?pkNbQvQgv3m1KA3TaWdMaTl1WIf7folu3ENpxgWMwA28jzZJQHksclbZibHD?=
 =?us-ascii?Q?G5OsyPh2bXj4iDkD1YbN02Iqa9u4QpJc3YjjwA8h5WRhuEN63HnJ7jYsH27S?=
 =?us-ascii?Q?s7BdFtMz+yoe1Hay7Uo/GdbqUG1GZcsmAbnZP5pU6ve560NNsJ5BsL7/7QQj?=
 =?us-ascii?Q?52/dsn/MkY+sQnOwB1S7rw+D9q2uBBJB2I8XHiuVvlu6dgKO8NHNaAJjYurT?=
 =?us-ascii?Q?JtA1CStRk0dpvLhjiKY/MDhUeJ42ZyM15LgIqQSwgBaiK7ryBnlGw2mwLQfm?=
 =?us-ascii?Q?AR+GKip7TWR+rS7OXZERMxP/sGvmOQbpQuJQEmaA8iaHwB5MVyMlZIdOI7zA?=
 =?us-ascii?Q?NnS5FasQt0GyUQVtMuubI1Y89kRYsg5gp8NNbDQWX5kBC/3vCrjLQGy5BJ1j?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809f00f7-9e8b-4b18-d655-08db9e6acff9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:09:39.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SylfxTRgXo2U6PiggscHGvVMPoUDYKCXOTzJSbYzgZANWfa/hT8wSLwKx+J3dKO2Z4P/w1f2aGJh8FT9Y1EPsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9189
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the following test to validate defer setup support for the
Broadcast Receiver scenario:

ISO Broadcaster Receiver Defer - Success

This patch depends on the kernel support introduced by
https://patchwork.kernel.org/project/bluetooth/cover/20230816150033.7812-1-iulia.tanasescu@nxp.com/

Iulia Tanasescu (1):
  add test for receiver defer setup

 tools/iso-tester.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)


base-commit: f4aea37ee6cf6b6cb3f91e4d4c9f09611acfd610
-- 
2.34.1

