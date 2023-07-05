Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA0DEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 08:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjGEIwH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 04:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjGEIwF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 04:52:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34209D
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 01:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjJSlDyP5AZM+qoogUx3huBo1jWfQEYLinC9Cw2dVqH21baLUCny//yndLY0Qi2YfmbGoaDNtQyq1x1iSPuoxY0nFx2jU1YmqzbBFvoG1n0faz+c2fDmHl2DJyGcXA2MiuqDJrPLbOcdkHMpwxRAcTTyF7BCRhx42oltPAqclG9u3XlhdDVvSPRHVRgKnJ9yi8ClFHlcypDU0I0LadzZBGXpBFgprzjBZjYkLENhSsMaR9c0s8UnzEUDFCN3yTOMnWqXX6EWtd/4TBFJ9jxg6+JV+7unYighFNiQNe6+1A515d4LZT+UnAuaDVbudfxRKR1j9sdroM/G1m0JAyShyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL/x95kukH4H5C7a3kHf8Ck2uyqAoy/BAJ0r/SWvuQU=;
 b=Jdt3UadGsuOKSDu8yw7jQXQbfilgLxb5EJlG1onOJ65zVWl9ByCT/Hv2qZ3QlCxPrbIO5hks4o3qQvQ5MMj+8DRE6/bGR+bCt5pRYvSthgLKnBih+g8EQZr1I1gWSetZPKoO6CJ1Ne8Lg+KWns4WIWSj8LNqWDFxlzpWLUpcS2rVw0TpapumzeGZ9ETrFJrfx4CjL0V12q4o2lKCxvWgSQm9GsvJtvPgYbZMY3+XqH6bawz+v2Z5FwAvwzeWV6BCmS3990p4OOlmwsmKHKXyU67bVDY7X5ptz+fNMQ8VTRliw/Ji/XRX709hSefS178fsxp6BHIlgu5WVagH0Uqq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL/x95kukH4H5C7a3kHf8Ck2uyqAoy/BAJ0r/SWvuQU=;
 b=SGiij4IOXm2nYhvzBKKPbztAbxF7gi1Rj2ox3+ODH157/ovAggF35TYPNuvO0fMg5lCHkLDywP80Zz1520n8CLIgabYUC90iRTvXmqcqkGAEpFAQw7yjroAEwHa0TmETjyis++iczO8pSA4FlFW/pSh8Q9ZmzIuS0TmaBdnu2vY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB8790.eurprd04.prod.outlook.com (2603:10a6:10:2e1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 08:52:02 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:52:02 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v2 0/1] adapter: Allow broadcaster to be passed up to application
Date:   Wed,  5 Jul 2023 11:51:30 +0300
Message-Id: <20230705085131.6643-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0022.eurprd03.prod.outlook.com
 (2603:10a6:205:2::35) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fdc1e74-1f05-4422-3ad9-08db7d351998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mpmHeEngrUUZPoyZZzr+7R7hcivoVo34BzqCALd8qvTlVXZNsOZkrh1kdEhAcNveRKFYZRU3Ak1FwbDNnq8pxV5PVLZLmvpRQa2lQg4FVfAWOfDyMEg2NoYEkDJlBwg6BpyZghZGOKM8GELFTZF/Vi/B7tyGfNNd53WuY9tXPQh2bcPNIPuxdMCjoih9m2VWGap5NOXh/5fnXK/9AKArNU8Yr5ywpW5TMQ6xIq+BYzJbMQxIkN0lvQhPWZ2RKSkCWSmzKG3WFu4VfRyLEwh+Tm0qRVL8VUtKMzf4aEiUpB+MeDMQL+hfnTnGU9FljSmDbiCjrj1fuq1sENt6mi/ZcWi60NGMjz9d2V2Yrx6VO7qDBrjYpDVBSl5iUnqbibSSKg/K4Y/VjmisN2x0yes0jyx6KU4cWTdFSIckwDSXVxgfG7bZ6pQ/eTehwhIqzHzidDeD/ktdOMXXPMCYADxcJQ+e0F7hyUtqEl5oAL32afN4SRipzQkX5DYyMn+gAG9KIAg5WYE03aBU2KFDfKaZ73gvUpfPH7ML8g4Fm0iy4m1M2zaUALxdbYRdsGZ3WjEnVbszFJr+CuCZN0x2kL8+4774SjAOIKLm0M/sR5RVcHGjuTfkhaec4I6wI5hab5u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(1076003)(6512007)(6506007)(55236004)(66476007)(316002)(38100700002)(4326008)(66946007)(38350700002)(66556008)(6916009)(2616005)(186003)(26005)(478600001)(4744005)(2906002)(52116002)(8936002)(8676002)(36756003)(5660300002)(6666004)(86362001)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GfZny1KLzyaB902WOhXWAlfridByn/+FpHgqIcnTffm4kPE/g55CCUKG4xsO?=
 =?us-ascii?Q?cECMkWUmjkDj7wOcx7NmkWYyucqg62O04nVFLnsTfZM2NRJ0AVNfJpR+7Gnd?=
 =?us-ascii?Q?fZEcRGfz1+0pK/X15jbwoTFW1Mdg4s/8Q33ETAupnaJbeHJWOP+ZtsWDGSh9?=
 =?us-ascii?Q?wi0ymb2Qa+Jg6+g5eHVIq9zVtvdmBwAGbvZeIW8V/TImmzPk1NAvxhAqIDE3?=
 =?us-ascii?Q?gC9OzZtvQuHX4pDWQHAe7h3ZimfMiHS/SWrZOd2P7xnPb8xp1LDIxeWofZxN?=
 =?us-ascii?Q?qRvsMo0l7cxuz2E8uIJIKDlryDl/uzM8LbGsqUz9hZbIMTtMLubuz+LUpOsR?=
 =?us-ascii?Q?/PphGL6vassuPHGgkDfrbhG8WmRZtI/vmQ6nCKTB46GrHAY2AjJqQjkrO7k2?=
 =?us-ascii?Q?d6qhQ/AIhBWRiViydRhTYg26y35ll8xLvtit0L/zweT4SOZIQHkW+nnHM8YK?=
 =?us-ascii?Q?lCEaNghxbkAifW/iszgR/piJzF7X5s68SqvC9nsUzKCtoSGmoiXeGnHc8L3Y?=
 =?us-ascii?Q?iWjDTLqLrjj0eI3ZckY+SISvOQGGXrkdnlL+HvvJWPmFW61XbVlunGJmZ7FR?=
 =?us-ascii?Q?lrhgayVCD8zpjUgzfro34OHlio005x5/hwvzwrlxibgSbwzCo+nGRu5hR0I0?=
 =?us-ascii?Q?O/NDZDa0TikKABG8k3MAK1bRW1YQIuN+c8Qqh1AgAipwEaYBx4qM90XyS2qy?=
 =?us-ascii?Q?j8hA92mva3UeQeMHg6K7T585fW65i4moQK7BJZJFTHYIHBiMJf9ZJ6cjAMsB?=
 =?us-ascii?Q?bNdDwM7SCuXmkLSCuAX2ElFnIsCDY3dMwtjM+FiGZ7wlyOw2RJ4woZInJYM4?=
 =?us-ascii?Q?0KrY2ZnS7+kvCosa+y2MHLnG/S4ZU9U1be4a5RkpJSF2zcLN4gmo5oT/JlAz?=
 =?us-ascii?Q?U0KlcMH4ZxAB8lpYoRqPDPECyykd0Y6JnrO3duSSSMbzzpXHmGF5LIwYxSvZ?=
 =?us-ascii?Q?+98EWsHIXOOVvVAEYRT+cEej5TbiRKCndm+hJg8IRc0CkVgotnJB0Z1U84xz?=
 =?us-ascii?Q?c2O9gH5E6aATl7tGSPUfexPPPrBgBJ/bHVB7tmS61rGi5QBC0DTFlie7S933?=
 =?us-ascii?Q?fptBxsfY/wYE398V/yeBw+pfxN9/QwKPJ+d2WmI+D1JPEFm8G6mLwZpgdJz0?=
 =?us-ascii?Q?eXK9BqopdyhF4MUyRh8ubSLp27cW9/Z8QH2v7tgxAukE+KD+V6nMluGuATLY?=
 =?us-ascii?Q?Z21UG11vWYQ2pxZngvcN/ZOmao0+B8TeJ1MfvebaMvpTLe1bPrh1c2xh4oEH?=
 =?us-ascii?Q?JV+PO0lhV6/oA0eSWQl7eZWWL6LWc4kfubhCHkbr4MxoE4le1XMRAhu0v9LC?=
 =?us-ascii?Q?XYVfX6MLGg2R5dGb6ptmnCHmVcrX9bm51xKrfTLRrlKOOVnnSwE7s0ApGubT?=
 =?us-ascii?Q?7m0p2paQo52jH7pTGQKaDyPC1V+0sGWlmkiQ5tyifyloFW4etTEx6RKjRsYV?=
 =?us-ascii?Q?LuZDrPlyi9rXEGwrXO6ORJgtls5pwA6L59DC3j9bNVDJ5IQPO2+5qEIvZORq?=
 =?us-ascii?Q?cw9LImxQZGpa50VppS1KrRl5VhmqKhj0IU5UDh38JHYzEZc6WaY/d8e8z4HX?=
 =?us-ascii?Q?wS1p1cMy1izSkMPl66F66ywJ9muzhLXjyGJf9/Kg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdc1e74-1f05-4422-3ad9-08db7d351998
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:52:02.1168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKGL5WZ9WlFVYiOlRm2bmcIUA3p2tbmq85oWEi4fBV+mYOPJG/CuU2CJ3q14afVa1OG2jKs0ou0HheXgmRvuSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8790
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Allow a broadcast advertiser to be passed up to application,
if the scanner is an ISO Sync Receiver capable device.
This allows for a broadcast sink to discover broadcast sources.

Claudia Draghicescu (1):
  adapter: Allow broadcaster to be passed up to application

 src/adapter.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)


base-commit: ddfa40977c7e7b8723fc3ba9389822631ddeeb5c
-- 
2.34.1

