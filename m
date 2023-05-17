Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AB5C77B75
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 07:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjEQH1c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 May 2023 03:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjEQH1a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 May 2023 03:27:30 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE41B19B
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 00:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggqM4r1lYvrUmeXICGNQnMWixXfjhb/P6AHVy++kBVGKHXrsw1Or0fvxQqP/tB3SHdiV8qnUmIIQYYhKTxb0fV88f3YZYk2FqQKOj8Of8PCu+NzKUjD1U3Wa89hs+vWu70h1qEmG3o4oMAWUc6b3jKDt3EcOrYijix530YEjOZFtWClYRsQ9s7LYuWr4L4juhHyVnLfwGH9nAzh4a0zGxP9pa4lKLrDzX0GvkXHeAWovxQMuuMHs2TjthO0ZEIC7JLc9/3FrCe/Qzfxf7UbAQdaWvLNXmsOJe9hMwCurYL5tKcsvbHLn/1P8QapFqv1ANU7t9sMvRvPmJCIZ80ObCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUJtBlHW/7gqXSxvgDVdpZU23CbOUuCFEb8Ko6niXkM=;
 b=YJKxjCOV8ffQcyJm8K0xNdjJvS0F22mmBUefy0FGCqBH/WxduEuTx+rb0s3sgo1NH901Fq2pY3ZbeK7Ref99K891ou4vrm0dxPmGIAeGes/JKmbNqIc7Nyl/fmAfe5acvkdTY9qjmp895NzsDBFP7F3fLH1UvJ1OTncVPYvdvNoyE01wA9RJCHrnEg4Ctgwg9ZNnD2zSfo7TwIFgJh/s5wraBolnHBBoqX+GSYYRcJLEvyBSsEfKzC8WOMYwQHoqJc7qTAkQzPzlM6CFLpEfXup3jVLnn7Inr9c28bVcl10rhpgTX5aFplkMswZTybCIW6gjXOcMFjGI4aO4cNz18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUJtBlHW/7gqXSxvgDVdpZU23CbOUuCFEb8Ko6niXkM=;
 b=GaIS7ChX3dTGmTyVg0khmSVEYRwElPoAT4pLQ4hWzMWKlGNFdDmsJARF83YNPvrx19jGD2pUyUlP4wkFaLggSRdHvFROQ+GdDBZ+cVmny8BA+kTx5FVQTOjTyFXWLrXhE8ruGS7ZsZrem7yOYsaKbNKlNvXd3gX8ajYLKZjl4Q4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB6993.eurprd04.prod.outlook.com (2603:10a6:208:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 07:27:27 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 07:27:27 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: Add support for creating multiple BISes
Date:   Wed, 17 May 2023 10:27:05 +0300
Message-Id: <20230517072706.5988-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0032.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::9) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a54659-b315-418f-bbac-08db56a82a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 13MKUIdJDcEt1FvG5uCAsMAhoTsWQQ1a3+CDQzHFOnlUCpGrR6mYH+7hu5VgKxfP5d1sru0ToudDQlp2N62g7t5ndA9xO1duII61nkqDsrHBhJXCZYabNwYXPpPKAIWd0eMH0w7d3Oyng94XeqxUW4O+eCjI9gbldpclleHaUuM/Mo2h07pla65mD6Yeh9A5JEmOTh5FaxL+K2YTVt46TmZKvvIBeu7kSBOpqV+hCnSzsy+6qqhe+PGvI+/gMqMFy5fUGB0jX+dNkJCSoM2cmudb8dxGFJopgpNvM31xAWA7FaJBIF1CQylFVt1u5bDRFH8z0To86+xqnGVSTpAx3PYhzK4uibgncnCxmW5zFOlMScTnQbbvbN9cz2sU35lvUx+Rx7SbDxNz3MCWtte9q9ytNe3YmYf9f7QAVvhh9qezol6wwBXnOhp0j6QCdJTBfCw2E6En+gbSs/GqQXDstaTfi+IewEZ74VTw07ABevNbU0A94uRQahsF5uLPRC5QBWfJyLTqOnQHJNl+9U673oqS6TDuxNb7/dVoy1BMbOqGo70xGVAmKhZriOnmguKoMxG+1ot+/szp1Fwew0/DYPcgwevm+uvKmaV16twqtKMywystx/SBmLW2w3Ah73gT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(5660300002)(41300700001)(36756003)(2906002)(2616005)(83380400001)(4744005)(86362001)(38350700002)(38100700002)(26005)(186003)(1076003)(6512007)(6506007)(44832011)(8676002)(8936002)(66556008)(66476007)(66946007)(52116002)(6486002)(6666004)(478600001)(6916009)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wdbu0FRAAQUnEJf3prSEwYxqj5X+FGWUDeXivmDiFHtRsfMM2hFwHnQEuPPa?=
 =?us-ascii?Q?OeXixzPDB+Dn5ifQHtaTYiFy2r5JqQfeAS6oUb2Ka5N7lAwd5xacwc9e7bP+?=
 =?us-ascii?Q?CksPcy1IEY6iKdCxo0e9jZ9lE2vxXPI3SfAYwD1n8zrRzJuwmFK4LrDYshvc?=
 =?us-ascii?Q?ZBICIT0v6PLDXpymLP1U94GPmEfnCSzgkNZth/Hcbf4SaEklX95F6B9W6FwS?=
 =?us-ascii?Q?aGqs0jmKNL4vUuPos05s1fZZUoKaOxZp7A8WlLXUEKbyviPCROPgMoZI/gAs?=
 =?us-ascii?Q?jQBglf3ntO7NEUBarcI3cuQ984p7Zb0VMlbhdWbLpUQEgVd8D3eDlRf4WGLS?=
 =?us-ascii?Q?3k+wZl1NA+tY4owo6ZLDLKwTahy8Gp+V1KYdGcphUV+3UjFqcBdXTxqPvM+4?=
 =?us-ascii?Q?8F2MRdOUqUDffan449zS3FVEZ11sF8mqNJaCZqjalySQZtId7DbLr2lkj65f?=
 =?us-ascii?Q?Tmpc9up6yiY7MpRKJMn0zyWsz9FDfAaJDQ8gYpJzSTczeZ4YcK8ORk7DcGWo?=
 =?us-ascii?Q?jM9j/Wni4g+LeIrf2Q1FDt3oKRumlposs+dBt4L7j7X+PCq19CUGsQ4oVtrn?=
 =?us-ascii?Q?gF2qHCkPozK8PGshUw69bYkdVdkvBRVcRuHr9usJMEkyN3b+Gr1Pqgq/kehA?=
 =?us-ascii?Q?68qNQP0ve9do5P7klmyqfX5h+B0loe7FUHbcgaNHumNlri4M8B/hhXxzFdGQ?=
 =?us-ascii?Q?Axzp3bhSXfhXzizjlfXoXULpvHdHA7t0tV5TUEG7yrg//2XMDaJdcMqrdbkZ?=
 =?us-ascii?Q?UImm9YMUiHrMVO5TVQb0Ms6CO4Sf3VUpEaU3zysevMI2IVdkDFlOnMYEEO5N?=
 =?us-ascii?Q?8as0qLsgTB3oMbpjgO7qahGtihKJR76Temdhcdg2Es6oOFFzHzi+KrWLGsYO?=
 =?us-ascii?Q?Zr7jXRp36VdntF3ULF7UmjAdOsnpUkvY32xhq4BkhqQ1HrVKA854USH8t9wp?=
 =?us-ascii?Q?I8YXO4E6jpon68uH+MbyPGQNUnpShhjlVG8g4BFHM9HTf9M0U7BS00o4Sefz?=
 =?us-ascii?Q?8mjhdWHowacLLfqmWOsigOq4ztmaqWCi5ZL9EDwjC7skRfuTPGyXvRHY2TN+?=
 =?us-ascii?Q?itfOLGgNywJjPy2q/KVWpKiscVa8suHOtfnyY1tUGneKA7m7S88nlKT6GTAb?=
 =?us-ascii?Q?kYeMgVzBT+SqPxRrVxBqj3JBuWWzPWhI+nKXOiCrirgM81dfUbC7cfH5N6ko?=
 =?us-ascii?Q?BTVJSnFbYJXhS18GK2IGzTTurdCKvVTah1uFQMIoqfNk6QryuI+nCS/vWRx/?=
 =?us-ascii?Q?Wkupd9sil7gRzMvTa30//VwoJwEuGbxfuSzybhghJaEDivUCTUxGMl0497eR?=
 =?us-ascii?Q?+uz9Ve8V7+h80VNnY+EgKCVHQSTjrA+qPgolzNG68f5/4Ey8UUO1Fetid2lL?=
 =?us-ascii?Q?zv/0aVTchMMYCanDiH16wwyO9WXdb5+FtSpzKzc5blQ1jTQvGCFFHU9C53fU?=
 =?us-ascii?Q?JYkfwrl4groP/ypNQ0F6FBiDZmSF1k94xg31L2+omTqs6UcdMpzAZQsG2+6v?=
 =?us-ascii?Q?xGUoACi45xsXT3PH6bHDxbkxfNJsEV0uyLXhDdykjDBIR6HD5kZ0KGvOcpMe?=
 =?us-ascii?Q?PRZ7UWJJ4aqe+pkQmrdlIQOiY37YC8oYsTUve4u2AD/XFdg31hjGJDhZZdkt?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a54659-b315-418f-bbac-08db56a82a6d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:27:27.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwidH51QPthYRWQVmzW1s/i0BBvef0swKhLFYpz7Dkeo9Bmumk++y1/L/rNp+cE0u63eFeZ6ABSVlXvNO1TRnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6993
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements support for creating a BIG with multiple BISes.

Iulia Tanasescu (1):
  Bluetooth: Add support for creating multiple BISes

 include/net/bluetooth/bluetooth.h |   2 +
 include/net/bluetooth/hci.h       |   7 ++
 include/net/bluetooth/hci_core.h  |  32 ++++++-
 include/net/bluetooth/iso.h       |  14 +++
 net/bluetooth/hci_conn.c          | 150 ++++++++++++++++++++++++------
 net/bluetooth/hci_core.c          |  18 ++++
 net/bluetooth/hci_event.c         |  98 +++++++++++++++----
 net/bluetooth/iso.c               |   4 +
 8 files changed, 277 insertions(+), 48 deletions(-)


base-commit: e6e576ec4e728b201a801374b0cec649a4473908
-- 
2.34.1

