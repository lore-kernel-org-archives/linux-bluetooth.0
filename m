Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA1EC04FE0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 15:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbjHPPBr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 11:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343947AbjHPPBY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 11:01:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B66272B
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 08:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fp2QWDuFKbHxYysam4AbmplGUXFYr6vm9yf/UB3wXUsynGWFJOrBkti0TXzIfy6xso45XqVD75hBtT5ve36MXYg32CvY/5ozyZmAsj60uLms9YUyBzSwcS73lrgzkOKcKUmVYDWYlvdJof9hWqiQyiAVPY8cXfDrRexoAj2uMYVFbVD0bmNKho5CJ+0CyBZn5fE1Mx9dDcli8+mZsAAtFHF80SZvrQ0BrCMpPeEnNNsqJvl4lm2S22FIyfNGYHyq6cNBj3VVqW/xM7Xb00DYvYO8roKspnLLapjmIUbnUTp1HgvFTJ/Pgyzn1L3b7zewqkFsI03Gn38Bd9O0RwxAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUv25renVaUUIWzcbZN4qRtKjBPYZu4CLWAn9WQ6xP8=;
 b=CVNrgQt5uFrfRvtSkWjVzxZ/FIeQEBmyeCgPKyj9v/XPHsfGjBgTkNsnZSSC0oix1kDdtIAfjTdisxNgaLCsL3tEMJXxOioAaPggl6qZZmhovmYjNL++iwxt0W4XxmK6XTSRVR53isuEvR/+eBG8yZ8hu8E68eFVuEvs6RJAAEwyuRUz+jb+hAZXDmNkUQ6UnrCgoeBVoW2eNbqaSeuL4aVdt5Hox/vwGoS7nG88Hwa1+Y4hsEaJBgrH7YWu1l7r7YOz9Em2JNw2lwDjVo5yObAHX2SIOu/BUlstJT5P6EJ1axh7TUhbKkzOaH31ZgIEn2+1jLMeX79/Z0dG0B3bJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUv25renVaUUIWzcbZN4qRtKjBPYZu4CLWAn9WQ6xP8=;
 b=sQ+UL30rOcablwdhSK95AhYX3TmZXfkHMAnRGUZkb5skWnsWC+WCWH9MvoOZOGKq+yuKoeQV1W+od9MHZ8a7LVda8nUTe0Om0pFF0FkOvBbjmWilI8H/FH5kSlEWe44+y6bP9x//x4aeDRoEA3lWV1N1hEzxB1BbKBCPLkXD5mA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB9189.eurprd04.prod.outlook.com (2603:10a6:20b:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 15:01:01 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 15:01:01 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync
Date:   Wed, 16 Aug 2023 18:00:32 +0300
Message-Id: <20230816150033.7812-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0044.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: c79aa684-7acc-40b4-0f1b-08db9e699afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cz02sLyxEccVHL34SE/z+RFgZlVINRyolGutxIQ0zfvpH+HHB38BZtm9iUl/6Wq/QdB7exQbSbGYYsGdXhT7z6L7P4GNcekFDoUXaVt5UNYH9Ny/0z6wDMaBM5t059/ycUmCoUWq3FiCFkA88AxZuMwt//IytZQ+hkaX9ICelc8tKO/noElibT0VO1S4m8DcdRwE8ylsXzCFxjKpPo1AhxTawvSBh370PUqzTAlVjc1IMIphezRxPTRClmN6IdFy1r9of9iFSmUiH9vOBE4bEmmLTP8dglwb7N02+8s1nY95mueVr2m5s2VB6L9I5hP+9LgS98xoI9gbqHeiqiefioH+zyuuAx3RZycqHaY9H5r2ZS6A/hWGrpzrLdB4o9DTWO3coNsdzrVeNvRPrxdKSaXBkDb3oPmtZbPSq6MMdyyIQ1gGgeVvEtLde1seooEVEcftKlCf3ewCqlDf6gqiFU77pgOgzHaCDdO0OXa2vye5IN5ks37IC7yB45EnKNaTTQiepdgWGoAYCVsVeHpLvbiox1714tbpa5c8So7fJi9NvAOFSXOlspeZt9r5z1DgKaXDEMc+lB5ylhyV2T+pFKyJ3cyjvQ4h1a5n0CmZVyy/Yy3MIT3zaDnN4UTVqsv8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38350700002)(38100700002)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(55236004)(6506007)(36756003)(6666004)(1076003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jhkBDmdHb9/iJhQ1L9HJ+fnOdzCV7+Yb0fuNT8gu+qnZwxDMsj6A3GZRRX0j?=
 =?us-ascii?Q?ha2/eOuR3+/ssLT5o4+AQhhv8UAHl5gBPCXD5NgqwX8jenDLt1XF3sQyTGMa?=
 =?us-ascii?Q?wiiTWMtyDzjUOdob1XPBJOkkhBflZHFHlMhAgFr/fhsnUx6PQOu3ZT2xNo8R?=
 =?us-ascii?Q?yJpCWe74ku6xngaFx7EPvFuhbOq+hDaJa2XYb3/MFOv+PjMLt1o7+D2JOU2i?=
 =?us-ascii?Q?Nv3mwFJcGpZayKyuhg/Z98NGxYRYORV+SyVBHpWI9HK1ewvGa9jSiCI39ZiO?=
 =?us-ascii?Q?q149RrCh2YSVlM/7kiCkhzNS/fi1dstX3XkMEbqj39A1t2xhK9g9VJ/h1HiF?=
 =?us-ascii?Q?wiaYRSoPqm42bEDcNASIJJiZi94NpctIYEclJVo2HpHfD5j1LjUEmvzoBy28?=
 =?us-ascii?Q?IgT7uo2i3qKVCsraluWWC7AfQgb+5DI8FV7ILR6gQAHop/rtCDrU+LfxuORX?=
 =?us-ascii?Q?R2lLJSeKK5ItsR0yI14mRFQWnzypm5qH8eXOFX+qkUyK+45BxMfspKCvUo5t?=
 =?us-ascii?Q?ulZ7ppjH1jLdj0nLk2RWtOjWXIGArcPGkdGTwanq2TWOQNU6qjGf9LP62QPu?=
 =?us-ascii?Q?90iH6MN6UPnYYwP5ggqxasFUAcUv3vFz7SDNlaqx43Fwe0sb5ZVYSpe940yq?=
 =?us-ascii?Q?64srqwWupAD6174LVIcgwv+qWUoJ2m33Xk2BEBIU0kted00rCSpjr4otmtVv?=
 =?us-ascii?Q?HiCBKmCLBRz/Fc4PsQ89qvXyC59ar9uiq/OznGTAMondCGXQxpTueg1D88md?=
 =?us-ascii?Q?c+kUJ0kiitTnNYU/Et7BCXlZqRY0xVNHxT9o63gwSQqX6LzTby20YuHJNTHn?=
 =?us-ascii?Q?XQMYRvaybr4IkYR5o536SNpeEf4baeMrkR2AWnbfP9KyF9KT96dPVCjyKgVv?=
 =?us-ascii?Q?mCpL/55K9pEDNq+YoKnzKUYcoornAWQYtX+nrTwbBs3xK7Wj5rJj+fKw0BUC?=
 =?us-ascii?Q?8Ao8yOOacYauUFxzwkHcQAXZT2o9Xtwcn8eOYp30QeWEM+srGLbjaoKYLN/3?=
 =?us-ascii?Q?7uYb8mO/Od+SRay8d4+HG1sjlfShxwrdnTekORfB/F6jlNtFVw854vUUlpJf?=
 =?us-ascii?Q?8NdhiJtSjTgzDWFPAryVwpj74n1SqindBjqMcwBJO1uqv8dD44ddqS3Y6h68?=
 =?us-ascii?Q?iL1wtb/k0j41CutSdsf7Bj8v2xHDecZDf4Vsit4IMpcRDfintdWhhxnjwcJM?=
 =?us-ascii?Q?rqn5ovxcOWHty5y1zFHzbH3jZEa4nf+1hIJrDBbYtFGCFfqbZssnKSYSZaMM?=
 =?us-ascii?Q?JzsW0g64iUsv88qhm1fk8ncEERL2+eVyexiqEyaYljx3etXVr8YDP+7kZ/cf?=
 =?us-ascii?Q?YF4npvhWmnK594NRr7A2EnV1ggO89oqVNemfG3DlLQqmGCdgEZ6aDbGQuSZR?=
 =?us-ascii?Q?HnJpcnF2LbwZYFn1alL+HQmR5WeM6dYnmbAYT1OeuDfeRIjNI1D8MS2cTkm2?=
 =?us-ascii?Q?24c56hydU3Q4CtXDcXZjM0QzisfLi2d0WU6P6QjWcIKSPXHYltSYwTJchszT?=
 =?us-ascii?Q?qg2QIihVR61xOXLcZ8MdB14Ur4VRDLmw/O3k5qxQGsfn9qk6rI9L2cRtcBrs?=
 =?us-ascii?Q?KLwPo6bD5kxxxjXDTAkqFwI0SoMx+pUnd+bOSUPuwAeQXQM6eeBZWntSm4xA?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79aa684-7acc-40b4-0f1b-08db9e699afe
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:01:01.3763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VmlSRbRqXHs+UdAAZDOWh3B3X6pYGktcWRs6VlBmlJzCrrn9RpFSnat4c7fhLXe9fNhYZ5pKeLS7hvdiMTKmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9189
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

This patch version resolves rebase conflicts introduced by recent
commits upstream.

Iulia Tanasescu (1):
  Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync

 include/net/bluetooth/hci_core.h |  30 +++++-
 net/bluetooth/hci_conn.c         |  13 ++-
 net/bluetooth/hci_event.c        |  41 +++++++-
 net/bluetooth/hci_sync.c         |  15 +++
 net/bluetooth/iso.c              | 160 ++++++++++++++++++++++++-------
 5 files changed, 218 insertions(+), 41 deletions(-)


base-commit: db4d87d4a68e5228ebfe3fb6a3e60b3e0b9a34ea
-- 
2.34.1

