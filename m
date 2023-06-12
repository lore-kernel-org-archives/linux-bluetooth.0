Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DA1C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jun 2023 13:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjFLNdq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jun 2023 09:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjFLNdp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jun 2023 09:33:45 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB55F1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jun 2023 06:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUBc+01Uxdpuzninj+kBCRcLFmHPHRkxB4EBY8J/5fyEzuchCnh4oLMxzseVX0Cwi8vRGmqQBfz+tQ7e7Xjs9rv29ffox5MMc2glyQ6JGmlkdQpw3UfQ/gTJYtyz5nJ07e/cauqGRRlh8hdlK4kOIs7jbY5ESo/cQ2fUCa/SdKsSF2O7xixCbYfgrnqGWi2hgmGOUuvEXwsZLTWTDw4Vd+JUMYK9KhCxd4fxUMCpO1qfz8HD9GfEh2W0+qQ+Y+kTDmJ5wc8gHANVghPZJV7xHPKhhJiUnVDp1omCh5Y5NfJBI/wl4LG1Zge/nHrFUyXy+JV2P4PGVjjN7GB0VlrYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fO3jTnAmM88LAZH+zjV7RwZRJJsbDjwWt2P9vEDH9CM=;
 b=GC415UFvCeohDCUVBuP69zcXnfX3ZSaGtaZdn7yOnbxMDZ1Ncj6GIyF0XF3VEZkKgsYUzaUE+mk2Z3nKaHcCn6IpsadV19aiUYf2bKF9nLOEtiL/O2TniBcAX0/5qYLKMgNfaXv0nqvD0r2Tt5pIkxVah3sKpQS7YYAWPKVl/TGhxQgTJbtHat9o1wlm6ns2bCa6TrsLaI4rQV/mv8XL7JxCSskVfbQeFdBk14rqV2X+MQBLq5Kcs1U0UCTvMp4VweNP8omxHLCQIbrZAr7B6nzts0Myl+8tUdazi+u3kfTdxnqcmN0epvUPBsTk4fYogJkmzOigPbI4fGpl9qKWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO3jTnAmM88LAZH+zjV7RwZRJJsbDjwWt2P9vEDH9CM=;
 b=g+ee3IjtCPlkZWQMftUuaI9cj2iYcpgjgCNO8BBF7UYdSXpjEDaohHnKMtZ/epbAfl4bPAOLoCCnOknycQ4BjHGAZjEzq4TQZLhLE+QwqAHGLbAzHzzKFLIEtaluk6x8sBdJemX/lruZOA8NKRNnm386MdDNx3pfFRmRq1fVWqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by AM9PR04MB9002.eurprd04.prod.outlook.com (2603:10a6:20b:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 13:33:42 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 13:33:42 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v5 1/3] lib/uuid.h: Add VOCS characteristic uuid(s)
Date:   Mon, 12 Jun 2023 19:02:49 +0530
Message-Id: <20230612133251.194-2-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.33.1.windows.1
In-Reply-To: <20230612133251.194-1-nitin.jadhav@nxp.com>
References: <20230612133251.194-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|AM9PR04MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c8bcda-69c9-4855-8058-08db6b49a31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ydr4WUa3lkvgFrEfh2k1IH5OvFgJN1NpJlhhF8QgTBdUf0WSukhK/9NUOMPtG9cMeunPORobqTorEmmfuAndk6U+JvDa7TcHoESDBRnZSI725vHFhBGrQDxqib/PCNU14S71zuFG66bCTv4N2vhEz46C91H2MbDHQlzUg8ehJvSBeqGWjS7Pxp3QWk6JAxW4Z6ge6T/dzeH8vdCyeqfOVOuQ2bkLQ3kMNjhxlvgcU6B7l3MXsK4n2kEFWShVcmTXEjyuStEaOVYFEYBGPgb10gO64tXy3mx2jmh98aF8yPxpNhNjENnXTTVsHIArBb1Sa3X5Rb0QEyCexG/596t4tgWJNzRQ4zv7Gidh3k0HbpAAOMNZXjEn36vMfVXLTqf+k4U2ggO6Le5OiIOA5sPZ5v6+3ecpa3a2t4G7f9jVnDmaRU5wOoCDw72IcYnyX0DA+iT/lJ0M85fgCw3oIzMKrijw4vhI6r+Ta0FsSUfbGdSuZV0w3p7qjmU46tIM+A1SpHasIHrCXCodEDU++8NlGb5Z9GSpH69zCtnAdvBDRPTHKtoUGkcZV+XyQ+NijYR80BA2bKdx5xXJIDDrRRH8cO/GvHUfXnA8QC8axrXApqp14daRY5JuGvquLhuomc+i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(52116002)(6486002)(36756003)(2616005)(38350700002)(38100700002)(86362001)(6506007)(6512007)(1076003)(26005)(186003)(4744005)(2906002)(5660300002)(44832011)(8936002)(8676002)(316002)(41300700001)(6916009)(4326008)(66946007)(66556008)(66476007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nfkCL6c80+6Us+3JY6GtabrEnSFZTKHLcN+KNCBDVA1o1uHlynEaAoMNTHE3?=
 =?us-ascii?Q?/hMLlTEZvuspGKRA5YS63CXfEmN8L51nBcQm0bAj7gVArfl89GDOix1VqATa?=
 =?us-ascii?Q?5EOgwazLdwtRWlr2qOKxYELbY/bwoNOnB0XaOaCZu9EGs1qwbfbI42WC7HH7?=
 =?us-ascii?Q?A0VHX/Bvl7f7FZECitkjLRNTbx71IPmYiMGvfDBVr1Dx0AfqgZR0xT0jrnL1?=
 =?us-ascii?Q?S918O10wOzGrePvp1FqfI2bcDocoN3zkrGW7CidkbkDQtgi5Us7Y+7dJXvds?=
 =?us-ascii?Q?KhFAjlX64NYMPfmboU9RqoXzzfGMF9Eqs/FEhOke22kVkKRQKHNI9olWUQnV?=
 =?us-ascii?Q?6QaN/8azC+Y8IL8uv7lrnDnApX6BTHmh7y0zdhVqN4I3WMWBt+bDfZHsHENn?=
 =?us-ascii?Q?BzcbMXa3a2xjcGRcQDYiG5wUCBCd3IGDcLovvoG0Ztt9iJVv4LVjv0vn6TfX?=
 =?us-ascii?Q?kZLmbO5DmAbf/AohlQNBfXdsI8DyVFOLt6OsG/rHGjCG4bSfxtbaqWwkKdtx?=
 =?us-ascii?Q?k+ZIQhbYyETYXPJ8bu1gRDzqPRlEIHQnT9N9lRx5+PtEKwLolAS996QmvKiv?=
 =?us-ascii?Q?335xEAesXQnMnPqLk+OIlxsEI1WBhqVgX4mAKdiQSMoXkTVUHUxQcokDuXgC?=
 =?us-ascii?Q?Li1oGrjxIFNgV2bSFI77dPmO351Yh0rRv1jfxUxOKnWzvSgyQygj3q7vxlqf?=
 =?us-ascii?Q?lBQszXqSxxg1Ah7hnvOBljjr+RHk6RrNhXa9AYNsVGeIepo77ONz1P/wQCRZ?=
 =?us-ascii?Q?yEfe9gYLe2Qooy4vy2wtSpDfAGZgBFZdbKZf/ds9AzB5vOfF0O93Gj4E8viL?=
 =?us-ascii?Q?h4wrGxhIx01oIC5f0S5sry0gyjL00NxIfrKPWyB8MnfrPBzmOibIjikWAuvc?=
 =?us-ascii?Q?HLiK2ofVNdmmdgf7rj5yPV9EWYifJa0P3CZQ13YKsRB8QHlaNnkEbwR8EvIl?=
 =?us-ascii?Q?gY+dTn1x2QCIpSFr9dD9VoEx+oGnD79jvU3xbYE74ExGYWzUZXR9DkCj1QkZ?=
 =?us-ascii?Q?Jz8T7K+1izqTc/FRn2FYpu0+cYsfJLJAcGbJ+v3sEwtGZhoFbnvpO2Bq8gKi?=
 =?us-ascii?Q?C671MiTvRA8zlmcJucR36s1Kwn1j5tqwcMSMDfuuBOdaw8AK+pRe/o8h+peP?=
 =?us-ascii?Q?ciR2zXA1Xynmt4JHvtQLQOFhma3GF1Ye1TekHaDO7oZ2mD2JbetzHoPwvw5D?=
 =?us-ascii?Q?DGTo8iIM0qTd4occY/+qWAILUZ5d3Ob0VWk9wjl8/8zQqMFnxkiu7yksP2o1?=
 =?us-ascii?Q?FQiLXdciYO6H/2uNfb/nALugCp5T9tZOIAf7kDHQX9c/WLDZJpZgjEmccVbX?=
 =?us-ascii?Q?om3fx6mkfAF8X7wq5bkWW90fy7Ja5Qs4GJIGiN3P73qmgJ+ii74CifNJoRgw?=
 =?us-ascii?Q?ujoiaPO2q3ObCO5uk91xldpSmhj79TVs9WXjGHUY2xteoyKvQgSM045VMUDr?=
 =?us-ascii?Q?ieGedQuhk2HvENTioMwVG289Ry3ismcLWLU9fRdSjskgmikNnkZsiaJWRfRu?=
 =?us-ascii?Q?+42m37iIqStVrfKjF6TIZlmcvnJ7SuiTi8aeY5Co1vFIWuzZew3X3o2vip/v?=
 =?us-ascii?Q?86HwtxCqU2YCe+07YkGN1fAulbDDKmClt5m41IaF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c8bcda-69c9-4855-8058-08db6b49a31d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:33:41.9858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZyg25qLDj0zV5jWULPfANBAZ/VHrlAvsvGKkLQIYwO7p2s6+AgMj3l3iIqUJVd6o1QfuReSLGU3Hma6rF8voA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9002
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 lib/uuid.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 5cdfedb4b..cd3b3655f 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -179,6 +179,11 @@ extern "C" {
 #define VOL_CP_CHRC_UUID				0x2B7E
 #define VOL_FLAG_CHRC_UUID				0x2B7F
 
+#define VOCS_STATE_CHAR_UUID			0x2B80
+#define VOCS_AUDIO_LOC_CHRC_UUID		0x2B81
+#define VOCS_CP_CHRC_UUID			0x2B82
+#define VOCS_AUDIO_OP_DESC_CHAR_UUID		0x2B83
+
 #define GMCS_UUID                               0x1849
 #define MEDIA_PLAYER_NAME_CHRC_UUID             0x2b93
 #define MEDIA_TRACK_CHNGD_CHRC_UUID             0x2b96
-- 
2.34.1

