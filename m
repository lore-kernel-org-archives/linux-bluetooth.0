Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CA7C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 14:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjGZOCN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbjGZOBz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 10:01:55 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0547526A6
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 07:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X70RoL8Jr/M5H+Be3oFQq0NmlmycbWaydbkJjtcmV30kWUCdzLx5FgS3V4+iCNZMz/ZDKRKYaphQ0IBAClMD+AydZ86UqzBL1R/j7YJaL6h3N8LnpkV7bPDBk872+ZaE1CGSJiOLifBVkErNncK4OpBdrV+/TzHVS+rh04yqaM3hGzqZJy7Oj1Q2V9biEqyDPxel2oGxjONsCQujDTs0s5+6LEBOQ32rGcxGaT49Iwvx+eJy1KkmVn0UwNdh/LPKBdlLYJama7EGwo1aiAqFmT7KJUhEDondWqigbeV562K0CLbxikH4owSh5wkeFleoct4S1uplm/1q1V0rz68nlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6V2LxkxP6jJmND2NK3AgExmBy2/lzgV6jTWSr9ytkw=;
 b=i++AvUFX+t7aTxBakEeLCDLUmyzOF7lPknTZfyzDlbiLLvfzSqSUKSXaIbDP/Lz/5l0NmvqJkZIEp/1jtvn1ehA6dT19uu3tiGtuoxp4+oV5xvmqut3tafgnSKebdbO2sw0yrwJIoHu3ss/iBW4zHyh1ihaWvVLQx2sE/uZDmoHE47H7NnDYIOGmhub7R/UPX3+p8OiVd956SZw7mI6RdKFKsFXp6/gww00H9rHN/6lQ3JH4xJGlbkCWBL7aK/ZnmNMGHvERRMENQfsMwfUh/InafAzyjKjCPrOL1IO+E5qpVdR6rSqh3Y9CItLdjPXkFb+YwAPtGlcmWPO5TmfgEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6V2LxkxP6jJmND2NK3AgExmBy2/lzgV6jTWSr9ytkw=;
 b=jaoq/6N3sjWPII20iedmIUkiMHaeevW1xMvUBI4fGp2YEYtVdeEgOSKGpua3DITplQkYoefRSp+sNPNPpFi4K6k4u3YgkstYLswB4iiKIeDnH06q9S5Crp2wdqFbaGd+U4jCNMISe5Lo4atdQEIa8Iljd4JCVnf/YYdZ4Z1mORs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by PAWPR04MB9887.eurprd04.prod.outlook.com (2603:10a6:102:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 14:01:50 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7fe7:582c:e250:bd4e]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7fe7:582c:e250:bd4e%2]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 14:01:50 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/1] Rename BAA_SERVICE to BCAST_AA_SERVICE, add BASIC_AA_SERVICE
Date:   Wed, 26 Jul 2023 17:01:22 +0300
Message-Id: <20230726140123.136672-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::25) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|PAWPR04MB9887:EE_
X-MS-Office365-Filtering-Correlation-Id: e288f62e-fa4e-47f7-e046-08db8de0dba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCuaw3yMIlT1Jqfo2CdK5iWjGt6YfhQ5AQ8MWX9krUDKGulRzvDZ7qUAYvTyWgTTYoXnPXf0ds9xZXaYfLy9J0md8PtPm4Q6G6R38ygnSicyySMWJhgtpuC7tbmlLKxZFQvjPZ0bEjgjzsUA++9tkXlHLGDd+5WuS1reeOiw6ycYa79zH9i7WryMA+F/UXsHrmuInUR05I1aSOefEiOce3fYE4tYvuUM6Lefgw1CnIQIdnNKKkPIV2iWQ84O2s7OFwBc7dfOhrc6lO4w5lmZxi+8norXlVKVx++By0he1R+9MIflShVysoNda5TZgQvlO/JF5RysO2YZ36uX/QL3Pqap/dIaOO56q2tRzPc9Gd7EofnBVdncSXvceFkyBbAiwc4hqqugLQNB3G+BaZ9VHxY7+R1hmESPSYxJBOAZI2FW8Pj20SUscTg6e4vZunNUz+cdqjZkIz+ANBhdJfbygkbWP9SvWYdR+pcONjWVaZW6Q6ZCXcj6lgs0t5GNeWsVR+7aXC+Izyg0J2I3TX/ZyZcYw8eurd7D5YWqkuGVMfUAHon+N5liIhl4q/6yuZQBYArMmYDNqa8QsYrAcOF9bqp17fJRX5NNlEWFiBnrzSgDH8XMIy62dZ7ll8NSDIo7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(1076003)(26005)(186003)(6506007)(2616005)(83380400001)(8676002)(316002)(4326008)(66556008)(8936002)(6916009)(41300700001)(5660300002)(66476007)(66946007)(6486002)(6666004)(6512007)(52116002)(2906002)(4744005)(478600001)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yxqLjq79kuSm63wmRmmzMLcpKOyUTndkb5BkcfWvfWoxiIb2eKrqcXQhF95A?=
 =?us-ascii?Q?/nSJIrTCHqkNQ+OWLofs6Xl2eEWGk/SJxh/DHm2OgTCneXgnYN1LVXOVUD6G?=
 =?us-ascii?Q?HhkA6n/yLXjjg/mRO47DcMzkuKV9zHuz5lbaNHTVrWZ9ig0RxxAGFFNgvtIC?=
 =?us-ascii?Q?UKhpwk0czfhcbELdHDRO0Kfb72M6W8WTIrOmRhAV8nGlokdmWKKKDBF4dLNd?=
 =?us-ascii?Q?3tIYoCXFeORMKx5LQ9UcpzURQo4IC9TKJiAMlegi2rD0gDODwzm+CLJoPWT3?=
 =?us-ascii?Q?TUcnlm5zK/JARWO/2wgZgG4LCYIZt+DYV2526USIlVFf4wa5xHcBF7sUtO/7?=
 =?us-ascii?Q?cqGg6v+kfcX80sZLQApgrYon7fb569FWSMWH5miTbGAbdv091MQD80dF+7ZS?=
 =?us-ascii?Q?cRqP5Ba5BROtZXNzZEoG7JFp6/grflq2XM1W0aEsZb1/rpSip/sOS/XvKW9Z?=
 =?us-ascii?Q?hgTVSL/jB1OlcPzVJEmwUUm6DKw5YNA9otAogDntSKrlT4dZXc7eUnFMSYUb?=
 =?us-ascii?Q?pFLC/GaC60gXVWxDrKmhKdjgAVO5T+RMOU5PZ+HzM/0kbnTBF0nj6uTXgduv?=
 =?us-ascii?Q?Mo4PsFJevzDnAZlRNNnJselFs3jaG6ng4NT6rL2rIK0ue+dNBkKjFTmeP8j/?=
 =?us-ascii?Q?MdGccjNInCsoVENLslmt49MRfIXzMDQ64yzSePmfYFPjhv2mqW+CUvk21bZK?=
 =?us-ascii?Q?mrFfDHPTiUWq/x+WFUsM8j2Xq2cFJUhnO3Yv8OHVGBCibZHsoswVHVHfSKHI?=
 =?us-ascii?Q?FnvcOsZRQ+DwOeKBQHBg3L2jpT3TvCaZH/fnhUeP2/+FGaHJzgkdZWkA0E2t?=
 =?us-ascii?Q?EzZZxfzY2QVGDizYAYW6y+JFIYagZH4v18ncBLaycsZ57FodtfDB3y6vtQGz?=
 =?us-ascii?Q?MJ9OUzqF7qd/ymKdMasS1M05cLrLB/39EwkuSzhEKAbtb5c50Pu3l1yPy25d?=
 =?us-ascii?Q?m+YoSg3WB1nSQwhzYXp3nf5ukn1NpjVDOVyFwVragpn2Q2yPe7r0+Z1jRJSA?=
 =?us-ascii?Q?NZ1kWFPnPanVF/YhMia1jW/TuCrGObpxan7lJFatADGRCLt84WrP8DB18ZDa?=
 =?us-ascii?Q?w109BRd9XdEKsI74hvfw0ju3lwA5qFtmQ5Q/OTXMqvP/wjrIstGVQJ84v13A?=
 =?us-ascii?Q?o72kx5lOZxrGla7qZAHtGWjqvgiVEoRHchFr1XBFvtevQq01YwjzYB5/ks3h?=
 =?us-ascii?Q?i5CEQXFdY7rUJ16Hii5eChg9yhspTuSYgjPM9mNItCCVuLZQkFap3kaG1Ka/?=
 =?us-ascii?Q?lcg3JL24TiKEzCAfXfNt7Vuc5PRA7RUDDGXp/zqkjcwYK9NDqF8j51PfXEIZ?=
 =?us-ascii?Q?XQkkOtLOLePHzywo7Ju/v6rQcf9iAZDOTTa/SoPByth44RvDoMhcc68T1IYl?=
 =?us-ascii?Q?kFg1mU7T/UXTXM+pD2lM0MNZePXmaRKFsB0+D6fhPT8/AZ4vqn1Vk5/7FO9j?=
 =?us-ascii?Q?P7ZgTaMZ74bvrbBV++Y3wkFZzoTCf4T2JckEgBAdiA41yuMuDDJ89ysNhC1C?=
 =?us-ascii?Q?J4cnLJHTJu27b22gEl7Oq2BOO9YHcPcfJlvFVCQgnq9g4V7A9GFd9BY2VykE?=
 =?us-ascii?Q?JJApxt0gOKgibpqZvsz2DUh/565mYmQ3f3LilwqZAFKvyTy60L6I/7TkrlG5?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e288f62e-fa4e-47f7-e046-08db8de0dba1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:01:50.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Dr/RuprkOjluZ2vcjShV5yWhK3P6laRn12hzNJo4FhQjjhHIHFu9TfOALMu1uMbLSiBjNP48e3VH8lecAORWDAIMEXSKyqO3BtMJOZoR9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9887
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Rename BAA_SERVICE to BCAST_AA_SERVICE and added BCAST_AA_SERVICE(0x1851)
as UUID for the broadcast sink.

Silviu Florian Barbulescu (1):
  Rename BAA_SERVICE to BCAST_AA_SERVICE and added
    BASIC_AA_SERVICE(0x1851) as UUID for the broadcast sink.

 client/player.c            | 8 ++++----
 lib/uuid.h                 | 7 +++++--
 profiles/audio/bap.c       | 2 +-
 profiles/audio/media.c     | 2 +-
 profiles/audio/transport.c | 4 ++--
 5 files changed, 13 insertions(+), 10 deletions(-)


base-commit: d8ca06631b7434ea8837f9c571bfe31d6602d31f
-- 
2.34.1

