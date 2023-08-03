Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A6BC001E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Aug 2023 07:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjHCHVL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 03:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjHCHVJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 03:21:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2899E2D6A
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 00:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSfVjQGjTwDfpFJJF73kzEu8y2Vc6lyrsRugxU4Q0TYM/opdWkZ/YEQfewHyhriSwUbkXn6ryTUhCKMC12yWVL337hSvleeoPOQyEViga/twlh3D0CwAKEzliscsfPUnfRfX03eM7gp8GYWXpBiE1akIEHefDcQHnNoibQGRZO9Wg3pNlNCMf6dRUWsBH/ohP6HM+8HpRPhg5rOwCaiLIuHtGg7UOrAq9lcG2/p6H0CuMJ2Z5x2jwRr3rzQy5WdUwh2mBIdsUSgXtIYRrnRdv6UZjLsj9JmDIEndOXLc8dlakCym7qIo6xf7vGFN6FKx95KZjHO7X8R42EgIHDtf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybGHPIVxTh7xjWPFbuoY4xW7eDTO+NySTP1UetPmwRI=;
 b=QPREXZkd1yA2AyFl+6fx941irGnnoipjrGrwdhiOfmj++3w1Ph6D2CV5+pz9O8YebE/0I3YMGT76ly+iI4oUQoDox7oHYg0xa07LqgVVrSkLttDI7qQyU0lX/t7DIfuAVeTAMNtixEi0SIfrxLaSbsUPkg54CduCTY55eG5SNXeYSpwUfsxBGWcQigfiaErrCVezA/yN/vdFETIKmlt3Sr3qepWsUbxvOkNnu5wnJX05SKUCeDUzcUexyEmQAZGxSk+yL4aKSJuT6ePolcQtKogSsKvKhH8+Ox6IpZj5MDUutQ9VcY+sNgyopcNldPMwNCt4TqEpv2vcqVhr0faaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybGHPIVxTh7xjWPFbuoY4xW7eDTO+NySTP1UetPmwRI=;
 b=syeACVZ2zr6S7MxgCfEv3bwuZtSJX6PcneBjxFy6Q6pa5Kn0o6oH6k4n3ih/0KioTOuIPdnIRNJMQXipwWhoQowVVcYW20cF1qZ08EG+qa+OwoIY3IYOEW1X2lXnGqDNl0SA11fDGRawrB+J/fp+K12VW+0SNXrK4tk8AmQX01s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6991.eurprd04.prod.outlook.com (2603:10a6:803:12d::13)
 by DU0PR04MB9418.eurprd04.prod.outlook.com (2603:10a6:10:359::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 07:21:02 +0000
Received: from VI1PR04MB6991.eurprd04.prod.outlook.com
 ([fe80::4299:5db1:461:bc17]) by VI1PR04MB6991.eurprd04.prod.outlook.com
 ([fe80::4299:5db1:461:bc17%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 07:21:02 +0000
From:   Mahesh Talewad <mahesh.talewad@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, devyani.godbole@nxp.com,
        nitin.jadhav@nxp.com, mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v1 3/3] unit/test-micp: Add unit test code for testing MICP-MICS
Date:   Thu,  3 Aug 2023 10:20:11 +0300
Message-Id: <20230803072011.191449-4-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803072011.191449-1-mahesh.talewad@nxp.com>
References: <20230803072011.191449-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To VI1PR04MB6991.eurprd04.prod.outlook.com
 (2603:10a6:803:12d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6991:EE_|DU0PR04MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc39ef1-8487-451c-ec80-08db93f2313d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evl8h23So9/UIXHmtMfUtZksjRBXERGPNZXbnqXAd/A9nz+KY+K+7csUIBnmEZ9dMnajqiiTpRlBihpDKNSUHAUOOVw6881mfVMGFmOORFrNF88oZclqZfMEU7StH1UBVvPEk9bEz3T/BaA4S2ntmFSK5GNTHa6HQGTeZ1sqzw8c6d1qLZyyZNT4PS5k7JgPUhL81ASCEH8+JjrUWg5Iv8xdrvpGwCzI1MIexxMmg1SqEwII8j2vZwoq4mwVKJgiqWSRhRQjTCCZeiio2uOeEWZgeLSmjLtdV6SHiGuvcdzsInRsbKkKGtNDMCC4S+Ye0fFyS0j1bYUIjR0CJuHXabSeO56cXbfFkMCNURqvbhcDx0SFYTOyjgwa6/2Sfq0xzIqoLVuWbnajK0Nf0Qld4UiBI7qCEYfbQX/cWZUrTrcuQv+p55vsKl+tfUOzRJjtLDGTXfXH5Jenn/k8/Que3sgs1yZoBi/LmwofgrnKe146C/Dc4/2uNl9BRbxKDIqDNeSwrYFDYerOrlmPcBO0577lDzCGz2LOvTl35mOhdC4nIDGVrXyjzoK24hK9njKXZ7mVHETjPcIplE+becd1m5/bYJOnpy3DqjkNn9ysbkCxhWTcfzri+osyQjIFmszB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6991.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(36756003)(86362001)(52116002)(478600001)(38100700002)(38350700002)(2616005)(1076003)(186003)(26005)(83380400001)(6506007)(55236004)(41300700001)(8676002)(8936002)(44832011)(6512007)(6666004)(6486002)(30864003)(316002)(66476007)(66556008)(5660300002)(6916009)(4326008)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Om1tjF1Xd6X6dBMDaGYkt3yjawvh+DSjhb+qOUPo2LTleUPQ/OGnJQGz7Kr1?=
 =?us-ascii?Q?9aLAKy+VksmJYGs/Eb4sQbLcBqQehao7FuzlM1CbkCTfP2so/KwWCh2u5iO8?=
 =?us-ascii?Q?or/MejQvoMPHf6k3Fe9AHKc8yY2VL0i6zJowfQP3RGadqnSQqkbbSl7hnc4o?=
 =?us-ascii?Q?bWonLusQTs0UbuQ9VnWGk3kQyJktfYPLy3pwFyRD9nZaVN1TqAeUwrIi7710?=
 =?us-ascii?Q?wV6R/eFGgVrA0DWaVKFK1HFiYFei5UDH8NoSh5JqW5UZouy3QtROMR9glatJ?=
 =?us-ascii?Q?1hMctc/J2dMhz30d53pqlMzLc1af/rwLSbePXikdnX99XS4US4spV4zkxyLN?=
 =?us-ascii?Q?ghJbB16EUTcPkutXHjrixxExyRHqlaya+JWpJtxtQgeJY6fiuPQY087R4MU1?=
 =?us-ascii?Q?JLSSxX8JVsnkgzpwS5+4TD0ZOuyNCAznxt6gyu+dIpIRMVFEpfr/Fc4WOxk1?=
 =?us-ascii?Q?CU1jKLa1E1E6AeO5r2ScQR7dk8pmMKrAKO8oRKOha18ZYC2Ds1gQ05V1Pr8z?=
 =?us-ascii?Q?UZ0eHdJ0WGKH1EQ/c/VyR0Qr+wfo2JIePkFSvR5fmKRKVesXX+rQVOgbDWMB?=
 =?us-ascii?Q?ZqGD6XSV3u/yFNEKQmvvJsK4UGhetsxHKI/r1ysQh05UnvDOiy4uejKfUG2+?=
 =?us-ascii?Q?yZwTpiDAhWftUmx3ceyBdHYXw9SAEE2MGAy2GFRyeKEUSoFRcru/5/MimM13?=
 =?us-ascii?Q?Rv3kV3wsOyOlTPFIfN4Pf99x0JdrnIZiGGXg5Ns9JrCtNM0pdxV2wl53kDU+?=
 =?us-ascii?Q?7ZUEYJQT198EWDYDTm8yXCLrnriB/Ww/qIgO0l5/2om7pVlLlXk1YVP9CRxG?=
 =?us-ascii?Q?nXZMU0xejYX+VEMcY4kNKW0X4d50oleg6q9+qb95UPq5VGe2u+tFWHv6peFO?=
 =?us-ascii?Q?k+S84OS+6CPALx2slt4j/QQJPcJNa1JKHYd44yeNDclnDRU+SwJ9oz0XWH3b?=
 =?us-ascii?Q?0PdfAu/l3+h0ly40V0AXpEY41AnEPdBXWbFkckUpj0hF5epvF81oL2DoCttm?=
 =?us-ascii?Q?vAq+BHfpBYqje4udFv1BhRKmiY3GqmZtW+v7lszYuy5L2KcNqmoOkuOCjxLF?=
 =?us-ascii?Q?uq66xq6jly4c5YwXu6S5/0P5K3/swWe43uJrkK7hqRe+p2TY36BYzmqqL/iQ?=
 =?us-ascii?Q?ZOPjetaQ4sfvW1mQXO+q+u5IK1b+jDf02t/yllE00h0/kc7sbfDgNpEETQd3?=
 =?us-ascii?Q?HdwsgMbdFJjVTQK6GIs6lUAE/Tv94XOTnovCCwj4rT5BK1Ppx0y9v2zfx0pO?=
 =?us-ascii?Q?SbnVg0H/s4+VeiQQiSWHAGx3MXRQWzlTruLtC6mnzKegMjMBVRreTq3qh0h7?=
 =?us-ascii?Q?omcCOP5Ekc4qN4Ky0oKOJwQC8vXSphsQtRzbjGqjHkAbYuGxtx3H3Ja5fPtw?=
 =?us-ascii?Q?yxO7amlGkp/UWR1thhcvmruITu5canogl+lw/A5SUmg4pmHiFRJc4FScR8fX?=
 =?us-ascii?Q?V1T3v+tFKlpjxqpM2aq+pxyUpu7vbiVr12AgcGir+NkcHQwbyHkikLea2YFa?=
 =?us-ascii?Q?9yGDyEaqroC8OCdYR0KvRTn8jx9kmhdjG8j9gMeflToClzdzYS43ZOzeCPZr?=
 =?us-ascii?Q?MeF9owE5Xbl7xMZx8kNPaH2TMXc76/xIhQYMufob?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc39ef1-8487-451c-ec80-08db93f2313d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6991.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 07:21:02.2513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsZ2l6tOvTaQC1GGeMcb5H9B3DMKCF1Kz64BF62JbQwVsmrFGeCkQZ2x7wy9BUa3dasvTe8GFHCiW2M74dmSmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9418
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

-Implemented UNIT Testcases for MICS[test-micp.c] and MICP[test-mics.c].
---
 Makefile.am       |  13 ++
 src/shared/micp.c |  26 ++++
 src/shared/micp.h |   2 +
 unit/test-micp.c  | 357 ++++++++++++++++++++++++++++++++++++++++++++++
 unit/test-mics.c  | 290 +++++++++++++++++++++++++++++++++++++
 5 files changed, 688 insertions(+)
 create mode 100644 unit/test-micp.c
 create mode 100644 unit/test-mics.c

diff --git a/Makefile.am b/Makefile.am
index 6f40f2a74..cde55bebf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -573,6 +573,19 @@ unit_test_gattrib_LDADD = src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -ldl -lrt
 
+unit_tests += unit/test-micp
+
+unit_test_micp_SOURCES = unit/test-micp.c
+
+unit_test_micp_LDADD = src/libshared-glib.la \
+			lib/libbluetooth-internal.la $(GLIB_LIBS)
+
+unit_tests += unit/test-mics
+
+unit_test_mics_SOURCES = unit/test-mics.c
+unit_test_mics_LDADD = src/libshared-glib.la \
+				lib/libbluetooth-internal.la $(GLIB_LIBS)
+
 unit_tests += unit/test-bap
 
 unit_test_bap_SOURCES = unit/test-bap.c
diff --git a/src/shared/micp.c b/src/shared/micp.c
index c5b814d98..bb71999be 100644
--- a/src/shared/micp.c
+++ b/src/shared/micp.c
@@ -1042,3 +1042,29 @@ void micp_char_write_value(uint16_t handle)
 
 }
 #endif /*MICP_MICS_PTS_FLAG*/
+
+static void micp_write_cb1(bool success, uint8_t att_ecode, void *user_data)
+{
+	if (success)
+		printf("MICP Write successful\n");
+	else
+		printf("\nWrite failed: 0x%02x\n", att_ecode);
+}
+
+void micp_write_value(struct bt_micp *micp, void *user_data)
+{
+	struct bt_mics *mics = micp_get_mics(micp);
+	uint16_t	value_handle;
+	int ret;
+	const uint16_t value = 0x0001;
+
+	gatt_db_attribute_get_char_data(mics->ms, NULL, &value_handle,
+							NULL, NULL, NULL);
+
+	printf("%s handle: %x\n", __func__, value_handle);
+	ret = bt_gatt_client_write_value(micp->client, value_handle,
+		(void *)&value, sizeof(value), micp_write_cb1, NULL, NULL);
+	if (!ret)
+		printf("bt_gatt_client_write_value() : Write FAILED");
+
+}
diff --git a/src/shared/micp.h b/src/shared/micp.h
index 4a9807ed4..f20d46c9c 100644
--- a/src/shared/micp.h
+++ b/src/shared/micp.h
@@ -52,3 +52,5 @@ void micp_discover_mute_char(void);
 void mics_mute_char_read(uint16_t handle);
 void micp_char_write_value(uint16_t handle);
 #endif /*MICP_MICS_PTS_FLAG*/
+
+void micp_write_value(struct bt_micp *micp, void *user_data);
diff --git a/unit/test-micp.c b/unit/test-micp.c
new file mode 100644
index 000000000..3db32a4f7
--- /dev/null
+++ b/unit/test-micp.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2023  NXP Semiconductors. All rights reserved.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <fcntl.h>
+
+
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+#include "src/shared/util.h"
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/micp.h"
+
+struct test_data {
+	struct gatt_db *db;
+	struct bt_micp *micp;
+	struct bt_gatt_server *server;
+	struct bt_gatt_client *client;
+	struct queue *ccc_states;
+	size_t iovcnt;
+	struct iovec *iov;
+	struct test_config *cfg;
+};
+
+struct ccc_state {
+	uint16_t handle;
+	uint16_t value;
+};
+
+struct notify {
+	uint16_t handle, ccc_handle;
+	uint8_t *value;
+	uint16_t len;
+	bt_gatt_server_conf_func_t conf;
+	void *user_data;
+};
+
+#define iov_data(args...) ((const struct iovec[]) { args })
+
+#define define_test(name, function, _cfg, args...)		\
+	do {							\
+		const struct iovec iov[] = { args };		\
+		static struct test_data data;			\
+		data.cfg = _cfg;				\
+		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		tester_add(name, &data, NULL, function,	\
+				test_teardown);			\
+	} while (0)
+
+static void print_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	if (tester_use_debug())
+		tester_debug("%s%s", prefix, str);
+}
+
+static void test_teardown(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+
+	bt_micp_unref(data->micp);
+	bt_gatt_server_unref(data->server);
+	util_iov_free(data->iov, data->iovcnt);
+	gatt_db_unref(data->db);
+
+	queue_destroy(data->ccc_states, free);
+
+	tester_teardown_complete();
+}
+
+static void test_complete_cb(const void *user_data)
+{
+	tester_test_passed();
+}
+
+static bool ccc_state_match(const void *a, const void *b)
+{
+	const struct ccc_state *ccc = a;
+	uint16_t handle = PTR_TO_UINT(b);
+
+	return ccc->handle == handle;
+}
+
+static struct ccc_state *find_ccc_state(struct test_data *data,
+				uint16_t handle)
+{
+	return queue_find(data->ccc_states, ccc_state_match,
+				UINT_TO_PTR(handle));
+}
+
+static struct ccc_state *get_ccc_state(struct test_data *data, uint16_t handle)
+{
+	struct ccc_state *ccc;
+
+	ccc = find_ccc_state(data, handle);
+	if (ccc)
+		return ccc;
+
+	ccc = new0(struct ccc_state, 1);
+	ccc->handle = handle;
+	queue_push_tail(data->ccc_states, ccc);
+
+	return ccc;
+}
+
+static void gatt_notify_cb(struct gatt_db_attribute *attrib,
+					struct gatt_db_attribute *ccc,
+					const uint8_t *value, size_t len,
+					struct bt_att *att, void *user_data)
+{
+	struct test_data *data = user_data;
+	struct notify notify;
+
+	memset(&notify, 0, sizeof(notify));
+
+	notify.handle = gatt_db_attribute_get_handle(attrib);
+	notify.ccc_handle = gatt_db_attribute_get_handle(ccc);
+	notify.value = (void *) value;
+	notify.len = len;
+
+	printf("%s: notify.value:%d notify->len:%d\n", __func__,
+		(int)*(notify.value), notify.len);
+	if (!bt_gatt_server_send_notification(data->server,
+			notify.handle, notify.value,
+			notify.len, false))
+		printf("%s: Failed to send notification\n", __func__);
+}
+
+static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	struct ccc_state *ccc;
+	uint16_t handle;
+	uint8_t ecode = 0;
+	const uint8_t *value = NULL;
+	size_t len = 0;
+
+	handle = gatt_db_attribute_get_handle(attrib);
+
+	ccc = get_ccc_state(data, handle);
+	if (!ccc) {
+		ecode = BT_ATT_ERROR_UNLIKELY;
+		goto done;
+	}
+
+	len = sizeof(ccc->value);
+	value = (void *) &ccc->value;
+
+done:
+	gatt_db_attribute_read_result(attrib, id, ecode, value, len);
+}
+
+static void test_server(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct bt_att *att;
+	struct io *io;
+
+	io = tester_setup_io(data->iov, data->iovcnt);
+	g_assert(io);
+
+	tester_io_set_complete_func(test_complete_cb);
+
+	att = bt_att_new(io_get_fd(io), false);
+	g_assert(att);
+
+	bt_att_set_debug(att, BT_ATT_DEBUG, print_debug, "bt_att:", NULL);
+
+	data->db = gatt_db_new();
+	g_assert(data->db);
+
+	gatt_db_ccc_register(data->db, gatt_ccc_read_cb, NULL,
+					gatt_notify_cb, data);
+
+	data->micp = bt_micp_new(data->db, NULL);
+	g_assert(data->micp);
+
+	data->server = bt_gatt_server_new(data->db, att, 64, 0);
+	g_assert(data->server);
+
+	bt_gatt_server_set_debug(data->server, print_debug, "bt_gatt_server:",
+					NULL);
+
+	data->ccc_states = queue_new();
+
+	tester_io_send();
+
+	bt_att_unref(att);
+}
+
+#define EXCHANGE_MTU	IOV_DATA(0x02, 0x40, 0x00), \
+						IOV_DATA(0x03, 0x40, 0x00)
+
+#define	MICS_MUTE_WRITE_VAL_00 \
+			IOV_DATA(0x12, 0x03, 0x00, 0x00), \
+			IOV_DATA(0x13)
+
+#define	MICS_MUTE_WRITE_VAL_01 \
+			IOV_DATA(0x12, 0x03, 0x00, 0x01), \
+			IOV_DATA(0x13)
+
+#define	MICS_MUTE_READ \
+			IOV_DATA(0x0a, 0x03, 0x00), \
+			IOV_DATA(0x0b, 0x01)
+
+#define DISCOVER_PRIM_SERV_NOTIF \
+		IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28), \
+		IOV_DATA(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x4d, 0x18), \
+		IOV_DATA(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28), \
+		IOV_DATA(0x01, 0x10, 0x05, 0x00, 0x0a)
+
+/* ATT: Read By Type Request (0x08) len 6
+ *   Handle range: 0x0001-0x0009
+ *   Attribute type: Characteristic (0x2803)
+ * ATT: Read By Type Response (0x09) len 22
+ * Attribute data length: 7
+ *   Handle: 0x0002
+ *   Value: 1a0300c82b
+ *   Properties: 0x1a
+ *   Value Handle: 0x0003
+ *   Value UUID: Mute (0x2bc3)
+ */
+#define DISC_MICS_CHAR_1 \
+	IOV_DATA(0x08, 0x01, 0x00, 0x05, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x09, 0x07, \
+		0x02, 0x00, 0x1a, 0x03, 0x00, 0xc3, 0x2b), \
+	IOV_DATA(0x08, 0x05, 0x00, 0x05, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x01, 0x08, 0x05, 0x00, 0x0a)
+
+
+#define MICS_FIND_BY_TYPE_VALUE \
+	IOV_DATA(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0x4d, 0x18), \
+	IOV_DATA(0x07, 0x01, 0x00, 0x04, 0x00), \
+	IOV_DATA(0x06, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28, 0x4d, 0x18), \
+	IOV_DATA(0x01, 0x06, 0x05, 0x00, 0x0a)
+
+#define DISC_MICS_CHAR_AFTER_TYPE \
+	IOV_DATA(0x08, 0x01, 0x00, 0x05, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x09, 0x07, \
+		0x02, 0x00, 0x1a, 0x03, 0x00, 0xc3, 0x2b), \
+	IOV_DATA(0x08, 0x03, 0x00, 0x05, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x01, 0x08, 0x03, 0x00, 0x0a)
+
+#define MICS_WRITE_CCD \
+	IOV_DATA(0x12, 0x04, 0x00, 0x00, 0x00), \
+	IOV_DATA(0x13), \
+	IOV_DATA(0x12, 0x04, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x13)
+
+#define MICS_FIND_INFO \
+	IOV_DATA(0x04, 0x04, 0x00, 0x05, 0x00), \
+	IOV_DATA(0x05, 0x01, 0x04, 0x00, 0x02, 0x29), \
+	IOV_DATA(0x04, 0x05, 0x00, 0x05, 0x00), \
+	IOV_DATA(0x01, 0x04, 0x05, 0x00, 0x0a)
+
+#define MICS_SR_SPN_BV_01_C \
+			EXCHANGE_MTU, \
+			DISCOVER_PRIM_SERV_NOTIF, \
+			DISC_MICS_CHAR_1, \
+			MICS_FIND_BY_TYPE_VALUE, \
+			DISC_MICS_CHAR_AFTER_TYPE, \
+			MICS_FIND_INFO, \
+			MICS_WRITE_CCD, \
+			IOV_DATA(0x0a, 0x03, 0x00), \
+			IOV_DATA(0x0b, 0x01), \
+			MICS_MUTE_WRITE_VAL_00, \
+			IOV_DATA(0x1b, 0x03, 0x00, 0x00), \
+			MICS_MUTE_WRITE_VAL_01, \
+			IOV_DATA(0x1b, 0x03, 0x00, 0x01), \
+			IOV_DATA(0x0a, 0x03, 0x00), \
+			IOV_DATA(0x0b, 0x01)
+
+#define MICS_SR_SGGIT_SER_BV_01_C \
+						EXCHANGE_MTU, \
+						DISCOVER_PRIM_SERV_NOTIF, \
+						MICS_FIND_BY_TYPE_VALUE
+
+#define MICS_SR_SGGIT_CHA_BV_01_C \
+						EXCHANGE_MTU, \
+						DISCOVER_PRIM_SERV_NOTIF, \
+						MICS_FIND_BY_TYPE_VALUE, \
+						DISC_MICS_CHAR_AFTER_TYPE
+
+#define MICS_WRITE_MUTE_CHAR_INVALID \
+			IOV_DATA(0x12, 0x03, 0x00, 0x02), \
+			IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x13), \
+			IOV_DATA(0x12, 0x03, 0x00, 0x05), \
+			IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x13)
+
+#define MICS_SR_SPE_BI_1_C	\
+						EXCHANGE_MTU, \
+						DISCOVER_PRIM_SERV_NOTIF, \
+						MICS_FIND_BY_TYPE_VALUE, \
+						MICS_WRITE_MUTE_CHAR_INVALID
+
+#define	MICS_MUTE_READ_INVALID \
+			IOV_DATA(0x0a, 0x03, 0x00), \
+			IOV_DATA(0x0b, 0x02)
+
+#define	MICS_MUTE_WRITE_1 \
+			IOV_DATA(0x12, 0x03, 0x00, 0x01), \
+			IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x80)
+
+#define	MICS_MUTE_WRITE_0 \
+			IOV_DATA(0x12, 0x03, 0x00, 0x00), \
+			IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x80)
+
+#define MICS_SR_SPE_BI_02_C	\
+						EXCHANGE_MTU, \
+						DISCOVER_PRIM_SERV_NOTIF, \
+						MICS_FIND_BY_TYPE_VALUE, \
+						MICS_MUTE_READ_INVALID, \
+						MICS_MUTE_WRITE_0, \
+						MICS_MUTE_WRITE_1
+
+int main(int argc, char *argv[])
+{
+
+	tester_init(&argc, &argv);
+
+	define_test("MICS/SR/SGGIT/SER/BV-01-C", test_server, NULL,
+					MICS_SR_SGGIT_SER_BV_01_C);
+	define_test("MICS/SR/SGGIT/CHA/BV-01-C", test_server, NULL,
+					MICS_SR_SGGIT_CHA_BV_01_C);
+	define_test("MICS/SR/SPE/BI-01-C", test_server, NULL,
+					MICS_SR_SPE_BI_1_C);
+	define_test("MICS/SR/SPE/BI-02-C", test_server, NULL,
+					MICS_SR_SPE_BI_02_C);
+	define_test("MICS/SR/SPN/BV-01-C", test_server, NULL,
+					MICS_SR_SPN_BV_01_C);
+
+	return tester_run();
+}
diff --git a/unit/test-mics.c b/unit/test-mics.c
new file mode 100644
index 000000000..fe84fb02d
--- /dev/null
+++ b/unit/test-mics.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2023  NXP Semiconductors. All rights reserved.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <fcntl.h>
+
+
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+#include "btio/btio.h"
+#include "src/shared/util.h"
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-helpers.h"
+#include "src/shared/micp.h"
+
+struct test_data {
+	struct gatt_db *db;
+	struct bt_micp *micp;
+	struct bt_gatt_client *client;
+	size_t iovcnt;
+	struct iovec *iov;
+	struct test_config *cfg;
+};
+
+struct db_attribute_micp_test_data {
+	struct gatt_db_attribute *match;
+	bool found;
+};
+
+#define MICP_GATT_CLIENT_MTU	64
+#define iov_data(args...) ((const struct iovec[]) { args })
+
+#define define_test(name, function, _cfg, args...)		\
+	do {							\
+		const struct iovec iov[] = { args };		\
+		static struct test_data data;			\
+		data.cfg = _cfg;				\
+		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		tester_add(name, &data, test_setup, function,	\
+				test_teardown);			\
+	} while (0)
+
+static void print_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	if (tester_use_debug())
+		tester_debug("%s %s", prefix, str);
+}
+
+static void test_teardown(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+
+	bt_gatt_client_unref(data->client);
+	util_iov_free(data->iov, data->iovcnt);
+	gatt_db_unref(data->db);
+
+	tester_teardown_complete();
+}
+
+static void test_complete_cb(const void *user_data)
+{
+	tester_test_passed();
+}
+
+static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
+{
+
+	if (!success)
+		tester_setup_failed();
+	else
+		tester_setup_complete();
+}
+
+static void micp_ready(struct bt_micp *micp, void *user_data)
+{
+	micp_write_value(micp, user_data);
+}
+
+static void test_client(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct io *io;
+
+	io = tester_setup_io(data->iov, data->iovcnt);
+	g_assert(io);
+
+	tester_io_set_complete_func(test_complete_cb);
+
+	data->db = gatt_db_new();
+	g_assert(data->db);
+
+	data->micp = bt_micp_new(data->db, bt_gatt_client_get_db(data->client));
+	g_assert(data->micp);
+
+	bt_micp_set_debug(data->micp, print_debug, "bt_mip: ", NULL);
+
+	bt_micp_ready_register(data->micp, micp_ready, data, NULL);
+
+	bt_micp_attach(data->micp, data->client);
+}
+
+	/* ATT: Exchange MTU Response (0x03) len 2
+	 *   Server RX MTU: 64
+	 */
+	/* ATT: Exchange MTU Request (0x02) len 2
+	 *    Client RX MTU: 64
+	 */
+#define ATT_EXCHANGE_MTU	IOV_DATA(0x02, 0x40, 0x00), \
+			IOV_DATA(0x03, 0x40, 0x00)
+
+/*
+ *      ATT: Read By Type Request (0x08) len 6
+ *        Handle range: 0x0001-0xffff
+ *        Attribute type: Server Supported Features (0x2b3a)
+ */
+#define MICP_READ_SR_FEATURE	IOV_DATA(0x08, 0x01, 0x00, 0Xff, 0xff, \
+			0x3a, 0x2b), \
+			IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a)
+
+	/*
+	 * ATT: Read By Group Type Request (0x10) len 6
+	 *   Handle range: 0x0001-0xffff
+	 *   Attribute group type: Primary Service (0x2800)
+	 */
+
+/*
+ *     ATT: Read By Group Type Response (0x11) len 7
+ *        Attribute data length: 6
+ *        Attribute group list: 1 entry
+ *        Handle range: 0x00a0-0x00a4
+ *        UUID: Microphone Control (0x184d)
+ */
+#define MICP_READ_GROUP_TYPE	\
+			IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28), \
+			IOV_DATA(0x11, 0x06, \
+				0x01, 0x00, 0x04, 0x00, 0x4d, 0x18), \
+			IOV_DATA(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28), \
+			IOV_DATA(0x01, 0x10, 0x06, 0x00, 0x0a)
+
+	/* ATT: Read By Group Type Request (0x10) len 6
+	 *   Handle range: 0x0001-0xffff
+	 *   Attribute group type: Secondary Service (0x2801)
+	 */
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Group Type Request (0x10)
+	 *   Handle: 0x0001
+	 *   Error: Attribute Not Found (0x0a)08 01 00 05 00 02 28
+	 */
+#define MICP_READ_REQ_SECOND_SERVICE	\
+			IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28), \
+			IOV_DATA(0x01, 0x10, 0x01, 0x00, 0x0a)
+
+#define MICP_READ_REQ_INCLUDE_SERVICE	\
+			IOV_DATA(0x08, 0x01, 0x00, 0x04, 0x00, 0x02, 0x28), \
+			IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a)
+
+	/* ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0001-0x0004
+	 *   Attribute type: Characteristic (0x2803)
+	 */
+
+/*      ATT: Find Information Request (0x04) len 4
+ *        Handle range: 0x0004-0x0004
+ */
+#define	MICP_FIND_INFO_REQ	\
+			IOV_DATA(0x04, 0x04, 0x00, 0x04, 0x00), \
+			IOV_DATA(0x05, 0x01, 0x04, 0x00, 0x02, 0x29)
+
+/*
+ *      ATT: Read By Type Request (0x08) len 6
+ *        Handle range: 0x0001-0x0004
+ *        Attribute type: Characteristic (0x2803)
+ */
+#define	MICP_READ_REQ_CHAR	\
+			IOV_DATA(0x08, 0x01, 0x00, 0x04, 0x00, 0x03, 0x28),\
+			IOV_DATA(0x09, 0x07, \
+			0x02, 0x00, 0x1a, 0x03, 0x00, 0xc3, 0x2b), \
+			IOV_DATA(0x08, 0x03, 0x00, 0x04, 0x00, 0x03, 0x28), \
+			IOV_DATA(0x01, 0x08, 0x04, 0x00, 0x0a)
+
+#define	MICS_MUTE_READ \
+			IOV_DATA(0x0a, 0x03, 0x00), \
+			IOV_DATA(0x0b, 0x01)
+
+#define	MICS_EN_MUTE_DISCPTR	\
+			IOV_DATA(0x12, 0x04, 0x00, 0x01, 0x00), \
+			IOV_DATA(0x13)
+
+#define	MICS_MUTE_WRITE	\
+			IOV_DATA(0x12, 0x03, 0x00, 0x01),\
+			IOV_DATA(0x13)
+
+#define MICP_CL_CGGIT_SER_BV_01_C \
+			MICS_MUTE_READ, \
+			MICS_EN_MUTE_DISCPTR, \
+			IOV_DATA(0x12, 0x03, 0x00, 0x01, 0x00), \
+			IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x013)
+
+#define	MICP_CL_CGGIT_CHA_BV_01_C	\
+			MICS_MUTE_READ, \
+			MICS_EN_MUTE_DISCPTR, \
+			IOV_DATA(0x12, 0x03, 0x00, 0x06, 0x00), \
+			IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x013), \
+			MICS_MUTE_READ
+
+#define MICP_CL_SPE_BI_01_C	\
+			MICS_MUTE_READ, \
+			MICS_EN_MUTE_DISCPTR, \
+			IOV_DATA(0x12, 0x03, 0x00, 0x01, 0x00), \
+			IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x80)
+
+/* GATT Discover All procedure */
+static const struct iovec setup_data[] = {
+				ATT_EXCHANGE_MTU,
+				MICP_READ_SR_FEATURE,
+				MICP_READ_GROUP_TYPE,
+				MICP_READ_REQ_SECOND_SERVICE,
+				MICP_READ_REQ_INCLUDE_SERVICE,
+				MICP_READ_REQ_CHAR,
+				MICP_FIND_INFO_REQ
+};
+
+static void test_setup(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct bt_att *att;
+	struct gatt_db *db;
+	struct io *io;
+
+	io = tester_setup_io(setup_data, ARRAY_SIZE(setup_data));
+	g_assert(io);
+
+	att = bt_att_new(io_get_fd(io), false);
+	g_assert(att);
+
+	bt_att_set_debug(att, BT_ATT_DEBUG, print_debug, "bt_att:", NULL);
+
+	db = gatt_db_new();
+	g_assert(db);
+
+
+	data->client = bt_gatt_client_new(db, att, MICP_GATT_CLIENT_MTU, 0);
+	g_assert(data->client);
+
+	bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_client:",
+						NULL);
+
+	bt_gatt_client_ready_register(data->client, client_ready_cb, data,
+						NULL);
+
+	bt_att_unref(att);
+	gatt_db_unref(db);
+}
+
+
+int main(int argc, char *argv[])
+{
+
+	tester_init(&argc, &argv);
+
+	define_test("MICP/CL/CGGIT/SER/BV-01-C", test_client, NULL,
+					MICS_MUTE_READ);
+	define_test("MICP/CL/CGGIT/CHA/BV-01-C", test_client, NULL,
+					MICP_CL_CGGIT_SER_BV_01_C);
+	define_test("MICP/CL/SPE/BI-01-C", test_client, NULL,
+					MICP_CL_SPE_BI_01_C);
+
+	return tester_run();
+}
-- 
2.34.1

