Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607A1EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 15:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjF1PHg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 11:07:36 -0400
Received: from mail-dbaeur03on2087.outbound.protection.outlook.com ([40.107.104.87]:45376
        "EHLO EUR03-DBA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231340AbjF1PHe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 11:07:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ws8no74F3Un2I+ODU4itiDntWbbOWpdZ6vVzAZ0JLFK5X+NBsRYEKgYkRFpxdux0QTuiNcu53o2kHM+2fMPZFz1MmKfzowAEDAFKVS7PwkLg0Fhay1KLDuOXUDm/huTG//ocUgCQyjtX5PpEGxgCoclLEn3TjmOxit8nCdoHxml8NbxqbL2kezz8Twt5kSPcjr0c0/asxrGdSXjAAI4YPjokSSaDA9dmwttLPUKfraj/SBt9uGlBWtXrWuCG51Hi+xVALyeI+WiE5MBJjr4L4mjmdtqVCk495Ol5QCQr6nPm5jd9aDcqi+RMYNeko+kVbhnK2yItmBRboVXzdxG1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yS7J6qTdPkILtOm4c40Jpr8el4De0APj2VdicJHL5Y=;
 b=Rgv2AX9nOFKSlx+epAGVdEOkJR9iu7FTkSBkorGY7eWIAulcc3Mlc2EvF/YXASlrKcV95Ew35DASVmMZJPgNq8YqqscPMqFY9Qsq2JhQZ9te+4lE+K+c2d/NrOirNO74DSLY2WlOkJAGR+0by9WvwFtKVTvu4wh15OBKIE79jx+LzROZGRSxTwgxAWzFIvIc1z8FfMURwVI3I4R5ekijSIVnYghwJbUH16CeFKTRVanhwM7v/ry1MsRN12NlxQ/dphlNWe+uMqAok1aU6AjJNBGjN7z0qu2tdYHibyLu9/d4ki4fJW1MTzQjBsjaz5L4fc5z5eWmed29fiLOzgjK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yS7J6qTdPkILtOm4c40Jpr8el4De0APj2VdicJHL5Y=;
 b=J1DNoKL4cZLcgnWyxqG78hNEi95FrwvjSboDU6maGsCs4hRL0LZxCl6hDv62vFLkp1w17sBYRSBrfjTUs+Ju3Yu38CCXzKDG727WeNrAJSu7CYoCy0Qe8gnjrfyYeBu6J0kmYpVndP9jiLTBACZq8I6wV6J7oFWNL30RjZmJ+A8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB8PR04MB6953.eurprd04.prod.outlook.com (2603:10a6:10:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 15:07:31 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 15:07:31 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 2/2] shared/bass: Introduce Add Source opcode handler
Date:   Wed, 28 Jun 2023 18:07:05 +0300
Message-Id: <20230628150705.248285-3-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 36e93661-274d-4dc4-7590-08db77e9650a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PH/qesK9zpFxCYiI8Lg/pvG3TtlIl+qize3xUHzadrVJRYAQfqAU3dUcs/lxi7dJlfuvnVv0xrU+/PBnxJQYXm1dZSybizDjOH5CsJ3RQ3VRGsD3ZWSN2OD4iwVX5UshuEghFBYM+tiniYaEMtWf6Aph/NeUk619/ROyRbleFRdu1R9NmHvpPgKMjXqTwz0LpFePvQVAcX5oiz88/ytGGWP6S1J3meIEHkEBXnp4HOZWvGv50d3a20wxx6Ba8B08R1ikcUpEalqMBTNdsYh7bZxrq+i6VEUnVZuGoybdRxoc5oPaD5XjPz/uQeIDB23Pc4vghRtIXXzG0cSsheRK7Tq5mfOS85AqBfRBeA+vGgCRRaLimg9IFmBzbWE/psZge0LP8NTHHAX2eCyQXSIii8CcFvM/m6vn7CMx0ZqVeGDZpcAtOqBWJ97RrLKkKIwK5tmkVORMdUjMDWMarRpxd3apwE8DDmgD2LSjE7izyjG2E8GH2sy64G85147fSsQB+IcKqurHwJs8o7u3IczPKrHQQNqIsr3nk3oCVIf7wc6ZJOkPOv9xErD9pUQ+ftDYQwFaxRSCTjNIR8khpDHZRUrS/13QRyqyNcC17tB/CqrZA39B6GS0NnAVC10Z0Ao
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(186003)(2906002)(26005)(66476007)(30864003)(5660300002)(41300700001)(8676002)(6666004)(6916009)(36756003)(52116002)(316002)(2616005)(478600001)(6486002)(86362001)(4326008)(38100700002)(38350700002)(1076003)(8936002)(83380400001)(44832011)(66946007)(66556008)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+2V2O62w/KvmpCb8OTEU00KSzIClHYPxrlW7MfTdWLiCeJsf0bhmP5ehvVzo?=
 =?us-ascii?Q?GadO4oZoT9/0qkBJEa4se4jOz3SiLFbCcucoYbmejpwFx1xWOzChyNqee7JF?=
 =?us-ascii?Q?YS7IwunIKmYOfcMDrg4aW1pZweOSs0mkUfiI3UyGrIoWwnBhU60e0AGj3U3g?=
 =?us-ascii?Q?ar7uSZS+n4zqdoJRd9oD2Eux8h9ZvQQ8HvaW1cuf/Y9v0g6dvKAYMPONxw2A?=
 =?us-ascii?Q?+A7XZBfFkYNU948pnuOT0XkvPJwXdh3HTaFb7+P+P/jBZPgNDsYCIW2Vdt3I?=
 =?us-ascii?Q?QYkECzqjotvdHu3Q7KwQbm5284/5DL+JANYZ0C/mg9oJWG32hzfIwzUqViK0?=
 =?us-ascii?Q?Hf3kCeCXcio+U5Hfsyab5+CSGsO6TLxwzETRJW4kK4eZ2fScMPx4fdvrV4fQ?=
 =?us-ascii?Q?+GjjN13MIIS3ADFZmirHiTNc9BmblBjv6ik3QcDecOFuWcgJq4LkNDLAd4pi?=
 =?us-ascii?Q?lRMSOeaNa9RtKCEuJeN2CPbwz1tNLwx3ZRSKDscFCVWVn3uDgbWF6vDuV7Ki?=
 =?us-ascii?Q?sBlCn1CYop/UOhJcXMJAD6nj64RCPeZ6IJ2X2jwYvMNVy4U5al7ujJe/n5Ps?=
 =?us-ascii?Q?U1AfUB2SzzISzZphX5wEcUB1yd9ZNNJAGdcAhnRdwjYr09mLild/eCHGjbXl?=
 =?us-ascii?Q?4ZboYWTh1bgkC/eIKMwz2TlxJ5Nn0O9XAb9cmts7FzgaJf2RLKwQwyh/RfOV?=
 =?us-ascii?Q?5pjpVFFVYEmxr24JxOvQEXo7R1jZc8bXSbRsfiq9w4by3Mg4x7nyDRPv9rsm?=
 =?us-ascii?Q?K8pOepGedXxowr4a2ZHW/RRPcYWJ6Cu7HHu+BP3Vqkiho5x1HrFP/5+ERu7j?=
 =?us-ascii?Q?LFdem+tSida0d6x72fxMYSslzliIva3TbEIy3ALZKw5oWAYlffnTdng22dOw?=
 =?us-ascii?Q?9iBDaiWa9N8U5jVuT+HAGPEhU1RdP2i6S+CX8iQLQGmYKTRKWLORfR/R6pM4?=
 =?us-ascii?Q?svHs9tNKAxJw4ZfQpPL62kkVnIQkNgFqYjbMXh3MG2fpkp3f1+bAdbcMkfoF?=
 =?us-ascii?Q?YMpFtMPpt2uUZIrKgBwg0UReyGW0TbPA4ap4cHmDfzkcHvBD7lz+pa0XPVrI?=
 =?us-ascii?Q?LaleLETG/giaulQm0k074mZdFHTR5rzCWM8kZvix9BHUmEPtwUi2vMmi6Oto?=
 =?us-ascii?Q?fwl2J6C8IDt9IQO6jfmjC9f/XiqXyQdWxtIdBlt++wfzUiGlqnPjv4sav5sp?=
 =?us-ascii?Q?4S6gkKQTi1q/sXMkLOSQr1U32s/X52cYKHcDMr9qJgff+Zeh9WHkemKrbr2w?=
 =?us-ascii?Q?1hvoPVFaKTjiZWIJ1+Z7hlLUzxw0vZimP8CKBE30/FAkOG7xDDCgRzpNGfyY?=
 =?us-ascii?Q?A5qiYMVRyDQI5YF5IhqIpG/vrxBCDp++JmqEMBJKmB/QGSfCizR3nibdl0cy?=
 =?us-ascii?Q?MoKF/E0dBUYDT4Lgm5B0erTl/nybcfRFPES4jUoCkdc0rYyTG0ifIRxPsB9q?=
 =?us-ascii?Q?kYCqU7FsmPGQn5C2Ppz9ChLZ1NKeDyBe4bDZx9lB1Gnvuw20Y8KMVKZLDZ0s?=
 =?us-ascii?Q?LjZIbXCmt7j91ADTJzRp/AAymQeNOoVbvfLbgmrhjkpzYp/jjo8NzHO9oKsd?=
 =?us-ascii?Q?zZLHoRvXw395Y3C80XQDIUENh3uOyw5uO3rXQ9psy3hTKDkeCyW6b1PNi99X?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e93661-274d-4dc4-7590-08db77e9650a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:07:31.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K12cPpZDMjmASJCjLrIQCDHBOrgZ64ypEjC/EyOYzbGlxnAPmbjmYLw8mVgiQtlHu8PvawpVGVW6Eks2FR75ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6953
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements the Control Point handler for the Add Source operation.
---
 Makefile.am           |   2 +-
 profiles/audio/bass.c |  26 ++-
 src/shared/bass.c     | 430 ++++++++++++++++++++++++++++++++++++++++--
 src/shared/bass.h     |  14 +-
 unit/test-bass.c      |   2 +-
 5 files changed, 456 insertions(+), 18 deletions(-)

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
index 423ab5bf7..3557dda0f 100644
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
 
@@ -539,6 +575,341 @@ static void bass_handle_remove_src_op(struct bt_bass_db *bdb,
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
+					bis[num_bis] = bis_sync_bit + 1;
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
+		bacpy(&bc_addr.bc_bdaddr, &bcast_src->addr);
+		bc_addr.bc_bdaddr_type = bcast_src->addr_type;
+
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
@@ -551,7 +922,7 @@ struct bass_op_handler {
 	const char	*str;
 	uint8_t		op;
 	size_t		size;
-	void		(*func)(struct bt_bass_db *bdb,
+	void		(*func)(struct bt_bass *bass,
 				struct gatt_db_attribute *attrib,
 				uint8_t opcode,
 				unsigned int id,
@@ -564,6 +935,8 @@ struct bass_op_handler {
 		0, bass_handle_remote_scan_started_op),
 	BASS_OP("Remove Source", BT_BASS_REMOVE_SRC,
 		0, bass_handle_remove_src_op),
+	BASS_OP("Add Source", BT_BASS_ADD_SRC,
+		0, bass_handle_add_src_op),
 	{}
 };
 
@@ -576,6 +949,8 @@ static void bass_bcast_audio_scan_cp_write(struct gatt_db_attribute *attrib,
 	struct bt_bass_db *bdb = user_data;
 	struct bt_bass_bcast_audio_scan_cp_hdr *hdr;
 	struct bass_op_handler *handler;
+	struct bt_bass *bass = bass_get_session(att, bdb->db,
+						&bdb->adapter_bdaddr);
 	struct iovec iov = {
 		.iov_base = (void *)value,
 		.iov_len = len,
@@ -596,7 +971,7 @@ static void bass_bcast_audio_scan_cp_write(struct gatt_db_attribute *attrib,
 	/* Call the appropriate opcode handler */
 	for (handler = bass_handlers; handler && handler->str; handler++) {
 		if (handler->op == hdr->op) {
-			handler->func(bdb, attrib, opcode, id, &iov, att);
+			handler->func(bass, attrib, opcode, id, &iov, att);
 			return;
 		}
 	}
@@ -625,8 +1000,10 @@ static void bass_bcast_recv_state_read(struct gatt_db_attribute *attrib,
 	uint8_t *rsp;
 	size_t rsp_len;
 	struct bt_bcast_src *bcast_src;
+	struct bt_bass *bass = bass_get_session(att, bdb->db,
+						&bdb->adapter_bdaddr);
 
-	bcast_src = queue_find(bdb->bcast_srcs,
+	bcast_src = queue_find(bass->ldb->bcast_srcs,
 					bass_src_match_attrib,
 					attrib);
 
@@ -712,6 +1089,14 @@ static void bass_bcast_src_free(void *data)
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
 
@@ -900,6 +1285,14 @@ static void foreach_bass_service(struct gatt_db_attribute *attr,
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
@@ -909,6 +1302,8 @@ bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client)
 
 	queue_push_tail(sessions, bass);
 
+	queue_foreach(bass_cbs, bass_attached, bass);
+
 	if (!client)
 		return true;
 
@@ -990,7 +1385,8 @@ bool bt_bass_set_user_data(struct bt_bass *bass, void *user_data)
 	return true;
 }
 
-static struct bt_bass_db *bass_db_new(struct gatt_db *db)
+static struct bt_bass_db *bass_db_new(struct gatt_db *db,
+				const bdaddr_t *adapter_bdaddr)
 {
 	struct bt_bass_db *bdb;
 
@@ -999,6 +1395,7 @@ static struct bt_bass_db *bass_db_new(struct gatt_db *db)
 
 	bdb = new0(struct bt_bass_db, 1);
 	bdb->db = gatt_db_ref(db);
+	bacpy(&bdb->adapter_bdaddr, adapter_bdaddr);
 	bdb->bcast_srcs = queue_new();
 
 	if (!bass_db)
@@ -1019,7 +1416,8 @@ static bool bass_db_match(const void *data, const void *match_data)
 	return (bdb->db == db);
 }
 
-static struct bt_bass_db *bass_get_db(struct gatt_db *db)
+static struct bt_bass_db *bass_get_db(struct gatt_db *db,
+				const bdaddr_t *adapter_bdaddr)
 {
 	struct bt_bass_db *bdb;
 
@@ -1027,7 +1425,7 @@ static struct bt_bass_db *bass_get_db(struct gatt_db *db)
 	if (bdb)
 		return bdb;
 
-	return bass_db_new(db);
+	return bass_db_new(db, adapter_bdaddr);
 }
 
 static struct bt_bass *bt_bass_ref(struct bt_bass *bass)
@@ -1040,7 +1438,8 @@ static struct bt_bass *bt_bass_ref(struct bt_bass *bass)
 	return bass;
 }
 
-struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb)
+struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb,
+				const bdaddr_t *adapter_bdaddr)
 {
 	struct bt_bass *bass;
 	struct bt_bass_db *db;
@@ -1048,7 +1447,7 @@ struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	if (!ldb)
 		return NULL;
 
-	db = bass_get_db(ldb);
+	db = bass_get_db(ldb, adapter_bdaddr);
 	if (!db)
 		return NULL;
 
@@ -1140,3 +1539,8 @@ bool bt_bass_unregister(unsigned int id)
 
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

