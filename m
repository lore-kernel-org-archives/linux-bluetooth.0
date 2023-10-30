Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCD3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Oct 2023 15:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjJ3PjO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Oct 2023 11:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjJ3PjO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Oct 2023 11:39:14 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4E5B7
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 08:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMAXB6Ecf2oW3R1P46RtNE6f16RfwBH4isOT+v0goUM19K5sxL53TNJENS9DwPqb3vB/MtmppckQV9BjieNHjoBkDykIbRGxGByOMyo0Lr7SQ7dSCgxs7+Lx1L7kVTUZAPH28YCay6bxV6IvKMAxdHACfxcp9w6ZVEsRU8zEL4MkBb2G8FwC//P45zz5aZtAYiRVcAAq6xVaLoHsJPJ5elw1Yq0oWEciINDn7OVLXd79PEesm20L1jNnkvtVI5x2EYbF+MlZEDpoKaqpAjQNHb7c1CD9Uz6fptmhqxarZsTSgKSvf7rNGMrZ7RT3WtnInngf9rp/2PWoMyUhb18MXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJpU9bfiDUD4ZV4NsAi3KH2NwzwlzYu6WlrUSte6VNU=;
 b=DRQgIsNHPpvTmTMtqLzg0uxxa8KS/6hn176V5cBenBkC8dKGB88JLlyaemBHRoNTm3BDYIdgwHHOqoQw68S68+yNyq+UrivdTApQq8POTlNMF8fD+aJ9BKMAf83gHRsDSxbw9JnuvHhjsO2wYF8FhmGZynsBHb20sLbw6Ml2t2/j1SucFeScrbAn6rixSMGEvGOWjhEhXT0LoEest5p3ZIts+8tmgk0ik3aLhtnA4ldsJLIpV0IC7YA5fPHubBgrIHYzMF54kB10EZ/MZIT/v9wLh5ebYBcfhHMNbDw6FfgVLEnGU7Z2pBYYYzIX5jU2zK0uLg5r745zec5fBvJTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJpU9bfiDUD4ZV4NsAi3KH2NwzwlzYu6WlrUSte6VNU=;
 b=AMcuFVb0cd22vxRfVaB+M9PeUmrk/23RzUytKx4FjubXXojO1315fY8GtY7YM76O4BdhnmZ2jIh4tFhEHKSTQ1sTGi+AUvcYiuDVSpZQZAhHel5fiVAx51PwKU0MWAUN71mAKKJ5FgRD2b+Q5ukmQwav1XmetyjYcnX/KGa25f0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 30 Oct
 2023 15:39:08 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d%4]) with mapi id 15.20.6954.014; Mon, 30 Oct 2023
 15:39:08 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] bass: Move io handling out of src/shared
Date:   Mon, 30 Oct 2023 17:39:02 +0200
Message-Id: <20231030153903.4248-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0021.eurprd05.prod.outlook.com
 (2603:10a6:803:1::34) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a176a31-8f89-46c7-adf5-08dbd95e5af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sAxNXN4MB0BCUVzxSvIVGc3U9FKrL7YNYaEP2dGrgVCxJsRRDa2xmHPD91FD64zCrkrdwGb6Y3TL+KMVrYgOximkUuijkweQvAN7m/yIlc7k6pTyGWcSLXcpLvX/bSDBvEYVOToXP3meaNk1Si/ctnA9hWpoIAk6zm28Zr4lpKKM6vdjnuUeu/FhSOh9G8dRMpo6Mnel8+cvOKM12aTHeTG6noAmvOX2kXHH6yu9pq9ANtrR5YM2XLPqIe9CUErEU07YScMWmKiuBbdEtmcuQd+DysuVf6OVZodluEKFvs8ZyJLM0BRRk0cQ2DOSqBGZHkb+41F1L58OB4RjpA7Nn7VeOI0vyLwqlFfIGmKFuEgipCZDHfc3ecA1ptlGIM2kgQZGvWx8sF8MpM0R3uX332h9MuVR+G9CpBm+eXaH8DimMfJKGjR72rBRMgDmwG4fmSg+kd2bU4NsVym+DXinQsymXn0UbiKFOwGsrpyN/3gAGlYEOVNjldL8MD4OEBnr97o6Q/KBegvH2I/8hEv1dzwdqohLqEAdXqCICggBnhLgsakPkwGv+3mebnuWf24
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(4744005)(2906002)(38100700002)(8936002)(41300700001)(36756003)(4326008)(8676002)(44832011)(5660300002)(6916009)(66476007)(66556008)(6486002)(316002)(2616005)(86362001)(6666004)(6512007)(66946007)(1076003)(26005)(83380400001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8z82vcr03IzydAMt2CZkvsSJkINCaQPferjudvSjy/rnSe0IL0IXMUbstSRJ?=
 =?us-ascii?Q?HzU4L5+ueYVO6ZIjI13BoTqlniHtZrxVI6DZ2P0hlAY9JUF0yIKRy8ZF1eG/?=
 =?us-ascii?Q?vwDp/AGZz2VgbUWUx5b736Q9D/dGlvoOHkIWZrBWBRx4PndzZSYSbAFidb4a?=
 =?us-ascii?Q?lZOROz53EA9pFUIzHRpNKz9+SsyfUBcwoY0mlqJUHmQpAD8RudIKAeoLbd4c?=
 =?us-ascii?Q?Op6RQUPKYGM7PswX4HGzDHaeANKGbG570fLnpDSLPb8k9dmG6bxP+YuzXF0O?=
 =?us-ascii?Q?cUQUDY9oiCBBNPLk8Qt7UppRRx+k/mn8xVGp/plchtXT4hUGMfKi2ZiIKtZ8?=
 =?us-ascii?Q?0PK9hUxUSUeJx7mm9VPlX+F3yOM6b+09PCH3BNhSvb069mpMSL+5cJ71D2vz?=
 =?us-ascii?Q?MQKzecCwst9P2tvYXOGlg7C4U9FnmLSaxYuNm3i7cqbBdS+gUGg6SZu1s/aq?=
 =?us-ascii?Q?ASrMofwg8pQYBctuMtYyeDj+qTfOPmT3Jas3CRmx3vWPIFV21dKNF1Nhxqq+?=
 =?us-ascii?Q?06+E4N3ZDXjJZ7Ik5d2sLGhgHcq/+ca/rPYuNag/khsqJ2gZOh5pHCjoJ+QL?=
 =?us-ascii?Q?g1Ac70LG5gbS6nsg37nm8aPzYgVsgRk4ZxwgsCXuXma8KXLuczkUM79cNh0n?=
 =?us-ascii?Q?bpx6T1Lo858ECcYvT88jdM1pD5bOGWZOgwjNGfTtkOi1h8Wl++vX4TUQaQ60?=
 =?us-ascii?Q?AF+seYrxUQzk3bzy8LSAtq8QXSELpcOnmjPtYQRr77qCHVSwwOblNA8pq1q7?=
 =?us-ascii?Q?qAYCaXazPs4epAaFBclzbvNr4lbJTqdSYYj1Jh2i2HE4iOMLlnxHm6lc7+UH?=
 =?us-ascii?Q?R27ifiMskVa1D9zb5UzZ8GaQHHM0aMsaraAVOHps2NugXQpUx9kOSkj7iPIy?=
 =?us-ascii?Q?qc3oQQszbu9Lb8Ft6YRTRlU7sxP9ff1eXRQK3MxEsTvWzXd8vVc1QRsRoOIV?=
 =?us-ascii?Q?IJP5HxH6g88Lhga1N+4FyxMsB5z/iV2bslGUe2SSbYAMdTA7EIS91r6knRRb?=
 =?us-ascii?Q?joiAQXLpwPlph7i6+Slb2A4r7yjhOZ83UmYuL7u6TkkljEFeBJeNT0+uwY2+?=
 =?us-ascii?Q?EK51OJiGWksS6o+x6SE3csI7Xlf46Qg4JTotmj2nCnT6lKHSDcUrBvRN0KC0?=
 =?us-ascii?Q?e3RIi2Q59G2w1Bz8/Uvy25BQNuR19j6Issae4Vuq1uBwOhhJu2d45Io9d+RZ?=
 =?us-ascii?Q?hVFUxx8B7j39R17UBefztPmpy2h8YTkoWh10uYwcWqE8G0PlH94g3PVNQadk?=
 =?us-ascii?Q?j/U06HQThhyRPW6a2rQoSXNEv0ikjGI52PVuaMqrQ04F4fnKZmaFHHBCzpmA?=
 =?us-ascii?Q?7C//7TygwXuUDsbqarQtW0E4W5MBKirb/cx2hgWLViOz7GUiLGmt0HpQqcGT?=
 =?us-ascii?Q?mq5cTWroOfgq75m1QV1pm1HmJjdssxSqSlTjHyo35BBjTGmpL86Yqjx/JKJ/?=
 =?us-ascii?Q?K52BZJS0BB3qu484EGcAdgqoXYt0I8+R7UZBoGpomiIAXCGme4h2hoMfExof?=
 =?us-ascii?Q?qrNv9Y4DlYI5WG+/LAt+YOFOgU6kG30D+MNgJGv4c0SLH1gbwheMlWA3Bk8C?=
 =?us-ascii?Q?aJjL8K9aDoraYwZlw7NQ4VPen9FhXzar6QemSI4ZOrgvdpFWVJ+yR/eoWU9O?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a176a31-8f89-46c7-adf5-08dbd95e5af1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:39:08.0314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoGFkpEWIj7OPtxA6DcswSesDX9doQbtMqvYuhM1jTfhR/G68gSP2Fzud4CxfoZWAgJWxurVqdaZMMNs64v0eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch moves IO handling from src/shared/bass.c to
profiles/audio/bass.c

The profiles/audio module registers io callbacks for listen and
accept with src/shared. These callbacks will be used to perform
PA/BIG sync and they will notify the result back to src/shared.

Iulia Tanasescu (1):
  bass: Move io handling out of src/shared

 profiles/audio/bass.c | 397 ++++++++++++++++++++++++++++++++++++++
 src/shared/bass.c     | 435 ++++++++++++++++--------------------------
 src/shared/bass.h     |  23 ++-
 3 files changed, 583 insertions(+), 272 deletions(-)


base-commit: 00fdb61d56161f523e975b4c044030f4b40abb6d
-- 
2.39.2

