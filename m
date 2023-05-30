Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F94C77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 14:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjE3OXh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 10:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjE3OXQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 10:23:16 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6C810FE
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 07:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuIoy8WMnYrsbtPiIxsy/F+5Zqd5jo7sQPLgmNFSpDN6xtY/z/0mQGfI3Hai51aMuQEgVfVbiA7u1EFXNGs4VeDxhg5TkKWv60e1TeC8ylNut5nIF/eyIWM0eGLBopZZN1FtrBce/ZOsMM7y2nOHoehBO3nmSzuCb6cG7hm8eh/lMOAObPVpI68T6h77lPOKvrz6u05r/7vhOa9XViutm7/8FyfpjqeQcoYUinMKsulPe5IWxrwmJTw0gxe6/EAEYpCdOL6zo80mHsoPT+vDJOJk13G4wLAhmGDhoaPA+KVPBrL7x5sgfX60EeEooxKxIsNJ8x1T7AtKeM8xJCFEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui5y540lwtR47S+G4aifXol5jxBXs2wWQngWvjXhxtk=;
 b=MNF2/BOpDyaPGoD/YMz4lfst4bLYCMOj5uTBolSPtNLo/oHiscBA8m2DjpOGCX4YmA/2P/QMTQ3OxuEZpTseQPvbkjx4EtS1iSz9dUGdXlDzMC3FE1j3FLWmskHkf2CTUFwo0H+Jkux0ANbtuMPvosAcaM4Yv3qxWKee86DjkEhj5/lij9QkURmnIkjwZicze7yg6GPtDdLVj38WptoWdBx0avlx71BE9+0MtAXe4dN/RDQ+3P4M740d0ARHd4YgUobVmZgKoIjD7Jbjb9YUDaGJTs+RHDdIMFupA6AEZNTP/e78ImAeJ2/IHTaZXLCZzKfNVQ3Uhb7NladaCIG00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui5y540lwtR47S+G4aifXol5jxBXs2wWQngWvjXhxtk=;
 b=il8FZG0ThSjsE6Cr4GELlZpLeJTuis/FDaiUAcpUggjk64Lz6scK+I/2L0MtuWq79c/Gq9CnVdSt7OqgbfMvVJbFvL8olrWbQ4NewcqS7/i8onkmKrrTXTFvSiu1NBsO+rmx74acCdyrggavnQ7fI389z6IPx5GnpUFJAOYJT6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU0PR04MB9324.eurprd04.prod.outlook.com (2603:10a6:10:357::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 14:22:23 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 14:22:22 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v3 0/1] Bluetooth: ISO: Add support for connecting multiple BISes
Date:   Tue, 30 May 2023 17:21:58 +0300
Message-Id: <20230530142159.410567-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU0PR04MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: d16c7605-41f7-4018-e44a-08db611948c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h4OOn9k7oVpckrWZaEqfKCrW2aG1ekpRGoxvWAklQZAp8aKijHZIb3PMkMvOrHSvgpiLlKvLCmXpVNnOaMIUUHIxuclR/y7xfdAVbTuAok86jDO5txvnVU0FO4WHsN1fuIR/5+G/rI6un9VuMFmP+ASRPr1mMYZDpFDbmh83Rx0UvnTemCGtwYJ9jDcEEe9NUXpiZFzYzNNkMqvESEp6fEUesaznJe9XxQLoH3YrHX0iN8d5qsHFAOSsbyAsdFohwm/P9t08f/BuY1pUF2JTpkHhDu+mzeuMkY7u71R0iGAIoLNiio3bifp5mjso6HwspDArKLq+HwqZ/qVRuH6wAflOpezjt+BNcoLA1Dj20yX4qMXEqdGxvJRZ/UIXr7pU5URqTle0WVPef4sk9RsRPkxPen+yAjCe8Fj0XUjghmRwyYK3mI1U58Y2nEbW8BEeKtKrykQD0F9QKq1/MkOuk3/9rNawqI4hl4PpwaLW/1zBpmZCc9s9C/qaa5Oc3fW5MVGdHEkGJZdSrojyZg0jU8CBNDsdRqrXaltrPux9Esgtbnt1sufsbc3f14w1G0l7RMK05A67+JUnZW2TqmDv9JKGJCccRLHG+uzXK30uA80c08/yQZEFKOsI30C85LmE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(4744005)(478600001)(2906002)(186003)(1076003)(26005)(6506007)(6512007)(5660300002)(8936002)(8676002)(2616005)(38100700002)(83380400001)(38350700002)(6486002)(52116002)(41300700001)(86362001)(316002)(6666004)(4326008)(36756003)(44832011)(66476007)(66556008)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dFZqH0xYjlmV1wCc9AV79aRi0m/u9kWo+HC5fADkYWGtFNmCRuS690/C9vW7?=
 =?us-ascii?Q?6YL68QD+HkQok6uQ2EGr0BINmAVpltqbsJ3lbc1qw4xQNZLWMXDrwUxhplia?=
 =?us-ascii?Q?WzeNQCdzq0FKQh73WR5YuPBZvrL7oBbsWSmbD2gOtBO9KMWOrEh4IvqLJATA?=
 =?us-ascii?Q?Uj1zxUbsxhmlLzBGWJo4Xl/99EY0oWswroyK6Scg1XAHra+/gHKJzH+57Iz6?=
 =?us-ascii?Q?bgmxN3MXSSjvI8IuzzZsNs7DKKF2ytOyLKwlkGHOnXyBOA6BAIi1d0f20zUr?=
 =?us-ascii?Q?Al6I7HJyrq8X1F1ulhkTHLJUWXRl0RlRQYZQa40r0ImgT8jG0k5Jz5pCKbkJ?=
 =?us-ascii?Q?4Xxr4pylOESRZOFUR+Du319h1bCwJrNDVWOEFILojv80VVBSDoYEbJ/cEBdA?=
 =?us-ascii?Q?ZVnnzIPSXcPyLRJfgP+iQmZwI9HxchQUI62o9y/hhWrmHcwnUUg2MEnkltft?=
 =?us-ascii?Q?k10zBNZpkhAFaSQlQ6l07o2wFG2vA7QfI1QxZbEoSd7HQmV785MTbMGRkcmA?=
 =?us-ascii?Q?6yQ7bc1CbfAGuRfH6BGSWUMFPIQ5LCECRH/iSG1TcUpJ69OGO5zhc0kCRZ0Y?=
 =?us-ascii?Q?RDblWJ7BNOQHutNiI48L7njVftyK8MVa+48tt58x56jmCcrumv3QDoT0vJxH?=
 =?us-ascii?Q?+VOiV9R443pquUq4te934ah6ZgZgwFCe2wS+EPGurXQhXkaZrqPhz/ol91zu?=
 =?us-ascii?Q?dVya6XcLRcMkWcRz3k3Y/tkaexit6uHpzIbU8MbzcKTNYrjBTR8XUYcw9jCB?=
 =?us-ascii?Q?rhZ3c4OA9ABdIUzF8AJFut/YjK+LCTkmnC13fAV5+G5W9Vga5ArAd3XVKNzb?=
 =?us-ascii?Q?Mjldd7pAbXt/4HzdDoK0SSkF0DDuBUHY0qQ+rZ0VQfe2fZwZLH8UVBH1yLO5?=
 =?us-ascii?Q?3KjcifmtLJD2wP53Jp8kPAFUr5dm6UlFOi74r7NbOMIPRA3zSK3AkDm94aYB?=
 =?us-ascii?Q?nmDU7ahhuvZ2TR6tyWrsM30Sh6oU17GFQsPgrpUKlSTn36zXVKRLXbmnCdxr?=
 =?us-ascii?Q?WSnaoxE+oOno88+16gHblXJ8wjX+2R7iH404CbiV+zMjdo/8KBDUMBpbldaP?=
 =?us-ascii?Q?q2vCHyMoxKzZbZtWECZLSG5wmPVdID1r9OsEyDoxG1IlBU7WlpVRl2rMnXBR?=
 =?us-ascii?Q?Nj/72uRk3x0r/0N0NGiOYuJE2JSZBGhmiq29oLLWpFdhvBMIeqD1i5mKUQoa?=
 =?us-ascii?Q?qNu1eB0GHgwUohakqOFG8DVh2wH2TrpK5zoU34KUWveQ7pujKfugpIvoQT0X?=
 =?us-ascii?Q?eI9GtQ1WnT0AWsnp6rbAtzQhuFlF5KdaItH+gdGObkujxDncbciAFN0LjxRY?=
 =?us-ascii?Q?9vRcDgNfNN/mAvqIaGS7eU63i7GnUiUy4tin/pBQKOFjAc1OCbHwLn6QMlKM?=
 =?us-ascii?Q?EiyrZf6Y2SNUXXEGGHmwqsKRWYtT/Vpgjvijx03ZGiMNwiV88VFP1UbUQUhL?=
 =?us-ascii?Q?py0STV0qQ32HRwseGZ4hdfxuW7NAO1n57MRZoLbgGeZuteSxxizyYdFMZyrw?=
 =?us-ascii?Q?VzngAnGeHiceWieOZP0aidZSm/YEw5x7FrEYeSiHPkwgsa6OHUue55jCcbQu?=
 =?us-ascii?Q?a72nBqECb3IPDUHwKrYEZVxfp3rh3APk4bx7DSr3pTYxQT4t4S8uqRpbUIfw?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16c7605-41f7-4018-e44a-08db611948c5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:22:22.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PvpjwZKRfm57zFK0b+OyPOE4oj4xl6yLbYVD2lEcZDjRiTS1Ie6vtozaCouyRV1lzohOKxFZ6togwtBdzXkVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9324
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements support for connecting multiple BISes as part
of the same BIG.

This proposes a flow similar to the one implemented for unicast:
DEFER_SETUP is used to bind a BIS to a BIG, without starting
periodic advertising or creating the BIG.

Connecting a socket without DEFER_SETUP will start periodic
advertising and will create the BIG, with a BIS for each bound
connection.

Iulia Tanasescu (1):
  Bluetooth: ISO: Add support for connecting multiple BISes

 include/net/bluetooth/hci_core.h |  30 ++++++
 net/bluetooth/hci_conn.c         | 152 +++++++++++++++++++++----------
 net/bluetooth/hci_event.c        |  50 ++++++----
 net/bluetooth/iso.c              |  28 ++++--
 4 files changed, 187 insertions(+), 73 deletions(-)


base-commit: a088d769ef3adfbc59ed86660d0de2abd86660e5
-- 
2.34.1

