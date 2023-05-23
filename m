Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC8CC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 14:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbjEWOgC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 10:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbjEWOgB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 10:36:01 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F1E1AD
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 07:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjKNUtn+sEvrUi3P947tpyYeYSKwTWULBkEyJj+KotCkpOJLt0fzcl7lhZuFXvBkOqua8/1BMZCV5W1OFXOLUnK0wfA6FQ95hf4i6qosF88hzCxilUoyTVV+bU60qEqrfuLk28YDXbp0ncVZAxcGa1p/PL2UUTRRzwNhBnR9hGoDEanUtp0Byh+6K7pIkpXyEgKIND/BRTF+DJw2efw2q2J/N/tMJxIsmWxXipmvjtcuceSjDm1QV6RdrVedhuTnVBpjCsRN8diFWqZDSAxmxqlwD3/kKToQGFjp7m1OttKoX8CQ5DAs83orH1ypI7A5vAidkvFz3tM8N7JqY9PMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIPskh/jHOef8TKlxbyo83o8f2WKdLXnQOm55Bsl6LA=;
 b=jEKZ8er6K2oI/yAkGhlMQe6hAJsJezqq8xCmWWAN5Sr/9jjnqXRbzYbQ6p1rHbKhect7x8oN17USXKVeIIYD4mZsJZwvE7O3BPrDWzOOYxxaOUz2Nwm7sZOgwlGCL7NIdwBNresP9Kat0dgy7JswtiIp14ZDXPFenm/Tf1cN//f+Ymf9N3kQmZP7l4jK4r8iHEGpx8vCTjp0WAQU1SOG9xq23lCHMvYTjqUmm2R0D7tbG9qxxBr92179T0/snIJp7SodX0APV4BI6+EMZ0YdFPBU/SgjQXTxWexB4444FRLd+eMYLZ2na7S1qiySpcTXLbLqNJzhCIGIPGFesL6RRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIPskh/jHOef8TKlxbyo83o8f2WKdLXnQOm55Bsl6LA=;
 b=U1aR/HydCTPmJhHt0XcSeTL6AKXbQvGiGphbd7EsdqVtnA2khlyLt32mvZfZzOYBMRdA5C5t/N9AXqFWakS7Cifpy0XnoWKcxRzPeILJEdp8O8pXCe887LmF3eUtLL+Y4ZAehR2VqFqCj/tAJODBrG2DKwBJiATaN8ycWOVTwiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DUZPR04MB9784.eurprd04.prod.outlook.com (2603:10a6:10:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 14:35:27 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 14:35:27 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH BlueZ 2/6] lib: Add macro definitions for BAP broadcast source support
Date:   Tue, 23 May 2023 17:35:00 +0300
Message-Id: <20230523143504.3319-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523143504.3319-1-iulia.tanasescu@nxp.com>
References: <20230523143504.3319-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DUZPR04MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0afdfb-2313-4d77-a408-08db5b9af39c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSfT7DfZHAtkvyH7JX0ShIpvy6qbRT76LlaHO2RGCQcKa0IiKnxWy+RL170KUpLhADMyG5BDpCYSZSet79jiSRuRJc9/Xgx7gT92hiEaRSg9PpVxNXjtBUSlI2atgwP/haHTCSjp9HrDmTexTuBmK27Ug8KMeluoZT38AxE9rZipphlXXAOQudPTaG2ZYZ7wNg2TjQ2cwPXDjnmDl8ebYG/6HomIEKSuurol3mhrX2NKpCpkcKs65fLpBuVH1blI7rmCRqdYLwhh7wtIrHYrSHQnJyfIpKtqBLX6AUBbVKKlWaB3HYUDXGXxxvTgnqlPakqI+Sx5J8AsCsHcLg823BLOSTkKlzkvxs+eLV6a+q1ufKsnDOra3iDOkIr1nwNtE9ZPAM660rxf6dApGOBphHxy18nmnfFdtA1JIN/g7tn7rgRw4T//UdVivn2TwTZ2+rfVLKeDgf4fHe3jD3upVw8GKkYthNcEWY+Dc8zBuHUbBKhVqTQ5qm7KuLk8IEkBzTxADMmHX+AKwJrbUvq3fLungGo5SUEVN1z48maiIgL9s8lBJfKUdOl9z7L7Mt04GiEIiEURLY+jCMEDDmi9NvxiqQOEQpQKlt2SRImZBxeE5wdBjBFcv4dbh3x4v7yi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(86362001)(478600001)(38100700002)(38350700002)(2616005)(66556008)(66476007)(66946007)(2906002)(186003)(4326008)(6916009)(26005)(316002)(1076003)(6666004)(6506007)(6512007)(6486002)(52116002)(44832011)(41300700001)(5660300002)(36756003)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2s6MyMQnL0Jo1puubltGNWhQXAJgH5YAKTf1c1VtynjqIWSqiGZIA5XlsJaB?=
 =?us-ascii?Q?KQ2aWK9LUo8SC6L2Rte6ETf3IXX69UrZghXJMwShasvUQ1s1UfKR3FIP/D9P?=
 =?us-ascii?Q?qU9E3QM2LUR5OgvY7MSBmbJDIo/mTuRq2M6fjI9FkpqY/OmR80G5ntKtoV8h?=
 =?us-ascii?Q?oZmPCW66lqaHExvH4GHMbRg0+HJenazpHg0xrcJcY9tR5LNtncN9tPIg0W2f?=
 =?us-ascii?Q?Pb7PUU6SJB4GecXWK7nryr5RO609tO0o//pcK6Om9AtOzwkfnKjpWaVlGhoz?=
 =?us-ascii?Q?dtxMHS1TUcRitiAdVFJ7OuEj16pUJxvsDU4Oe4bKytKiFJZD3XA6lO2l7Koa?=
 =?us-ascii?Q?w0YtOyOx8OVfB9WTTVgMU+TFiqHN1gICol2Zwp8faLfvrvbTLHZfysLPV91Y?=
 =?us-ascii?Q?SYzWxvOVhE0pY3mbemcknprnXLLPWiVi34nt5hyA80RVjDsESQHL+8NqpCWO?=
 =?us-ascii?Q?Ge0/Z3V90/QlkFQumPUlco8Jpbn9L3UB77XtWovHRdhzdRdCct07KY0BQKJv?=
 =?us-ascii?Q?kKJH1Rh0bIHiuegAWkTGwKicynh/CdRQiS8O2GB6qj2b+thGt8c73UeJtjaK?=
 =?us-ascii?Q?M7DEZYcOjRJhQsTke6fBXzXtRlBk4y20Fqd5tVPfYV9mDp45FaIVunxVNrG3?=
 =?us-ascii?Q?jYmj8iTQ/Nv2GEgAy4Neab3rJgXXkb3ox+xV6yb26oUiJ8KCsOIPgLj20G7y?=
 =?us-ascii?Q?wi23RSn3g7sP7MN77j1YJT3Hj9SAJSrHrsvIFAGbzyDTF3ZghztrrzPiWMc7?=
 =?us-ascii?Q?eRVkCdA90Etj5IN6d/3p7eFYX0W+/5uM8E1fVkcIjRWLOQe/AV+OIigBqhW0?=
 =?us-ascii?Q?GPTNCtV30QykuW/YTEh+yTXDchiZFIxgmx6wb2pN+aIhL5Vc7qVT0uuhMW3/?=
 =?us-ascii?Q?XN92WXrgd1Vtic8lz/1pSLzDfn1GXo/LAPIGDJgbs8/QCvd0x7ts9CwAUrYF?=
 =?us-ascii?Q?YeMRt9YAmCkzJXyVQY1OS03Ln0FDhA2XdfxgtWko8EYH2vujvupcyLRUvON+?=
 =?us-ascii?Q?Uolih4kL1HYgGybi2SP69QE8e8uYWKH346+pqr9qjeL5GYKGIE32HP3UzTWh?=
 =?us-ascii?Q?ytg2PKEBGvA9iewnf4v9vdk0MMqN5CC2wMUlP6RlIUi2vQu6G3vCHj2ahnBR?=
 =?us-ascii?Q?7gpXdgAe5cEIUpexateW2DrTFn5Gkfv6ugeNcuR/NJ8yylo2pP/V1XSWP9xi?=
 =?us-ascii?Q?ex5U4eQT8wEgHXZUJ4h3q2QYDpI30NwwvsTRAKkjtHRK/JMeRojnwJG85WE1?=
 =?us-ascii?Q?lc33SbcqIf5nKy2sijGELFFPR34xEtsrSlGB28tct1s8J7eGYvrfsW9WTDvN?=
 =?us-ascii?Q?y9MVAZtq5TRS3vjnAUEmQsV/VhArPWlnE8jRFuqwDNG/nyGA2yxzBKFm+onN?=
 =?us-ascii?Q?uq5kB49dUgYdu9coE0cwEvTfu7XdkkhRJkS/8cZd1nisBqhWvGg3U4einQSz?=
 =?us-ascii?Q?XjDCdP0ED+1WoC4YhJRwEHcJw+5n0ODsGE+IGJzQzMAxNWTuQZ1db8UXyMuX?=
 =?us-ascii?Q?YtUKnhmE1Jv8fNREke85JDRRKPkoXHM+/5FNmQ2P7Ng6I6NMNLoq/l4I8/3y?=
 =?us-ascii?Q?QtwCyyx2QQE+kvOuDMgf/ssUXUpyLeklQp0i1VgDNW0N1VIZPJgk9zgqdG5k?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0afdfb-2313-4d77-a408-08db5b9af39c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 14:35:27.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Hs98QTA/+zQLZ88u4ixPUt5hJZA17MwkGA8qImjPHZDFp1+zkcO8xJBUz25v1Z2kbaPZJvx+Y25oy7vPa/+sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9784
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>

This adds macro definitions for BAP broadcast source support.

---
 lib/bluetooth.h | 9 +++++++++
 lib/mgmt.h      | 2 ++
 lib/uuid.h      | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index b4bb6748f..ca4b0115b 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -150,6 +150,9 @@ struct bt_voice {
 #define BT_ISO_QOS_BIG_UNSET	0xff
 #define BT_ISO_QOS_BIS_UNSET	0xff
 
+#define BT_ISO_QOS_GROUP_UNSET	0xff
+#define BT_ISO_QOS_STREAM_UNSET	0xff
+
 struct bt_iso_io_qos {
 	uint32_t interval;
 	uint16_t latency;
@@ -186,6 +189,12 @@ struct bt_iso_bcast_qos {
 	uint16_t timeout;
 };
 
+#define BASE_MAX_LENGTH 248 /* (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH) */
+struct bt_iso_base {
+	uint8_t base_len;
+	uint8_t base[BASE_MAX_LENGTH];
+};
+
 struct bt_iso_qos {
 	union {
 		struct bt_iso_ucast_qos ucast;
diff --git a/lib/mgmt.h b/lib/mgmt.h
index 59273c85a..c3c905232 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -102,6 +102,8 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_WIDEBAND_SPEECH	BIT(17)
 #define MGMT_SETTING_CIS_CENTRAL	BIT(18)
 #define MGMT_SETTING_CIS_PERIPHERAL	BIT(19)
+#define MGMT_SETTING_ISO_BROADCASTER	BIT(20)
+#define MGMT_SETTING_ISO_SYNC_RECEIVER	BIT(21)
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
diff --git a/lib/uuid.h b/lib/uuid.h
index ddde4bfa3..8f2e23681 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -157,6 +157,9 @@ extern "C" {
 #define PAC_SOURCE_UUID		"00002bcb-0000-1000-8000-00805f9b34fb"
 #define PAC_SOURCE_LOC_CHRC_UUID			0x2bcc
 
+#define BROADCAST_AUDIO_ANNOUNCEMENT_SERVICE		0x1852
+#define BROADCAST_AUDIO_ANNOUNCEMENT_SERVICE_UUID	"00001852-0000-1000-8000-00805f9b34fb"
+
 #define PAC_CONTEXT					0x2bcd
 #define PAC_SUPPORTED_CONTEXT				0x2bce
 
-- 
2.34.1

