Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C45BC41513
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 06:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348303AbjHQGpB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 02:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348312AbjHQGow (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 02:44:52 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1C6A6
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 23:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPlLV/4nmkDpWmd4l30ruj9RV2BE0b8soX/5QsMXHR0Jm56uaQLHG6vVsY5qAyW2U3RD/32g+wSAxikT5TjgbvkhSUZgw9bKMqO0od13zs+xDLCr1iSM0LMQkj49W2acf+HXxWZ3+Mk7Syp4URJFacSLuZEjoF/QZpE+S6YapHIkqHGB/5xXF9wPa0Om1+qcCWJV3g5b3dC9Q8xjEhuYd0ou3pFN/gsOaK8eVLE+cguRd26y9cXEfVJCfyVdoLktYRhYnCIR36PMydXpwi0YtgxRs1ZtuCkY4xJlaAOh8Tx3zXOtTHeBc28J8nswnnh6Poat1k7k9U8IOIc6leHDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr7VIjhJLyb0Fbhr+Q0I1oVeHxnMckLD0r4c3AWwwxU=;
 b=jwn+nUIu16wHjq4WFCdIoRq99YDvhO7JvX6y0M9s3w29LGd60zRvzDwfDj0ZjU0vGCKcYmS1iomm5svFQvM6zLwg4ayE/HAiSX2s+M2bBG/2a0Jc7OjPHjTT3EL3JSoGotQGPPTBmQ5c4XhwTnORIorIJ8lM9JXtqCAVIaZI1PQUwFhTJSzLwZlV47DDmhs2aVbm7olcJ/xd8Frtj05penMzlyrWsfPSjr8Yt2FeGGBWIJDmI6JY21DRiv4UNsC/MFCc+GYV14RYdJbubpLHTbQYjkk7P66oxHt3MOAZmURvWLN48dOkRHA7h7aQ7Ws/QpTe/inGctWEXq7rmxI4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr7VIjhJLyb0Fbhr+Q0I1oVeHxnMckLD0r4c3AWwwxU=;
 b=OMo1IzSEon/XwDLBj6JH17hf0SD4gC9GRkQT8rtyL+EfkZKDMCvgd6Vl1778NZpDROMNvV28KtaQERWtGk/3ipmXxMvmQ4bFEobjHB8Ay5Z2QERvutmqz8ylhE2uNm2edy8HLVcb25ZAW4/9rQWoACd33fVJiTZbGW0Q0d4k1S8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8484.eurprd04.prod.outlook.com (2603:10a6:20b:34c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 06:44:48 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 06:44:48 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v3 0/1] Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync
Date:   Thu, 17 Aug 2023 09:44:26 +0300
Message-Id: <20230817064427.3647-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0083.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::24) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 250610e1-6e37-4e6e-82b2-08db9eed737b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ins+9nEaZbxR/RRnL/4ZhfNj+FTltUZAI1VwZnWl0oDX3OTFrG1rnWAtPugRcEsvqOYQMeTG6hChqIBy6ugKli9CDvkkNEESg1Pu70N5ll8scsAIUONG/r3IQ9cjLNPZb3wg3hFAkFgbtugR/gTWG12YtFiUNDHJipBjy6zfgH3Yy12KgTHQnkBfbCufR1iMZiIoDxzFhK6P2zgSCHkZMlCW37wiyzyg6t7XIefhP80BIMzZlHBZmHZsOuIJ7buzYU8yWnRbcy1YPFZD6OniQXIFncPwSVbcJ6F+rECG0bL6V7wHZkZthxJJMiamKTVOHzHM89nEwmLgk7QARn+D7E/+ivhH+oOqvC27quSPkArsWJr0nOXOdgPis8xWMUyDc6O0kHWPPf9xB9V5MJvuwCmm8znyr3FGCKuzk7KTQXz5dmz/AtdNg++YcFQdExxeZ0rbV1VoqqXTc0PmbxC9VOWtUkLROPb+v1Vimx9C8t18KgZGUa/F/igO2k5q3lkIER21oZzqXM3lwqJAgOY8VYnZvoTdv/zOsaxk2p/vtarqYsnuAKmTyPUQPLK6P5RltlABFSr60nYl0gQ2rMszph8djjQl71yaXiLGd6vysy3mkVAS0ScfHCmrMVnUFV8R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(316002)(6916009)(66556008)(66946007)(66476007)(5660300002)(41300700001)(44832011)(38100700002)(38350700002)(4326008)(8936002)(8676002)(26005)(2906002)(55236004)(83380400001)(478600001)(86362001)(6512007)(52116002)(36756003)(6506007)(6666004)(1076003)(6486002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1r5tMMf+atRf0i8uaH3Ab/N8x37XzJvw99mPAyhr9N4xkCZvanvM/ejyaRE0?=
 =?us-ascii?Q?3i1Hwosmri41mwbm//M5clzG2Fpl5XmUPmjcChyaTJhTbPPNdqnuA+0dsUz6?=
 =?us-ascii?Q?G1+yTzYQBYVlUlWLS08oe4aPAGW2ddX8eWi8ylU0Nkdue4MHx/wkhlcFzDTy?=
 =?us-ascii?Q?1hUQZZ9YFB4FCSK5Yn97El58IKnPmcms+YBoE9IX68xhH+LkIDOEpdKOcxK2?=
 =?us-ascii?Q?/k0Qw3M7J8vb+TzPlYyLIwg9f/MisNbukM3L0g4xhR3I6SPzMq49bPxz2dLJ?=
 =?us-ascii?Q?SIAWsY83hkB1iPwoC/EEOzR4ioaYgLupkUXqDB9mTRF7H6ejuVK/kNcLYBrN?=
 =?us-ascii?Q?Nx6MedAlDTao5TjcfhCdbMjyXrB/W+TJi7aQzYBCYhK1p/fvm9K9bTelG9zd?=
 =?us-ascii?Q?J7NOwisB3xzTF1UFDkKI1ae/mMsiJu16p6WTzoM5R3nGIz5RRvN9R3OEwXGO?=
 =?us-ascii?Q?WQNw0EwniVLNztj6XSps+YvaFe30vm24mMhASBkAZyjYu9GX5K+kINP5t1Z9?=
 =?us-ascii?Q?oVYhF9L9bqP6TP+jCZAfNYyXnobsfnJ1CE9qOSYP/F3WVUIU/ps43J6R5Z/8?=
 =?us-ascii?Q?a4atT2ayLoFVU0QSzTbIFXKHECv248lEXCFFavFngW3klGdDY6rHoSWDojav?=
 =?us-ascii?Q?weq8sl0qgRdp6ezIRH03q4Wyc+TxSCePzUEJ+p1pMepbshF1njSbBisFr7/U?=
 =?us-ascii?Q?tSR7wTQOf2k9j7Z1Ozuq2mJhjIoroyPo6b144Ow5ds73Vuzo3yTMio4KrZRG?=
 =?us-ascii?Q?HLb2ewZHVmEc2lw+GdimBLbHOv78CPdkr6h65Uys23vb8RKcuUfcQ3TWnIiH?=
 =?us-ascii?Q?6b9KxG3L2N1y0QwwDuyWh/6Vn1E+xQgiwWJzCTeOyVhEmZ9RJzsMyXHDUfXb?=
 =?us-ascii?Q?RhGMWPtZVLXYHjwtLEFwoct3gPOmuzHZPKLc6zT1qDwyhwiw7+sjgbmzB4yD?=
 =?us-ascii?Q?7q8Nz2GWmrbQU+CdFZ9Vk98P/ByZQsn17lOTn6vKXnJwHGlFXzBJo4SldNHb?=
 =?us-ascii?Q?sco/jSmQKl9j6fkwP5kK49a3mtLkOWHu3grSCV5SNfANJ5uxGQHOQztBjpBh?=
 =?us-ascii?Q?VJjOjs7JlaNyZijCnMUPchXse5sJ0SrWadjcrRJP4buTq/uHK3UIyXpzTMd/?=
 =?us-ascii?Q?SZgCj3Ca1NhuDLRnk1uhk5S8u3Ru10rCzlbiAMqt2gBakdklawgmZea+3f3y?=
 =?us-ascii?Q?yAfg0lv0Dc9/rITKnw7g2mxAIBgJ0UHd9yTQCLOVgEOCzRkRXQ54RpKnQeLy?=
 =?us-ascii?Q?8UMgHkbuw0PJtJdd9dP7p0TgnEM284/S3hBkLM6Toij1Q47i8DGbTIafgP/4?=
 =?us-ascii?Q?JAOVmG8tfvJvrn2tAo6FoQyF8MFCF5qttMAFYrCqtTLZz+FqMKwOyjESPJKk?=
 =?us-ascii?Q?IfGKycFZf/CS7GskmybeFOVT7y2wlFRHJ9eCVvLrv2SgSXTrq+lhLtYSMZu6?=
 =?us-ascii?Q?F5DaplLJoNNrB0hzGUnK9IsGdKtq55Gq+UGlDa1nLBH7Rdz0JnTLMQpMhK28?=
 =?us-ascii?Q?OktxQtLf1kzyA4LSgvfiTVb6qbmfPqiifjmfG73j+OGxH4P7aL4LUiTvYmkJ?=
 =?us-ascii?Q?yWIe/6iN89swu7aBqCwsGo7UqWKde2U2ep14pf+YQhQMxdz9UL4zbgMKJfPo?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250610e1-6e37-4e6e-82b2-08db9eed737b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 06:44:48.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMUlbBUgW4a14kqDlirB13WhGcmtMAdrooiIT9unNPyFMh5mED5BdUlvWxACRpIm+MfYeEXdJkplr35NUMt8tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8484
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some scenarios require a Broadcast Sink to complete the PA sync and
BIG sync procedures separately.

For example, a Broadcast Sink might synchronize to the periodic
advertising transmitted by a Broadcast Source and it might detect
that the BIG is encrypted, by looking at the BIGInfo advertising
reports. If the Broadcast Sink doesn't know which Broadcast Code
to pass as parameter to the BIG Create Sync command, it might learn
it from a BASS Client through the Set Broadcast Code operation.
Only then will it be able to successfully sync to the BIG.

This patch implements defer setup support for the Broadcast Sink
scenario: By setting defer setup on a broadcast socket before calling
listen, the user is able to trigger the PA sync and BIG sync procedures
separately.

This patch contains a rebase against latest commits.

Iulia Tanasescu (1):
  Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync

 include/net/bluetooth/hci_core.h |  30 +++++-
 net/bluetooth/hci_conn.c         |  13 ++-
 net/bluetooth/hci_event.c        |  41 +++++++-
 net/bluetooth/hci_sync.c         |  15 +++
 net/bluetooth/iso.c              | 160 ++++++++++++++++++++++++-------
 5 files changed, 218 insertions(+), 41 deletions(-)


base-commit: ef6d9b23aa589073cff4371135d017724728ae9f
-- 
2.34.1

