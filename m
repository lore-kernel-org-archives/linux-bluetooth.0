Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE3C7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 May 2023 08:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjE2IsP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 May 2023 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjE2IsL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 May 2023 04:48:11 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AFAB5
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 01:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cP+cwtJE9mrszAxwTiAnfrop7mmjIN58yDGrH8x+nQkcB7nR2Lkf5PK5XaZxqdX+t+tGAptpCHxpMQYjTFB3R6GclEzpk/A0fr9JGXg4qJQ9yWtQPQ8EA4gVnM75dpzVvsxWPbz40KMWsoshp0w07Yrt3RTkGuTJU6vzRJbeqcHvMxKTJgmw7RE1UeiZU4rewnvUxjuy6fBfnVCn44ovjxx0XvAaKbKxoWNRDIl6nxn9gr/pvb3S4/ql82fSXY9HYWG0/g5zs9WVpLowqpsH9UFPjymITnws/6vwgw0qmmGMB3RrtmULdYHca6uKSBHJl/vq/Ie4+upXQk3ho/EugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UtrSwPfMvIxu6YE5SeXhufoZK28Bv7ZFTna/y+9HmI=;
 b=SAj8+Uw4w7K9jMShsSD+oANb7qugwEYP1724O7FeZaYa4Ao6Y/SbhY90LRMl7Ud6iCk1GrXYBqIe8xu+uLeMuf/Y6mPTkkxwmepEnz0dKS4C6d7VAMy2zUHiQ+lq78R4dFjKaUZ17NqIn/2lMcWYZNtINN1ft8L9WU4FF/yLr/RmIUioHMToZLNJRJYX+/gnQhBB+oZahJoK5GJcD0gd3DuwrOWG6jeXi2IBamOJaXl1VLiS+CQf1iySY/DFVZcOec0PbkWSFnBObXF6cSP8GjBBEj7gdCFwbNRDqQ9wZFeVqRIIUMNPiu7HVXzBnBwvLZrPCLG42voNRTTBaSpI7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UtrSwPfMvIxu6YE5SeXhufoZK28Bv7ZFTna/y+9HmI=;
 b=JISmHW83qw9pkJRXeY6o4Gybm7dww8KPvEwSCREo4QqIlypT+uP6+rwLrGjIT+u0JCYmmj2nN6CR+5auOgSV4vSRGKsRIVi7Jx3CU4C8nWVmQrA62wef88AYCCCCgTCAAciUsd0a+QFhn4JwnklNJcysyxsAXkm2S+dMghnzL9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7074.eurprd04.prod.outlook.com (2603:10a6:208:196::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 08:47:13 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 08:47:13 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/2] shared/bass: Add Write Without Response property to the CP characteristic
Date:   Mon, 29 May 2023 11:46:49 +0300
Message-Id: <20230529084650.72126-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529084650.72126-1-iulia.tanasescu@nxp.com>
References: <20230529084650.72126-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e9b5f6-6ad8-4c4d-a9b4-08db60214c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZogg1AmkLou9xSqxJTqJUBOtYLuSjBDfZqvtomq9ZTazkkGfe3E41bP8GLkuIfV0Z+xJISGnvYirwt0EXzZkNnz/3+3H+K9RWer5SW+YHxScMnJxto209Dp0qEjqIumBXOGV5mEyYTO0ojN5k8mcMLgOGkWSAsh6yjKg55KLOFC73EVl9cUCIzjjjOcdUvteITZOEHhKxLt1TUD3t5AkECCtfu0qSPksF224LG/3iiC+wUpsT9gd8Knvir//FydlY4RwNQcHbPtseBp884OjiIxdSBrQOn6p8/kfyA4MTsxTJGRGJy6NSHXEiww+r6rpmQfY0P4/gRI4UMm2P+Bo2sN9S/2fVo9eDE0oBNYE3TN3YTf8bFf8iAjdiSChNXTMGGosF1BjDKVr+Gfxvj3MHmRUHRL8x8YsVrOtvRwpiB3Bu2bir2DgjscVANOLWQIMOKvjrjh86lFia9Zl+9YDeeIHcl+gD20t4tE4VGk4JRuEkVVg5AbUKC96QSf1bP8psPYBX+Q33JkeLvTC45quEnjFYtidiBzffan1N8SdJVSuU7CXX8om1Dja0MpnNt2nubFmWp0LvUPUk+x1N4mlYRhThbb7PrhCLy0roN1zhvwFrKyGBHIrx7gTAdXrQ4k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(38100700002)(38350700002)(41300700001)(6512007)(316002)(6666004)(6916009)(4326008)(86362001)(52116002)(4744005)(8676002)(8936002)(6486002)(2906002)(2616005)(66946007)(66476007)(66556008)(36756003)(44832011)(6506007)(1076003)(26005)(83380400001)(478600001)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RpmnXku5ozBGOSwPZFVxA7yxLWoonUa/ARo9r7GGW2V+yPctSoYwoO7WV234?=
 =?us-ascii?Q?af4yGlWUbJKxMV7CpDqpVSVl0JQm4lYyQK8Z7c3LtyljzNPDgKiMx8x5xSw8?=
 =?us-ascii?Q?OelxFeGxzqRyTQdayF17cG0fzABT1SNDBUEz9s0mt3/CRD7LGA40Xbo/Ht3R?=
 =?us-ascii?Q?zBHXCLaAD25ynAo8N4RUd9emtGZPJSEosIqPyzqJLOTXZY0Vecx//GqtbhKK?=
 =?us-ascii?Q?gCIEzRMqiuznDJV2T+AJfgiaZo+YI4AkxDN/74wENFFWSR5IlUt+lOnmQblG?=
 =?us-ascii?Q?mj5w5+/1gjSNSg9qZfjsp5f7P0IOnavRC1Vd9P5M2yhZQpvrBIxnA1krlP9J?=
 =?us-ascii?Q?xoEOBZXA3FBzH52QxckJ1H9Kcm4O0zbN33LfgFbDskiSSwiPBYQQX0kvRu+s?=
 =?us-ascii?Q?h+mYSIpnEHC4S/O6sN43dtUnaJQfDgQNKpGBWUYYobauWr+moNR5lloxLk7D?=
 =?us-ascii?Q?VweUNtxBgRgAcklyfw4UyzHI633JkuVEfJ0piHgtdRJy0YplKqpn7hzTWmNH?=
 =?us-ascii?Q?bsx9hvc6soe5bzt/RlOtw+OTzaJ2IjgAtN6VygDEs7msM66mt9HVoPpUJfM+?=
 =?us-ascii?Q?sHepyJdYHE5iqHOIn9x5KxvIe/n7HnCTI6cZgKhmJLK38psjmI78zJ7xgPJx?=
 =?us-ascii?Q?LsOypp9Vzfi3yfxVIKB2ZSZNFtRgpjYVFyEkIYmaQRzzFgzfzh8UTPO3ztof?=
 =?us-ascii?Q?lLgGC7EO4UUU9FqWcDGQxjBY4eJnThlPFpu/8m0rr6pxUWFgmwjjth/Q7+Fa?=
 =?us-ascii?Q?ZnlnOAKLWtvhAZ2VWQAt93qkNL3tio7XBtvATGlt6dHMBiKLrEiS01VCXuzg?=
 =?us-ascii?Q?i+IIgDFBaKN2+c9k/lEWqtw94arirkm8jc+72t6y4u3TDCFIfU2kRVSoYXrP?=
 =?us-ascii?Q?VthsXKFYCbUZUI/hJnelq/VhvZpdwEbr9vFWFl5L2Lp9z3W7dH+emd5DEHUj?=
 =?us-ascii?Q?knKAXDw4/M9uuCANTnCUF1C1vTImxmfgyMUYo1h3GvyjcUcfsMhU89XQKoes?=
 =?us-ascii?Q?z/ZVKJaZjkIhvxeZaF5hg1czJC/pdFpCwK4LAbawMIuhPHyy3CH5JZD7NPJ6?=
 =?us-ascii?Q?JmGSkfzyJdTb95rdYCh85s9SdCIbx/2lxrjdIX4Zf9KrgKf0JGOJ4W8PivoI?=
 =?us-ascii?Q?WnNsRqq+1W5sK73kTZFa8OY0NS2gY6OUAhPiOicylRMqQPGuLb7Rf4EWtCqO?=
 =?us-ascii?Q?B+dDa7AkRTGA73AR7uuDF3+2oM9b1zaV3lbK3cZSkDIQ+aWj458wyfk5VAnB?=
 =?us-ascii?Q?4uiPhdheqDTEOCT2A3omzw4tiwFPLYEtR7mC6G7xSditFOXpENrrCPIm///w?=
 =?us-ascii?Q?6OJh9VFE4FQ2L4cRjeVUonMyVbitjz/JpQ2AGzmT8fE+ijLadGMnygYCRvir?=
 =?us-ascii?Q?bRLkcad1wVJ8p/x2v3DreKtjzihI1zPq5qPCZ8IjFsiWsDEgZ0JKz7EkksyL?=
 =?us-ascii?Q?SUZsEPIMlwsq/Ew9d2hww9wR3n+uVZmbhnTlcLzDhZyo0jZ6K06BSSkQdYxe?=
 =?us-ascii?Q?uYO5AI/ygY9b9WeA8AFMyOG9vrmjIt4TbY17jLhRYvKt/P12ridLPoPWkgm8?=
 =?us-ascii?Q?xsiT+fm4Aib0Q+82SQwBjEm5meQuyaZELPWKNwaixQyjdY15cQUbya576YFU?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e9b5f6-6ad8-4c4d-a9b4-08db60214c12
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 08:47:13.0382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jToF25yQ6fjrPRr+B0P6S4CHIZdOy+7irZJwYV3XJZJdeWVFPRHQ1M4/ZTB0t3tJwCs55xRPeJyQdwXt6nMgNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7074
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the Write Without Response property to the Broadcast Audio
Scan Control Point characteristic, which is mandatory according to
specification.

---
 src/shared/bass.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index fd4f28ac5..8906ca1ef 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -567,7 +567,8 @@ static void bass_new(struct bt_bass_db *bdb)
 		gatt_db_service_add_characteristic(bdb->service,
 				&uuid,
 				BT_ATT_PERM_WRITE,
-				BT_GATT_CHRC_PROP_WRITE,
+				BT_GATT_CHRC_PROP_WRITE |
+				BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP,
 				NULL, bass_bcast_audio_scan_cp_write,
 				bdb);
 
-- 
2.34.1

