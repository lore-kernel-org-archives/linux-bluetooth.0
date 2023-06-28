Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745FFEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 15:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjF1PHd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 11:07:33 -0400
Received: from mail-dbaeur03on2052.outbound.protection.outlook.com ([40.107.104.52]:57967
        "EHLO EUR03-DBA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230196AbjF1PHb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 11:07:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1lVy+JIqczE1ykEz2jvGY42YYy1h0OMyqcPeGDZn8cg61l50gnJWXUYa/tL3jvxAUvXsyr4rXaY/wuUbVe0jYQaXAsD6hJkuPuTEAndqGZVxYm2aLv1eb/k6Y6jprTLN/Wak5iSfAYC6EZOKRv+EDsF0q7nqqXIQsazk0g7GIWkuBvQvf+Jyyo+XAU1WGMJrGn6/Mj4cAMlz/UY5keMCXTmC/KqgGvJvRtmytV9dDBualH804ZiATC8jJ8GYsDYlzIdPyyp/WcAUIYJND9k1tAqzVUUvHtkUXP8mGY+noOcyXIU0hJkjVtdCs/a3KAv50ynUHdkXU9qKlX9CXir/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hesL4NSvULlcZ6G/p2p+bbLpn79W4ZkPvOXZ0XRmuxo=;
 b=mw37bYOyqGDl65fulpxkpqT1OjedphisuHMvwKT2kEy1VBNcLKb7GglzPDcmR8ekweeE4YWAL0+Y9QIlfPzA6oDhUo0CPKD9J0hiA2EYyzBMlqdpoiNBhl9qjav28+G/D55wLS6QL/6rZTdnkF/YDGFu7D5SZyZaTO38ATrPPGEWrH3O4J5MYX6cxSjfFapOVHDKkKIKEuOuWMr/Rk4RxAu2PIBxvCPAiicTsUsUTczVNz6vLMOzjKI//6XD3DmLDUfGCGgqPN0RmWp6nNnbqsyu6K6qecJoZAuEJ8IfamSnVG9bBOHCOTz/0BD+eBsC4BBsHA2vCz21+cWmvZ5ynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hesL4NSvULlcZ6G/p2p+bbLpn79W4ZkPvOXZ0XRmuxo=;
 b=NEzfhfN4Y6GwGu8Nga3nJa4krxZaKI9S1ueggT7j0QIUVPLbQ0Bk+IBuYbg6P24IJ2BQ0bNdGj7FjgY81Wa+YOQ7rPeWVxkLZumb5EaRncOi1Wxr19snZ7Yq7R2MpwgKVhgAEZXrV0zyo014yk5YiP6A07unji9yqK+2qE5lZvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB8PR04MB6953.eurprd04.prod.outlook.com (2603:10a6:10:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 15:07:29 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 15:07:29 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 1/2] btio: Add option for binding iso broadcast address
Date:   Wed, 28 Jun 2023 18:07:04 +0300
Message-Id: <20230628150705.248285-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628150705.248285-1-iulia.tanasescu@nxp.com>
References: <20230628150705.248285-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0034.eurprd07.prod.outlook.com
 (2603:10a6:205:1::47) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB8PR04MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b27b0d7-e77e-4da0-449c-08db77e963c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMg0mKCBqpPR0R2fP3pu44GUeR/5rYvMaxwqGmpDtYcg7/cndJD/R4mLVndacLSi/bTsJHW8idokm0NAwqXQdlxjf2m68WwnDeoAwhThx3yRmaH5Gcwk6j/eKzPa9OLg7HOT9c96gkFlzEhHOajsgROginxmLaeN8TcPk3umiTBJXZIpDOzehjBJq6Pozdj/eqW6RCHWs2XHCqNRAZYtNCSfYNSqvgsYBqmBVxFUHRz0OsBkN+A5pbTL3caCrArNpWZX8fHHWuUmcEDLWMxhkd6TtzX8Ocg/p8EUAgkh4oB3IrktM/T1PFCHxYTjC17Hxh2v3v1iIOmsKBhsWqo/tCcoFlGXQ4mvZGh5Dm4BkAcciEsGKOrEu/yRRn4c6zeaWCacjK2h7+Z2uhkAOl+HUgLFuU3KULgBvxg4mDGyGrip9WEOLr9tThGT5FrVAswbDYAGclDCis0pKnuUGskWarvFcsCZIJfTovsvBBFsTHgM2NqrtPdbEPxb0+Hrf/leoWTNZl9PL5wGOTAzKBCMQM8yy9IgtwbhekMo3v4sYMFZOpuFykFFuUtmLViQPGK+dFDABFGnQ5W73KiW9qKi4fKUlAbrMZF2Zanwy4vD+rGhqAyH3zU792IZPyL7ehDp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(186003)(2906002)(26005)(66476007)(5660300002)(41300700001)(8676002)(6666004)(6916009)(36756003)(52116002)(316002)(2616005)(478600001)(6486002)(86362001)(4326008)(38100700002)(38350700002)(1076003)(8936002)(83380400001)(44832011)(66946007)(66556008)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ii4MQ/3/hHfcVsecAX7/H1MHvkRRRN4kM0xcZ3IF57BNOLBD5PEJqU2zhmO4?=
 =?us-ascii?Q?RhNQcx170AVhD0jLYH/5h2/Pi7GmNQXj5d9aojmYeqh1ibMQZzuYs86iG5dm?=
 =?us-ascii?Q?IaWX5OTAY1/dGaJA9/ub4a4F+8JUshEGF8PkHyo/B+K+ASFVoKTsgz33XMui?=
 =?us-ascii?Q?Y5jdHhLOyuzyKZG52UydSnLz3bWlcoSUDxqmGkqc8wiJSBZhIn2NsYifmaTB?=
 =?us-ascii?Q?Qa/aypCQhTxzvGCx0/gH/AziOpSiMbldPi/FuwFjF6m0NClSR/PfJLkcOZ52?=
 =?us-ascii?Q?kl+BuVpAhsYRU8s0qX4HEtaNKblFF0o3z6V2dSEhX3rdcWvChqlLpmarKMeA?=
 =?us-ascii?Q?AZDmVeIhWal/0QEwcLP+1QtBlLf16pre1O8iKq34SKvqf7sl/z9c35HXKOon?=
 =?us-ascii?Q?deh3tcv0slKgaLuW2fcAv6lyrhpnXGmRasMrrOf1o+VXqFhLdb0Dao/ANM6x?=
 =?us-ascii?Q?JTFLB+8YuT34Ll749XFKjx9jXl6ikhWMw/pjj81tlg7+SRQPCea54BnXURs8?=
 =?us-ascii?Q?ppYp3fBCVoKk8LadOdBcqRczJWuIMr5QNiBZ0QbLAkTageeHmVZhMpBXZtgu?=
 =?us-ascii?Q?qUNAumkyQMDJp05EVQbl7JeRiKHhPQ0khzi0zjqUXwvynwvHQO7lnLKnYCMr?=
 =?us-ascii?Q?GGMIOSqrM8Q8+y18vM7/THlVKm2nuOkJrX1y7MosJOGwRlwp2XU9PxNavpet?=
 =?us-ascii?Q?oAPqxIkxh1RTP1jSUTmb6kkekpF6wr5JP9Di+SfgrWeTltficCvoA459JxBB?=
 =?us-ascii?Q?6Pem9SL5mTY6RcidHI+r7mCelAnUa+yU0NKeywTizsLe4bAEh5Gz69QYZcZo?=
 =?us-ascii?Q?6nBXCn6z+P8ns0VCxd9aVPuJ8uGvs8z9VgTTAjugm5xTK27VpRKuMgzeR5YA?=
 =?us-ascii?Q?BsxXFHQezmAtr3Jp99nt79qHoV3/D3+A1xW47yI+I25p0FQbQFsoohMxXjZY?=
 =?us-ascii?Q?QqEvjc2dsCJHpsTKRaOLgKxQ/c7ycYGlgNbHgJWtGAT9Q/naznrF8UHOx+Xk?=
 =?us-ascii?Q?BQRllthelEZNkcfc4GllFrcTBNxnWSznHRl3zxWF9YyfW8Pv85/y3a/sOz+i?=
 =?us-ascii?Q?480wn1qD2UL0WlXqjGbuJDjM35YIM0Mbuj/5yx8Mn+NlMEoXoYyPdFNgTN25?=
 =?us-ascii?Q?aYFE2i3Yy6MhnxDyxXTkuXz0ns8uIqSwK8WSsLxKBYZSbc8UkKhqDyKf69tj?=
 =?us-ascii?Q?SPRkoF9R9QCn95fCe4jJQE5p5WzB/AVkDGzP2TCbY6SXzoRZZ4h7R8WbSPcI?=
 =?us-ascii?Q?3r1f8z+CjoJcCR+fVY5idHjBI6tjRXjMTw47VvqMQhP0j503zXQ2NkuAdk1s?=
 =?us-ascii?Q?JI/NFimi1MMFcZ6Nz+br28ARnw1p5G+JDuQIXf6qksEzoWFLeHzme8Sm36Qj?=
 =?us-ascii?Q?tFa3ZmgVCwlHGF7or/WXotAQ8D/Mn2AAgCiaBjRs2jyUyB72t4r3c1jgApJn?=
 =?us-ascii?Q?rv9gVJ2V7rrezYWApkKBzGWzKOA5Ipt2V40Ab0kIhypMoiPhGU3NMRmMg48b?=
 =?us-ascii?Q?5WvO+4uCEWDbx4lZt78VUF3xAzu3a1S1sMQ2fBUYOfd9g/pwTT04an7NZ7rF?=
 =?us-ascii?Q?thGIQc1LGjdB/nTMTHYlmnsRvhk6+V9tncgiXqdD+lsunShyDQBTbpHXm3UN?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b27b0d7-e77e-4da0-449c-08db77e963c6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:07:29.0481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CoAK12QhgRWzeC/au/pjD7K1Sim0PFrTIlNEHzIvHMYzmQ5NSHSLyJrF8bFEacnrlTSAC169oR1cXerbDOhgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6953
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the BT_IO_OPT_ISO_BC_ADDR btio option, to allow the user
to set the iso_bc field of an address at bind.
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

