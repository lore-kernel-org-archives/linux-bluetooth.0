Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552A5C77B61
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Apr 2023 15:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjDXPZc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Apr 2023 11:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjDXPZa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Apr 2023 11:25:30 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8213419D
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Apr 2023 08:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgMslpqCttybaWnUh1xfXtoheqMqY/94sQNP+XzhR3M/pVjX6syG3myX/6L4t4i/3Qt3TopYVzhOL5DwXsKA9V6Mu9bsBeFBTzFwd8ircO9TPvKFWL7AsVb12OnGbnCJ0DJ8yts65m0xMCdbbAWwhcyfn8g4VuN/04A5FRUbyqif74AAfvZYSJlj7ZDNEE6JykNMmY6og6qVLD08vsazpbpUuc1es/D8csTwkoAaZYx1dIkpn/aGCuPkb51jWK2enuZo1f7QpaLPwv2/S7irkg1cZrRE29Zk5/Vw45ujXG1bWYOgwgzF+u2ssbbkCrYs3cW+HkUBdoP2tyDDT8IKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1b0iqmKAIn1xctxbMCkwfFXt7vQkKHVJXTAq2ujBsA=;
 b=hAKy9l8Mm/6ACQRziU1Ut1dUZlgiIsWvITckCxxpq2RdbkdrCU/NmHkIIP54NZOsPT7p8cnw/UzNvQhDUyazyk9ODDDtph99BUeT/TJ2KsUaySWJqaj2GFiw7LktA6LKFyRKwhxwZn4p+Lyq6H5gPugFVqyoPLxFNjHMu9OPqmKWwWx9b+2rZZPboaiWRDiPp3ftoS7N/4NttzvbdkHo4jUK8rtHObzkwPLcM3EiBin+W9XhhQOr9Kne5o746bqGAYfG+7g69ZvFDPtmW23FqxIJ8C57rfIzyl31jO/lUL2okNNIKVpsQ05f6aO9FiC8K8NN6hVTpkS2QqZEExEbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1b0iqmKAIn1xctxbMCkwfFXt7vQkKHVJXTAq2ujBsA=;
 b=R5Fm9zbFB+Dfde+njppDuWcabzVgFU7bw6bil8btY8EhqIHXTNMSYRFCATuaQmoZVLEiQQP3drHxDDqPOmoVqYoNDdPEQ8xqgYqBj0VtrYFafmP85oDBkCDHOYqN0hERiTvPuowZ7OiRPAd00RDoA+YtuiOHWLub54eesY+yVTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9572.eurprd04.prod.outlook.com (2603:10a6:102:24f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Mon, 24 Apr
 2023 15:25:22 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%8]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 15:25:22 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/2] shared/bass: Add initial code for handling BASS
Date:   Mon, 24 Apr 2023 18:24:57 +0300
Message-Id: <20230424152457.28000-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230424152457.28000-1-iulia.tanasescu@nxp.com>
References: <20230424152457.28000-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0002.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::7) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5c1828-a34c-41bd-624f-08db44d81edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3H+ngpcRy0jOgdUx2w60PHbToVqt5EW7dMve0kUEpCxiexz2zJRYJFvYDymKF0bfBAukZ71kOcPuJnLhW5q2DQ/v4Q/JGv5oYIJx7m4z9bJmWhRh9bUochRiwXXW4lQF1UAKBvOmqjVjp1ipXUXj2iiiCFFqFcDpbNhQ5bRgIISSk9dYyxXTjvz34N+1LN4FoxJuML2UCkh9MlnSKHnse3AEgIEPcfZJYtGlh6plhq9azOYE7EXITY3rRSetp9D6Kv9ePoX7i+1gv/VSqWdHNJs1HKKWRGayFv69pakhKobxROAR3jyB6FDCdajJriNIlIR6gbW200vHDHow2Rwq2gRRHe1xekdRcIUkQ0LWNPVSM2j17JiAdJ9Wjr0f3OgF/kgLOFRqC6duXXg5TPrrxFP7du2MfD3bdkGT7zdXCXnHxAB7/EGkSskH2FxxJ4VvXYxU4M7e+X9Xy8dDZU50m7TGpts7zA6EX2c9KLvWrfdJEmG8ijEN6pqRSyKpgt6/gDK43pTsQLHFH7VHPF+WVhvZbqPLSWN1dIPj0QjAR+vIHWSmoTIq2AyWNRDYnEkFukpbMPRqcxBhUSj+isQNG4rSARiXNJPk0P0/87RzA37j4fG8wx7rDFs4IrVHGLWneDLC7GO48rfiy3WskwJytd5n6xdmuxXqyDl0k6Bo9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(52116002)(30864003)(186003)(6506007)(26005)(6512007)(55236004)(1076003)(6486002)(6666004)(38100700002)(66946007)(5660300002)(2616005)(66556008)(41300700001)(6916009)(4326008)(8676002)(8936002)(66476007)(38350700002)(478600001)(2906002)(44832011)(316002)(86362001)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HFZh6oMDu8KlsRiVz9WvOmTypusE3rGT0oqj81+OK3OXgS5h17HhjaPZZwp8?=
 =?us-ascii?Q?XR67ErrR/gQnnjIURMiIAOZ6VA16qCdM2St33MVE44r/YTdkWNzvyTVHCGNn?=
 =?us-ascii?Q?GYjbnwuGULLzA8KWe0CXHydag2u3qyja/n0qgVI+YqKPec0r5TIlUkugdVAQ?=
 =?us-ascii?Q?F7bY85DLgMNpAz0cgVCao9FWPmPx0AlpyUuQrGG2MPIHLMozGbJxdzbwEpDw?=
 =?us-ascii?Q?oUoRtgqCHtuNfFgdd/Yowq36T/WqinZFXsOOcW2RSZTY6hhLVz95DQBsfORY?=
 =?us-ascii?Q?O7B1oELTbYB6QWZmmyePJpup30jmC5rkSuuKxn+/O6tvdK05cX4dV7noaa86?=
 =?us-ascii?Q?vdhvOzgmHu0m4G7Alv7zVTtZ0q9bgQpJjpCfjsVCfh0nUnVHc3aF7ze4n6pf?=
 =?us-ascii?Q?lPUx5W+A82gOgPX9ry3FDefTBOBUArAlWbc6wc7YkKSttv5MEPlbtRc5YlCv?=
 =?us-ascii?Q?M1mx2r90NNMmLeZSZ9sSKhzDlUn+tsXxAPioH7clc0mU7hRYTly2nROQK4Ey?=
 =?us-ascii?Q?H1aRbOMo8NbtLlgc6NvROwaOkrn+KmyoMvGNOR+GgGNLO4/3lkpBaH+veRNu?=
 =?us-ascii?Q?VJnpOgklKaejIlRI6QAk1f4NS6kx8JNm+F9i47bEam00S+9/QJiLibD/ZwBi?=
 =?us-ascii?Q?O8NVICinVZ0mYKew6ZYQEHug3QrBJyuudgs8WWGPXK8jPYfTFTWvczckg9CQ?=
 =?us-ascii?Q?MT0mXA2gao+svSRXdifn/oOwHaNJkt0C7OgqRrMEtXP/IlHlkPF/yJm/X4jm?=
 =?us-ascii?Q?7OL8YKG5nrbsW1mj1hWc+gcNEgxADE/lyafK5kUWp2BI6PHV1F0jPCBuFeI6?=
 =?us-ascii?Q?VJlWPiQTL5YzOh5LU+Es6dCoCLUoludwOC03dNuxFJw+vrLMQc4GOMZCjAI5?=
 =?us-ascii?Q?ulfzAmL4s83s+eaLu7bZKJP0DHa3VtYFdhKc7tOJZmULUtAXznUHaBUyjHZZ?=
 =?us-ascii?Q?3XjzVex35C8fgGc/2fgVAp9YdPJMMO4X/9ofZEs9F6s6QPadNBHOhT+XUUAw?=
 =?us-ascii?Q?YYIslurfUA1bHqoDrR4ESfMlwiz2JPzsoSBZ0RiBMfTrmH5nLu0/8LZzLPxr?=
 =?us-ascii?Q?n/bpLkD5YHJIXQ60eWdDq2JcjuJuB/IZ1ePmF5m+w4/FEFckB4rtiW/NmzK1?=
 =?us-ascii?Q?zCXHEwv+qU86DzzWyvSxDPX/78v1xpsYvy0TjhppOXJpJ42iHvaKI6mlxD2w?=
 =?us-ascii?Q?ZgcycM012EAo87aydoVHzffEVhyBv8Ol+mSyQHwoCWFji7YvmFyrFzyiPHg1?=
 =?us-ascii?Q?ct6n74wgDqwzaRxnv7cyfG1K6xWGkyUEGkSPJNo+V9WgzwlLJphcqCyZKm9T?=
 =?us-ascii?Q?SksSpLWEFYlb0xTpMIa+gYtjVM7XZg8G9Mflaf/XEmVuTLZtR+0DYUuK1vA6?=
 =?us-ascii?Q?K04YpWIDJtXWVVtp8LdRRf23FcwBnqgOMDbrVGztYHJ44p/8PgB1ho90r4dZ?=
 =?us-ascii?Q?X0BX75mQEaB/PJaLN1zfFOR4MdcffJQXyyg3159Z0RMiLAnzJOigGmqa2IjO?=
 =?us-ascii?Q?+1PxMNaZWP8yYTT5q2XG9eCzZpRJs/9cpLbSfTyAXRTFTq5wvgYwaaBbc9AS?=
 =?us-ascii?Q?sTj0Q4f3A8omnBdnXZzGmrGuu+WnqdS366zXejXGiNmJcX3QPyANGqdX50rh?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5c1828-a34c-41bd-624f-08db44d81edc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 15:25:22.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SA1XjX4dngVTwziYqC8MTgP6V9x5aC3uRVd0k7+r6w2aSIHFpwV6yZ2mHr09I9kdTDQxLU3gyT8UnJru3xdEPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9572
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds initial code for Broadcast Audio Scan Service.

---
 Makefile.am            |   1 +
 src/shared/att-types.h |   4 +-
 src/shared/bap.c       |  57 +---
 src/shared/bap.h       |  51 +++
 src/shared/bass.c      | 703 +++++++++++++++++++++++++++++++++++++++++
 src/shared/bass.h      | 124 ++++++++
 6 files changed, 896 insertions(+), 44 deletions(-)
 create mode 100644 src/shared/bass.c
 create mode 100644 src/shared/bass.h

diff --git a/Makefile.am b/Makefile.am
index 7ded3ba75..f4425a003 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -231,6 +231,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/gap.h src/shared/gap.c \
 			src/shared/log.h src/shared/log.c \
 			src/shared/bap.h src/shared/bap.c src/shared/ascs.h \
+			src/shared/bass.h src/shared/bass.c \
 			src/shared/mcs.h src/shared/mcp.h src/shared/mcp.c \
 			src/shared/vcp.c src/shared/vcp.h \
 			src/shared/csip.c src/shared/csip.h \
diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index a08b24155..6783b0980 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2014  Google Inc.
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -101,9 +102,10 @@ struct bt_att_pdu_error_rsp {
 /*
  * Common Profile and Service Error Code descriptions (see Supplement to the
  * Bluetooth Core Specification, sections 1.2 and 2). The error codes within
- * 0xE0-0xFC are reserved for future use. The remaining 3 are defined as the
+ * 0xE0-0xFB are reserved for future use. The remaining 3 are defined as the
  * following:
  */
+#define BT_ERROR_WRITE_REQUEST_REJECTED         0xfc
 #define BT_ERROR_CCC_IMPROPERLY_CONFIGURED      0xfd
 #define BT_ERROR_ALREADY_IN_PROGRESS            0xfe
 #define BT_ERROR_OUT_OF_RANGE                   0xff
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1fff7e0fd..70aa89a79 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *  Copyright 2023 NXP
  *
  */
 
@@ -28,6 +29,7 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/bap.h"
 #include "src/shared/ascs.h"
+#include "src/shared/bass.h"
 
 /* Maximum number of ASE(s) */
 #define NUM_SINKS 2
@@ -114,14 +116,6 @@ struct bt_ascs {
 	struct gatt_db_attribute *ase_cp_ccc;
 };
 
-struct bt_bap_db {
-	struct gatt_db *db;
-	struct bt_pacs *pacs;
-	struct bt_ascs *ascs;
-	struct queue *sinks;
-	struct queue *sources;
-};
-
 struct bt_bap_req {
 	unsigned int id;
 	struct bt_bap_stream *stream;
@@ -133,10 +127,6 @@ struct bt_bap_req {
 	void *user_data;
 };
 
-typedef void (*bap_notify_t)(struct bt_bap *bap, uint16_t value_handle,
-				const uint8_t *value, uint16_t length,
-				void *user_data);
-
 struct bt_bap_notify {
 	unsigned int id;
 	struct bt_bap *bap;
@@ -144,35 +134,6 @@ struct bt_bap_notify {
 	void *user_data;
 };
 
-struct bt_bap {
-	int ref_count;
-	struct bt_bap_db *ldb;
-	struct bt_bap_db *rdb;
-	struct bt_gatt_client *client;
-	struct bt_att *att;
-	struct bt_bap_req *req;
-
-	unsigned int cp_id;
-	unsigned int process_id;
-	unsigned int disconn_id;
-	unsigned int idle_id;
-
-	struct queue *reqs;
-	struct queue *notify;
-	struct queue *streams;
-	struct queue *local_eps;
-	struct queue *remote_eps;
-
-	struct queue *pac_cbs;
-	struct queue *ready_cbs;
-	struct queue *state_cbs;
-
-	bt_bap_debug_func_t debug_func;
-	bt_bap_destroy_func_t debug_destroy;
-	void *debug_data;
-	void *user_data;
-};
-
 struct bt_bap_pac {
 	struct bt_bap_db *bdb;
 	char *name;
@@ -569,7 +530,7 @@ static void bap_disconnected(int err, void *user_data)
 	bt_bap_detach(bap);
 }
 
-static struct bt_bap *bap_get_session(struct bt_att *att, struct gatt_db *db)
+struct bt_bap *bap_get_session(struct bt_att *att, struct gatt_db *db)
 {
 	const struct queue_entry *entry;
 	struct bt_bap *bap;
@@ -2189,6 +2150,7 @@ static struct bt_bap_db *bap_db_new(struct gatt_db *db)
 	bdb->db = gatt_db_ref(db);
 	bdb->sinks = queue_new();
 	bdb->sources = queue_new();
+	bdb->bass_bcast_srcs = queue_new();
 
 	if (!bap_db)
 		bap_db = queue_new();
@@ -2199,6 +2161,9 @@ static struct bt_bap_db *bap_db_new(struct gatt_db *db)
 	bdb->ascs = ascs_new(db);
 	bdb->ascs->bdb = bdb;
 
+	bdb->bass = bass_new(db);
+	bdb->bass->bdb = bdb;
+
 	queue_push_tail(bap_db, bdb);
 
 	return bdb;
@@ -2518,10 +2483,12 @@ static void bap_db_free(void *data)
 
 	queue_destroy(bdb->sinks, bap_pac_free);
 	queue_destroy(bdb->sources, bap_pac_free);
+	queue_destroy(bdb->bass_bcast_srcs, bass_bcast_src_free);
 	gatt_db_unref(bdb->db);
 
 	free(bdb->pacs);
 	free(bdb->ascs);
+	free(bdb->bass);
 	free(bdb);
 }
 
@@ -2669,6 +2636,7 @@ struct bt_bap *bt_bap_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	bdb->db = gatt_db_ref(rdb);
 	bdb->sinks = queue_new();
 	bdb->sources = queue_new();
+	bdb->bass_bcast_srcs = queue_new();
 
 	bap->rdb = bdb;
 	bap->remote_eps = queue_new();
@@ -3382,7 +3350,7 @@ static void bap_notify_destroy(void *data)
 		free(notify);
 }
 
-static unsigned int bap_register_notify(struct bt_bap *bap,
+unsigned int bap_register_notify(struct bt_bap *bap,
 					uint16_t value_handle,
 					bap_notify_t func,
 					void *user_data)
@@ -3835,6 +3803,9 @@ clone:
 	bt_uuid16_create(&uuid, ASCS_UUID);
 	gatt_db_foreach_service(bap->rdb->db, &uuid, foreach_ascs_service, bap);
 
+	bt_uuid16_create(&uuid, BASS_UUID);
+	gatt_db_foreach_service(bap->rdb->db, &uuid, foreach_bass_service, bap);
+
 	return true;
 }
 
diff --git a/src/shared/bap.h b/src/shared/bap.h
index bd13abef9..44b0d1535 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *  Copyright 2023 NXP
  *
  */
 
@@ -62,9 +63,49 @@ struct bt_bap_qos {
 	uint8_t  target_latency;	/* Target Latency */
 };
 
+struct bt_bap_db {
+	struct gatt_db *db;
+	struct bt_pacs *pacs;
+	struct bt_ascs *ascs;
+	struct bt_bass *bass;
+	struct queue *sinks;
+	struct queue *sources;
+	struct queue *bass_bcast_srcs;
+};
+
 typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data);
 typedef void (*bt_bap_destroy_func_t)(void *user_data);
 typedef void (*bt_bap_debug_func_t)(const char *str, void *user_data);
+
+struct bt_bap {
+	int ref_count;
+	struct bt_bap_db *ldb;
+	struct bt_bap_db *rdb;
+	struct bt_gatt_client *client;
+	struct bt_att *att;
+	struct bt_bap_req *req;
+
+	unsigned int cp_id;
+	unsigned int process_id;
+	unsigned int disconn_id;
+	unsigned int idle_id;
+
+	struct queue *reqs;
+	struct queue *notify;
+	struct queue *streams;
+	struct queue *local_eps;
+	struct queue *remote_eps;
+
+	struct queue *pac_cbs;
+	struct queue *ready_cbs;
+	struct queue *state_cbs;
+
+	bt_bap_debug_func_t debug_func;
+	bt_bap_destroy_func_t debug_destroy;
+	void *debug_data;
+	void *user_data;
+};
+
 typedef void (*bt_bap_pac_func_t)(struct bt_bap_pac *pac, void *user_data);
 typedef bool (*bt_bap_pac_foreach_t)(struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac,
@@ -86,6 +127,10 @@ typedef void (*bt_bap_stream_func_t)(struct bt_bap_stream *stream,
 					void *user_data);
 typedef void (*bt_bap_func_t)(struct bt_bap *bap, void *user_data);
 
+typedef void (*bap_notify_t)(struct bt_bap *bap, uint16_t value_handle,
+				const uint8_t *value, uint16_t length,
+				void *user_data);
+
 /* Local PAC related functions */
 struct bt_bap_pac_qos {
 	uint8_t  framing;
@@ -265,3 +310,9 @@ uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream);
 
 int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd);
 bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd);
+
+struct bt_bap *bap_get_session(struct bt_att *att, struct gatt_db *db);
+unsigned int bap_register_notify(struct bt_bap *bap,
+					uint16_t value_handle,
+					bap_notify_t func,
+					void *user_data);
diff --git a/src/shared/bass.c b/src/shared/bass.c
new file mode 100644
index 000000000..1be36ef75
--- /dev/null
+++ b/src/shared/bass.c
@@ -0,0 +1,703 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright 2023 NXP
+ *
+ */
+
+#define _GNU_SOURCE
+#include <inttypes.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <errno.h>
+#include <poll.h>
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+#include "lib/iso.h"
+
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/bap.h"
+#include "src/shared/bass.h"
+
+#define DBG(_bap, fmt, arg...) \
+	bass_debug(_bap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
+
+static void bass_debug(struct bt_bap *bap, const char *format, ...)
+{
+	va_list ap;
+
+	if (!bap || !format || !bap->debug_func)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(bap->debug_func, bap->debug_data, format, ap);
+	va_end(ap);
+}
+
+static int
+bass_build_bcast_src_from_notif(struct bt_bcast_src *bcast_src,
+				const uint8_t *value, uint16_t length)
+{
+	struct bt_bass_subgroup_data *subgroup_data = NULL;
+	uint8_t *id;
+	uint8_t *addr_type;
+	uint8_t *addr;
+	uint8_t *sid;
+	uint8_t *bid;
+	uint8_t *pa_sync_state;
+	uint8_t *enc;
+	uint8_t *bad_code = NULL;
+	uint8_t *num_subgroups;
+	uint8_t *bis_sync_state;
+	uint8_t *meta_len;
+	uint8_t *meta;
+
+	struct iovec iov = {
+		.iov_base = (void *) value,
+		.iov_len = length,
+	};
+
+	/* Extract all fields from notification */
+	id = util_iov_pull_mem(&iov, sizeof(*id));
+	if (!id) {
+		DBG(bcast_src->bap, "Unable to parse Broadcast Receive State");
+		return -1;
+	}
+
+	addr_type = util_iov_pull_mem(&iov, sizeof(*addr_type));
+	if (!addr_type) {
+		DBG(bcast_src->bap, "Unable to parse Broadcast Receive State");
+		return -1;
+	}
+
+	addr = util_iov_pull_mem(&iov, sizeof(bdaddr_t));
+	if (!addr) {
+		DBG(bcast_src->bap, "Unable to parse Broadcast Receive State");
+		return -1;
+	}
+
+	sid = util_iov_pull_mem(&iov, sizeof(*sid));
+	if (!sid) {
+		DBG(bcast_src->bap, "Unable to parse Broadcast Receive State");
+		return -1;
+	}
+
+	bid = util_iov_pull_mem(&iov, 3);
+	if (!bid) {
+		DBG(bcast_src->bap, "Unable to parse Broadcast Receive State");
+		return -1;
+	}
+
+	pa_sync_state = util_iov_pull_mem(&iov, sizeof(*pa_sync_state));
+	if (!pa_sync_state) {
+		DBG(bcast_src->bap, "Unable to parse Broadcast Receive State");
+		return -1;
+	}
+
+	enc = util_iov_pull_mem(&iov, sizeof(*enc));
+	if (!enc) {
+		DBG(bcast_src->bap, "Unable to parse Broadcast Receive State");
+		return -1;
+	}
+
+	if (*enc == BT_BASS_BIG_ENC_STATE_BAD_CODE) {
+		bad_code = util_iov_pull_mem(&iov, BT_BASS_BCAST_CODE_SIZE);
+		if (!bad_code) {
+			DBG(bcast_src->bap, "Unable to parse "
+				"Broadcast Receive State");
+			return -1;
+		}
+	}
+
+	num_subgroups = util_iov_pull_mem(&iov, sizeof(*num_subgroups));
+	if (!num_subgroups) {
+		DBG(bcast_src->bap, "Unable to parse Broadcast Receive State");
+		return -1;
+	}
+
+	if (*num_subgroups == 0)
+		goto done;
+
+	subgroup_data = malloc((*num_subgroups) * sizeof(*subgroup_data));
+	if (!subgroup_data) {
+		DBG(bcast_src->bap, "Unable to allocate memory");
+		return -1;
+	}
+
+	memset(subgroup_data, 0, (*num_subgroups) * sizeof(*subgroup_data));
+
+	for (int i = 0; i < *num_subgroups; i++) {
+		bis_sync_state = util_iov_pull_mem(&iov,
+						sizeof(uint32_t));
+		if (!bis_sync_state) {
+			DBG(bcast_src->bap, "Unable to parse "
+				"Broadcast Receive State");
+
+			for (int j = 0; j < i; j++)
+				free(subgroup_data[j].meta);
+
+			free(subgroup_data);
+			return -1;
+		}
+
+		subgroup_data[i].bis_sync = get_le32(bis_sync_state);
+
+		meta_len = util_iov_pull_mem(&iov, sizeof(*meta_len));
+		if (!meta_len) {
+			DBG(bcast_src->bap, "Unable to parse "
+				"Broadcast Receive State");
+
+			for (int j = 0; j < i; j++)
+				free(subgroup_data[j].meta);
+
+			free(subgroup_data);
+			return -1;
+		}
+
+		subgroup_data[i].meta_len = *meta_len;
+
+		if (*meta_len == 0)
+			continue;
+
+		subgroup_data[i].meta = malloc(*meta_len);
+		if (!subgroup_data[i].meta) {
+			DBG(bcast_src->bap, "Unable to allocate memory");
+
+			for (int j = 0; j < i; j++)
+				free(subgroup_data[j].meta);
+
+			free(subgroup_data);
+			return -1;
+		}
+
+		meta = util_iov_pull_mem(&iov, *meta_len);
+		if (!meta) {
+			DBG(bcast_src->bap, "Unable to parse "
+				"Broadcast Receive State");
+
+			for (int j = 0; j < i; j++)
+				free(subgroup_data[j].meta);
+
+			free(subgroup_data);
+			return -1;
+		}
+
+		memcpy(subgroup_data[i].meta, meta, *meta_len);
+	}
+
+done:
+	/*
+	 * If no errors occurred, copy extracted fields into
+	 * the broadcast source structure
+	 */
+	if (bcast_src->subgroup_data) {
+		for (int i = 0; i < bcast_src->num_subgroups; i++)
+			free(bcast_src->subgroup_data[i].meta);
+
+		free(bcast_src->subgroup_data);
+	}
+
+	bcast_src->id = *id;
+	bcast_src->addr_type = *addr_type;
+	memcpy(&bcast_src->addr, addr, sizeof(bdaddr_t));
+	bcast_src->sid = *sid;
+	bcast_src->bid = get_le24(bid);
+	bcast_src->sync_state = *pa_sync_state;
+	bcast_src->enc = *enc;
+
+	if (*enc == BT_BASS_BIG_ENC_STATE_BAD_CODE)
+		memcpy(bcast_src->bad_code, bad_code, BT_BASS_BCAST_CODE_SIZE);
+	else
+		memset(bcast_src->bad_code, 0, BT_BASS_BCAST_CODE_SIZE);
+
+	bcast_src->num_subgroups = *num_subgroups;
+
+	bcast_src->subgroup_data = subgroup_data;
+
+	return 0;
+}
+
+static int
+bass_build_bcast_src_from_read_rsp(struct bt_bcast_src *bcast_src,
+				const uint8_t *value, uint16_t length)
+{
+	return bass_build_bcast_src_from_notif(bcast_src, value, length);
+}
+
+static uint8_t *bass_build_notif_from_bcast_src(struct bt_bcast_src *bcast_src,
+							size_t *notif_len)
+{
+	size_t len = 0;
+	uint8_t *notif = NULL;
+	struct iovec iov;
+
+	*notif_len = 0;
+
+	if (!bcast_src)
+		return NULL;
+
+	len = BT_BASS_BCAST_SRC_LEN + bcast_src->num_subgroups *
+			BT_BASS_BCAST_SRC_SUBGROUP_LEN;
+
+	if (bcast_src->enc == BT_BASS_BIG_ENC_STATE_BAD_CODE)
+		len += BT_BASS_BCAST_CODE_SIZE;
+
+	for (size_t i = 0; i < bcast_src->num_subgroups; i++) {
+		/* Add length for subgroup metadata */
+		len += bcast_src->subgroup_data[i].meta_len;
+	}
+
+	notif = malloc(len);
+	if (!notif)
+		return NULL;
+
+	memset(notif, 0, len);
+
+	iov.iov_base = notif;
+	iov.iov_len = 0;
+
+	util_iov_push_mem(&iov, sizeof(bcast_src->id),
+			&bcast_src->id);
+	util_iov_push_mem(&iov, sizeof(bcast_src->addr_type),
+			&bcast_src->addr_type);
+	util_iov_push_mem(&iov, sizeof(bcast_src->addr),
+			&bcast_src->addr);
+	util_iov_push_mem(&iov, sizeof(bcast_src->sid),
+			&bcast_src->sid);
+	util_iov_push_mem(&iov, 3, &bcast_src->bid);
+	util_iov_push_mem(&iov, sizeof(bcast_src->sync_state),
+			&bcast_src->sync_state);
+	util_iov_push_mem(&iov, sizeof(bcast_src->enc),
+			&bcast_src->enc);
+
+	if (bcast_src->enc == BT_BASS_BIG_ENC_STATE_BAD_CODE)
+		util_iov_push_mem(&iov, sizeof(bcast_src->bad_code),
+					bcast_src->bad_code);
+
+	util_iov_push_mem(&iov, sizeof(bcast_src->num_subgroups),
+				&bcast_src->num_subgroups);
+
+	for (size_t i = 0; i < bcast_src->num_subgroups; i++) {
+		/* Add subgroup bis_sync */
+		util_iov_push_mem(&iov,
+			sizeof(bcast_src->subgroup_data[i].bis_sync),
+			&bcast_src->subgroup_data[i].bis_sync);
+
+		/* Add subgroup meta_len */
+		util_iov_push_mem(&iov,
+			sizeof(bcast_src->subgroup_data[i].meta_len),
+			&bcast_src->subgroup_data[i].meta_len);
+
+		/* Add subgroup metadata */
+		if (bcast_src->subgroup_data[i].meta_len > 0)
+			util_iov_push_mem(&iov,
+				bcast_src->subgroup_data[i].meta_len,
+				bcast_src->subgroup_data[i].meta);
+	}
+
+	*notif_len = len;
+	return notif;
+}
+
+static uint8_t *
+bass_build_read_rsp_from_bcast_src(struct bt_bcast_src *bcast_src,
+					size_t *rsp_len)
+{
+	return bass_build_notif_from_bcast_src(bcast_src, rsp_len);
+}
+
+static bool bass_check_cp_command_subgroup_data_len(uint8_t num_subgroups,
+							struct iovec *iov)
+{
+	uint32_t *bis_sync_state;
+	uint8_t *meta_len;
+	uint8_t *meta;
+
+	for (int i = 0; i < num_subgroups; i++) {
+		bis_sync_state = util_iov_pull_mem(iov,
+					sizeof(*bis_sync_state));
+		if (!bis_sync_state)
+			return false;
+
+		meta_len = util_iov_pull_mem(iov,
+					sizeof(*meta_len));
+		if (!meta_len)
+			return false;
+
+		meta = util_iov_pull_mem(iov, *meta_len);
+		if (!meta)
+			return false;
+	}
+
+	return true;
+}
+
+static bool bass_check_cp_command_len(struct iovec *iov)
+{
+	struct bt_bass_bcast_audio_scan_cp_hdr *hdr;
+	union {
+		struct bt_bass_add_src_params *add_src_params;
+		struct bt_bass_mod_src_params *mod_src_params;
+		struct bt_bass_set_bcast_code_params *set_bcast_code_params;
+		struct bt_bass_remove_src_params *remove_src_params;
+	} params;
+
+	/* Get command header */
+	hdr = util_iov_pull_mem(iov, sizeof(*hdr));
+
+	if (!hdr)
+		return false;
+
+	/* Check command parameters */
+	switch (hdr->op) {
+	case BT_BASS_ADD_SRC:
+		params.add_src_params = util_iov_pull_mem(iov,
+						sizeof(*params.add_src_params));
+		if (!params.add_src_params)
+			return false;
+
+		if (!bass_check_cp_command_subgroup_data_len(
+					params.add_src_params->num_subgroups,
+					iov))
+			return false;
+
+		break;
+	case BT_BASS_MOD_SRC:
+		params.mod_src_params = util_iov_pull_mem(iov,
+						sizeof(*params.mod_src_params));
+		if (!params.mod_src_params)
+			return false;
+
+		if (!bass_check_cp_command_subgroup_data_len(
+					params.mod_src_params->num_subgroups,
+					iov))
+			return false;
+
+		break;
+	case BT_BASS_SET_BCAST_CODE:
+		params.set_bcast_code_params = util_iov_pull_mem(iov,
+					sizeof(*params.set_bcast_code_params));
+		if (!params.set_bcast_code_params)
+			return false;
+
+		break;
+	case BT_BASS_REMOVE_SRC:
+		params.remove_src_params = util_iov_pull_mem(iov,
+					sizeof(*params.remove_src_params));
+		if (!params.remove_src_params)
+			return false;
+
+		break;
+	case BT_BASS_REMOTE_SCAN_STOPPED:
+	case BT_BASS_REMOTE_SCAN_STARTED:
+		break;
+	default:
+		return true;
+	}
+
+	if (iov->iov_len > 0)
+		return false;
+
+	return true;
+}
+
+static void bass_bcast_audio_scan_cp_write(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				const uint8_t *value, size_t len,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct iovec iov = {
+		.iov_base = (void *)value,
+		.iov_len = len,
+	};
+
+	/* Validate written command length */
+	if (!bass_check_cp_command_len(&iov)) {
+		if (opcode == BT_ATT_OP_WRITE_REQ) {
+			gatt_db_attribute_write_result(attrib, id,
+					BT_ERROR_WRITE_REQUEST_REJECTED);
+		}
+		return;
+	}
+
+	/* TODO: Implement handlers for the written opcodes */
+	gatt_db_attribute_write_result(attrib, id,
+			BT_BASS_ERROR_OPCODE_NOT_SUPPORTED);
+}
+
+static bool bass_src_match_attrib(const void *data, const void *match_data)
+{
+	const struct bt_bcast_src *bcast_src = data;
+	const struct gatt_db_attribute *attr = match_data;
+
+	return (bcast_src->attr == attr);
+}
+
+static void bass_bcast_recv_state_read(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct bt_bass *bass = user_data;
+	struct bt_bap *bap = bap_get_session(att, bass->bdb->db);
+	uint8_t *rsp;
+	size_t rsp_len;
+	struct bt_bcast_src *bcast_src;
+
+	bcast_src = queue_find(bap->ldb->bass_bcast_srcs,
+					bass_src_match_attrib,
+					attrib);
+
+	if (!bcast_src) {
+		gatt_db_attribute_read_result(attrib, id, 0, NULL,
+							0);
+		return;
+	}
+
+	/* Build read response */
+	rsp = bass_build_read_rsp_from_bcast_src(bcast_src, &rsp_len);
+
+	if (!rsp) {
+		gatt_db_attribute_read_result(attrib, id,
+					BT_ATT_ERROR_UNLIKELY,
+					NULL, 0);
+		return;
+	}
+
+	gatt_db_attribute_read_result(attrib, id, 0, (void *)rsp,
+						rsp_len);
+
+	free(rsp);
+}
+
+static void bcast_recv_new(struct bt_bass *bass, int i)
+{
+	struct bt_bcast_recv_state *bcast_recv_state;
+	bt_uuid_t uuid;
+
+	if (!bass)
+		return;
+
+	bcast_recv_state = new0(struct bt_bcast_recv_state, 1);
+	bcast_recv_state->bass = bass;
+
+	bt_uuid16_create(&uuid, BCAST_RECV_STATE_UUID);
+	bcast_recv_state->attr =
+		gatt_db_service_add_characteristic(bass->service, &uuid,
+				BT_ATT_PERM_READ | BT_ATT_PERM_READ_ENCRYPT,
+				BT_GATT_CHRC_PROP_READ |
+				BT_GATT_CHRC_PROP_NOTIFY,
+				bass_bcast_recv_state_read, NULL,
+				bass);
+
+	bcast_recv_state->ccc = gatt_db_service_add_ccc(bass->service,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bass->bcast_recv_states[i] = bcast_recv_state;
+}
+
+struct bt_bass *bass_new(struct gatt_db *db)
+{
+	struct bt_bass *bass;
+	bt_uuid_t uuid;
+	int i;
+
+	if (!db)
+		return NULL;
+
+	bass = new0(struct bt_bass, 1);
+
+	/* Populate DB with BASS attributes */
+	bt_uuid16_create(&uuid, BASS_UUID);
+	bass->service = gatt_db_add_service(db, &uuid, true,
+					3 + (NUM_BCAST_RECV_STATES * 3));
+
+	for (i = 0; i < NUM_BCAST_RECV_STATES; i++)
+		bcast_recv_new(bass, i);
+
+	bt_uuid16_create(&uuid, BCAST_AUDIO_SCAN_CP_UUID);
+	bass->bcast_audio_scan_cp =
+		gatt_db_service_add_characteristic(bass->service,
+				&uuid,
+				BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_ENCRYPT,
+				BT_GATT_CHRC_PROP_WRITE,
+				NULL, bass_bcast_audio_scan_cp_write,
+				bass);
+
+	gatt_db_service_set_active(bass->service, true);
+
+	return bass;
+}
+
+void bass_bcast_src_free(void *data)
+{
+	struct bt_bcast_src *bcast_src = data;
+
+	for (int i = 0; i < bcast_src->num_subgroups; i++)
+		free(bcast_src->subgroup_data[i].meta);
+
+	free(bcast_src->subgroup_data);
+	free(bcast_src);
+}
+
+static void read_bcast_recv_state(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_bcast_src *bcast_src = user_data;
+
+	if (!success) {
+		DBG(bcast_src->bap, "Unable to read "
+			"Broadcast Receive State: error 0x%02x",
+			att_ecode);
+		return;
+	}
+
+	if (length == 0) {
+		queue_remove(bcast_src->bap->rdb->bass_bcast_srcs, bcast_src);
+		bass_bcast_src_free(bcast_src);
+		return;
+	}
+
+	if (bass_build_bcast_src_from_read_rsp(bcast_src, value, length)) {
+		queue_remove(bcast_src->bap->rdb->bass_bcast_srcs, bcast_src);
+		bass_bcast_src_free(bcast_src);
+		return;
+	}
+}
+
+static void bcast_recv_state_notify(struct bt_bap *bap, uint16_t value_handle,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct gatt_db_attribute *attr = user_data;
+	struct bt_bcast_src *bcast_src;
+	bool new_src = false;
+
+	bcast_src = queue_find(bap->rdb->bass_bcast_srcs,
+					bass_src_match_attrib, attr);
+	if (!bcast_src) {
+		new_src = true;
+		bcast_src = malloc(sizeof(*bcast_src));
+
+		if (!bcast_src) {
+			DBG(bap, "Failed to allocate "
+				"memory for broadcast source");
+			return;
+		}
+
+		memset(bcast_src, 0, sizeof(struct bt_bcast_src));
+		bcast_src->bap = bap;
+		bcast_src->attr = attr;
+	}
+
+	if (bass_build_bcast_src_from_notif(bcast_src, value, length)
+						&& new_src) {
+		bass_bcast_src_free(bcast_src);
+		return;
+	}
+
+	if (new_src)
+		queue_push_tail(bap->rdb->bass_bcast_srcs, bcast_src);
+}
+
+static struct bt_bass *bap_get_bass(struct bt_bap *bap)
+{
+	if (!bap)
+		return NULL;
+
+	if (bap->rdb->bass)
+		return bap->rdb->bass;
+
+	bap->rdb->bass = new0(struct bt_bass, 1);
+	bap->rdb->bass->bdb = bap->rdb;
+
+	return bap->rdb->bass;
+}
+
+static void foreach_bass_char(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct bt_bap *bap = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid, uuid_bcast_audio_scan_cp, uuid_bcast_recv_state;
+	struct bt_bass *bass;
+
+	/* Get attribute value handle and uuid */
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
+						NULL, NULL, &uuid))
+		return;
+
+	bt_uuid16_create(&uuid_bcast_audio_scan_cp, BCAST_AUDIO_SCAN_CP_UUID);
+	bt_uuid16_create(&uuid_bcast_recv_state, BCAST_RECV_STATE_UUID);
+
+	if (!bt_uuid_cmp(&uuid, &uuid_bcast_audio_scan_cp)) {
+		/* Found Broadcast Audio Scan Control Point characteristic */
+		bass = bap_get_bass(bap);
+
+		if (!bass || bass->bcast_audio_scan_cp)
+			return;
+
+		/* Store characteristic reference */
+		bass->bcast_audio_scan_cp = attr;
+
+		DBG(bap, "Broadcast Audio Scan Control Point "
+			"found: handle 0x%04x", value_handle);
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_bcast_recv_state)) {
+		/* Found Broadcast Receive State characteristic */
+		struct bt_bcast_src *bcast_src =
+				queue_find(bap->rdb->bass_bcast_srcs,
+						bass_src_match_attrib, attr);
+
+		if (!bcast_src) {
+			bcast_src = malloc(sizeof(struct bt_bcast_src));
+
+			if (bcast_src == NULL) {
+				DBG(bap, "Failed to allocate "
+					"memory for broadcast source");
+				return;
+			}
+
+			memset(bcast_src, 0, sizeof(struct bt_bcast_src));
+			bcast_src->bap = bap;
+			bcast_src->attr = attr;
+
+			queue_push_tail(bap->rdb->bass_bcast_srcs, bcast_src);
+		}
+
+		bt_gatt_client_read_value(bap->client, value_handle,
+						read_bcast_recv_state,
+						bcast_src, NULL);
+
+		(void)bap_register_notify(bap, value_handle,
+						bcast_recv_state_notify,
+						attr);
+
+		DBG(bap, "Broadcast Receive State found: handle 0x%04x",
+							value_handle);
+	}
+}
+
+void foreach_bass_service(struct gatt_db_attribute *attr,
+						void *user_data)
+{
+	struct bt_bap *bap = user_data;
+	struct bt_bass *bass = bap_get_bass(bap);
+
+	/* Store BASS attribute reference */
+	bass->service = attr;
+
+	/* Handle BASS attributes */
+	gatt_db_service_foreach_char(attr, foreach_bass_char, bap);
+}
diff --git a/src/shared/bass.h b/src/shared/bass.h
new file mode 100644
index 000000000..8edd73502
--- /dev/null
+++ b/src/shared/bass.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright 2023 NXP
+ *
+ */
+
+#define NUM_BCAST_RECV_STATES				2
+#define BT_BASS_BCAST_CODE_SIZE				16
+#define BT_BASS_BIG_SYNC_FAILED_BITMASK			0xFFFFFFFF
+#define BT_BASS_BCAST_SRC_LEN				15
+#define BT_BASS_BCAST_SRC_SUBGROUP_LEN			5
+
+/* Application error codes */
+#define BT_BASS_ERROR_OPCODE_NOT_SUPPORTED		0x80
+#define BT_BASS_ERROR_INVALID_SOURCE_ID			0x81
+
+/* PA_Sync_State values */
+#define BT_BASS_NOT_SYNCHRONIZED_TO_PA			0x00
+#define BT_BASS_SYNC_INFO_RE				0x01
+#define BT_BASS_SYNCHRONIZED_TO_PA			0x02
+#define BT_BASS_FAILED_TO_SYNCHRONIZE_TO_PA		0x03
+#define BT_BASS_NO_PAST					0x04
+
+/* BIG_Encryption values */
+#define BT_BASS_BIG_ENC_STATE_NO_ENC			0x00
+#define BT_BASS_BIG_ENC_STATE_BCODE_REQ			0x01
+#define BT_BASS_BIG_ENC_STATE_DEC			0x02
+#define BT_BASS_BIG_ENC_STATE_BAD_CODE			0x03
+
+/* BASS subgroup field of the Broadcast
+ * Receive State characteristic
+ */
+struct bt_bass_subgroup_data {
+	uint32_t bis_sync;
+	uint32_t pending_bis_sync;
+	uint8_t meta_len;
+	uint8_t *meta;
+};
+
+/* BASS Broadcast Source structure */
+struct bt_bcast_src {
+	struct bt_bap *bap;
+	struct gatt_db_attribute *attr;
+	uint8_t id;
+	uint8_t addr_type;
+	bdaddr_t addr;
+	uint8_t sid;
+	uint32_t bid;
+	uint8_t sync_state;
+	uint8_t enc;
+	uint8_t bad_code[BT_BASS_BCAST_CODE_SIZE];
+	uint8_t num_subgroups;
+	struct bt_bass_subgroup_data *subgroup_data;
+};
+
+/* Broadcast Receive State characteristic structure */
+struct bt_bcast_recv_state {
+	struct bt_bass *bass;
+	struct gatt_db_attribute *attr;
+	struct gatt_db_attribute *ccc;
+};
+
+/* BASS instance structure */
+struct bt_bass {
+	struct bt_bap_db *bdb;
+	struct gatt_db_attribute *service;
+	struct gatt_db_attribute *bcast_audio_scan_cp;
+	struct bt_bcast_recv_state *bcast_recv_states[NUM_BCAST_RECV_STATES];
+};
+
+/* Broadcast Audio Scan Control Point
+ * header structure
+ */
+struct bt_bass_bcast_audio_scan_cp_hdr {
+	uint8_t op;
+} __packed;
+
+#define BT_BASS_REMOTE_SCAN_STOPPED			0x00
+
+#define BT_BASS_REMOTE_SCAN_STARTED			0x01
+
+#define BT_BASS_ADD_SRC					0x02
+
+struct bt_bass_add_src_params {
+	uint8_t addr_type;
+	bdaddr_t addr;
+	uint8_t sid;
+	uint8_t bid[3];
+	uint8_t pa_sync;
+	uint16_t pa_interval;
+	uint8_t num_subgroups;
+	uint8_t subgroup_data[];
+} __packed;
+
+#define BT_BASS_MOD_SRC					0x03
+
+struct bt_bass_mod_src_params {
+	uint8_t id;
+	uint8_t pa_sync;
+	uint16_t pa_interval;
+	uint8_t num_subgroups;
+	uint8_t subgroup_data[];
+} __packed;
+
+#define BT_BASS_SET_BCAST_CODE				0x04
+
+struct bt_bass_set_bcast_code_params {
+	uint8_t id;
+	uint8_t bcast_code[BT_BASS_BCAST_CODE_SIZE];
+} __packed;
+
+#define BT_BASS_REMOVE_SRC				0x05
+
+struct bt_bass_remove_src_params {
+	uint8_t id;
+} __packed;
+
+struct bt_bass *bass_new(struct gatt_db *db);
+void bass_bcast_src_free(void *data);
+void foreach_bass_service(struct gatt_db_attribute *attr,
+						void *user_data);
-- 
2.34.1

