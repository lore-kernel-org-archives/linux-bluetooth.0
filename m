Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53BBC7EE29
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 15:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbjEYPfW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 11:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241667AbjEYPfU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 11:35:20 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2070.outbound.protection.outlook.com [40.107.14.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E3AA3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 08:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuuWsZgJakNtkhEZlelQpyFOcmEyBr4xD3/1riEDJ7nxgC9j1nrrATJ4Wnc9esof8vvqMlUSg9523UvobBfsInO0Ee25gzqdo8Oj8QFrxvw/0J/BUUWMnsAMXQ4yyTXMRxsnELjbaskKZUcJMvLDJvGJItSwMzyQdf7stI6qZfgKrwP7reg3xdSKje7yNYYFg9W80sd1Uf/6fHS7Fg8eRUX1sWUObvsjq1gJxSwVcKAf/nrkvmXS9PSxDdeUR8SX52tVJmetcW7Uvu8IhoPmOjgZDhcsaxIyJYiZhjU9UfV8CPtPQBJ5x8nzt+iuKlqqQziZ2b5oS4gJIBNbP1/hFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWAbnU0yLDxbBNkvU+VKimZnO3gf4rlVIppyt59m+Iw=;
 b=QMp8icvVGFfNzHE/S+dZi/bpXpUTND916YUSNRb6X1A6mhbrhmmUzezNGcWcM9A8NYF7yFqw037rPsWwJORDPP4/71YNfcgUUMkM+UCvb/DwI1b2Ij3CIdkVgD1Ob5yjFcudRGwIs/849NjY1jm9j6iO1sV+UwY+x0T+wAU207VWtGkIeijq7Q0HbIaSnQAAPGKbh/RFiTI7r/g77CadkqbaM4cslrnwXVMl389OE2qaZ2irXQMV1jFjuCfYXwwVH3z5071+Nj1FpsAgIn6pkuhUd4Djx7ueiqgkLA+CbFnhPXzxKo2bcgD3jYiJwA0jLBjqfZ9/vPlcCRkyuw/E5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWAbnU0yLDxbBNkvU+VKimZnO3gf4rlVIppyt59m+Iw=;
 b=LAZ7g4I1xIGrDTOYnPDdyv4ourCI1b1V9M6xvcZjTDYonsuGItwDGhy9OrdCG/O+m+NDuq+7aSM1Rt7JCOGOkqRe/8uFPeRIqWFVQ5kSiPuhQnUXN2QtHdBcUOqJ5iMe+LFp44aQhJXMfBsG2LnISY9i7vu1XVR6yYsBK0y/kR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AS8PR04MB7848.eurprd04.prod.outlook.com (2603:10a6:20b:288::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Thu, 25 May
 2023 15:35:17 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578%4]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 15:35:17 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH v2 4/6] Add support for setsockopt (BT_IO_OPT_BASE)
Date:   Thu, 25 May 2023 18:34:50 +0300
Message-Id: <20230525153452.125789-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
References: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::15) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AS8PR04MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbca499-3167-4e0b-47f1-08db5d35a3f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mz9l+BAfQ7ncrun4jadWzuWCtxwik6UJQMD//FPqEwxIA07tyDBNfGdNV+byCr5kHG8W/49mVrciCi0gAMBiEg0rSJ8ablj8z++uzhLo1XcgQ4UabzAPBmi/ERbUd3Qz0oUG27kLq6ruxi8G2gyQjbaqkH+O4Y3FrtSe/0trmYhv/RVudpUsk5Qk1vV6Z8+L7LxEwhuQv8wHrQIH6asi2GPBHbuW0CZvgSWZ6UxLblxtOWRG3JqmOA2RmdNJATXUeA3Mou6sh0XYqgubBNcja5yrNHixxIjPZd1p7kDcQmRl2TmZdLePv7gaztzhjrFLmjOXwQeKWk0vTkn+ZlLht7LD0PWiK3gCzr5bbsm8B6/FyQWoSDDbGmeKnDu9YQBHu45WU9BLP4fiZ8Wb4HHWh5rsi6UaDIqVx962FKiZQ06U8rm8VfJt/qv2AVEi8A0W3yIsMO3hDbGedp7UKp7IlSYECG0ZEp3MRTeBmwA1YFmNT4aRPcORNQ3ZFOyiT3VRZDHA59ZYoY/q0N0U9v4bHHbcWp4nETckMjDIqSIpuS5LocTfBpUSBM+e1rB+wf9rYlPFWS11bXGYDgFjgTZ7K5n++Pjkwy9KZpF2gqnPmQ45TVrFA7VsUShdxvQiXof2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(5660300002)(36756003)(186003)(2906002)(2616005)(8936002)(6512007)(1076003)(6506007)(26005)(55236004)(478600001)(66946007)(66556008)(66476007)(6916009)(86362001)(4326008)(8676002)(38350700002)(38100700002)(41300700001)(83380400001)(316002)(52116002)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?utSGgVAFOa4QAgwXIYf/Frlp5AU5D5h3jHXZ8Z56kZMHFDD7SgC8mUYJVM6H?=
 =?us-ascii?Q?ZvwBh4/aSJ2VDhAGH/NreUaFhTds/J50UY4Oss28YMEUit6rRBksJcdCXXAL?=
 =?us-ascii?Q?Jh8CW5n6jg01JgofDoLqBQy2oCsK32+adn6Qsuz0AVTYntxGHnQHgROR3WhR?=
 =?us-ascii?Q?QzoL3Rp679lw/9CnTsZKwnYtpi/Cuu27kYl+eOfXm2rz4fWOMrBtlglc3HV0?=
 =?us-ascii?Q?2867y+afmYv/ZVh3rUia/X7jtoQRe+pKwpXUK7duwOod0Hj6DRIK107sH2FX?=
 =?us-ascii?Q?D4QpnClAmBx2//qhOQB/BCbJomUDgCa78P+jmoXtVBjEKyzbcfYw88gaReHu?=
 =?us-ascii?Q?DXzdJ0KNbCkyS4lvbYtKt9VGOL6BVblrXI4LidO+ZubTUht+emU3yAxXUC6T?=
 =?us-ascii?Q?d1A1q7fnvkaJnnpSiY1jLvMa2Lk+A+Ikewdl01QiYU2ZBEb/ffhf/00eMGZi?=
 =?us-ascii?Q?fKGWAejye+qwMI9q2WkzEOZODB359BtlqtDm5bIEfVAEODnw0qFNwsG3V49L?=
 =?us-ascii?Q?nIj8eVXKHfHxuwpD/mlV1Zr4knaOrWoPBDIHJVAlN02OHED/QFeYRhfE2w3A?=
 =?us-ascii?Q?LAExrDSYud4J6vF2lwtHpdU0kT5uat5CGa7P8VQKjqqZvW2tbQKfN0A3LZRR?=
 =?us-ascii?Q?Vthrt5DJr7nMLefwv8BX6YBGe//qRxC1xpz3Jf3KsuLaYLh4VhEQZlXY5bWf?=
 =?us-ascii?Q?wHkbT1NvJ33JPldHmXQmi1/21gzTc/6zVLw5BJMLy+mXxUuxlDeL2WpCjyYe?=
 =?us-ascii?Q?GKkeealRmVOWV8G9i6WDiveTUkHSN8mM5gT1pxiSvDvJnGLd8D2y6aklY570?=
 =?us-ascii?Q?Wk1sG3z977C/Tg3nfGSfhr1as3xSDOsmbRSNOYF2955GSK2laWoqMSZQjhxv?=
 =?us-ascii?Q?sFjjD+62qI3Bgnq/6N+k/C1zSFF4wLJNnSIP/6rvVUqSWg04/XIm3EP60JfW?=
 =?us-ascii?Q?nPxAe2nheQCPzjhgaLFESZlSsSXzWp9V5altNoLrw+i1repkxyvRW3bcYcbi?=
 =?us-ascii?Q?53G+7NELofSB9+G/dk8C34Nze5QyfqrWQk+rnXrATsXeA70pYHn/Gm6Rf833?=
 =?us-ascii?Q?QEm82NpxMkEtNt5YLQmD5GingPnlFiZGV+/co2J6V5LHmc1UkYSRRf5Gfvt4?=
 =?us-ascii?Q?7vg1rR7md6rejKswtatPkqKmtTeP9SNn1dy0qP3kpIZp/dVo+hvGkRR3jYzX?=
 =?us-ascii?Q?2GCUgr+gEWJUFnKnMbKNIa+IWZsorH4qLkV1ITQFgqF3b4XyYxSXn7uc8qy6?=
 =?us-ascii?Q?tdmwL1JTyHMQzuiYA3Y7Uyrc+LnAdhpE74n4Xy5EwddeE62OBUg864GZD3Ne?=
 =?us-ascii?Q?14J8Keruwy+fWo+OLDAAzjEK3830+1HbU0i2ouEhUSK9haG9ub91eI1VHeKp?=
 =?us-ascii?Q?iNA56uKfn+sFJhy2Fy5vlsIQ1ZBYLPTbcS9FmQtue7/6+dhpPAX63ida2X9R?=
 =?us-ascii?Q?2npNJKmcLAqP6vtzWoBUeDnlSMK9dCMZJBcUKzo2jENdBTiC1jbM3on+SfQq?=
 =?us-ascii?Q?sEJY1FomrgG/g1prSPW5JjizsOvDFaDUuFZ/CusxyGBPnajgeVeuweAB0nb8?=
 =?us-ascii?Q?6w2U1/AMJuo82IW4ep/URbCv4dOZhna0TDw52SFZnAc+J66OTQ3eLKNzmIvo?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbca499-3167-4e0b-47f1-08db5d35a3f8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 15:35:17.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HdmAu2cUdXGiCbDvl4mwPW6zqyzJDsnm/oRwSNEljLYzj4noOZD3wLqnP6DNtihIo6w8DHPfXoTE5vSEr3PY6jB3UjmlY/EaaYKnBS6Uh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7848
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds btio support for setting the BT_IO_OPT_BASE socket option.

---
 btio/btio.c | 26 +++++++++++++++++++++++---
 btio/btio.h |  2 ++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 6f6d76dc8..b68bfb14c 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -70,6 +70,7 @@ struct set_opts {
 	uint32_t priority;
 	uint16_t voice;
 	struct bt_iso_qos qos;
+	struct bt_iso_base base;
 };
 
 struct connect {
@@ -858,7 +859,7 @@ voice:
 	return TRUE;
 }
 
-static gboolean iso_set(int sock, struct bt_iso_qos *qos, GError **err)
+static gboolean iso_set_qos(int sock, struct bt_iso_qos *qos, GError **err)
 {
 	if (setsockopt(sock, SOL_BLUETOOTH, BT_ISO_QOS, qos,
 				sizeof(*qos)) < 0) {
@@ -869,6 +870,16 @@ static gboolean iso_set(int sock, struct bt_iso_qos *qos, GError **err)
 	return TRUE;
 }
 
+static gboolean iso_set_base(int sock, struct bt_iso_base *base, GError **err)
+{
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_ISO_BASE, base->base,
+			base->base_len) < 0) {
+		ERROR_FAILED(err, "setsockopt(BT_ISO_BASE)", errno);
+		return FALSE;
+	}
+
+	return TRUE;
+}
 static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 						BtIOOption opt1, va_list args)
 {
@@ -966,6 +977,9 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_QOS:
 			opts->qos = *va_arg(args, struct bt_iso_qos *);
 			break;
+		case BT_IO_OPT_BASE:
+			opts->base = *va_arg(args, struct bt_iso_base *);
+			break;
 		case BT_IO_OPT_INVALID:
 		case BT_IO_OPT_KEY_SIZE:
 		case BT_IO_OPT_SOURCE_CHANNEL:
@@ -1290,6 +1304,7 @@ parse_opts:
 		case BT_IO_OPT_MTU:
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
+		case BT_IO_OPT_BASE:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
@@ -1444,6 +1459,7 @@ static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
 		case BT_IO_OPT_PRIORITY:
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
+		case BT_IO_OPT_BASE:
 		case BT_IO_OPT_INVALID:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1554,6 +1570,7 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_PRIORITY:
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
+		case BT_IO_OPT_BASE:
 		case BT_IO_OPT_INVALID:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1627,6 +1644,7 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_QOS:
 			*(va_arg(args, struct bt_iso_qos *)) = qos;
 			break;
+		case BT_IO_OPT_BASE:
 		case BT_IO_OPT_HANDLE:
 		case BT_IO_OPT_CLASS:
 		case BT_IO_OPT_DEFER_TIMEOUT:
@@ -1740,7 +1758,7 @@ gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...)
 	case BT_IO_SCO:
 		return sco_set(sock, opts.mtu, opts.voice, err);
 	case BT_IO_ISO:
-		return iso_set(sock, &opts.qos, err);
+		return iso_set_qos(sock, &opts.qos, err);
 	case BT_IO_INVALID:
 	default:
 		g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1820,7 +1838,9 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 		}
 		if (iso_bind(sock, &opts->src, opts->src_type, err) < 0)
 			goto failed;
-		if (!iso_set(sock, &opts->qos, err))
+		if (!iso_set_qos(sock, &opts->qos, err))
+			goto failed;
+		if (!iso_set_base(sock, &opts->base, err))
 			goto failed;
 		break;
 	case BT_IO_INVALID:
diff --git a/btio/btio.h b/btio/btio.h
index 9636fd467..e9a8a01a3 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2009-2010  Nokia Corporation
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -45,6 +46,7 @@ typedef enum {
 	BT_IO_OPT_VOICE,
 	BT_IO_OPT_PHY,
 	BT_IO_OPT_QOS,
+	BT_IO_OPT_BASE
 } BtIOOption;
 
 typedef enum {
-- 
2.34.1

