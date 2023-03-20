Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E071C7618A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 14:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjCTOiS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjCTOiP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 10:38:15 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C0B28D1D
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 07:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA5NL62NhWlwrsGEntdOFLTeehMKVMN8ryNOOq5e6pr1GXzzBlgv4LYLznPVYRle4sizVeoKVxFOOOaqLhDXqy3nP/TEbnt0+neOK3M9mkkrFVC5bZJLLh7KurnyGlHOVqdIw5OViMUz93DNiDSft2HPTMj0Rdt7WbDkvld5XVdFqkDvWGsoxZ8ZvAqBTV5izChsI98VMCWvzy6NbDNOkSVLpxLgtT3wkEbiiTQbZpxq9ikDL7CbYDhEgq3uGjETRkp+bQaRouVEyYK+AOB+bIYl8hOBIR67iHgvJX1RrabVSt7gfk6A72ozIjBcZnC59W65CwbVr+KOmX1WpuOgPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEiqZo+mSFJ0XYUj1u8d0Dphps7jH4PyC6Vsutp3MgQ=;
 b=cMvpnT5TjYeOSAnlpUw3zkQEtKqdPwnaOBM//+eaTVWibipgbvx7+SEu/+iGVAh4Iruy0poOsOL3EDAGjdPIrk74rR1zN1sBxVmzmCZtVNjjwGqhzAW+FV98422FZKaYP3yHh4y+isUwgFFknTlr6mQuIA5/l+eIgEfQN9kbgfHFHpSV3GQPCg2SWv+2aNqV+z5iycGP//1fAFx66b0KrKh3koeulIh+RgpcBHdcMV+FSCQ2o9hXjPP/YtJI3Ms6CLpwqZlCD6yon9x+4nu+P/Ds+l7r3hf8fQJUeQ5hSPpSoJYKzV3BQ2DqgU9ctOcMQydNCw9XmcWDdNiPC0G2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEiqZo+mSFJ0XYUj1u8d0Dphps7jH4PyC6Vsutp3MgQ=;
 b=Em2C6gTGKTN281LOfoF37PuHJXQUI8fGLG04oMvJmQ65QXhS9fe9ul1cQzhsHFKg63J+ao1oh9OOEYbSw0V6lO/c55w+VkCy9LFXOrTMVyLyHsGloDQfZhlZOzXrvZmLkipI0TpDUGCSNSaYH/3ov5uc4NJBny4zYoVW+WJqtsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:37:34 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:37:33 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/8] client/player: Use unicast structure for ISO QoS options
Date:   Mon, 20 Mar 2023 16:37:07 +0200
Message-Id: <20230320143713.25449-3-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8063c225-00c3-4975-a56c-08db2950a48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJxW799H0WGBGhmcb4j7Hn9mp328Ij38/Dj6FwZtazAIY7aH7mZzDShArKk2McJG/b+MnbRoKGYN/s9qLXY9vwb5VgO3OV3cLzbR/YkK2IwohomztkyNr74ownIwfapPZFHzJdW8R7iYD75L8u5f18OtyBfCYHB3sPwvJEDntkupyRnAfVa2aZKHSx3KaWUtxvzRcQsVykQQs9YW2ZZw2cF2O/OeFmVViBZjtN2/6a2OTMzl46fowpRQvdomcHZChMlLXQTJYGcPr6hV/hbWbBRm48jh0nQMG4Ay2XXdhFAQftVViD/Psp70UkqSm+ZcIi9UXgcaCuYzKqZ7+cnl14E2/7aIxl82UufhTWA5KlcUnLB/TvKgHQSk80NgLOhxI5VUgiFTl5V95o0Hkwcl5lblxFBC+Dj4F2KYU5gl6hUJ5x3AmqsAeVDpYQq5HC/94mbFLEz/v6R1qFZEyjyLdGzTPLjsNccZl4bzrxfnztvPZLSvTvvMeuRR4Sgl4QRIlnbM96f+Ef7cjvwOZvmrB67hb93DOQ6/JwZdNHs8+jdtqC32gBYD5AhYLrSh7Oh6tYagoH+RR6gXOugOZxVTLSrBCWtPqx/Mdo/FcYK89gcRalMaxYFz0cofHb1ofa+SIYil6UBWBmdj1hE6o9vHSWXsDRCgHwoCbUgzx7AmNAJ01gtX/h68FZ8GuSRPLqN/gtFJs//ajDom03WEJ9fcLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(6506007)(2616005)(1076003)(55236004)(26005)(6512007)(6666004)(6486002)(8676002)(4326008)(83380400001)(52116002)(316002)(186003)(66476007)(478600001)(66946007)(6916009)(8936002)(5660300002)(44832011)(2906002)(41300700001)(38100700002)(38350700002)(86362001)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RkLb1ppM7pJbK6DRe3BbvGw9Npez1Wefz/VGjg/NfbzP7BkHd4SOLtt/FkZP?=
 =?us-ascii?Q?lS074ERbfu/0TNEEov4Ih6nIy4SdbdkwMrTNNewMIu0g75r3Sd/cMXelPtKr?=
 =?us-ascii?Q?/VoZUkx+KOO+CT5tumsQHF53iBZdMICaik5632fvxi8JgurIQYWtyNbnh6KL?=
 =?us-ascii?Q?HL13em7kdQxqsu2kmN3C+wMBdjCcB7aTUr8NW8u4jei9i4tsJ1/68Gfus+YY?=
 =?us-ascii?Q?4VHFWrOCFx82hNBiLripR+u0OSlgBCnoYL4sHaOtkJrPbuf+dwWhloFkJlQd?=
 =?us-ascii?Q?L0sCjItS7SaLzwENJVDU+ZGXRENGOlesAOHxUw+9lL5UmmsFws31s0WqvhEs?=
 =?us-ascii?Q?P25kRoXH56th0Dx3IbjY5DEa4xqN8OtvzJEmmCpSei8BF09ZqBbkwiqHj+Ul?=
 =?us-ascii?Q?31dWVqCDQypghm58UbuXPh71VG7EfeQWpkwyOb8rFYUnZQn4gG5UoFlhnf7c?=
 =?us-ascii?Q?8Y2kw1mtyQk8asgu7R264qKRNnuI9bMK0b9ngmG9mzU+KUaWQH8tOCDXq4Oo?=
 =?us-ascii?Q?EsM2IaxEsd+1NdmsULUCf9Ag4oms+t3+HYZIfR0ZN+ou/nd7crG3y957uh57?=
 =?us-ascii?Q?YAmZqme/w1jWFw5KvOHOZE4xmZo88okrlvLVupJTlf3GNag8N7pWyMuNGWSF?=
 =?us-ascii?Q?Re1iELWjz+vEVNnr4fqDG/JNgdK5ZEGiJKFcRPRJTlx9W3eeaa83TfEgi+LR?=
 =?us-ascii?Q?OMMhDKiBsuPDSPJexUr2knXslPnv/hOz+/20nJJc/iRE0qO00jeV7ixTQRl3?=
 =?us-ascii?Q?8cCoHWL2FDNoiD2KRAC4Ow+kwmum+cX40jwC3Xl0uHikiEFFIw/nDyA5Jybw?=
 =?us-ascii?Q?dSiqoyhN+TE16sgEYHQzBd/m/DY6+jeBlVp8w1fwaWww9GR9fvCejs58B39j?=
 =?us-ascii?Q?U9xRjMe0e6+7kCK0BcBkBvRDpic7ac7QRQ/0rsfIwQxhz7SjNCLGVQjQP90v?=
 =?us-ascii?Q?yLE9NVhS86Lkd93qkdvDmbWzyt6Bec8IGT+BNgMZ3Hb2lr6HUf6RIdq+0hN9?=
 =?us-ascii?Q?KMK+Gm038ryc1Vny3b6JYfQPjIhUYDzl0Ulg9s0aESpbsyR/DP1UP75lKhxe?=
 =?us-ascii?Q?371/h2En/HM7m3dCnkD57b0Lu72KkTFRY+vPyAg7m2BPSKL0mzvH3SA7PORK?=
 =?us-ascii?Q?b7v3BNfTLaQnlIc10QWPziTeT5DdwZ5TPFbrtd1y0acVJErJsvaehcAm9r6V?=
 =?us-ascii?Q?fvbg699786KdqypTyXyC3nR6SbyeJZ+TmMli9GU9+T1zGlLvXEtKeaMIttXB?=
 =?us-ascii?Q?PInh5VETy1Rq+1x/dfH8pvX+g2fDNbMizzGuvlG7HytFOwuXmKVNg6bdGftK?=
 =?us-ascii?Q?J/GqT4KAAocXvEf4Ws09WL7+3rh79O7O+6tP0+OBESWW36SLmGU0Ats0dP8h?=
 =?us-ascii?Q?s1/wMUovJbo7tJsuM+G7rImS3V3y9P2KFcflSGKWANQh6Md8KO7X2+vD9Ce5?=
 =?us-ascii?Q?HNinGWuw5ctnhHVfgJcxbHKWR6VyiQ5WywTzJlrmMIj1q1nWixSqT2jI8xxI?=
 =?us-ascii?Q?WFc6lKVoj46ydhCXcgJ6ONF13YkxJj+vdXo69aScv/mNPN6NBJssZL3hXdzZ?=
 =?us-ascii?Q?aInHX0xPUjpBw243k0LZoZ6/PyPGCOv39X4Fon0Ju6/TJcENRyZq/JNzqxyB?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8063c225-00c3-4975-a56c-08db2950a48e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 14:37:33.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERS63nKSJhhtgnXusS+EVimtRhanU5t3cdnjG+WnH4NVkGecsm++7sHjl94z4qVSKOjxMF5cWhx0bsX3uUHsFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Convert the generic bt_iso_qos structure into the dedicated unicast
structure for ISO QoS options.

---
 client/player.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/client/player.c b/client/player.c
index 63e11db09..83b6092a4 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -3506,7 +3507,7 @@ static int transport_send_seq(struct transport *transport, int fd, uint32_t num)
 static bool transport_timer_read(struct io *io, void *user_data)
 {
 	struct transport *transport = user_data;
-	struct bt_iso_qos qos;
+	struct bt_iso_unicast_qos qos;
 	socklen_t len;
 	int ret, fd;
 	uint32_t num;
@@ -3526,9 +3527,10 @@ static bool transport_timer_read(struct io *io, void *user_data)
 	/* Read QoS if available */
 	memset(&qos, 0, sizeof(qos));
 	len = sizeof(qos);
-	if (getsockopt(transport->sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos,
+	if (getsockopt(transport->sk, SOL_BLUETOOTH, BT_ISO_UNICAST_QOS, &qos,
 							&len) < 0) {
-		bt_shell_printf("Failed to getsockopt(BT_ISO_QOS): %s (%d)\n",
+		bt_shell_printf("Failed to getsockopt(BT_ISO_UNICAST_QOS):"
+					"%s (%d)\n",
 					strerror(errno), -errno);
 		return false;
 	}
@@ -3552,7 +3554,7 @@ static bool transport_timer_read(struct io *io, void *user_data)
 }
 
 static int transport_send(struct transport *transport, int fd,
-					struct bt_iso_qos *qos)
+					struct bt_iso_unicast_qos *qos)
 {
 	struct itimerspec ts;
 	int timer_fd;
@@ -3591,7 +3593,7 @@ static void cmd_send_transport(int argc, char *argv[])
 	GDBusProxy *proxy;
 	struct transport *transport;
 	int fd = -1, err;
-	struct bt_iso_qos qos;
+	struct bt_iso_unicast_qos qos;
 	socklen_t len;
 	int i;
 
@@ -3626,8 +3628,8 @@ static void cmd_send_transport(int argc, char *argv[])
 		/* Read QoS if available */
 		memset(&qos, 0, sizeof(qos));
 		len = sizeof(qos);
-		if (getsockopt(transport->sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos,
-							&len) < 0)
+		if (getsockopt(transport->sk, SOL_BLUETOOTH,
+				BT_ISO_UNICAST_QOS, &qos, &len) < 0)
 			err = transport_send(transport, fd, NULL);
 		else
 			err = transport_send(transport, fd, &qos);
-- 
2.34.1

