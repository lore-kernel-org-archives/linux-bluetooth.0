Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BEFC7618A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 14:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjCTOi6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjCTOio (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 10:38:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776191EFD3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 07:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AI4Mr+PIOcodsksaawVGUK3kUbv1x/GX7EnmwU94SIMoq4Ff0VetkMnBitijBCeA6Uv2r5pMLWoM6XVvlVI5LHBI4Lmf0WDzInqFjTRTOZqfbLeVDJ85mQggqRCyUCsKZyZlzQQF8xyQBslCcxWpfC4h9sjszvAi2hFAhBCVeuTJLZ0+v/UF2XWtpjo14qhugtJon0KgH5kfOmxTmmvTuoni9kaHTu0EnG2hLlLTLlxy63VQ+orjQ6kvhPxzvXz0nEyyETkW5hWYFQQ9rZHDfSgchiAxn3kd95T+EhH6LJN3QnZBwzl5YAsR6J9iwdMoGgDP2fbPtzrhMScmFsBd9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RAB59sNVjt1rQPpe0ASMNJxyUOETmSbGLmOvwJygEo=;
 b=ZgyKj2E7SbGbFwpg1FNmIr95y+uPBhLTKZNnVFV/UK8/3HDNkhtZtNEZ63KpZBgOtEtCjljQCBpNCB6TaBtG4bAqHUHhgUg1Grtu9imEgpd26Ux2mEwOSagAOBpkhZGk/GU2aKhDLXzh61n9XTD/3wBqes1O+iO2bL4ZN5TrRijAfKeZzKEAe/GqgjO6yyVyV33gp9PSNk7XdqyxdZo9dVECCDkxrjTnjLrLnijJdn8W3C+TL3lveOFdk1WXyfCz7PFEHRfI9uFgWjuBb3is4sQWAV7Q045oVuqVo3pkx4BW5sjJTJPQoSwLhMQOq8gwiU+yb8/k0u6+a6yaXkPw2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RAB59sNVjt1rQPpe0ASMNJxyUOETmSbGLmOvwJygEo=;
 b=ckJM5thjRVTUVYW6+RYerrQaosKT3xKQUo9Ff9XwOMqwVOCbYbLQdHpnrwigGUsudUacQubdM0kbYTxPpLxjwanRT1OhGvXB80BmJyqFcrObV/7RbYQer6B/1UuB15k36tlqewI9+ggiT4Vs8zNAhPwBgOZkTKacKMqwIMm0udU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:37:37 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:37:37 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/8] lib: split bt_iso_qos into dedicated structures
Date:   Mon, 20 Mar 2023 16:37:09 +0200
Message-Id: <20230320143713.25449-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320143713.25449-1-iulia.tanasescu@nxp.com>
References: <20230320143713.25449-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0147.eurprd07.prod.outlook.com
 (2603:10a6:207:8::33) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: df54bde8-db7f-40fd-e08a-08db2950a6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jhk/2i81XMMbq4Nu+IdbPWWsa68pcg1Ahc20e0Ue9IMNRCldNk6Y5TJDHQwPC8qaguMv8wgv52S3R2jjwQq3UNDEet51c9jpL3gHOoQEo71uIkCg1UXfEmnCTaaqUUu342cWCWfcu9Sq8FpqN1jqJauGywzpQmmh6NaR62C8MKxMLy/b70ZTkyUNQEJPfxGro59I3yJI/JlBKRTcBOUr+vuBkTL7NrNN2UtvMOK+yDd99EbVs2HB/BsUzQiP3JYbFNQ/QywTc6rVTuSvCcnizI5XQbp8pX6jFvItDxxL/44KS/9SMyINChsiMnIjGaQZygvaoLFBx4qm5drDJkonTT3G1lZmx3xxih1CE+dqv7z0VTVAXDpnSUslROZVMwGYwOK7pgGlryAIwlR34MdXBwKlIGQjgbBlgtEHYjlD3dmSkG2zlfRVS6lBaz/2ZxdfndS9gTa7lEoBq7o47Nuvp1BpI9Feg2ekAvjox5SvVD2Fz5mrV6KNZNy22U2P79RE1Qvpm6aNoX8+5/ht5k+QrWHxvHCMadRBdWyOznTf9xNIBSkl7ZBpPmpaOvuefmCnR+X1DUnOmoz0IdWxwM3Wt4hh7LqSQ/7zAerErYhezIud13l1NUUPP/rI8sddA8r1ML0S1IJUjwB/+JX4fhA+BqamJXFHyYQPekijkxa+wbsuQYbeQ2b+igWxHlkXii+2xwGSgMIdzFKOESweDD0DaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(6506007)(2616005)(1076003)(55236004)(26005)(6512007)(6666004)(6486002)(8676002)(4326008)(83380400001)(52116002)(316002)(186003)(66476007)(478600001)(66946007)(6916009)(8936002)(5660300002)(44832011)(2906002)(41300700001)(38100700002)(38350700002)(86362001)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c17VnU9TJCJ6YNLoNkpYj/JS/cAoMe3C4WIklEEJcTcK8w3KfscZKdGQa3z4?=
 =?us-ascii?Q?ZRqTXp38EHGSuwZwdm5szBcBxFkqFlhFOhkQTLniC8vMjCNOTCVLnQZ6FOGB?=
 =?us-ascii?Q?2LiLosJX+C5VgpcUajlNyWgtz+Vx3/cz48X96aIoqSQDP/+kzzywZVPuU6c7?=
 =?us-ascii?Q?EzC/IiUBVjxVD1Xs/Jm5Mxz5fzZYwLjmv4yISUvWkKLc74DoJD2GWVgyzO+T?=
 =?us-ascii?Q?H7VYQkHFdwUnzaPn15mdltQHbLUz/X330A3J0WR+7nx0/aGF+vU6mEVRoJPl?=
 =?us-ascii?Q?uUbjj9wonoZ0DcC8FoKS8oec3nU+NRZo08+vW3dC3bs2Edva1udkDoxF3Cwz?=
 =?us-ascii?Q?FloiJ6CFScAQfxSeba1Lp6MMjXDZiK/cfFkpjlLlSWD/kblO/QyOXXwQQz1Z?=
 =?us-ascii?Q?guRQinFil9cbo3Es2NCbWgWevxxNtiCfYqgNV4QRLHpG/IX3ERN5Nppcs/uS?=
 =?us-ascii?Q?Bm4KPgJqhB2EcVVVBqzfmtHQgEpNXkamDacD7yWHi+wUi7uBevuAP3sWEr/K?=
 =?us-ascii?Q?rHDHvXxJgvt2P0hlgHzgu8GrqEWcjps9GuxjmX4qVepSH+U3zf6+s/29fb1t?=
 =?us-ascii?Q?KId8mFdL1945aIy3Tv4Eutt2E3gdXCjLHyqZDwChM9V2pnlh6ESg6grRltDt?=
 =?us-ascii?Q?GivpadQZo4widfQ+mniRAE1NqGGf8KhZ+7EhnBjusBhAWbzyHaPdzVeGhhrF?=
 =?us-ascii?Q?APP23jvNOhfULCyTyA+shiCGw4lSTN0/xY9vXzWScpz3TzwmeQ8PjjI+Z+9E?=
 =?us-ascii?Q?DRb0hFtTm3TgVLoqM14MxJpZkxDkQAlZFJzK/qo4oMwjS8CwQ1clIaOEk7UT?=
 =?us-ascii?Q?DADbWgCJGOSv6ZL2fqh+Q7aJ6Qn1jYPGIVooMLiAnO+ibFdbJAWeYP96HpVP?=
 =?us-ascii?Q?9Kn+wS32JuijXbS+Rnqs7oScJpUu4zG1kiB6Pz+M2cTuQL6Nik0hIw3zoJmF?=
 =?us-ascii?Q?sEdJwV1r7vC8SrctFtHdDX1WoXx5GxPauz9oYuUvoKKnFJyfBpkZjXvb3lVa?=
 =?us-ascii?Q?5xjAI9ifI15ZkmsJXU7rrUDeKMqwSulDnVnnrPjI4C51jj8mbQEdcTczQ7zd?=
 =?us-ascii?Q?VoIO1chMPaXLjGdfiLhmHNRBOGPvBRFSD6UqJfSVjDNkGbduShXLopfhpgUq?=
 =?us-ascii?Q?wH9HviWjwPTtknI9aYI2Is/dwjPsNC/56G1R3fHOHrJZT18winO2G9/as/CR?=
 =?us-ascii?Q?CkkBa6k3QW877wAPKXbWYboxsuyuajQz8CbUwfzv1C3AC/K+ygkHmb0MVqoL?=
 =?us-ascii?Q?IKCEj1eY467D0N6/oqp29VkkJwQqAsordCsz4yMpsapshT+WZJx19tU5Zu90?=
 =?us-ascii?Q?dHeFFroOuETCQnchKT0eyU4YGvCmjwApkvpBoTH/1BNTcKaDlbxZ7bOixY5T?=
 =?us-ascii?Q?PXy+7EiNwmsU+aNqsuXu7LT+qCaUk2uqs+uV0a3fw2cSKXHCaUTuP0baqtBd?=
 =?us-ascii?Q?6jRYoTYBZCdicYMJWON8P7IqvgG6c0oF+HUsgUr4Z6DZyJcAQyFAWWEtHz/w?=
 =?us-ascii?Q?i5clWBcroIzDfc7hBku79LSq+MVgACIhqDLxT/xleBm7Y4v7/AlfeIJSGjnT?=
 =?us-ascii?Q?GBDYSzqVi7+Dp8bIXTsqCsSqTid3v6DRrhxSMKBT3iTdvdg2Nzqz9QwEOyL4?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df54bde8-db7f-40fd-e08a-08db2950a6a6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 14:37:37.3758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajTR3J8G2fExjTBQhwEae4ksfXyLouSH7tMPVBoWjVCTJyAKf0QeTJzOz3HIxInzZoosfbRShb/uWAxR2tO2uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Split bt_iso_qos into dedicated unicast and broadcast structures.

---
 lib/bluetooth.h | 50 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index af5fbcfbc..d365d681a 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -6,6 +6,7 @@
  *  Copyright (C) 2000-2001  Qualcomm Incorporated
  *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
  *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -141,11 +142,17 @@ struct bt_voice {
 
 #define BT_SCM_PKT_STATUS	0x03
 
-#define BT_ISO_QOS		17
+#define BT_ISO_UNICAST_QOS		17
 
 #define BT_ISO_QOS_CIG_UNSET	0xff
 #define BT_ISO_QOS_CIS_UNSET	0xff
 
+#define BT_ISO_BCAST_SINK_QOS	18
+#define BT_ISO_BCAST_SOURCE_QOS	19
+
+#define BT_ISO_QOS_BIG_UNSET	0xff
+#define BT_ISO_QOS_BIS_UNSET	0xff
+
 struct bt_iso_io_qos {
 	uint32_t interval;
 	uint16_t latency;
@@ -154,25 +161,40 @@ struct bt_iso_io_qos {
 	uint8_t  rtn;
 };
 
-struct bt_iso_qos {
-	union {
-		uint8_t  cig;
-		uint8_t  big;
-	};
-	union {
-		uint8_t  cis;
-		uint8_t  bis;
-	};
-	union {
-		uint8_t  sca;
-		uint8_t  sync_interval;
-	};
+struct bt_iso_unicast_qos {
+	uint8_t  cig;
+	uint8_t  cis;
+	uint8_t  sca;
 	uint8_t  packing;
 	uint8_t  framing;
 	struct bt_iso_io_qos in;
 	struct bt_iso_io_qos out;
 };
 
+struct bt_iso_bcast_sink_qos {
+	uint8_t  options;
+	uint16_t skip;
+	uint16_t sync_timeout;
+	uint8_t  sync_cte_type;
+	uint8_t  big;
+	uint8_t  encryption;
+	uint8_t  bcode[16];
+	uint8_t  mse;
+	uint16_t timeout;
+	struct bt_iso_io_qos in;
+};
+
+struct bt_iso_bcast_source_qos {
+	uint8_t  sync_interval;
+	uint8_t  big;
+	uint8_t  bis;
+	uint8_t  packing;
+	uint8_t  framing;
+	uint8_t  encryption;
+	uint8_t  bcode[16];
+	struct bt_iso_io_qos out;
+};
+
 #define BT_CODEC		19
 struct bt_codec {
 	uint8_t id;
-- 
2.34.1

