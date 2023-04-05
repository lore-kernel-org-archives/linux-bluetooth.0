Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBFFC76188
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 10:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbjDEKzG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 06:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbjDEKzF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 06:55:05 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0A793
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 03:55:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjVqjr8FvaqC2zora0PzXem3vPiyrc9D3xHi1sepTihAUTcdMP9aaUx7oFqwXxMA7avIrjXCEKTmX786OAbQIzKcJGivStK28HnGJiXBsKu4wcDQGVOvVAQ7RiFDMe5uWx7vPJ9sWA/1YDaYeYAQ+gCXc/oL5OlQ572lWbPm0KlmvOuK8nERaLUmWSi2KZ3Ya/xRnY59MwRbbLoeEkpW8olxoBCjFVqcamufLoPTKMeQqnBnyjEakRbYawCAtWUKM8819yvBdyV2dunf/h/xwyhrwKBL5OyCrqFH55eyb3MzkiZDieTew06wcbCuD2300R+3RWRLGxyuE2EeVsiNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CMGuce0vn8c2uQjVUqh/OW9eOWZpJiNpshqHmeQmyA=;
 b=YGoPNJqLVkEjL3tW+9Jk7HntPGX3IT42CuWOUM9O0XuzGI3H1HiGQObSb1Zu8frWmskT4Ry/C8l7Yqq8lzmGaWguwLvNYc9ELbFebQK7euznUTyHGkQnJpnPq+yQVZGiGhDSSj2GKokhHJDPBU7E5QmMe7dD//iA38sqo5VnH/4BsQuTSvoOLKLiMcKrDO9TRCCh8SZejFE0hvVrQzHVIyhRyDYs/zwdz3XNmsm1Y5JM6p2IW69LqkC/IiTEuvRMBP5C+RgPbPxPHFThTt0QRVccNvu6XLnb9BnaHqBuFexSJq6hOv5SwUQgptcdn9Es3p6vbH55iIjUOcqdvOBw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CMGuce0vn8c2uQjVUqh/OW9eOWZpJiNpshqHmeQmyA=;
 b=PiYnn1gTMBupvM74/yOtDIVDX0ZJ3AzPF4BJeUAzK9ncI+ahPzeEgRPLhEcYlsGa8uZFdR87AtLIlAoKLq21ZparS81KYu5703t79tLUrE0xV0lASK7LhPa4bkfzv4tWDLUGFAftxnM/t5fyggeAxBQue+hwSksBx7MMET99RlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 10:55:01 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 10:55:01 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 0/1] monitor/att: Add decoding support for BASS
Date:   Wed,  5 Apr 2023 13:54:41 +0300
Message-Id: <20230405105442.14281-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::10) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 351b7353-e3df-43c0-dbf6-08db35c4349e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2cB4kZh86yGPOUnmP1BstPOZTxRcSqrczmlslYdCZjLPKA99E3gn6p6Gc3gU0k1T4LbyvuRnptoLgskY+LNA3ykiRVCkuYFT6jVqTZgrgn5FUp13PiLwz17PfrkkNA2kQ81IIofnV4cEva4a/0ZePqFa6Ho5p6q1OGxWc7UiciiNcih7YFvz72Cm/byEDA4aHGEiDbEslsN+3Dibn174/kHQbibs6wket7iftfsGfXZE9CPCQ4KklI8Oofhhi8hvaZSicxAkzYPs+ye+y8U8naqg4599dD6ZhBOrYfAgzJGmtUwz0ahLvrIjrbRZwSIWFKR9mOUHOqdnYqW8s+Y+YQyLLwk4/Kms/XXctvPXMTHKovs8CfepIeh54OErki9LhagaGcuNsJAhYlzUPHR56nRC+32+3q+V0gdfFlGjyc/OJzgxhURX2c9ZRExjyEwqrIAqyT+rS6sBVT91gQ0eVaOo5Fpjn5WTDhaEWP+pjjn4T4e8V4QRz5nm2UKgVy730TeLCG3/Q37p5G+MdWUoGJhVVJMQ8texMo4Rx6A4eEtWgdl7PRFHMEQQlE9O7aCoNXy3sVZAfRiFnrB5UBKI6rOe4Hmd077U9pSUZidDHJRtkjHUbfp/t/xBlB/qrLu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199021)(6512007)(55236004)(6506007)(1076003)(6666004)(83380400001)(6486002)(26005)(2616005)(38100700002)(66556008)(38350700002)(41300700001)(52116002)(66476007)(186003)(316002)(66946007)(478600001)(44832011)(2906002)(86362001)(8676002)(6916009)(4326008)(558084003)(5660300002)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e3H5ZyoVDzqrejJeQz0R2okizWcPqR9s6nSJu+5RZeIZfPtwPka760QCTvp6?=
 =?us-ascii?Q?+mfMmiJ0VjGc93qfrah5nH16Rg0ZWhTRFKB8wsu3+NaPICY0VdzDQT5shhnJ?=
 =?us-ascii?Q?Mf3O2JDO53sARfzu/kGZlRp+QI+XlysrAk0YA4E1sHTF5UxABSkHph+06neP?=
 =?us-ascii?Q?Pa58Z3yVGfoSwKmFG7Rfn+Mm3/gFv69wNhMOJXcHCWHDCMb1rdGhj6Mm+GKw?=
 =?us-ascii?Q?OFZHZWDDhl2PgBQilnCotTgrzc2x3RAweEp+84mBKQr2zZuIMTmhoN53mnF7?=
 =?us-ascii?Q?rpRVCYKHQbVrxWD1bRlOnBTXCiW+nnVFdylUEzX81vRExGhJp1Nc4f+3tl91?=
 =?us-ascii?Q?8y/8LXkuyNTsAqiIi6FMzvpg3YCx3uGeqEaHjiKo+Z5LPKSiyXyyAKK5smet?=
 =?us-ascii?Q?luiQBO4HOljC4/CUtdeAFbV03CziO8de8fDd5PGIkoSo30n7pJWQG4Tw5D3/?=
 =?us-ascii?Q?ykbSHW+ibLTVuDJI6stGBLIZkF+SDVg50MpNLmE8hpi7E6X+oTItBINwOnnr?=
 =?us-ascii?Q?30c+m6+b5DEHWcFU27GCOFZKjybgeyxXN7fNUt7cf+zKhPBRL0NDMQk6AdiG?=
 =?us-ascii?Q?tSrz4KM38ZTIFDkm56TgFvY0BXivOSqONmTvmmeHNs45xpp4FfgKVgN0Khb7?=
 =?us-ascii?Q?SZp+jl1mn87EWqYHMi65QLNXBdb1XO/kAS+foBv0kWHMLxlrAK/X8rm3rlpR?=
 =?us-ascii?Q?T5NwyVm3e0yU447mlClE9YCf00kPTTkiYP8q9NfVF3L0mydYbwYOLev7AQDN?=
 =?us-ascii?Q?DYPF8A2HyzB4xDmDF7cG4a9piF/Ar6j7vU+Ksyz1mrxhOK5FH74Mu8F0LZM6?=
 =?us-ascii?Q?fjZPTj4V411yjwwtTe4tiyjTOFGcdyofW1aNcFZoEs9QbWb+QtJtJNrx/tj0?=
 =?us-ascii?Q?Mi1SV4uyKexRuf/pW5qwE7QN1HC1WH/g3UvnTaT3oBbyxQWEKaKST05xzrsB?=
 =?us-ascii?Q?mxCrw7kLLFg+/yamRpyT+udKjPQMRal9JhUVarsBgUpbEp9Mkv9qHfSglVOM?=
 =?us-ascii?Q?wYTHI9L0SuL8gQHakA2JIIVK6aiF7kO/Xb19q1iZJFIHwQuhss2BgJuAiVRs?=
 =?us-ascii?Q?C8zppqxCNxj+i4U8Gil+KJn6edAuvWjy9/eJBXPmcEH9xVPciBNCZe6cFIH4?=
 =?us-ascii?Q?/sMAK1jeDvPeQTHlY8e06dQGafV4b8MKsPIMKkcMSLzx4JpPf6x+kXxvJOqU?=
 =?us-ascii?Q?FGXxJLw5Bf0xnqxNEOZ2eSiFVDl1F6h2SXIHHzpMs4ugSgrL5alwhvp1c0Rr?=
 =?us-ascii?Q?4XgrTV2nZBG7B+o5+x6WLxZG5iD6AaYK4kWHTH1HaVzPX5NniKCEnFMZE47N?=
 =?us-ascii?Q?3e3cf+TYtd7coeiVox5+qjdoPR6AIwot+WvGG1NRyNZFNYowMfGwDW51o28H?=
 =?us-ascii?Q?goJATPlyVDaM2KIhGJkWav4RUkpM2dg+MrOcheEj6/kvRdjL6cvjkX0WFs7X?=
 =?us-ascii?Q?GN7qbWPPAOaSoHjjsYo3sihqEgpE1j9zbRxg5YFuwdpo1wvtozNgPH7va7Hu?=
 =?us-ascii?Q?75gAMUXygEL1hqbDmVzLaRoTyEyyDu2WzzrlSkZT+qmAJbJeC+b7sTNMul0F?=
 =?us-ascii?Q?ZAcruTRXnBLLRncNA/sNZaFdCGp3LwnM+VDPTqwuvd5QxU056TSYQBMhx+zt?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351b7353-e3df-43c0-dbf6-08db35c4349e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 10:55:01.7161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLDp6dJ5o4D9nc2EYjZuYiOy+PLxpyVJ71k+Ryau+9dLLY0I2uLqdMomxEJ4kdwoAGahpcL3TviddCjahAZj+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9351
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds decoding support for BASS attributes

Iulia Tanasescu (1):
  monitor/att: Add decoding support for BASS

 monitor/att.c | 464 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 462 insertions(+), 2 deletions(-)


base-commit: de8e7cfce25b8d717f5ee60ee3b79d426fdcc681
-- 
2.34.1

