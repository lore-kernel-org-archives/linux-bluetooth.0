Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AA2EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 09:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjGLJDb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 05:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjGLJCj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 05:02:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9513412E
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 02:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSDMgAbodLYOozPMdPWZ/RaiiSu3ueQHvUF9D6VCPr2AW3u/KPC6dlxQAHVi0yOHBenTJHqRb0VHgNN+9Lm17AfxzjRbTbBWThTUSdChQV0AQPMOQACXqTjEaR3rggPMIhpYIegKEhbMciKp1tW+C2dUgeP982sIy3Nr1HnC1Is/eFWRhfBGK+iwrJkaRx9cON5fTSa/15Q67FFzF2fYC1qi3HY8IGLwJ072FDf4zrf9z3T39b8pzfFy/Cf9uIxd4gGkTTtjPdqoobC/XXQCLgo0gHBk2QTpxhRnCiopDqhV8+zDZxe+K+IQy43hreNJ65y6SbDw47rP83N7RoqFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XUqFkM/Gimatb6mvBGZi6nXPehNOlRRQRxS/V4Jsd4=;
 b=Ux/EgC7UQUlKVJ41/Gxg8Hxggla6b5BJe5yynZdvf8H2Vrg6aUfYvRm51vngv7swExC+m9/Z19Deq5GE/6OUwdRnh8OIew+3AyaUGAFs+3ssG7lR6d0pchexw+cDgilKou6ys3oZzXzjP4pt+9nIyKf1b9UYZNHrxmFTiAA95qjaeKUop0QljeaZ7fnwk6RLiE5I755q2tHSFBbdN/SHegfLXZqpnbOS3UtcMINoNF5ntqUIGL5e89ke8A8FDP1GB7BxEZ4kASgrGKlAfm3nleJFkxzkyUBitAQg9/ADBdPlRjHwSGx7Wo7NPngs1O+jdfWkxCwVJ2qUBYCWkNHNHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XUqFkM/Gimatb6mvBGZi6nXPehNOlRRQRxS/V4Jsd4=;
 b=p9CCWYiU2BQ+uQsSe51DYqZS2O6st+UBWXZ9InlwHPxTxu5YaTW5G3+ybVRznmge52qV9PBl+l3UtcHunpogH+laXYNp/V5pDXocjZg6edi3AawN2srmbFhdtKbMyxldPuOINJZQ6LuZWH9pPeqmWlKFOPh8lrNfh+BJ4Mx4wzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by VI1PR04MB6830.eurprd04.prod.outlook.com (2603:10a6:803:132::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 09:01:12 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 09:01:12 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 0/6] Add support for BAP broadcast sink
Date:   Wed, 12 Jul 2023 11:58:54 +0300
Message-Id: <20230712085900.5423-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0004.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::12) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|VI1PR04MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b211e28-6424-4393-0d5e-08db82b68a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1yO8m6yyn3L4UhOXLaJdFckMQDnmXOkXLLKCI8D7GgppVen2rOdyR0R2xLLnLSFplgGMDxBlm9iQ/Hb3aneUcl9AYvag9FCEAo12OzkNWt8UIVU2JZkqglxb8TRtnUGs3w7ENhIYdgX8fuRdS0aWUbeBuYZFHsbo//Tpz0vFOpSuJxMw1Bd9bDlLm8Ygejc6x58+rukyKOmTmyl4rH24y0C00TWcZ7HomFxBVJ09qGu4Wlut5sBeaEu6jgVMV8CPIC2NQ2qufi7j4MYjtuDf4TVSEmCLwuMvhF3x6nxV8MZj1AOrLYj4FBX7revb7u0aV2vXwU5cdQlH0GTAkTFtsTi4chpuSHyyA+hQ7nER9URl1AidVCRfj3luzcpdTJ5PQJC55yJOMCakZ2zgne5e1mnJr+LoR6i1af1XCRfcDVmacqVJf+1dH0N7w9U49177qXJTQFnwCI0Lwb1qFq0bC4BkUqIHvKIc+D3O7otP/rBX57Ojlf3EVIH++dYZz4GWZEyJpVsqQrADbn3jiD6/ivxUo6vZJvEQACOTi7DnD8ic8o8DgpET2R5pRKpHHwv+tdv6TR9kOy6MqEX0as2z4TDxTXzlRKLu83HFn4Xe7pLSyTRUE+hs/ZYpd08mRDr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(38350700002)(86362001)(38100700002)(36756003)(6666004)(6486002)(52116002)(55236004)(26005)(6506007)(1076003)(186003)(6512007)(478600001)(2616005)(2906002)(316002)(5660300002)(66556008)(66946007)(6916009)(66476007)(8936002)(8676002)(83380400001)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p0oVWUiNki7d8yUIkZs7DaAAzIY9Z07qM5J3x+5/HJNpSc2xbu1mHh0k1dSx?=
 =?us-ascii?Q?0i3UQMD6jKK0YDN3Za7Ea5EzBILjixb/AOkVjEQWgYTWSkPnpt4ly8Q8pdLO?=
 =?us-ascii?Q?THNOOs8Qf+YYeFfICt21ajgPPdBEM9zkcca93qZnusV3IW6eQQ0pLU2pz3Vi?=
 =?us-ascii?Q?iP7ElJvkbHyR0QZIMU6qzJLC2JcVFr1DNQDKdHGo/vvcaIK9iLtqx6Yv+w2l?=
 =?us-ascii?Q?GWH1oFUXTvwDKYThn3ACktps4jGd5j1QMQ0ZPrnVkmpm65pyaCEJT8XFp068?=
 =?us-ascii?Q?QM0vC8Vdp7Z7WEy5HIizDKPG73SyTrvistifjZwpxnB/nNoH+AmBcJ+JQtq6?=
 =?us-ascii?Q?nQqBZiXvtb52HMq0pb5bRkJqMNfHcm14S81J6mZv27j09L74eiigCWMt5xhY?=
 =?us-ascii?Q?1rs6zRTUKEHO9/KkvzSKCHm+FxVur9DIwmDd+9LQPCVFPpdZ55EwbkJUcvsr?=
 =?us-ascii?Q?cX2tdzD/C0c8txTO+bwhSw2KiiefDkATvsZykvpQHtQyMjRiN9TFI+YnJ9wt?=
 =?us-ascii?Q?dCildPf6z2CQ13/dk9+ur/OQTcBuuq9tkwST3WDt6hYvfAEteg//yqup/TFI?=
 =?us-ascii?Q?rOF3TH5A7nCwmHBf+pfIKw2AZ/bX3eq4zp0tYJ6APr9G5Tgy9X584EO8eEtM?=
 =?us-ascii?Q?KZyldQhNL6Uyqcq/UBfZ6YlgOazGSMwswghrn4R6wpozidoy0CXm158OGXro?=
 =?us-ascii?Q?A/I6/0Z7p2Gh8HdCkbIkP7pGTI1J30JbcRRI5bvBy8Pk05ybDHjgSjcC49Wj?=
 =?us-ascii?Q?u1O4sXwvEiwY5EZBTV9ha2kMjHEm3GToAWsYsjVfm6S7GxYxt8E6a6a/x3Mf?=
 =?us-ascii?Q?94Dw4EG/R7yjy1DV89T4IJgI7ZOZT8IL3G655SvNWF261n+UvDMBl0q2GU45?=
 =?us-ascii?Q?5zwSa798iUxOsoevPS/UsT6j7SDPVpIWR8wm/pWDX7AwXxx1a6yq2PkYKldO?=
 =?us-ascii?Q?guzg5FGpd3cs4rOyusa8Y49iAk9MWrG6upiY48dKWzhCIXSYEFtvSsyuGFhF?=
 =?us-ascii?Q?22jIzF8KDZ9aEqNkxkdQ5XssF6zVlwhrtAH6v8ZrX6cV0WZJhBtweBdCezmq?=
 =?us-ascii?Q?84k9bMfNgRVYsxfCjLXS7fVFFWuB+LVcc4v1CniUWdwktpqAoVA2r/xtD0W9?=
 =?us-ascii?Q?MkoHD0Ct4C9H5g87LLj0jWqwHrOi2auUybKpH/BnhrtgMnOQoiT/tusQ2P7o?=
 =?us-ascii?Q?zVp5X8zTnPAFrGpeWpsWb6dmh19PgQD0ueuhowGJVPsjUFZyc25oAcnOYpO0?=
 =?us-ascii?Q?nbmQi/IaNatYl2MjaVdbc93APwRcMiUbswAQOzELLnZ/ZnDSr2SyH17KmxVn?=
 =?us-ascii?Q?YyyyAuK5S0hVME0Io5Z2S38cfK44sAVtM+tGmPxJz+r3EeSccdzb5YVKi1Rj?=
 =?us-ascii?Q?jY5150o/bziU5QkIGIXzp6nUQvD9QbXTuArn/oUXSXujz38jsTvjgsaNgw9y?=
 =?us-ascii?Q?KJ/2I/8piiKDlR6J8djQ0lvoy9VpyMYD7AVFbqGtokZLuoltDovT0Xfb2mnt?=
 =?us-ascii?Q?uFlBhE7zRIRrVMoPX9rUuRKp8Jl841Hm2lMlP5o/228tjFm15CpFIFyAmxGW?=
 =?us-ascii?Q?4krf/creMkRGNQCUK4MVMIb+XpibsqUSQWSrvNcA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b211e28-6424-4393-0d5e-08db82b68a61
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:01:12.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tpHpkyhXf5oWzwtMvo3uyb0Xs5qbfFR8FCIi4UpD3qK7/dpMbyap4RjVndeC67+cwGBgTuwKMi9RTJrHncyVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6830
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series of patches adds support for BAP broadcast sink.
It consists in registering a sink endpoint using the Sink PAC UUID,
discovering of broadcast advertisers that announce the
Broadcast Audio Announcement service, synchronizes to the Periodic
advertisements of the source and synchronizes to the BIG advertised
in the PA train.
To retrieve the BASE info advertised in the PA train, the patch
Bluetooth: ISO: Add support for periodic adv reports processing
was used.

This feature was tested using bluetoothctl with the following commands:

[bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] unicast/broadcast (u/b): b
[/local/endpoint/ep0] BIG (auto/value): a
[/local/endpoint/ep0] BIS (auto/value): a

[bluetooth]# scan on

[bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0 
/local/endpoint/ep0 16_2_1 <source_address>

Claudia Draghicescu (6):
  client/player: Add broadcast sink endpoint registration and
    configuration.
  client/main: Add broadcast source discovery
  media: Add support for a broadcast sink media endpoint
  transport: Update transport properties for a broadcast stream
  btio: Add support for getsockopt(BT_ISO_BASE)
  bap: Add gdbus interface for BAP broadcast sink, create
    synchronization with source and create BAP broadcast sink stream

 btio/btio.c                |  13 +-
 client/main.c              |  57 +++++-
 client/player.c            | 187 +++++++++++++++++++-
 client/player.h            |   3 +
 profiles/audio/bap.c       | 347 ++++++++++++++++++++++++++++++++++---
 profiles/audio/media.c     |  35 +++-
 profiles/audio/media.h     |   2 +-
 profiles/audio/transport.c | 244 +++++++++++++++++++++++++-
 src/shared/bap.c           |  50 +++++-
 src/shared/bap.h           |   4 +-
 10 files changed, 888 insertions(+), 54 deletions(-)


base-commit: 838e1578072900d1f98dfb31cc538940d2fad876
-- 
2.34.1

