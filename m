Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B02C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 14:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjCTOjn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjCTOjX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 10:39:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5F64EC7
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 07:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmKIEzV0yRWkB2+lr24416MZFV3imWuAuRg9qgRckmJvmGvYI94WdiYqZYVnQZ0HJl7YyNpchsAW8sA210WTc58BU4da0Ik1aYi08zA0A/EC7JGk+QefWHsGlY63a4NoYwghApAqt9fnjzbyK9l7FpuHLhR7uw1ULmLR3F4TDimSsGwDMhPQihGyxkcaPHGyoe4yj5NTzuDK9Q1xFB8SvbXk7oI6GMEnRnrfmtoQufNyRiZU5KfY9o7McrDMQL+zu8uLYsKLXWpYgqvV1Z6PyHMttT1vJLFI+8tVe8hlm7lvBOX9IqhyBVfBKSWyq2qktSjwf7lg08vC7CN3fj5RdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOevsh3RkaSlqyb3JVWJIle7kUDvz3eog+zy+sAEO4w=;
 b=Ay0v25jw890XUmczfNqX5+KfFM7KrFT96FKslL8Ose9qA/1Z+ztNIXJW+QYa9Wid2DOpnyI6eYGGHLXDwiXqsavJmwXKMdg00Pz5CuqUnACbN+7UNgw1sw3JzJq8+Rt1Oy7Dil36lAR5FJSmhHMKVBc70mupKXeg0VJdmqCXkQYMflT0pK8cRT3HUD1QIA0NMfuvq1V2k0eUWpbovyKIZv8tKEXfrAuOPP0p2QGMJK5CCeU4JSG1tl9yeljah/vV1uTzIvp5/1qCUbPP0xN1ov+ZBH0ZFX9bactN20r4d28LfTXw6FLk93RXLX3REShKQjI+lhnfiG5vMbe1Fkt/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOevsh3RkaSlqyb3JVWJIle7kUDvz3eog+zy+sAEO4w=;
 b=MwcfoQZ/YV8stcYGW0WH5vjlAGyiJX5M/vmBoNT9Pkaxb/P+1XViGavEBU1YyazTBU/cqASpuARcZBGe4G34BbHInRiewfHzVPBm1xXqC40/WvXtuOK2hj6z8Dm/4UenVCo/tFHuJ0ou/22e2uBCGklfPraPlGEcZlC0tAKYZkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:37:42 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:37:42 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 7/8] tools/isotest: Use dedicated ISO QoS options for unicast and broadcast
Date:   Mon, 20 Mar 2023 16:37:12 +0200
Message-Id: <20230320143713.25449-8-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d2b7113f-59a0-4341-18c8-08db2950a994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tWBLeDsgsDwywdnQ89oPOqboiFizin6bQWW0g1QNoZkAd+El8exa7yt54kkqVUc/8euL0VhSsRHXFT/xT12YSfhRCXSx0vQM9KlYA8UYeWO4VdXD8lm91n9BDJqjJaXbx70xkBk0msALc0wBQOX0wknX1TH44+dDyDB0T8JgfxT5gysshjdd3AtriiUm4K0m0pm6OzjlbeQxgOxhTHH46riXJuoQjjBTH64M4HdSgK6DiWgNrVsfIORysZLXQojgo/BMWVOZJggSqjp24rbZFhmtgLvoMWsuHqRLm41iblw0V7dCmcS96Ips3y7FbdkBbh2D7K1P4pFecH7t7D1/XvZzWrhpkkUOAyFn8Dj4qtye8p0wxgnjPjNETDA5tSvxXnNKXaezM8UI0ClkSNGHq4swSy798MD0zTC9eKVlSm3keH+FH4yHdTxWpbJXMgJJqKTXsoSwxtu3EDtLv7YjnoUo5w4WfPD44EfAdPoqgK0ULaskJ5K5aA7tVBZYT6aUscs9iHQRQ3ulwsy0YjTpdeuUm9JO6eEva+ch8PfEuz8vV7Euepz1cByq9S0/H8KJM0B346/L/ytkAPwrCqe43THjAk0KZJ+6EO6PDzETRY0zX0lgWgoRNvgLlHwTRV440HqQxXjQitP6SBPcQN2c0mcQUBwJ2LQnqUZr7PIJ5wl6JOeDcxo88AwO2puu2Nw+0yaqF2msG13FX7aw5mNlAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(6506007)(2616005)(1076003)(55236004)(26005)(6512007)(6666004)(6486002)(8676002)(4326008)(83380400001)(52116002)(316002)(186003)(66476007)(478600001)(66946007)(6916009)(8936002)(5660300002)(44832011)(2906002)(41300700001)(38100700002)(38350700002)(86362001)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cU6NTS2IaLuw3TbyW1ytvkIKOb4KpZT/BuVdkHg2bs9ZDFHhZCX7h0cWApD8?=
 =?us-ascii?Q?bgfai0dZ/n0UJ9bYPC6SSvnMNU050Z5vTpiOwHIK3rABEasOsI7Hgtkot4vs?=
 =?us-ascii?Q?mIrOQms/Updw0hbbgzVhxLPcQz+eZugYHYpWD2YyaIgSx1gLAp5pP1UAMxLj?=
 =?us-ascii?Q?Tn6oUlJjA5ZrLEblnzDUdLJV6R+Z8qDnh4WoFlc1GOyL+AAXDPDzq0Uz1KZp?=
 =?us-ascii?Q?Y7tgpeRb76QQm0+bkfcjhUaNOVpQWStlqqtxYQNCZuKNkEk9UFHyoDURjM4q?=
 =?us-ascii?Q?x9nrMinEttpCnBFhzOw+GEaSOVaq6quAPEXDRzW/xevkpt2vmEm2c23ybn4u?=
 =?us-ascii?Q?n6uodecHJBIy3jORI7o7YhFZOy8oqETeXG9GaltYbFNoMkWEkvsrZxXMQ4/1?=
 =?us-ascii?Q?xcRUELflHZ1chmUob2TszIWXbfsoJCUwlgj2dci6Xtc5k96Orl0Jahdzce58?=
 =?us-ascii?Q?dlMf+QkM4ZBxm+OReZnpsBfPWS5SW6V3Smz0vPikh0B1Z0x4EyrACi1qmC86?=
 =?us-ascii?Q?S8WcF88QaZm+71lEzICMW4RXTmui5BLF3ZOPz3n/vmPK26omxmlHnsjZzmDa?=
 =?us-ascii?Q?Rjg2ZntLxSQOjo2n4KZKRhE3E35u9ItcWiKvLJTQWeW302WTkeHK876ZdXoh?=
 =?us-ascii?Q?MDbQaWAxIHr8GUjKiebCqDmyjnWpk7TDis+/6jFI3H1eeuujOqaH5c8JGFok?=
 =?us-ascii?Q?m8708UQKlqHcBW86mP58FQE5OMmyUR7xog/OIk9t7+NKG+oXDkE7nGKIrvQR?=
 =?us-ascii?Q?AZ4WsFN0dhwPf/NoVBUglAENvOJQ39ysSQP0vlKCsKxPipqoF6GGVRtx9kFr?=
 =?us-ascii?Q?QDaIZzQcUx2cjXX12wZ9T39uysC9tkNUryLhNjM1ICcC0rAsxXpwjMAIaR5M?=
 =?us-ascii?Q?EKcx4vQJ4X1ouewotSSnykMQ2xv1tT+pTCFKbbI4SaRi5lyPK6roBZd6EEYy?=
 =?us-ascii?Q?bFW8mGqzdFExJNRNUAEO+XVdC9Jh3haup9CyipVQSKDNJnvZ3sH695zXAntk?=
 =?us-ascii?Q?zjf+miNf3Wgoh8byl1GwMQggIYBVELDANvAbFoeBOdNGX/hGoQDdnNQJwtsL?=
 =?us-ascii?Q?bGp9MwvaLRGaYmst8q9jHavqfSdv9YZARMIhHapXALUl6rx0ANzYlzv5qTNJ?=
 =?us-ascii?Q?w4SoEDPlBiNxVZ8UBVKv+zzig7QZzJASYg6HtGZyXqa/8+kkuPbefbONxUbl?=
 =?us-ascii?Q?dF89gnBOqM778GpZEcCcI9O4RpKfFlosNtvUn4VnenZ6EZqupl38sR+//rzv?=
 =?us-ascii?Q?lYtX4vIrCrxukk3xru/ts8YjAmEev1tAFxgG/jKYQuDnOzL8eqeVD6lERxDf?=
 =?us-ascii?Q?6MGef0nthUOX59FnVxUL2RZ3pfbCjFkO51Svwi3amXJNBsX/L57JdXgrLoyB?=
 =?us-ascii?Q?J9tbk9Divcw16KO9yYLJZfdW2x8GlkhkDv2bbPfr3iw967A3Tk5Bs+b3RQ1W?=
 =?us-ascii?Q?M90Lw41UbY/9KI8oyzuWmN7Vvc3uSz8uyLlLmyBaGphVSBS6GOMQG8BhnK/A?=
 =?us-ascii?Q?F7GU/yyacM0Joi6kHumTNLbR6WQc8j3jaQJOpT9qawc86AA+kHTLHNMeT8JE?=
 =?us-ascii?Q?4LpFz2UbtShpQ+EHf3o0Qx9Tfvu2re4+tjEw7ipBNDLPti/VCdyBCvljWtxC?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b7113f-59a0-4341-18c8-08db2950a994
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 14:37:42.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykFgArHRnnel35s9lT16fnDgdfMG2Nj163M9+cGw59FKyf/RNmHPdtRUht++5jj09IbU4LKEZsHG5RRcf8Lb9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Convert the generic bt_iso_qos structure into dedicated ISO QoS structures
for unicast or broadcast.

---
 tools/isotest.c | 159 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 125 insertions(+), 34 deletions(-)

diff --git a/tools/isotest.c b/tools/isotest.c
index 2b5f164de..f12658812 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation.
+ *  Copyright 2023 NXP
  *
  */
 
@@ -68,7 +69,7 @@ static int sndbuf;
 static struct timeval sndto;
 static bool quiet;
 
-struct bt_iso_qos *iso_qos;
+struct bt_iso_unicast_qos *iso_qos;
 static bool inout;
 
 struct lookup_table {
@@ -239,38 +240,94 @@ fail:
 	return err < 0 ? err : 0;
 }
 
-static void print_qos(int sk, struct sockaddr_iso *addr)
+static void print_unicast_qos(int sk)
 {
-	struct bt_iso_qos qos;
+	struct bt_iso_unicast_qos qos;
 	socklen_t len;
 
 	/* Read Out QOS */
 	memset(&qos, 0, sizeof(qos));
 	len = sizeof(qos);
 
-	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len) < 0) {
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_UNICAST_QOS, &qos, &len) < 0) {
 		syslog(LOG_ERR, "Can't get QoS socket option: %s (%d)",
 				strerror(errno), errno);
 		return;
 	}
 
-	if (!bacmp(&addr->iso_bdaddr, BDADDR_ANY)) {
-		syslog(LOG_INFO, "QoS BIG 0x%02x BIS 0x%02x Packing 0x%02x "
-			"Framing 0x%02x]", qos.big, qos.bis, qos.packing,
-			qos.framing);
-	} else {
-		syslog(LOG_INFO, "QoS CIG 0x%02x CIS 0x%02x Packing 0x%02x "
-			"Framing 0x%02x]", qos.cig, qos.cis, qos.packing,
-			qos.framing);
-		syslog(LOG_INFO, "Input QoS [Interval %u us Latency %u "
-			"ms SDU %u PHY 0x%02x RTN %u]", qos.in.interval,
-			qos.in.latency, qos.in.sdu, qos.in.phy, qos.in.rtn);
+	syslog(LOG_INFO, "QoS CIG 0x%02x CIS 0x%02x Packing 0x%02x "
+		"Framing 0x%02x]", qos.cig, qos.cis, qos.packing,
+		qos.framing);
+	syslog(LOG_INFO, "Input QoS [Interval %u us Latency %u "
+		"ms SDU %u PHY 0x%02x RTN %u]", qos.in.interval,
+		qos.in.latency, qos.in.sdu, qos.in.phy, qos.in.rtn);
+
+	syslog(LOG_INFO, "Output QoS [Interval %u us Latency %u "
+		"ms SDU %u PHY 0x%02x RTN %u]", qos.out.interval,
+		qos.out.latency, qos.out.sdu, qos.out.phy, qos.out.rtn);
+}
+
+static void print_bcast_source_qos(int sk)
+{
+	struct bt_iso_bcast_source_qos qos;
+	socklen_t len;
+
+	/* Read Out QOS */
+	memset(&qos, 0, sizeof(qos));
+	len = sizeof(qos);
+
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_BCAST_SOURCE_QOS,
+						&qos, &len) < 0) {
+		syslog(LOG_ERR, "Can't get QoS socket option: %s (%d)",
+				strerror(errno), errno);
+		return;
 	}
+
+	syslog(LOG_INFO, "QoS BIG 0x%02x BIS 0x%02x Packing 0x%02x "
+		"Framing 0x%02x]", qos.big, qos.bis, qos.packing,
+		qos.framing);
+
 	syslog(LOG_INFO, "Output QoS [Interval %u us Latency %u "
 		"ms SDU %u PHY 0x%02x RTN %u]", qos.out.interval,
 		qos.out.latency, qos.out.sdu, qos.out.phy, qos.out.rtn);
 }
 
+static void print_bcast_sink_qos(int sk)
+{
+	struct bt_iso_bcast_sink_qos qos;
+	socklen_t len;
+
+	/* Read Out QOS */
+	memset(&qos, 0, sizeof(qos));
+	len = sizeof(qos);
+
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_BCAST_SINK_QOS,
+						&qos, &len) < 0) {
+		syslog(LOG_ERR, "Can't get QoS socket option: %s (%d)",
+				strerror(errno), errno);
+		return;
+	}
+
+	syslog(LOG_INFO, "QoS BIG 0x%02x", qos.big);
+
+	syslog(LOG_INFO, "Input QoS [Interval %u us Latency %u "
+		"ms SDU %u PHY 0x%02x RTN %u]", qos.in.interval,
+		qos.in.latency, qos.in.sdu, qos.in.phy, qos.in.rtn);
+}
+
+static void unicast_qos_to_bcast_source(struct bt_iso_unicast_qos *unicast_qos,
+				struct bt_iso_bcast_source_qos *source_qos)
+{
+	memset(source_qos, 0, sizeof(*source_qos));
+
+	source_qos->sync_interval = unicast_qos->sca;
+	source_qos->big = unicast_qos->cig;
+	source_qos->bis = unicast_qos->cis;
+	source_qos->packing = unicast_qos->packing;
+	source_qos->framing = unicast_qos->framing;
+	source_qos->out = unicast_qos->out;
+}
+
 static int do_connect(char *peer)
 {
 	struct sockaddr_iso addr;
@@ -306,11 +363,25 @@ static int do_connect(char *peer)
 			iso_qos->in.sdu = 0;
 		}
 
-		if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, iso_qos,
-					sizeof(*iso_qos)) < 0) {
-			syslog(LOG_ERR, "Can't set QoS socket option: "
+		if (!strcmp(peer, "00:00:00:00:00:00")) {
+			struct bt_iso_bcast_source_qos source_qos;
+
+			unicast_qos_to_bcast_source(iso_qos, &source_qos);
+
+			if (setsockopt(sk, SOL_BLUETOOTH,
+					BT_ISO_BCAST_SOURCE_QOS, &source_qos,
+					sizeof(source_qos)) < 0) {
+				syslog(LOG_ERR, "Can't set QoS socket option: "
 					"%s (%d)", strerror(errno), errno);
-			goto error;
+				goto error;
+			}
+		} else {
+			if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_UNICAST_QOS,
+					iso_qos, sizeof(*iso_qos)) < 0) {
+				syslog(LOG_ERR, "Can't set QoS socket option: "
+					"%s (%d)", strerror(errno), errno);
+				goto error;
+			}
 		}
 	}
 
@@ -338,7 +409,10 @@ static int do_connect(char *peer)
 
 	syslog(LOG_INFO, "Connected [%s]", peer);
 
-	print_qos(sk, &addr);
+	if (!strcmp(peer, "00:00:00:00:00:00"))
+		print_bcast_source_qos(sk);
+	else
+		print_unicast_qos(sk);
 
 	return sk;
 
@@ -441,7 +515,10 @@ static void do_listen(char *filename, void (*handler)(int fd, int sk),
 		ba2str(&addr->iso_bdaddr, ba);
 		syslog(LOG_INFO, "Connected [%s]", ba);
 
-		print_qos(nsk, addr);
+		if (peer)
+			print_bcast_sink_qos(nsk);
+		else
+			print_unicast_qos(nsk);
 
 		/* Handle deferred setup */
 		if (defer_setup) {
@@ -648,7 +725,7 @@ static int read_file(int fd, ssize_t count, bool rewind)
 	return len;
 }
 
-static void do_send(int sk, int fd, struct bt_iso_qos *qos, uint32_t num,
+static void do_send(int sk, int fd, struct bt_iso_io_qos *out, uint32_t num,
 		    bool repeat)
 {
 	uint32_t seq;
@@ -662,14 +739,14 @@ static void do_send(int sk, int fd, struct bt_iso_qos *qos, uint32_t num,
 
 	for (seq = 0; ; seq++) {
 		if (fd >= 0) {
-			len = read_file(fd, qos->out.sdu, repeat);
+			len = read_file(fd, out->sdu, repeat);
 			if (len < 0) {
 				syslog(LOG_ERR, "read failed: %s (%d)",
 						strerror(-len), -len);
 				exit(1);
 			}
 		} else
-			len = qos->out.sdu;
+			len = out->sdu;
 
 		len = send(sk, buf, len, 0);
 		if (len <= 0) {
@@ -686,16 +763,22 @@ static void do_send(int sk, int fd, struct bt_iso_qos *qos, uint32_t num,
 				seq, len, used / len, used);
 
 		if (seq && !((seq + 1) % num))
-			send_wait(&t_start, num * qos->out.interval);
+			send_wait(&t_start, num * out->interval);
 	}
 }
 
 static void send_mode(char *filename, char *peer, int i, bool repeat)
 {
-	struct bt_iso_qos qos;
+	struct bt_iso_io_qos *out;
 	socklen_t len;
 	int sk, fd = -1;
 	uint32_t num;
+	int optname;
+
+	union {
+		struct bt_iso_bcast_source_qos source_qos;
+		struct bt_iso_unicast_qos unicast_qos;
+	} qos;
 
 	if (filename) {
 		char altername[PATH_MAX];
@@ -728,16 +811,24 @@ static void send_mode(char *filename, char *peer, int i, bool repeat)
 	syslog(LOG_INFO, "Sending ...");
 
 	/* Read QoS */
+	if (!strcmp(peer, "00:00:00:00:00:00")) {
+		optname = BT_ISO_BCAST_SOURCE_QOS;
+		out = &qos.source_qos.out;
+	} else {
+		optname = BT_ISO_UNICAST_QOS;
+		out = &qos.unicast_qos.out;
+	}
+
 	memset(&qos, 0, sizeof(qos));
 	len = sizeof(qos);
-	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len) < 0) {
+	if (getsockopt(sk, SOL_BLUETOOTH, optname, &qos, &len) < 0) {
 		syslog(LOG_ERR, "Can't get Output QoS socket option: %s (%d)",
 				strerror(errno), errno);
-		qos.out.sdu = ISO_DEFAULT_MTU;
+		out->sdu = ISO_DEFAULT_MTU;
 	}
 
 	/* num of packets = latency (ms) / interval (us) */
-	num = (qos.out.latency * 1000 / qos.out.interval);
+	num = (out->latency * 1000 / out->interval);
 
 	syslog(LOG_INFO, "Number of packets: %d", num);
 
@@ -746,8 +837,8 @@ static void send_mode(char *filename, char *peer, int i, bool repeat)
 		 * latency:
 		 * jitter buffer = 2 * (SDU * subevents)
 		 */
-		sndbuf = 2 * ((qos.out.latency * 1000 / qos.out.interval) *
-							qos.out.sdu);
+		sndbuf = 2 * ((out->latency * 1000 / out->interval) *
+							out->sdu);
 
 	len = sizeof(sndbuf);
 	if (setsockopt(sk, SOL_SOCKET, SO_SNDBUF, &sndbuf, len) < 0) {
@@ -768,10 +859,10 @@ static void send_mode(char *filename, char *peer, int i, bool repeat)
 		}
 	}
 
-	for (i = 6; i < qos.out.sdu; i++)
+	for (i = 6; i < out->sdu; i++)
 		buf[i] = 0x7f;
 
-	do_send(sk, fd, &qos, num, repeat);
+	do_send(sk, fd, out, num, repeat);
 }
 
 static void reconnect_mode(char *peer)
@@ -844,7 +935,7 @@ static void multy_connect_mode(char *peer)
 static struct qos_preset {
 	const char *name;
 	bool inout;
-	struct bt_iso_qos qos;
+	struct bt_iso_unicast_qos qos;
 } presets[] = {
 	/* QoS Configuration settings for low latency audio data */
 	QOS_PRESET("8_1_1", true, 7500, 8, 26, 0x02, 2),
-- 
2.34.1

