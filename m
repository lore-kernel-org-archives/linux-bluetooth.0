Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42450CA1000
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242446AbjIEQWs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353665AbjIEHJo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 03:09:44 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2070.outbound.protection.outlook.com [40.107.14.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9531B4
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 00:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kItwcouq5602ryZ4QQ2FfNU/LyxO3tG8wYMHhyo5NiE9b9IMkoO78DzX/HSQT7TdHZqJ+/AR38lJnAU5mxiMFN6X5JaDZcx8nHvQAO+hID2BAYAGWvGb33wq0cUkEpVZOZeP+cqmHsA4cM7bpXliHfGY4hipRODhYDxig0SNcCkeMOs010VNrxQkgHP7MdmiaHFQdHEMCTeAPl2vrfqUP9sRWhDVzIOTp4orQJT89KVM1eu339OpbntKw5XWWu24QP6Yl8kEMOsslwGoQjMm2Le9toMs4np1nvKMzeqL1KMKqBxdgQ//zJwd/tgOjG9DGK/MmOJ8r1HFJAZ44e1I3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nS6Zrj3HO9VDi8CZSDAQ8mzD6ETMWlKUsl2rH2fiPLI=;
 b=H1AAtkLmQ2iswXtrT61GKy8Owrrw4Ih0mmunpml0Bvxp12myf/GutBh4tmW/zMrA+nb/tGLvTLw9+G04ltykOxEdScmO/UOvwX1UvPaiedNv2sVDLmVoQTZDx7iDF9tVU87xZZMdjpokJiYmn5wIY5o/TEgd2TBKb1lJSqpDXPjQFNvPcG3JPIKdOnhgwJ2HvvyGdoK4+wRi6goSgqiKgNyF3kiqwqbQF+zeTtfj4F0Yr82my0mOAueEL0BGPBk77InEl5bJfVXPvfiiuYDPWEzNZ+pMsEO6cIxPcQkfWHCp5+YatIedtOwK8Tvy2CemOOFXCEUeH13T5wOGAifPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS6Zrj3HO9VDi8CZSDAQ8mzD6ETMWlKUsl2rH2fiPLI=;
 b=H+g94DkZCIiPGLAPw5JZth/1NSKoacKgr0lzue+FE3QCRSfmCQsbJ+PIZPezlulG/Z+SobcYShkvE5THKxFVmIld8cGy5Lxrb1fhqjqjJJecjbijTPAGHesCBQWGuQUoNDL8HoFv2UsGLOCfiUhs8CxjVzS/kcsCfCPFGXxFh9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by DBBPR04MB8058.eurprd04.prod.outlook.com (2603:10a6:10:1e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 07:09:36 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::2320:fa57:8f7c:bb64]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::2320:fa57:8f7c:bb64%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 07:09:36 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mahesh.talewad@nxp.com,
        luiz.dentz@gmail.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v2 0/4] Implementation  of MICS and MICP
Date:   Tue,  5 Sep 2023 10:09:08 +0300
Message-Id: <20230905070912.82340-1-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|DBBPR04MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fa74c7-3ea7-4e99-5d62-08dbaddf101a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SeAqbRLnKRkLoRMba32wCSGi0DsXcMIPCQidcXNsZuyfWud83wqPZRuXKwf5BlG8afWJTO9H500wGMQaBumE4cLmmgfcMTctVMnXbZEYFZhL2+i7k8n/s91FB3oDCopsNwVzPBL6Leqhze/me/RAxY+qFnc4a5D+WPyMuqfjstLrAk0juXMjokuKRElbHGTKG+1oiNzhoR6AzB8oGoMpW1s06HZDf8xtTfI7bmnvqBYbzJuv8TscAK6wM3TZ0w4MBNoqaI8NFQY6YCbHH1fWnJH2n2SxGdpYRJcN9nGWI5YnH5/erYqFUT1RNtFdLc9BKZmvUettkavdO6XsiAPHiEa+9xp8KnS+gzXSTEhw09G4QzFSoErti5nVcqD8yALl9rYkxz2er79raVv6ossjq3u5jikAkg96a6cDEtOGhAGSYfhNTj4dDUVwPnjySgD8N1rq/zrStUsuYxs5pBErvCdE+OyV99cyTqIF4jbSTfgWbdXz1aJUDk08ZyMDdj5PZzdyEdNGa86x5dqFZoPoIJ9bazMmOYvgCWKT6v8EXEeM3ECH+RokPhlqEE3MvLj+STBC6/XCDXjZStOb+RY4W9P0Pom9avlMR6dn8FKo6aRpalrd8+st5BvSpj9/2MsC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199024)(1800799009)(186009)(66946007)(66556008)(66476007)(6916009)(478600001)(38100700002)(38350700002)(316002)(2906002)(41300700001)(86362001)(8936002)(8676002)(4326008)(5660300002)(44832011)(6506007)(83380400001)(6512007)(6666004)(6486002)(52116002)(55236004)(2616005)(26005)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rmT6cCyIDCC2Zz1Bbb3/tImUTH5jid2nSZx7Uuo/EQDbX+k0agCzpKxArZFP?=
 =?us-ascii?Q?6podmPoSaJm2DDJW0kgA1OIdC8hkY1xyl26ll+Vx1j58HKbs+gpfaHa6CuHZ?=
 =?us-ascii?Q?WrUHW1uXqkhXP20TRlbzU3KNjGrN45ZmKUbu1yjVSjuAH1bX99z0iULKemSE?=
 =?us-ascii?Q?OcE9xAQgjOX+JQT4hH3TjLB1rNljxX2ISkTmlfWbY4R0I69x4eITdqCzs7tI?=
 =?us-ascii?Q?8gd8Obpf6d9U7RnDV5OYO8LEj2b3ypYMDIGTcMUMrVGGX2JDl/TOpjGzkvbc?=
 =?us-ascii?Q?ypSOMBQnr5AQJHo+n1IlqwMdswcD3LWkXbZpQ/8hj/dqrrxXvJ2q2oVphyVu?=
 =?us-ascii?Q?C8nm4DY8GGS1NsRWOwCVvGl6ZwHsQOYr3eTAxIALNdI2r6VD2JpflMsh3VQs?=
 =?us-ascii?Q?xFtx63IC42NNrDDI/begrIxQ3iHa/vDzStyGHxk+vKk/yGo8PXte0ZsOJ8n/?=
 =?us-ascii?Q?0Q6kywHBDLkUiF7O+2mhbG7ge90v8GTsQLS2s1ZiRymWMFFdltlmAZiXGoA8?=
 =?us-ascii?Q?HbOe5KeFw+vZxy9/WtefSaU5+DjyzGoNzSTyXSSQB/qoXm4ZiwLfwj2KsLIa?=
 =?us-ascii?Q?FC28yKWM0EM15ZenGbwOsNYOC9XUR77KhBtsRyD08nH6iJxANjvN0bkY97Q4?=
 =?us-ascii?Q?+2zpGa1gOU1f0LkqMcSmZhcauX7wI+WoJwlRQgEjXLRRAIyaR8v+tEgyolXO?=
 =?us-ascii?Q?Yn47DcYaalHMX0cerVOndI9C6x0I676twQqPCcnV+e4SDQNbJr4yjCo5ev/E?=
 =?us-ascii?Q?xbRYVaFppr6C/aI6+QQEaeFUFSOU9Y7EkLRne0wgLE1tvXihGFaDQhNvi4IL?=
 =?us-ascii?Q?JSaN8D+5Ttfnuh3TTHBhFfQAAq21zSBDRBYoDit0XJgDRbDi0Ze1r6KM6hxG?=
 =?us-ascii?Q?M7WqtzOsdCPKbDD9YkstK3g66vFgVL0mwFErGaumPpE4McZsQZVOy0vT5H++?=
 =?us-ascii?Q?6miev3WW8dx707aBHbXLA+tM3IEZp7MXpWX1naLPrRvx8gsrMGo5poWdMBQD?=
 =?us-ascii?Q?eA0mrHfIIUC8KTICcrCxE04Bxd778Q4sPTjZy10VEHGgJPTg69X1BTLVe77d?=
 =?us-ascii?Q?ffkEv631FJGWluh4DwOpYnK2hn/BxuFGGBziL2zqbrn0yWaZHoZ9X/hl9zL7?=
 =?us-ascii?Q?Bl1/rEr9omxmF4jfvetN9Y/QGEpFfoPmP6cm+ShuZ34thxtwDSwtnicW2/fT?=
 =?us-ascii?Q?PuOdmZzrRwmMgvf2VcapecbQpxXDzIprDrlqHSQZtItu6JCVUq33JuHJwJ+7?=
 =?us-ascii?Q?yWe/OXUxwBj+36T/gUqfoSZc5/rCod3VZ1+joF1OOh7+SDVHGPvbZ01j/4Zf?=
 =?us-ascii?Q?FCc2MtPDXLIyOvvieDAcHyyKG7ShWkGqYQNTaLXCzfuUQdq/Bpjs4RvhW7GC?=
 =?us-ascii?Q?pc9fVb413Gcr2cMZpY4X+aQVergb6yCJyewEOqwwrbPyJmKhXhVpFe3tOzJk?=
 =?us-ascii?Q?hXatxCEAmgJ3vhj3NjngNbPLm+viwZE0MYjTHTZ8KE6nEmW9IelEWGthhbzq?=
 =?us-ascii?Q?IUaMXJG0Bzcnh9TUrwSPWBYu3INHDbeRCHqNNLB6w00yozO6w9Ccy3qJZoIw?=
 =?us-ascii?Q?YFg8B0mmc0arjxO1k3+CTYn7g83vDHznsgFJ1Z9p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fa74c7-3ea7-4e99-5d62-08dbaddf101a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 07:09:36.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHAkXa4ODM0/IZQqFanmfsVHLNK8jeIJaIJHmVemDsUmOJpnqtBXxCf18A8R9zLloK/mKKO4/7wKaFR0PMmvVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8058
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers,

This Patch series contains following points:
- code implementation of Mandatory features of MICS and MICP.
- code implementation of Unit Test cases of MICS and MICP.

Implementation of following features have been handled in this Patch series.
MICS-MICP:
- MICS Service
- Mute Characteristic[Read, Write, Notify]
- Configure Mute Notifications
- Read Mute
- Set Mute

Unit Tests:
- Implemented  Unit Test cases for Mandatory testcases as per 
testspecs[MICS.TS.p0ed2.pdf & MICP.TS.p3.pdf],for both MICS and MICP.
- All Unit Test cases are tested and all are Passed.
		
Thank you in advance for your review.

Warm Regards
Nitin Jadhav

Nitin Jadhav (4):
  lib/uuid.h: Add UUID(s)
  src/shared/micp.c: To implement MICP profile MICS service
  profiles/audio/micp.c: To implement MICP plugin
  unit/test-micp-test-mics: To implement unit tester code

 Makefile.am           |  14 +
 Makefile.plugins      |   5 +
 configure.ac          |   4 +
 lib/uuid.h            |   5 +
 profiles/audio/micp.c | 340 ++++++++++++++++
 src/shared/micp.c     | 887 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/micp.h     |  83 ++++
 unit/test-micp.c      | 357 +++++++++++++++++
 unit/test-mics.c      | 317 +++++++++++++++
 9 files changed, 2012 insertions(+)
 create mode 100644 profiles/audio/micp.c
 create mode 100644 src/shared/micp.c
 create mode 100644 src/shared/micp.h
 create mode 100644 unit/test-micp.c
 create mode 100644 unit/test-mics.c

-- 
2.34.1

