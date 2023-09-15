Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409F4EE645D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 13:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbjIONTK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 09:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbjIONTJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 09:19:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE65219AE
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 06:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqB+f0BrdwRZKTzA6OOFyjMduG+7oh44HvMK/TKOSloFYCgrlTH5e9j8sqC/U99nRWl/z45kQjRkXwOj0WEGKDEuRAhgtgqyShsJGDHPeKinMhiyZDwr00zxpg+SAeRfY9qA4vTPLDo6lyQQqGnnqotcsv29oRP4Bk0OvzTI2Akx+PyoS4JDP1dJmGCvx4BU5y2AdJzWJDJnITseN8yhJqvOeBAQla8uidONwC7s3oAkV3OnavSvBbWN9rZ6LCuyv35dDCYPaV/x1wUypmGJaIUy/hk4a4FEkxD/cUWlWl6HgyrBYzR2aI/1ezrfW1q1weqgyaYUXwJbpi1DVjPr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=easvc3CZa9qiO0y4abUlaTKrbI8ij5F3hw/HHDwS55w=;
 b=oe0izpvZ+H6rpPtGYFB4CmsnzH1kD/EvJRZ5dJYuDO2KbHf8Z2UIfVzw9TOK0ycKATp+TTpgSuMzbXaJ1p+fr+Iy9sifxufwo2UkxCxfPtNdCd5f0qbi4+2SfC9NfGzVzLqzo2Pg30CyTenpM9ryw1YP6OxdwG4LwwmZGbAqtaVp1r+dF4kSnpo+biwwbkRIjVxIZ9jb+99tJOBCnqcibYocmcOovxJoXp31xSrnJf/Q6PNeFq4D6M05E9sgJXd/nv8t/PjjWer7DHkf0/EMGNphDOa1NQOem5l2icP6YaGFeDZ/L/yo74IQ4Ssoahbo5Pbx4IS1kbaHU8u05uDvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=easvc3CZa9qiO0y4abUlaTKrbI8ij5F3hw/HHDwS55w=;
 b=WXP3c+c4zuHccajKYMs2o2aMIXr2Ak5lECBD1zHOmdzDcRL8awAM+ayIsT4iUWHkW0VoA2v+hAGkwiPRhHsdzZ1+msybkVMVCibeD43Hx9LkLh6oH74RzR7SdYp6CS12hq/os5kT84lVgAM8RR6tFOoOGYiHHTW/PRlVjXCSpRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6991.eurprd04.prod.outlook.com (2603:10a6:803:12d::13)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 13:18:59 +0000
Received: from VI1PR04MB6991.eurprd04.prod.outlook.com
 ([fe80::e160:6b82:9656:6366]) by VI1PR04MB6991.eurprd04.prod.outlook.com
 ([fe80::e160:6b82:9656:6366%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 13:18:59 +0000
From:   maheshtalewad <mahesh.talewad@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mahesh.talewad@nxp.com,
        luiz.dentz@gmail.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v3 1/1] unit/test-micp.c : MICP-MICS unit test case implementation
Date:   Fri, 15 Sep 2023 16:18:31 +0300
Message-Id: <20230915131831.119124-2-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915131831.119124-1-mahesh.talewad@nxp.com>
References: <20230915131831.119124-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0050.eurprd03.prod.outlook.com (2603:10a6:208::27)
 To VI1PR04MB6991.eurprd04.prod.outlook.com (2603:10a6:803:12d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6991:EE_|AM7PR04MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: c16df951-fc08-4cec-1469-08dbb5ee526e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dc7sfRHJDsyOp77WAkxcKziIRkHMK0KnrFdyvV/a7CLfzTvKfGVnlejiPBhAer2nnXui2KHo9aa7bYURYS8wGb+Nlr9CHS5SEdr2o7++U072Tx6gdX6PKNzCXTD4wcFv1i8nu8NkS3MXcg95LlAek5E6wfjTeTBwN4NTbJfd1YxWjINKqbCKnQU4tNA2lv6eRXkV+qbjlF55OfKna+9Clyt8avu7zaR3ZeUlBJqk9H9KTkbNOixM3w1vomFTDb/2XuAHfvQ8h2079jDSGWdmigOO6diJc5ELoqe1yYr9dyT9zoPxGmJsqLOUz42X1WTImp7ud5weIFxbJTysJSfnrvdLdGADdvCsp8KOH9O/AskHsaJZuApvrQd44H1rFAKkH1XnW1OqHm8ZNpHy/l4fHyXQVR8K0+Q7RtH4zPPHH24VFLZrT0AH7Zi7su5fkZN0FK8OzLa1fbxoR3AhbM7Y9p3UogWdQf48fZixgICG6uz8TZIglZgv+tMCCoshhMTcusaSrfr9El9VHt+WLJene2leiG/O5KHqaApy7sBRp/cTmBnH3fJUN5CNKCn6uNJBnatqKCDzxey+LuQBmfZbouO6KmMMG4jf6WM4MJeyghogkoeM3ryWpHLvVRPgCPP1mv8qToro7DZmAbRYTfVF1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6991.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(186009)(1800799009)(451199024)(1076003)(52116002)(6486002)(55236004)(38350700002)(2616005)(6666004)(66946007)(6506007)(86362001)(83380400001)(478600001)(26005)(41300700001)(66556008)(66476007)(2906002)(6512007)(5660300002)(316002)(4326008)(36756003)(6916009)(8676002)(8936002)(30864003)(38100700002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ivpjvEvaAEii5sUlvlWCfhGHEc9dXsRPA9utEXxaiyAT96GbkPhcB/KvzYB?=
 =?us-ascii?Q?J7l9uX7cBbWMMrJpNmfCA/0C1Kbk6OfOdR2zqV7RBM01e3y1gaPQ4xJl6YRX?=
 =?us-ascii?Q?YNpIbNW0m8HrmXOazqfM9hBiR/alqrkQ4jTmBc+RRdIJXiMo7rSyp5skiKYK?=
 =?us-ascii?Q?J1Rs8Q5dlVvl+AhR5pFeYb6yb94LOLmONg1nJtYMqr68VI97Y7uI1dcmEN7b?=
 =?us-ascii?Q?wNlBCa4RbJfktjEt240ILT+S5mb2HDupGF+OwW0UXdo30FJyYBClo/H8Hfvc?=
 =?us-ascii?Q?VxIVQxQ/3f9OXMA9hRxMgPiaopx1TkT8ghZw0BG7kG7aBsrnCu/X2gNDXoR4?=
 =?us-ascii?Q?PR1aPKJbbrrjN6dhgQTNkpQpj6gVHDthJdOniuO0zUKRQLeKQWZfb95jDt60?=
 =?us-ascii?Q?X+ZBI7865pAziFm1HhlJZWz02qXdm+CMTrs7xqunCzRaHnVjQqeSlPeA2pHF?=
 =?us-ascii?Q?JAzexIGHf4tSJeM5j2St9lM802VKjHjmZPLMGAznXq0vXlVtRd1FCfNSHZrU?=
 =?us-ascii?Q?N+h31nQ0pzcOGChAh4WrJhHdEh38GXmyAiyJnzoYa0L3upe6sQYYuWikkV/6?=
 =?us-ascii?Q?hKxso/9K4QWTRgkiWcJE1W7z6CoQIUB4qboUaTZCZK8H5nMf/crBjSWYrNQF?=
 =?us-ascii?Q?7d6tKScub522yZebbjnF/cT19XsnK9i4CmkzuzTqViLcqO+++VXkzbrjPMF7?=
 =?us-ascii?Q?4BFxXLXK3ILeReB8b4BtAggzfbYVPl8FauQFCl+by9EJneKmEp/ZcC6g6yRT?=
 =?us-ascii?Q?0sLNiqcGQMiIr/jFmtKx7544lvUzcaXnEqfSU/G1ZKMXhULuShm410dK4Q4H?=
 =?us-ascii?Q?ZYPMuP5vwctaIlJwsp/tXEHh2Pf+PRuZrgMvLqtnl17B6Lg3bRa7IL9GdoqI?=
 =?us-ascii?Q?+UBlhtBhLrCxaxeGrAHzufkVTn+gHsUPgc2dxcN2WmK76Y8W9kyIdfw+pWz0?=
 =?us-ascii?Q?/gdrQNM22ul6QZqoB/TIw1j1aHTXHrihdfFuvrdVtMVbnw+pdKDfrz6HvZtn?=
 =?us-ascii?Q?V60+3yJMSS6A1aC8YhvqPSPM/oXGtQsCZYKqT38wdiFmppEm/K8s3ajqrmxW?=
 =?us-ascii?Q?RtSSM/qBbsDxnjYyAcepeBoybT7+Z+keD6LJCCrpxFw7hTptXFm8eplG50ND?=
 =?us-ascii?Q?bqpwvq9mDKzZZU5ywYukWDCLTcQCajV22nGj5V2gEPspK35KxMY3aUaUvFJw?=
 =?us-ascii?Q?J+tKT6y5CpvsQka1VlHY/fEcvE/K7JX9+0p7PmHPpLe8aeZxYnFZttx5P0Bo?=
 =?us-ascii?Q?HR+lvg6moXXcBdEne6Yugrsw2+yxjT1w32KML4/hcft5e6CJowddLAL6X/Mf?=
 =?us-ascii?Q?A14efLGSyFFRngQpvZ2I5kLnTC00XjhKPyKBlhegt2FZVJBuC/uIVCSvk4ou?=
 =?us-ascii?Q?t/Cb4rE/rokBJsnapXlxzMhv76Y3U1JC7465wD9UFNa7zHQ8w6iSkvbXws8k?=
 =?us-ascii?Q?SMJ7ZZ7oooaqxVyGIuTgw7RbXMdSwFJNOfmCfeak1y2ZIy6ALyLB7VyX5QmG?=
 =?us-ascii?Q?5936Gv0OU7HDcpBPGeFsBWo9pmcuSlfzUM7uBYK0Mf1kl6u7lBGyLliDXqmk?=
 =?us-ascii?Q?YsgykhQ2zNpLilBkzzQR6jj01ZIqSo/GV0yN6XIGGQ6XV2+sste0rMdhX9Th?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16df951-fc08-4cec-1469-08dbb5ee526e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6991.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 13:18:59.5953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCiqhhQPGCfolbV4+yTl6HOdw1TTU6ST07BRbmLHO12oKNCnjlLAFDgAnNlLoPVQN8+oHPQApdK3xa3/xJ+MFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

-Added MICS and MICP Unit test cases in a single file[test-micp.c].
-Tested all Unit test cases and working fine.

Co-developed-by: Nitin Jadhav <nitin.jadhav@nxp.com>
Signed-off-by: Nitin Jadhav <nitin.jadhav@nxp.com>
Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
---
 Makefile.am      |   6 +
 unit/test-micp.c | 847 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 853 insertions(+)
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
index 000000000..04f5f4ad5
--- /dev/null
+++ b/unit/test-micp.c
@@ -0,0 +1,847 @@
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
+	struct test_config *cfg;
+};
+
+struct test_data_micp {
+	struct gatt_db *db;
+	struct bt_mics *mics;
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
+		data.cfg = _cfg;				\
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
+		data.cfg = _cfg;				\
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
+	bt_micp_set_debug(data->micp, print_debug, "bt_mip: ", NULL);
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
+	IOV_DATA(0x12, 0x03, 0x00, 0x06, 0x00), \
+	IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x013), \
+	MICS_MUTE_READ
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
+	define_test_mics("MICS/SR/SPE/BI-02-C", test_server, NULL,
+					MICS_SR_SPE_BI_02_C);
+	define_test_mics("MICS/SR/SPN/BV-01-C", test_server, NULL,
+					MICS_SR_SPN_BV_01_C);
+
+    /* MICP Testcases */
+	define_test_micp("MICP/CL/CGGIT/SER/BV-01-C", test_client, NULL,
+					MICS_MUTE_READ);
+	define_test_micp("MICP/CL/CGGIT/CHA/BV-01-C", test_client, NULL,
+					MICP_CL_CGGIT_SER_BV_01_C);
+	define_test_micp("MICP/CL/SPE/BI-01-C", test_client, NULL,
+					MICP_CL_SPE_BI_01_C);
+
+	return tester_run();
+}
-- 
2.34.1

