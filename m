Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB9AEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 08:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjF2IJR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 04:09:17 -0400
Received: from mail-he1eur01on2048.outbound.protection.outlook.com ([40.107.13.48]:45537
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232013AbjF2IIu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 04:08:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0OSmUDpH0qHXYjzmbh70+O3yBA8m+CkOui5NVXkJBtTIEBGcIkcqISuDTM1t307/bomdYjLMYgf09ZeJy3A9Ib6aGGW/EJNZgg0oB+DzdChmYKLsJe+JnhRTOSeVGU+5oUfj3Bb3M0LjUm+BUWG+mY7YvesBK8jgOCriFQXDcE63kckNhqZdhyt4Aywh5OjBH8X08gRbyatDkP/sU/9zLIk7pOW5/J8T76NUoP3C6A31Q2P5NyDE0eOkL0EyzOjA3Q70QUWnSgLw1WEMDXhu27zW07mHu0Va0xsXnoWXBhg4WVoXmuoRFR+//NbbhBVXMf577ZlxpT2pkRsCdmopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnzKcFSKEuqArpeh/pE4j6kpG+JangQfODp1YuZ/gTg=;
 b=bL1hxq9bHNa6hO79t+pjdZd97xeJ3HHvQM9xY4exeIXmB+hPFrgYGQqI0Dxx37depg1KdNjv+FGLpBFcTf9o1COLs96YDTi3JFbrDVJwlrB2322SzxbRbRDOkFKsXeVEZ9Q9RB29N9EU31bjFiiuKVPljp/5C8MGMhvpCe84uasqjktOGvBcoG+BIUtiAkeykLBtogXaFvT7FQNy2+bw2W6MSq7zvWyCMRBY2zOaRcRyYKOBuHPK8QK4OKTrqBlsot06RD5e11aWIIR8gO/58NKInUNgIhAQ4xcVhUK8StodpTvsgi3JXtRCQe9UUw4FHOX7a/DNvEMyB5AkmaH6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnzKcFSKEuqArpeh/pE4j6kpG+JangQfODp1YuZ/gTg=;
 b=P1gyHY+jTgBtpAijQusfLGvG2xlrDvJDekv9eZyQXHOQQDSSfsNy1W7D+NZTdxTUr2qz5I3ESJ3BTNmnY4pU8YW2KB5mCBGirAnkYIVNGu3/adz7mADbwFoWGN/Ba+5o5bRwc3BFbF7Zj+SBTa23J391alAa+Qjvs8cvatZRQ0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB9130.eurprd04.prod.outlook.com (2603:10a6:10:2f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 08:08:10 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 08:08:10 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v3 2/2] shared/bass: Introduce Add Source opcode handler
Date:   Thu, 29 Jun 2023 11:07:35 +0300
Message-Id: <20230629080735.525650-3-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 31d89739-9749-4810-6b49-08db7877faa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lv25HzUyXIMrVQ63INfp8kmVzHNmYU6DV0QDOWql2OjRbNl+Fs0cC9Yhj4DrzenN/Q8pjdGD2YdHBTs4E2WDunaJMLvJbuE2Rh0rZdmK3QS8xMQyn0eCo+fW/PBSy3/VNsOrvak1srKPMHu08X+JKS2nOfBMV2OCAvQ6yc/v09u0Z8wwA/6i/7q5vExT1NZZnwExUDGr0wPHeHuSypVTpFHQ967sXyfaMrvOV9JFbifPN8wGs4pNT0qj0sBdAHY7qNSQKwQcs0tBCfRGzGbPjhKgVpHGnjWAJeVka117PBpRVlJg+rzhvJDPhv53OE9CHxpz53WDSy2IhHCjRMEdPR68LtfDk/be2awx9+6Evmq3xnqfm908D6KnMGDVvjMtgY+jucNSofeqgiIG4oJqE+4yQu/bxh52L/q4bBpanCMR6Q3Rfq8WyFJat5lmpbetz5uLW8UkTfUv67THqMYy7v4uyEBBqVPprITrgK9PladsBJs8w60UKn5Gt5T9DvHGqmZ8D3NbEZwxKVt0V/Xjgj3jqXJ3RrJDUpaLTyaksKxSwJYt2NqkfaH2s/IZkZ2uN1q5vfiZSrfcW/LnPAEn+v3bOLuCg+EpIZl9mhxqSDCsC91+Fzy93gE7o9XKtLeoZrrAsjgh6gEaw/fPE4TeZ3VlkLQO7acxsxUoMz0krsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(52116002)(41300700001)(6512007)(316002)(83380400001)(86362001)(55236004)(186003)(44832011)(6506007)(26005)(1076003)(30864003)(2616005)(2906002)(38100700002)(38350700002)(5660300002)(36756003)(8676002)(8936002)(478600001)(4326008)(66556008)(66476007)(66946007)(6486002)(6916009)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ytTCoYWc9U8w0TiW5dlqyk2596zpaT3IaR7pXjF90w/QyZ8G1oayY9HjuWvM?=
 =?us-ascii?Q?9etm5u4eYEldWx5YM4/C/GYdAWg19JanAmha9D3GVq9zxPlZgATa0GRBkmY1?=
 =?us-ascii?Q?VzTiSE6jfWLgpKgX/Hi99IiT/r3ShsWW2qN3SbR8qCGtFY1cXcG1g1vegLLX?=
 =?us-ascii?Q?IhqjFRRh/rr0eDjMgVIhB9sozGIsVRzYS9QZIZkByQFRw7snjJP2Bb0qalv2?=
 =?us-ascii?Q?YJuP1P8sZbki6XGHqIvgBDu1hWrA5sKoC2kGineXerEcL8q2AHHvsG/tzcQ/?=
 =?us-ascii?Q?uS9XKrvMkQ5JzGs5lvlks0QEOC5999tivp7y2catK/pFqNTlLi0n3cxDH3gv?=
 =?us-ascii?Q?eCvlFG4+zYfJFQCKVhyBQvfIN7V+rYpd8z+nbaDNCCZzMKk6hPNaXsUTvvgz?=
 =?us-ascii?Q?9j5c8aQW89Rg2lOgiDEdUy1hWVK12h9QqjpAD0ppJDKAwgHKmQd3Co3nRcBW?=
 =?us-ascii?Q?jxfgo3LkhAAJhPSqpUCs9I7B2c+mCqfCs1ICNsAWSGrtqZU26czQESACsEpg?=
 =?us-ascii?Q?f4F0vtDsrs5jMI2UlAkFS2ims5/WAJewSuEaZ6311OMKTJLize6CIojnxLqQ?=
 =?us-ascii?Q?BLE5PxCbr/BVRMbdvNDDx5GquxiYxjNwEFcWZNIMi9i1dZ25t3T+8xqQeh45?=
 =?us-ascii?Q?580MQ05YbceaTIGVJmHtw0DU172OneTi17Cq/NwFV6P2nfCVO9z+IYT3hkpm?=
 =?us-ascii?Q?noZjfzmgEhEZdOWJAyEtUHvWESQgeTkH6xTVC09nVI50cT4CkKYoyHR/cqM4?=
 =?us-ascii?Q?ApcOL78yG2UXOOsybsPfcPUcOI+ohxOCtCx4BgFMWlC+a/g4/CQ5tW3YtuXw?=
 =?us-ascii?Q?qjJSzvbpDgaQDS6qG3+jDkQZNorc/DvLKuhQLAA3FnQI/4ppe2GkQZ9Yx/69?=
 =?us-ascii?Q?nB3ApceiXHG92PvOUTKn6Q1W9Bsoaf1triJaI3943B9Gi09bzglQSYvKf0U8?=
 =?us-ascii?Q?0n7cUaRPzDhl9QIBG7iyRKnW3AZ6U+Q8z19rbGi+fh+n22w7jKmumTRJ0WdC?=
 =?us-ascii?Q?J8btrbvGlFQQtRdXLW7JQeawc7PWc56zUOJezMKHW4c1cbsvmwM/liA5cQsa?=
 =?us-ascii?Q?4HLxvajaO+my0pBlc7jQrSOvscY0W8MKnCAlpoq/zEY3xZ+v0OL7hBs0GzoU?=
 =?us-ascii?Q?7BiSE+1psuw2cG868VFwAEPDUhIJ2M3tkABa19r4m+PA/jruL+F5lOe7ytdk?=
 =?us-ascii?Q?Gzyay+qduRfdgjgdfE5JxSbLLC+aRTksrYTtq8UxQmbkU77EHF+WJNZV+zT8?=
 =?us-ascii?Q?pNqM11x/KW7wWdbcELZGxRjGusdTjujE9zVN1yJMu1ddfOsjT/QQepQ/2Gww?=
 =?us-ascii?Q?O305x1dHZraaOjDK5MBJHYzDbPoWpSJfbnUlAihiXvwZvyQ/P5XYBR/1Xzz3?=
 =?us-ascii?Q?k0qqKOMA5MePcvXnMTrqxZ/hrEM47GAdii3+IcIDel0wUNbx9OGpnlamN1Kr?=
 =?us-ascii?Q?2QjXKBaMCLIifMenfb/MjuWeKZGFjbKGVDRkToGjkN8Zskbl9EEDDauqrdDw?=
 =?us-ascii?Q?qiSYHzwoLvHleMvqlesDED1XCTX/p5zdBA8B/qp5Hkuj4QdDC85Pw718z17B?=
 =?us-ascii?Q?2BlLb3Y3PwpcLL9eP0at2yGe+jgdibmaiVotgFLSVEzBjZk1Dfl8vk1AWPsZ?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d89739-9749-4810-6b49-08db7877faa2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 08:08:10.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whjjsnayeDXmFVPcCBg24wum+z1W71LvyWELEXZwnJdLHg8LPRLONptVlO43/nfjmY2SpW8lXVSjIaRXEqcXvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9130
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements the Control Point handler for the Add Source operation.
---
 Makefile.am           |   2 +-
 profiles/audio/bass.c |  26 ++-
 src/shared/bass.c     | 427 ++++++++++++++++++++++++++++++++++++++++--
 src/shared/bass.h     |  14 +-
 unit/test-bass.c      |   2 +-
 5 files changed, 453 insertions(+), 18 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2bd547564..98eb185fc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -580,7 +580,7 @@ unit_test_bap_LDADD = src/libshared-glib.la \
 
 unit_tests += unit/test-bass
 
-unit_test_bass_SOURCES = unit/test-bass.c
+unit_test_bass_SOURCES = unit/test-bass.c $(btio_sources)
 unit_test_bass_LDADD = src/libshared-glib.la \
 				lib/libbluetooth-internal.la $(GLIB_LIBS)
 
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index fae7fe004..7952105c5 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -37,10 +37,10 @@
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
 #include "src/shared/gatt-server.h"
+#include "src/adapter.h"
 #include "src/shared/bass.h"
 
 #include "src/plugin.h"
-#include "src/adapter.h"
 #include "src/gatt-database.h"
 #include "src/device.h"
 #include "src/profile.h"
@@ -197,7 +197,8 @@ static int bass_probe(struct btd_service *service)
 	data->service = service;
 
 	data->bass = bt_bass_new(btd_gatt_database_get_db(database),
-					btd_device_get_gatt_db(device));
+					btd_device_get_gatt_db(device),
+					btd_adapter_get_address(adapter));
 	if (!data->bass) {
 		error("Unable to create BASS instance");
 		free(data);
@@ -268,6 +269,25 @@ static int bass_disconnect(struct btd_service *service)
 	return 0;
 }
 
+static int bass_server_probe(struct btd_profile *p,
+				struct btd_adapter *adapter)
+{
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+
+	DBG("BASS path %s", adapter_get_path(adapter));
+
+	bt_bass_add_db(btd_gatt_database_get_db(database),
+				btd_adapter_get_address(adapter));
+
+	return 0;
+}
+
+static void bass_server_remove(struct btd_profile *p,
+					struct btd_adapter *adapter)
+{
+	DBG("BASS remove Adapter");
+}
+
 static struct btd_profile bass_service = {
 	.name		= "bass",
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
@@ -276,6 +296,8 @@ static struct btd_profile bass_service = {
 	.device_remove	= bass_remove,
 	.accept		= bass_accept,
 	.disconnect	= bass_disconnect,
+	.adapter_probe	= bass_server_probe,
+	.adapter_remove	= bass_server_remove,
 	.experimental	= true,
 };
 
diff --git a/src/shared/bass.c b/src/shared/bass.c
index 423ab5bf7..1bb40877f 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -14,9 +14,13 @@
 #include <stdbool.h>
 #include <unistd.h>
 #include <errno.h>
+#include <poll.h>
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
+#include "lib/iso.h"
+
+#include "btio/btio.h"
 
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
@@ -25,6 +29,8 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/bass.h"
 
+#define MAX_BIS_BITMASK_IDX		31
+
 #define DBG(_bass, fmt, arg...) \
 	bass_debug(_bass, "%s:%s() " fmt, __FILE__, __func__, ## arg)
 
@@ -45,6 +51,7 @@ struct bt_bcast_recv_state {
 
 struct bt_bass_db {
 	struct gatt_db *db;
+	bdaddr_t adapter_bdaddr;
 	struct queue *bcast_srcs;
 	struct gatt_db_attribute *service;
 	struct gatt_db_attribute *bcast_audio_scan_cp;
@@ -82,6 +89,35 @@ static struct queue *bass_db;
 static struct queue *bass_cbs;
 static struct queue *sessions;
 
+#define DEFAULT_IO_QOS \
+{ \
+	.interval	= 10000, \
+	.latency	= 10, \
+	.sdu		= 40, \
+	.phy		= 0x02, \
+	.rtn		= 2, \
+}
+
+static struct bt_iso_qos default_qos = {
+	.bcast = {
+		.big			= BT_ISO_QOS_BIG_UNSET,
+		.bis			= BT_ISO_QOS_BIS_UNSET,
+		.sync_interval		= 0x07,
+		.packing		= 0x00,
+		.framing		= 0x00,
+		.in			= DEFAULT_IO_QOS,
+		.out			= DEFAULT_IO_QOS,
+		.encryption		= 0x00,
+		.bcode			= {0x00},
+		.options		= 0x00,
+		.skip			= 0x0000,
+		.sync_timeout		= 0x4000,
+		.sync_cte_type		= 0x00,
+		.mse			= 0x00,
+		.timeout		= 0x4000,
+	}
+};
+
 static void bass_bcast_src_free(void *data);
 
 static void bass_debug(struct bt_bass *bass, const char *format, ...)
@@ -461,7 +497,7 @@ static bool bass_check_cp_command_len(const uint8_t *value, size_t len)
 	return true;
 }
 
-static void bass_handle_remote_scan_stopped_op(struct bt_bass_db *bdb,
+static void bass_handle_remote_scan_stopped_op(struct bt_bass *bass,
 					struct gatt_db_attribute *attrib,
 					uint8_t opcode,
 					unsigned int id,
@@ -472,7 +508,7 @@ static void bass_handle_remote_scan_stopped_op(struct bt_bass_db *bdb,
 		gatt_db_attribute_write_result(attrib, id, 0x00);
 }
 
-static void bass_handle_remote_scan_started_op(struct bt_bass_db *bdb,
+static void bass_handle_remote_scan_started_op(struct bt_bass *bass,
 					struct gatt_db_attribute *attrib,
 					uint8_t opcode,
 					unsigned int id,
@@ -491,7 +527,7 @@ static bool bass_src_id_match(const void *data, const void *match_data)
 	return (bcast_src->id == *id);
 }
 
-static void bass_handle_remove_src_op(struct bt_bass_db *bdb,
+static void bass_handle_remove_src_op(struct bt_bass *bass,
 					struct gatt_db_attribute *attrib,
 					uint8_t opcode,
 					unsigned int id,
@@ -504,7 +540,7 @@ static void bass_handle_remove_src_op(struct bt_bass_db *bdb,
 	/* Get Remove Source command parameters */
 	params = util_iov_pull_mem(iov, sizeof(*params));
 
-	bcast_src = queue_find(bdb->bcast_srcs,
+	bcast_src = queue_find(bass->ldb->bcast_srcs,
 						bass_src_id_match,
 						&params->id);
 
@@ -531,7 +567,7 @@ static void bass_handle_remove_src_op(struct bt_bass_db *bdb,
 			return;
 
 	/* Accept the operation and remove source */
-	queue_remove(bdb->bcast_srcs, bcast_src);
+	queue_remove(bass->ldb->bcast_srcs, bcast_src);
 	gatt_db_attribute_notify(bcast_src->attr, NULL, 0, att);
 	bass_bcast_src_free(bcast_src);
 
@@ -539,6 +575,338 @@ static void bass_handle_remove_src_op(struct bt_bass_db *bdb,
 		gatt_db_attribute_write_result(attrib, id, 0x00);
 }
 
+static bool bass_src_attr_match(const void *data, const void *match_data)
+{
+	const struct bt_bcast_src *bcast_src = data;
+	const struct gatt_db_attribute *attr = match_data;
+
+	return (bcast_src->attr == attr);
+}
+
+static gboolean check_io_err(GIOChannel *io)
+{
+	struct pollfd fds;
+
+	memset(&fds, 0, sizeof(fds));
+	fds.fd = g_io_channel_unix_get_fd(io);
+	fds.events = POLLERR;
+
+	if (poll(&fds, 1, 0) > 0 && (fds.revents & POLLERR))
+		return TRUE;
+
+	return FALSE;
+}
+
+static void bass_bis_unref(void *data)
+{
+	GIOChannel *io = data;
+
+	g_io_channel_unref(io);
+}
+
+static void connect_cb(GIOChannel *io, GError *gerr,
+				gpointer user_data)
+{
+	struct bt_bcast_src *bcast_src = user_data;
+	uint8_t *notify_data;
+	size_t notify_data_len;
+	int bis_idx;
+	int i;
+
+	if (bcast_src->sync_state == BT_BASS_NOT_SYNCHRONIZED_TO_PA)
+		bcast_src->sync_state = BT_BASS_SYNCHRONIZED_TO_PA;
+
+	/* Keep io reference */
+	g_io_channel_ref(io);
+	queue_push_tail(bcast_src->bises, io);
+
+	for (i = 0; i < bcast_src->num_subgroups; i++) {
+		struct bt_bass_subgroup_data *data =
+				&bcast_src->subgroup_data[i];
+
+		for (bis_idx = 0; bis_idx < MAX_BIS_BITMASK_IDX; bis_idx++) {
+			if (data->pending_bis_sync & (1 << bis_idx)) {
+				data->bis_sync |= (1 << bis_idx);
+				data->pending_bis_sync &= ~(1 << bis_idx);
+				break;
+			}
+		}
+
+		if (bis_idx < MAX_BIS_BITMASK_IDX)
+			break;
+	}
+
+	for (i = 0; i < bcast_src->num_subgroups; i++) {
+		if (bcast_src->subgroup_data[i].pending_bis_sync)
+			break;
+	}
+
+	/* If there are still pending bises, wait for their
+	 * notifications also before sending notification to
+	 * client
+	 */
+	if (i != bcast_src->num_subgroups)
+		return;
+
+	/* All connections have been notified */
+	if (check_io_err(io)) {
+		DBG(bcast_src->bass, "BIG sync failed");
+
+		/* Close all connected bises */
+		queue_destroy(bcast_src->bises, bass_bis_unref);
+		bcast_src->bises = NULL;
+
+		/* Close listen io */
+		g_io_channel_shutdown(bcast_src->listen_io, TRUE, NULL);
+		g_io_channel_unref(bcast_src->listen_io);
+		bcast_src->listen_io = NULL;
+
+		for (i = 0; i < bcast_src->num_subgroups; i++)
+			bcast_src->subgroup_data[i].bis_sync =
+				BT_BASS_BIG_SYNC_FAILED_BITMASK;
+	}
+
+	/* Send notification to client */
+	notify_data = bass_build_notif_from_bcast_src(bcast_src,
+						&notify_data_len);
+
+	gatt_db_attribute_notify(bcast_src->attr,
+					(void *)notify_data,
+					notify_data_len,
+					bt_bass_get_att(bcast_src->bass));
+
+	free(notify_data);
+}
+
+static struct bt_bass *bass_get_session(struct bt_att *att, struct gatt_db *db,
+		const bdaddr_t *adapter_bdaddr)
+{
+	const struct queue_entry *entry;
+	struct bt_bass *bass;
+
+	for (entry = queue_get_entries(sessions); entry; entry = entry->next) {
+		struct bt_bass *bass = entry->data;
+
+		if (att == bt_bass_get_att(bass))
+			return bass;
+	}
+
+	bass = bt_bass_new(db, NULL, adapter_bdaddr);
+	bass->att = att;
+
+	bt_bass_attach(bass, NULL);
+
+	return bass;
+}
+
+static void bass_handle_add_src_op(struct bt_bass *bass,
+					struct gatt_db_attribute *attrib,
+					uint8_t opcode,
+					unsigned int id,
+					struct iovec *iov,
+					struct bt_att *att)
+{
+	struct bt_bcast_src *bcast_src, *src;
+	uint8_t src_id = 0;
+	struct gatt_db_attribute *attr;
+	uint8_t *pa_sync;
+	GIOChannel *io;
+	GError *err = NULL;
+	struct bt_iso_qos iso_qos = default_qos;
+	uint8_t num_bis = 0;
+	uint8_t bis[ISO_MAX_NUM_BIS];
+	uint8_t *notify_data;
+	size_t notify_data_len;
+
+	if (opcode == BT_ATT_OP_WRITE_REQ)
+		gatt_db_attribute_write_result(attrib, id, 0x00);
+
+	/* Allocate a new broadcast source */
+	bcast_src = malloc(sizeof(*bcast_src));
+	if (!bcast_src) {
+		DBG(bass, "Unable to allocate broadcast source");
+		return;
+	}
+
+	queue_push_tail(bass->ldb->bcast_srcs, bcast_src);
+
+	memset(bcast_src, 0, sizeof(*bcast_src));
+	memset(bis, 0, ISO_MAX_NUM_BIS);
+
+	bcast_src->bass = bass;
+
+	/* Map the source to a Broadcast Receive State characteristic */
+	for (int i = 0; i < NUM_BCAST_RECV_STATES; i++) {
+		src = queue_find(bass->ldb->bcast_srcs,
+				bass_src_attr_match,
+				bass->ldb->bcast_recv_states[i]->attr);
+		if (!src) {
+			/* Found and empty characteristic */
+			bcast_src->attr =
+				bass->ldb->bcast_recv_states[i]->attr;
+			break;
+		}
+	}
+
+	if (!bcast_src->attr) {
+		/* If no empty characteristic has been found,
+		 * overwrite an existing one
+		 */
+		attr = bass->ldb->bcast_recv_states[0]->attr;
+
+		src = queue_find(bass->ldb->bcast_srcs,
+					bass_src_attr_match,
+					attr);
+
+		queue_remove(bass->ldb->bcast_srcs, src);
+		bass_bcast_src_free(src);
+		bcast_src->attr = attr;
+	}
+
+	/* Allocate source id */
+	while (true) {
+		src = queue_find(bass->ldb->bcast_srcs,
+				bass_src_id_match,
+				&src_id);
+		if (!src)
+			break;
+
+		if (src_id == 0xFF) {
+			DBG(bass, "Unable to allocate broadcast source id");
+			return;
+		}
+
+		src_id++;
+	}
+
+	bcast_src->id = src_id;
+
+	/* Populate broadcast source fields from command parameters */
+	if (*(uint8_t *)util_iov_pull_mem(iov, sizeof(bcast_src->addr_type)))
+		bcast_src->addr_type = BDADDR_LE_RANDOM;
+	else
+		bcast_src->addr_type = BDADDR_LE_PUBLIC;
+
+	bacpy(&bcast_src->addr, (bdaddr_t *)util_iov_pull_mem(iov,
+						sizeof(bdaddr_t)));
+	bcast_src->sid = *(uint8_t *)util_iov_pull_mem(iov,
+						sizeof(bcast_src->sid));
+	util_iov_pull_le24(iov, &bcast_src->bid);
+
+	pa_sync = util_iov_pull_mem(iov, sizeof(*pa_sync));
+	bcast_src->sync_state = BT_BASS_NOT_SYNCHRONIZED_TO_PA;
+
+	/* TODO: Set the encryption field based on observed BIGInfo reports,
+	 * after PA sync establishment
+	 */
+	bcast_src->enc = BT_BASS_BIG_ENC_STATE_NO_ENC;
+
+	/* TODO: Use the pa_interval field for the sync transfer procedure */
+	util_iov_pull_mem(iov, sizeof(uint16_t));
+
+	bcast_src->num_subgroups = *(uint8_t *)util_iov_pull_mem(iov,
+					sizeof(bcast_src->num_subgroups));
+
+	if (!bcast_src->num_subgroups)
+		return;
+
+	bcast_src->subgroup_data = malloc(bcast_src->num_subgroups *
+					sizeof(*bcast_src->subgroup_data));
+	if (!bcast_src->subgroup_data) {
+		DBG(bass, "Unable to allocate subgroup data");
+		goto err;
+	}
+
+	memset(bcast_src->subgroup_data, 0, sizeof(*bcast_src->subgroup_data));
+
+	for (int i = 0; i < bcast_src->num_subgroups; i++) {
+		struct bt_bass_subgroup_data *data =
+				&bcast_src->subgroup_data[i];
+
+		util_iov_pull_le32(iov, &data->pending_bis_sync);
+
+		if (data->pending_bis_sync != BIS_SYNC_NO_PREF)
+			/* Iterate through the bis sync bitmask written
+			 * by the client and store the bis indexes that
+			 * the BASS server will try to synchronize to
+			 */
+			for (int bis_idx = 0; bis_idx < 31; bis_idx++) {
+				if (data->pending_bis_sync & (1 << bis_idx)) {
+					bis[num_bis] = bis_idx + 1;
+					num_bis++;
+				}
+			}
+
+		data->meta_len = *(uint8_t *)util_iov_pull_mem(iov,
+						sizeof(data->meta_len));
+		if (!data->meta_len)
+			continue;
+
+		data->meta = malloc(data->meta_len);
+		if (!data->meta)
+			goto err;
+
+		memcpy(data->meta, (uint8_t *)util_iov_pull_mem(iov,
+					data->meta_len), data->meta_len);
+	}
+
+	if (pa_sync != PA_SYNC_NO_SYNC && num_bis > 0) {
+		/* If requested by client, try to synchronize to the source */
+		io = bt_io_listen(connect_cb, NULL, bcast_src, NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR,
+					&bass->ldb->adapter_bdaddr,
+					BT_IO_OPT_DEST_BDADDR,
+					&bcast_src->addr,
+					BT_IO_OPT_DEST_TYPE,
+					bcast_src->addr_type,
+					BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+					BT_IO_OPT_QOS, &iso_qos,
+					BT_IO_OPT_ISO_BC_SID, bcast_src->sid,
+					BT_IO_OPT_ISO_BC_NUM_BIS, num_bis,
+					BT_IO_OPT_ISO_BC_BIS, bis,
+					BT_IO_OPT_INVALID);
+
+		if (!io) {
+			DBG(bass, "%s", err->message);
+			g_error_free(err);
+			goto err;
+		}
+
+		bcast_src->listen_io = io;
+		g_io_channel_ref(bcast_src->listen_io);
+
+		if (!bcast_src->bises)
+			bcast_src->bises = queue_new();
+	} else {
+		for (int i = 0; i < bcast_src->num_subgroups; i++)
+			bcast_src->subgroup_data[i].bis_sync =
+				bcast_src->subgroup_data[i].pending_bis_sync;
+
+		notify_data = bass_build_notif_from_bcast_src(bcast_src,
+							&notify_data_len);
+
+		gatt_db_attribute_notify(bcast_src->attr,
+				(void *)notify_data,
+				notify_data_len,
+				bt_bass_get_att(bcast_src->bass));
+
+		free(notify_data);
+	}
+
+	return;
+
+err:
+	if (bcast_src->subgroup_data) {
+		for (int i = 0; i < bcast_src->num_subgroups; i++)
+			free(bcast_src->subgroup_data[i].meta);
+
+		free(bcast_src->subgroup_data);
+	}
+
+	free(bcast_src);
+}
+
+
 #define BASS_OP(_str, _op, _size, _func) \
 	{ \
 		.str = _str, \
@@ -551,7 +919,7 @@ struct bass_op_handler {
 	const char	*str;
 	uint8_t		op;
 	size_t		size;
-	void		(*func)(struct bt_bass_db *bdb,
+	void		(*func)(struct bt_bass *bass,
 				struct gatt_db_attribute *attrib,
 				uint8_t opcode,
 				unsigned int id,
@@ -564,6 +932,8 @@ struct bass_op_handler {
 		0, bass_handle_remote_scan_started_op),
 	BASS_OP("Remove Source", BT_BASS_REMOVE_SRC,
 		0, bass_handle_remove_src_op),
+	BASS_OP("Add Source", BT_BASS_ADD_SRC,
+		0, bass_handle_add_src_op),
 	{}
 };
 
@@ -576,6 +946,8 @@ static void bass_bcast_audio_scan_cp_write(struct gatt_db_attribute *attrib,
 	struct bt_bass_db *bdb = user_data;
 	struct bt_bass_bcast_audio_scan_cp_hdr *hdr;
 	struct bass_op_handler *handler;
+	struct bt_bass *bass = bass_get_session(att, bdb->db,
+						&bdb->adapter_bdaddr);
 	struct iovec iov = {
 		.iov_base = (void *)value,
 		.iov_len = len,
@@ -596,7 +968,7 @@ static void bass_bcast_audio_scan_cp_write(struct gatt_db_attribute *attrib,
 	/* Call the appropriate opcode handler */
 	for (handler = bass_handlers; handler && handler->str; handler++) {
 		if (handler->op == hdr->op) {
-			handler->func(bdb, attrib, opcode, id, &iov, att);
+			handler->func(bass, attrib, opcode, id, &iov, att);
 			return;
 		}
 	}
@@ -625,8 +997,10 @@ static void bass_bcast_recv_state_read(struct gatt_db_attribute *attrib,
 	uint8_t *rsp;
 	size_t rsp_len;
 	struct bt_bcast_src *bcast_src;
+	struct bt_bass *bass = bass_get_session(att, bdb->db,
+						&bdb->adapter_bdaddr);
 
-	bcast_src = queue_find(bdb->bcast_srcs,
+	bcast_src = queue_find(bass->ldb->bcast_srcs,
 					bass_src_match_attrib,
 					attrib);
 
@@ -712,6 +1086,14 @@ static void bass_bcast_src_free(void *data)
 		free(bcast_src->subgroup_data[i].meta);
 
 	free(bcast_src->subgroup_data);
+
+	if (bcast_src->listen_io) {
+		g_io_channel_shutdown(bcast_src->listen_io, TRUE, NULL);
+		g_io_channel_unref(bcast_src->listen_io);
+	}
+
+	queue_destroy(bcast_src->bises, bass_bis_unref);
+
 	free(bcast_src);
 }
 
@@ -900,6 +1282,14 @@ static void foreach_bass_service(struct gatt_db_attribute *attr,
 	gatt_db_service_foreach_char(attr, foreach_bass_char, bass);
 }
 
+static void bass_attached(void *data, void *user_data)
+{
+	struct bt_bass_cb *cb = data;
+	struct bt_bass *bass = user_data;
+
+	cb->attached(bass, cb->user_data);
+}
+
 bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client)
 {
 	bt_uuid_t uuid;
@@ -909,6 +1299,8 @@ bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client)
 
 	queue_push_tail(sessions, bass);
 
+	queue_foreach(bass_cbs, bass_attached, bass);
+
 	if (!client)
 		return true;
 
@@ -990,7 +1382,8 @@ bool bt_bass_set_user_data(struct bt_bass *bass, void *user_data)
 	return true;
 }
 
-static struct bt_bass_db *bass_db_new(struct gatt_db *db)
+static struct bt_bass_db *bass_db_new(struct gatt_db *db,
+				const bdaddr_t *adapter_bdaddr)
 {
 	struct bt_bass_db *bdb;
 
@@ -999,6 +1392,7 @@ static struct bt_bass_db *bass_db_new(struct gatt_db *db)
 
 	bdb = new0(struct bt_bass_db, 1);
 	bdb->db = gatt_db_ref(db);
+	bacpy(&bdb->adapter_bdaddr, adapter_bdaddr);
 	bdb->bcast_srcs = queue_new();
 
 	if (!bass_db)
@@ -1019,7 +1413,8 @@ static bool bass_db_match(const void *data, const void *match_data)
 	return (bdb->db == db);
 }
 
-static struct bt_bass_db *bass_get_db(struct gatt_db *db)
+static struct bt_bass_db *bass_get_db(struct gatt_db *db,
+				const bdaddr_t *adapter_bdaddr)
 {
 	struct bt_bass_db *bdb;
 
@@ -1027,7 +1422,7 @@ static struct bt_bass_db *bass_get_db(struct gatt_db *db)
 	if (bdb)
 		return bdb;
 
-	return bass_db_new(db);
+	return bass_db_new(db, adapter_bdaddr);
 }
 
 static struct bt_bass *bt_bass_ref(struct bt_bass *bass)
@@ -1040,7 +1435,8 @@ static struct bt_bass *bt_bass_ref(struct bt_bass *bass)
 	return bass;
 }
 
-struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb)
+struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb,
+				const bdaddr_t *adapter_bdaddr)
 {
 	struct bt_bass *bass;
 	struct bt_bass_db *db;
@@ -1048,7 +1444,7 @@ struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	if (!ldb)
 		return NULL;
 
-	db = bass_get_db(ldb);
+	db = bass_get_db(ldb, adapter_bdaddr);
 	if (!db)
 		return NULL;
 
@@ -1140,3 +1536,8 @@ bool bt_bass_unregister(unsigned int id)
 
 	return true;
 }
+
+void bt_bass_add_db(struct gatt_db *db, const bdaddr_t *adapter_bdaddr)
+{
+	bass_db_new(db, adapter_bdaddr);
+}
diff --git a/src/shared/bass.h b/src/shared/bass.h
index d3474f7cf..fb4b72d7d 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -56,6 +56,8 @@ struct bt_bcast_src {
 	uint8_t bad_code[BT_BASS_BCAST_CODE_SIZE];
 	uint8_t num_subgroups;
 	struct bt_bass_subgroup_data *subgroup_data;
+	GIOChannel *listen_io;
+	struct queue *bises;
 };
 
 /* Broadcast Audio Scan Control Point
@@ -71,6 +73,14 @@ struct bt_bass_bcast_audio_scan_cp_hdr {
 
 #define BT_BASS_ADD_SRC					0x02
 
+/* PA_Sync values */
+#define PA_SYNC_NO_SYNC					0x00
+#define PA_SYNC_PAST					0x01
+#define PA_SYNC_NO_PAST					0x02
+
+/* BIS_Sync no preference bitmask */
+#define BIS_SYNC_NO_PREF				0xFFFFFFFF
+
 struct bt_bass_add_src_params {
 	uint8_t addr_type;
 	bdaddr_t addr;
@@ -115,8 +125,10 @@ unsigned int bt_bass_register(bt_bass_func_t attached, bt_bass_func_t detached,
 bool bt_bass_unregister(unsigned int id);
 bool bt_bass_set_debug(struct bt_bass *bass, bt_bass_debug_func_t func,
 			void *user_data, bt_bass_destroy_func_t destroy);
-struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb);
+struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb,
+			const bdaddr_t *adapter_bdaddr);
 bool bt_bass_set_user_data(struct bt_bass *bass, void *user_data);
 void bt_bass_unref(struct bt_bass *bass);
 bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client);
 void bt_bass_detach(struct bt_bass *bass);
+void bt_bass_add_db(struct gatt_db *db, const bdaddr_t *adapter_bdaddr);
diff --git a/unit/test-bass.c b/unit/test-bass.c
index 8937c9478..2ab61f760 100644
--- a/unit/test-bass.c
+++ b/unit/test-bass.c
@@ -309,7 +309,7 @@ static void test_server(const void *user_data)
 	gatt_db_ccc_register(data->db, gatt_ccc_read_cb, NULL,
 					NULL, data);
 
-	data->bass = bt_bass_new(data->db, NULL);
+	data->bass = bt_bass_new(data->db, NULL, BDADDR_ANY);
 	g_assert(data->bass);
 
 	data->server = bt_gatt_server_new(data->db, att, 64, 0);
-- 
2.34.1

