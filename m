Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C22C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 15:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241556AbjEYPfR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241521AbjEYPfQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 11:35:16 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe16::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74B3A3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 08:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xsqtd5O90TsCRnR46Cth3kX5c0PCRIemX7GWja0GxQ5g4FdtHY4TnsmXV5F0uGlDb4sGrosfX66Qu0ykA7FRRDVkgFG6ZXvv3XAbcW5CYznPseCre1H+qiTti7O806pYIeVpWGxKeDBPGppW13PfUMe853fTghzHhNQp4mdgqz6+vL4SBqs1zklb4FVKnj95rnMkhqle7PhtfY1+1Y9RyLnQ9diu1RZdbOCc1ojgvHQeMX0z6oir+R70giXzFgIBnEKmIDE1Up40l1s5qXxVI6ej4o9X4xITzare2UAu/uV1wloGYd6SDlw0pL33nd/98UZ0fhlU+yErmGTUkE4PCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=418h3WJaDu1KV57m9UfyuG/1ZqiF2v9tZi7wDSSB+rk=;
 b=KCDa+N5CiOwT+RD6SdYWnrh7X3DRfwv/XAdGli6GbZyxzq1z4nWBdWC/V8Qf6BISVvrj2e2BZo3s06UKNSJfz0GQ82gzeQ0X2DoZtqei2yED5ZEK3MMEt3+ct70PwATjP/93bVUs7SexSEVJHzbJT4FP0DR+yyKcms6mzIYhKeuvjhv8FGfvRs45Fh/H+rKvzuRSIAqW9EIzlO5zJeHBgaKBcp7K3HfSMbjvqfXYcnnFVbgb1leBlBZk9Qq0qGpsG5cQc9VjF6w/M6XmS2yPOX24J8MkAFycVFOFekB6d04fq0pM02RvwsIg29KASL+ee0wuIF+1LIaTBvQHkSyD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=418h3WJaDu1KV57m9UfyuG/1ZqiF2v9tZi7wDSSB+rk=;
 b=NFERvyC+IUS5VsNsknKL8fEs3OuHNrPJW3bQ3UVjAn01o1a/IwFDPQzeGzVshtH/tv4FpN77ukFQ0K81WXStq9+k8ig96J6u8NIFL2bW8D0yGg4rcDKWur2PelAikXVHyLpLrDjEF6BXePUkcp9FazRt3iajS68NIKkIgWItRks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DU2PR04MB8742.eurprd04.prod.outlook.com (2603:10a6:10:2e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 15:35:09 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578%4]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 15:35:09 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH v2 0/6] Add initial support for BAP broadcast source
Date:   Thu, 25 May 2023 18:34:46 +0300
Message-Id: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::15) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DU2PR04MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c01d0f4-dc4a-47f3-b524-08db5d359fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bL9+xYt3AUQDHH4iXTfrjuKQzhmhk+jqJXZOtPGi5t9wW/tb4e7MjrsvOYgIL8JY+5FG/L7mGw3z+SDPAgGJtXxlx2ucSNjUcN/1763cax0w+jbzp4nYZwHUQB6PQybYE1xH58fYtlyqo/IoLXoWo3994+7bjEW45tLj4PjLtR9yPIGisRaTCQqBeR/tuCYPkRtSLg8g3oZ+gyBW3WtO976Pil9Wf83fwlf9SX0yszL1DjSuMo3wVook4nvA28Hwm9hvS+n3DsI28zbvrs7r82OtdPhgn7L2PdcJvD+S0WsFelB1XKIfmM3GYr1VNZfUHbvvbOjMPouKJSsYqS4X6qrz4A6E80pdhmL4voCmRSaGgdc0WBZck3RNabgaxnKTI8hgePIHOvvuTTozAu8msNuVL3jnMVfGJmqP7HpxMasJZPwfHLa0YwPw7+JE7wbV+ZGjSUFre0mrQ0SnlnKyNGiEGAMUIuDErDrA5RA5ku3gsD8qYf9Tr8rn9qX7l8IwhxxKGupOs7/ISEs6liStHhe7M5zy6lmCw7IeE7w/7HJW+KG5wC940P3HLMqQREvs4Pq4ntlNdTyNm2+DiXF3MfQfKHnSyF0fBnYpJ+4T0NE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(83380400001)(6916009)(4326008)(52116002)(66476007)(66946007)(66556008)(6486002)(8936002)(2616005)(26005)(6512007)(1076003)(6506007)(186003)(55236004)(6666004)(478600001)(2906002)(86362001)(8676002)(36756003)(5660300002)(41300700001)(316002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eE0qZ/tJK/mK4yfj5DWsnxWfIe6PgO6RrlV/tP2+K2IwUUnRbmKubFacI1N+?=
 =?us-ascii?Q?kGLtrjPc26C1OZhcv0/iPtkpOm0ashtwUlLlfLxGMark2N3WxwZAlfY8lJ6X?=
 =?us-ascii?Q?fVZDHlsM3MriJ0+dqzgkVEpFlfjOdIpO6apSH3cIQ4hm2eLSDiDGt5JYuNRC?=
 =?us-ascii?Q?SJNDVkx+UgbYU88oIR7vQAR8tUGuXJs4MUOqz9gc6uiumP6GESL4bs08knih?=
 =?us-ascii?Q?SvszZlHc5RMTudNChjA2G+62TJ2jy4oGKosuS59rMkPiHZG1gDLI3O3amWPW?=
 =?us-ascii?Q?9IqvGs8Qz5eciUPT+IUrJeUuftNs3eXPcwFm8E+EMjq9OkVxiR6YVogvS8iK?=
 =?us-ascii?Q?UcWBkwgkgBt8/Vc13Z0yElp0GNTEb8uHIhHx7sTxKWWmEAXySBNbIs9AOv85?=
 =?us-ascii?Q?3ys+Of26qiTwoNjtjXrhYGxxvRmTMZ6B3WvWZIf3257alDDJeZgT5pheCH0C?=
 =?us-ascii?Q?Z41Pj5N4Dfnz3wGiPAazTmLChXMgeZaBM3GBqAuTps1KohVffSzBOIjWLJYJ?=
 =?us-ascii?Q?ebhg0cG8X1uIzYHQuBmbN0NLIjphbxrY6vH1w5Ar48eevkS5na1Ew+YMHpuj?=
 =?us-ascii?Q?LYBSpg+L/DlqFVlTvkZ2+Dbec35298qQB0AwsRuWZ2wU/ikIBbPL03JU1m0R?=
 =?us-ascii?Q?Xhid8J7adilGLdkACVQ80zd+aoCLz4gfmm8WmOmrQI7eZmpJFx4P0deekPTj?=
 =?us-ascii?Q?AIcD+5EC8jTSnKKZ4UHUVPPZxbSDg87ViQ0/o0NUTRv+a9eLJfp48qwev2Nc?=
 =?us-ascii?Q?pc1s7vT+eTXU7JOB02BVB2zfGA+1OldmHobNpttI07KXf16GCZBQo2cFqMrr?=
 =?us-ascii?Q?66wQTP4CWhnA6yNuT5ikW7KyD2bWZte9M09Xg5g51s7jr4iT5RTYwwfZjXFy?=
 =?us-ascii?Q?ac7GB5U+6ZPCS7Qlf0rJcdZkUlnrrLsRXCP0Nro2ic4/1A2sKC8BC5fm6lCl?=
 =?us-ascii?Q?3oChX5GGIxschr8qF12OdTpYjbxLb+QRJlUj7IAA3g0CvkmuIlvMvwFo0LGt?=
 =?us-ascii?Q?umyovuAm5sp1XE1M7BJQNXARJT6hxNsSJyZ+Lv6I6me/AUzK6HKJ/JURu9OS?=
 =?us-ascii?Q?LZTgkRWzzNcwGKICQAQehNwfcOVnFeM95auOCGkk4v4poQfy/qFDSj0+8nWg?=
 =?us-ascii?Q?EfVsY3nlv3LH566QyEFdjgo1fjPlORd32hqskpeZxX3BSjW2nvN8a9KPYOZZ?=
 =?us-ascii?Q?d44/Db+Nlc2PP/HLCon7k0R2AujinnDL0K6GsqTVQ9cyk2YOtwsYT5QINDxC?=
 =?us-ascii?Q?wnGZT6APoFu8ihNWJIw9Jl2U8asgTmJDvCFmNBqelfFJXWKfhxjGce+udptT?=
 =?us-ascii?Q?68dMXNmfxcEqQXd6m9NF+jyjyWIDnPGbkjeJiVDyq5XXSRwBg3w7LfNOivQ7?=
 =?us-ascii?Q?mdMARh5sQlTPBNszbhcyqN/M2s52q9sbOAYs/T7Wh/sADLY/4cpxwmE0aC4B?=
 =?us-ascii?Q?w2dO9lyAKq8deM+Rcp/7z306Qp9/pfiCNzLyH+KhDoMO/T7lhyFY2fNNWJFe?=
 =?us-ascii?Q?mfId2xi1klohdPQ/TIr/y03luXfjCc6F33b73twpOaoZ77EdYHgLe5aDqbPI?=
 =?us-ascii?Q?bqLU7+soU8QBZIM4HjVGLIUGSPV4GQBH0x/h0/7rnbo1eq49a+xiZjzjoXvT?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c01d0f4-dc4a-47f3-b524-08db5d359fa3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 15:35:09.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5ksxLUsZsAsQTutRy8WLlpLMRErl4JWhfxBdcn5xYHK/8CwEiXX3RZkXcetvUrJ6V9qbRxd7+a4wBgzXctJDk8cXlf5iE+GDxWIGskQho0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8742
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds initial support for BAP broadcast source.

The current implementation allows BAP source endpoint registration,
media transport creation, transport acquiring and sending broadcast ISO data.

Currently, one BIG containing one BIS is supported.

To test the current implementation use bluetoothctl with the following commands:
# endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
# transport.acquire /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/fd0
# transport.send /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/fd0 <file.wav>

The curent implementation checks that ISO_BROADCASTER is suported on the board so
"Check for ISO support in controller" patch is required
(https://patchwork.kernel.org/project/bluetooth/patch/20230510134557.11486-2-claudia.rosu@nxp.com/)

Silviu Florian Barbulescu (6):
  Update Docs for BAP broadcast source
  Add macro definitions for BAP broadcast source support
  Check for ISO broadcast support in controller
  Add support for setsockopt (BT_IO_OPT_BASE)
  Update bluetoothctl with support for broadcast source
  Add initial support for BAP broadcast source

 btio/btio.c                |  26 ++-
 btio/btio.h                |   2 +
 client/player.c            | 209 +++++++++++++++--
 doc/media-api.txt          |  11 +
 doc/mgmt-api.txt           |   2 +
 lib/bluetooth.h            |   9 +
 lib/mgmt.h                 |   2 +
 lib/uuid.h                 |   3 +
 monitor/packet.c           |   4 +-
 profiles/audio/bap.c       | 455 ++++++++++++++++++++++++++++++++-----
 profiles/audio/media.c     | 129 +++++++++--
 profiles/audio/transport.c |  51 +++--
 src/shared/bap.c           | 324 +++++++++++++++++++-------
 src/shared/bap.h           |  81 +++++--
 unit/test-bap.c            |  83 +++----
 15 files changed, 1121 insertions(+), 270 deletions(-)


base-commit: 718f27d09fc129d0b94ef61192482ac7e18cbaed
-- 
2.34.1

