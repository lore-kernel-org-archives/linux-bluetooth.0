Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531F6CA0FFA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349713AbjIEQWK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353671AbjIEHKC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 03:10:02 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2084.outbound.protection.outlook.com [40.107.14.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058371B4
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 00:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePgf0gH2Rxt93QWuLpLD35byTbktUlY2yfeAsi3qGxcMPtqAuxdA1J8mt8k3Cz/e1bphfpk/z+Ha1d3jTuGQfvGca7agJ5lNSthHCkrFNBYVSCgcBcixi4ySivwLSrt0J5b8g4wE4f1LsFa0EwdTzWzcjorDjFdKiiniu2LXj+2xlJHDe32iQlEjoMH5qC7kFisqggLTXNyTw4Gpy9Hb/XyhluOqv4gIV8t1R33Si2cEj8ijyj2wCW0AihgK9ZFcVEnA0/qrQFXRIpuLAKJs/RYJSRUdj35t3YaA9Rcw0DrB3gBBSBvi8hg0uexruwD9eb/ETuF07VnRuYRsEJ1Jfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3zOJG/Tl6o4BkWw52KbeJfBXtdds9wHUT2KOWv2gYg=;
 b=k7rys7zBym8ob4u+anyKWfkE4Ojk4oT/1RPPkpljDvUT8VukvY5NbwWL7pqsXfQ49IpsU/DWHAMvetub+ZzyngfDWIuCj/7Zy/MWquE6PXCH+V/ywe/1X9gNrdzWsyzDF/YutT+fzjGosJoMMivihUQsmVRRAB79yU1qFrD+wjBI4RTwEnG/iWr/Xwp/DTbD2t8Gi3nFd42KzojsYbI2bhDSlzdXgMz0nLU4ayXPZddVgh429G1GENBpjhI66P9uh1Eg853LfW8bMplyoMKS8iyYDqVpvtOLKD6fqSFcLLBUI6bppQGPcFGVy7RE/svrD/LRFsHFPtUBNPUBQbPVeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3zOJG/Tl6o4BkWw52KbeJfBXtdds9wHUT2KOWv2gYg=;
 b=SYQgZ+4DWGwvXVjRZUgk75/ifinMz/W3P2dx4R0W/JEsTDRUJCPLsVtRK/18m9xBg5tL2OiXXL2wxg30yLzhSooluK5U4cRakUzXwF63Qi/8ba4dvdgWzulrSnvZHS/sVmTEP5Ar+E1JX1U/lqYwgG90YwoLUjhr/zrAZ/aWmVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by DBBPR04MB8058.eurprd04.prod.outlook.com (2603:10a6:10:1e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 07:09:55 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::2320:fa57:8f7c:bb64]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::2320:fa57:8f7c:bb64%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 07:09:55 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mahesh.talewad@nxp.com,
        luiz.dentz@gmail.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v2 4/4] unit/test-micp-test-mics: To implement unit tester code
Date:   Tue,  5 Sep 2023 10:09:12 +0300
Message-Id: <20230905070912.82340-5-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905070912.82340-1-nitin.jadhav@nxp.com>
References: <20230905070912.82340-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|DBBPR04MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 32be7bba-ad2c-4f7f-52d4-08dbaddf1b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8apolO8iemCWWrwgyZzEAVHI7ud+40KQ7VvaDudn7qhBIt1WszEgui01g6FQRTiSwVjxrzW+fpc3B2hmM8xAGcxIqAwp0iLnY2EbKeJxnJr6iTwYEAPlzrcFR5zi0l+IPXeDa5RWmxMTVTiTVr6QDThL48sHtwA3i51+q2QJPflVWboyPy1qJnsxumhuwp1lAiLtzXX+sty4aWq/IZZ3MauU4HT6D8CTjhL8RS9iLCAR9aB6bCxFs0hPIb3vRczlklikNLYW1ir/DRl22C+5YxZG9FaJgz8SM8hK/fmjIZyex4c+fHnb3HjP6tV8wQhNu1CB4dv1YZIoq+CxWTcAqYg+ygl6MDYc2LJ37avV0WkMn22NhhjKSsOs+ErlCReYunNYTRD4b+ThzxOs917OLWONqebhDliliriSoJ9op4D2NPhutIz4JAD3rn89i9ERU3GUY5LaxTIeCxJYTJH+uk9It2f8vQ3npV5L/GGJEl/GDVnt1GY4Qka8YEmzJWTeHrh4yWmQHDBs8hfgXXWp0eyqCGLeTnDBmFIDeOqrqkowfTBzOWctXTA//Bm+3StcHSOm7V/OtqEphf7M0GEIetadudU1+8d8ajek5FawG5wyrU4Un+fQwwfFN/H9VNH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199024)(1800799009)(186009)(66946007)(66556008)(66476007)(6916009)(478600001)(38100700002)(38350700002)(316002)(30864003)(2906002)(41300700001)(86362001)(8936002)(8676002)(4326008)(5660300002)(44832011)(6506007)(83380400001)(6512007)(6666004)(6486002)(52116002)(55236004)(2616005)(26005)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DMoEYFL4EemJIFZWaOehFBe8vke0+YkAtup+9qb4KoveITaqVyVRhS73RePN?=
 =?us-ascii?Q?o7dskpkmWr6vXtRUyowaEBhnAFGPBPAFrhSZ4GIMOXX1Vv1ny4Vfci2N0dL8?=
 =?us-ascii?Q?Fdh3Wq3FL9dK83RevO7QuQYbJzSXEUWHBZ/BDcmd8fPOutiW+pgMbI5aw95k?=
 =?us-ascii?Q?CBxNA60d4ltyIHeUHr0mxV8GtjzQDLzrdhipdbsFZef3uA1bz6ZHGrYYWv+3?=
 =?us-ascii?Q?F3A3+vwRwO73AhZglTYFaPN6U+yEH6vNk+Ta0mDqgtJFBR6hbHklk4CHZPMm?=
 =?us-ascii?Q?cgsgAPFpdgMYCtHhVnJmN/IZ+6m1ouV0bS7103+6EI/u56lOUaJmGQU6ULnn?=
 =?us-ascii?Q?LDfOfQKiCqMUv6kK9eMBsC6FKqZPu8o1Omt4LPdbUKmpYGCCOhXT49R9LuKy?=
 =?us-ascii?Q?CAM78gYFNPa+YiLnO/6MD/Reio84EHh2/l7t6IakuxJqRspNx1i4fLbN8T4i?=
 =?us-ascii?Q?FosX+cJNKwslb0FhuGi69O/aPogT9c+f5bkuOFkAKuJtSyCyXfI2wkFKA3Tm?=
 =?us-ascii?Q?GfJW5wEo0aOXiix6IOiybGrhbblckIJmYacHP6WyYfu4Os4AhznesS0cwFDB?=
 =?us-ascii?Q?h0k6GYEyBeukYGsm9HUDAQZw6b3OzF9ZPO/8jVeh6tx9UJK7q3uRdd9Bofhd?=
 =?us-ascii?Q?gQm/83t3IrZgciAzfi2ud9QjLe5qIhiahcvn00wHePznCtoZzT1bEjQCNHN6?=
 =?us-ascii?Q?ewTgpvALxgcsOXrtk0n8ITNX8R9QkUAlpPKe4AkJt7LM2y44/MgStaG8wCrB?=
 =?us-ascii?Q?ntKluT25N/lpllUIifMoh6e2PTL56psBgqtHJmkUDKPcHbh6ldohauynIRJW?=
 =?us-ascii?Q?2gzoe0DOJt5pL2BJEVcdjmwNPPnpg1GpYBZWTPQg8+H55pLT/up6SST+WKmQ?=
 =?us-ascii?Q?0gKSJDf9PhpLDJgKMh77Ts4smCNBmZ3lXJtJnUFt3UoVO0RdCHCNBx+OXQ5v?=
 =?us-ascii?Q?x505J/PVLBRZ/krtGPPBzM6zb5IRsHTOB8JcxIN4jpHMNTn1t9drmKUvxn2A?=
 =?us-ascii?Q?+kq369xwG8j/f8CIZHBCPGKOPK5kZ+MOZRExwHdCwwiKXSKG+qy8+1PLA44g?=
 =?us-ascii?Q?HND41QSWSJ4u17BoncE2TazZj8uGMlVvJz8U0XnsRMOjulAQA82zkHl9+rZI?=
 =?us-ascii?Q?fgsRyY6EDTTdVMvO+w1e+ks7rjXt3f+UZudOJ9lD3uhfv8s+pFz387AnN7Su?=
 =?us-ascii?Q?tgQPG4Qjru8EW/VjdkdkA3D1Z0Kcme8IN4qK0fNqoU/DShZl04iVKbjbWvB+?=
 =?us-ascii?Q?d6HhLnWP4VMaQbSwVE/o4+xbSF80EGOfFSYHuMhWcIyEc8wIFRMrBiaw//Ak?=
 =?us-ascii?Q?nnwWSUOjFOqrCQcM7RgtGhY/P2VYYal1obm0SGGLua5LloC02Nvhp8yT0Jf9?=
 =?us-ascii?Q?8AmcJg4jXPAkV98MD+lYm+97zeTYifEyqbfIH5xBbXkgjoDipQBelWnQbddB?=
 =?us-ascii?Q?RjEPPZMkM+Jo1+9GwxEDaCfwhpU7irny4o9+UUGyF8syKEHuBHD0hvrWzgn3?=
 =?us-ascii?Q?5h5JtNOKbTKXiNymklzujICt7dZsJuv4VP6qRVaCOCaEUunMn0kFmkVP2bzy?=
 =?us-ascii?Q?um5lD40hzbZmCTWRq9G93h/C0WS/+Y+XkoMtyk1B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32be7bba-ad2c-4f7f-52d4-08dbaddf1b3d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 07:09:55.0836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjZ5r2nGYFv6moq9HRR7qmw5obmO9sriBJ4NyEugmzWTH77INRln7s1DkGh4qHIlf8k01wWEITuVnewOXXrnVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8058
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Implemented Unit Testcases for MICS[test-micp.c] and MICP[test-mics.c].

Co-developed-by: Mahesh Talewad <mahesh.talewad@nxp.com>
Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
Signed-off-by: Nitin Jadhav <nitin.jadhav@nxp.com>
---
 Makefile.am      |  13 ++
 unit/test-micp.c | 357 +++++++++++++++++++++++++++++++++++++++++++++++
 unit/test-mics.c | 317 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 687 insertions(+)
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
index 000000000..7a7d70bf3
--- /dev/null
+++ b/unit/test-mics.c
@@ -0,0 +1,317 @@
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

