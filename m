Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEA2C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 14:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjEWOfs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 10:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbjEWOfq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 10:35:46 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB370E5B
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 07:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNzhyT8M9LqEV2vnqKZJNFfa/0BVCEpmAW+dI/9575ggXPhXXoC5LwGgUPpxCvhmasm8vOCQ4htmEfeJ6JF2e49Q3q2z1ESeeKcTbNqd8aClVyzBBFIHFSdx/jJduN8TyJZRperZnZM1wN8bUFaGlIPt9YgcuGOuDhlcZpPEt8NWTG//KC2P05rxvj1mRWyl3lr/UeHHRYrNj9FeWhfE9lcksM4XOj8r4Y+and09sWhhuxy1q2TeHBESTx8AIHK98H9RVo8Ndt5aFaz23H+EgXGlaHx2jIsbFngUBXYYhIsxAwJBEAGrJlc9w5En+PQ3LhwIUsUfEUNPFX+q4U8nxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSefyQPzr8r4y+LQpnnfUvAp9yz79qDbodZk3lkrefY=;
 b=TDEd5OJ1g5qxn9V7A0/ojOziSbg40iWak4yoAf7jLAQ4VaYc10ntpdCkXnE6DJYY42W9oaOi51stQIyfTLtus1Kr5WbbAJBGZ85rsXLjAIuAf7v3MkFVtRgUDiBNFMnULu60WK0e9+OhblMdUqlFZ4j4K20ZxhVLgI78udeWZEVJ5MPwQ0MSa3w9lCof5yMxyMJrPnzcRt2IO1cXVGW70HjYB95I9vMW5by+6lahuje50/QcPnawc9UQk6TqL2LoAP90yHLQxFhHCXqVVxLLqkiJO/h8bhNY/ftnY7UFZfcgysL4j0vLhugun0kGFQEQXbY91PdRLx9xuSjGJ0SXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSefyQPzr8r4y+LQpnnfUvAp9yz79qDbodZk3lkrefY=;
 b=PNCYAl4nRkA/EDiydrvMGC1XAefiC/jbGGRunBi2m29Golw5/9c2t8rWjU37skysyGHndv3Scn1lCdjpnwpRmA5UGzEnhXD4WBb4HpAHrZfKxyusx6tSOWzWx4rpQKRXI014zqQ0k8K5DXTwLCvQ0saVzfB8R4Umyz9NjeMVqDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DUZPR04MB9784.eurprd04.prod.outlook.com (2603:10a6:10:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 14:35:24 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 14:35:24 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/6] Add initial support for BAP broadcast source
Date:   Tue, 23 May 2023 17:34:58 +0300
Message-Id: <20230523143504.3319-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DUZPR04MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b041ad-09d8-4c03-3f18-08db5b9af1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nD7PiJ0czJZV1e3J48GPP+lcWvsxaWQTnDVtuWP3+TzaGhgrLZFkM73hldVnVXUcbGe4u+kR04tTprO0jB1luvrpVPqk5IQdos53X3xR7m/GzK1fCRkXcIjxk3czReYX7gHYBoLvtD9rJrlFvqeRwTzFbRSQ6Naa8Uta5miR2AiaPowkm3M5l/d35hjAmAaKm3m8to8GbkbgPgImDSMjIMjNE59xk5dPptqRNDLAjwpT4yRalBe17qtzU+E8B4Vzm/u9O6fAHepLDcMYdtoJHgYcMGCbhogXGg5VrUiOc7ISXST2o3Rysv/57i9gXmc6OTUUF1aq6/CPjnZEGkOgn7udNsrzt95DBy44pCW740lzURzSc1IWgQ4ANKjl7oDzGjssiUjgo/20qEH/XmrrJZrwbebf3A83wriHpR3UOCcOXP7x6lxY8bIcnFyISLhYiSrlbxHwyamEhM4gh8xD4Tre6U29vbs/pXffBJ76kjmDGVvE0J/mm6La461VIVE4tyGWye+gc5frHoallGU/nFg8sSAjNw5WbaME1ejlIh/Q7eEIW8zVCdAPhSzLZqdIvAGCwggGqOr64oHq9JZ9wJiCigwSPS/TOIJzyMoQ0U0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(83380400001)(86362001)(478600001)(38100700002)(38350700002)(2616005)(66556008)(66476007)(66946007)(2906002)(186003)(4326008)(6916009)(26005)(316002)(1076003)(6666004)(6506007)(6512007)(6486002)(52116002)(44832011)(41300700001)(5660300002)(36756003)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BxzemGmNzVj2hENAXn65cs5LtEdPt2JBtCXcx0ABWkL1jXL9uNGA/Z29T9qR?=
 =?us-ascii?Q?/h4/eN1v7rR3dwukNJCWCpJqvbwX/Oet5qlq9jbcgFOVrpN1cMvIgicwIhWd?=
 =?us-ascii?Q?L2EMWtI5+0w1VR4jXe1N8ao3O9bXgiLv1DihBwhpn5DOCHkJ0pg6ICanBbEH?=
 =?us-ascii?Q?gzoueVqWtOlPq5VwyXtG8O7gKAmJmKFzgzJwHavxQ42d99YBJan9TZpcx+gy?=
 =?us-ascii?Q?Cikd+qpf0NEW06KMMcY1Bp61dwcev4Z9PvXPi+UHlfajTte5+V7ejjLBsxOS?=
 =?us-ascii?Q?aWqfgRzRIPd7gEh7zFGeWhBqmPpCVseoEDgbSzf4X6uJT15zuRSxziqQiQLI?=
 =?us-ascii?Q?PuZUNbdOhEXxO3M1H1rR/gyrE6JNAZk2L+Xeqq+KliGlQClhOunhHCInnI+Q?=
 =?us-ascii?Q?2tq5T5UyFMbgk4jlO5AZ7xte2s/5GrJA50fBZuqCOJYOOK54lRABAg3MotuH?=
 =?us-ascii?Q?mpiJHsASTb9uQioQsCbmGfNe3yT8EOR7Ws74YvCHBiH+8W5WrpSHrtRS5f1W?=
 =?us-ascii?Q?ZJkxth/392Uu02CVdHp6Xr4i0KZK2au8li15XgxgAIX92szNeuPPOY/+M41O?=
 =?us-ascii?Q?ZVxX8j23hHoZDYWuJ4GNiVGuJjQzZQnu8vtSOHmdTklCGJ8X3H9PyP4dJB2n?=
 =?us-ascii?Q?1GtgA+9DlBoZhMEmHq3i+FdI5DeruUObdT0EnfRUUZr7UElxPd6WCxBeqfiz?=
 =?us-ascii?Q?CMUYha/mkbWT/jLA1zoDd23DRnxPsd4jw+f/9t7Ufp66zc1vNgGiR9hSX8g/?=
 =?us-ascii?Q?J0y/22Ipov/l3P8nNcUez5U/NdGwYPpS2pUtwuz9Tdi9VV5mJ9ZndMIV0M9f?=
 =?us-ascii?Q?Gh6m7jTqDaXNARg80E+9UHKpUfHWEkrAoUPsyCdd9pACI1y8ix8eE8pOVtJc?=
 =?us-ascii?Q?pMETi+LEb4c1RwZfAAQuS+SsshbOUe0psBcj7hopi7G0bWymUl2MroqwKgvG?=
 =?us-ascii?Q?28UhQCOP+2+uuteAvK7wRNy8di/uUElVWihTbHJQK8apao2MwBLr51UBo8jo?=
 =?us-ascii?Q?5J/mRsX8LMk+vWP4p4ScknOOO9Z/OSZXVLpiIAm1yaPp2OdtGD557bojaT3i?=
 =?us-ascii?Q?w3L59dIrvOgBfntBrEyiiDb0sYwVWZ6qZ/wofPZ/AI7+3NYk1UVM+9Mcxy8G?=
 =?us-ascii?Q?bGOBJdu+kO3XgJBthujGmQlLXS9ALMMYT+yL1uoK+40Lz0EkD2NeNs2ZTiOZ?=
 =?us-ascii?Q?6+7PeJU0RAV9OdSLHlh63ftvXWSd/zY4UyBd58eC7KNx/oJVdIP78UCLD812?=
 =?us-ascii?Q?Gc9jp6uzt0Lcd9Ocu36txcxRE9rBr42/Z/U3JqWm9VgAm4SHqq124b4/LObu?=
 =?us-ascii?Q?S3poorBe+P4tEvM2UJeGG5wnGXv73e+1ad3vIjG+Nowft32WibFQlN89bot5?=
 =?us-ascii?Q?p6RFli3+s2ixLQBCqaI1MnDzJHxmckKaoY3kCkQDFzllkKE4Q3CNrIxY6FTy?=
 =?us-ascii?Q?qG10f/2pIjuPXxl6Xhn/j8sLtTsTqJCcRWTg/CLdGUDhp6Y33hNerlTWrxtu?=
 =?us-ascii?Q?fEL+L+nAo3SGmZV9eragUqUpUQDPk+ylxwhyGbGVNd1UqK3jKwCoe95ImaUh?=
 =?us-ascii?Q?RWqzxMRs3wspaYg8t2IU+3siTuAj5HhTwEIKHk7YtszrpjYPSuNRKbzLOmS6?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b041ad-09d8-4c03-3f18-08db5b9af1af
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 14:35:24.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UV+6TEu+1gl6VURLZmZuaZglqEyDAWHXh6XHPcMOFlwPyAXSaK4NslEF5mZrDZMzBwsRN2kJMRQjyZIrQaZh4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9784
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
  doc: Update Docs for BAP broadcast source
  lib: Add macro definitions for BAP broadcast source support
  monitor: Check for ISO broadcast support in controller
  btio: Add support for setsockopt (BT_IO_OPT_BASE)
  client/player: Update bluetoothctl with support for broadcast source
  bap: Add initial support for BAP broadcast source

 btio/btio.c                |  26 ++-
 btio/btio.h                |   2 +
 client/player.c            | 207 +++++++++++++++--
 doc/media-api.txt          |  11 +
 doc/mgmt-api.txt           |   2 +
 lib/bluetooth.h            |   9 +
 lib/mgmt.h                 |   2 +
 lib/uuid.h                 |   3 +
 monitor/packet.c           |   4 +-
 profiles/audio/bap.c       | 460 ++++++++++++++++++++++++++++++++-----
 profiles/audio/media.c     | 129 +++++++++--
 profiles/audio/transport.c |  51 ++--
 src/shared/bap.c           | 324 +++++++++++++++++++-------
 src/shared/bap.h           |  81 +++++--
 unit/test-bap.c            |  83 +++----
 15 files changed, 1123 insertions(+), 271 deletions(-)


base-commit: 8c452c2ec1739efe581273bacd738e5294d0ca0f
-- 
2.34.1

