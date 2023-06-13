Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF34EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 14:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbjFMOR2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbjFMORZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 10:17:25 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517C0B7
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 07:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leu2zUCTBDLs2PDrw5WtKsk+ofswJaAP1zz4iyOcZAIGJWB1HqTJ/R8Lah9ESdn3r5r8YSwsUQbL0Ui4DD0nYqAvpyPTrn4GeF57VStrcKHu6gQ/hHdQsCPSRX0rYUJCTu1EAA55am9+aR8vjSuk6wtty2B+tNv1ghQfg6T1RaWqjpY1ic12H7Jd0U34Xxfq3KT6EyxT88cFu1yAH/dt4aYhNLJq/rHJ/0X8msa+L8Eo3TQypXf/Bjy+VpSqQKC1yCni2uxVAf+GuGlsy5Nvo/enF61jSexP3RXpJtlUQbR70MA9OMLh4qmdUhQMzr4sKkYuq97U9iuOZfxCoJbVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsnZBCWoG1xN40lipUqZptw/TCoqRZ6nXBuRlDaxJkE=;
 b=m9kRCdUOoqpted9o4GivNsW9XPgYo7vjOyIVPhUy+8BFSqbhGbJUuKleszftuhxNP0Uw/3vcf9mCSNMHdyHkzU4lQKJUcoIIZkIiLljqc0RT+vnqPLmtAA67PrHqgw018+3BSxDt42+HiKh1bFmDwh9aZZd4JrRaagFqMMCJ1AiqAQZZDDw/Y8tjh8EbY0bGpR8FypYSSixsUKggZhqVqgHF8eFsDwWAeeJ73g9n07KZMw3XZnyUEba3U8aGWFL4/8d/lSxhNV7xydraOVOVtIfnA4kIaQQapDk7LaTF3uxoNvmgF0Z1TwlkJ8tAr+o2tIb5Mnc+yHyOZRa0vPlZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsnZBCWoG1xN40lipUqZptw/TCoqRZ6nXBuRlDaxJkE=;
 b=Ru0rj6wBqdQD1ARkrKO855n5/33SUO5VHLoGQeQH6HxcGJ3TJaY9YNp7IjN/mUTVWpeYlpKYz+TXMCpYTz48zG0suqI+Lcb81QWMENYTMTKDrOg4QOkiIrULp2mRSCb3LcIjZFpZNmraPjD29VA3JxiaFlNEmm39rnAfiumrWJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 14:17:18 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%6]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 14:17:18 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, silviu.barbulescu@nxp.com,
        andrei.istodorescu@nxp.com, mihai-octavian.urzica@nxp.com,
        vlad.pruteanu@nxp.com, Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/2] gatt-server: Check pointer before memcpy
Date:   Tue, 13 Jun 2023 17:16:24 +0300
Message-Id: <20230613141625.9197-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613141625.9197-1-iulia.tanasescu@nxp.com>
References: <20230613141625.9197-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0501CA0046.eurprd05.prod.outlook.com
 (2603:10a6:200:68::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b9f940-2466-4be2-9a08-08db6c18e527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9F/w1ArFUcLCjxfE7fDOX4rjCvg34nx74QlJh6WSZfylAWo7q6PLme82gr7/Aiq1ZroF/Z/YonCKxgHDcDXR/09flO0PbYCqqkR/KQHzsw6kdHnkSTmrUrF6ByLZhHgdLxlTAwHdYFQnAcdNrtoEqxruvlWuhWx6Lv6mWui9PWZLK8zR4+Y7sRVUoSxgtnRBrsOebHqxDyUI/VtOr6Yn/leJzpKvszMD9Bk0g0QopMoKrYVstbPmp9ZEhjSN5OSWD7Yw8jNWHYPsMXU+LWdC4IJwTZNH6B4zBY1xfqbJ+rNIGRA0rlWduazM+QDHUh0CnrX/KjKjYaRA4YRo+llon9qF/M/NirsGUIq7xzP5TDMMPxLDYaPSIooUNvtgEo2UC5gLIHkcQJsANqxWAJ3KF8ZVFF566E++7E4/1J4kRAhGpCGyRxyjzIUPEdMvJRyhU2SxQ5d7QBoys09maW+SwGOgffxbr/zCUdEhewFlNmn54g5cl8jzjDbcByi77i6aFY2X0GiW1FDntzA+U5HyS108+43Zoeoojbsg9Qy3jhu6d95l8xeAWrpUzvPrQtE70OicjUje8GHWIybNyqrHb7ZcgJ/bl/OpBopQA5QU9/PB3Lgyy1Ukv87Mn8RuuIC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(5660300002)(52116002)(8676002)(8936002)(4744005)(2906002)(66946007)(66556008)(66476007)(44832011)(6486002)(6666004)(4326008)(26005)(1076003)(6506007)(6512007)(41300700001)(316002)(6916009)(186003)(83380400001)(2616005)(478600001)(86362001)(38100700002)(36756003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yxkYIJLLJxyQsHX3nzhUcbCAjuRPYwyDUjq/uaggSZUClLl9HYb/8lPPtbD+?=
 =?us-ascii?Q?rw9LyzqqIbUd6aA2lyJnT1//NnR7xH3cpPGLRbD4ne5Ab5TB5ScSVqTaq+Yq?=
 =?us-ascii?Q?X6hk0CjDV2DKk3XQ+lwrjDW8J259BDMzyiUXCYLb+nkR+WugTksHrG/wbsvk?=
 =?us-ascii?Q?76kCis2g26y4etfhPRyw36CFWHyHdFZRk6oI9p9LaizNWEW9rlbK9opEW332?=
 =?us-ascii?Q?yCZhMv7nlmrKW7c3cXP9l3Bzt9Tl6osoYElNukBaTxs82yVAw4uRhWuGayIL?=
 =?us-ascii?Q?GNds05Bsn97K4oHFgZZwqq6mTQjzOHVv/aDEK1U0ulURNC6/823TBdds+Lvm?=
 =?us-ascii?Q?ullFMxR2nZzfbb+AbtB4zlbX3bbFjbBTqlKRljQhr3GxEGEd1IdGtK05hpHr?=
 =?us-ascii?Q?Om4HpLWN24OJhJ8z/i8WmyEUBTaDIZlNqxMIoil4nd0z+J4NlYO2/5EnqBmW?=
 =?us-ascii?Q?Rff21TXO1gmmYbrCbXDWqM9o8FAQnCCT/iC+8Fu4WerC3pz8PZEWnqtzLD1x?=
 =?us-ascii?Q?zkBA2cocoWYDAKonFzVP50Mr8O6rQk/KZmHvk/oGRMEcgdmZf5xTFaavBcok?=
 =?us-ascii?Q?xyY1+CGN093ZXDnsKIzyt60EuMWJ9UP13irEQGeBQKf91cXmRta9gT88GLig?=
 =?us-ascii?Q?bySIhvay5DhewCy7G1laDL0bj2XeT+unTj2yFSsWhWjcGji/GQnqGJeIH51Z?=
 =?us-ascii?Q?cSEN+W7oc+9y9NVRfRM7ikGhqcHIPMHyluxUON2UNTeBAltw3wcxuaI2h6bz?=
 =?us-ascii?Q?PvFKK1Y1c0lALE0Ii9jmpG4Z8dK5Ya33qrVixWIqXXTySIvAmUuRPqlRiiu9?=
 =?us-ascii?Q?UTFiBFIfHzsp4zBASldMkZTF2ZW3Tajkf1CwsTR08PWMEYcZAf+xQds5aEYG?=
 =?us-ascii?Q?A20WWgFry8C3cJXaDBVwhnZ9gZHHYd8kEllAG8NMiOW4T00c4UrlLvLF9VFi?=
 =?us-ascii?Q?rshIu9Sm/oq7c5R+49wOxFzl1Q53LRTC1AsxrHo3A9p3KIu1i4e2beOouluK?=
 =?us-ascii?Q?gjt7mydftQetUXV2IzY6oLx8ATVq1+FEICqRXEh3KwU4A88oT1bsQqBBR7zR?=
 =?us-ascii?Q?T9lMjmKYokNAjtVATWw7NV4i/zFsHlG48cWzXKYgWgodeUDSB8KWvoHHw6Rk?=
 =?us-ascii?Q?d0apI8/Fu1A7PuD1b8kMTwKDTLMYrGHHmYvZQDy3KXfTRD6v3wFbFCDguqx9?=
 =?us-ascii?Q?RNayTaKpNskuhIaoh+FiPgsGBox8HFY2q5LpH99IYhjPsvBvrZuB4TdtTC5X?=
 =?us-ascii?Q?juxWF+ZpPASf/FFiPKAMqrQURqwPhlk81VEWoY14bH72zpywojf85/ifgr15?=
 =?us-ascii?Q?7BfkdpuJxv5bKSFb2699jCcpXdqFDdRL+JYFvRe6nWcCisXtIw8/v4PplHog?=
 =?us-ascii?Q?a/ErgLMm5f7ANRNmh5IDCR71FW6fu/vGjDIpF/DrwoWNRQ+YXTt/iiovG+32?=
 =?us-ascii?Q?30wK1FYGyrdDm2XycLEIBM2CO+sYXyaHlBywq0IarfJQxEP14vO75lDmw9aq?=
 =?us-ascii?Q?/UDUSiX/sNvpEkhlW3i0044UBQEc6jsXCSjnd6n99Jj5cZWfrFXsmcGhb1v5?=
 =?us-ascii?Q?B1Jx28l5I7A+ygUz3N/bAhzgeRz26lFj96oPQrLUCjLwrXInC+AtdaWBGSVd?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b9f940-2466-4be2-9a08-08db6c18e527
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:17:18.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/YSWqTMKvJMg+WHM80V0vBUtPZADhpNDc8DvgI7qJxivXG3UHUYy7ImWKfT4n3l2UX5cXZv3v2rhyeNRoEbMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7213
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a check before calling memcpy inside
bt_gatt_server_send_notification, to avoid getting
the following error in case the user wants to send
an empty notification for an attribute:

src/shared/gatt-server.c:1789:3: runtime error:
null pointer passed as argument 2, which is declared to never be null

---
 src/shared/gatt-server.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 85cff30ec..0512d06f6 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2014  Google Inc.
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -1785,7 +1786,9 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 		length = MIN(data->len - data->offset, length);
 	}
 
-	memcpy(data->pdu + data->offset, value, length);
+	if (value)
+		memcpy(data->pdu + data->offset, value, length);
+
 	data->offset += length;
 
 	if (multiple) {
-- 
2.34.1

