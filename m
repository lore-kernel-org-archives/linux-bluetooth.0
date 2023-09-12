Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EECCA0ECA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 06:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjILGzq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 02:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjILGzp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 02:55:45 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2202A10C0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 23:55:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEKQaApAN2wGfaU/sIzngT1xOJVWOlviIhwFsGh2p4vEso0ppIxs2raph76iz9ip317rSndyc1mjvOFYL0YhqPAusg3hbB03P/WS8ByMGWt/jVq+J4G5THcfw8SaGPjYAwR0GKIBfPT/3Y7Svc0v6Fu26uQ+7i0HRjGaRWFiiDg4u48G0c7wePC91dzE9VyG5bRumUKr2oocEy1fCZOcg+JIIzNrsVIBzMm0RjJy4JgEll2vthMTyLRICZz8swcZkhM4zhZk72EGNFY+93qLGtC6c0mYaOONcGanQzDxyKNPpES6kSE//UutFwkGWJPJobTsz2OPNYJ+c7X1nxsLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJMwPSQ/SPAFMzgkbEyUOBCF7getvmQG/d0BZ/wzTBg=;
 b=IxiQ7etucmnXg9g0ufWnvUJAFMoc9uLcilSjWjb6kEemDknbyxFnpboexQXZbfXaa+4QV7VoniAlnxLfjYHWAmrdlNqPMhGdUHDlqWmWvUxu+EkyVoOWx7VfYenKvY8lcEL7oCsKcjCrC1r+iobJyxDeTzMnzZkiNVpIOtWYR+MCFdeMevNY8Y49wS2V8WMtN+wH+dMz0pGqR3Mh4h8qkOIWQ3v9zMVfqgrTE4SeSM9xGX3Vh6UYx63ToCEKygQImUiElhgXThByW2Jlw3qO9sh/8+KmuIbhk3hJwxr9yJGRXFgJ6e5OH0aclDoPhUfF4q+PkGrtf24Rawg8Aq2BPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJMwPSQ/SPAFMzgkbEyUOBCF7getvmQG/d0BZ/wzTBg=;
 b=Qx0Pp6OHa5genEXZrpJfGDHW5j79nCN5xEwNUvSVfXry4PB7TURxo7WCS5rUzE09PKH08yNiWiNh79g7W/vuZxjUb7LydMBbW6u8md463GH1BN4Pg1dRoIFFhpQN9KUgeU/tQ9GM0s+xYPGxN8kkVWdF+dpNkkmZH0oO6tYgmO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by AS8PR04MB8532.eurprd04.prod.outlook.com (2603:10a6:20b:423::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 06:55:40 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 06:55:40 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v4 0/1] bap: Use defer setup when syncing to a BIS source
Date:   Tue, 12 Sep 2023 09:55:25 +0300
Message-Id: <20230912065526.1217334-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::12) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|AS8PR04MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a2801f-48a5-4254-20c1-08dbb35d466d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWi741horJrdz8Ap8+ELjNgu6dpiV95XUH0vPqlwd2hlRVrQIEhWqjMPrD+LkCpV4t7qmAVIGXTIm0XI5F49a7pA35Ko38qGozQ83NL5Fax6fZTm+rYLuuSshC95bO14mFzSbPk54DhZMCgCUvm9phKoNW0t9us2fK2r00+sBVR1efXdwsRFyxW9QKnFeCYl5jiV3SaBkSFxpS4IsFVQ0o27i6ZkFpoCg0iGJVVBjpqyHf9Q+5Myc9sQ1otmstYJ9mH4i8g7HEQxKmlD0YlAbPNYdIcf48UuEFCM2nkuVkwb7JPk6cnYJT3E3gXa1A9uu/5NEJTC5rwy+m64MsJ/kADYBc1vJqzhIoKbKyZxIBRryQmUYH3ij2cMxHtYa0mfu0nzUwvX1nsCHU6QrLIBuOTiWHLKP1fqAFWAG1H1dI0R0odbGul4U1mJP6mRE1/Gwf+TJ0pE+sG3Cr3QTutic3np0S6sxDscAYnPW3mzn1dIJSAjBUkCn5G/r2+unfO8luOTTBMLq0auN9gWTjWZ/lzrW738eg3+fPHxKFTQ7ZrL/+PD8oHt6AGBnwry84AMwo8t0bJFiWfo+x0tNRIDbsa3asJwOQ3a38q4wgTfGailekPlYcpPvO/3WdsFmpn9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(38100700002)(38350700002)(86362001)(8676002)(4326008)(41300700001)(5660300002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007)(4744005)(2616005)(478600001)(2906002)(6512007)(52116002)(83380400001)(6506007)(6666004)(6486002)(26005)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vCOMTmRK3hWGYm8rRthd4+Fpp4zxjhWenVb3jIhUe3cE05OPXs+rYYF88DlH?=
 =?us-ascii?Q?yRwic/edIVWu63dX6dBQm/d7kQYpsZf9QTq/Dyyb3ztR4E0B7TYqFN6WuaiA?=
 =?us-ascii?Q?04RKi+OZOEgdMQ40iVl9ejJLKC95Fo57jxHqg5A4HSE5Para/jHdRVtyMUHh?=
 =?us-ascii?Q?lWKcrqRtIeoYw4zexukwvMSUOLZR5HatwNtRzInjNptzc94L4S2WI6M9ggef?=
 =?us-ascii?Q?RrEwkkqXw0iW3FkrazYBp2tpg1hh0HzpCH8gb8BZ+B5IIpiYIomYFI1srxyT?=
 =?us-ascii?Q?X/g/7mq92cMUsLXPuxThu4jhhfnVJdO8z6aQcu25xEw/ESw1GRjpZi96/u60?=
 =?us-ascii?Q?ArFUMIFOmcMXyiFZAs35kOqNmWWc9HA0dmc96nd0t03NLEnfn314o6uEnOoW?=
 =?us-ascii?Q?SknvztZpW0naHCO9Y4gLdZEnZYBu5uZgXeMXYKUMlXrxAIl/KWDddjHwtL8i?=
 =?us-ascii?Q?AO91jNc6TvveXmpCIxBObwqa4+fzxhLYR0MPlEkNUIu2sxE4nknG7DgAFsRd?=
 =?us-ascii?Q?Iw9GNRkN8W9z+tZLfONoSqwhR7zxa5mnZlJJZbbAuB6ppdIRY/IieU+MbpwI?=
 =?us-ascii?Q?m4V934Xdr9s6sat1HhyReXoiUEYq3npcMRxEoIK/2gsePK83K++ZB4T0szg5?=
 =?us-ascii?Q?UVH7FP7zMbmh90hfq09mLEMw6Z+MT8OuGcdkd5XlOUyul9RJbKicU+gGJEk/?=
 =?us-ascii?Q?ul6N16+2FuQwIqwVPJ/6FTURN6sVyDul7xFmgA7FZk4pnhB5C2O64zQLnoMR?=
 =?us-ascii?Q?CEKPC7W2QmJ7EzslC/wF5homKm05ru4N3GDPacTmMHTTv+K2PjHpAnH4996+?=
 =?us-ascii?Q?y9HR9EFZm9uuHlnjjJ94+wiAuRWysBddvralBmZS+JRDh5y3IC8nehH3JCTO?=
 =?us-ascii?Q?LYQcmoR6WTlcvU6G1shPpHWLiQEfyaL3VHuFzZoe1SGBcQPFEOhjPHQiM3GO?=
 =?us-ascii?Q?5OiZJEr13MRiz1CCUYbFyZ8HV40S9zhZ645BARmhJBy1i3ISVW9Lis0e8o4s?=
 =?us-ascii?Q?YlfPs2Mg+TqFFDXf7btxnAO5DpntM6HszKPWX+q5ZpRY2rga5vdei7QMvviB?=
 =?us-ascii?Q?97esj3aoQbN40UjHgCcNHdrO+Rz5uZx27fGl1uAaHBew7J+L3W0/+h6kSH3c?=
 =?us-ascii?Q?IfjxY7DOpZHZaHJA1qThI1W1lSB9jE98Eb/ZagBEzCh5l11BP8OKEBI6vtNT?=
 =?us-ascii?Q?oDMA7QV59mxWEewjnemq1IKsfHzG1vM+GRt1xVuvPTl9LxWt8u78hSI5t0sn?=
 =?us-ascii?Q?Wlc5z54DfeWShVhQBJzcFPi0o4W283r0HwhtBPfa8ukWIRwYBu2+rnA/3qds?=
 =?us-ascii?Q?TxYxYLmYfRu9BccG7vbob8EVF0mV7ZAi7W6zEudEs47cIv9LyhW1RNUk1zsv?=
 =?us-ascii?Q?kXZHhzysiYP6gQZBRJu6rn8KMo0crELnwkab2pSzxGOdekkxWkRoT08Xgd3F?=
 =?us-ascii?Q?JiStup7sylyqIiXXermo5L9B1uO3GIz0O0zPxe2yCH3NLABrP5cfXn8d0u4G?=
 =?us-ascii?Q?wa1BczWI4Va3+Qoez+fleUR/hQh5VOTKE3l9u+lfaa92HeDJc1EbpxDvVPd1?=
 =?us-ascii?Q?xBz1hGF8LVFDZZM/Hrax6QON9N0ZQjF5fcc2pFlwCTq2k2vjyQvfGRe8ypum?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a2801f-48a5-4254-20c1-08dbb35d466d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:55:39.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbJLpXjlWB6VLmGHKNepAPxZOHjmj2jSJCr1TdBGfTpQmI7WsoiedlmS0woswTHTRekzw9/JSDDKlaQzhDryvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8532
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit uses the newly added bt_io_bcast_accept function from
btio.c to implement the defer setup for the BIS sync process.
Now, information from the BIG Info advertising report can be
used when sending the BIG Create Sync command.

Vlad Pruteanu (1):
  bap: Use defer setup when syncing to a BIS source

 profiles/audio/bap.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.34.1

