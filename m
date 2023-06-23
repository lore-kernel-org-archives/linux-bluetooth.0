Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08E4C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 07:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjFWHrd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 03:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjFWHra (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 03:47:30 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A271BE4
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 00:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/7MhLSrFfxDDs8+5MvQ1kEj4CtJ1vEJ9kE0py54pNHFrf1Ci6gJ3dfRu5BRPrBR52mIN+zErAZ7crl/10bBIbpj96+xw2DIZ1h0wdRShJEo3EJ1pmzoKUzT5TQ5E/CzauPuMyOigbT+OJaHYTjdVxlRIKspT2ZIC5ssp4EjJfdj9UMYJW521s55Zxwx5L9bMMIp2XXxoud3eISWxoC5Tgn8XlE/sBhOhg26X5m9HIugsfpAjhLpMVM9BoSWNIu2wSd+4ug2PAemK/QYOHZT6Bkmz7b+gtIJm0ayEzhFUBdX97T0dMF2IhfayDUEarYPA4NhCOHVOT6H3IGvfS3ZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLnHt8ELp+JbACTkjRu8/g18NQp7HqJuAgri41Q4ob4=;
 b=NY0BpiHHSX/ribAo6vy2PLNK3ZVHDU1oBcOuoweRS6KnSR71Pod/r5kRV+RT/9szUQDJidgB7uYlUZb2Qh+e5Vpj06rADKK7P93Gr22BfS0fW7AvYspmMZE2FV0GL4igGB13+eoLo8cVM3u1QIaNrq3z24LS1qMmMT+Zp6xGiqciU9iBzWGpxHQyo4ZyWetBACKHShGSEYIexBs4/2EDMheA2qt38W7D7i/ANTeSmiaD8fT2Ror+nlUBU9lOjjruBBk0iMs1cuMhdWe2ujpycKqj7It1m/u0H9HIUVCWudtrmj6cNjUjRcq6O5M/hgXzSROVg2/v0EKdupGeZkSl5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLnHt8ELp+JbACTkjRu8/g18NQp7HqJuAgri41Q4ob4=;
 b=qrVg/Xcid0KerI/EZT6A0UoEenVjS9Ve2oMq5kC5+zfTavYh7GL69y3zIrp0qQ/ml7dJFm1z4GteYxbicHjncXqXRmE/xzsMYD3OqTIXpz8Oo31RqtAHRMX1Ok+Z2blJQRb8m5wU1QI+D3GfYftHr7lh1XN48npsh0jcLInZKOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB9925.eurprd04.prod.outlook.com (2603:10a6:150:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:47:18 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:47:18 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/2] shared/bass: Introduce Add Source opcode handler
Date:   Fri, 23 Jun 2023 10:46:57 +0300
Message-Id: <20230623074657.16618-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623074657.16618-1-iulia.tanasescu@nxp.com>
References: <20230623074657.16618-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0228.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB9925:EE_
X-MS-Office365-Filtering-Correlation-Id: 66128209-f413-457b-bb09-08db73be11f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHtuBsYO/KtAxfUk3gPWXOUqvD7aQYj8vf50XbTOyuSKjkWWX78Q9zjXFpCVnM9n/sI9Dk0iPpIOp/Ywmpn0peXvy6CLfg7RsA/uhI5R37uY626cZk6FrFi0es/Fix0HNW/iinwX2X2UG9KUA8OOG+lp8XbHsQwTtV60C45VyTBhNGAu0ZW5Ofp2+SLVOPmRXC3496qVKDCf72CsATPMFe1M3HVS1DK5K6VoPHMThVuYiOwJO7o7sIrxZD5dDHTOCaIKhIR0Z2FF9vashuZRNB5IKfjOoWxi0kxjDhjY02DufY0Kjnyqzj5oYwg5GxpDH0/PcNYYy0k7gyPDrKWgqIjonpfmWYEQ/5EKL1upWNAyoQIYj6Dip/q5j+qO2SFXYutMwdL0U15RTiSD9jE+wQhAVT8G6sYXVtY3KRW4dI4pxiqtGaah/6xOnf0cP1BvymHrgkqlnaAzexovKd/BYxIRprKvMzS83UVdcdexemJ437hdu/yAveqg3l/HnvF6KpDsgfa/ulAHu/6SUt/lkq+dSczg1EEUioAR+2MEYCZ6sV/6Jvej++izRHv0v6BxCs/OdzhWK701CNTrwAqosrzbMLYw0kSqq5EffYnnnshQSyfi5c8DRJ4P29mh7DYP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(26005)(1076003)(6506007)(6512007)(186003)(2616005)(4326008)(316002)(36756003)(6666004)(6486002)(6916009)(2906002)(66556008)(30864003)(66476007)(66946007)(41300700001)(86362001)(38350700002)(38100700002)(83380400001)(52116002)(5660300002)(478600001)(44832011)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iS1k1o1zWt1rts6MH5gIJKltcnwMXSCVkcEVYiwgMgcK1VJGKKXOvUB7FkeS?=
 =?us-ascii?Q?a5O7laT98c2vj7kOiP9o3IaMGg8yYex6wd/pOBy+Z7C18nzP48r0OxKaKQxP?=
 =?us-ascii?Q?RlqfG8FTOMxpPryPJ9gIwxoD/y0rMAirkzwsv5+doG9GDgOGeDsFLtFP1qRx?=
 =?us-ascii?Q?GZ59nFTDwF2CpF0lADGOAkI/mdDa8KEOHpwiy4rMOJfdQhDu6Tu97tBSXbax?=
 =?us-ascii?Q?aT5KQaFT4L7HmWG0c3SXAd9EOGWrjsvi3IYCb0p6aFHKVcp5/7ZK5ScPNThX?=
 =?us-ascii?Q?SRkHdBywjyRh6UG6MLgw5WvQp+Qb/b3RXyR3Pe0rqVPn1DrsKTcjeGJc/1kW?=
 =?us-ascii?Q?+ot0ZWa+3IERyM2+R7YsUvMf+c8s/uScmEyuUUAPp6B/w/WSO/Emmpq8KQ1l?=
 =?us-ascii?Q?JWTCfnU0v9z1mrA71hiby4ykvPn1zzJzkgWjYuAC0a+IDCzAnXIwfD0+STYS?=
 =?us-ascii?Q?jZFhfT75zSa2+oRzUmbG7WMjWmFDhOQjJR44AS222ZU7PPmOOo5F/ii0M2E8?=
 =?us-ascii?Q?CH28KsAI3UeoSy5lJS3pYsGXRNm4b11X3JuBlUkXQ+TEHwfdZsBMkJjWxGYw?=
 =?us-ascii?Q?tr9Qe9aHnnycnFSSAs4kDPya48WD2hM+RgIcGK26MCTWxnEkXb+HyUCDet+a?=
 =?us-ascii?Q?xfvTdrxBjiPV2CNXAWotRGV/YIuACboTNpFtKQtWH2uqVEwgjeujLN4mI85m?=
 =?us-ascii?Q?vkjaucRMVNdxAiW2ybGK5/CHwGTHWNHPeLsy7D0x5Sqq5Jd1mQmb6KVbhbzT?=
 =?us-ascii?Q?6eI0YP0GZjXmAO+AAi/wHovR16/kQr9ywhjXr6OzZOeSWOw1XK/hwK+yXZtv?=
 =?us-ascii?Q?45dAZChZuIUv9V6MXK/KHE0V1Pk4VqvjYRlA8v8EHuwnGbv81qM5UgxbvzpZ?=
 =?us-ascii?Q?Ac/mslgCr7McHRWurGrE82sYMbyxy9Lf7dzUyY6MbUImf9c84KjL26D0k24s?=
 =?us-ascii?Q?iko2YkdufSL8oiwVj2MU1s0efZVQUJNmsfMVT1IemwHwg0k6USOcFciKwMAX?=
 =?us-ascii?Q?k19zSgYPe8PBR4zt63hjv1W77abYjIxovPJAi2PDTVjpkWbo9HSFjAILT1Qx?=
 =?us-ascii?Q?sVpB+3oSmI162FdncJavirpcvHYVHig2KLUDHBXqJkAxrOdss7tVbizS3fDF?=
 =?us-ascii?Q?PnIY14KG0oy5NE0jplnWAgkfpmMwe0cHixPO3Tr2zVcDGuyHfn+h+l0UNV3d?=
 =?us-ascii?Q?uQxSlX1bcQcaSp15fpKPMnQzmYd+WD1sn+OStPz3FQj3/7W7dJw0P61WIdgc?=
 =?us-ascii?Q?IKzXDhN/P1hxq3bd/6lRW/Ic9/qwbC1ESvsWs1rEZ+yvUPlaYmN9rSrVMmYz?=
 =?us-ascii?Q?geLrp+21TUB0ybiMfkPohsP9LQxpR+6LhSuYocZ5OiZotOEiXTZYn0B9yFT+?=
 =?us-ascii?Q?Br789vw5buwZjn+R/JArknmmQZ0B4Zl6PVHtxEnAYw0x9CsPDore9T1E4m4l?=
 =?us-ascii?Q?gSslZCAl3CjR7E5CAMzX/ukeTkgSMukcUSUnmD29U5nNBJyRp/NqPCikKHId?=
 =?us-ascii?Q?rLbCSgTwf2wvwvWUQ0HF/hPP1L/HuzajrLZA29/YVB6blw6c9c0OozRKQEN7?=
 =?us-ascii?Q?ZoKNzPecXP035IVGN28IH8eDDEeQi/56wMQtfICjsFhAli08MHohuJgB8lps?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66128209-f413-457b-bb09-08db73be11f7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:47:18.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hm9LeK2NVnfoT5ezAxV/+ThKtmroLYG3/oVxzZkqe3g/KPwiR1Vlbo08LMq8g5+uOyzpJ+29MjAVDIBaih6Vtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9925
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements the Control Point handler for the Add Source operation.

---
 Makefile.am           |   2 +-
 profiles/audio/bass.c |  26 ++-
 src/shared/bass.c     | 424 ++++++++++++++++++++++++++++++++++++++++--
 src/shared/bass.h     |  14 +-
 unit/test-bass.c      |   2 +-
 5 files changed, 450 insertions(+), 18 deletions(-)

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
index 423ab5bf7..3aec760bc 100644
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
 
@@ -539,6 +575,335 @@ static void bass_handle_remove_src_op(struct bt_bass_db *bdb,
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
+	struct sockaddr_iso_bc bc_addr;
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
+	memset(&bc_addr, 0, sizeof(bc_addr));
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
+					bc_addr.bc_bis[bc_addr.bc_num_bis] =
+								bis_idx + 1;
+					bc_addr.bc_num_bis++;
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
+	if (pa_sync != PA_SYNC_NO_SYNC && bc_addr.bc_num_bis > 0) {
+		/* If requested by client, try to synchronize to the source */
+		bacpy(&bc_addr.bc_bdaddr, &bcast_src->addr);
+		bc_addr.bc_bdaddr_type = bcast_src->addr_type;
+
+		io = bt_io_listen(connect_cb, NULL, bcast_src, NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR,
+					&bass->ldb->adapter_bdaddr,
+					BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+					BT_IO_OPT_QOS, &iso_qos,
+					BT_IO_OPT_ISO_BC_ADDR, &bc_addr,
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
@@ -551,7 +916,7 @@ struct bass_op_handler {
 	const char	*str;
 	uint8_t		op;
 	size_t		size;
-	void		(*func)(struct bt_bass_db *bdb,
+	void		(*func)(struct bt_bass *bass,
 				struct gatt_db_attribute *attrib,
 				uint8_t opcode,
 				unsigned int id,
@@ -564,6 +929,8 @@ struct bass_op_handler {
 		0, bass_handle_remote_scan_started_op),
 	BASS_OP("Remove Source", BT_BASS_REMOVE_SRC,
 		0, bass_handle_remove_src_op),
+	BASS_OP("Add Source", BT_BASS_ADD_SRC,
+		0, bass_handle_add_src_op),
 	{}
 };
 
@@ -576,6 +943,8 @@ static void bass_bcast_audio_scan_cp_write(struct gatt_db_attribute *attrib,
 	struct bt_bass_db *bdb = user_data;
 	struct bt_bass_bcast_audio_scan_cp_hdr *hdr;
 	struct bass_op_handler *handler;
+	struct bt_bass *bass = bass_get_session(att, bdb->db,
+						&bdb->adapter_bdaddr);
 	struct iovec iov = {
 		.iov_base = (void *)value,
 		.iov_len = len,
@@ -596,7 +965,7 @@ static void bass_bcast_audio_scan_cp_write(struct gatt_db_attribute *attrib,
 	/* Call the appropriate opcode handler */
 	for (handler = bass_handlers; handler && handler->str; handler++) {
 		if (handler->op == hdr->op) {
-			handler->func(bdb, attrib, opcode, id, &iov, att);
+			handler->func(bass, attrib, opcode, id, &iov, att);
 			return;
 		}
 	}
@@ -625,8 +994,10 @@ static void bass_bcast_recv_state_read(struct gatt_db_attribute *attrib,
 	uint8_t *rsp;
 	size_t rsp_len;
 	struct bt_bcast_src *bcast_src;
+	struct bt_bass *bass = bass_get_session(att, bdb->db,
+						&bdb->adapter_bdaddr);
 
-	bcast_src = queue_find(bdb->bcast_srcs,
+	bcast_src = queue_find(bass->ldb->bcast_srcs,
 					bass_src_match_attrib,
 					attrib);
 
@@ -712,6 +1083,14 @@ static void bass_bcast_src_free(void *data)
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
 
@@ -900,6 +1279,14 @@ static void foreach_bass_service(struct gatt_db_attribute *attr,
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
@@ -909,6 +1296,8 @@ bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client)
 
 	queue_push_tail(sessions, bass);
 
+	queue_foreach(bass_cbs, bass_attached, bass);
+
 	if (!client)
 		return true;
 
@@ -990,7 +1379,8 @@ bool bt_bass_set_user_data(struct bt_bass *bass, void *user_data)
 	return true;
 }
 
-static struct bt_bass_db *bass_db_new(struct gatt_db *db)
+static struct bt_bass_db *bass_db_new(struct gatt_db *db,
+				const bdaddr_t *adapter_bdaddr)
 {
 	struct bt_bass_db *bdb;
 
@@ -999,6 +1389,7 @@ static struct bt_bass_db *bass_db_new(struct gatt_db *db)
 
 	bdb = new0(struct bt_bass_db, 1);
 	bdb->db = gatt_db_ref(db);
+	bacpy(&bdb->adapter_bdaddr, adapter_bdaddr);
 	bdb->bcast_srcs = queue_new();
 
 	if (!bass_db)
@@ -1019,7 +1410,8 @@ static bool bass_db_match(const void *data, const void *match_data)
 	return (bdb->db == db);
 }
 
-static struct bt_bass_db *bass_get_db(struct gatt_db *db)
+static struct bt_bass_db *bass_get_db(struct gatt_db *db,
+				const bdaddr_t *adapter_bdaddr)
 {
 	struct bt_bass_db *bdb;
 
@@ -1027,7 +1419,7 @@ static struct bt_bass_db *bass_get_db(struct gatt_db *db)
 	if (bdb)
 		return bdb;
 
-	return bass_db_new(db);
+	return bass_db_new(db, adapter_bdaddr);
 }
 
 static struct bt_bass *bt_bass_ref(struct bt_bass *bass)
@@ -1040,7 +1432,8 @@ static struct bt_bass *bt_bass_ref(struct bt_bass *bass)
 	return bass;
 }
 
-struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb)
+struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb,
+				const bdaddr_t *adapter_bdaddr)
 {
 	struct bt_bass *bass;
 	struct bt_bass_db *db;
@@ -1048,7 +1441,7 @@ struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	if (!ldb)
 		return NULL;
 
-	db = bass_get_db(ldb);
+	db = bass_get_db(ldb, adapter_bdaddr);
 	if (!db)
 		return NULL;
 
@@ -1140,3 +1533,8 @@ bool bt_bass_unregister(unsigned int id)
 
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

