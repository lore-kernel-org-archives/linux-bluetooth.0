Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF593C00A8F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 11:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjJXLEC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Oct 2023 07:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjJXLDy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Oct 2023 07:03:54 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7894E109
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 04:03:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBJN1epQUY7fowYrzwZUY2HoDZ3KIL6lazPx1xh1AiZ5FdkAu1ld8cNt/PGDPfBlfIme1AUOcIu7zcqsyyfuAU+YYldaang9nb/oA8HM1gcKCeEFWZcvkKX0FulnB5xDXpxDgUiBigYqQxXyOB5UUWUtteoW5PevS7/t8rSstlchBY4YLUqT3DerIq6KqmVpqN3HJIfE4+7n/B6dY7sZtQSrYf5hZaDGHYW4jWQSGYVf84vB2DoaTceA4GVB+CtKUiDnX/xFLuSmkQZlcqfDkdu52CWKWzTTkIQB97lLD8NOeLaGaai6T/pTl8jyFbcv2oFZnyULdWFUqxdVxITO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0abbjMJg6Rr7CdhsfzcCnXCe5MAQ2eP6UgWv0iodUQ=;
 b=MF99FlXx/2L7hwe7eJjIr4Ajyl/mtp8RV531XJADSiWaP32m2VylUzuLBmMoZzu+5rUrq0X9RScEVBZQ+uwF+Hy/E0/q8/0yR3AgUH7rgQXYOCxfGA0WaKH7Ucg8kYWH8tq0n9rsKc9lkjn4XMKOGK/fIKi7G83sUmE+QQ5k6bGXVViQFKg3MLCf5P4HDkSfNEQZsDyVt6b4Mw0eN9qDFhUl0qWTiTraU8CG1Fd938zDRSzvRqeTVL64pMxbkiWvW60M8sCZ5pebQakRgla/tB9mT2e7pmbO/6DzqKgco2rdBS0bn0C0Fg014pwVDLxsu8HwyIyNQtyUoYVSdBueyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0abbjMJg6Rr7CdhsfzcCnXCe5MAQ2eP6UgWv0iodUQ=;
 b=ctC0aYR4+aXH2K3CLY1LjGMBSyhBnHkse7CZsBpsVpNeZQu4s7MZX4Iao8L7CHURD+b4w84eXVAnBppuBXhNL/Q6/YQnqaS9p16VLdU6dr6g+6F4wuXDPKAXFpgWcipvO635dSiroi7YZjaPyVZiPmFlnh46LrFXZFqALAdrMFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8545.eurprd04.prod.outlook.com (2603:10a6:20b:420::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 11:03:49 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0%6]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 11:03:49 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] iso-tester: Add test for bcast receiver PA bind
Date:   Tue, 24 Oct 2023 14:03:44 +0300
Message-Id: <20231024110345.3292-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0061.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fcd00e3-521f-4109-83f9-08dbd480e6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RKqKUEl5tIiLUCHL7nIi1tBD9uApuPiwTtJidPFONqUIut50bqiiwLXvyfvV5wrgrLdsuCh6EJNxGRmxogTYlsGPkgURTIzfulqUTTDYRgG9sQyLOJ8gS0Hkak5jNadiAJBYv8b4ctPsC8+6Q94z4ZALypEnsMkC5GnNccqSgv/E8hgPTLyWnkn3IUzOP78PTa6x1N4PnS82Fyonnz94UDzrXfJXO+Px+HIeawGqdAm0FbNG+tUC+lQXb0MLMlJ2WDAlgGrg4f6//XwbUAzvtlzfL8HndzB/SM1jyFGBDE3gTVLCR9u/NWpnTUSA/0gAyijd35uOcB0yoq4Bgr86BL+iweZmkCaDPlpxuGBVMeIIZ+zKUNqyvUQAASDk1IOlZvPu7EjQ8wu5R8jb2ZB7zoFzIFrsT6NJUZqth7JwN2IIrQK+JmcchZWXcBx9JDrvLz5jKG28RktUnpbPDqvDnY/jckzfeCLJBR9xdrZnzsxMHqJmq8fP7/5Y4g2K1t0HTVV9+uvivgqBx4h1mDMzfkssjZUyKanejKQqTx1gxC5l56AD8TrvlCUgTTbHc2v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6512007)(6666004)(83380400001)(6506007)(1076003)(41300700001)(4744005)(4326008)(8676002)(5660300002)(2906002)(8936002)(478600001)(44832011)(6486002)(66946007)(66476007)(6916009)(316002)(86362001)(2616005)(66556008)(38100700002)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?55wKG6TTWU6fDvfnft+OxfugQ70YKnM+SefC40cxaw5/YXFHDOQAVpqnIuxQ?=
 =?us-ascii?Q?l0PQbFnBmBFL6yOTo8zPV8bVCsLDe3RHYQ4uoz1AQLx3JbF2uNFeA9EFKvp5?=
 =?us-ascii?Q?k4m+7m9V7al3/L5uSCaEipxKMUQ5G+VZxNpWd1bh+cJsDfJ77jculnm/Bg9J?=
 =?us-ascii?Q?uF2u7KqwOlWaIRABUT8QwFGBL9WtYFFyqCncUf7NT1cGIzKreoD/FsFN9USl?=
 =?us-ascii?Q?QH9zTJS3wmXtzJ7AYJTK26/k5njVetTvr8kewk6PkSe/D66dweCWEsZzTLZQ?=
 =?us-ascii?Q?xilZcgTKwC0Ik3D1Sl1rGRjWzQLmk2RmD0J1kQeaNqepnJ5uZAqun21LRA6s?=
 =?us-ascii?Q?adzf7UbdadwgnfG9Tr5e7WvYt5CtSu9Ibskujvy87pzyKmQ/4EmkWBk/8/nF?=
 =?us-ascii?Q?T0pxi2Hsj2TE1FHvBi9FQPwf2oSXqev0sWQmO07mpD5ZEaKkA2a14bh74eFz?=
 =?us-ascii?Q?Cq1yd2XCV+gW+47Z2GeCKEg/+m7rCPsOkoFg+C1WyYUgh47Tcdf5whYTm9fV?=
 =?us-ascii?Q?3bsv17/MzOtc5FhALLgKBMcXjBlVCt8XPi9qAKKQOw62tweWRWW4Q6xxYvHa?=
 =?us-ascii?Q?8zlBGKAEAzy9fAvvcyTZVmquab//XVAYPsB63t19Dr1WBwfcS4pV3W4rFGAo?=
 =?us-ascii?Q?u4jWcEDuxewTVRHeM0Wfk4P6KiYzV+NcYCROPsSWdxCR462LlaZhMFMWpRCK?=
 =?us-ascii?Q?shGnrHd8C5BUOuRsxWSaHzZjUK5tFVrzDynC/XfCLLrVrLple44x+i4+72pJ?=
 =?us-ascii?Q?Al9Myroc0hTMPX4rG41IXYo69xkbNZngxQHfxQP+cQU5jB0ILJvOpjkw9XEk?=
 =?us-ascii?Q?/ZUkXb24Ty3R/RHr5ckNA+I25CzVAxTEOG9gQb504Sv7bxhP9dYmJ0aZIVal?=
 =?us-ascii?Q?r1YHeF7dxZwpB9yXOlwuItAkKpRd2Q06ykJSe/fp7/Fw4QamsxwlczzcKXaW?=
 =?us-ascii?Q?5ULyoyww91r3mnmDI3DEtlJPJxyXx9L9To8oa+dioMf9KG2TL6rbKb8jPJHS?=
 =?us-ascii?Q?SQ7GvJQgF4I6hp2/lV0wUJR8xLazrPzFMSrR08jdsLYLfcLgMEO0gB2zRDFg?=
 =?us-ascii?Q?+2TTtJW+vK9zYx5qWUobYNgjE5a0Uj9EXhHXhu3xOHulksOFPAGmcPuF7GLl?=
 =?us-ascii?Q?n6s5FMlEaAabMLv4Q/tLLSdChu2W40KJOWtnUXTz8betO31itticlFp1Yl4U?=
 =?us-ascii?Q?DSF9c1TM9V/bUg9j6vO7oPu9RlPtIHcZY1A03QKTz09yPFR8eolkpTkYnJSG?=
 =?us-ascii?Q?nPi5mu+s3dAjTGiDW8ObdNoFeunRXeMM27FiVchc2IC2aPXbW5rIoP/+YSq+?=
 =?us-ascii?Q?rmGJ5Ujh4B/NBxfrJOVFLqWoTqxrubK5TF3R7yInJ6z0Srklzb0n3//8Givx?=
 =?us-ascii?Q?FXhlixgq/tfUTTRqMgePHjd0I58LeVT/6sLohaXCkafIdS4fhHQpdrSZ49Hl?=
 =?us-ascii?Q?98U1RrzL+m71s2IbFu0amA61qAbapVdOzjSG76wyRb33W8HpqV0+I6cN0+nd?=
 =?us-ascii?Q?wBHhgEjKMzjNb5pYtRBJHeIITIv/FUhBUq8yGWTFN5Fb6XjU6vY9Kh8upFZP?=
 =?us-ascii?Q?6NkmKwk8UkfeqPv7IQPI08ctnfeIUnE989bXd7iUJ23ukOMcZJW1rXl7mTnA?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcd00e3-521f-4109-83f9-08dbd480e6d6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 11:03:49.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUHXJYxacZVe0X3IObOi1OTJK+w3ewmhJkOuXuKVR8vOZK6tOTm0sDG2/GiNkVKGF7/XvR7sXrYUZgTnecVrrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8545
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds a test for binding a Broadcast Receiver to a number of
BISes after PA sync has been established.

This test depends on the kernel update introduced by
[PATCH v3 0/1] Bluetooth: ISO: Allow binding a PA sync socket.

Iulia Tanasescu (1):
  iso-tester: Add test for bcast receiver PA bind

 tools/iso-tester.c | 70 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 19 deletions(-)


base-commit: 0c757e8eeef69ff2b1eefa59e590f171c9fe1c88
-- 
2.39.2

