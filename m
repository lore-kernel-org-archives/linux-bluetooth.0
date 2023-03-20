Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84CEC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 14:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjCTOiM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjCTOiJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 10:38:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6524B27D61
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 07:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWgL6na0Va3EwKN+6oNBF3AEIta0+6oAN1h+z6f2dRP/nrkc3YNESHxIK3DPyiLAbYAsTc+d1xGcGw7RlQjTf62IEqwtPbovv+AGAYofBXzpQ5kdOLPR3wW+DpVIB2Erp45JdbxKd0tDdHX63poPxSZ1R93CPEhoozlLRW8mM+EVabQ532sdWs8AkXhIZTbj8DFFmSlHapdqTX28z2wKUWtdkzqYpYrQ0QHYmORFuWiXfahGIKD0U2NxBJz+059WEtI5LqjnTYWy9Qqc3VW5C5q4gwTWjmF1kWG6tfFjWgt7BqAP3KQ8mD72T2uFsutVef4P2vKUKwzfgSpSpYC+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LsbZsCo2JAX3nycrmH4HBfYMOxjeY5Mpw93XPrzqnM=;
 b=UVTCXh3B3HR8dAx66GEgyjy5mj3j9jxZcO6sf5ipWCtCjMOk3zIslLgPV6GFT47ZbZuH1E8VeFD6o3gU9WudRsRfPIuor6bHWRjno7t9Yc9DEgNiOGlh0HG4qcU0J63eBPLvABLcfcS+pAVH0aOJZwo9/ljZBN1WaagnzOJWtIJcPUr8UcZo2z3zfJHCIOQbtuiM+Gm740YVewTJJg3lcWF6zqYadOLX/5NphEi3TSN69aJKDxZXzD8ZnM/nJaorPHwmiROXeOoPZo5w0+JbhGIqO2AlXRAxmIqnmwi3KomVxSfn6F0vxh6garvZvFIXzb3q6XMRh8hOAX68JM6u4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LsbZsCo2JAX3nycrmH4HBfYMOxjeY5Mpw93XPrzqnM=;
 b=ToRN1zSKKcBaWi9W5Lr9K7T2iQReN2aqT6hx/thzbIzQ5uqi19uTkbwnad0QifOT5TiOE+WHrE2y8boN0h+xRayQHjzFU5DfVXjfg/DAHlFEpqkwQvfS/nHMErdfI9LKeGwD8qwhsh8QSRelqsl2Hi8P4GRqUHH3TCzs4HjLJHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:37:32 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:37:31 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/8] btio: Use unicast structure for ISO QoS options
Date:   Mon, 20 Mar 2023 16:37:06 +0200
Message-Id: <20230320143713.25449-2-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3518510e-b032-4ee3-52f4-08db2950a355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLEyYjeAW2rodNomWB1GHgXub/vyICzE/bXUS/JgRhwQ9jpA9sZNIyYHGWFLLUPy2J/IGudVvyjJvoso5cLfyKQLPfoD3B51p0G4HL8EBXK1aEakjSwoGq9M9da3fD+XSvxnRX/0omLAfPyOamgJ8MeffQhetHv9zwP/ZzhMNW/jXWGDRrPSIVywzy9K3j6LEAHujNdwZEyxOkOMsEZbBJJS2rzEVx6a5cORsdqQbBZmAAFxd0M13WxFsPdOWpXBKiY14drWyFnrst2/pdMr657ytNvFOI15r7VSqXMYRJJBVbRHrAt7hzLia52torLrJGAgb/zPviwnKIJr8bjNjntRgXgh9x06Ac1/4Lc9lqHUj050uiwOuoPm77/gQh8odyk8eUftf8XOSCTWMtXHI/cZLA1FLK4gNNORZ8RUA4wn0mMM1o87MWx4kENcnIaj+YhJ9Z8ED9Ar+0bCb+r02s7Y6bWzIvVG6TeRsUnrK9wbUKpPUKVtJpN/mixyj3LVcHjFp9BowCJN4ah1HUxDQB2wZ7y3d5TmzegepLyDds9TUm4yXzzKbEFgLLnvgIlc1mIYkD4tRFn75vz7E2rW2VEMEq97DrCjAJC3gWP2znAeaq9K0qD/NvEhUvrtEyQIBDa+vQ5IBXkKhifT84nCPwAnkQnI33rFVCXAMH7CSkePUBasBCmViTs8DfT//hDJ0gCQyL8ztKdEos0clOKH1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(6506007)(2616005)(1076003)(55236004)(26005)(6512007)(6666004)(6486002)(8676002)(4326008)(83380400001)(52116002)(316002)(186003)(66476007)(478600001)(66946007)(6916009)(8936002)(5660300002)(44832011)(2906002)(41300700001)(38100700002)(38350700002)(86362001)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yfv8Vr++0kDs4LNAl+qHAC7cdR01aiaFP1hjxfpASF3DX15+9Oy7JQCPmtSl?=
 =?us-ascii?Q?CUsBIerxHv2e0KF2G7+mfC4hfpXJu55ya80A0ZhPnfJZqaxMoKappMhPyKuy?=
 =?us-ascii?Q?8muOygxlOXVtPbjC2GtqOEfLWmp0fGg/wMnqKww4NV7hTrOZwnzGOylFrdpL?=
 =?us-ascii?Q?IvHKtA859JTKMHq3M3s8O78iveRCuPXLBJn64jxXIegzSAE5PNnzxHIwrYPq?=
 =?us-ascii?Q?bRGdfxUzfTFEj+OytfC3QatRvKKbAcJqz1pgX1gKQkicyXoQt/xtF4TstqWb?=
 =?us-ascii?Q?MISqYb4quGsw0r/dcxN3v3kNpizsTOM9kbFdKPTq15GdgJaIgcXmYKT9jmLa?=
 =?us-ascii?Q?sd9P37aqKZ4sZxOu/kOlF2zOnpTbCcCtlpsEIvOqcHQaH9bzPjoW03mq/CT/?=
 =?us-ascii?Q?GqciMPimXoani1g9pTeLkZpp11cnVPQ3z+wF2W8NoGzvyerRejeFwz/jW0m7?=
 =?us-ascii?Q?Xrg7U0bjrZ5w4KlpuAQrrVaHpgg7zYXqz/3cceqa7r8i9baMyhvqh0Z5htMz?=
 =?us-ascii?Q?fwtaPN4TZtYrBv/4WSsGOHrHxAQTnRZ+JpAQE1CPvnngxlZMrz097+6ZmObM?=
 =?us-ascii?Q?qLVoTsdrJ/0wp5FaPs1RFaB8Mil6l9N2U2kEgIQizSO9jQHKif2zSq4MXMxN?=
 =?us-ascii?Q?PljfAFUlB51TIrMKoUfvupFQJYiFygg1exNLFn8z9rJ5Jx3QvpxTZVMCFdPa?=
 =?us-ascii?Q?OqBf+o5IWn29BGA2gLJxe9bhlrYm/avGmhe5ysujGaK77cwhFCNi9QJhDfvq?=
 =?us-ascii?Q?dEDK9Kck9ubfUlIzXOO+p35Yf5iGm4v+fxWARc1J2Oqu3Faipd73VlJ91LJL?=
 =?us-ascii?Q?lv3nU20uR+ywQVELZFO1jRWr9iAlwyMAUh+66YNr7DBX5UyLeiF0GFGhmHZZ?=
 =?us-ascii?Q?ENxShKIhwXICRCZQ9ZjfaVC93FYgTeOgrznQP5BgFJ+S/s+JxuuGnmEdPO1Q?=
 =?us-ascii?Q?unN1ial3YjV/WxqQSFMrEuZZRp7kSiUyvJ4qLBcaAYRnK3G/+rWI9n9h+uIw?=
 =?us-ascii?Q?yJ2WpMbtDwQCx1FQr8LUFVk/YThNGM2EZiXiuYAgEREdwyiYBscstjtasaBS?=
 =?us-ascii?Q?sWvOKMsNgsem64QTN0GY1Ag2KIq+RmqeMAVkkfoVdBPZ4WI4k4p56aG1kk8r?=
 =?us-ascii?Q?9UM27kCsWeMp29yNBjKWeFvorwqbydHi2P4XpeY4KRVI65P0KANpczINzKwa?=
 =?us-ascii?Q?QOCrNN/Q/YG+TePlRygESr+IzsNQ0+iq3W8JtFEP5zB9Y4nxgFIfl2zWcDvT?=
 =?us-ascii?Q?HBURVzaU5dllmRk+S1U4VxHnKBD64SXsCrx7iOQRgjQE9Uud2eQXrTdhi3I1?=
 =?us-ascii?Q?7G3hYY45r4a7WiZpyLMQw+7R+YNfrm//2EH30qQIMEDX5l7RsBV8HPN9dMmO?=
 =?us-ascii?Q?DeeiXzwJpD4+fCJOOzdn5vt8RjDSFMYBR9kEQJhN4zdxWo0+yGRx00h3bQej?=
 =?us-ascii?Q?5VRZlc9bSaPSE4Q07EmIo5pQ9HZZdgVU6YyFR5ufi8v3iNV+eouDbbPepjfF?=
 =?us-ascii?Q?PF/CGwNSt4Lza7gp0Xbd0NtyxrkW8x72+uN26lJL+b+XgcMd+/dnQKHig9S7?=
 =?us-ascii?Q?EZGDGtojsUwBcpxqIjegP32eq7ursPsNWTjeedKKj6Zz0KTBF97xi5Hs06rb?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3518510e-b032-4ee3-52f4-08db2950a355
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 14:37:31.8238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPQGRBTCrvp9jcH0ZxL9eIcGzx+0vy0s9Ptzdoa1CxWFnYc/n7GWF667bBsVcUjAkXglZCROTjI/A+WURNXbmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Convert the generic bt_iso_qos structure into the dedicated unicast
structure for ISO QoS options.

---
 btio/btio.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 1ad42728d..017b53a54 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2009-2010  Nokia Corporation
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -68,7 +69,7 @@ struct set_opts {
 	int flushable;
 	uint32_t priority;
 	uint16_t voice;
-	struct bt_iso_qos qos;
+	struct bt_iso_unicast_qos qos;
 };
 
 struct connect {
@@ -857,11 +858,11 @@ voice:
 	return TRUE;
 }
 
-static gboolean iso_set(int sock, struct bt_iso_qos *qos, GError **err)
+static gboolean iso_set(int sock, struct bt_iso_unicast_qos *qos, GError **err)
 {
-	if (setsockopt(sock, SOL_BLUETOOTH, BT_ISO_QOS, qos,
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_ISO_UNICAST_QOS, qos,
 				sizeof(*qos)) < 0) {
-		ERROR_FAILED(err, "setsockopt(BT_ISO_QOS)", errno);
+		ERROR_FAILED(err, "setsockopt(BT_ISO_UNICAST_QOS)", errno);
 		return FALSE;
 	}
 
@@ -963,7 +964,7 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 			opts->voice = va_arg(args, int);
 			break;
 		case BT_IO_OPT_QOS:
-			opts->qos = *va_arg(args, struct bt_iso_qos *);
+			opts->qos = *va_arg(args, struct bt_iso_unicast_qos *);
 			break;
 		case BT_IO_OPT_INVALID:
 		case BT_IO_OPT_KEY_SIZE:
@@ -1570,14 +1571,15 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 {
 	BtIOOption opt = opt1;
 	struct sockaddr_iso src, dst;
-	struct bt_iso_qos qos;
+	struct bt_iso_unicast_qos qos;
 	socklen_t len;
 	uint32_t phy;
 
 	len = sizeof(qos);
 	memset(&qos, 0, len);
-	if (getsockopt(sock, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len) < 0) {
-		ERROR_FAILED(err, "getsockopt(BT_ISO_QOS)", errno);
+	if (getsockopt(sock, SOL_BLUETOOTH, BT_ISO_UNICAST_QOS, &qos,
+							&len) < 0) {
+		ERROR_FAILED(err, "getsockopt(BT_ISO_UNICAST_QOS)", errno);
 		return FALSE;
 	}
 
@@ -1624,7 +1626,7 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 			*(va_arg(args, uint32_t *)) = phy;
 			break;
 		case BT_IO_OPT_QOS:
-			*(va_arg(args, struct bt_iso_qos *)) = qos;
+			*(va_arg(args, struct bt_iso_unicast_qos *)) = qos;
 			break;
 		case BT_IO_OPT_HANDLE:
 		case BT_IO_OPT_CLASS:
-- 
2.34.1

