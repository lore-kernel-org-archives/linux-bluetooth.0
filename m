Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01FBC6FA8F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 10:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbjHXKYe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 06:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjHXKY2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 06:24:28 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A461739
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 03:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU+dpgPYopp9T6+Ax1mAWGEaTyVsRCOO3J6wpnwbPf6K+oD5kkhMootwhxE3FgmueH2OqYeSRHX5SORdnZna5eA1/kjbfNpqVLGKhrZ61Qy/jDnazJm+xnZLbWqP9XrRb2SBf3+K62VNKgyQOAZxPlSr6SdMcsNU7N7vsEQOfJBZ2eqJcJs3lIztW2gkpWi0tHaE9C21x4pZpQcuBHOzNnhncuXviKLXEwVKrWxn8m1Vbqi0HMDlJulY05EinP5Lx9GDkQW+sKi+Nv86RrbZWhzVDi8hdglxI8hmmGGgGnvR0A1fqDqMlPnNkeiftme8EL4BWRSVuQZikQFsDcuXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92qP9HnDvjHLjcJWvtpl8aBzcTuAUfllOs8UQC2oVBU=;
 b=Pox/w2BFIHHpwPOhjKzaegYGAWxLIzPw48JxrFLiFRxwl819l/RHBr4hqLUAFHK+rahAFoQ46F4kJXy2la0KBdMCnk5u8SM7u324Hrl3L0yzM90WUcse9KIZRPLhqXU0PYETMzxF1JArGh4tEiKCyUR3Sv7vtt+vvBD4ARDymTcTdL/JR+QdbZVMiYZI5s7Ql41gYQFFCII6GGyd+VFbkdaGR7JEU2jaZontaN4FGwjSyf2gvSIz6QmZPGXfeWHRse3VARcGb89C+G0+L+vrD1g8rkRFVKtQmLk1VuBBRGxXYIc2fShL1mvm+8++4HPE6h0xmYww2PbfaELhy2LTug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92qP9HnDvjHLjcJWvtpl8aBzcTuAUfllOs8UQC2oVBU=;
 b=qCKPjeJvVYo71KdTAezWZibCvdCvgDYa3fnMG18lHKrFJvDQEwzPeITUYkllZpxBfahp2MAukfCt7o985ZSx7HNYvwQQOIbD0zWPpFaczlhPh3jfCdbv6qbVDhJADh+Tp+J5oI5LtyrgjfMSsSYk+StmuHB2dMMHGTXORZVDK/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8625.eurprd04.prod.outlook.com (2603:10a6:20b:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 10:24:23 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 10:24:23 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/4] Add mgmt event for BIGInfo report
Date:   Thu, 24 Aug 2023 13:24:03 +0300
Message-Id: <20230824102407.25883-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0050.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::12) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8625:EE_
X-MS-Office365-Filtering-Correlation-Id: 61133acd-f67a-4c9b-5724-08dba48c4939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFVjc83xv/GQY7Diqys+bRANVFS+0wMYkJkxFvVBWD38c51L8eBpQGijbe1ztYqzTeTBxoJrw6/C8Eq04bAYgUKkQqTZHn1apBepbHoCvlCMb3mcygqAYIzFpbyHbT+7ox06zlW7R1z9m0ZISU+pG9Y8ozUn3burtwoosvcOewD8lbx4AoLza76A4vW/pyhk6qQl2yN7a1mNFNnEK4prYXy6+d7rTM2RqwgDqHvlu18C3i/zVNJFX3zZ+SgPvFW4fXauVBb7cdgIIfAXgfnHNtipRzOI7JWoOu2iSMGxoXGT6p1BjfM2BRp+mnSpUjJDIe1Gzr9I6SRq2BYqSALHZbH28KDFqz4GZ3xeUHXJxP7aZGbQR/ZNbYCvkWV0XfOOYwj1/G653LWiazELD++jGWOm0XJjEcCr5HGdbyEr0sUNHImizgxPvJkN/CFQS+B+wjd8i/XefrimEGCpRFP7FkwhfL434Sy+Qvw5DO4EBQE19tV16tCHKWvonF5eZ+jzkQCpkFYnRZj1MkpsnUXKR119lVsgMKkDjLGG10Nw8gAs+SxglSJvsAiMJYqMpD4iRYSjqPD8N4PDZ+dAXZxRfwwgyz+ZzgoUIx/O7YkVhkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199024)(186009)(1800799009)(66476007)(66556008)(66946007)(316002)(6916009)(478600001)(38350700002)(26005)(44832011)(38100700002)(6666004)(41300700001)(52116002)(55236004)(86362001)(6486002)(2906002)(6506007)(6512007)(966005)(4326008)(8676002)(8936002)(1076003)(2616005)(5660300002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qHhBRBeji4l1nUMEKr8W2+/bhFIjzbSL2D2GBA/0fcJvpyTDzVreMOMLWX2x?=
 =?us-ascii?Q?GPUMiZdd7oKAhGcwYB2cKu4pKd0NBN6dcONwwiJAdxNs06YY1CZW0x7Dyb4Z?=
 =?us-ascii?Q?zuFKZFCAcD7O+okmh2TND+tgN8+XyGiN+7iPwkHp6fz4cJJmmx5F5sWm3dlY?=
 =?us-ascii?Q?k6gzKeLkCvXm8icT1XkMlHK+lM7jydg2kUxLS41JnrBHnW0wLt45V1jSkDbC?=
 =?us-ascii?Q?JGltm44Jae4wsO9vjlOyubi78LPn8pwPQkOzoJi9LdCUh8x8rIpACmesgIC2?=
 =?us-ascii?Q?GW5wG526SQFcxHNubJJrRET3dA2AOfxMlYbLfph7Xr0TU9qg0pPxbYCXTAwl?=
 =?us-ascii?Q?NdWSsH6mW8eJqzO+BuvBcRICtFEVO+nB/kPhe5l0G6bsMXRjfeHZ4HpCQSu3?=
 =?us-ascii?Q?im+1og6ux3SXOgMGyhry5/7g7OJWH5ldBApqDRsFfVjmNu1gUc/zk/ObKNzZ?=
 =?us-ascii?Q?ovPvpbCbMhfkcZKxlu2Yyg6ocbuTpUfRGfJ6ggyTYRWUY6bS3IwRZT0Nzemp?=
 =?us-ascii?Q?TT/668Dk5ppyfjUZpliXd/PbepkQlrKy54mxJ3X61n8DZ2yVHjvypXnpeUlW?=
 =?us-ascii?Q?5EE0s02yqOI19eBDKzL2JAomxC07URDxwlVlGa4x/ooelgOFRLsbYFzEIqwz?=
 =?us-ascii?Q?btOgORXQC6gkcbwYskDs/W9OE/2D5Z7T7Da3h2TLrfA3ITzsifNeIoy1xhHI?=
 =?us-ascii?Q?bDeQ5+j6NBN8DkBIvzgFkG0GE7zgXK15xDzsY46qOUtWfbMJYdoM3RC8+1+O?=
 =?us-ascii?Q?rhTbtKsRy4cIPAXegdmb5B+IAcvw47k25THSsU2325qqztsDsO7f0/0i9Gvz?=
 =?us-ascii?Q?xfwzMCM5ISZ9cY5RXhynW6SwDCgq4Y6FtV6n3DxNdcgq9fiiE4wIADf9av3l?=
 =?us-ascii?Q?ZnOQVAgJi+1TgXZ6jD+gQPc0ValqpPC9+yQGAsOQEZLbeahCYcChH4AyISqD?=
 =?us-ascii?Q?6SjclWYnf3HTZmyavdP/4FV0+17ps6Q9PraXFqXibkTRni347C1vphmypKd+?=
 =?us-ascii?Q?8/ZH+mJh8lmd4EBTOpfIiEZ1AT8x0wOb8wzV1f3bxb+ptAUFzzGZOu5sWjEs?=
 =?us-ascii?Q?Z2i6/5uznGZVoyX1WFT/oZ3ipTjgKf4apIVv+BJfNo5GrgFUVDvgWfv4QWtb?=
 =?us-ascii?Q?LayI3+rOtOFdUziR9wTt57ntaktnda+/4iw7U/LmBTqNbJlpFnxKmvOfDh4c?=
 =?us-ascii?Q?wCLcMDMfp9ZdA09rF7CwxthNJEFTwM+PtqtB0QClOlobRagBsM2qDFG0JxUU?=
 =?us-ascii?Q?D3wqmTepP4/Yh1bLo57KkgiVz4leRR1+m2t283hAwyobqcwFaA3QBiNeAe+W?=
 =?us-ascii?Q?C4IRAbOr2RSEjKnk1mlQBQM9nYkmE2laVN/Biv0DKNhS/PtRxBQny2BCi796?=
 =?us-ascii?Q?N+DrWt0iRYavZwIAh+xVPn/kmSFctxNm7jWj6lhqkBrx4/Cix3prv4QoOSAG?=
 =?us-ascii?Q?tsGDpq5JrCsSR/XG3dXnlQ86M0iBD79qtLmd7ETS167R7+UgH55cthVKcNeq?=
 =?us-ascii?Q?R3saBWsg07vSwU58i5Ul0/GbVOcw0f5zMJveB/K7sKsddMQb8XpvzOWQ0+T6?=
 =?us-ascii?Q?wT/8Y++aEVxKoWrBBB6e5YK4XbkaIDfxmK8BPZcvKBTH2doR3m+SI7lwnd9a?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61133acd-f67a-4c9b-5724-08dba48c4939
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 10:24:23.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltxsyX+qdAr17FzHRZCpcY93PjSuXoNseLdM34N95b1wmnn8up3L2x4BTV69v/amJGcndpvAps8Kj5ap3OwS0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8625
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch introduces MGMT events for BIGInfo advertising reports, so
that the event can be passed from kernel to userspace.

This patch also adds the sync_handle field to the bt_iso_bcast_qos
structure.

These changes are needed in order to implement the BASS Set Broadcast
Code operation - a BASS Server is required to inspect BIGInfo advertising
reports received from a Broadcast Source, to determine if the BIG is
encrypted or not. The Server is only able to associate a Broadcast Source
with a received BIGInfo report by looking at the sync_handle field. This
is why the sync_handle needs to be available in the QoS structure, so it
can e retrieved via getsockopt, once PA sync is established.

This patch depends on the kernel updates introduced by
https://patchwork.kernel.org/project/bluetooth/cover/20230824101635.25662-1-iulia.tanasescu@nxp.com/

Iulia Tanasescu (4):
  lib/mgmt: Add mgmt event for BIGInfo report
  monitor: Add decoding support for BIGInfo mgmt event
  monitor: Fix decoding issue for hci BIGInfo report
  lib: Add sync_handle to bcast QoS

 lib/bluetooth.h   |  1 +
 lib/mgmt.h        | 18 ++++++++++++++++++
 monitor/control.c | 25 +++++++++++++++++++++++++
 monitor/packet.c  | 35 ++++++++++++++++++++++++++++++++++-
 4 files changed, 78 insertions(+), 1 deletion(-)


base-commit: 60731cab5891ad2be01f5fcdbf5908aff7df4fd1
-- 
2.34.1

