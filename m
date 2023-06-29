Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48056EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 08:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjF2IIu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 04:08:50 -0400
Received: from mail-he1eur01on2048.outbound.protection.outlook.com ([40.107.13.48]:45537
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232191AbjF2II2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 04:08:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFJzJIX1L5coUQn5QcMPsJopFBUyz44qmlcOdDof6WApQR5SBM5rxHtbvdSYCjvSJuxCDKu7tWxJLUIrvOMWTpMR50JFS7UamCe6qS51sZHRtHMhQTSDpRQA2Wj3BWBfn3IhkBWQTF/Pi6T/bKTHgXojT8CsISQ3rFiTUwN+GiBi7UWt9ZGgSwp0mJmKrVhJCpMdu5Cag4ZngcNcgdNZ6+h5QDjbU82YyWClo4U5oLWn+nh2SmjfrBfoaa+4bI/h0YDAA6G0UEfW/q8kKrfZ280N1XE6Nbq9P2Tdefu1ZS7yh+fB67cUqT46UEVD5iEqIv6SahPwuc1q62+t01aGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVAXqQyNk2EkawDN2J7sLSf0qO1THMsLaaUWURRUYsg=;
 b=EhU8bcEvqgG2JOZilWrC53+vfl6KYgXtNbpNtOCwR/V6EjwbVgFf6Ngdmz6wKORf2Y7lF+8QusuJm9PDDrfr4Lcr/pmK++MQ0Diq/Ap42wt1PzKXR4XBG7Zv9QkgW5C0ED08gAyYziijkAaU1OUylISkOgi+eFwgZZyKn+ne7tYoZeGxTw4yzJ4Paa/xRFCV+wax9PqfrEjsiwvCvmhld0w7tcjzo2gM8QkDGAcOlpL/9YIvFYYJBOK+Kr0umzDhi/cqLwXIR9aas9tdDF39MTMcBhQ3t83x2CZuIRK2Sz/DKaRD/gI0qlMiLlZS9lArzUb9BzEPoHEUGDQnAprM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVAXqQyNk2EkawDN2J7sLSf0qO1THMsLaaUWURRUYsg=;
 b=pMAnMjvDJ5nYjrE8Lv3aYTztyVA7cOvjP0OexzjG+IF5iw8dhGhFL+OJSepSFa5hay4aEDLrclqIdvWkdAlNjy+y3vmwGhGHEfrRHG5aTNuQnxgwhOEdwSGsjFW2NJ6Ue/BOCpX3zYIYg1LrnvHFNFmBhLHz6S4Rsw37MovBjO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB9130.eurprd04.prod.outlook.com (2603:10a6:10:2f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 08:08:08 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 08:08:08 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v3 1/2] btio: Add options for binding iso broadcast address
Date:   Thu, 29 Jun 2023 11:07:34 +0300
Message-Id: <20230629080735.525650-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629080735.525650-1-iulia.tanasescu@nxp.com>
References: <20230629080735.525650-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0049.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::22) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cb3021-d3b4-4aeb-7942-08db7877f93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hgPM2ns29HN+reOUFbkeX/F7Z/lbkmbAwqdxAC5PdcFk++z69/uu9ExbMWRaZvX1PPPPHwd9gH+i9R+M5e9psu6B2QjjWongmmsA1DM6YBE7fiMdorq+woggPKY8Wzio6BiO97Sml8NCR61DeWwVzmPWT0RuYVtnVSK3mQygzZ2fWNoldiNjw2/DtPSqKmXkMMjSJt76rSxUSlo2iSYIWnvW85NO54UiFe0yPL6yQJ8X7L58UQLekcr8IWrz90RWryQ1Q2JUEPoKyaNXJBMs+I8dfKBfqhRKR+kN6pLLfCmTTbgCcbNrpPVYjfejkDmqNhI9h3h4XEGsL9Y/MzM0vWNKj7irICFofH7hSa3juTWTLogaj0BDnb+M5/wdH2vQtrGILgQWo+X05AaXd/nDYhgz2QoGOEhHl7EC+LBiSQbV5S0gQrC4eBnSc8IF2valpyCYXGknSTI1x0WNRfoEKUe0NcF90Zwjp1eQx/0YXsb5/8QaEYY0d9Sya6I/l787hqkuwiqY2Wkos7dXAAYYexxp6a9ACmO+/8wnl3HJ9pF3F0GZ7Sfs5OUdTiY24uOAK74R6K/W1FIsKnB/S2/8HkhURUafYff9vUSx7xTA8EILYu0he00zoPtC3PTQmCCdLWCu2nl337TaAxevYtLmIYTWngAUE2AQY9fJ3bVgnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(52116002)(41300700001)(6512007)(316002)(83380400001)(86362001)(55236004)(186003)(44832011)(6506007)(26005)(1076003)(2616005)(2906002)(38100700002)(38350700002)(5660300002)(36756003)(8676002)(8936002)(478600001)(4326008)(66556008)(66476007)(66946007)(6486002)(6916009)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lssif/p2jzZ1muio5uTeLgQrm6ZDDf/RawoPREBwxMj2PxdXSzEjE8DnuF9o?=
 =?us-ascii?Q?OTl0dSNtX8LQwm3WM4r4q10mXMyakCIlm73UMRMyWlNSnSmNqFHDt31Y3j0d?=
 =?us-ascii?Q?r2ml3YYhg9AmiJ6z5DAsUdXprS5e22/HqR+L7bYn1vXxktf2I8BlYpkoR3WH?=
 =?us-ascii?Q?f1PNbv6c7jPEefr7BeDMBl7KphEBb/MS43zod6Z/d0ZUtUqYJH/046HVheVf?=
 =?us-ascii?Q?tx4pQSsc39MUl8Z9lNwlx3DKIKHRfkCFyigi+4auBd0eYF6QNHPifF3nKT/n?=
 =?us-ascii?Q?g0Kt3lQ5Iw4/omHLTY8kU+G/WmaF8/17V98vZ4zFlhAVVr/5lchNoWfg3CU6?=
 =?us-ascii?Q?PyQLbUxNgEkqYbt/ScgVhiZrWk2Z40zc3KvpvJZ0aD/WaWjQxOyC01lmXZUx?=
 =?us-ascii?Q?c6EVPErdUMz9djn50/G85pOurEdy+WgCbqczXKA8ElJwp0x4D6S3UMp8PNvL?=
 =?us-ascii?Q?DMXiKTiAqv4hzZ1f5O7DYuGCGcsUC+Y7S91o6KbzRAG/LInwq3BsY68/y3wY?=
 =?us-ascii?Q?hNu2dhkTb5o3EX4295x6DKWfp2+SfqBxo2I5GViOcj8tRU4f66b6y+lE0XgZ?=
 =?us-ascii?Q?M2ibli30tzDLuQDaHj7Eq/6AERl+bE0yt7Bez7MeVlrjTkpSjVGsH5EQnYrN?=
 =?us-ascii?Q?hQKLozDn9wEwhzF0tz4p9M065t++Z9LDXxuScrBmtYtPKXI6BAf9W8ODtoDh?=
 =?us-ascii?Q?Ohj3FR5IRfEx+BrxM6QO+BIyVeT48Tnhm/fLsM7cgrs3jewEaoWaIctovjWi?=
 =?us-ascii?Q?HbWxTM6Sku5lC6INu9CREn6xMxhnkfhaIgIsvpuMyyKvztN3m2kWg/A90+X8?=
 =?us-ascii?Q?vOOuW1k+YbTBI+Oi/YAhl/oaTvlnztf3hxHAov5sn0XaQAi9z7Py9F+KAG2f?=
 =?us-ascii?Q?2SOY97WLboT6/I23VmjT7AR7c1848vFzhIT4S6pDWzOdsj5EPQB2jvHC4ZZ/?=
 =?us-ascii?Q?2YDrhJ1z1rnly1MEGsxXEhf3HSTrFgk19lxT215HXvw932rNUyTqCHlAiDPm?=
 =?us-ascii?Q?zYCznmdbD2hkHd/cunV+yOB3+RRgG0vB27f+zq5SBp58b3O/+F/UBdb0+HoU?=
 =?us-ascii?Q?S5PzwVCu0gNEDd70Hjgx/LHPwj+bafwSRQ7Lqw8Wd2BR6WPRoqUW5LGfIXHO?=
 =?us-ascii?Q?XIE4asFZhPeZMWhdi/Cnb0LNLKLnkvV4OYoMAUR7GzS1XS7NjQ2ZNsQvkggX?=
 =?us-ascii?Q?q8popieIi4ArMOxf/b5R/tOuWc+KdvU3u2DFY3IqutL6YZS9RYKdYyTKRtou?=
 =?us-ascii?Q?VANMm4UTyovLJ67SqTh8JjFdDm2mYaQuQh5gODCHgIN3dmcSDdfvVemZUMjO?=
 =?us-ascii?Q?e0gB+XKoHIGOMvCOhvRUyZOEZwkejhQf5BY3XYGjrBmRHykNSx86duRxQalf?=
 =?us-ascii?Q?Cz/p3HLHn/uqxQlYcGwf767l6uSqOjDdCMqv6fxM3qZA6ElbNAw9Gw4LAHE0?=
 =?us-ascii?Q?GtOX60CTdp9GMQWJoX6V3k5KB4lW8NLNlP/V5xXoOORtTBY3sPdEwpjDxWGm?=
 =?us-ascii?Q?gfU22zsxSBRWpon7uO0XfnNXewYI4Gf8POYJumuKRjpRbUEggcv/MEImIMc/?=
 =?us-ascii?Q?4KHtMR9emJF6Z6jgteux6QlToDZCGdxte9QX6Z7lIzLeuW0zvO3EX/tiGxf0?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cb3021-d3b4-4aeb-7942-08db7877f93a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 08:08:08.1888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbPfD43PapooAcgGuvDh1Qmay0PCUKasfsP8mn6Sk6lGYEtD7DXDk7bycY1t0lHmIRN+uXnECAhhVkoIIkrjQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9130
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds additional btio options, to allow binding a socket
to a broadcaster address.
---
 btio/btio.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++-------
 btio/btio.h |  5 +++-
 2 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index b68bfb14c..179be6289 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -16,6 +16,7 @@
 
 #include <stdarg.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <errno.h>
 #include <poll.h>
@@ -71,6 +72,9 @@ struct set_opts {
 	uint16_t voice;
 	struct bt_iso_qos qos;
 	struct bt_iso_base base;
+	uint8_t bc_sid;
+	uint8_t bc_num_bis;
+	uint8_t bc_bis[ISO_MAX_NUM_BIS];
 };
 
 struct connect {
@@ -771,21 +775,47 @@ static int sco_bind(int sock, const bdaddr_t *src, GError **err)
 }
 
 static int iso_bind(int sock, const bdaddr_t *src, uint8_t src_type,
-							GError **err)
+					const bdaddr_t *dst, uint8_t dst_type,
+					uint8_t bc_sid, uint8_t num_bis,
+					uint8_t *bis, GError **err)
 {
-	struct sockaddr_iso addr;
+	struct sockaddr_iso *addr = NULL;
+	size_t addr_len;
+	int ret = 0;
 
-	memset(&addr, 0, sizeof(addr));
-	addr.iso_family = AF_BLUETOOTH;
-	bacpy(&addr.iso_bdaddr, src);
-	addr.iso_bdaddr_type = src_type;
+	if (num_bis)
+		addr_len = sizeof(*addr) + sizeof(*addr->iso_bc);
+	else
+		addr_len = sizeof(*addr);
+
+	addr = malloc(addr_len);
+
+	if (!addr)
+		return -ENOMEM;
+
+	memset(addr, 0, addr_len);
+	addr->iso_family = AF_BLUETOOTH;
+	bacpy(&addr->iso_bdaddr, src);
+	addr->iso_bdaddr_type = src_type;
 
-	if (!bind(sock, (struct sockaddr *) &addr, sizeof(addr)))
-		return 0;
+	if (num_bis) {
+		bacpy(&addr->iso_bc->bc_bdaddr, dst);
+		addr->iso_bc->bc_bdaddr_type = dst_type;
+		addr->iso_bc->bc_sid = bc_sid;
+		addr->iso_bc->bc_num_bis = num_bis;
+		memcpy(addr->iso_bc->bc_bis, bis,
+			addr->iso_bc->bc_num_bis);
+	}
+
+	if (!bind(sock, (struct sockaddr *)addr, addr_len))
+		goto done;
 
+	ret = -errno;
 	ERROR_FAILED(err, "iso_bind", errno);
 
-	return -errno;
+done:
+	free(addr);
+	return ret;
 }
 
 static int sco_connect(int sock, const bdaddr_t *dst)
@@ -980,6 +1010,16 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_BASE:
 			opts->base = *va_arg(args, struct bt_iso_base *);
 			break;
+		case BT_IO_OPT_ISO_BC_SID:
+			opts->bc_sid = va_arg(args, int);
+			break;
+		case BT_IO_OPT_ISO_BC_NUM_BIS:
+			opts->bc_num_bis = va_arg(args, int);
+			break;
+		case BT_IO_OPT_ISO_BC_BIS:
+			memcpy(opts->bc_bis, va_arg(args, uint8_t *),
+					opts->bc_num_bis);
+			break;
 		case BT_IO_OPT_INVALID:
 		case BT_IO_OPT_KEY_SIZE:
 		case BT_IO_OPT_SOURCE_CHANNEL:
@@ -1305,6 +1345,9 @@ parse_opts:
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
 		case BT_IO_OPT_BASE:
+		case BT_IO_OPT_ISO_BC_SID:
+		case BT_IO_OPT_ISO_BC_NUM_BIS:
+		case BT_IO_OPT_ISO_BC_BIS:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
@@ -1460,6 +1503,9 @@ static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
 		case BT_IO_OPT_BASE:
+		case BT_IO_OPT_ISO_BC_SID:
+		case BT_IO_OPT_ISO_BC_NUM_BIS:
+		case BT_IO_OPT_ISO_BC_BIS:
 		case BT_IO_OPT_INVALID:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1571,6 +1617,9 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
 		case BT_IO_OPT_BASE:
+		case BT_IO_OPT_ISO_BC_SID:
+		case BT_IO_OPT_ISO_BC_NUM_BIS:
+		case BT_IO_OPT_ISO_BC_BIS:
 		case BT_IO_OPT_INVALID:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1660,6 +1709,9 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_FLUSHABLE:
 		case BT_IO_OPT_PRIORITY:
 		case BT_IO_OPT_VOICE:
+		case BT_IO_OPT_ISO_BC_SID:
+		case BT_IO_OPT_ISO_BC_NUM_BIS:
+		case BT_IO_OPT_ISO_BC_BIS:
 		case BT_IO_OPT_INVALID:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1836,7 +1888,11 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 			ERROR_FAILED(err, "socket(SEQPACKET, ISO)", errno);
 			return NULL;
 		}
-		if (iso_bind(sock, &opts->src, opts->src_type, err) < 0)
+
+		if (iso_bind(sock, &opts->src, opts->src_type,
+				 &opts->dst, opts->dst_type,
+				 opts->bc_sid, opts->bc_num_bis,
+				 opts->bc_bis, err) < 0)
 			goto failed;
 		if (!iso_set_qos(sock, &opts->qos, err))
 			goto failed;
diff --git a/btio/btio.h b/btio/btio.h
index e9a8a01a3..642af2e22 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -46,7 +46,10 @@ typedef enum {
 	BT_IO_OPT_VOICE,
 	BT_IO_OPT_PHY,
 	BT_IO_OPT_QOS,
-	BT_IO_OPT_BASE
+	BT_IO_OPT_BASE,
+	BT_IO_OPT_ISO_BC_SID,
+	BT_IO_OPT_ISO_BC_NUM_BIS,
+	BT_IO_OPT_ISO_BC_BIS,
 } BtIOOption;
 
 typedef enum {
-- 
2.34.1

