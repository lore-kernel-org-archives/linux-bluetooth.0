Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2537BEE4993
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 12:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjHUMEh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 08:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHUMEg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 08:04:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20AECE
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 05:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxZ5XEeWc+FExa7GsvMYQEli9FteiM3cUT3rV4prYtxBsu9vRvBJs1MHEkDUCatqEJ93dY7oKBk+2YgU5WnlISje/ONdivYI8xI7EgvIU4qke/0X/nkouwHIynU3m9FvgVmjubZcDm42iHrREFhAJE+AMDWf2j32T0Ak4g7qfif7rseCTeV8BigwCNzyjW8P+qEO/BK5TZG6FYgZOxnW3Zz7pajWX7+EGIRdz+0rPtdFg/vkMAbs91fRb0w32aZANGjOIekIm4qbDqROcbOcbE+nASxebbxrkp7evdt4fpqunlN2rF+yr4PfaLjkcXEX4CDlwfuaAiqyc86hCoQ+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzOJoAX4psVU5KfAWHkHcK2bmU+hS0BKkW065wxYZgQ=;
 b=hFvN1/e+qGUtKBtUrbwzkHCMHzY13LgSyuvtCnxCPeNx8kfc6LdYtJm2SHOLO1WkRsbN6XOusZXh9htYvSJjrREYRbDfBeU9sBsEB7wmSyL81FHvVMQjeL5P+S6xboVtZRzzNOBPRjaA+WfznGNSpvd7XP45KWw0eF0BdPLU2f5sslJe+SR0lecELg/BNWO4N7XVed2plc2RYCTrYCrLo1xs4F9Hl3UDUoJUf+Xde2YPC3Ey6kwFXBSO/Syr6U2UlUYlcMI2UTdh69MmPsa3WxK3Z0HQ9jg4kgy2O15s2SBrG/KMjdPjIb24LkN9ju79ZMbGcc6UddiIqCMl7usnbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzOJoAX4psVU5KfAWHkHcK2bmU+hS0BKkW065wxYZgQ=;
 b=TTSLNMckT/ftYI0CGXUBD0rJ5asYpwOMgH12raDYPKOdOSzv4bK7JGVhNjA8ISIpoP6k9AzFbVbVOH1lYJIghFRGzEhheqN8nmQ5wevMzUZbWDu2gFZRIIiNY6HqPq4EzAZjemJ9isIyT5p9aj8PavXaMCMU1ZUfvRHyOq82pe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU0PR04MB9586.eurprd04.prod.outlook.com (2603:10a6:10:31e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 12:04:32 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.031; Mon, 21 Aug 2023
 12:04:32 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/4] lib: Add sync_handle to bcast QoS
Date:   Mon, 21 Aug 2023 15:03:53 +0300
Message-Id: <20230821120353.28711-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821120353.28711-1-iulia.tanasescu@nxp.com>
References: <20230821120353.28711-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU0PR04MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf1c076-0daf-4077-8d0a-08dba23ec761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ixo+y1Gm78lLLv8z5oURUuzfoGN6ppTZha3fXiF4RZ2bIif+XXzRyIglud/NgsJBLsTuuq30lSZ3geDoW3/fJV5tXs/OAePPry66EcduZZGBevZt+tOv5qiQ9oDGc/P4uxx4LTraimprzkyDyBC1htqv/OFeCsnHq4SS1i6iR9gJ+yDR8kBn+dnyXEF6Je3Z+tV3PvJ3WPFf4FjmnT+g+yZVKN390Sa+763p/mBy8tP+U4OrU2YZBrhHoMo1nwr2ESD72uSdRDz8siBvmiiwOPo2QzsB9kH8DQKhSr5wH2qtJ1+K2M//S/4ahJZxnWeNs4VPsi96rUBmIEyoCuFF9j/9MLRf5nRptRRdxcBkDkx9Z65tDGSAiRv0vvNpwSSMgbsqpng37Z+2kjLsHrtYFNx3p3cxfKJQlsIBz6IWWBdDsClHDNA8B3xCdmc3I6902/Yt8As/FGdrhWP6gM9sX4mxbjUvcExdeViK1xdxpjQEDuWTet1ML8rKWaGreHvK29kLQTOa5vQD5R8S+6tcgymR8CNUl+hUx52zx1PdQaySEBEqE6tTrzYA79FjYULm3I73oelFK1W19a9KbTkbX+FRGhZ2yPn4FMuHNK3qPeDB1tIbYRz2eVjptcjFGxmQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(1800799009)(451199024)(186009)(478600001)(1076003)(6666004)(55236004)(6486002)(6506007)(26005)(52116002)(6512007)(2616005)(4326008)(44832011)(8936002)(5660300002)(8676002)(2906002)(4744005)(316002)(41300700001)(66946007)(66556008)(66476007)(6916009)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+PA/AP18/jT8mhoVCo/bcV5WGMlMJ0JfMQbG73HAdr6Ug2UxXnb9Lnqsei+i?=
 =?us-ascii?Q?jvqmLi/8sbho6ExDwTvE56z/Xu3H0J6iFzuLU+LIanZeRjAywSxGuw/vXwB9?=
 =?us-ascii?Q?nAaV0w3FqUxyBVxffAQXqALqjyoGraGiQGpa7EROksPfHx5Kr5l/hnCaQPlp?=
 =?us-ascii?Q?oA+2XFf1Mr1hu/KzX2t9bcv0b9HvRJxzEyp+dt49Nb4dLS5CJ53DZzjCWMkB?=
 =?us-ascii?Q?RRAI22O51GO6WVMUn9w3RK37YkwMDFrnQsRJOepiDaqSUZ4ehLJhfPqKJgV6?=
 =?us-ascii?Q?zGGa326ZrpzNgebP0D+YLsibbZD5RZrXKpGtASuniJtA+AyFMOJoLvdozA3T?=
 =?us-ascii?Q?jJw7zF4jB/qbqIUmHrt+8c8c4f60rn4m116VVlf74GVwcGFEv3ZNXQV7G/3g?=
 =?us-ascii?Q?KfP7FxZ2X5oGEB9fBIHQ1wI8qbE7HMoZ2/tyaDu3iq3g/l/S8oPpn7a99KWu?=
 =?us-ascii?Q?F7iEEIkgFbiFN075uU0tAzlu9OX8Dresk9hGe0uDsQDeuTrW23s/19wwZz43?=
 =?us-ascii?Q?vOlQWcCAIrrwmJAI3jP5syyNekms3R43dXoH0TM4T8HB2dul13ix7Q0n3CWZ?=
 =?us-ascii?Q?5sA84Mcj1f0ctZ6UaUJy3ylqYY1NE/aMcjCMVbwwwNLagJlpM4OXD7Hl8yoi?=
 =?us-ascii?Q?vP9YWn72j6YceHy3+vXxljbRBPZRovhQMMW9sEfIZAkW6ElTj+qmG9GpxN1J?=
 =?us-ascii?Q?D8KofCwiSodBgrN5kN/yu6NqBcJ43QCmzQiQHbBLF04XpIxT4DUBs+mDDS6N?=
 =?us-ascii?Q?jCi0eymAuuJ7RovuRMcE+xmg3NSYm8AujZnZXprsQMFasEhPAQaq44W+zFvD?=
 =?us-ascii?Q?2NDeYEK/zBO9NPTxJ6/IFtVKwhumJHJprAkXpOqj3/+1XMt5EZ+UqmcmtC7l?=
 =?us-ascii?Q?4zpxLy9QARVR4wS97Of9aMNiHLK5tuVnVt37QD/4F4+pAZ9/Zilm6rLED9eo?=
 =?us-ascii?Q?0uyd107+/rjsJ2OhU4h86iRFMJGf286P9eafNcgSIUyFinzzTtFp5CyMy1kB?=
 =?us-ascii?Q?6XdplfiZS62uSudq5ImB8k0kOHPOIBFfm9ahAAo2x8HkJKtQjsR8kzfYw9rm?=
 =?us-ascii?Q?h1kO9wwLYycX0J0Q5B5iCBG6QC1S9C0XiA23FMZjHr0Vqli4Fqie7eG2M5Bg?=
 =?us-ascii?Q?uK9Rm6TQvDA7wCghm7Z9cpvQM8VBDy0w79t23ycUU+GrCe2h9o2AHmAM7OtQ?=
 =?us-ascii?Q?lx3wNUKzmA5DtlaUKk7vufUXa29MIw9ur/nWk+KRk6213nMCVMUJvMjsJmx6?=
 =?us-ascii?Q?8OD4NaA2ZXnumgOQL9Oa0BXw+L0bhjKcIwXGgF5X8KYtQyqcBX+fYAEEl1Y4?=
 =?us-ascii?Q?3W1l6AcRDKqucBCXwvlyNp7SbqKckGMQyvmnlnC0OEad3qo0In3RjOpG4mOE?=
 =?us-ascii?Q?S7TBDMj/57DiUkQQj28rbw/zY2sAhVYw0Hcrwrac91KwISKbF1BvyLEWYlqS?=
 =?us-ascii?Q?7SBbRifxu4c7DNuq+4J6I7OlYVnjL4DKxl0UHu+2chlKeNfStGEoetKs5YXD?=
 =?us-ascii?Q?aPiKqNXSV0DeZZZ7MJgroQJoCNdBYOZuZGrfxOd0waKsDK23lxTN7ndXaTQh?=
 =?us-ascii?Q?c8HWRCO+31GdII4QjeRJId1e44JHA6kEyps5u9fm7uoZP60gwyggbpaQG8GL?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf1c076-0daf-4077-8d0a-08dba23ec761
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:04:32.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rf2mzsUtDHAZ1Ku6/1GW3/xkSFiHceRR5NVQ3m/fZj7fR/4L/KTHLuyCyJTx26oAaKOhvBlA1RuwZFnQB84Zrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9586
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the sync_handle field to the bt_iso_qos struct.

---
 lib/bluetooth.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 1286aa763..f007240f4 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -187,6 +187,7 @@ struct bt_iso_bcast_qos {
 	uint8_t  sync_cte_type;
 	uint8_t  mse;
 	uint16_t timeout;
+	uint16_t sync_handle;
 };
 
 /* (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH) */
-- 
2.34.1

