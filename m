Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA16AC77B73
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 13:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjDSNo3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 09:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjDSNo1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 09:44:27 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5AA6A55
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 06:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+RcqCoFDzA2ivzngPvlbVHxupz6au86B29dllwzKyc8b2fptWS5EinN8glL+UcjsO2QN7DnQY9fKuitVZ7v3Uv+IV1Os4xJZZr2jscR02SPbeTUU5gyB1S0SL29Og+/c5LbG1klPL+zqo8PYH/AThNWfcCVbVA8PQAmGSEckgim50SDHmsX++dsduWETFL7+eI8Fai2D5K/0XtodYXhuif3MrMGgToKhMd6Qz3t6vcD4Z9tvljk2HSLBhqVNNf5dA4dbuXZhVT64M8VO+SEbOsX/Kxg16WjNpGD42XcYR6GGoDfjZiw6IcovH65Dd6pDpJZ7bKd+gt64VkP+nI8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UV/yFWkvNEcGGXTsNAHClECwDV6I3On8fQIMcrEcD0=;
 b=PQau9s17AYk/Z/rsJNJ8+1G8h6JtUSt+FcK+rkZ+fZX6AENHzMRW7qC1DKJLkZ+NXJjoJ7JNiffRuhgAYlvgx59wF0/00MV3R04W7Aqior42tyuAnZxlpDp8iQmYM3RDj5h70eIyhMHK7JcsEVoHg0jSAHqhl7ZC49mwD+2j3QS5PwLq0qMQsb6kbUs8LoQzyNWE0u/guhCAEzYrI9LYUYJk6PKLYV6lSpJtBTXnRqD/gOlXXbdvZyamIyNwH+KW5tAQMKYjEHLPflMJevv3Km6c/it5okZGKKBVI2dSa71w98qYp+JlUaiJu+bNL4RUmurZB0aa3yaO9oi9pIogpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UV/yFWkvNEcGGXTsNAHClECwDV6I3On8fQIMcrEcD0=;
 b=OivUx3PLp7G7g2JHnUamV3PG1Y0yYfA9pzU7QeCtxtDvKAeqU6Kha5pN4SH6y2SXOg5NtifioXnQy1inv0dGL9KazTKxe8cNo0XHazMrtCzJ6i9tp6DBzpc5yRwlmSq+BWqBKiQUQ+SmfsmZ+IHvJEGuDNvBhi8W2JviWkOho+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 13:44:24 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%8]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 13:44:23 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/3] Add additional Broadcast tests/options
Date:   Wed, 19 Apr 2023 16:43:51 +0300
Message-Id: <20230419134354.61950-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0119.eurprd05.prod.outlook.com
 (2603:10a6:207:2::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a08f573-e957-4d91-8ea1-08db40dc2f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKWlWYwVJion2ue2KiPqO9P/hpIDFlQ1L0VFWUF/NkoqE8TjO2NbAIpdA4/GUj9VQhTzYiueyQ2r5+VP6pr53TQmFVAU0P2O0RTmYpQWjeO5LTLubIFGQJ7Dgr9mikJ2bZemt/kEmvI5KMxgnwnEZB67y0utQEh3Fdx1RSHyoT91dcpcFSnUq3v6ZRpBONPzvOA2XdBfKkXOO4mFdKCq5RkUgn7kh0mDl4dniN4JvFrzZ6BzjFSXfSUczLrsvpTY5ATK9IVeZnlS0pcKIA0IRt3wD044mAIyOhatiaRkGeTYDeS0JDlKCf9x0rZcbzuNze2uPAWoNG1VSLqt+VOgJn/ig14KoyGYSSZLk8kv3ZGwk0DqDXJg7MDm2uQSJ62rGVC35O78+PAkWnPRpHbC3N8m6FaZtQilApC0rhO2RO2JoROGuvwggAuteKvp8ZAuGGSD8uLhLM7RG5u63QbJWDrk7Ih+AiC2UZYI31rBZ/HZWBarbPNNFf/3XLaDPfqiEtfhCgm8IPxXvcG03KUZoFfaOtdVByGU05xk66+KCdmprsnYZ47QtwvxWUcdr8xGWYQqkGh7xZzUX6RcetHlR1ac/7U0pjq7aQJ31ukS8ZXUxFMhW8FOAtbN0wcc1yt0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(5660300002)(44832011)(86362001)(2616005)(83380400001)(55236004)(6512007)(186003)(6506007)(1076003)(26005)(38350700002)(38100700002)(8676002)(8936002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(36756003)(4326008)(6916009)(66946007)(66556008)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?49ZYV859vMUWMk+RsZr5QOTv2nt+3iR/lfxFJ//ArSVxky5fNxtsDYSC5TDC?=
 =?us-ascii?Q?Dybs/w2gMXDuHuA3bbRVe1KMBIO+XbkwwPUzQZhNZar8XplNbt8C1RZBLjad?=
 =?us-ascii?Q?67CDg2bKwVpPu7uS0V0vNy4n4EQZRUpKjOLGRmjNWcNbtEY8N1hwbmKDMdsH?=
 =?us-ascii?Q?mJyW+E2hKv4NGTqtyx0gwc58XxgTyhuFEepGf/bcCeeCz7xjKZa5U6GEv8uM?=
 =?us-ascii?Q?QKS/PFxWc6mG9GeuCi2CbZ/L9ngIUneaFvtMzD9bHelNsBX/IvemwO2DNVmb?=
 =?us-ascii?Q?3sH8xfigdIgAiwUhddOPn44isK/dHzgbb8xOak2IaN9bvMilV7lVEwi5c3iC?=
 =?us-ascii?Q?yDbeXS+FnAjF9HHcOhPeb6PPXaXwSJcgXtQ+5bdksH2tqSiSkbgp5Cq1YJJh?=
 =?us-ascii?Q?sHzdRsfsv3wmDcijm2giraPSI+P6xecWp3IcI+w86TmzGUWm5LMY5ovmWaZY?=
 =?us-ascii?Q?ZyBiSs5FNkW/SLVrmYmANAASpup+Ix09ipRMjla9PIKwjbM7ttgPwZUks/8u?=
 =?us-ascii?Q?A94nz36G4VO/DtjraV84AkolrmHNN0eRiAG5/NRpvbHY/FHYRzPs74nzzyu4?=
 =?us-ascii?Q?fQIGokk6azj3txCRv6/ZrLGpEp6lRYpInZdu3WPBWA9MmBPRVHMh+e2wI4HS?=
 =?us-ascii?Q?vgYJ/4wsYn+W8B1dc7mMAc/9zlnIw0/+CXdwrsoTOq9YxOqdu5eIjbOJ/GbP?=
 =?us-ascii?Q?c7tsY246+f1GWeMq05LIXkdpAPncK227iLDAyyYfRO0ggyr1NZhqR6n5aUnO?=
 =?us-ascii?Q?dN5/b9oyF5gf6aKq+09EmOyh3LTA1Kxzae5uSSaYiqo65xNh9l2M8fAyu6Xv?=
 =?us-ascii?Q?t584hOtbDRFA3vEhthkpe38N7/cYLRyLMbdWXFdU8jQeJ9E5IoUqt4vfkA22?=
 =?us-ascii?Q?T/T2xEAm0sPc2bY+P9j9DNnkvcVKFH/IwgRMQgtLajqhbU4sbH1KuT7qMXsa?=
 =?us-ascii?Q?ZzEDpMI2Q3GD8qNWKoJe7TXlFhkzdjzAwz5Jt7Pg75M24/keMJEQlEoFxK17?=
 =?us-ascii?Q?nU9xVelqO5rKMksXNp00eV2/XEaDvhFGNQOFTwRD6wLEVBcYEmP9H9mXWRVf?=
 =?us-ascii?Q?grLSs76XnkjxcJ2SUSkGcblAv9Ny5Zm5gqAdu0C6jAMGllbFkgoeNVmUbgx+?=
 =?us-ascii?Q?MnF8Mj50XLWdRl2O7J4wYz21ew8Yy4hp5XusrD+Brvu5N9MRVntNuX9+cVSA?=
 =?us-ascii?Q?UqeG5R+tOE/ebW+l7oooaTbWsPHkOGul2c864qVYKcEQUv5qAiACm9mgcxDW?=
 =?us-ascii?Q?GyyiStKxIygZrtOezlYS1kkZbDny0NU7noPRg+hO8k5w0xWIs1f4Jo0CGyjA?=
 =?us-ascii?Q?4CFVyOtWBXItEQFlVhYJcf6vUwdRuRcQZADc3iFCRdIJ0pk0t9aOP4xnB8T/?=
 =?us-ascii?Q?fjIgdcq3spGOu52F87/Sb5K/s+l3W+XHdMFGY1Quk6nKQH/GbKXqd9ZNPIqt?=
 =?us-ascii?Q?6/e8d2O3LJjSz5LSMDF3A0T+hZBZxZS8rffoqj8/0CMymGptUCWP2n1OS+J6?=
 =?us-ascii?Q?Px8vfWG1bxzsC+0xp11l1iscrDlFwYokxhP5gbydmN8mkZGZiHMrjHoRllMJ?=
 =?us-ascii?Q?2a2ADOImelgLCxsjN/DdJLO1wxIKIvw2V3MXjzhrOUS5V1HDUvzkgxYNlSAv?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a08f573-e957-4d91-8ea1-08db40dc2f83
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 13:44:23.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTZSqPN401g+cwA7/VKj8NIjWvUMnPArZ/fiJM07Etz/xX9Rl1FJprVV6BWQ8YHH+6nVw26lT300EVu8c6hAGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series enhances the Broadcast tests/APIs available
in isotest.c and iso-tester.c, by making use of the
encryption and the bcode parameters of the broadcast
QoS structure.

For isotest.c, two additional command line options have been
added - the user will be able to specify the BIG encryption
value and to provide a broadcast code for the encrypted BIG.

For iso-tester.c, two additional Broadcast tests have been added - 
One for an encrypted Broadcast Source, and one for an encrypted
Broadcast Sink.

Iulia Tanasescu (3):
  monitor/packet: Fix BIG encryption decoding
  tools/isotest: Add BIG encryption options
  tools/iso-tester: Add Broadcast tests for encrypted BIG

 emulator/btdev.c   |   8 ++++
 emulator/bthost.c  |   5 ++-
 emulator/bthost.h  |   4 +-
 monitor/bt.h       |   2 +
 monitor/packet.c   |   3 +-
 tools/iso-tester.c |  64 ++++++++++++++++++++++++----
 tools/isotest.c    | 101 ++++++++++++++++++++++++++++++++-------------
 tools/isotest.rst  |  19 +++++++++
 8 files changed, 167 insertions(+), 39 deletions(-)


base-commit: 4d197b859e57a9101e26a9ff341dba3da32ebf77
-- 
2.34.1

