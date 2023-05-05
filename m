Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA100C77B75
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 May 2023 08:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjEEIf4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 May 2023 04:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjEEIfz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 May 2023 04:35:55 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814EB46AD
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 May 2023 01:35:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyI4ABXfZSnYgMME/yp78Hn8XRtB+jzif/4uiSvgdCpjVPa4kmwoYO7xNtcbTtXhqh3iqQ/Z0W0h264G2IK0eDn6EfzOZTmx8TuF5Mhp5xB9ApQDfwoyMzI/9FTU9gailrZlVmGqfz2fB5rsxCPRdvZ40NludwKRewSp5lkegxATOoHevijC4aXHGdvOmYd3Y+dZeOLbVtD0CJ5r4z1m6XYjqzJZUOk4RrwuOvInnSfUNNIHQVqaR/YilrSFG457tO7TIC+khpnpj720DNn8MiZI+v0A6A2u6+4S9is8eSWUghG9nqX8VS85urUnvKXG4E7gmgrb+nxh2a5a4ae0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ssDhyjJNsA/drm8zQ5CH1hca4s8RZmKr7NGrHJmrUw=;
 b=NcZmlrVIA+v++jYaFaDmkfqUBH0P9lmJceMN7xncnz3XofnHsjVNBAfu7TwGDEBt+vypKLFCyJpmB/Oz+Cx/kfk1+0GCAeIUuo0aenNzBfCrWyjoV3y+qh70gyXaNyBPm4Yz+rS9VtaKXZxhdqHyZgnfzIwL7XtC3pM7zFVLvQjEabPWoy0jrLxPHVgxd4SWX/qGv3WRs+xvsLWr2FwLjlQwurnjQ6ZzzCwBLWsLHfgJAk5k3/7fLSgzZAOn/O0tKhsZKE7xTdaWZOvoWnZ4r24JO2w9AvLi14djt8W7OnWsTacmOJATqHeg/Sas9q72VSILle7wH5qzjmp2tn1JmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ssDhyjJNsA/drm8zQ5CH1hca4s8RZmKr7NGrHJmrUw=;
 b=UgE0u6YNLizxie2p3mxr124AzTXfUKdA0b6Ny2PJmEx6Wdd51RWJ0LRHzIfhX0VMLg3M3709uOdMBViAJL+BejVdtX27mGy8IGvOUf9v5J2zQD1uAyh/8da6izDzMhx1FubiTNbDgBrf7lLnx+f51Ad1A1K1GGTU073I9X33fsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8101.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 08:30:19 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 08:30:19 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/5] Add initial code for handling BASS
Date:   Fri,  5 May 2023 11:29:38 +0300
Message-Id: <20230505082943.92033-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:205:1::49) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbeabb1-adc3-4034-5704-08db4d42f5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4TZ8lQQ+cZvvgoLlDcIOoFUhXpP96EQAQUZND7NhT4pgZsafzfKU3JkNZvNBhMwfJje94mWtOFdcTcJCCpWmqMvfbwpT0EJvtwFP/YPJpax6ZVvdqP2MgO10k5QiK4fnFL2h2nAimrLRfR2VXQVlY+A1V2vK9/H3UDCiIzf2VD/HAlT/xu+44CpuXNCHSftbPDjxU/i4r+ilyMctEP8klqzKEDdB4/w5Lvc9F5PG6BYTY0Y2TlIFVYQCiEsslhYAg3QB9icbMRBX/WEa0gw3kpCE37OuKukZWNzya7K3/A9AJDewOkC5e9LVkwURTnO8/NRERFrwfq3CXNwW86dT07RxoQqGcD+mzylFM05+DExsgVWelezEEm6/rQ6+dreuvMxGMFocqgIbjFTBan7QHP1O8R6EwER7fLINlDy4iSsP1LfL8MFqqXEjUdm7coU6WuauiQ4Rz0sY/vgbGrGYqHBbuSaa9nlHypQPSf7yrCY1V5KJiIz7iKI9sbKpU0wMPFYCEMQht4JjTfqJtwSDtR2YNLGKbguUzMa3kKRbejhd5ymD1aOIflGKSheKljC8x65g6d1M66Ia5nG5Y0XhQuFV/LNHWdVqSGz0WsXvq/WtaOjs5zzfpZ0ZHxaq0iUD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(52116002)(6916009)(4326008)(66946007)(66556008)(66476007)(6666004)(478600001)(316002)(36756003)(86362001)(6486002)(83380400001)(2616005)(55236004)(6506007)(6512007)(1076003)(26005)(8676002)(5660300002)(8936002)(4744005)(44832011)(2906002)(41300700001)(38100700002)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mb8lg7Ig4XAeNh98gFN39pxeE3WxG/Wh+BDUVsthtQHRntBxJb30UHRIYOg0?=
 =?us-ascii?Q?TZX8jpgueoCIdXVoDFqBScTOLpNrvtazEtBO994+EAQqDEgHiLSJzCgUw6sd?=
 =?us-ascii?Q?Z09tAuaKk49Gq8nbI+O4o319QkoWE9YMqdiGf3UqDM+Kcc5YUb1ds+EYby1H?=
 =?us-ascii?Q?SISYLoAL+hxftSiEqsfHvj+McLg4jjdhKiaw0gkTirZoVwDcewanhyX9lvhb?=
 =?us-ascii?Q?WizUZ+7YxLGiF29pzFD8XD6C9GD/1tRFNoKvoBOJUxH2WuJqkvlB3O2Pn/l2?=
 =?us-ascii?Q?qr0x4Qhfzgznq2HuZEpYlWSf4EIF83aMkT8QZxHRX+bZSYNFF4CqUNxsguQQ?=
 =?us-ascii?Q?ly6XAfAXti2d1WDMcW4vV030tTL6627o/LIsnTicTEsXwMuTvRh4j/fi2xbW?=
 =?us-ascii?Q?d0FQ/3aOIDA5pJBmIQ9GpLx1Y5al6wmT1M2WnhPPq77nX3iPVBSjUMh3cdr8?=
 =?us-ascii?Q?SyimRzJWEL3n9tdu2ziw1LUwcXb9LkZ1DavZV1Gp9bPFHuBnvml5DxkExLUi?=
 =?us-ascii?Q?Od4ADXGQr4exqr0ONYi3qC7WrW8Q0Bm2nqPg7+PlJIiwDgvVQoyHu+NR9hh6?=
 =?us-ascii?Q?jgpDSLzDIdK4vZPot349qwgeB5hI/9OEa0fY58DWGePYjZjVEjngw1gShRos?=
 =?us-ascii?Q?kgc2ZTmjcLyykgBcHGAKKaVy8nuNbuNt9pf94Hpijv8mMvKsvWRkkDS3euUP?=
 =?us-ascii?Q?ox/9wId40gOKCv3Jl3IY8abfkQtq+5DJbgEuk7ACVcnUJNmqHJuowQa4Ke8m?=
 =?us-ascii?Q?BluZFgY42YdrK9mOmmUSZZAYrXsA1JIz/kuDKDRE3VmR2WGvLlA2EeOYUBS1?=
 =?us-ascii?Q?wlfPLM+DkTFa0gIsYdkkt0zG8F25e1q5EaljQC8PBst2nt7dFbnIBEd2aP+C?=
 =?us-ascii?Q?V1Fm0JZTs9x4dXRFGk6/aDqJO0AeIb1CDFGGwc+K22nfeF4KrKosJ2mSKiZx?=
 =?us-ascii?Q?2vhCGTRKkv/Kc/F1+Qkb5w6PsArDT7u6XBQEySQ6nk8jKQL88TZoWiE65nJ7?=
 =?us-ascii?Q?rae2DJyowPSItfEXSfY+eb+6U4kMlYI88U546a0DwCEl40KOjf2/1Z8tDTUo?=
 =?us-ascii?Q?pBqcOcFOo4M9Je70K4Xd0Vh1zlwbAaZTNYJrtsv1qJp0vZO2PVGOOAtielo9?=
 =?us-ascii?Q?z+//uqbkUQGYZGFh0tgyTBppm5q3ikoM6PmdJSe9WTeGxMclPv9zGaB8DIKt?=
 =?us-ascii?Q?WvAGyxVGYfdMMAS9Ov7HQTpGEjCqfgTz3g2J44GNpXBbAsOxeQWq/E1yYpFQ?=
 =?us-ascii?Q?qrPi2CiNg7onTI/FGu0UexWWVs8+jViQE5rO5Gt1A6+p6SsyLJXzGFeeYbgn?=
 =?us-ascii?Q?7j9jMnhTr0CjCoWC892R64efP8HIITChRGTJMb3p3zkuapgzChwDXGnM82Et?=
 =?us-ascii?Q?8PfabGZyjQJinRtb4VRE+b48HC063BRa11DBbNUSuYieeJ9D4JO5Zj+wjIJh?=
 =?us-ascii?Q?77kuufkXrIRGRgzsKFdb6HZLI7zHAbC6kVMTT8YWmO5wye4S9wVDgLwUAd+n?=
 =?us-ascii?Q?zywS7d9a6zJy5z7fG1tZkRg2QUrhCGMShwgrp7ZVolX0EA/QpMsiKUM0VZI0?=
 =?us-ascii?Q?Y31eugie7cLAIHljNgUKARgFc6MGZpXbOutK5iDP2CoHjXMyhEvyL8vVcDlG?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbeabb1-adc3-4034-5704-08db4d42f5e2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:30:19.6622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULh4y7iWxi3aXaftoIS6u6OdzYn/gioYbkuYQ5lmbOdZlRZ+pl3/H3v8Xp1arzhKZxto7bLD3B+lKDautE/7rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8101
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series adds initial code for handling Broadcast Audio Scan Service.

Iulia Tanasescu (5):
  lib/uuid: Add BASS UUIDs
  shared/att-types: Add BT_ERROR_WRITE_REQUEST_REJECTED error code
  shared/util: Add iovec helpers for pulling/pushing le32 and le24
    values
  shared/bass: Add initial code for handling BASS
  profiles: Add initial code for BASS plugin

 Makefile.am            |    1 +
 Makefile.plugins       |    5 +
 configure.ac           |    4 +
 lib/uuid.h             |    5 +
 profiles/audio/bass.c  |  305 ++++++++++++
 src/shared/att-types.h |    4 +-
 src/shared/bass.c      | 1012 ++++++++++++++++++++++++++++++++++++++++
 src/shared/bass.h      |  122 +++++
 src/shared/util.c      |   53 +++
 src/shared/util.h      |    5 +
 10 files changed, 1515 insertions(+), 1 deletion(-)
 create mode 100644 profiles/audio/bass.c
 create mode 100644 src/shared/bass.c
 create mode 100644 src/shared/bass.h


base-commit: 3818b99c764efe84cd3455081f6392c256564085
-- 
2.34.1

