Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAFEC04A6A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 11:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbjGYLWG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 07:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbjGYLWE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 07:22:04 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CC21AA
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 04:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPgqLudHpZgStNF8U3CCpjmJkRn4m0nXoBnKrBAolV+JovTr9jJOt9rk0pA0qzD4y8kTwXbudQtvieZ93ImBhQSKp1Y+BsTcKPonsGcVm9MIg6FdmYZtG/UBU1RaZK7OOtvLaaHU4mB+/1Zx2sgztp7zHzHnr5uHUiVNuUe5NJHS0r+rvbuiTr3kv5pdtARAe4T5Yn0m6R/RBh2AsVeAen9jq8SPq2GsmSeRMgGuhMVoZUsZLV7hyL6gzaFWtfbo0rvGdwZ1Agc2LuVQX1UGtgh9DfbZM61OjRFEg9r2Smr7YTUBLDgsCZgpAyXutOd3UGc1YfQ9nv4DtM8CDtz3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbCjhdd1k6P2/Hpa+8K0nDFPn3j+J6vv72MoplTOzr8=;
 b=ZbEytPs6p27q4e42kPWJeBJTF0J8t7g8y4apyN1zAHvColgHYT3bI6Kl8PjGqyzPVcFiM1YiykExbzhzDk84TW987UKliMepVGvMbPRmyd/1sLyJrUgdztACtc84/gCMCmp/VfX+ONFCNhcnQ2p3urniZGRYQ6xQMjsT80iuBCvEotDo/F3PyVlgEBdD7tm3TKiRQuPsBZjKTiHW9My21MpnOHfu5IN8O6DWRXqOmtg5FKnLNtHShG3a7V/bb0BI+2wk+NrAk42ZwvANT1ugqwqrPCYhXxppmRb3lUilG1vdw9CFrkkMqn97DI7VBB1Shf4OZPS8yOYrCVRipuXtAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbCjhdd1k6P2/Hpa+8K0nDFPn3j+J6vv72MoplTOzr8=;
 b=IcFaxyyb2iKj0RXMQOReKjg2xeU76rQbubl0kTAgJpz1tndM1i5Vh2uNVsUbkaQ5KcdeqAFcLTObgpKMFdN/KhPMEK809Fflrp64FCPQW1ZZUi1U19xnZPSQYnkeNH6I6X3j7AAwCefYEaYywUttwHF/pkaMZ6Xt17vkiwrwAww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by DBBPR04MB7580.eurprd04.prod.outlook.com (2603:10a6:10:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 11:22:00 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 11:22:00 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, pav@iki.fi, luiz.dentz@gmail.com,
        sathish.narasimman@intel.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v3 0/3] Fixed the crash observed with VOCS
Date:   Tue, 25 Jul 2023 14:21:23 +0300
Message-Id: <20230725112126.49656-1-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|DBBPR04MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: b98953b4-da72-48cd-8cff-08db8d015cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6bMXJKHGgjqgnrPG/eItwhNc/TX9uOIIMkpFI4Nby+etsZYBiU4L94gGPGH71ueHWK9e9SY2Rvp8NuHFsyNrxleMjXlCXJga/JKLt/RM2gLfRqMAJ6CBR598qOo8Ym4KvqAdvwjSOGN9jzVh9yS0vHlEC/xOQoBQItzyleWGmLS9cMRwl1REC0129fm+Eino0A3DZbfG5HVS8Xa8VLp/hCLnjB2aPB5zNwGUmGCKxKqmFsnFsTWbXINTYtyfilFI28gr4klQUAUliULUK/7GdjjqVbWAU05uHfTL8zUc4Q3jNTl/PUi/novt7W8Ua1YthuIkFYrK1d0rtGXReA3n+gYMMt14O51q7GP/BH1R9h0uMcn3NSPuRzZcvLdn9fERJpw73XVCJqj+Za3U6WGh9RWAsuDP5Ee5eLUkwgVWtAuv9C62TfEhF5JBLvWr1j3GFAbO4P3EH5KKFHD9Ac+BKLemnaD/CWm8x36xO5WJVMW8Duq57LuCwkOQfp1dQMAm+9FWCiI5lI8bqHv7mLZoXpirzERPoibVr1ilbEjAKs5jtXDYjqLdwbMrdCp0XK25N9dW64Gxw0b7kA3BzVBTv1j3l8qrdzq43RWYyF4qyRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(86362001)(36756003)(2906002)(52116002)(478600001)(38100700002)(38350700002)(26005)(186003)(2616005)(1076003)(6506007)(55236004)(41300700001)(44832011)(966005)(5660300002)(6486002)(8676002)(6666004)(6512007)(8936002)(66556008)(66476007)(316002)(66946007)(4326008)(83380400001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xsQOkbWUJpPJAHp8LmTBCluzZQoNFjbRUrJdZybK4D7lp1cI9mJDh1/AhMRu?=
 =?us-ascii?Q?aZH2ocJ7QccUuXEdy9CfoknVe1yBwMeSBB/WVppS8IkgrmSzn8XEMNZS5vy+?=
 =?us-ascii?Q?bORNbNnuLvet8IY8iUJcK7XYeSpZTQa1VDvB0ZBsHPTJJ+gskzySXTLz859K?=
 =?us-ascii?Q?2otbVbCqdUWnYPW54daHUVQPUmJLvHDYHUHpFGjDvW8kCTLv4KfZ2AygtJdx?=
 =?us-ascii?Q?eBjRDM9mUzfZKutlfzCPhULUw0+RlOvQYLknWj8GFm5JNij1EoU0DlBk2MhL?=
 =?us-ascii?Q?7qjqOz4oxG5w2v5TostqUBti8TKbb0JTLaeuBZwGrP5XxiDDWmqOh7/F3ki8?=
 =?us-ascii?Q?tbyAIqFHPDymO46FE1Z+XGOJxMPk4IAeF7ejxm0Y4Mp3SjgUjXY/FChY8wus?=
 =?us-ascii?Q?EO9A48mxQGQMXQJDZ/CO6z44dwh3CdzsB6Ma2QbycJn0LNkI1ZwyFfP2q8nH?=
 =?us-ascii?Q?VG5aGwWUxODGEvo4HJMWDpU0sjMZsUltKOG7jHnM+fpozgti57PEBDpJ7Gsw?=
 =?us-ascii?Q?0OfzWzoWH0a5jS7ZN3LRcOXyNfc8tG/wuJKUggdlUS/4pYsqdLzzUSbXAGlj?=
 =?us-ascii?Q?O1wV9z9QeCNlykXZJ+LftMJEPv2IDGxKiaV4UhhiI9PFa2go7VzJiGGz2Bha?=
 =?us-ascii?Q?Y4mu+Z2kQuLTK3SHVZAy7pjIzybtyifzYwDEMYBtsutXsVWbhlzQC+lFY8Ua?=
 =?us-ascii?Q?X9eViH0fLiP3aAKj1pW1+tm8kRUXE61pO/NEy/vTzPRHst+7H5mDsZw9NTPx?=
 =?us-ascii?Q?JSOEmblKwUIJE0Kv20ewyG2VLlJ0GUApKQILUiSw2Z7RWkoHStWA22OLdYSK?=
 =?us-ascii?Q?ftJyJCyrNGCRQFvyYW+t0Q48FrNPpGTPclbwL2Xu8j9nBwf/rb6oDTA6DJOB?=
 =?us-ascii?Q?7h/ddpwloSVQaMwGRXmtsfJooV08byIR08N5X/H6FL024tfOhQDymZrE83Dt?=
 =?us-ascii?Q?FGjpoxDaQ5OCyqSTTJpMKDUwyiVYP05s75ic6CFLbXyB0vI+4nwzrDT1J3IL?=
 =?us-ascii?Q?j+bW0vSdzTyIo6GDe2cZ/OduI+/9455ZMTl7ubWhUnpVsDmukLq9lPQcWsAt?=
 =?us-ascii?Q?JpqMRRenp42OPSRhMumoHDQB+bpKb6GT0YQc6HxPQc9gB44sbcdZtIA8sLE3?=
 =?us-ascii?Q?nkzvCK3CPB5Ik+XoDqJJlsd5sYkGxl02Cpyi+WRfhNWOlwtIp9X9An9ELK8g?=
 =?us-ascii?Q?EGZe0sdpTapUwy1y8kbh5fJep9RMrly/aL/8G/WHnShWae3622v1tYPbRa+z?=
 =?us-ascii?Q?WHnxte35reXu/pBrUW0sO++f36U8wW5pSQqMUX8LTZ95OE2ZTQfpKoWnA2mU?=
 =?us-ascii?Q?WaroFx4TPd91vOLyu2WOABdxr9uP0bmieZjIjCBJk65sf5gpju8wE2clUZqJ?=
 =?us-ascii?Q?tRZCvyfML5Pg5OWxMV929ZqRvC6SmEVRo+hMEICIiv+nAsEsyzeHuexV2rIq?=
 =?us-ascii?Q?aalwD5RAyFxA6fbsaeLnefVVW3FPhKauLU0MPh4Hp36pO04vXbo6W+li0KlP?=
 =?us-ascii?Q?tAKNKfyt6qq9zpDXgnLbwnrXSB6OkN67+D4ysZ3xzTgKxA3yqzTJDlXOQnBC?=
 =?us-ascii?Q?2NM7BGQoMsSz5l6gauHtaYJ9gBI05hvaUc53BaIn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98953b4-da72-48cd-8cff-08db8d015cfa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 11:22:00.0503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuQunB9B47rDxN1quru9hNF0uNpMHWsD2kUEkCWClo3p+K7F04lphXCLW84CxXVg9R1Tlyc+x/P7zpCrDwLofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7580
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
  shared/vcp: Fixed the crash observed with VOCS
  shared/vcp: Fixed issues related to read audio location and descriptor
  shared/vcp: Corrected handle size to accommodate included service

 src/shared/vcp.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

-- 
2.34.1

