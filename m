Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73BFE75451
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 16:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbjJEQeM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 12:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjJEQcn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 12:32:43 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379D5261A6
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 05:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5byRVOGjbeRrqGTd1QWOzErnR2hm/kDFcCMHiDCP8QyAqlF6v/YOH1/DXHilHZ2ZMiMSjabfsh6ejE7OmbWQOnqobF7aN64dkaf+j6v4kaBOeGW56/nytyImxi4008C+3RWUjou2WQmGM0aqmp94iwWcvhPKBqYryHmhwXZIfvXlKppPb1VDmYP2IiqZi8mJ2wdHZvIemgvihgY1ti4kILJHzNRiHXsLWxlXtbU1PHbrLRcFZYoh3pqqZuDZ3TFjqVQfxVWDZABM+e54wO9yH7DHbIJmo3ktcxYkffW31uWk06KAufZV6nACzb6IHsyb3UZzJy4LgcBFjJveBwv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsIxZdhXj0SoDed03rKl2vhKRi6xkFgFfka8U53Q0Yc=;
 b=UEeZSy1/wglqfY+HP6v0TbAbUdNGYLnAiBkBLC6B47miz1aO73zS0o/2kQ1/001zvg/Fo9i4Nke1jkIpgnMoXhMqfZ07x8WwdgW5i/V8LZ2s9k9kC1xk4IxlkoIrhm+HellCGGjaLElb+y6BsuWkz9fDasetLPrWg5a/OIBm8CdcgyiSQVTVQ+Jr7MbcQbxVTHFR/obhfVCYAaCJPCWA4RsyLb1kxY7VSk/uKNme7UIDPSE+fXEznE801nfk3rQYu2gR9i2SwZh28fms8RVRQlG6EJPvubMCksGJjF/eRAOHHTSsxqlbUugwWcSvevGwYGNbJa1cwIwOvfhJqsAkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsIxZdhXj0SoDed03rKl2vhKRi6xkFgFfka8U53Q0Yc=;
 b=dC8LPn0oM8ZTHcmFB40qKqX6QOk9LdBZ9JnoIK5r1JBwoYwiuheQ0ZalnCUSseE6XE8KQ5GjVCVgXyoCOGKns0Foqek25U3PT7RWjhHw0KXGLCRtiy/7rejg+T7XP/F4Y0SSjqGzGx01WsDHDqWrIIDimHTcjg6EXjXOKC9QmWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 12:16:14 +0000
Received: from AS1PR04MB9654.eurprd04.prod.outlook.com
 ([fe80::74d9:fef3:348a:ef3b]) by AS1PR04MB9654.eurprd04.prod.outlook.com
 ([fe80::74d9:fef3:348a:ef3b%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 12:16:14 +0000
From:   Mahesh Talewad <mahesh.talewad@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, devyani.godbole@nxp.com,
        nitin.jadhav@nxp.com, mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v4 1/2] unit/test-micp.c : MICP-MICS unit test case implementation
Date:   Thu,  5 Oct 2023 15:15:43 +0300
Message-Id: <20231005121544.306495-2-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005121544.306495-1-mahesh.talewad@nxp.com>
References: <20231005121544.306495-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0017.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::11) To AS1PR04MB9654.eurprd04.prod.outlook.com
 (2603:10a6:20b:476::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9654:EE_|PAXPR04MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 0769c345-a58f-48ff-8a6d-08dbc59cde8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zw4HMWj/GiQTqR7Zj3gL9jM4k2Vy1lbYWg6ErwqRXf5Rt7WHY6t5YUeLWRmNXiLt3ENV6kRKEM0EORogqPUP+7+MEljKP48/L/XcuVdrn1Guk7gHe2sKz7z6M/jhGfvvtYVf+ySWGoJdnpkNqzzk3bgVJy0ytCffJpydLF9GYc2UQRYgM5wxbavlWbf9VAF4uq0Lx42qYFHjnzn8w89kzkV4aQ746BF/HR7OQ+rSdgeW6elPaPxsgYIOLAkqSHa/k0ZdqY5QCACIPURiR1qiTxtOBOIHYov8YNdcLxPd6/yl1KPw6lirdasyLmUjdzOUpGkBtudosmeg/c0kyxa5I3PvTly1O0SwuXK3AAGYduhVJJW9y9R5lAyFieHzhFUbzDe0opYWhp84U09ZwqLU6CFffdRDYh6FBORF5J20N8E/DXAKnmEg3OVzjTA6WS0auA+f5ibgqLwjQlB6p6SDnE89iEdPYM+zyuTl/xgaMrEICoA8GimqHGnlt1gE33bHfdaUQe8dRd/sGAa939w16ODKi0B/3ZnhEkIeum8avtt8hvdcOMqJ/ApqhARZf8tiWpv81Z43O8GkO26FOBi1FCl8iB72Fmh3PVupjWmdE0Q2B6888gdlBB0dNPANe94r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9654.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6666004)(6506007)(52116002)(55236004)(2616005)(478600001)(6486002)(83380400001)(26005)(1076003)(6512007)(30864003)(2906002)(41300700001)(66946007)(6916009)(44832011)(5660300002)(66556008)(8676002)(316002)(8936002)(4326008)(36756003)(86362001)(38100700002)(38350700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AwVU+72tFV/FtMyZa+U4AeggmrwyXv51CgslGnLfuxdRmMwJE/1ESoxIrOoK?=
 =?us-ascii?Q?3HuAffq4fMf8ZkBEXdadTYqU/AbEWUcC2maFUnBrAOtYVCuOv8LJ2VeGxaXz?=
 =?us-ascii?Q?rHmfclK0zMWENoCnuqCy7elt4BR4d3ByC0iZBCzhmjvc6ttZT6l9K6ppRGBR?=
 =?us-ascii?Q?Bx8CFKRX6aUhrZ+gadxxgoitHgBqqcNW24Yh99/pcKnqCH9wSOmus/kgLa9D?=
 =?us-ascii?Q?H1npfkbSLiQXvONvnXErNj3DZpRuGh3N9dKsKHWX6AvIHgtORW1Mg/iLZIPK?=
 =?us-ascii?Q?Mze0JzJrMlnng998HQcfQVJp/0oNVT8jlXZpJcnG7sxSnVbctCxkCzwcvwtq?=
 =?us-ascii?Q?gphtwQJd4JqqmzBKAb3rAelBbkw6ib9z3MNa1EJosHpxIt7lcTf8+bGR7vlz?=
 =?us-ascii?Q?9Cpesc1DIOlbKvOawEKjUu3dVS+iIS3mrolDs3P4lLema3RRr/cjlRJEKwsx?=
 =?us-ascii?Q?Okpqo6yMlBto6EODyFB2u06jVFt8JzYqFde0WuNq4JmMsLlg3HZbNOMVrWz+?=
 =?us-ascii?Q?vca6N7tRRKpccl1mpr6hEYZApQzOHIFDi5wmn7BXjaInRZXVdpuOfleAq3d8?=
 =?us-ascii?Q?/9B0Flaj2nBNQCp/eA8lbHDFtW6adYoAXNKzPlyXssWZHgG1W6pvCyWXezZS?=
 =?us-ascii?Q?T4h6I0fNggfXtAf4iEXEIzeEb7XvDg3wvoOXZkUzSeuQV3zmn1Qx/uw7+d5t?=
 =?us-ascii?Q?fPRK+kPd8FOTADx3s+hEJ0vWuHZVPm8dgqgd3cX/jBe2JGJ0IirTA1Mm0Dvv?=
 =?us-ascii?Q?gfg9sugYvTNZpgBLwZpRfPA+N8lx7usspbagbBnRFJDzC9tnZBVGkqW+J+Ba?=
 =?us-ascii?Q?hwH0yWhj7hMPbk21GrLUqmTfy40lQTVswRRprxkt5Tmu/XMRYmKphKa4xugY?=
 =?us-ascii?Q?j+5j/D6gE2LRx9hqA43aRuDu1QIdfeIErbGim7B44aTBQmyV3HMaAnZ8BOvw?=
 =?us-ascii?Q?lY1RmXFs1Q5Kl7qnz52m1n+DaVUNmDkTYeSMu98xE0t0NYeaucA7UE4NkycB?=
 =?us-ascii?Q?NleTJvGcy/jq7qzHAF9TLFL6vT+WjWYLCwip2TzVKPqxhRyRrRCLZpbm2o1x?=
 =?us-ascii?Q?WIWuMM8nhNNBVtDB4mwb2zRcLSILqIAVEvrZ+/SPUaTEewKRRXryt7TFegTP?=
 =?us-ascii?Q?bTmeDNbiEDI3F29W0ZV4fV9U8AvIw1TCDOjoIhjg5jm7sRheCXkTd0lk24mx?=
 =?us-ascii?Q?uJuDZ+Xv4b9Lw82EVmnNB97L9518XwY/0yrDQ+plpSXJ4TyLyGMBckjqraME?=
 =?us-ascii?Q?4UtQQS8YqdaRZKmFK1Zyx85uvkIpnVfcYWElEUmPQKz71NTYANM854tvsgB1?=
 =?us-ascii?Q?bkTvknWk90n/x5rCjUFVfB2diZvEe+wOknWsa24SdTNvg9IUItUU0adWOJbn?=
 =?us-ascii?Q?J/z7SSIHkd5eeKCLFukBdqLdJmJ25R4IumXqVW1cShOjQQHsfnChnhzv5dNm?=
 =?us-ascii?Q?1h55x+LwvQrKrVpbg9KDErjBvqmw7W8wMYqY23kKxoNv5ATh78ggP4Qm87zO?=
 =?us-ascii?Q?MDvr/YkQ2Bst/uOL0/ENmZ9r6yAatomr1uRSbVkGGnlA1lZ74TFWZjfmC6TL?=
 =?us-ascii?Q?ydFQ3B20/V4wJfe/8Z9YvjO5W5f96aIHAGICwG7oIWHYDI21J827IClVprv7?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0769c345-a58f-48ff-8a6d-08dbc59cde8c
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9654.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 12:16:14.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SO6xVwm4IM4XyqNs8QLTA+2FM/5faHM65USPRxm0sy5sprXxR11rMglVbso65a7uQI3wGROOK9VoV0w/dkaDmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: maheshtalewad <mahesh.talewad@nxp.com>

-Added MICS and MICP Unit test cases in a single file[test-micp.c].
-Fixed the issue that occurred while running all the
 Unit test cases at a time.
-Tested all Unit test cases and working fine.

Co-developed-by: Nitin Jadhav <nitin.jadhav@nxp.com>
Signed-off-by: Nitin Jadhav <nitin.jadhav@nxp.com>
Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
---
 Makefile.am      |   6 +
 unit/test-micp.c | 838 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 844 insertions(+)
 create mode 100644 unit/test-micp.c

diff --git a/Makefile.am b/Makefile.am
index c28c59a05..ac63c7ad0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -579,6 +579,12 @@ unit_test_bap_SOURCES = unit/test-bap.c
 unit_test_bap_LDADD = src/libshared-glib.la \
 				lib/libbluetooth-internal.la $(GLIB_LIBS)
 
+unit_tests += unit/test-micp
+
+unit_test_micp_SOURCES = unit/test-micp.c
+unit_test_micp_LDADD = src/libshared-glib.la \
+				lib/libbluetooth-internal.la $(GLIB_LIBS)
+
 unit_tests += unit/test-bass
 
 unit_test_bass_SOURCES = unit/test-bass.c $(btio_sources)
diff --git a/unit/test-micp.c b/unit/test-micp.c
new file mode 100644
index 000000000..e2975c298
--- /dev/null
+++ b/unit/test-micp.c
@@ -0,0 +1,838 @@
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
+#include "src/shared/gatt-helpers.h"
+#include "src/shared/micp.h"
+
+struct test_data_mics {
+	struct gatt_db *db;
+	struct bt_micp *micp;
+	struct bt_gatt_server *server;
+	struct bt_gatt_client *client;
+	struct queue *ccc_states;
+	size_t iovcnt;
+	struct iovec *iov;
+};
+
+struct test_data_micp {
+	struct gatt_db *db;
+	struct bt_micp *micp;
+	struct bt_gatt_client *client;
+	size_t iovcnt;
+	struct iovec *iov;
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
+#define MICP_GATT_CLIENT_MTU	64
+
+#define iov_data(args...) ((const struct iovec[]) { args })
+
+#define define_test_mics(name, function, _cfg, args...)		\
+	do {							\
+		const struct iovec iov[] = { args };		\
+		static struct test_data_mics data;			\
+		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		tester_add(name, &data, NULL, function,	\
+				test_teardown_mics);			\
+	} while (0)
+
+#define define_test_micp(name, function, _cfg, args...)		\
+	do {							\
+		const struct iovec iov[] = { args };		\
+		static struct test_data_micp data;			\
+		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		tester_add(name, &data, test_setup, function,	\
+				test_teardown_micp);			\
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
+static void test_teardown_mics(const void *user_data)
+{
+	struct test_data_mics *data = (void *)user_data;
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
+static void test_teardown_micp(const void *user_data)
+{
+	struct test_data_micp *data = (void *)user_data;
+
+	bt_micp_unref(data->micp);
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
+static void micp_write_cb(bool success, uint8_t att_ecode, void *user_data)
+{
+	if (success)
+		printf("MICP Write successful\n");
+	else
+		printf("\nWrite failed: 0x%02x\n", att_ecode);
+}
+
+static void micp_write_value(struct bt_micp *micp, void *user_data)
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
+		(void *)&value, sizeof(value), micp_write_cb, NULL, NULL);
+
+	if (!ret)
+		printf("bt_gatt_client_write_value() : Write FAILED");
+}
+
+static void micp_ready(struct bt_micp *micp, void *user_data)
+{
+	micp_write_value(micp, user_data);
+}
+
+static void test_client(const void *user_data)
+{
+	struct test_data_micp *data = (void *)user_data;
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
+	bt_micp_set_debug(data->micp, print_debug, "bt_micp: ", NULL);
+
+	bt_micp_ready_register(data->micp, micp_ready, data, NULL);
+
+	bt_micp_attach(data->micp, data->client);
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
+static struct ccc_state *find_ccc_state(struct test_data_mics *data,
+			uint16_t handle)
+{
+	return queue_find(data->ccc_states, ccc_state_match,
+				UINT_TO_PTR(handle));
+}
+
+static struct ccc_state *get_ccc_state(struct test_data_mics *data,
+			uint16_t handle)
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
+	struct test_data_mics *data = user_data;
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
+	struct test_data_mics *data = user_data;
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
+	struct test_data_mics *data = (void *)user_data;
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
+/*
+ *  ATT: Exchange MTU Request (0x02) len 2
+ *       Client RX MTU: 64
+ *
+ *  ATT: Exchange MTU Response (0x03) len 2
+ *        Server RX MTU: 64
+ */
+#define ATT_EXCHANGE_MTU	IOV_DATA(0x02, 0x40, 0x00), \
+	IOV_DATA(0x03, 0x40, 0x00)
+
+/*
+ *  ATT: Read By Type Request (0x08) len 6
+ *       Handle range: 0x0001-0xffff
+ *       Attribute type: Server Supported Features (0x2b3a)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Read By Type Request (0x08)
+ *       Handle: 0x0001
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define MICP_READ_SR_FEATURE	IOV_DATA(0x08, 0x01, 0x00, 0Xff, 0xff, \
+	0x3a, 0x2b), \
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a)
+
+/*
+ *  ATT: Read By Group Type Request (0x10) len 6
+ *       Handle range: 0x0001-0xffff
+ *       Attribute group type: Primary Service (0x2800)
+ *
+ *  ATT: Read By Group Type Response (0x11) len 7
+ *       Attribute data length: 6
+ *       Attribute group list: 1 entry
+ *       Handle range: 0x0001-0x0004
+ *       UUID: Microphone Control (0x184d)
+ *
+ *  ATT: Read By Group Type Request (0x10) len 6
+ *       Handle range: 0x0005-0xffff
+ *       Attribute group type: Primary Service (0x2800)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Read By Group Type Request (0x10)
+ *       Handle: 0x0006
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define MICP_READ_GROUP_TYPE	\
+	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28), \
+	IOV_DATA(0x11, 0x06, \
+	0x01, 0x00, 0x04, 0x00, 0x4d, 0x18), \
+	IOV_DATA(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28), \
+	IOV_DATA(0x01, 0x10, 0x06, 0x00, 0x0a)
+
+/*
+ *  ATT: Read By Group Type Request (0x10) len 6
+ *       Handle range: 0x0001-0xffff
+ *       Attribute group type: Secondary Service (0x2801)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Read By Group Type Request (0x10)
+ *       Handle: 0x0001
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define MICP_READ_REQ_SECOND_SERVICE	\
+	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28), \
+	IOV_DATA(0x01, 0x10, 0x01, 0x00, 0x0a)
+
+/*
+ *  ATT: Read By Type Request (0x08) len 6
+ *       Handle range: 0x0001-0x0004
+ *       Attribute type: Include (0x2802)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Read By Type Request (0x08)
+ *       Handle: 0x0001
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define MICP_READ_REQ_INCLUDE_SERVICE	\
+	IOV_DATA(0x08, 0x01, 0x00, 0x04, 0x00, 0x02, 0x28), \
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a)
+
+/*  ATT: Find Information Request (0x04) len 4
+ *      Handle range: 0x0004-0x0004
+ */
+#define	MICP_FIND_INFO_REQ	\
+	IOV_DATA(0x04, 0x04, 0x00, 0x04, 0x00), \
+	IOV_DATA(0x05, 0x01, 0x04, 0x00, 0x02, 0x29)
+
+/*
+ *  ATT: Read By Type Request (0x08) len 6
+ *       Handle range: 0x0001-0x0004
+ *       Attribute type: Characteristic (0x2803)
+ *
+ *  ATT: Read By Type Response (0x09) len 8
+ *       Attribute data length: 7
+ *       Attribute data list: 1 entry
+ *       Handle: 0x0002
+ *       Value: 1a0300c32b
+ *
+ *  ATT: Read By Type Request (0x08) len 6
+ *       Handle range: 0x0003-0x0004
+ *       Attribute type: Characteristic (0x2803)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Read By Type Request (0x08)
+ *       Handle: 0x0004
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define	MICP_READ_REQ_CHAR	\
+	IOV_DATA(0x08, 0x01, 0x00, 0x04, 0x00, 0x03, 0x28),\
+	IOV_DATA(0x09, 0x07, \
+	0x02, 0x00, 0x1a, 0x03, 0x00, 0xc3, 0x2b), \
+	IOV_DATA(0x08, 0x03, 0x00, 0x04, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x01, 0x08, 0x04, 0x00, 0x0a)
+/*
+ *  ATT: Read Request (0x0a) len 2
+ *       Handle: 0x0003
+ *
+ *  ATT: Read Response (0x0b) len 1
+ */
+#define	MICS_MUTE_READ \
+	IOV_DATA(0x0a, 0x03, 0x00), \
+	IOV_DATA(0x0b, 0x01)
+
+/*
+ *  ATT: Write Request (0x12) len 4
+ *       Handle: 0x0004
+ *       Data: 0100
+ *  ATT: Write Response (0x13) len 0
+ */
+#define	MICS_EN_MUTE_DISCPTR	\
+	IOV_DATA(0x12, 0x04, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x13)
+
+#define	MICS_MUTE_WRITE	\
+	IOV_DATA(0x12, 0x03, 0x00, 0x01),\
+	IOV_DATA(0x13)
+
+#define MICP_CL_CGGIT_SER_BV_01_C \
+	MICS_MUTE_READ, \
+	MICS_EN_MUTE_DISCPTR, \
+	IOV_DATA(0x12, 0x03, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x013)
+
+#define	MICP_CL_CGGIT_CHA_BV_01_C	\
+	MICS_MUTE_READ, \
+	MICS_EN_MUTE_DISCPTR, \
+	IOV_DATA(0x12, 0x03, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x013)
+
+#define MICP_CL_SPE_BI_01_C	\
+	MICS_MUTE_READ, \
+	MICS_EN_MUTE_DISCPTR, \
+	IOV_DATA(0x12, 0x03, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x80)
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
+	struct test_data_micp *data = (void *)user_data;
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
+/*
+ *  ATT: Write Request (0x12) len 3
+ *       Handle: 0x0003
+ *       Data: 00
+ *
+ *  ATT: Write Response (0x13) len 0
+ */
+#define	MICS_MUTE_WRITE_VAL_00 \
+	IOV_DATA(0x12, 0x03, 0x00, 0x00), \
+	IOV_DATA(0x13)
+
+/*
+ *  ATT: Write Request (0x12) len 3
+ *       Handle: 0x0003
+ *       Data: 01
+ *
+ *  ATT: Write Response (0x13) len 0
+ */
+#define	MICS_MUTE_WRITE_VAL_01 \
+	IOV_DATA(0x12, 0x03, 0x00, 0x01), \
+	IOV_DATA(0x13)
+/*
+ *  ATT: Read Request (0x0a) len 2
+ *       Handle: 0x0003
+ *
+ *  ATT: Read Response (0x0b) len 1
+ */
+#define	MICS_MUTE_READ \
+	IOV_DATA(0x0a, 0x03, 0x00), \
+	IOV_DATA(0x0b, 0x01)
+
+/*
+ *  ATT: Read By Group Type Request (0x10) len 6
+ *       Handle range: 0x0001-0xffff
+ *       Attribute group type: Primary Service (0x2800)
+ *
+ *  ATT: Read By Group Type Response (0x11) len 7
+ *       Attribute data length: 6
+ *       Attribute group list: 1 entry
+ *       Handle range: 0x0001-0x0004
+ *       UUID: Microphone Control (0x184d)
+ *
+ *  ATT: Read By Group Type Request (0x10) len 6
+ *      Handle range: 0x0005-0xffff
+ *      Attribute group type: Primary Service (0x2800)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *      Read By Group Type Request (0x10)
+ *      Handle: 0x0005
+ *      Error: Attribute Not Found (0x0a)
+ */
+#define DISCOVER_PRIM_SERV_NOTIF \
+	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28), \
+	IOV_DATA(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x4d, 0x18), \
+	IOV_DATA(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28), \
+	IOV_DATA(0x01, 0x10, 0x05, 0x00, 0x0a)
+
+/*
+ *  ATT: Read By Type Request (0x08) len 6
+ *       Handle range: 0x0001-0x0005
+ *       Attribute type: Characteristic (0x2803)
+ *
+ *  ATT: Read By Type Response (0x09) len 8
+ *       Attribute data length: 7
+ *       Attribute data list: 1 entry
+ *       Handle: 0x0002
+ *       Value: 1a0300c32b
+ *
+ *  ATT: Read By Type Request (0x08) len 6
+ *       Handle range: 0x0005-0x0005
+ *       Attribute type: Characteristic (0x2803)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Read By Type Request (0x08)
+ *       Handle: 0x0005
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define DISC_MICS_CHAR_1 \
+	IOV_DATA(0x08, 0x01, 0x00, 0x05, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x09, 0x07, \
+		0x02, 0x00, 0x1a, 0x03, 0x00, 0xc3, 0x2b), \
+	IOV_DATA(0x08, 0x05, 0x00, 0x05, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x01, 0x08, 0x05, 0x00, 0x0a)
+
+/*
+ *  ATT: Find By Type Value Request (0x06) len 8
+ *       Handle range: 0x0001-0xffff
+ *       Attribute type: Primary Service (0x2800)
+ *       UUID: Microphone Control (0x184d)
+ *
+ *  ATT: Find By Type Value Response (0x07) len 4
+ *       Handle range: 0x0001-0x0004
+ *
+ *  ATT: Find By Type Value Request (0x06) len 8
+ *       Handle range: 0x0005-0xffff
+ *       Attribute type: Primary Service (0x2800)
+ *       UUID: Microphone Control (0x184d)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Find By Type Value Request (0x06)
+ *       Handle: 0x0005
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define MICS_FIND_BY_TYPE_VALUE \
+	IOV_DATA(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0x4d, 0x18), \
+	IOV_DATA(0x07, 0x01, 0x00, 0x04, 0x00), \
+	IOV_DATA(0x06, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28, 0x4d, 0x18), \
+	IOV_DATA(0x01, 0x06, 0x05, 0x00, 0x0a)
+
+/*
+ *  ATT: Read By Type Request (0x08) len 6
+ *       Handle range: 0x0001-0x0005
+ *       Attribute type: Characteristic (0x2803)
+ *
+ *  ATT: Read By Type Response (0x09) len 8
+ *       Attribute data length: 7
+ *       Attribute data list: 1 entry
+ *       Handle: 0x0002
+ *       Value: 1a0300c32b
+ *
+ *  ATT: Read By Type Request (0x08) len 6
+ *       Handle range: 0x0003-0x0005
+ *       Attribute type: Characteristic (0x2803)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Read By Type Request (0x08)
+ *       Handle: 0x0003
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define DISC_MICS_CHAR_AFTER_TYPE \
+	IOV_DATA(0x08, 0x01, 0x00, 0x05, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x09, 0x07, \
+		0x02, 0x00, 0x1a, 0x03, 0x00, 0xc3, 0x2b), \
+	IOV_DATA(0x08, 0x03, 0x00, 0x05, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x01, 0x08, 0x03, 0x00, 0x0a)
+
+/*
+ *  ATT: Write Request (0x12) len 4
+ *       Handle: 0x0004
+ *       Data: 0000
+ *
+ *  ATT: Write Response (0x13) len 0
+ *
+ *  ATT: Write Request (0x12) len 4
+ *       Handle: 0x0004
+ *       Data: 0100
+ *
+ *  ATT: Write Response (0x13) len 0
+ */
+#define MICS_WRITE_CCD \
+	IOV_DATA(0x12, 0x04, 0x00, 0x00, 0x00), \
+	IOV_DATA(0x13), \
+	IOV_DATA(0x12, 0x04, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x13)
+
+/*
+ *  ATT: Find Information Request (0x04) len 4
+ *       Handle range: 0x0004-0x0005
+ *
+ *  ATT: Find Information Response (0x05) len 5
+ *       Format: UUID-16 (0x01)
+ *       Handle: 0x0004
+ *       UUID: Client Characteristic Configuration (0x2902)
+ *
+ *  ATT: Find Information Request (0x04) len 4
+ *       Handle range: 0x0005-0x0005
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Find Information Request (0x04)
+ *       Handle: 0x0005
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define MICS_FIND_INFO \
+	IOV_DATA(0x04, 0x04, 0x00, 0x05, 0x00), \
+	IOV_DATA(0x05, 0x01, 0x04, 0x00, 0x02, 0x29), \
+	IOV_DATA(0x04, 0x05, 0x00, 0x05, 0x00), \
+	IOV_DATA(0x01, 0x04, 0x05, 0x00, 0x0a)
+
+/*
+ * 1.reads the characteristic value for the
+ *  Mute characteristic
+ * 2.update the Mute characteristic to 0 or 1
+ * 3.sends a notification containing the updated value
+ *  of the Mute characteristic
+ * 4.update the Mute characteristic to 0 or 1 which ever
+ *  different than step 2
+ * 5.sends a notification containing the updated value of
+ *  the Mute characteristic
+ */
+#define MICS_SR_SPN_BV_01_C \
+	ATT_EXCHANGE_MTU, \
+	DISCOVER_PRIM_SERV_NOTIF, \
+	DISC_MICS_CHAR_1, \
+	MICS_FIND_BY_TYPE_VALUE, \
+	DISC_MICS_CHAR_AFTER_TYPE, \
+	MICS_FIND_INFO, \
+	MICS_WRITE_CCD, \
+	IOV_DATA(0x0a, 0x03, 0x00), \
+	IOV_DATA(0x0b, 0x01), \
+	MICS_MUTE_WRITE_VAL_00, \
+	IOV_DATA(0x1b, 0x03, 0x00, 0x00), \
+	MICS_MUTE_WRITE_VAL_01, \
+	IOV_DATA(0x1b, 0x03, 0x00, 0x01), \
+	IOV_DATA(0x0a, 0x03, 0x00), \
+	IOV_DATA(0x0b, 0x01)
+
+#define MICS_SR_SGGIT_SER_BV_01_C \
+	ATT_EXCHANGE_MTU, \
+	DISCOVER_PRIM_SERV_NOTIF, \
+	MICS_FIND_BY_TYPE_VALUE
+
+#define MICS_SR_SGGIT_CHA_BV_01_C \
+	ATT_EXCHANGE_MTU, \
+	DISCOVER_PRIM_SERV_NOTIF, \
+	MICS_FIND_BY_TYPE_VALUE, \
+	DISC_MICS_CHAR_AFTER_TYPE
+
+/*
+ *  ATT: Write Request (0x12) len 3
+ *       Handle: 0x0003
+ *       Data: 02
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Write Request (0x12)
+ *       Handle: 0x0003
+ *       Error: Value Not Allowed (0x13)
+ *
+ *  ATT: Write Request (0x12) len 3
+ *       Handle: 0x0003
+ *       Data: 05
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Write Request (0x12)
+ *       Handle: 0x0003
+ *       Error: Value Not Allowed (0x13)
+ */
+#define MICS_WRITE_MUTE_CHAR_INVALID \
+	IOV_DATA(0x12, 0x03, 0x00, 0x02), \
+	IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x13), \
+	IOV_DATA(0x12, 0x03, 0x00, 0x05), \
+	IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x13)
+
+#define MICS_SR_SPE_BI_1_C	\
+	ATT_EXCHANGE_MTU, \
+	DISCOVER_PRIM_SERV_NOTIF, \
+	MICS_FIND_BY_TYPE_VALUE, \
+	MICS_WRITE_MUTE_CHAR_INVALID
+
+/*
+ *  ATT: Read Request (0x0a) len 2
+ *       Handle: 0x0003
+ *
+ *  ATT: Read Response (0x0b) len 1
+ */
+#define	MICS_MUTE_READ_INVALID \
+	IOV_DATA(0x0a, 0x03, 0x00), \
+	IOV_DATA(0x0b, 0x02)
+
+/*
+ *  ATT: Write Request (0x12) len 3
+ *       Handle: 0x0003
+ *       Data: 01
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Write Request (0x12)
+ *       Handle: 0x0003
+ *       Error: Reserved (0x80)
+ */
+#define	MICS_MUTE_WRITE_1 \
+	IOV_DATA(0x12, 0x03, 0x00, 0x01), \
+	IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x80)
+
+/*
+ *  ATT: Write Request (0x12) len 3
+ *       Handle: 0x0003
+ *       Data: 00
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Write Request (0x12)
+ *       Handle: 0x0003
+ *       Error: Reserved (0x80)
+ */
+#define	MICS_MUTE_WRITE_0 \
+	IOV_DATA(0x12, 0x03, 0x00, 0x00), \
+	IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x80)
+
+#define MICS_SR_SPE_BI_02_C	\
+	ATT_EXCHANGE_MTU, \
+	DISCOVER_PRIM_SERV_NOTIF, \
+	MICS_FIND_BY_TYPE_VALUE, \
+	MICS_MUTE_READ_INVALID, \
+	MICS_MUTE_WRITE_0, \
+	MICS_MUTE_WRITE_1
+
+int main(int argc, char *argv[])
+{
+
+	tester_init(&argc, &argv);
+
+    /* MICS Testcases */
+	define_test_mics("MICS/SR/SGGIT/SER/BV-01-C", test_server, NULL,
+					MICS_SR_SGGIT_SER_BV_01_C);
+	define_test_mics("MICS/SR/SGGIT/CHA/BV-01-C", test_server, NULL,
+					MICS_SR_SGGIT_CHA_BV_01_C);
+	define_test_mics("MICS/SR/SPE/BI-01-C", test_server, NULL,
+					MICS_SR_SPE_BI_1_C);
+
+	/* MICS/SR/SPE/BI-02-C:
+	 * In function *mics_new(struct gatt_db *db)[src/shared/micp.c]
+	 * by default the mics->mute_stat is set to MICS_MUTED[0x01].
+	 * As per test specs, Testcase MICS/SR/SPE/BI-02-C, Initial
+	 * condition of mute state should be MICS_DISABLED[0x02].
+	 * To verify this Unit test case we have to modify the initial
+	 * state of mics->mute_stat to MICS_DISABLED in code
+	 * [in func mics_new()], build it and run bluetoothd. Then run
+	 * this unit test case and this test case will Pass.
+	 */
+	/* define_test_mics("MICS/SR/SPE/BI-02-C", test_server, NULL,
+	 *				MICS_SR_SPE_BI_02_C);
+	 */
+	define_test_mics("MICS/SR/SPN/BV-01-C", test_server, NULL,
+					MICS_SR_SPN_BV_01_C);
+
+    /* MICP Testcases */
+	define_test_micp("MICP/CL/CGGIT/SER/BV-01-C", test_client, NULL,
+					MICP_CL_CGGIT_SER_BV_01_C);
+	define_test_micp("MICP/CL/CGGIT/CHA/BV-01-C", test_client, NULL,
+					MICP_CL_CGGIT_CHA_BV_01_C);
+	define_test_micp("MICP/CL/SPE/BI-01-C", test_client, NULL,
+					MICP_CL_SPE_BI_01_C);
+
+	return tester_run();
+}
-- 
2.34.1

