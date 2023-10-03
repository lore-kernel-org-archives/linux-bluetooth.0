Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5478BE7AD57
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 14:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbjJCOhv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 10:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjJCOhv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 10:37:51 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2082.outbound.protection.outlook.com [40.107.247.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0238AC
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 07:37:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCu7xOudxOGmO6EhbdYG+ACCfZLZF7N+bS4etv0wb50lQd725h/8iPRHCKvtbQPboYIGnQZtUpnuNHK7bKqd2032w/YvniSWMU2+sbK2xJmaIeQURRbRk02zTpiVKFRYsg0LRagPPB5EC9/afQbr1fo/bN/kyI6G5EdTd4FbQQn0ca9dNaeSof3YWwbeXilvLDCcmcqUsmi+xwYU6F35c0n1hJ0BKEd/VwAYzJcwROKLY1l0JZmkasblLDPNETlOtZImb7wdjxSBT9JCQLeD1rLWCkJrk4hFXe4Xqmmt1L3rXYuc15IHoqGs3eHCbVa5whvlOqnOkAAN0hZIqQvLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z19erPW7JM63EaxiDVkYShxv6siFsxkEHwimX6mX7+g=;
 b=SUm7cIaI5UGw22GVRcAc0bOgIy0j70iurNBCXBbge36IwwDKz+3C9GwHlX0ng6GBd1HpiPz6vVdje4GDyWziLy4atKrSiOj1+1Z99U4QyhL6ZJ5UAK/NHowvxpdin+xAhQ5ynYaiMqnsSWgIAJrVxlBehXqfohK81F4D+mAkyyYj2ODHq7QW72M5ro17mZGoLAc3N91oQBlonGt8CILhI7YIFhFp12/ILdqL9eDc5kkRvUbGsP8J9ddtofQXcJGbshybiWnqCTnnToX446ZKpUnMqdRVosgVeWUCG8mEQPHdJyU//pLi3qrrT35rzQo63d45sG0Gs8lJJu0Sz4+I+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z19erPW7JM63EaxiDVkYShxv6siFsxkEHwimX6mX7+g=;
 b=Ol1JU+tri3Hl6pTKHw9BtBLd6tL73eP9kAZVZDWRqJza3O9q/zCB6VoBH4lWN+3R7BDuqleH4ze6l6SvHsqLNZw/3+pLZupXCPqtWO/dYekYNWGyjHLFkF8CM2CgGVmfOfpe1GlksnWU7aa+qVv0mWfFwhZawlDGdeXYKriExTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7882.eurprd04.prod.outlook.com (2603:10a6:10:1e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 14:37:44 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 14:37:43 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Match QoS adv handle with BIG handle
Date:   Tue,  3 Oct 2023 17:37:38 +0300
Message-Id: <20231003143739.2925-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:803:14::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: bfff8334-f19e-48e4-52d7-08dbc41e4d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDPzfohCaPC+0YTLzv56p7TVhHV52Li1ol8XHAQzqFfdW9XCR8ucXz/nt3lJBXtIH5D7DbfUV4M1AKu7hdFwp7Feg6PQLyGqkFZogSXyHA+f1wU1x5IX402h2ypp2Z1eqWwK6BAoVlVW0mg1oqmSWxotnmEFmL6hbpfrSk2nNqNjGj1y8U9Frdu+Aub8aWrH+aY7Q0AYJlYa2ZE6gfOnwKLv7J78KrDpbvFvcQ6Ej0WQ9xOf/pVGX2bejbH6d5f/sNKNqj6PGL43OOfZsXMkfbcWMddbmocjaioBYQkR5k6+lAjRp9a81IBxweyjUHIEJlbI5CGs2Xd2WwP/rdmGCELyF5pxAOTLVc/e6JKrETP6IaDJipijqhtv3AhsN9BL2phRq+SsJMGXIsnOyIZKAErSL5XnsXZd6SQsEsI8DacLs6yAMMYgwMbEhPqpE+sLXF2pQuu29yJDPAEbehSXUAdvyrp5mJJi2T3cjwnAzDOHf7iULULPPlmM/8rWPnE/WZV0G2LsLnseqUCbCZqx1YR8ooOpauXDk/DS2gpTkNpkA4sLuFUTrI9Ijwc8IonO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(6506007)(6666004)(6486002)(6512007)(2616005)(1076003)(26005)(2906002)(41300700001)(316002)(6916009)(5660300002)(4326008)(66946007)(44832011)(8936002)(66476007)(66556008)(8676002)(36756003)(4744005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o9+LJwdwtFo+Oxr/phMw1k0phZ6JI4B8wmpcsHwyukhC0WP1Pm6H+l4s+DPX?=
 =?us-ascii?Q?YUO5JyUzFcqpCaRxpXRTjYO/oB9jWSXUyeqdDXR7vWd2CGYreLOt2IdEfpLV?=
 =?us-ascii?Q?X4X0QvlhgOSXVhuBQpQeO8SNuieQC6pM5QqZEhxtLpxPkW+sRk8UuVaN51Ou?=
 =?us-ascii?Q?oBWq37Zyt7ceoFeO0hhBnOJiiY2mssKkjfts4lquGhpWoUfzuDg5mzRadQry?=
 =?us-ascii?Q?beTJG7d2Fmis5Mp7s8SS3/X++QEt3nnwMwBEmJ3/GGWn8jADREYTmPiqcXwy?=
 =?us-ascii?Q?LU23Vspq9wUdRbnZWasTiO3A5O45XMlq9Q7ix077FCN3LAQUTydgEnZM1AnY?=
 =?us-ascii?Q?zS3FiIP2Gyilk+y6Gtq7KFWg3xlxkadh7sErYsar2gIstx38aFTij+pEzzJW?=
 =?us-ascii?Q?vRUn+L2fYiUNOfUyExpAtTLuyQJr6jwshVDR0IsqNS/29gdGoMehwoM/eg3K?=
 =?us-ascii?Q?KJO+w2eEDW8lsk0fVSIoBB6rztEdSlZfGjzQOcfALADKg/BpdO1HsLDwCaIw?=
 =?us-ascii?Q?bWCcucCj0tILazKPmWrql/QJRvDNlav2vZkKFudMcGauuAKlU9Qzdmsy1btK?=
 =?us-ascii?Q?WOnbFYY/3kWi7dy7j7ua4usBw3LS6Z3IiI2/kZqFLB4v2TJ/vjugNcA9odfS?=
 =?us-ascii?Q?rJ7cUnpwDg3KqCEvEoO93b3clF24S2R7HYU6Gd4NjVAwrqnTgDeStgO+rQKn?=
 =?us-ascii?Q?GNRfcuK2QvA05nTaPlQraZcs8cv7L0YEG41JM/mZP9g9bvt9K6hUVBkfa1Cb?=
 =?us-ascii?Q?I0TJ5TbQ5hWCczybVAcHJahb0Gfbdm7Kw1a5KEdMup2Xvs0nctOWOz1cTAax?=
 =?us-ascii?Q?ez4GVwN77RheyhylFXmZsRmC7e5JuqAfvqCvZPCaFMo+Bl7j5vm1k4UsicNm?=
 =?us-ascii?Q?lDftungVn9X0cYYZ+rrFAsb43VheHSmz5hfAGkX7nPtpKx3E7GMJJwq1DIEt?=
 =?us-ascii?Q?PaveUQTNKdr1gBN6/aniseAVVVcqpW6wOyZiUSxHkCl1MOmMa3ZB9tlqbbjW?=
 =?us-ascii?Q?f8UcPtP67KKin2axa0l5waQ4jKBUhxSzLqaYlU5RHmHBwgLLv9JvEWk3wMrW?=
 =?us-ascii?Q?ZHXIRYyapOQWyrzezRP3bAgypx29kAni1U4EV0wW6MKCWgYg/SrEFLtXu9c6?=
 =?us-ascii?Q?2BbjtHny4zpL+ZwvzMuNWvUppf6wKKZKT6DPIu/02SvMN+n5uB9xXEO2K3v/?=
 =?us-ascii?Q?2irUzT9+ouE2wiwysvCWu42BaTE1IUg5666YA/finH1jI6Hj89blFdsbIwlQ?=
 =?us-ascii?Q?hIijVgzfA7NCln9zMASrQo3ErSVv5EHfDYLWlqwdm5M483DrDUfJPyiPkCTR?=
 =?us-ascii?Q?siYx+HVlFfSKz7Hb6wQC94HuJt+UiXLrdiVh53migOKVt8quYJRHgqPFWxxP?=
 =?us-ascii?Q?lGdjh8+407NTDcyk0fj5X6iRfekhVT735UHpGRsr6iYFR/pp0TRP+O1qAYqF?=
 =?us-ascii?Q?mXIQb0NBFmZ8hMyNGH5WgeswPnaSF1wqfLrkQt0CZZsoiLJ8MT1GRPtEhxUQ?=
 =?us-ascii?Q?X0jHYIFMLaMcWC5oUoQ1Xkfg4Zq1KC6r0eJw+OaiMotytLs1kN6vaN+UMzzE?=
 =?us-ascii?Q?4eUc5LlmFW9BK98TcrhY5D+EPSb+iyIgznMLYIyNh6qfmNo6z5SBfUgEriM0?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfff8334-f19e-48e4-52d7-08dbc41e4d94
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:37:43.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZfZRTg1z0R6lHkJwy7p3BVd48cIG0la3lbi6pQtfaPTUb2C7oZ/ZWbwYxCfCqYPt0+R6p8vLMpvdl8EUHjZlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7882
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently, if the user wants to bind multiple broadcast sockets to the
same BIG handle, the BIG and BIS fields of the QoS structs must be set
and identical for all sockets.

It means that the user must remember both the BIG handle and the
associated advertising handle that the BIG will be opened for.
This information is redundant, since one BIG handle may only be
associated with an unique adv handle.

This patch makes it possible for the user to only provide a desired
BIG handle and leave the advertising handle as unset - in this case,
the kernel should allocate an unused adv handle for the first opened
socket and then be able to match it for all other sockets that will
be later bound for the same BIG.

Iulia Tanasescu (1):
  Bluetooth: ISO: Match QoS adv handle with BIG handle

 net/bluetooth/hci_conn.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)


base-commit: 091e25d6b54992d1d702ae91cbac139d4c243251
-- 
2.39.2

