Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E36EE57EB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 09:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbjIHJQy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 05:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbjIHJQw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 05:16:52 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE61997
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 02:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDwUS0oLNPrRr0hkk/9TtlSSQ+6LfR6QR5/3hx1CaMM2q1RqCjLqXcYdjh2fatvu4FohJhx4z1CvH4eIrftujUkK36gxjvoXtjB9PAD86AoIy3XLK7bHGpBx9w01oUM96ryCdC/KTvgNeJsREaoX9EhshRn07vmrBSLggttoTogYY4FxnhyQVUVRU/BE9aCdkCe/sDh6I83F/maevMls7mHTvJrKWq3MJ/vKUM9j0UbDzZMbND6cS9F2NEp5hSGfQ8WmwgUVOQqOcINbFJ1/paNvnSvKLSVSD4ms1MdR+YQcUzO8jdhID/oqjynwMqtYimldaQPbE4t5sJCHdJrPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/Cchi6Qpmfn46OO77oAu2s05v9yJPH0eJKrJ/2DDIk=;
 b=HsFZNykAKX8QZdmJ9km5C/Bw5qW6uwnZJF4uFMzCh2RBj11tzi/S4NJ6uIcSGdWoeMpH6h8/Jl6c5UC0ZKkAo5G6XqbLa+kWuXEaF9YqSHhMy9wTv4Ur/wnGtDkeJRKIALEvNlvUxa6lmfaSK49tJneYl4TE7ZpvrsROhAI8Ew568XBa8oxhoHQdPJ2gZtzXKizwsrhlWnYrixALlqUnu11w2phJMoM2Ya4un24M4mNQlHo1QXU3rWf6wbjbT2gKgh2wOn6FC6M8jFo+5H6dRX6jbjOxq2S2nMOVsIV5DSO/isRMirL6hD7myA8c5N5Livjcs7yd0Q7lMWDFE3/bqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/Cchi6Qpmfn46OO77oAu2s05v9yJPH0eJKrJ/2DDIk=;
 b=rGXc4+C4QTqiklcDGCpjBtr9KhsslZ3tN7Yoiu2UFmHx+G+mqLWqJsRnil6vX9VXlarCb5azShcslK/Mpi7IlkCAiL0nefxbOuh5X1v2Z/YrLKn0m7+S637Wxr5cijvsxbQ8xW7GGS8C6YxpVNejBPDeanrIwQqfr3xTQMmkD2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by VE1PR04MB7327.eurprd04.prod.outlook.com (2603:10a6:800:1ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Fri, 8 Sep
 2023 09:16:44 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 09:16:44 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
Date:   Fri,  8 Sep 2023 12:16:21 +0300
Message-Id: <20230908091624.20040-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0040.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::9) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|VE1PR04MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: 38643e9f-7b31-4ede-205f-08dbb04c51ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CbKgWJ53p0eYhQ1wXjrqWFMPCrE7BcHrtmgQNH8t9wkbGKQeAaEbjpKVWadtS4W83fTy3wRGH3E1r/FQZlHpkCZPbwpMrwB+J+/soNWaHosedsZe5MzB++JP+K4Qd374EABusp0pJ4jFSdx9g9+5nut0EjnnXkHv5VGG0g4E0wl6svT2aX8Y9r5wcb16O+3DKraWi/hSUHdwExkysUQBJBMn0jGCAY7nw3YDUJ7eoeggs7K6TkHeNkZUtSRZx8DeHtuAnNRVZyFeQ7pEXDfZhnpGebfy49OG1etJ4DHJzn8VeZIMvcXC72ob8vmPtLlPRQQIO3U3nBQxiMwvY1VTb8iENf0B81GxWVTHzsGyQRWT+cVDf6jVifuMfWfgHSX3dqww+mgvPnCbtf2UbGliFhVDuZIy676OZkBOB8qOCM5EiuEeYf/51uOdYgZVlb7MEGIu0a9HLfhwZ5wn2N4O64QInLaplyXp7hCvhbGlWLYYYHCHcIy249Pey0aVfnMZGXx7KD0mQ2A/CcAS2oPhuTipo5MByi/KHyfG5UYRibc8I9zJfuUhrNaBLV57eRFklW2j9qNHTDOpVQjBJG6uC3pt99vZHKaj/SEkcUePGeh7oor8ry6PO47RUI2UAM8I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(1076003)(66476007)(66946007)(6916009)(316002)(66556008)(2906002)(4326008)(8936002)(44832011)(5660300002)(6666004)(83380400001)(8676002)(6506007)(52116002)(26005)(6486002)(41300700001)(6512007)(4744005)(478600001)(38350700002)(86362001)(2616005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fu5xhc9ovu31pv+nmLH+dHKCAdMpDFaoMM3/NrwtBwUshG36t/eiBglnBMlF?=
 =?us-ascii?Q?FxApFjBnXPnC9yBcBOzzeXKtKE3HYVa6wBUlcyR680kkD75qwhr4tK1M/YOQ?=
 =?us-ascii?Q?I289Lh9yK5JwJvsaajawimV71pNUeITKE4Rh7A5yxvqgB5yJlc1FhtZhKZBu?=
 =?us-ascii?Q?y3ER8vNDU5F+iYEwnrGM47ctSNup/fFT0NYTSYDgsUvpJjxBOJwWjG0+QG/G?=
 =?us-ascii?Q?WGWr1yFdXJNITHn8E+MaDPESL2Pr5myWOnamdgdPWzeRWd9aZ/Kcwz4R62rX?=
 =?us-ascii?Q?FaWf5nMMZhArz6HicOZeYu0rmjWcgS4PXb3sF/6w1y4kRyN0zQKKNcvIx/9V?=
 =?us-ascii?Q?h7THBP01imeYM/LSocSQGvG7ic+A5vYwq7/OcTtGMfXFqor7J0a5rFRff3r2?=
 =?us-ascii?Q?x6yCqkZ+QWqE4/cTA8kBbescXANinIU6Po3X6GN40Rb0fvPk6D1GuaggFY/D?=
 =?us-ascii?Q?DFWTwW2LOzsThevQP8pKLWMZAOmzNOubhQdSkswvXg8UOTvLpeUXtIjUEEVm?=
 =?us-ascii?Q?TbmOcfNARqyIjMk46qvaAcI77GJOwIH6BigFMCaZnw3q27fUrnF7muCUX3Xb?=
 =?us-ascii?Q?Uts8tVCOax/rcyIKc9Oz6IzVxgRRFil+CMZXStID2TByJg1/krm/jGR2d2SB?=
 =?us-ascii?Q?xhHdDuvGuStENVzzb1cX3NuY6Pdg0nwbJeDHiIu6Z5Qd81igglMhQOgLv8iq?=
 =?us-ascii?Q?2apELheewCmdVy5rDR7Z2OLT/zlH7ZeOHtLE+o0wndmT869IuwuQbEKOW3fm?=
 =?us-ascii?Q?64vEtihFurvsj+C0vUKXBTZp2Fv8wwG6k+ZKN3T0E9myVt+l6OFU75dUUYl7?=
 =?us-ascii?Q?viljgMrcranYS5zt7bWKNhJIBQsVorSw5yLY9QxeghP59fQyc1bpHOUFjNLJ?=
 =?us-ascii?Q?aHPOS2Fgi/hGx/0Bm1amR9lfdX93tVM/vLK/KuUlvFMsYm6K1ci/D2QsnjKj?=
 =?us-ascii?Q?0/PVNFrsTfk72eUaHhaL0Fvn2ZhJm8/uGFZ/MNn92FolAQDYiEDQ7HS/WCOC?=
 =?us-ascii?Q?3vqAsSm4huD1YdUR+CoBkyymjn6dhdn/5J70DwK2KuNwGj+WP6505H/yASE3?=
 =?us-ascii?Q?BeZYwo+kFzUQxdIVIOb8a89v15MYEKcp7YH7jrAUAKJsiguXsNIOENDF3OOV?=
 =?us-ascii?Q?vrAdZ/5X6APgD1zyjuDM6DUkrZvgC0Vt8XB26z0lIiQCYoYQDe2Z0ae3pmRb?=
 =?us-ascii?Q?5bGh859yFD9jIj3mjrmIus+9cH54Yxny/s5J1bUq5z6WcWj/RrqGTDXjxfuF?=
 =?us-ascii?Q?7Rpcdnh6lm9vasbLYyA6l2sSvQaCZgo13wcqL5vv/UdHEEe4DGjZvQL3M6l+?=
 =?us-ascii?Q?UIvj36+b7RwABKGTlYTADK5ysmdNRaDDiVVQsu5aNrkoqT4G9q9ZbNOC5Qaa?=
 =?us-ascii?Q?HoqEqb/zoVuOujBjPGew/F6fEDv+E6hu6C+0z8SxDFnofBgCdm9EvzoxA2L7?=
 =?us-ascii?Q?zjZ+lrAmepRBTQaqQj+BJbsg2eiRe9hT4lbfoirHjlCRpfzv6dGBle9xfpj7?=
 =?us-ascii?Q?6pgUfC4yNhItH2YllhIni9GROfNsOzu8OqbCRqUp8qTAon6QkoPTJ1a0ExsY?=
 =?us-ascii?Q?3WV/iPMIZWmO2XTL/LgHbQRaX5nR+jcOKhlqIy7vuDgPxKTYq98w49oKllRk?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38643e9f-7b31-4ede-205f-08dbb04c51ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 09:16:44.3414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkDu/6fkf6LJOL3g2okuG9j4uImTMHUo75BO0Kts2nt0X5g+b10nuGFubMIoH7SDIv9LC19ovj3V+4c7o+3+Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7327
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently the CIS bit that can be set by the host is set for any device
that has CIS or BIS support. In reality, devices that support BIS may not
allow that bit to be set and so, the HCI bring up fails for them.

This commit fixes this by only setting the bit for CIS capable devices.

Vlad Pruteanu (1):
  Bluetooth: ISO: Set CIS bit only for devices with CIS support

 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

