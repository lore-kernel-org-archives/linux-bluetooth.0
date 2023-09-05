Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34731CA0FE2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjIEQWy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353670AbjIEHJ5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 03:09:57 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5C31B4
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 00:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOAA8gaDOEU49PeA2KxImyGe/XPxVSL4FkJdGexKIrxncvP9T7ZTOz5vq2aWUUL9eJi2To0tL+5q8TGONoXitGsYiXl9Q372SBmtZ7RPKeNTIvgACFTbNBeDyyzu7EQkpocLjs9uhzU7ws1KwVBRu393gHlGppNqoUIR3zqnJPw7cdZws7vIL31++Td/6jZuLbuYhXlKRgX0jsPml/N3yG75EVgzauvdJY/uxp/CcZiuU2vffM+HaqF/ZoV35/HTGhWzR78R5of88AkDIHuCo5+EHTijzhUKEs8KUcqQnjzjZpYALWJZp0ctIG9vdC2zMMF19jRmUNCCM/i9Hn6xyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QixYa73qMrOEn2y44yuyOC4vF8yJozPeyquUdBrhJw=;
 b=ZiusdtuJUTQwhF+kAng7PGMM6/PrWlhouDJ+sOWB0FrXJXkZag2taB7R4i8hkbbvpZu9LWZbHC7g1bQnkl/k1RogKpM1tFmc3Jtj7UeIj/bAlvvtUd80N+ju2uTG5+XeZeXGl3Bl2Hh1gCv0apl4SXgeuwPPGL82xmo824zbm8AzGvDMGE3ILOuM79HmAwPBB7UwZC1E0rtTo3EUnMomoWsVZXxlv7YDNmLYpoN35KbdfqFN0ArA0QHfxdrOCABzVgkrWUPo+p1pcauIAnuoIKraki9vJFAW2Wc4TwblB4RRy5k3tCLUPN2lMZUbO3ua3Q0EfuKBhaHs30hxmm23yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QixYa73qMrOEn2y44yuyOC4vF8yJozPeyquUdBrhJw=;
 b=lRLmmTFQzI9IdhelBheos0zsjm8sePUfzy1hq+XVSrGjjNIJ6urdZjjI6jsvY1+k3wuLdBso7h7wzKp9TSlzqY4PtUSFExTN36xSYlktiiNlDsa46B/1PtY2wqUtHah+OawpiYin83FFnqbe07aCUUuvsuCTEKkhqdKSsXLRIaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by DBBPR04MB8058.eurprd04.prod.outlook.com (2603:10a6:10:1e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 07:09:51 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::2320:fa57:8f7c:bb64]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::2320:fa57:8f7c:bb64%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 07:09:51 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mahesh.talewad@nxp.com,
        luiz.dentz@gmail.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v2 3/4] profiles/audio/micp.c: To implement MICP plugin
Date:   Tue,  5 Sep 2023 10:09:11 +0300
Message-Id: <20230905070912.82340-4-nitin.jadhav@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 95963ddf-4da9-4b23-7220-08dbaddf191b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r62JeXrfxDNzxU2Cpiytsou4kTCZlg7+NTC/T6n0ah7P2RqYDUnNpmkGH91pF9eKTCYVHUiopAHvc5bd8cf2WKhOf0cOkcPzkoTEMCzZImfyptEEK5KwuIBhm3e+je72atC0/6+0LzBPSfC3w7UrbNVGcJ0xMZktFLxU3u8tBvPl+SrAp6ND2ANyEQGL9xyQTiARnz7FFmkdoTstk0ktXN+5W3ntndHGuJIc8appsVX/iRgc70gK6KxZ7YsAqwTh3Igv2LhTOFmzY2N244m+SUNTQnjyvI3mrR1/ST5UgE9M2c+5S42aHv2f8yBcVAZWI1JrlUIWvcAc1nguz06lyFB77rMjZE901TPHVR6Fv8Y9ty1d+pITJi1zCNDr6922jTY89ibh9ngAHEi7e1DtgdtKn9mpC+LFbtXzeeIHfO6GONWQmprre7wUfGVLZ2Ypwnt0D/nG8I5XY89cdY8fZ7M028r9XJstBtkH+YZbgw+qp0C2W0nQFBKt+KQranliuDVJHxz6OajGYFrjSnZzl3E6iSHBmhgPWYmH+AGsofIkPjHzHosyEAsVP1E5M36FOO6LAxHJOiA2xFCfZ6dA6Ns9I4RSm2FmGGMSRELxWQvIzyu9i4wF0+G6gYd/fK+Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199024)(1800799009)(186009)(66946007)(66556008)(66476007)(6916009)(478600001)(38100700002)(38350700002)(316002)(2906002)(41300700001)(86362001)(8936002)(8676002)(4326008)(5660300002)(44832011)(6506007)(6512007)(6666004)(6486002)(52116002)(55236004)(2616005)(26005)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p1bzOA8DeSQ1R+rcaVUeih1Om9ztiwQp3KA7ZWAweDRme9YYLX+KZqihpNyS?=
 =?us-ascii?Q?g2oOjKBlHZ1758u17h/wolEEBjnEdmjHZlWpsm2P42blB6vR32CfCSzMLkJ3?=
 =?us-ascii?Q?tMzVssNYyS4t6nghbsyguKdThBFK+ibn0GewIfGJtIc2WV5FHOFouYOG1PSA?=
 =?us-ascii?Q?kxtnX+aE5LwBZqniw/VjwSHcL7/kp8F++YVxRhj2fj9IGmTYNG+x/m5zHWAy?=
 =?us-ascii?Q?pNJLKgW1/qUEQFBXZ4mkhjYa/74I5uRto3OqdpIevzBKNy/M05QwN7Lq4D5e?=
 =?us-ascii?Q?aieiUFy01Ho/kzdTYYbcfjVs4hUYFhUZCNMfdksND2k/Rudq93s6vdzpPf66?=
 =?us-ascii?Q?cEfsuaUSsObfIyb2Ay76dXw60N6zzmZwafcD6tegVIt2vI5hrwbFUNjSMjs6?=
 =?us-ascii?Q?pmGP8QsO54Wf8nAJOlO4TRdM+qQHi5EwLn0pLS06y3HvmUG4iDgu4yHE19Dr?=
 =?us-ascii?Q?U3+C/a4tC4OFywPT1E1j2I5Wqeo3Iao1xqOLLO2DdGRCAXbv2fC7QArAnKRi?=
 =?us-ascii?Q?izIiyOudvrSglOADHxqyZN5ojD1slnaZLQRRg94l6ZV72vNwTNiaSvolutxA?=
 =?us-ascii?Q?N4qfh0Q5OX6h4oLe2WTvb2QHuSGGuNiO3kvPYwRmDMrUUBfRbhgLtY/TWFYl?=
 =?us-ascii?Q?usqPUrguNBYQ5GSoOxO5T6oGjIzoBRtgaoYVc9OLNetj89Wd7f5fNNOqwySa?=
 =?us-ascii?Q?CX60Q6AD1MiMhp+ONMMtuHHJaJqYIGflsqUS3x1Woh4fIy7ML4ViBqKhZ/e4?=
 =?us-ascii?Q?5yJQPSM3HCA0UzKGYNnwHZeqUbcoJlIb+qthS/TATKCFkf08y/G1wco85hL0?=
 =?us-ascii?Q?XCTWJHeX35PHq+zqrWy1bOoTAdFxR2Cl4NR5Il/qyqt0kQ2brKJ3XW7biADC?=
 =?us-ascii?Q?B2nEhmpHu/mF+bsKFNcDItvRXKA7BrcP/noBRc6XtMd6izp1jEvFzmM53ZDc?=
 =?us-ascii?Q?pq49d95gXTZ3hToNIJTP/FFWIecEdG/qDHPIKoMAYunJLgQzb+s2fyAYm0yC?=
 =?us-ascii?Q?oSnH6rM0dcDnBICHjiQTYBWehjMJ9PFPQppHUtMgK8c3KHmnUNXW3G5Nkn6y?=
 =?us-ascii?Q?nXgcMItxI6Z/bl9Ul/IGmk24m4NNdOTBDFinR5tX8Ga9IJ5rAnAJPY0wLhNb?=
 =?us-ascii?Q?jsjPXtp2lZ/DHMnPxnUFo061JcuLhsZBtsVWIDyXQ+zYVUARR1uDRhQ0YxNK?=
 =?us-ascii?Q?YbNqq9fM9JYbVQWlVei0X2TTpIIJbdSsmjy7/YTVogNmLeJEIKtAsW8R6jI/?=
 =?us-ascii?Q?Bt2mawGT29YurGlUOf3viPt+uMLuFCxnX2PMW0kyoukG8nJToChQOEntwFkq?=
 =?us-ascii?Q?QyhS2LWaCZHhBPNe/qeqYKJKOtek+/diLX5NNBLIWukXxz1eWp0a+Xw3k14J?=
 =?us-ascii?Q?Yb4fCjId/8BRUdpRZ3gBmjJTkVft2eqn/+4fXLKycLZ1bQJLtNyH7uq7gFIz?=
 =?us-ascii?Q?T0aGv85clwDzWd1JO+6oZ053l2E8rwUJ6ctwlLANS9XrTo/qP0aUecCaTlRK?=
 =?us-ascii?Q?p2e9Pyb5GfyO0t6aARvUYuAb9iT74dg2VJQlClAlMm7z7Yl3TwNTcPnRqZuG?=
 =?us-ascii?Q?pL5WXULb5ftznxFYJX2nZY2W7G27IoWiN5LQA3Tj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95963ddf-4da9-4b23-7220-08dbaddf191b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 07:09:51.6450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNnL8mvXwowX4s4hrq0alHu3OJCuUkj+dKTqPSConFwccM7C8P/9vRjPBn1cEK0ti9jQ9TWdyH8lGkqpNJZzrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8058
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

MICP profile level interface function have been implemented
This adds initial code for MICP plugin.

Co-developed-by: Mahesh Talewad <mahesh.talewad@nxp.com>
Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
Signed-off-by: Nitin Jadhav <nitin.jadhav@nxp.com>
---
 Makefile.plugins      |   5 +
 configure.ac          |   4 +
 profiles/audio/micp.c | 340 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 349 insertions(+)
 create mode 100644 profiles/audio/micp.c

diff --git a/Makefile.plugins b/Makefile.plugins
index fc19522e4..5880ed0df 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -137,6 +137,11 @@ builtin_modules += vcp
 builtin_sources += profiles/audio/vcp.c
 endif
 
+if MICP
+builtin_modules += micp
+builtin_sources += profiles/audio/micp.c
+endif
+
 if CSIP
 builtin_modules += csip
 builtin_sources += profiles/audio/csip.c
diff --git a/configure.ac b/configure.ac
index bc7edfcd3..9a8856380 100644
--- a/configure.ac
+++ b/configure.ac
@@ -211,6 +211,10 @@ AC_ARG_ENABLE(vcp, AS_HELP_STRING([--disable-vcp],
 		[disable VCP profile]), [enable_vcp=${enableval}])
 AM_CONDITIONAL(VCP, test "${enable_vcp}" != "no")
 
+AC_ARG_ENABLE(micp, AS_HELP_STRING([--disable-micp],
+		[disable MICP profile]), [enable_micp=${enableval}])
+AM_CONDITIONAL(MICP, test "${enable_micp}" != "no")
+
 AC_ARG_ENABLE(csip, AS_HELP_STRING([--disable-csip],
 		[disable CSIP profile]), [enable_csip=${enableval}])
 AM_CONDITIONAL(CSIP, test "${enable_csip}" != "no")
diff --git a/profiles/audio/micp.c b/profiles/audio/micp.c
new file mode 100644
index 000000000..452027c75
--- /dev/null
+++ b/profiles/audio/micp.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2023  NXP Semiconductors. All rights reserved.
+ *
+ *
+ */
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define	_GNU_SOURCE
+
+#include <ctype.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "gdbus/gdbus.h"
+
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
+#include "lib/sdp.h"
+#include "lib/uuid.h"
+
+#include "src/dbus-common.h"
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/micp.h"
+
+#include "btio/btio.h"
+#include "src/plugin.h"
+#include "src/adapter.h"
+#include "src/gatt-database.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/log.h"
+#include "src/error.h"
+
+#define MICS_UUID_STR	"0000184D-0000-1000-8000-00805f9b34fb"
+
+struct micp_data {
+	struct btd_device *device;
+	struct btd_service *service;
+	struct bt_micp *micp;
+	unsigned int ready_id;
+};
+
+static struct queue *sessions;
+
+static void micp_debug(const char *str, void *user_data)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
+static int micp_disconnect(struct btd_service *service)
+{
+	return 0;
+}
+
+static struct micp_data *micp_data_new(struct btd_device *device)
+{
+	struct micp_data *data;
+
+	data = new0(struct micp_data, 1);
+	g_assert(data);
+	data->device = device;
+
+	return data;
+}
+
+static void micp_data_add(struct micp_data *data)
+{
+	DBG("data %p", data);
+
+	if (queue_find(sessions, NULL, data)) {
+		error("data %p allready added", data);
+		return;
+	}
+
+	bt_micp_set_debug(data->micp, micp_debug, NULL, NULL);
+
+	if (!sessions)
+		sessions = queue_new();
+
+	queue_push_tail(sessions, data);
+
+	if (data->service)
+		btd_service_set_user_data(data->service, data);
+}
+
+static bool match_data(const void *data, const void *match_data)
+{
+	const struct micp_data *mdata = data;
+	const struct bt_micp *micp = match_data;
+
+	return mdata->micp == micp;
+}
+
+static void micp_data_free(struct micp_data *data)
+{
+	if (data->service) {
+		btd_service_set_user_data(data->service, NULL);
+		bt_micp_set_user_data(data->micp, NULL);
+	}
+
+	bt_micp_ready_unregister(data->micp, data->ready_id);
+	bt_micp_unref(data->micp);
+	free(data);
+}
+
+static void micp_data_remove(struct micp_data *data)
+{
+	DBG("data %p", data);
+
+	if (!queue_remove(sessions, data))
+		return;
+
+	micp_data_free(data);
+
+	if (queue_isempty(sessions)) {
+		queue_destroy(sessions, NULL);
+		sessions = NULL;
+	}
+}
+
+static void micp_detached(struct bt_micp *micp, void *user_data)
+{
+	struct micp_data *data;
+
+	DBG("%p", micp);
+
+	data = queue_find(sessions, match_data, micp);
+	if (!data) {
+		error("unable to find sessio");
+		return;
+	}
+
+	micp_data_remove(data);
+}
+
+static void micp_ready(struct bt_micp *micp, void *user_data)
+{
+	DBG("micp %p\n", micp);
+}
+
+static void micp_attached(struct bt_micp *micp, void *user_data)
+{
+	struct micp_data *data;
+	struct bt_att *att;
+	struct btd_device *device;
+
+	DBG("%p", micp);
+
+	data = queue_find(sessions, match_data, micp);
+	if (data)
+		return;
+
+	att = bt_micp_get_att(micp);
+	if (!att)
+		return;
+
+	device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
+	if (!device) {
+		error("unable to find device");
+		return;
+	}
+
+	data = micp_data_new(device);
+	g_assert(data);
+	data->micp = micp;
+
+	micp_data_add(data);
+}
+
+static int micp_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct micp_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	/*Ignore, if we probed for this device allready */
+	if (data) {
+		error("Profile probed twice for this device");
+		return -EINVAL;
+	}
+
+	data = micp_data_new(device);
+	data->service = service;
+
+	data->micp = bt_micp_new(btd_gatt_database_get_db(database),
+					btd_device_get_gatt_db(device));
+
+	if (!data->micp) {
+		error("unable to create MICP instance");
+		free(data);
+		return -EINVAL;
+	}
+
+	micp_data_add(data);
+
+	data->ready_id = bt_micp_ready_register(data->micp, micp_ready, service,
+								NULL);
+
+	bt_micp_set_user_data(data->micp, service);
+
+	return 0;
+}
+
+static void micp_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct micp_data *data;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	data = btd_service_get_user_data(service);
+	if (!data) {
+		error("MICP Service not handled by profile");
+		return;
+	}
+
+	micp_data_remove(data);
+}
+
+static int micp_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct micp_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	if (!data) {
+		error("MICP Service not handled by profile");
+		return -EINVAL;
+	}
+
+	if (!bt_micp_attach(data->micp, client)) {
+		error("MICP unable to attach");
+		return -EINVAL;
+	}
+
+	btd_service_connecting_complete(service, 0);
+
+	return 0;
+}
+
+static int micp_connect(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	return 0;
+}
+
+static int micp_server_probe(struct btd_profile *p,
+				struct btd_adapter *adapter)
+{
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+
+	DBG("MICP path %s", adapter_get_path(adapter));
+
+	bt_micp_add_db(btd_gatt_database_get_db(database));
+
+	return 0;
+}
+
+static void micp_server_remove(struct btd_profile *p,
+					struct btd_adapter *adapter)
+{
+	DBG("MICP remove adapter");
+}
+
+static struct btd_profile micp_profile = {
+	.name		= "micp",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.remote_uuid	= MICS_UUID_STR,
+
+	.device_probe	= micp_probe,
+	.device_remove	= micp_remove,
+
+	.accept	= micp_accept,
+	.connect	= micp_connect,
+	.disconnect	= micp_disconnect,
+
+	.adapter_probe	= micp_server_probe,
+	.adapter_remove = micp_server_remove,
+};
+
+static unsigned int micp_id;
+
+static int micp_init(void)
+{
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+		warn("D-Bus experimental not enabled");
+		return -ENOTSUP;
+	}
+
+	btd_profile_register(&micp_profile);
+	micp_id = bt_micp_register(micp_attached, micp_detached, NULL);
+
+	return 0;
+}
+
+static void micp_exit(void)
+{
+	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
+		btd_profile_unregister(&micp_profile);
+		bt_micp_unregister(micp_id);
+	}
+}
+
+BLUETOOTH_PLUGIN_DEFINE(micp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							micp_init, micp_exit)
-- 
2.34.1

