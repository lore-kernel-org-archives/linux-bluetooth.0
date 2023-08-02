Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4B1C001DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 13:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjHBNZU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 09:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjHBNZS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 09:25:18 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C42E9
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 06:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j920l9nGV8owoBDD+LQ6Ud8WRUhbwAKIr2FIGSl/CAkMaIInQGPZUJYPu2NXluJ1/CHr0ynFI2BF95bcmRNJSN9CJtnKDz7RPWmiJBKKNwGMFHmqsJAqWY9xC5SolezfGgqGEh8XNFGX6hMy/9pM5yyFqAMdk4Zj8qDPpeZMcejsjPu2TpQ16AeUctG/iURN77uEl64l5iDciuVcYGclCPAZjNiMoLxdQviGDQAcPBUwuDRT83LRtrAoS7RYXC35ahV6Lj+8ZqSrLlqD3MqerluhNu+R1rEBI287aTGAcgVmgyj4BOnMxQslKeeD/N/854TjBwqjYaU7mDg8zIO0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oV6xeCnGm7Nq7/6bZZaQ/eUh7rzHEz/u5m2UUdxzVpY=;
 b=BvJ3v6IQNQsyUzWsCAIi2VnZ71dGAqfnr05zxdb8zqFoN1nIazrUdrBerI/aCFKWSGEyK18kXwGyyKoLkjcayJHMEPfYZfTATR2CTkgmbUb71sIMZcMv3KG+3I/LDDmhUB/A2w2SUmXYofbYO2ab6GfIu46jnp0pMnZBcVnKoSbrVAHQBFWR79dY5TcPrqosn8HL8pdpsJucbY+2CgAY2cdD8ZzAomg80MpWX4Ez6IVzsY4pzEy5I6GvvnlWsxD0xvhjt4GTUOYENIe0iUbCXyDw2DqmFc6LHp/oJTvBZDFurUTorj/uC8rPELOEF/hRd8S6e8LpAxZk5WaK5JbqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV6xeCnGm7Nq7/6bZZaQ/eUh7rzHEz/u5m2UUdxzVpY=;
 b=nupt9j8dhLnlBQD5RFGb8/gGO2/3z5u4qcWk9IrkVD+g49uQtng+YEtUUzYFmpkM4Fl6MuCkFh+Hetstdv3xr700uCQGoUtvujjwHL9u1Z/MH1axZlwWGNuEXlLQt822Jzn118qWne3jCJgbt2Qv+4XsCnhzfOzf/zzlhDIIDwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM0PR04MB7010.eurprd04.prod.outlook.com (2603:10a6:208:199::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 13:25:14 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 13:25:13 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v4 0/6] Add support for BAP broadcast sink
Date:   Wed,  2 Aug 2023 16:23:49 +0300
Message-Id: <20230802132355.4953-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::19) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM0PR04MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ae032c-dd0e-4abe-75da-08db935be765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcVlEaDFks9QsvdGyw/19IfWGen1n+psoE6KliADlCftdsM++e8szAFdzGEajq/KO1JvEamA5u4FCVilTYmiKxo8JBxPbDtTN4xPxKTssJPilB6vuoYKJx8CP/Zla++I+bubmGAJDOuP3rJbH3bF7NrvWvAiU32HDnCdoIk6YCZwsgOa/gL4tZCXb3M/fb2H1TpRHbpPauxIF6leC+nm5U6aciPMGtVHLOagEFbcaGKrTmEEZg+7d0KoBsMzH2+h6wggFvQWPl6ac6L2L1miY+3QfSvIkr9ZGwfxdxA6ExQwuDard0BKmShymuuSyzMVYNehjMzVi4c21zxV25KqJWHPgpXE6qRCazzVQ1Jignc6Sa43GRCuNrjEyTygDbQhYAOrcWyUgOE0lb5GqUVo5qnrXvwLdjxKuFnBbYRRgK5Wb1MI66qmfO5uKdySazbLakvrE2EieUMPdXIMpMMKyAdu7o90OZjy44bW0Yry1jQGn87njRUaDh/nSq+pIyGlSe60SflgiLDEvjBPKCdut/QMdXIqFdVLzLijgsdXpF46wAQ4QULG+CtdBORqHKsvHWY0uPTBmcxZjkyOKwdcgKsFVNnOXu7K951cQGGdiqnz4FSQHhyrdu3poV9Uv2Cq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(186003)(8936002)(83380400001)(8676002)(26005)(41300700001)(2906002)(5660300002)(2616005)(86362001)(478600001)(38350700002)(316002)(38100700002)(1076003)(6506007)(6486002)(52116002)(66946007)(66476007)(6666004)(66556008)(6916009)(4326008)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XJLEj+RRhOQxSq0PlAnvK0zPOOn7YEJzwB9ouCa72Y2S0k6ya8kveFRn5RMO?=
 =?us-ascii?Q?LdUVyZ4fCoRC1aqIp8NJPn9QabdfXely1zcoCWIn8jj8/Zh0LXpChkfEPGkw?=
 =?us-ascii?Q?TIc8pXJ58WPvc7qgEZaLDsSXctr6TGU+spsPqB04MEU8w6aNN3LnAI8fRYff?=
 =?us-ascii?Q?sJMU51wUTctP+vpWN58F4slKNMYINw8EgUEIavqwJTFhb92TzU7zsShGDMZu?=
 =?us-ascii?Q?a509PoTJtEquXoLj0+yyitA1E5R0MTrzPGq6+euJ65kOP1eDoB3dyX0IjS3W?=
 =?us-ascii?Q?V6JIQ7WjPmzBmnkXXv5QXsmMv3vytnneNQymTOosrttOUlHOBT4P3QoRnCcR?=
 =?us-ascii?Q?6EfTDdQDjOWLjg23454aXT+54IuOws8Gx3ntF+HpGgqpr5QXSKGW0qge5nsp?=
 =?us-ascii?Q?4n3uYcj30mjSpb08i34Iobxhc4JzZCRKIV0P5n9hFx5kTw4hjqmIU/sGk2dZ?=
 =?us-ascii?Q?KRqek1OJToS9rBh4S6J1hLD0vASEMuyXxgjlTf9TYDcP7swXfjRofQyjp+cB?=
 =?us-ascii?Q?bO5pXU99IgNKxZlt8V5b3aoHth5vhg6ffQ7s34gQqzDk9gFBTLrdYlWbd8Z/?=
 =?us-ascii?Q?exN62HFu9sPVM620/EhKB+c2azX/127zQrmhqQTuU10nIHQwZWvUZET2UVLV?=
 =?us-ascii?Q?eqSE84t+noX5S6xBkYKzQrClJTKKrn247b2ic9qgpzHavpk3ILcRYkdBVDgz?=
 =?us-ascii?Q?OnYCWrtK/3ZycoanyjQ2rScCERCwE/kirPZXxPFkNZj/DTRxwE3ufoS6bcsE?=
 =?us-ascii?Q?sscQxGqr9HJebdRt+PzxQ6U2DUTAmYfk34yXo120ZIZnZtH/zebulIVSrUGN?=
 =?us-ascii?Q?YICmPT4Hw4SmVjNi862LQ67tV1cVNpumAWiitNH4No5WuXiQ68SKAMDF3KiW?=
 =?us-ascii?Q?azXSd17r54xsdwZn+u+sH2pZLY9946WyBjQ8eahCly7IV7Zt2uWVzTB2iJBa?=
 =?us-ascii?Q?V28bSU2iwJOJhHp7KSfT1aCi3HjsjKzeGEVvKRa9wfpvrsZZRbr3YzvE+99c?=
 =?us-ascii?Q?aUaMnC+rxRFJWsUyz9l6zg2Nkx447cI5FWCqsayC6EJznDl3vkcr2BKjnQAp?=
 =?us-ascii?Q?0KT8yqEjjae9UHxn0bUCs75TpdB1yFhAuvcDncmtbv1fZDGjSfNG8wnd72xp?=
 =?us-ascii?Q?CwjH4GzF46pmqMR1QrCdwgVUQAV/n+5NAs1UWGF7sfgA7XkbqoqBxvuQfm1r?=
 =?us-ascii?Q?2wMcbweF/6eHttYeKq50o968ptAucL1zbqMz62I4hJwmqnXgIwG9bDVhw9ON?=
 =?us-ascii?Q?VPYYa6kP4cHHsoS631efoPwYPcRQUyN4R4F6Xc8KK2ghnJfzNOq3AHVYv8iZ?=
 =?us-ascii?Q?R0Iu8NPKELRjkhQI/N4EUMlb1S52wxjb93lGthVjPOEum8T7mpfhS4a1lQaw?=
 =?us-ascii?Q?28oGT6uVMxDIxVMnVosh/x4/S0vhmHE4s8Xj4xi7E8mUZaQzHISd+Nal1Ol+?=
 =?us-ascii?Q?oKwWR+HMVP55j0giwtZPzFlNrFTMlcBhVy0w50uXVzNfa80gavXyhl/Q2LCs?=
 =?us-ascii?Q?lhpNZdeRYZ4od8XUDDDCLTffcRixgsnqZGtvqGK/dXH0EnqwxE4dNYtUg1iQ?=
 =?us-ascii?Q?2nOczQSiQ3a9+qM5ijeCT8S2sbv850LNqBNh+RH+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ae032c-dd0e-4abe-75da-08db935be765
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 13:25:13.8462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHRszOZ7jOsuKamPtngREeaOyk5uIAavJEMxrMnaW+09k+QQI8wFHpjIjPSIvtz64ZFVm1WDLTZa58e7Ingd5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7010
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

Claudia Draghicescu (6):
  client/player: Add broadcast sink endpoint registration
  btio: Add support for getsockopt(BT_ISO_BASE)
  adapter: Broadcast source discovery
  bap: Create synchronization with source and create BAP broadcast sink
    stream
  media: Add broadcast sink media endpoint
  transport: Update transport properties for a broadcast stream

 btio/btio.c                |  13 +-
 client/player.c            |  61 +++++++-
 profiles/audio/bap.c       | 300 +++++++++++++++++++++++++++++++++----
 profiles/audio/media.c     |  81 ++++++++--
 profiles/audio/media.h     |   3 +-
 profiles/audio/transport.c | 245 +++++++++++++++++++++++++++++-
 src/adapter.c              |  48 ++++++
 src/adapter.h              |   2 +
 src/shared/bap.c           | 153 ++++++++++++++++---
 src/shared/bap.h           |  11 +-
 10 files changed, 835 insertions(+), 82 deletions(-)


base-commit: 8eb1dee87e019f29b6c8233dfe0f9aef8ee44461
-- 
2.34.1

