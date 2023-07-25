Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE59C001E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 11:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjGYLWU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 07:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjGYLWT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 07:22:19 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBFB9D
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 04:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Br5DWa8zRfiR4T9kbpXwWiVacTOyy7MFM2cUQVYqFl5hgNzyLKabfxGMXfceAaDGHVA204dumskDnHWEyzfCToxqYYJe0FfboN0VvdGZ8zhqUww/0MfFFjnCzlX8bOWLvM9HIbH259XdtRup4sJz9MhyH3obwmwUgQElYoCdWGCnuaL+1mb74U2ABhqAHMXo5f5BOB9GP5JjeP70Xw8l3jMe5rJTxIbTBEJmY88EC/DnZNqQo8HBsdzXBxsobHgD0oR6lhb1rg4YDaHGZRnp5Df5hIHdcjjUltUHzQQCEL5S52Vof+flZq+eeusKZuYmQP+CUU4vILrjZmfCK1FmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUt6FM0CMI+A9Rzv8goHZNKcELhgXs5Wx8XW4aHmQFo=;
 b=OHYmWfQSDwQVoDGRUYNvD8KBsVfbKHVdGrrNrb46iQhudzHsxG+mSzb9g8hIL+Q+oPfUjYYrLx1nZeDRp4QYi3RukjTBOarchApamBHfzntE0a6IXsIE1z0OVCW9wJCUV+HWOkq4aUxYqc45Je0JfYbvdTRx09cKCKVt+cxW7FuS3nxrWJ8nHH/M9sUBFggxlO5fzK8PjHffR4WSAmgIEpgKBUVrgvI1X3YNQ6cC1HVXw0ST7twhef/7Zi4UVjKQD5M9ogaXbv4NxXQ0VfONC91JmQNMZifUC3Hwf52PT3ouXRXjd8G2yfgpExYobcuh05uXv551t9Lb7wWMxvIm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUt6FM0CMI+A9Rzv8goHZNKcELhgXs5Wx8XW4aHmQFo=;
 b=S5BfMAAQ79nm45WY5yn4E42rNxrmanZTaOYqvEHTtLqsPLstZqcfIEIloiSweBKzIMeN6efdyw/zBPOcwccii/3Un6L9yX33fviPfpiEH3HoV/CdstEVaptV2PsL9XOwx9TYz8i1cApq5B5POQZuCQnAX+2OuvNcfp+2Tdww0XU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by DBBPR04MB7580.eurprd04.prod.outlook.com (2603:10a6:10:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 11:22:14 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 11:22:14 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, pav@iki.fi, luiz.dentz@gmail.com,
        sathish.narasimman@intel.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v3 2/3] shared/vcp: Fixed issues related to read audio location and descriptor
Date:   Tue, 25 Jul 2023 14:21:25 +0300
Message-Id: <20230725112126.49656-3-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725112126.49656-1-nitin.jadhav@nxp.com>
References: <20230725112126.49656-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|DBBPR04MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed5eeb8-7cce-4ab2-1293-08db8d016563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOv52yJFwwrKz3ob7ZQGkfhoeu5sXgjKCOCBPwi0D8TmieFtMefRcl/DIPzenPKsI6S1yNi9oAT0e0TWz+qqcfXXdCKAs+IO4d15egbMuiV5QzYAu4Z7dHrnZPx0xzwNRoRU9Yzbcv/Y60l65RICSZyd8uobh6MnTx1+wSAxwzG2cMZqo1QTY6NHEeiNA9D+njuzxszn31KaAcIAkJ83+yFsMeurg/cd+7ynW/B8+zoBVhc7U7LNQ2npZb6h77vb2vsp6tMFDHjTVPb2EDxIRNKdEYnNdCHBfHaW8v6UTPrAkVLSgAHMkzh+e9AmUiCi3p5ZgYdZ3DG2Kuz9eCF7TbCCIrWQyP5Qvc+iZKBTNWCgD3HFDSoj+UsPF5Ls92NCspv2KMA3hBj/f/o8AG7YPCrs7UyOszw90EnuQcSEp8QxoWOeiBGugSU7GehGU8cbW6NZ+YDE64B5JeicZcbsfRZqDoWRxgZ0yrlLWMdkco7N+t+Zzh8xoqYuCVsbA3pltr/NOqixi1hzjR5ZQToU5VHd9IfhsQFgRpAeRBQQdEh0IIONBMYGaSQRF8GG3grnQFAL3rMvFNX/H24/Myx5Zzx7Edvx7Gu1PSLnS6XkVrRSBnW3n0OoIyAoH2dT3pUm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(86362001)(36756003)(2906002)(52116002)(478600001)(38100700002)(38350700002)(26005)(186003)(2616005)(1076003)(6506007)(55236004)(41300700001)(44832011)(5660300002)(6486002)(8676002)(6666004)(6512007)(8936002)(66556008)(66476007)(316002)(66946007)(4326008)(83380400001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hpUcDeMYSN54154iOOjhVlpMjRQPKYaJdW8nsSM38arxTNwkMKf0g/5/D9Vr?=
 =?us-ascii?Q?Z/kMX0cGtEdW+98aRSSAoysijB7bgTflU9p+z2yGgGmrC0C7psJ2n9Q32IyB?=
 =?us-ascii?Q?vIpc/zbTqRzG2lHqgEIshtFC+Erel6bIjdWy2PncH04iYHdK85Q4LXNSK3VE?=
 =?us-ascii?Q?ALz4upDOk88xDZygNwm40JuAwLlZdldKUkZCOfhXlO3e6VBG3/ezOuy39AIS?=
 =?us-ascii?Q?Sa5XBnJYDnVyZFnNOhxSiq9W+pnw/cDCyRi4jO6aZzrz3A31/jt/G9at9lfg?=
 =?us-ascii?Q?ruiXAzWVRfHXKMoq/fYaZBcO57O8O1yDEWgdafe3FejoWWt5dvnlzb7kNQoZ?=
 =?us-ascii?Q?SOYfCbf78D3Q3b9pok2PnwBkW21fxlfh56wl0E8610bIqYGZHHjnuXAf2KaC?=
 =?us-ascii?Q?rLBLfnccJ7ziPxWWIBYuBCyORBvzTI3gVn080pL2WrhRz+ef7hbKnabuTVdl?=
 =?us-ascii?Q?K8rqG1V/zZn3K2RlDOerRArfc0k6TKll5t0Otl5sNqo2R5iIkS/MNes8B9pN?=
 =?us-ascii?Q?bmQ0NmiaLAz2T88m0H76nEDo8uaGWOL1ydxkQ9Cw8aojR4lJK+r5wZ9BzVH4?=
 =?us-ascii?Q?xHa4n6NgBIcMS2PYqxDGAYno1uoAAkvv2Q8BVymfYmXiLE/NhcvvFLFPEZcM?=
 =?us-ascii?Q?znTgwOoJloDKyDNEA31EktTxddWdP1VPstfxEljmhCmxBOfl45Rgyu+fn/JO?=
 =?us-ascii?Q?IGpGYsZCpqD0Mtt4zLA8X/pQkRAh9jgGRpdyXxxJFl4tOoHLEo3TUj5v2lTA?=
 =?us-ascii?Q?Ovsqz06/rq5YMrAhezBiIlnbpwsQeYsmpaWIrNb/6IToD0brT7RmtkfpToyU?=
 =?us-ascii?Q?m3BoU48jQp2maDelN54s4h7fxwn0MCjdFUNuekLgQz8zYYu3Yw+wq7Wha//V?=
 =?us-ascii?Q?1IgAe9sZlmVx7wMc1AjX+qmQH5zd9Ga730QQ3AmNUQH26dPTfh+aJ+JRdScS?=
 =?us-ascii?Q?1YS/O2yYmg9K7oamF3ZBJPSOlhGP5xWtayH7BT8RblSqoGr99CZkBVVe0eIY?=
 =?us-ascii?Q?og31l32xVYMSYEatTdtfg8I2eOlhyDvCJ+Unh1vf0rZizsSUhddf0A1Xjg21?=
 =?us-ascii?Q?7BvzEJqFPS+6JMALEnbtE5C4rM5Jgvk/BWE8uxen3YKD7rPk+FTpWdxO3R7w?=
 =?us-ascii?Q?C5RIqsj7VlO0HorPUqMuFMgKznvELPHFwWxrB3YcF7V9FeeEbUkN5J2hQqDS?=
 =?us-ascii?Q?/BK67TAV+XLHmqxLj9ZnqG6PQxQBcQE13WUjelUI+GMFI2lEv+tZqwyKIdKJ?=
 =?us-ascii?Q?qbkans8okl1JyEo1JBK5JFBWBWdtbzhahxuWMHHV23Zf+GENzbVOipxSEAr8?=
 =?us-ascii?Q?e/GjyYdGtqpBZ1e9yjrEs1PVqZur++oAsByWYaoPmCRsIb1Qiqai7ntEEgoo?=
 =?us-ascii?Q?houMq8ltDxkim9djbkuspa3WRFhR2O7jbBMsnDjoMiNi9ct0Ije/dRSwLgVq?=
 =?us-ascii?Q?ncO2YJW1g0YgZL/3s5/FN/kxOCZmO9VNossgLNkHb/gFCbTm2VYvaMcmbhD2?=
 =?us-ascii?Q?ZhNY80Ad/fyOwOR/BBLMAq/FjI8VafMUVNist01BPEWoyT4OvWDYyUJTDQ3B?=
 =?us-ascii?Q?zj80E/SMTaq0mDQesG22QRcfn23qv8e2snRSrZrd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed5eeb8-7cce-4ab2-1293-08db8d016563
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 11:22:13.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEJET26YjuHWFR0SJ9SzN/Lx/32HqkW78Panvj0Ttbe3JYlp9F3EU54vbpseseFQGBvNX/pmtrAMQ13aXrT26Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7580
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Issue
- Audio output descriptor & location read functions, requires code correction
- During reading audio location descriptor value was checked instead of pointer.
DBG statement wrongly accessed value to print the log that caused crash.

Fix
- Corrected audio output descriptor read variable
- Corrected the audio location debug printing function
- Allocated the memory as char pointer to the audio descriptor variable and
copied the string to be displayed.
- Corrected the audio descriptor pointer checking condition
---
 src/shared/vcp.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 314618664..0408531b2 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -973,7 +973,7 @@ static void vocs_voaodec_read(struct gatt_db_attribute *attrib,
 	struct bt_vocs *vocs = user_data;
 	struct iovec iov;
 
-	iov.iov_base = &vocs->vocs_ao_dec;
+	iov.iov_base = vocs->vocs_ao_dec;
 	iov.iov_len = strlen(vocs->vocs_ao_dec);
 
 	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
@@ -1385,11 +1385,12 @@ static void read_vocs_audio_location(struct bt_vcp *vcp, bool success,
 				     const uint8_t *value, uint16_t length,
 				     void *user_data)
 {
-	uint32_t *vocs_audio_loc;
-	struct iovec iov = {
-		.iov_base = (void *) value,
-		.iov_len = length,
-	};
+	uint32_t vocs_audio_loc;
+
+	if (!value) {
+		DBG(vcp, "Unable to get VOCS Audio Location");
+		return;
+	}
 
 	if (!success) {
 		DBG(vcp, "Unable to read VOCS Audio Location: error 0x%02x",
@@ -1397,13 +1398,9 @@ static void read_vocs_audio_location(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	vocs_audio_loc = iov_pull_mem(&iov, sizeof(uint32_t));
-	if (!*vocs_audio_loc) {
-		DBG(vcp, "Unable to get VOCS Audio Location");
-		return;
-	}
+	memcpy(&vocs_audio_loc, value, length);
 
-	DBG(vcp, "VOCS Audio Loc:%x", *vocs_audio_loc);
+	DBG(vcp, "VOCS Audio Loc: %x", vocs_audio_loc);
 }
 
 
@@ -1413,10 +1410,11 @@ static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
 				       void *user_data)
 {
 	char *vocs_ao_dec_r;
-	struct iovec iov = {
-		.iov_base = (void *) value,
-		.iov_len = length,
-	};
+
+	if (!value) {
+		DBG(vcp, "Unable to get VOCS Audio Location");
+		return;
+	}
 
 	if (!success) {
 		DBG(vcp, "Unable to read VOCS Audio Descriptor: error 0x%02x",
@@ -1424,13 +1422,18 @@ static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	vocs_ao_dec_r = iov_pull_mem(&iov, length);
-	if (!*vocs_ao_dec_r) {
+	vocs_ao_dec_r = malloc(length+1);
+	memset(vocs_ao_dec_r, 0, length+1);
+	memcpy(vocs_ao_dec_r, value, length);
+
+	if (!vocs_ao_dec_r) {
 		DBG(vcp, "Unable to get VOCS Audio Descriptor");
 		return;
 	}
 
-	DBG(vcp, "VOCS Audio Descriptor:%s", *vocs_ao_dec_r);
+	DBG(vcp, "VOCS Audio Descriptor: %s", vocs_ao_dec_r);
+	free(vocs_ao_dec_r);
+	vocs_ao_dec_r = NULL;
 }
 
 static void vcp_pending_destroy(void *data)
-- 
2.34.1

