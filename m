Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4646CDB465
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 13:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345827AbjJSNyz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 09:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345821AbjJSNyy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 09:54:54 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B58B131
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 06:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8un6N51a9AuVFvp1kLRVd0emAiCe1iTW7bNr/QQCcqn7n1mOh3Ua11Pwq5Vo6N4P57upS0L9/Is0PcVQ9AZrbQ+MQ0/fRmQgH9XKn6+vCJthj6slvcri0qDgiesBMDwyylKOQ5DBJjzg9PwpLM5RB0rqdb8TdTjTmFsr4RnaEkc6rwwDggqPatL3Q4iqAX1nMk2su++PTUBwySxBiWnE7N6iGeExyHy+Xeuxf/wWqBkEDfSbi3fyh/ON6vfYjROvuFPHnGBmP+1MxmiG6HpLK5mZOIiUpiwhknjOZP/4DPvz6Vj2vD4wtw42tTzKHS8SvYzyK5GyiMDVkTXKL5M0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+YLBJm0uoJk/r9cVuU2ezHaKeZjWmslcocv4eQbfxM=;
 b=cKa1q5qOOiZK7FuVC/3vvuTWd4R2rckuxVGXpfRYtup1hIwycZNgd2yu8yc427aoSqSEFomrl/uk25xZnRwJsLmgeCKZzBY1iNcv9YtEkQ8KhdXNRXVHGcdUNvtZvmRCSm8BnAXQL+eEjVGcfzwZIj0iuwXn9l+/HMtUWzK8OJ/FH1imekM9zD58lTKTBV8HHYNa9KyaInMPYIY6CjnaqNjJwCYksgBfqRQjVJJbD8S11ZtR9enJusSb8DHiBmM235RmKkxsfV+D7rrOYCuTJ8knEy6YaU/lvnkeMhr9FLPKF/njG0n9NLROl07v/g6XUryujoIODdsCZH1Wnf7p3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+YLBJm0uoJk/r9cVuU2ezHaKeZjWmslcocv4eQbfxM=;
 b=k9iQakab6YME/szJGKX6lP03WM5Z+kftuE1h3mw637/WfKMld9SkxY4mvR5MwnK3G90Y0eI4tsO/m8SH47zM+JToZ+5Ad63IZT5xGN0Q3TCQZEILkGGl7qyGTcmodTUg2nJPH1+HKbdbYZAijsZaRA0uIk1ke2YXFs0HG9Q/WMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM9PR04MB8729.eurprd04.prod.outlook.com (2603:10a6:20b:43c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 13:54:50 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d%7]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 13:54:49 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v2 0/2] Fix source+sink endpoint registration
Date:   Thu, 19 Oct 2023 16:54:41 +0300
Message-Id: <20231019135443.3806-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0035.eurprd03.prod.outlook.com
 (2603:10a6:803:118::24) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM9PR04MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d62286-42ff-4ce3-2b0a-08dbd0aaf609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDrMqvEyS8fyIMGqTIpT9v3b2Qqw6WMhxJMKMXanzQ86LggtRpBLkfB9v/v9XYLC2mr5ok8tLT2IIkvEqQ8GiOqNnBfflqoY+6RhVAMq8EYGBZT5/m5aJ4syYotunwxABQxNroTFb5P8OnwzcoNMqHZ2zS97gRVo3t46d6J+XQ/GJ10HhFp6fDVegp+awLZcxL2ObT2MyoL0bNFds/UbD20NGqUXDmrMQkxS9U0ihw9i+hCQisrgz4ZKrDCrxIB+MRyfhUcSJsEkno5EU4i8IzMWU1cUUt+sC50edc1dSfQPO9DK89EjS1dmcshYlxG32JO00GsCAkzCSLlZ5zqTptDxgJsk/kCrYYxmcHLTaVNuj9VON74p5PzoZHqH42LiDXSX8pgb3KfttAg0MMEMjkE9u8Mpnpa9zHNJZ256ypgpXYaCekPq0Lb+BdcYGSERGrhGcnDIuaFenEMZM0tcuyaIIGaoLO7Ju1D8YSkQnswWAwJ7UD9LY/U0vb/pHt8FXx6g4hz4ll23ObJO0ju7uoHsAQRkb2tDQaupELac2HM2KDPcQPQj1Hd78vGjC3B5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66946007)(66556008)(66476007)(6916009)(316002)(6486002)(478600001)(6666004)(2906002)(86362001)(5660300002)(36756003)(4744005)(4326008)(8936002)(8676002)(41300700001)(2616005)(1076003)(38100700002)(83380400001)(26005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tce6RGJ15lubjQrKPzC4ylabtxRLPbQbh8juuqflVxO3ghGWiEu6qNvIZ2bC?=
 =?us-ascii?Q?XuxXv3NNVSiScCRa4JBYGbLFgZKVc6qUGCwDBsSpB4S2jIrazMTkmUoWgerx?=
 =?us-ascii?Q?Jvxmmjn19F1YvYn++/cwVAu0nS+SWRP+nfeq69KCYrtPy42UMsoWs5HZiscQ?=
 =?us-ascii?Q?WmajxHURutiHykOEVAz+jUPyU9ZOnC5odbk1HSSSaaNzHbXeY/5MEXscJJ9d?=
 =?us-ascii?Q?aHcXxPCdTHYeEJRjRHI/za8ERULmkUZ49E382MVXMobCyHqQDnpyZMqnqu7O?=
 =?us-ascii?Q?bVaqo2ZsgLKrs+f4PxnMORIKfZ+SfHej3neWAtxH7QX+snjgNz00b17iD8mz?=
 =?us-ascii?Q?C8vdkB2FPI+IQTnHjuPOD78/tWe4LH0+/xKZbacKpqKLJm4QRQMSoczShJcl?=
 =?us-ascii?Q?KVqx57XINd/NfrK15flrmREHGycDkO8tD4/msUnNqtlGowZ1bIbYGnMLV3Sj?=
 =?us-ascii?Q?IaLae3+6kqvFjzN3Ow2VrhLQjhEA9cV+WWlpOtYOQTt4T8NudigPc3DhBZwh?=
 =?us-ascii?Q?+HjgxXRY8q6o63JZ2O1faTz2y9IWcxMaWiUB9T2YIoanCeByHSKJtL4WYQN5?=
 =?us-ascii?Q?L2Ad0jzOUk9QkBExhENV+qk0xn6GjJFYc55VkIAmr/ubEubPAiRDJTzZ5yjE?=
 =?us-ascii?Q?veD/UL40YhYun98joR4Jbh5CYlW3x38jTddKls8DevtKVu/d5dFvinfx8gXY?=
 =?us-ascii?Q?D71/s8elBjpvwMerjI/SarMurB0CTkXsZBgxey2U82DjKnrTEfwZcSB8Pr6j?=
 =?us-ascii?Q?YIq6roJH3F+N1CI9g+aSJEHObkBr4SSPQcGbj1drAV2dHl4tzywBVtIYgZtf?=
 =?us-ascii?Q?kluOq4rjaMXdqNoBPECXm2AynVlXuvaR6UDzenjR82EmgPACQGXObR3T+9p1?=
 =?us-ascii?Q?MmpDcj22As24D83J+vU5ss6h1gMq+1hGzVnWrOyRsmSJ0lC8nMfeAQQm73CS?=
 =?us-ascii?Q?OgqtUxwTMeL32O75bSDqjLdTquhVrWn4AMWm4jcMZ65/60ZN51FTukcyamhO?=
 =?us-ascii?Q?aHrUGzYK3V06mSm/yyDK9wFJzMAfFX92+/ordJxmfEIz8+FMtZUTrXkFOXRo?=
 =?us-ascii?Q?2op+aMy249wWhLUMsSze2PwkFGO/n+SdGYDvF0sD9v1MYxKU/cQuFK/5OT/l?=
 =?us-ascii?Q?LYxpAZLTSs3UzG+eWeUaIEyI+zohglT0hpGqaJoB+Z7JZ9Nr2RfahNrtv6kE?=
 =?us-ascii?Q?a/PD674PZrGB4kji4kJFjcUPS1oib5dP+T8ADwvYinplj3t23rMBy3quYVV9?=
 =?us-ascii?Q?KV/1qGTAFHsMcKNsEPYPmZRvOB9yZnYlaWMrK8U5e2z61ryxSgzf5bvOwRup?=
 =?us-ascii?Q?SCg9pZ3j7oogQUVuXvppyoJkIveFX/QH3//IeBiTc81B7EXgTaXubGjJxQYD?=
 =?us-ascii?Q?28MxpuASb9ssNsm6iqtPiHf5/VuYsmAppiv/rp4IVNyqNd31CyNqYS81wvBM?=
 =?us-ascii?Q?UWvMirtoeyAyjIqdZiZVOxwSNRYUcELp0hzsx/Ax1QF10eey1KrsQaEmpAbE?=
 =?us-ascii?Q?e9xR5MAx1F6tCRnaZmijw1nZAo5PyhTa9kO26lFycqgmpmdr4zL8hq8NSZMt?=
 =?us-ascii?Q?36gnRZxI/xOIujPufcDpwB+/eKbA9OYTaaF7yWyr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d62286-42ff-4ce3-2b0a-08dbd0aaf609
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:54:49.5855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtVzLN9mWWzj12jBcdgol08pEuuP6qGrS0PJdletlkQ1xSYERaERkd6JYE0+zyIlxN/xx4M848Q7nbEYcjNMZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8729
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Create a broadcast source endpoint using only the local endpoint.
This removes the ambiguity when having registered a local 
broadcast sink and fixes the situation when multiple remote 
endpoints are created when discovering a broadcast source.

Claudia Draghicescu (2):
  bap: Fix source+sink endpoint registration
  bap: Fix source+sink endpoint registration

 profiles/audio/bap.c | 27 ++++++++--------
 src/shared/bap.c     | 73 ++++++++++++++++++++++----------------------
 src/shared/bap.h     |  3 ++
 3 files changed, 55 insertions(+), 48 deletions(-)


base-commit: 0c757e8eeef69ff2b1eefa59e590f171c9fe1c88
-- 
2.39.2

