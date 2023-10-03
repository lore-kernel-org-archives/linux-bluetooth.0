Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17553E7AD52
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 14:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbjJCORr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 10:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjJCORq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 10:17:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2053.outbound.protection.outlook.com [40.92.73.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E865BD
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 07:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpo+g9wBYjbERdBRqOFic5+tkW0ysweFLbaeQZP04eYpuwvQ+BC/Qq6zeZ4Mjywf4f4WvVHcg91i4gCbjt05wgm0bZn+SDvBoFI4K/uRggS64DjzjjIw4cA5DlM2aPb3DfIjOxWfM0f9KcizLz4v2PhWq8pqWSIOLMdroz7YXdwy7BVfktn2CshelJURvoVjCotSrQGQEYi98wK5CDs5ZTsEDUxoEBhfok2oXO0dSis4OnFPhSMW3xfn8edZsihy1QEoReuqoDYeHjGs5mdOZubNQZeZb/6jmK4Vvkk3xMOmCTjXqihbBct23f5ROdSkmdtU4GmrywGahQJGOeJC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijmvZn83xamleHKDwyGcRyWTDZUS2DzWsKAfx6cgIEs=;
 b=Gg8Gm6487r9KVPr5IknfiULnPc+osjLmkTvIuGoh1pUC2vtRHNqe94h3yFdu57sbMOTzjJxSsUMV3H8/vAw5xEjL8nqJaa6dm9ZeVAwehdIa6CzOYXU4Lb7fTkc4XpbCG8GhOqf8/oac714rr5zN6WR7CPpoeXdwkYX7qDF8o1x/KH7/gEjmTYil+7oRttOkciso/jVFFywAuVgDp/2vMdVErpO/J+ML1F8CajjMK7JXZ9SQbw8l0xrw6m8Es6vu2vpcHIsQXIAL3R4UewtbQsx4qyZl4B2ev4zjEM+b8l3ys92bTPqek0P0tzYGwZiSj9tZG1BFLCyIsw2Z2cjjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijmvZn83xamleHKDwyGcRyWTDZUS2DzWsKAfx6cgIEs=;
 b=RzyEsLgm0qf0irsLdGHaoHlK5UiCeM9AIzDELTN/33ZA+5LoLiRfFdIQ4ONGU5li4NGxy2I02t7iPY6FOLOEO/O2m17oc8g6eXTybFgq87fkYbOcZ8XK87rR0/U609nDXn5lPfEdJhcy4bLwe1Bh/ddeV6+u5ko+iba+qRYag6aRHxVY1e1x/N5xl9ZDOR7kOVEC6ipwylJMRsS+/ef9MyGaPGjTVeL0sqn+SfRcMaxDVJURNbYCBVMZ8n6P44LT4GILpJBm0N/eNAzbDy6wTFiTHHjhjQrCIERL6sQ4xkv1ShERKcAkdcY9mGtZmB5fYbzWB3breVo/Nkw4UxbaQQ==
Received: from AS8P189MB2602.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5c0::20)
 by PA4P189MB1437.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 14:17:40 +0000
Received: from AS8P189MB2602.EURP189.PROD.OUTLOOK.COM
 ([fe80::94ef:9fb8:bfb5:e10e]) by AS8P189MB2602.EURP189.PROD.OUTLOOK.COM
 ([fe80::94ef:9fb8:bfb5:e10e%6]) with mapi id 15.20.6838.029; Tue, 3 Oct 2023
 14:17:40 +0000
From:   technicaluserx <technicaluserx@outlook.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     technicaluserx <technicaluserx@outlook.com>
Subject: [PATCH BlueZ 0/1] LE Extended Advertising Report structure
Date:   Tue,  3 Oct 2023 17:17:15 +0300
Message-ID: <AS8P189MB260214B1E811D9C90F27D855C6C4A@AS8P189MB2602.EURP189.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Ls5Kyrhk4EzsXoIr51ukILpu+sfNkOpAT4lw9KiorXYXVI7Gc2Kdzg+TrYB206aE]
X-ClientProxiedBy: VI1PR07CA0288.eurprd07.prod.outlook.com
 (2603:10a6:800:130::16) To AS8P189MB2602.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5c0::20)
X-Microsoft-Original-Message-ID: <20231003141716.23955-1-technicaluserx@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB2602:EE_|PA4P189MB1437:EE_
X-MS-Office365-Filtering-Correlation-Id: 4534dd7e-2531-4bbc-4456-08dbc41b800d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YkW1E0hz767caJKjyNVRG33X2FRjHuz53OKfAfWbYtg9kupRs2kBxCHdrh90hPl9S8bELpO+qXkV1zL9qABl5W+B+w9cBHRguMpYtLzTj7rZzHheFYv0M8ykl7eWcH4yPBJFt2w8jbbENhaPm6qpc4uZmCBq/GY6A8Ky9MrE11T5HwNdu3kzXdpvXizwlaWbRp5FMpuYaYN4mp7L3VFJ3E4RTA+E6VrMvUw8F127uTgJ7LcnAWc4HfR+K4ibc3NT+1bJRyOzWhyAMXjyFF5btx9arhBIFKM7oyjlQqZMfqyU4k2hysypgnxPYZWPaHyd3P+x5QTaD/b7sipu8is/DsKLNGPcNMTmqlFa6Jrgz+5SsXxApRnBSkqj6q38I6xW9X4RmXcRW0wisslZT94jS+yGJdf5UwjN4vnxwuEFnrH32WL8iftXnGnOxOywPdISbj8tGqoM+ywxzfTmu97Sr7XExbWbj2nJ2dzu3UAjXtkW+o59Iu5LWHiUBS80Vy77P38i9hut47irF7iAnkURR6nBbWyay+XHJkoR5qRgnwDyD4AhaMidI/ZSIFLrI4Bgt6u542lZuPJzU9INnZnWVjbr9nYbNUSLPMjhqd+DyfL0V0dsu4Ep1/PcyHffUOcL1geHb8YspQlwerVe1noDbA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LIZGRD7cW2frzAgzDIYhWBY9EGC3A9X7991WM76quNEshczKEChBHWF7wJGL?=
 =?us-ascii?Q?uOViD9VcEioeKTxD2vLaeK3GmO8H3qzsqWCJnYlNFpLubyNsXH7WBv6AWSaR?=
 =?us-ascii?Q?rt7me2MVpwVqy9up5fZky5ZLDkNIwklBLJ4d1KjGe5WARSyNHB5y1xLGWzSA?=
 =?us-ascii?Q?dzcYYHoKD+eXAxnpcM3QyDXBhFauP0cxBzIvxOQULupmrMZWaKYBWRTAmUjU?=
 =?us-ascii?Q?22YfktEBGUczT2MhvR+dHUD4IAxl4PMHCdqsW9+hGYCtOisrRtiTl+ah19RK?=
 =?us-ascii?Q?o0168zdAH2U++POkLZsijXFZBlZ5iTyY3ftIiIpQqEYXHKY95Z3QQ4JsSFMj?=
 =?us-ascii?Q?YOkii22o5Tkp9E0n7VoOtlP4x3XuONUCapN3SFUz0EzYE261gvh6FeF1Ixyi?=
 =?us-ascii?Q?NXAJKtyuI3hQ/tvQnecOwc68+rMRlgcUySxwuTGLBLZ+38xAR6kPx/7/prKi?=
 =?us-ascii?Q?ttHb89t7Oux6AiOAAZxECB/YvnK4TgMUoyG6jB4eAIaArYzRU6g3T9EA4cOP?=
 =?us-ascii?Q?dRrcS1cN6rqiaxkt86UNCgLeEbQfx5KFu47as0t+cz8fvhyZKvnHDSViyBKo?=
 =?us-ascii?Q?boWIt2IxDHmJBToUB6VBzG2PFN+6jXCXDtLJEznCmvXF889FvY40nht/hcy/?=
 =?us-ascii?Q?yuCW1MNCI1D7Jnv+Mzi0f2c1hse+KgCF5y1KT4s4/d5xgr99ZNAwgk99p9Cq?=
 =?us-ascii?Q?acXvEnBmaphE9uj0uWeNexDHh5sy7tFxhK9sTDxFErtCJzOv3o2boG0HULKS?=
 =?us-ascii?Q?l250I8PjTKK8IrfAZTk2qD4sNOJRdsolVbadw0WnHoOYvxETewy+sC4CT2F0?=
 =?us-ascii?Q?oxvjx3WO+yyUjdzd5Cgh3ay7TEPktQwaOhlybREH+T/rK2Ya3w0+ZzTT1P2L?=
 =?us-ascii?Q?lkdK8IkNr5pKrne7bBwVkwWF8/U8EywGSNN9P7jJdLZHDlGa4LNy7mbvjvCc?=
 =?us-ascii?Q?YygM/mRfTGWrfxLdpHAtBO/ZfWsLtcZMD/Me2j2neTXaDto0gKz5vdahjD6v?=
 =?us-ascii?Q?B2j2B1yqVZ8kOTtggWo52dFxctrVtVTRYp0wVfNLU6q7apsDVoQYll2yPmZF?=
 =?us-ascii?Q?G1XAgeHc3i1F2BntD1AfA1nRXHpWmewY9DFVn2Gq0Uyxr/SKnSjcpP8Go6FL?=
 =?us-ascii?Q?GPRNjEmt1gcWkDfVSgb87/Q1mjDpQJD5zgYFYlV9UiKss9FQ3Rrfwm2hovuw?=
 =?us-ascii?Q?2JHeL1MxVdQnV5vXnNoEfM463KlsgRC1/3mzTW2Q8SrFtvwsmHlQ60RfUPIQ?=
 =?us-ascii?Q?M8ff+FqoGeiy31Z2oQWQ1nmeWxFnRFE+VbMbOaI6zKX3GArZJjKrF3zxDTM7?=
 =?us-ascii?Q?uFs=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4534dd7e-2531-4bbc-4456-08dbc41b800d
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB2602.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:17:40.2089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P189MB1437
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The LE Extended Advertising Report feature is added in Bluetooth 5.0.
It was missing in the library so I added it to hci.h.

https://www.bluetooth.com/specifications/specs/core-specification-5-0/

The structure is defined in the "Core Specification 5.0" PDF file, page 1213.

technicaluserx (1):
  hci: Add LE Extended Advertising Report structure

 lib/hci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.34.1

