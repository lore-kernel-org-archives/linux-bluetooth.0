Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAD9C04FDF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 16:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjHHQ1X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjHHQZw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 12:25:52 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BA84693
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 08:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuTqzCek56moi1yQxAi39ABzOol203XBZZfuq9rePoKO7VpNo5NGi9EYKwhvLhepNw+k9D9dtahwpspx+YppbA0BK5RqZvh/dP//Msc/Y0dD+gANFU4jO055LmZa4A4UMubd4lKthsr6gqDSkuJJxyo+ma+OiU/BY9pmGDPul/F+ozdp7LoUgoHyEGQX/0AYDr+BonbnM7OkYyODgTRVkljnUZ9sowlgNSvZKSjf5zlksqkQY231ie7xFjbIjGYnkqP2nvZsp5gnt5u4DSgcD0H95WInmnh5yTo3092jRrniJuzWw0W6sOnJ/XX+WF7hjOd5cKUqVw5sIj7vDpvvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO8RjUqXfgSblWdvRTjBYBSksZCvEFjrW153W6/l4YY=;
 b=c1iCnDU6KmO+kniB8jihZ1JP3RCCGB9vug9I3EsXpNL7D91OkchzJ+TlOegGTXp2hL4mp16u+sOJNn+0i8eqYqCbApRIInWJ8pplfjVGd9iuYqW3pq88fVBs7snkIK763Z0xYKyaNUdMhNih/KnV8zl32N1hDX67Dj/NgAE8sCfLfJnfdvuI3OA25CtUHk++fSlOMNGSkxv5LgH1Cx/AYzLLhWi1TMZu1VeVCnTURLYTDJe9w8IY2XkUFdwNtlcSfVE5j+6OGoDz/gQEoCGs2rLiPU9Nr7u2J2kNkGnFl7iZGgu9dnoTVDjA2Az+t+7fhFdtWJVSMS1sfNAPcpxNBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nO8RjUqXfgSblWdvRTjBYBSksZCvEFjrW153W6/l4YY=;
 b=dwjqBs24EEUJVF5HKnkag8neN8qOZanxvy0OieXmfzTvnY+qwNcZagQjI7NqP2UUvdJ7bUdeYml8kmLzK2B2TOs4YU3ZlFYi0Cz38WXuA7wfLg3gkHgaK+HCuYvA1dmB/6qyZ1pL+1YRwLveqZvPmpYgRmSgQasv3Mu1zJRgmwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DUZPR04MB10062.eurprd04.prod.outlook.com (2603:10a6:10:4e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 11:52:47 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6652.021; Tue, 8 Aug 2023
 11:52:47 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v5 0/7] Add support for BAP broadcast sink
Date:   Tue,  8 Aug 2023 14:50:33 +0300
Message-Id: <20230808115040.4403-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::6) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DUZPR04MB10062:EE_
X-MS-Office365-Filtering-Correlation-Id: f60e82fb-a11e-41ba-5ea3-08db9805fc37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQMnbTyONcWnORASlg03b4F1itTbKW8ot67TNJ05WUMmeF+57LeO68tzyteDmImpMfgD79nnQ7G7O6HbvhGeml/mqVsMzJf+yRVEkyjDz/i/54M1V9tB2bBrd63ul/71RKOZAEz3faFEmJhAkUddyjo482og3VzWp2vFxHFIv17q6Cu2tbexJwwN7xPTD7crncnPFtqs1mhN61kUHxSWB4lRKHMVVdx/R5mqzPb0F7e7z1rhX61TyJY74f4uilnOcgWtKEUOfWxyyjUl4WnqWrV5XOnkiz1e4HggKNiu9NLLzrM8NU83VaUiWuFRialm8ETsfYPyX+bJRV0q1Pb8LG8iRSL/REmpJylKl7zUOEKcWdjFj1/btFdMH3QVeOi9QhxKd6oLButeyg/5JGJb6Dwb9xqLTClTHeY3VlNPx+is4qcmqbXxa4mOjejjyiv6qP//dc48DG1zeffPBy/1Y5ysO6beWk65kmVMUvpbMgz1sxSJBPo3ldKA9vYBmtof0pMUeE7QZUfRUbBJQonhaUPQc4MONVJ4+rWDOtf2p9XJaxjlfmvM4v5WeR02Ga3+noHRdszw5W2xqP1sBTJLLUTzkHVKFbOVBX65r6YTDhkjIkc8pQmDL30UFH8KPTUv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(1800799003)(186006)(451199021)(83380400001)(2616005)(52116002)(6916009)(38100700002)(38350700002)(41300700001)(2906002)(4326008)(5660300002)(316002)(8676002)(8936002)(66476007)(66946007)(66556008)(6512007)(86362001)(478600001)(6666004)(6486002)(6506007)(36756003)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g2+k4oOxybt9U/4S12MavdIZ4+FKsM9uuRCQkaA+8yyoKgpS2NbCuQjk2P1s?=
 =?us-ascii?Q?3MAl3V4svy55VnSgi7w19kOBYmHn8ld0HmDcLFXw7HZReJDetCKJv4TLnvvr?=
 =?us-ascii?Q?VS6JDcej9vuoqZH0oLzhBqUie7d99Fxr3g+Pqm4jZ13OInU5/fbnwUeWHfCA?=
 =?us-ascii?Q?SgZLVkb5uS1o6/jf+8WdKAXdd3vIqSf2VEzdSYpcW1uGwz1OtMZJj7GyT4KD?=
 =?us-ascii?Q?i166pViGEd7TEnq15zPFT8cMcVs4Bl6W9snT/rv32JHr6jPlVmWYttbUr1FB?=
 =?us-ascii?Q?YWYVG3WVtK0WtINHmXqe+xwdgQjdjPh5YcnLl3AGwtfzJSGyyKe7dnPA4u01?=
 =?us-ascii?Q?VcPViR3DjwbWciENJY9OY3c+5m3CtOA6E49QmBjF1Tqlm7s8KzZQvCdrfcdC?=
 =?us-ascii?Q?F6+RYENzBxxER80GizIlLd7pER/GtFdmmVWolDoDuHxwlCvezrlajnRmzwUl?=
 =?us-ascii?Q?2zThtUjtj892B/M+bVOgrgHSPTroTqdZssV4dHPymWD3dN7/0rmXjB+ZWKsE?=
 =?us-ascii?Q?T11KKYlFh++QZ1nPMwJ9p+Ca/PVUcKiRS+imHJ8u2dWUsBrDazs3aXBdMx6j?=
 =?us-ascii?Q?LJD8AE1LvRq7hMoATPzieANmGXwZ6vHP0h5sSv5fX06QqQo9VlDOt2HiExwq?=
 =?us-ascii?Q?y/QrbJ5qqPIHvOcw4fJAKrR9uTslLtH2b0oUfBhu0IxOwkNafhyuLCr/EfYL?=
 =?us-ascii?Q?5T753Q7o2wB2SB1rEMk8I17ILkE+QUf9RvqlheQjYQkoO6gsfSDgD2dTKsW9?=
 =?us-ascii?Q?L8/fSMOH7Z4ZpMA9GKb3zDumWRIZ+6UPb7hov3dTwPZ1c8SztqKv/df9RsHE?=
 =?us-ascii?Q?6NFDDYj5pGt5ky/Sgdv3k+V5mPR9RuNjbzFi9eeqOs1/GlgNS1j+wECcGVvZ?=
 =?us-ascii?Q?Z5lsF+KqGq3JLIPZAXovAPoAo9f5zi/RhWLERvdVX4G+gY56wesyDwZYg6Jb?=
 =?us-ascii?Q?UufbMV69hhX7CmWQb9JT+sRW83XAi07Tmq8cDF1Re771ItBvA4tVjP2oVUHD?=
 =?us-ascii?Q?Dr/ZN1VYpvr1RF/3/dkZugRifDOoAD43iyYti7+LqlmPB0aMy3RVh484T/Rq?=
 =?us-ascii?Q?xsDehoydoP/h57ou7flg/f3nAoLgHhLTCcnVaj6D4EVW6r0l9R2KbNAZTKG7?=
 =?us-ascii?Q?KCUc6tLFbCCM1lqUD3qaS38mYpRvmJLPrNj/Q85uaz+oYt1vaZOxR7zi3zCt?=
 =?us-ascii?Q?gV8zT6sBfvxWJCLVuCOKh5TcPixOCq1pHsGbdOsCrxXdmGQ29KraxhLGd7so?=
 =?us-ascii?Q?sVNbf5Hjxtx2uaNxKBPgSZnrN5qloOcVo2vUvWSVyn3yki/CcL3L+RPihVz2?=
 =?us-ascii?Q?EJkKcCMdFKbemIGAmLYiGm7rV8wxftbFnW4JptKZc9tTZ1lcoySFg+6QjNlE?=
 =?us-ascii?Q?W//p2C4Vx1w9clCm7gDbTCd5Rr1d+iwbuht7cp6E+Ndxihfl47fdOsPyW2rE?=
 =?us-ascii?Q?CpptTQLc30hlYU/4RvVwYzWzZ9fMMvME4t0E+XUa/z/nRdHRAwaN7xChsEoJ?=
 =?us-ascii?Q?4VixZC3bjct6z9n6QE3RsCMeWeBq1ppheROb57RC5SJ/me9lAUR+0Rp3nWhm?=
 =?us-ascii?Q?H6xlrSdzDhYx9I5iLkSsKqs7QnCsqdpCNs/BeE2o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60e82fb-a11e-41ba-5ea3-08db9805fc37
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 11:52:47.8457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkVWy2nmWbNeKkj6jV5FQyMmtx3s+FNuWakXK9HspU2z13+i9iSJKWv0ftkGfmp7TnXNSYe6EJMbwlgVG/nquw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10062
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series of patches adds support for BAP broadcast sink.
It consists in registering a broadcastsink endpoint using the
Basic Audio Announcement Service UUID,
discovering of broadcast advertisers that announce the
Broadcast Audio Announcement Service, synchronizes to the Periodic
advertisements of the source and synchronizes to the BIG advertised
in the PA train.
To retrieve the BASE info advertised in the PA train, the patch
Bluetooth: ISO: Add support for periodic adv reports processing
was used.

This feature was tested using bluetoothctl with the following commands:

[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[bluetooth]# scan on
[NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
[bluetooth]# endpoint.config
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
/local/endpoint/ep0 16_2_1

Claudia Draghicescu (7):
  client/player: Add broadcast sink endpoint
  btio: Add support for getsockopt(BT_ISO_BASE)
  adapter: Do not filter out broadcast advertiser
  profile: Add probe_on_discover flag
  bap: Add support for BAP broadcast sink
  media: Add broadcast sink media endpoint
  transport: Update transport properties for a broadcast stream

 btio/btio.c                |  13 +-
 client/player.c            |  61 ++++++-
 profiles/audio/bap.c       | 334 +++++++++++++++++++++++++++++++++----
 profiles/audio/media.c     |  82 +++++++--
 profiles/audio/media.h     |   3 +-
 profiles/audio/transport.c | 245 ++++++++++++++++++++++++++-
 src/adapter.c              |  10 ++
 src/device.c               |  22 ++-
 src/profile.h              |   5 +
 src/shared/bap.c           | 139 ++++++++++++---
 src/shared/bap.h           |   6 +-
 11 files changed, 831 insertions(+), 89 deletions(-)


base-commit: 59569c1f947d648f1e0b9234dad3707f6c34739b
-- 
2.34.1

