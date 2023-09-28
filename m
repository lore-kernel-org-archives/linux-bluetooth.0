Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61CACE7B05
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 08:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjI1ICX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 04:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjI1ICW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 04:02:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBAE98
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 01:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VniE5kY9xIaoVheHzUYODF93SP76GBO8zJDRJSPX5Yg/NVzy4QOWx+SVXX39oXrzG0R68cNv0IRDJ/wgYQ0hSlpmd2MZHyN/XcWOb8xRMAvNm1UWQK1gKX+pAhn3cwTxKNMVVTzcSCfx/QDK7plebG0QHp9IXQft8wX3Zssgecy+IyOfYQWgkYds/XMiuR1qNQRI+WUCO/L49MFNCL1kGZVzhvAStfWf1zivkXufKP7TE0muUSVe6BDxYiFYasJGTaRxYL7wCfhNdGwCM7PekBSmIEblO8OchigiVmkgJ7W52Z9QIZEsHNDkANEJ0yT3LR1/iQ/MJeVZ3laDiHHZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79eKjmm8+zzNqwXX2/pzZK+jEig4nJlZQFJY4AxaY0M=;
 b=Yu/9dzp45h4O0VS1Ex7/NuooZyCjcUDBWXRFqePHnFjRFWWGeRtMq4LJhmy73lMEt9AHTqQdwg/HNyR2hiRXKg7RpEeLnC3V374/A4JnKK/flI7ifmcpMQwVXSdO/rVFH4aMIxv5DaIgudnCZCUJv0yB6LQbbaISjjHqS4LqOcWgMyHWKo3YfU/woKcrFJD6nsEvav/LgKjOqidoTVr+LeCPTS+6H288l7h144/wvyJjUCicZs/Qx/br9NvmNnL0wdqAKHQMT7aYsto0eNCPVnRXBosweJIv5npGqjbyHOaWh1OQFf5nkQS09ykewD6Esrov8c3e0rA/P1uS33NC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79eKjmm8+zzNqwXX2/pzZK+jEig4nJlZQFJY4AxaY0M=;
 b=ePTWqEU0g2mH4Rv8jwEA3TnWcZ1ZnYwG6D75zp0D83qeMKXzCZ9HvK3xCkxwMafphva9OTBsvArIWbzyh/lYYHHLhMcXCgJC9qUHLGS90nezhKBPtBPAt79qKjD3p6yVrrTBHptk8HVlAFfnzc1XAxhcKCdakq6LGLGsWMQ3WeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM9PR04MB8290.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Thu, 28 Sep
 2023 08:02:17 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d%6]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 08:02:17 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v3 0/1] Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
Date:   Thu, 28 Sep 2023 11:02:07 +0300
Message-Id: <20230928080208.5517-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0012.eurprd05.prod.outlook.com
 (2603:10a6:803:1::25) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM9PR04MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: d938405b-4afc-43d5-ea78-08dbbff93be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxlOUdrP7wM5xi50Z3DGP0WfCou+M7UIG8H6LZF0yyOB/C6/8CJ4MYsUcIaTRZSHj0HSGaUbCGOx12LPaS+USSIVWvNE0F2IAOL2l5lEZw/zd8x7duxAfXXDDfwaiOeVz90d10ovez7ULPg2SX42vgIvVvpUMwoz/6EuolzHdDkUQvUgFEIZdM6huWG0CWkJL6YKhojI3RXm1YTuc2rrpFecSbVB48wmQJCTksNvID+MiUMFM2tDbzQ464ShsSDmM+KP8io7uelfJyHudfAAMTIUHAgmuV2sQ9FrLIZ/ObV53R/VCaH38EVy3dEDjAs2TOHOrJz/165kIKJY0yfB6xj2JiH9mzQWyOv6O+cS0eF8jUU6sRTgkKZDgbxq+O43oRCvM9QcEkNozUyUA9R8myS9weBmpZJ4RnASHfDUoZEO1rxG1x1CqXyX3DYzKgO6KNdtfkxV5Gew7Hh+RBKv1vGvoWQtjzt+t6E1VgrH9H7IsLOvJXwZFzeMvyswIpAaRzzOpBAIUX2MyMqRWu8ZMLCAdpIjKxiQgIYDmgwiM40vctzZThq+i5wUaAJ85zbo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(41300700001)(8936002)(8676002)(26005)(4744005)(2906002)(5660300002)(316002)(66946007)(66476007)(66556008)(4326008)(6916009)(478600001)(6486002)(6666004)(6506007)(6512007)(36756003)(1076003)(2616005)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T5fseSFlGhQFEqwh+0p7xR/5MtVBpxUputlXN310kmKtud0uxXWZL5edTAdm?=
 =?us-ascii?Q?oLYHBXU7XCk1pxAJz5jShGvKBeFtjHV8c1rTl9o6n+4/Jbb3OjoTAxMp3O00?=
 =?us-ascii?Q?h4zGdKB1SdJLd7a/kjWV5ySawlJ3VdOIqsx97M0NaY32lw1776RG8UGWPmb/?=
 =?us-ascii?Q?MrYHRzvEDB30N94htEE1ItQ7KIipfwqTC+97xl6SFE6hqReHRl2cf4KsyInM?=
 =?us-ascii?Q?PPT83Gj1uc4DZ12iuhLu/HKBbvF4jVd1yts4r1yvAJTxrGdnmBcVLgy879pG?=
 =?us-ascii?Q?CF2MXX6voV7wEFRmuttirmyGrnC4hyspFyDRUiRuGqn3HKBNikKipwoGWktw?=
 =?us-ascii?Q?Qr9IoEIEaEfv+ejizFtZ7W9EqxcfPt7eRdEdazo5PgxUYruPMDS1x/R7Ci/O?=
 =?us-ascii?Q?WPDWrXPNBRUzFPL+mljknd6eozEs6f4TtW7gqGxJn5GQeMoC6Uq+krBr179l?=
 =?us-ascii?Q?FHspSy6pOFQHmpQfciyNgmMwgYkK2ISGqPBGR08wnmtmH64h2cjeXkp59jqz?=
 =?us-ascii?Q?KpbZGIxkWZg5/pT8N6wNSghkUsLOwQqosOGYxDew1TZRDcuoUORGxR3uz7ng?=
 =?us-ascii?Q?l/qm/Ngx3fD+VVgihPuzm6+LMuC5cxtoQruiWmUQdEjF6U70CIjU8fSuuK+O?=
 =?us-ascii?Q?Rx5SRgjmgutpCtWgcRzwW3Fyp8nMhWre+kueQx70zWsrXlH+FgWEpHcZbUmM?=
 =?us-ascii?Q?XsyA0lTw42c47wlZMoKTjoHRy0OjU5wSBx8kuEbVYWyeieTaR616VmRxg1Fr?=
 =?us-ascii?Q?seZxTqiAEQsY+KcjqrKIeVnCxuVQJi77v2v4/ixDQvQ0B6n0VlM4hsx6mcn9?=
 =?us-ascii?Q?KO4vwdH71JSm3bZ2mEOqlM60yFrRKBadxjm/Dg90f+XlhEksq6gxUWezMdcC?=
 =?us-ascii?Q?2fnhpbzYrg+0LHSKUk8HUCJwpzzxTAWiLaIfNhHIMDr5GvfMyApMb1D0mBH8?=
 =?us-ascii?Q?+zNvcsDDBSmrLoI5uTPSJvhn49aHbrQzkFRxc8m1FmyAkVV5Pt80Zxt1uDTk?=
 =?us-ascii?Q?yR6MFKwO8IvuU2VSSxdTvRjMwjKqfXIZhj8kQda1/ZBj3IQ3rV78f7hwXL6r?=
 =?us-ascii?Q?v5gynVrtY6zP6EP2h9sOwTJjsoWmWHWAjlYTyIeA2SYn9ykoIiupkKzJGudo?=
 =?us-ascii?Q?hKB1f3MpQdvwxC66/rlfOG7XSNIjUQ3smQrjBVCq+5bIA4ZX3jeAlopqvQP4?=
 =?us-ascii?Q?oPlkE/CFeaf8++kvUhfJLd0i6cZuyykqSKniGVwuaOt9coFfJtUrDsJjmpBL?=
 =?us-ascii?Q?H2MgdX2I2axG3c0wmB1KdyBHfs9zXRQlaWUkmDomroCbkk5nUNDLPPqlkRrE?=
 =?us-ascii?Q?xP6qsxF6fVtVelhZ6Y7GQmn5Zexi3oP9L5kP0KEnVj78kADE004mTmNAkIm9?=
 =?us-ascii?Q?i/eNw+iTL2GsgnLXmI4uNach3FUWbFcZl5jr+m3XE+1q4MjzIBX29V9b8230?=
 =?us-ascii?Q?f6jbBwcfnSX5zP3OKss+ozBW3YaUOaChHatMpWs1BnSxZMAYZ3aYf9ViBHBu?=
 =?us-ascii?Q?gqVtVGEIQXZ2NPAMvi+13m/sBVClQagF1W9bP9yb54g7QbesozxbaXN/f7Ow?=
 =?us-ascii?Q?3uZ8cxE2IzNyidNb8TjGKi/9Iig2pcmrNknXJB/r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d938405b-4afc-43d5-ea78-08dbbff93be3
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:02:17.7289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2CMlj+nPFRVTgwI5mx6s3Fojnz9kty3dXXdoEoaSk49EbjFf6FUFkLWpUXLlkpigM4dPyjItsYtTVgqxlHNsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8290
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Copy the content of a Periodic Advertisement Report to BASE only if
the service UUID is Basic Audio Announcement Service UUID.

Claudia Draghicescu (1):
  Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID

 net/bluetooth/iso.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)


base-commit: c0c68490dadb598cc621f14e37d56c284e668267
--
2.34.1

