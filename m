Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD468EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 07:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjFWHr0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 03:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjFWHrW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 03:47:22 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2054.outbound.protection.outlook.com [40.107.15.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1591170E
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 00:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFMPPoTOs91yfM/KDO3HUAPZ0dhrEI3Nu5XghtyNSBBZ9qC8YvthRBJXjhfY7/I3ZcQ0tvI9FPcU67dcmVwB3GchZttl1ce8uoqQXW1PBW7mbQI5zA4AH27XoAU9B8nrlp0KIqYPJUor+nFGnGkJwbtLGtWw+D9avj+FC7D+1YpaSUZNsyQlJsxBm3X5UaIxqCzzVi229gCKgABmZB1Xdrafabay5fY1ZsLLRJVF2NpQ0ZGstAPV2TXeUMhoaYE4ceK1+ymVuqdpaD7LeDFtxV4Ck2VhhBPLBQBD9JDrM5I+WE+7A0KH/oqJNf+T56kiCl+S/Xwmher2KLFXp+TYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pffRSiXZC4cEJZisEr+bYSuhnN4C5yXHs9bc9+/kq8=;
 b=K9MRJod9YDkaKqHaTXeMUqTdrz2QAIP0PNcJNyDM9b8ZXZaTXVGtS8Jq/TG5PLiSSSGO4MTb+DepBj6mKPlC4r7/ffPN86NFk0PSL72H6ffy3Frco0fl87vL+VSX0ptnzjBSBmhKWhAwScw5kTRwtW70SIwWhfGDO7UVpwoEjVnwFIT0pSTVzOggk7Zak86TYB2VBj9c4csw1Vd8AjYht+E/iOqed0TzdT+be5cnmTAugnK7mL9P6N/SeAIN3aWVumMIZXASDZTqNtNSbY9QwgjBT9cPxQHo9VgcrpFv9kSaQHI8tIlXMOYEDpuGPLrbKPbTPnCHUErBhhEXLnk2TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pffRSiXZC4cEJZisEr+bYSuhnN4C5yXHs9bc9+/kq8=;
 b=HUN5p7RReuoLQCftxTDqUbSK47AeTXKOlpFVClQ3Zqs/iJRH6wTHUI4nk9fGxe93WjrPb+ejioX9pC6ymWCnxYv5pswaxlGHBEefAxlkNaL9hA9RbbpSjyNP9L3FnkIdGTtpx3/dul2Tggvhu8XvTazoNyClamtv+/Bkz6GXXP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6918.eurprd04.prod.outlook.com (2603:10a6:20b:10c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 07:47:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:47:14 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/2] shared/bass: Introduce Add Source opcode handler
Date:   Fri, 23 Jun 2023 10:46:55 +0300
Message-Id: <20230623074657.16618-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0228.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f784d52-52a4-47f5-334a-08db73be0f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1iuf8tovA+p8YZeYKfCXiY/YxxWKN9Jh0B9rZpr7ptjsbntr7x7nbTSf6ZOXbgoRz/V0cHd+QOcje3igfiXKdM2UGNSFUR4TAe7zUQr4zJJt7QIbdn7D4omz4yGUUxkVQWFYYZ3MKPXLYS6Zi71mpPCn2Tm0uDtxiaR65SqhkkS9VRzugdCUDzWYVFNOdka69vmB1exdZYIzRsoGFoxFn/Punmfn+aNMKW87YNUoYaf+a8QxEx89lW/1cY6PVcNFCkzNXlVnlNOJXt8OB5IL6LgprojwEwG74K7ZIvIX0nt308dA7zQc3pbNtVrkj3koedWI7sGRIlLyvKNRODRzy+TPw2bslaCVCQnHLDNlklFwRNu1OYCQ50GjFRaIeCe7FNsUVl3m7xHXaIM/EBVMvmNeLjTnh+K83pwi5qowBFhK9GNBCEMINypGCjpK5pOg2fiyfqy9I/KHT+OQJGJtiHkhiUyCOrP0q9zPqwNfzxE6eddYbNI4pVE24mtUBL85o8Zzx/s9wNOQZsX9w5nqa6FTmBK10QYPmpz08ryxyOIqIBw3P5etst+He9AaTo0O3h8owgXZY6gKJ21dkfrt9hM4DZDhFyfB6zdCju4cznEOms6Hrs8As3hhbg85YDq4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(83380400001)(41300700001)(8676002)(8936002)(316002)(2616005)(186003)(38350700002)(38100700002)(6506007)(6512007)(26005)(1076003)(6486002)(52116002)(6666004)(478600001)(36756003)(86362001)(4326008)(66946007)(66556008)(66476007)(6916009)(44832011)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xGtnnRsfsYW9QXDnz5In0vXjM8WbawaoVeuK660IL0fSHs0QPpjVmPymffIs?=
 =?us-ascii?Q?EtKFebssnfdGpOBrId7RFA3ywniv+/WVXn2vFjVubJt0cVWk0wvXdixDQ5Jh?=
 =?us-ascii?Q?uWISy9Ib2/rlkRXnmm1c/EzlcoOvg14sWdlJDKVBZ3aPEeJ/qc1C2a09H/d5?=
 =?us-ascii?Q?8fotihfCrpu9QIPb4MuATEcpSAojmWcOD4uCs7Ff+3cGoa0aBcdvytyj8lET?=
 =?us-ascii?Q?odt2DzWyDN+6hkAVFVp/nw+3x3P4W9TXOklGfUQWRK3INjQKIgUOLvkdfFsi?=
 =?us-ascii?Q?B9b/Ef8+f6Sz05UssNI2nztbiGimEl0ZXry86euGND6NY0nRMZsGKwlP/Uw9?=
 =?us-ascii?Q?xc8QMWYxmQMsp5GTNFNqiOzgYRSZk8Brc8GtYdK6Kz3PZml4GFcA5aS+/BPa?=
 =?us-ascii?Q?pD/29tduX/OT7zEyQlTwW8Tahdewj5QZ4fzQyuLdMBygj0OEFSEy81VrgHB4?=
 =?us-ascii?Q?N2eSWmhzXr0ro0N+X0L58U7QBEZPHzv6WSEPlasrmQd7KsuAhjnL7+2bVNRA?=
 =?us-ascii?Q?6+5v4LtMN6WJwuots1ersFmRX9MdDXiU6HrcMXsQpcWpR4Ew8fgYapGlEsb2?=
 =?us-ascii?Q?2oc8CNJvF2KdbNbFYHK4A3twvDj3gK7ntt4s4MBdJigxN8P0Dry3EosP1dFj?=
 =?us-ascii?Q?Mw+APVzQKwC9mwpl6JbvwdSvrMY53m1H5dh5hJ0t5TgEzQ+UsjEJGGCLlBXF?=
 =?us-ascii?Q?NFtVDcodJszuIPk8ynasVbqpmAFVV18QAIrttvhG8NufY9WMnIyJOBYbqlNN?=
 =?us-ascii?Q?Q2XgG8AIUOf0AahfDGysX64gX3qGM1c3IAkq9NMlZPtPRlbm7jrIjlePeyka?=
 =?us-ascii?Q?aLTrF5lXvE41oPCUXr/Eq15xLaGNvg/lgyukLQwSJ3JLhlIENeXS1xP6zho+?=
 =?us-ascii?Q?ZfUgNZSH/H7MD29XMyVOscRf0fHK8wS7Q9SyRKfaHz9nMGSJWZoO+8D8tIiM?=
 =?us-ascii?Q?PigTmZu/KdjNUSc7FOSxUFzgCacigW6i/TyITij8qMnkKdwp5Z/5lN2s/mNR?=
 =?us-ascii?Q?Wo6L9IF/nG7IGUBFuce01Jb/IhU0+qEgd+rHmUbldmdOYJ3dSyIzqG8ViFuq?=
 =?us-ascii?Q?uY9+jpZH5BnVhTj4yMVZM7k2Menwbaxd0UeooI9pADvKroG0qY/wRPg75h8X?=
 =?us-ascii?Q?+yBDsMV0mZ9Pud/qC7TWtU/0u2XD/zBKUynAHo5UOTyecUXZhnN1Yh1eCRTo?=
 =?us-ascii?Q?2biO0CXglv9UotVCfqURu7WCVm592qZcidSpifSzeB8hkR8pAYwSTzvAu54N?=
 =?us-ascii?Q?ia02Z4sJGqyKI5gXdVAVAYc4UI8DFFxCKEcTAiqdctHFvVe8ppeHXgCeeru7?=
 =?us-ascii?Q?bjVs0/UZSxfjKj5hV1H2jcY08Q/KR1pIKCE9zL9U1W6IgEknilC/pFAgLmUn?=
 =?us-ascii?Q?w7LmW0Tcqe53q9k/whBrnr1CFLVl6Y/wa8vwa++Ge1yGuSW9mcA19hi7TirL?=
 =?us-ascii?Q?g/B2FHdCEdxxSk8Vh8geH4b+sYcnoJP1+5i7AdJohWgYJQLSA6mJieU9NqX1?=
 =?us-ascii?Q?xnpcG4/cDIcI6gqAjdc0RTU+yvb91m8ASLODEX2PiSlbXfDFQ7imvLsxoCgM?=
 =?us-ascii?Q?FG2J3cjzCJoaqKzWCAAfxLzKAUp9wAeTLf+uDXNfNRkF+2slGFe70MlIy2+V?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f784d52-52a4-47f5-334a-08db73be0f68
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:47:14.4260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utxw9bqdA+YMvaim7JGJiC7WMmSK0UVPjd70ejvm/Q+ukUM8L+PJXbnC3kHwjPf3OxgKwv/S4YzJxohRDiQlJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6918
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series adds the BASS control point handler
for the Add Source operation.

If instructed by a Client through the Add Source opcode,
the BASS Server attempts to synchronize to a Broadcast
Source, by opening a btio channel.

The BT_IO_OPT_ISO_BC_ADDR btio option has been added,
to allow binding a socket to a broadcast address.

The BASS adapter_probe callback has been implemented,
in order to automatically configure BASS into the adapter
database. The adapter bdaddr is also stored along with the
BASS database configuration, and this address will be used
as the source address when binding the btio channel.

Iulia Tanasescu (2):
  btio: Add option for binding iso broadcast address
  shared/bass: Introduce Add Source opcode handler

 Makefile.am           |   2 +-
 btio/btio.c           |  56 +++++-
 btio/btio.h           |   3 +-
 profiles/audio/bass.c |  26 ++-
 src/shared/bass.c     | 424 ++++++++++++++++++++++++++++++++++++++++--
 src/shared/bass.h     |  14 +-
 unit/test-bass.c      |   2 +-
 7 files changed, 498 insertions(+), 29 deletions(-)


base-commit: 37042ca9c6ddcdbbb0899b3d62238935cd53f443
-- 
2.34.1

