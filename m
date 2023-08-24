Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0396C3DA6F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 10:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbjHXKYg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 06:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjHXKYd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 06:24:33 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6EE198D
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 03:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkudNtPlbx7uP94rwRuVHs7gkC5WQLTL/YmpJHPAWUPykQ4+MANOmpocdb3rWUy2Pc8YHGtQnroCZ9vwziKgMRfa0JZwzIG3LhWCOmV/eyEfAIHj0CvoprQtAhDs90xcUVCewRK3AixglS+bdnL8MB3XxdusjKNu93BnJy6HALslNLGjvHP0d50sMRLPMYnxd7NsHYZBBGtNhE7TO6DXzS9+pBGKVdsU+Mh8Kco9vCkVeoaiSO4NapTfKjb3Ain9oe85dZheC/ksL2fWFHiDTd9wUa5dPMoXWz5jvE7GkT3jdG1RA0riodpvOF7XD58BPKOOK+pnLsHK8uCqINn6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVdet1ZEX/EL8zmNFfMoFY0s/PO9xjuKS4lhh7KmUww=;
 b=nRJ2ZXLK2JCHo09CkxOPHqrnpJeB++XeH45Z9Ig+BQnEtuOTyfXQLmHOCGJ5JWmBPAyPDr9klUf/HOySAOYkDi5Xgp9oTZJIwh8OpyRDwX7k/JsfjMFTFGm+8NEpmO8W6bjgwpZY7JFjQuOzDZsTbAsTS+GtI1ZOo2riZ8mw0f8uvJ1NlPJTQGYM3OqavC2/Piii6GqYbPpOhUBqAN6abQKs1lXcBAAykwFSEZJu9UXLnzTwO4fWlO93b41Tzs/pbWE3Xhg4C0vz+eWX7x41JOzekz/ziqhgyY2G3211yQJsY+EOo0Z+qeuk0k5LdHFL2vcPdvAFLbH30Kr3AljaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVdet1ZEX/EL8zmNFfMoFY0s/PO9xjuKS4lhh7KmUww=;
 b=EEyGZDhAZQw5JE8h91n1j15t7yV92y+hSesJlZpVnx6RDWSiskd57QUE37xMVlOLyUr1FSwFZUz7+Ur46PYPRzQ89MMd02OOa0yUHOELa//Yb/+/SAByaItidpvOW9kZNlVl/FBUF+JSF1oKjxGnQ6rw8Yd+ECKEsRtLZmFcTTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8625.eurprd04.prod.outlook.com (2603:10a6:20b:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 10:24:30 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 10:24:30 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/4] monitor: Fix decoding issue for hci BIGInfo report
Date:   Thu, 24 Aug 2023 13:24:06 +0300
Message-Id: <20230824102407.25883-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824102407.25883-1-iulia.tanasescu@nxp.com>
References: <20230824102407.25883-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0050.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::12) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8625:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ec9090-68fd-4088-d291-08dba48c4d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXOWTArn9d3uBbFNlmey4MYqvZrDg6w7Y1/y7Cp2VNEGWBaoRHt4Pl++xiR9X8JSijcqvBCk2yrSmv2BokFbQ0q+fMfFbYn2zzuIBO/XtUr+DOh7XCks4vDR2rA6zjtzKH9sL2zA/IdhVsTq6nsq+zLkFccjNrfPXPBrEaONopIsxlmaTZs/0aAyomSr0m1aER6A97g4fItawdOuYtxCbQ23U9OVZCCPJjuQUjg3HuyMbynCWB1RzeGFWZzB2myaqqEXA8w5txP7hI9oFWSYWhvd9xw2GY/PLXUXkEqgK/FwGIIyqTaYyQwQoy0SMtJhIETLPxVGVPtyUnghSprNVkDymMi2kDf4z4RLYlOYbn9q6LvQI6qVwg3EdzvVB8PJEafkUucTPcIzhu70BFFyuOdXLM3ifItvEHJHuyoUcPzivqZI3iZEumNKDcYMGWdTYSK8DbnMvidXaRMol3ypcAA194hAjYYFrmtLP4a0/rYeRZpsOpmZoAF471k4KguT0DC/btdCW2U+ZDeNrzZrAKnqEj/ZOe1RV0eamRTaiox+zyqyE8aNJESEVy88HGTggBVyBZGmpgohqkQydsjJ1PTFWhzEpZydBOxvGEdJq/Yz81n1VnZHy/QY5+Zbrjnn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199024)(186009)(1800799009)(66476007)(66556008)(66946007)(316002)(6916009)(478600001)(38350700002)(26005)(44832011)(38100700002)(6666004)(41300700001)(52116002)(55236004)(86362001)(6486002)(2906002)(6506007)(6512007)(4326008)(8676002)(8936002)(1076003)(2616005)(5660300002)(83380400001)(4744005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/KLsK/0LD32sfAcHJ4bDTkL0uZ1cAbCBjEa6R33/IwPr1M76xRAdDuD55ScI?=
 =?us-ascii?Q?Svtk5RwI7sMI7XaI26GPoprSSbhFhwvrZ8RnhjxUwapl6RLo2q6r89+WsGTn?=
 =?us-ascii?Q?9sQn8APRCOdRAByqwjEA3HxQBtg89C6nH5IsKUmKTNF+XloZtLW/AXqgReOZ?=
 =?us-ascii?Q?9z2fDAHkF5hC8XgRDyEOUr3x/MXLV2epEDSvKzc+K5XtVGM+DEGeEwAgoZWP?=
 =?us-ascii?Q?HqD7CfuJOvpzyktYSHFgrImy7rxGiK5VOKzq3IoCq4FCgrMmMlDj31QWDVQu?=
 =?us-ascii?Q?oFxxh5tDIvuYrNi2Opz6bYfGErumxq1o9/ibsDHi0lK54JImOEaLj3AbGcsL?=
 =?us-ascii?Q?wV7cvbXyKE9mVvvRSSpGKAxB7VQEKCFMg47NvS3QsoxhvqzLE4KgRyz/TtHi?=
 =?us-ascii?Q?LdVErJv1CMfYmrfvjwS02r9WoaJbpkwzl2d+3I0lT2bhqImqmMoigPEY/0w3?=
 =?us-ascii?Q?hYsoj47KFz8BN9MS320134YpK5vipR1oezuMjsWDGwGki0aeptaCq2DzTBv6?=
 =?us-ascii?Q?KDphJ25nFc2GNqNcOhawoxvDouRtnwI0Vt/G/a74akTE1SKc5Z5H1y07vble?=
 =?us-ascii?Q?cPvECFdsNGXrvwlfPAG1MSyIIjpPQtWg+avFf3mT5Xpe7c3TeN5B8XryQgXH?=
 =?us-ascii?Q?XIRGkkvWg5kguerLMENNhcYPDBaqV6esqyf5tEM2p7fmJ3c1dJ+1wcc+eXNy?=
 =?us-ascii?Q?0yQLUxHdSZecBadQukjawD0FT2xMxFHH0ES5930Wyqi1fc1n/NCjDRM0tPhF?=
 =?us-ascii?Q?QvLf/AC75YbyVC85XzLTKJkp4aajOmwSlkRPsopiBP3BQmgKOuOj6+m2wWvD?=
 =?us-ascii?Q?20pOwr/mGagei2vouYa1sDyDcfwrxndqWZYn/+UouUqXyiObL01VLe/GXqQX?=
 =?us-ascii?Q?A/c0ynMpMnm7xTfPs5TDtWVHK7QG2RowtJrH/eIWtsP2PtcWHK7NhHTPdgMm?=
 =?us-ascii?Q?fdE2csxWkXt0Wlxw5v6/3siCyg44ldznFvSmFt5S6FlGIZIzFYBbhOQ3rJb3?=
 =?us-ascii?Q?K1dgDXMpIKAJHEhjj9qd0eoxHAPzWGziy4KgNgcZP075UmF8U454iG+b7/01?=
 =?us-ascii?Q?xLtb43+MVbcWsPkJmKPHyQNm+Sa0K7AiU7KRMst9T2ZgF1X6UQ1L4aemkgJR?=
 =?us-ascii?Q?R5F1sl/02aSvlBqJCU66kqQ1RK6x/8FOUZpS58Kt/QssqEpzPz6YT2eCrDNT?=
 =?us-ascii?Q?TwGh0cpAzzeECfo1PQYnjOY10XpTKsAagiJ9RTJ9fSt/FP/RvDN4Q72AQNkE?=
 =?us-ascii?Q?zqNcS1A7YqkVoXDoNSSg0holdqQLvJ4IY8PumzZ3W0LIBBgJML9/MCzpr2SH?=
 =?us-ascii?Q?dwNVyuPWIAK+hT9NrrTr0TrDt2K3SzJKcNoXBFxYDmDH5t5KwD+JVfhqIjn4?=
 =?us-ascii?Q?Kh6xeORQQciFFp7+ZALTcY9PVw5qcV98ZeLe4/gWUOoLRrQXBEPrXGYFwf6I?=
 =?us-ascii?Q?IDpsXU7Hz6p3J8HnsFDi7q/XLaxCZDUPWgZKn08A3RLw6k/XtLIuI/c/tXe+?=
 =?us-ascii?Q?snEApWUEVzXaOXIkgb20N8o6emQ40LgNIFJZzkJoHNf67/WVAr/uR8tRdIrg?=
 =?us-ascii?Q?9cqNkXXKubNJJZKHtKQDrBnr0nDuVsZfsP4IS4Ghh29xPHITHCR7HDiFKL0s?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ec9090-68fd-4088-d291-08dba48c4d11
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 10:24:29.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTri904uf0fEPpdUjL91oc8TRtxlVaB6SDnUZPpEu4EMlgdYBa3JRgrjcz9XQgI+sC8Xblba92RkxrZCknT0bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8625
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the fact that when decoding a BIGInfo hci report, the bn
fild is printed two times.

---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 96fc2662e..69600e93d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11783,7 +11783,7 @@ static void le_big_info_evt(struct timeval *tv, uint16_t index,
 	print_field("NSE: %u", evt->nse);
 	print_slot_125("ISO Interval", evt->iso_interval);
 	print_field("BN: %u", evt->bn);
-	print_field("PTO: %u", evt->bn);
+	print_field("PTO: %u", evt->pto);
 	print_field("IRC: %u", evt->irc);
 	print_field("Maximum PDU: %u", evt->max_pdu);
 	print_usec_interval("SDU Interval", evt->sdu_interval);
-- 
2.34.1

