Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB72C76196
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 07:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjC1H0V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 03:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjC1H0S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 03:26:18 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB79F3A91
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 00:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA7xZC1nWCL34DoBuJMtS4y8mCxNHqSR15yvujRZfjSvgF5h2XSnKBQFmRm1u9UEU8ZsuiEq2qCfWGIljl0qMtyJ1wtKbgirTexoLn+PBe9OSHkiUz4T8K0+ScjVsEM2s4uj88ytAlnxEMxOr2LupN83i0sv6rVa45wODsODbeJR8OywMGA8vhKrG92JnAlSYs+nt3591WP5jtF44Em1lNDLJJTydvFLZ81NYkjdv9ZVBaJW/PS35d/CwgJ/XyvZ7nyD0usJbMKiMc9UClRswxWRB2kMgFW6RnSmjnFfWPkES1eXd8ZrOOAX6O1VxAiE919mr+uQbp6pWDdxgIT0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3z59vyvw5iQfUQxgNhTvuUrHn98+98i26lPPBh4Qo0=;
 b=f8oA1S4mhIKmc8fO75TNU3O+vgu+Saxjux8Oqb+ogGeqc9l6XaaayXk92xppWIZUlFsu+tLGfuA94xXAX5QS8ZMWN2r+kTaY6QlLNwyHagwch8+/N+7tucH9pBtmbDs/PdJuUgFte+hoKZQVvKjSzSAz17hyY0L0UFp08aX22/iqdEQp+lS/LJdF0QEoOLvc6VSQztE69HjtbxtLcHItM/u9wzNsid7gEZbAq843UnQ3pvlyc1Zi9jsoQ/4unHFRwMaw7OAvmU54c2aoKDw/Xq+oWnEyo2dXYLTPE/emCn0tg3pQ15cpCOQ3MmfWOCOZ9ZnLAEaMvLzkgr1dTzG2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3z59vyvw5iQfUQxgNhTvuUrHn98+98i26lPPBh4Qo0=;
 b=C1XtbHteHHcfhAw0yXEOPkEeUROdU4lhZsCDNTvNXCJ7XZnzkoVy1WDqtSUQJi5340C/rUJiHLl1ierbvOucyMHaOAg0Jt4Q6kgFka2s8cKw5QNGwosR7ocpfBmowIbqYcut+myHMY29hAbvEbXLGA41v4lDDTAs/KRMcGRDWL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7328.eurprd04.prod.outlook.com (2603:10a6:800:1a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 07:26:11 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%8]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 07:26:11 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: Split bt_iso_qos into dedicated structures
Date:   Tue, 28 Mar 2023 10:25:44 +0300
Message-Id: <20230328072545.16876-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0121.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a9cafd-268a-4de4-b989-08db2f5db4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yx8IXzTBohnwFNYFGcO9d9qhVoOdsc9AbyulaBjiFI9Ue8tuFwXtXsR4E1rG4ZvSQXonVGzohDyBXDTuZq79D0Vmbz0ztF0K1W37hbHIYOmg1qlQ9FcuIcigOFpSlcCirbwAW/oS1Ykl4hIwWcFhzKHrxDfBH0MOed0CrjlxzJ5A/xmyTPNoql4DCUUPpkID/JCJDrqdiE0auohkT7Li3yUwMxrz0CRvysnFzBSa88UTDWoEEq2bgyLctDUmvvBnVj/Yp9G709+DiTvfL8SJklfjSQf/cxsVZWx/DBQdu9QIv18evpdnMH+QwZ2EOaVpk7BCFitq9owXPSePzgjCS2YbJUkmnUDSyI4wjPzMBx1OHwy/ThrCDyGn1vyansvPqyaQikz/Ly13JfEcfmoVLZ8r2ThJJ7GYbWXqeObjLs3Ll7BVHM48buoHVk+HcJzDfnaMYlrCmsHQ9KAsXvTW/XSLGvmCg0q6lc4ghpoab5iB03HFYe0JG5dui6F7z4qMAciGdQvT/btHTlbklDhsQOkOUsrCe+ISJFz3TQBHfuLAHdTlKHvVPJqOtPFFVCkjAtZG5xUeB4SYza9QS+zGWvYYrAIIcBazgu5Kt0o5fIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(6666004)(83380400001)(86362001)(316002)(186003)(6506007)(55236004)(6512007)(26005)(1076003)(2616005)(52116002)(6486002)(41300700001)(8676002)(38350700002)(38100700002)(36756003)(8936002)(6916009)(478600001)(66556008)(66946007)(4326008)(5660300002)(66476007)(2906002)(44832011)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K9y7OWtG4JdK6F4I4ahuU4aztnp3oXiKfHigYbty+fCJa0dd3xodq61x3pql?=
 =?us-ascii?Q?VNrzW3BoOp2gNwtUBDWw8qPr3QCi0M8YLuc74VqlXMksg/GCEWHlkoZxUhP5?=
 =?us-ascii?Q?pFcXmiSETB0RCVU7uG8gxjp2KhO8BrYv9ckWpfzefnLPONhjGF/luXGElMFg?=
 =?us-ascii?Q?3PNc5hKxdtZ9t3mFmHFIvGmeMGupVV7M80R4b0BtWgZE+jSCs74ysMsvwKzp?=
 =?us-ascii?Q?FBNdQKODjg2BePo8emwRrDr3VvP2HRgi/xrB6BTT9sjHmveebLUu+s+7JyMZ?=
 =?us-ascii?Q?cyi1Bp4/KYz91ZmRaLb5LPGibvhkvRbq7Urw88pMbKlMURRTfWPK6+MqGJSu?=
 =?us-ascii?Q?8Onxw7N4aVwWnSNbu37ksrHHL19RFHtqbKxYAYm0Wf2vmEjpTTdBEfz39vmJ?=
 =?us-ascii?Q?IkzT6kePjtt+PDBy2mtdfFqUR25FcMYIXmbHpGo1P+g8iNRMip8lSlHo92+9?=
 =?us-ascii?Q?ElvV3GLskx5JpEPBflF2ilZIHkeJgZFF/ZD3xzcdU1cdlvP6knWGW0rY0Klh?=
 =?us-ascii?Q?QXjDfJP0wC2NzsOx6a7oHzu6sBFvWcFAu5c6O6JibCOTlwxBA3NiwJnNJOUH?=
 =?us-ascii?Q?GPV8CbQUW1cBFGrs9ZvWt+vxHbtb9eVBWSk3VEUxHAGbnvNQ3ISQIcFcelK9?=
 =?us-ascii?Q?vVKChxhzm+NC6Bt/asOJh7vkpWnO4wbQ1UYUe+pIXk4paZBj9fsOWThmGswV?=
 =?us-ascii?Q?mM6RG06Ft3pSck7V5tjYPzAQQ0Vr6hw6hi8WN2BhlboRbBf9EYURRn2Nb5GI?=
 =?us-ascii?Q?3U8cFdQzHHu2wJDjxHeYewvYlpzm5/Vbx70C0Y/8qU7juDxPAvJB/AtZrrFh?=
 =?us-ascii?Q?ma/oLKFP0yPWczgQGBaM7ccId0y4Kq4QXKEc3GmGoFFJb/Br9ugmkdGRTw0g?=
 =?us-ascii?Q?yt8e8gPeUEsktrzNvTlB11X9zbXmqyNvaLdQRSlReGT/Xr8/QcQpkapfYw+f?=
 =?us-ascii?Q?ElGDHH9Hjt14KUBmlWMtOBiHPFrhm5L4d4Wj6jVvoBJprtC8Dyd8ACUxQK94?=
 =?us-ascii?Q?lhzn0+lKDkdgAE5EsY37oRrdJG7kG78m1vlQP7XuOljfuEKAYbsSKOY3n8GM?=
 =?us-ascii?Q?aepF61SRcNx1IM9sr71eNCQnHXdT6QpsJVP3rBujDYQugcEU98QsJNp3/NQN?=
 =?us-ascii?Q?WqmhlERTQEFtAn9Ck4rapozpugbOhC9fIrfTzi855cVBZYDXy/3rcua3TDpO?=
 =?us-ascii?Q?6jaD2wVTJ7NJ6D67pM0NKXUFmBaQ+BWJumCHjudYtu2k29TWdOERS9rJjavC?=
 =?us-ascii?Q?EACeC1VWAYwOvA3SGJ0/rDMR5GQxqvekPWRUZ5xQGdicDdpVrvTeJEzWoaPR?=
 =?us-ascii?Q?iNL8hRavWDN2AUJv76ZVd9njaL2AEkHhdbzqJpLllU8DImAH/uueNE8gPmnD?=
 =?us-ascii?Q?Qdf7KghmOsoxVvLoe9U5Msjd/wRMefcaVkI1RkJl6N0tnKMrMTiV1JAzBENV?=
 =?us-ascii?Q?jTzaqGTgqDTI3+W2wAHuqvzIrXWmby8Wpixih7OUz5ZTg5zeV5xcGNptssfP?=
 =?us-ascii?Q?5VUgQTjmBo5h0P3QLNY9ndaxPklJQDY8q9L2ZnbsgDZfXwz0FcoiO97EscRx?=
 =?us-ascii?Q?Hhti8TqaRaaP/ZQDbRhmr/BoqX6+erWzo71ySUbhuMUlOR5tZPycgM0xPnUX?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a9cafd-268a-4de4-b989-08db2f5db4f0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 07:26:11.8525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07AWERvOVPtDObJyPsT6ba5cB60tBE7myuGz52RYZ+kkBr5ZxSRk7kpEugNhznehNznvEEQtly73ap2t4W0v/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7328
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support for additional ISO broadcast QoS parameters,
that the user can set before performing broadcast procedures
using an ISO socket.

This patch splits the "bt_iso_qos" structure into dedicated
unicast and broadcast structures, so that ISO sockets
can be configured with dedicated QoS options depending
on the type of ISO procedures to run.

This patch depends on the BlueZ patch
[BlueZ,v2,1/1] Split bt_iso_qos into dedicated structures.

Iulia Tanasescu (1):
  Split bt_iso_qos into dedicated structures

 include/net/bluetooth/bluetooth.h |  56 ++++++--
 include/net/bluetooth/hci_core.h  |  17 +--
 net/bluetooth/hci_conn.c          | 104 +++++++++------
 net/bluetooth/hci_event.c         |  38 +++---
 net/bluetooth/iso.c               | 205 ++++++++++++++++++++++++------
 5 files changed, 305 insertions(+), 115 deletions(-)


base-commit: db0fc80ec686774f1ca4606e752bf42af1f1cd97
-- 
2.34.1

