Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E833EC7EE25
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jun 2023 09:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241873AbjFIJut (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jun 2023 05:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242022AbjFIJuN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jun 2023 05:50:13 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E233A94
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jun 2023 02:43:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdsWA/6YuGgkMW4wgvtolG/OlD/yIWo8I76JP4pqeK8DunyYjeYw4lJvH3Ec9RYe2zFqGBoT5d0FaCdkCKkYsVGRLv5qlGkWKG3k6w0FNk9T6Db6Ep4M7w47vYRt0HBLqG2X/P9IR3VV9LcyLJzy9feZZp5IKeLZr2rfN9IxrjqwhBJn5OebeNYLniUeUTBH0H6QUY6l8/v9/fvjYgdhsVA3doohkpIRsRGNh7pIL9QD7zRzH5zdr6i7uiRRG6Iiax2uLeKXa7kUDCzKj4GN4vDLJ6GBNUcdog9M2sjMStFiLhtUA22J1cj1ZDhUdXOpkao1vnsdVYCWsgpDfM9Gng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8JdeWc49xQghpmCy4FFN+Cyp1uurrACG32Bwn1BIak=;
 b=HFhB9v9FaBg+5YBy+7omA3Em1X7F9Y65l5oqy2N/p03r1mc/XfgWFbrXKbrpwlTW1UsnJc6g6/VYTtg42F19zVYmi12d2aRuTBcznBEiAlmxGCd8KtbFlQ/qoeAalG+hwNxtASsx+hxm+5e2/yn/TbJlYG8E70QTcCeXyvxBRtheuiEUp4QfyU73lLPAtlYHM1ZafOroO6w6NyC3ONBVNWO22066KJD76HPnksc+YkadnPUxm3hzqk2Uhlpas8Nb8Gf/+JIM7Mgj46qcrG+MWXX3FtMdNaPoYUq5Kf/+EagqNS6aLxLrsGM5PPUh2ACm3dwnvUBhWxHkTverRQC16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8JdeWc49xQghpmCy4FFN+Cyp1uurrACG32Bwn1BIak=;
 b=ivWYXHG6js9hhlXgYW64Xb9JXI2G301nH9VBgpag/20da/at9qShnWwbjX4JLrDxKFd4Q154FHNXoyOAka5RYXTA3KFVts4y7Mv3xokslUkSuwG/tX2v4WLuajlsRea4MEbwx7kemxo11czCCQ2DkzSp5ctAPmS6pWNeb0LOo9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by PAXPR04MB8191.eurprd04.prod.outlook.com (2603:10a6:102:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 09:43:04 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 09:43:04 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v4 0/3] Code handling for VOCS service
Date:   Fri,  9 Jun 2023 15:12:19 +0530
Message-Id: <20230609094222.1877-1-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.33.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|PAXPR04MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac19df8-cb7c-4e46-7c3b-08db68cdeba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01kW2FyE2DLQ4M+nTylEqTdv09tbcqE2M8i6c5NK/b80TUhXjRzSCmT7OTndkX3zH1kWn8Jkw0EW6+xYKkWKL5r457rAHU1TxzSpo/Oclj+cXHxcwct4FO5tabP0hm3HbqrPQIXHQNfRYqM2TY5dkr9UC3QS55jPtYgUKtLaYxBI54uTOaefViRpD2BwSrYrPaWgachwV5FXJfKcr2fwx2Bp6SOMuDmxodFskChtdYH3wCQZB6JA/u77FbCaWwlhBooAGoCXqVGYvS0V45Els/AnFFVhtOeVjR9rpyI3Ej89jPMlVyw0hhVQLKxtJin2T9OtYWYRNh3AkyWd+utwZ+IR+k87eUhC25nKSSuQaQwne9AMdW5OJJZfEi8lbfQzDrx1ZFnjSvMy3llF2Mi69Ge+r8zjnHFd4WS0BUDdiXDu0tuei/kmTcnUXeQirRh7f2wE08ZdZv1V9lzGYJdW0WZ1pjHDDrtuzV8CK8nPCkt7woxcG/LQkbWt2zZm9xpX9WPY8gIBi2vxPG4Y+q9AYSUECle5H5GiMca9N7YBP9Usndp4cPLhbkWbIfVNKqskdbrYtsZ9t7GHyiFUBl/434tfORUiYpXgN+FE32HhSHy35s4qjQdPlSeP5OMcIAh7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(36756003)(2906002)(86362001)(44832011)(5660300002)(2616005)(52116002)(6486002)(186003)(83380400001)(6666004)(6506007)(26005)(6512007)(1076003)(478600001)(66946007)(66556008)(66476007)(4326008)(38350700002)(38100700002)(316002)(41300700001)(6916009)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4h+foMY1PHeenrTiFiTKYJ2xNmR1PT0FpPB2ezRjAswc4ixRqkZA7ljweQPD?=
 =?us-ascii?Q?r9i5tmaQCgzKEEGODFQIlp3nb0Z3cl3ApnY1WBdxf9AYPpTj+Pve1ceKsmam?=
 =?us-ascii?Q?CSiOOu3PvXpZ+JpKfODmVHWKI9zmpJukPZiGymPH533KYyb2w/nLXStmvrQt?=
 =?us-ascii?Q?vDKACGyzr0wwFUgFmd0FRyaXjYh9T2v4p225XJ0FG9vTgQyjvS9q3r7IDycf?=
 =?us-ascii?Q?jVfzrvmfrc+mlRfJVvWlqzKeKDcbZ73ACN8lsREMXpoFs+iRmWRRb9zMw+C2?=
 =?us-ascii?Q?fVVhCpdPZy2186se+A+n60T1r1w40l0jT9Yto8g0TYmIvC5jLQybzlJzyP83?=
 =?us-ascii?Q?3NqCXErYzPu75hS8bQSirMe8ZjlK6EdJZJq1m4YBX8pqfBBzdhUh44Iekcen?=
 =?us-ascii?Q?mDyVCJjE74Hfkd5T/2oFR4tWxisXyMRw4WvwctNDB5/ZuNEGluiJYic5Az2T?=
 =?us-ascii?Q?cHX1S1LBe/R0PkxfMWFTw5Yhs4auWxvQ3BQ+/x1Z/cLjkLWBuaoOxK8J0x4S?=
 =?us-ascii?Q?DRRMHjb638/wUpKss0dQYFRxZrTrkq017LKhae4qSogppulOhu1Kqgld2Cpd?=
 =?us-ascii?Q?AvrreTW4GDTp+f2LgpD0VQucFpg5QpVBj2RiQrkf5xy9sBJKZgcZvRJtbf+E?=
 =?us-ascii?Q?suK1HcX2MgzBcLu/CnBGlbMr5HaEteVX+A4Nev0lId218BC2ntDOOagvMKtI?=
 =?us-ascii?Q?E7tGBKrIMyr7t+623fGhAmpiLFIheiVLDJ5AcIOix/CmTz+WYKQZX6miMygm?=
 =?us-ascii?Q?uI/duBxRw5Iv/FLWsYRRvKI3ZtjvBiHSQBXpsPo86Izn4S171Uk9dNqmPnoc?=
 =?us-ascii?Q?ERp0BsJ8d+Un5z5ABJfU3IEfC7zi58ezJomWe5mmbn9aR6rXW/w47WoiO24Y?=
 =?us-ascii?Q?xlMSo13YfPYwedqLEh7Sf1we+FRg4QpHY30BSEgsCSR2OaHDYxSUMCte5T9Q?=
 =?us-ascii?Q?IhqzQEGkXTU278QnEl/L5rGYA+cVJV4krh+nipJKVjU5u44gTPaYeTni8SIz?=
 =?us-ascii?Q?c9ul5TKVBPiCOFxjA1oxLPeRXMIVwB2X+jF96HkG23Z2JYqtNKJvPvWWfShZ?=
 =?us-ascii?Q?U+5SAo1/omIkG/NjBMuuEXW2uU2vJFlWKqwlPbx72q46gnVyRFVQ+rmYhCi5?=
 =?us-ascii?Q?5rbCfk47rvJpS8zaRQzRCdrtegq0XC92NIBqtXti6iE7L6fGQ0O0FvrRSqPN?=
 =?us-ascii?Q?lX+Av48yojMUYI3huTr1ZudQFsRmdf0nXNvZ6nDO7FPs8d/bpd4g25ra8jbw?=
 =?us-ascii?Q?PmTv+IxhZ0BmeJcKlGlzuTP2UdEipka4X5ksyhg1lYB9vr2k0JERtJ7u6QX6?=
 =?us-ascii?Q?f/3Ig8SIXAuuEglshxH4qy+I9VTIOgYTSocakEZ1JYzNHSaYz24EprXFH+O/?=
 =?us-ascii?Q?loy5dCVMHrDS9PKw/fJaE06eOsR3ykLuhcmDN2EfvXU326pxVjWEOfY6frER?=
 =?us-ascii?Q?vMalzVKOZFXIlx6yw2/70T2M10bBAEFyKlLm9adBK8iFhSuyMohDlUN5pP+i?=
 =?us-ascii?Q?0Lzm81lp2AnNUH676KHxariu/BNtCgPs0LaCjJ60gaXYSV9m2QnzHdm+NgX+?=
 =?us-ascii?Q?31gGmPXEEoy3mWyDS7z4DACnmrJJXv1TjBYZQ31a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac19df8-cb7c-4e46-7c3b-08db68cdeba0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 09:43:03.7189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxXyU0bvBoLO7ICMPTPdq1Hne0L/8tRh8OLB97WiLFXxFd4/fcSFQdAm8B6YNfcbhhPUS7GwJOBv0ASIVD7HVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8191
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers

This patch series handles code implementation for mandatory features of Volume Offset Control Service.

Implementation of following features have been handled in this patch series
- Volume Offset Control Service
- Volume Offset State Characteristic (Read, Notify)
- Audio Location Characteristic (Read)
- Volume Offset Control Point Characteristic (Write)	
- Audio Output Description Characteristic (Read)
- Set Volume Offset

Reference Document:
- Code implementation is based on VOCS_v1.0.pdf
- Testing is done using PTS in reference to VOCS.TS.p1.pdf
- The verdict is PASS for all mandatory test cases.

Thank you in advance for your review.

Warm Regards
Nitin Jadhav


Nitin Jadhav (3):
  lib/uuid.h: Add VOCS characteristic uuid(s)
  shared/vcp: Add initial code for handling VOCS
  shared/vcp.c: Make VOCS (Secondary) as an included service of VCS
    (Primary)

 lib/uuid.h       |   5 +
 src/shared/vcp.c | 564 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 567 insertions(+), 2 deletions(-)

-- 
2.34.1

