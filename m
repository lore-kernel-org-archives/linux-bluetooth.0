Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDB3C001DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Aug 2023 07:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjHCHU7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 03:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjHCHU5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 03:20:57 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8252D65
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 00:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXXaayays8UauDzQu24OQZaTVsQm3VB/fT1vaTJiiDcftwtfNNhAvH9zhTtwRgr0gPA8p1LEanOOpctM/1SXEa91+2Fa4M1W8Q9H4mYOhBm5IGvT6RQMGdNkMDLyAyZKCZc0WAqOGFEC1PbO0CDaCLIBYBXvELa8Mso9+6tOkdHs5yvfUWyJc42wSCMLSYkoksJLS+wxRqrhh3SLAIm5eGTL99PfemaUyBZrygUKzj6xWyX0f26faMFiHwgfdYj1xEVHbd+gbpAV1D/2zflP275tho/mOHgeR2qMaETPQu7QVkB7614riRZPppfgCHy2AktLW83ov2mfK/z4Y+aUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cC+ZWpJOH2ZNglVKIi6ZvwW5b8+/4otqVlALsLy2hk=;
 b=MPJSNbvyKd5n1dxmyHsiATukThBohhWmnbWlfqPd3l9Emjp6DB1sAAzTxWJYPu8fUa7nlhkY+YS1xsVqyuryZ5WCSpJRqiYyddiIVVtmP4Y2T3wUG4Q1i5vvW4MFfK8F3ZodHS3mlU99u3y+pgqWHiTiFcTRdeYaJYpwl77fXi0+ORVmoddJs+5EvKeGgGDjT6Dni2lJmirQoKfabE9v+SHPGDZMCQU72Drs4+2n+++UoUXgYutm0nc++b2zU/9mEqAIzWoI8fqnsOw2kXXk26BH6+hs3ZQl6MA7fdCUm/h88ywbSuYv2tlXFj/sDi5y45vZpeAO3wwOqpniny8sNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cC+ZWpJOH2ZNglVKIi6ZvwW5b8+/4otqVlALsLy2hk=;
 b=LJCDQfAYFtzchaTMFxVkPRhWjCIiLlf+7jFpYYTa6cmOVXH3HoUl3bMWznig0QIbijcEBJBGLuVp/jrvspNVClfFi3txuQpBfSTuqpl0kD67mu9xFQ0b5d7skoq3EAaJF1XMJssIsMylIo/3gAVvfG/A22bQbqCpq0yVntvZ1uc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6991.eurprd04.prod.outlook.com (2603:10a6:803:12d::13)
 by DU0PR04MB9418.eurprd04.prod.outlook.com (2603:10a6:10:359::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 07:20:50 +0000
Received: from VI1PR04MB6991.eurprd04.prod.outlook.com
 ([fe80::4299:5db1:461:bc17]) by VI1PR04MB6991.eurprd04.prod.outlook.com
 ([fe80::4299:5db1:461:bc17%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 07:20:50 +0000
From:   Mahesh Talewad <mahesh.talewad@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, devyani.godbole@nxp.com,
        nitin.jadhav@nxp.com, mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v1 1/3] shared/micp: Add initial code for handling micp and mics
Date:   Thu,  3 Aug 2023 10:20:09 +0300
Message-Id: <20230803072011.191449-2-mahesh.talewad@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 54d0dfaf-4840-4e33-bf7b-08db93f22a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHXPCmRRBKKFs0oXWfGiCSXuwSplSJTlP22LemDYvLbkwXCQHqu3hK4rATHY+YmefXtCGbelBnT4hFWHHj2tIwRv7g0T2YeS91GYq2Cr1dgmMR85MTCVwEpfkO0Ow/TV1U+zL/ORVFPx+q/sPfAzJt42bICR9JnMYGNIK8VMiwLD9wn9Esn90Q2yHmd1XB4vjm2zAZiNFydwy04AfGufXZWCEDCCig5haquZZWISmgf8tkc8vcFgV3ErI+kZWiswsYWAexRr9h/osmnsUMW3s7WhgL0DteXTSSVtYSX7g5WjOpzafCjsMKInnJ7eZXpiJo94uWTNParbq8ESR1DXF5HuovJPDN7fu5+uXsAbMBt8U0PKZsez7Q3K3ERHdyLHLH51u76NL/lA7Ri4NUTNUnckb0FQb2qcRXLkyNt9nRfqKtAz4YutO3FriyJYkDJ0chsQuToHwqvgRYmVIJfojZMGvWpsRFOFNqNg9Bg/c8G82MA+HjyVqEmQ6jTaz0sWUQJYmYaxzG635e1n/I+8KkBooRC0ZDTb6rOBJHIKShKtxzGvCgAr3TONmU8B/M+K301/KEjRvwKGqmTh5932q57x+p7Ca9jyvDCinDly4LTpwja7pyDf2JjKxDYIOhc5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6991.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(36756003)(86362001)(52116002)(478600001)(38100700002)(38350700002)(2616005)(1076003)(186003)(26005)(83380400001)(6506007)(55236004)(41300700001)(8676002)(8936002)(44832011)(6512007)(6666004)(6486002)(30864003)(316002)(66476007)(66556008)(5660300002)(6916009)(4326008)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lJ1y99k88zFDnoxLR4w1YXLz1rmfDNKQGSS6V78m3WaDpZ6d5QTweh4bww+s?=
 =?us-ascii?Q?Kr84vqvy3oIVGPBeO/CzxGYMJ3JkPU2R2E1gFtu0nQDy5/dGvbeDkicasBvR?=
 =?us-ascii?Q?kvBFMr87lmlzyjcr4lFYxsOASoC25yhj05OdSnz2RAEJePvITzVo5IA1szrG?=
 =?us-ascii?Q?j28Hmrm+9B1/eyPq0XhDYDiYNi2opYziH4kXMY8W9wzMCqXmV07K5b1WkdUR?=
 =?us-ascii?Q?1Kn5ZhGjikfbULphENxB1YutfRv0ngdXiSOX4G0j24+A0GUTwz8E/QnE4gH5?=
 =?us-ascii?Q?nBTacpGHSqcWNOJqN2g+0tJJWmsTIpPVckjKf78ZAwxJleQI1v63EhbHmJR8?=
 =?us-ascii?Q?DV0aOter8eqir6dmCTOspK5aeenzuT3uaEcrsMtotZobLW/24LOrfSMfGWy1?=
 =?us-ascii?Q?yi/KwzjCBLRss3JUkRVmaV6B+jNLE9PRA5XK15T3b0DJcvc2gs5s2f3YuGs0?=
 =?us-ascii?Q?oGzAC7wuL2OuKU6147umpcZwepUGSvXdCuFXSSillh7IJuEn0LxDhpAagUmu?=
 =?us-ascii?Q?Y1OnXbHDvE2L9o9UwKtJ/1Ds+WebzXYKNaEDtQGqwrDwkiLn9d5my0VWfJ4T?=
 =?us-ascii?Q?MqNyy6Pp5Qh5Mnf4zcKXDyNJGdDz4qcIi/16lCdcgAC/GdAxGrnYWH5hdeTn?=
 =?us-ascii?Q?kxjV0MyBBR4gPY3vLQVpunbgtOsL0ebK8ve+lmGxQ2wfGF/FZtZk19V6vlbG?=
 =?us-ascii?Q?H6Ib+8YJE6BR9tuoC3zb8QxqxjGtw2L51EGIRAKwN2oRTrg+I1lAxyOg6BU2?=
 =?us-ascii?Q?2ce88YedUIGx/DbY/Ztk+aGBRWi1MYnQ+345WUMLu+dyg+ns3LM5XjRZys6F?=
 =?us-ascii?Q?hA+i+IofCS/5v4PhV2SpCSsCXZdO8TpUF0PQb+dEkG3c3KqL2q+FinUUAGXr?=
 =?us-ascii?Q?JP+BkYibDj/bTXITsHVka7cYidSZUE90ikoNzDMNxYtp1LeSWx24HbsMfpLj?=
 =?us-ascii?Q?CyDgKGVCyzGG167Q8l0zSi5q/Lb1Scm9jFP2+VRzZZJsFC4t6MDyvp+f9rQW?=
 =?us-ascii?Q?SV0YoIWJQ/6zgRF3qCR6BGuLYpIHRRiWBv5na2LRvFxMelM17lMsqFM+mAuA?=
 =?us-ascii?Q?89ok7GkTysoSSZn4tU8PLX+Ec7fmyzOgXwFaeAUEu2l8SZ/AxaKUEy1sM+ya?=
 =?us-ascii?Q?wEvOQS/WKNNLBKVRuwRFd4GXAmfnsdQ2nYt7v+W91OgqToUHnGkAS++LUkv2?=
 =?us-ascii?Q?l4fZE6LRxpdNozSnlCSJ8YgyTf+uKQ61+lfolbYnYfgBIxEylqeURLK/7gos?=
 =?us-ascii?Q?UVmnhz/JuD+IOhGCrPs8YhcQCuWx0Qdk9fi874r4OdFLbicgnlUFcujQXMEo?=
 =?us-ascii?Q?YQyXRNmol9Gc5Jv5b+5FhzTsmAqrpCaa6R6MjHvXSaySsz90Q4ng9L8sAdyr?=
 =?us-ascii?Q?GHBxYBdBq7RXEuqf5e72y6JJGBbBlUyjcqqn5LmDsOm+wXa3FvaiC+PTs4Ed?=
 =?us-ascii?Q?GFs2OGNCwK7KV584nxx4GIC2vAAhB2u76BG0gN//1fDafZYV47b0TsjevRRb?=
 =?us-ascii?Q?F6G4OIoTK+nAPGhLH184ZX+poLmxVLVa5bfgxD1Z3TVnDaFSdY8Wp7lvnXHW?=
 =?us-ascii?Q?4wVXR/2VRwzxQ/55c0pFjSFlIuTnEJNCB5g3+Byu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d0dfaf-4840-4e33-bf7b-08db93f22a20
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6991.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 07:20:50.3905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeOJTvbf8ltJxBo2uPIdBLVZ3kpoIl6U1gTPY7uleM6ZBJyfJt5gB8paWPrNcTyn6nRXs5sSqu3y5HR+3gJYmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9418
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

- This commit is for implementations of MICS and MICP
- Specifications referred for implementation:
MICS - MICS_v1.0.pdf
MICP - MICP_v1.0.pdf
---
 Makefile.am           |   1 +
 Makefile.plugins      |   5 +
 configure.ac          |   4 +
 lib/uuid.h            |   4 +
 profiles/audio/micp.c | 340 ++++++++++++++++
 src/shared/micp.c     | 922 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/micp.h     |  46 +++
 7 files changed, 1322 insertions(+)
 create mode 100644 profiles/audio/micp.c
 create mode 100644 src/shared/micp.c
 create mode 100644 src/shared/micp.h

diff --git a/Makefile.am b/Makefile.am
index 4b9b7e5cd..6f40f2a74 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -233,6 +233,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/bap.h src/shared/bap.c src/shared/ascs.h \
 			src/shared/mcs.h src/shared/mcp.h src/shared/mcp.c \
 			src/shared/vcp.c src/shared/vcp.h \
+			src/shared/micp.c src/shared/micp.h \
 			src/shared/csip.c src/shared/csip.h \
 			src/shared/bass.h src/shared/bass.c \
 			src/shared/lc3.h src/shared/tty.h
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
diff --git a/lib/uuid.h b/lib/uuid.h
index cd3b3655f..6661a537f 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -206,6 +206,10 @@ extern "C" {
 #define CS_LOCK						0x2B86
 #define CS_RANK						0x2B87
 
+/* Microphone Control Service(MICS) */
+#define MICS_UUID			0x184D
+#define MUTE_CHRC_UUID		0x2BC3
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
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
diff --git a/src/shared/micp.c b/src/shared/micp.c
new file mode 100644
index 000000000..25ffa6940
--- /dev/null
+++ b/src/shared/micp.c
@@ -0,0 +1,922 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2023  NXP Semiconductors. All rights reserved.
+ *
+ */
+#define _GNU_SOURCE
+#include <inttypes.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+#include "src/shared/timeout.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/gatt-helpers.h"
+#include "src/shared/micp.h"
+
+#define DBG(_micp, fmt, arg...) \
+	micp_debug(_micp, "%s:%s() " fmt, __FILE__, __func__, ##arg)
+
+/* Application error codes */
+#define MICP_ERROR_MUTE_DISABLED            0x80
+#define MICP_ERROR_VALUE_NOT_ALLOWED        0x13
+#define BT_ATT_ERROR_OPCODE_NOT_SUPPORTED   0x81
+
+/* Mute char values */
+#define MICS_NOT_MUTED  0x00
+#define MICS_MUTED      0x01
+#define MICS_DISABLED   0x02
+
+struct bt_micp_db {
+	struct gatt_db *db;
+	struct bt_mics *mics;
+};
+
+struct bt_mics {
+	struct bt_micp_db *mdb;
+	uint8_t mute_stat;
+	struct gatt_db_attribute *service;
+	struct gatt_db_attribute *ms;
+	struct gatt_db_attribute *ms_ccc;
+};
+
+struct bt_micp {
+	int ref_count;
+	struct bt_micp_db *ldb;
+	struct bt_micp_db *rdb;
+	struct bt_gatt_client *client;
+	struct bt_att *att;
+	unsigned int mute_id;
+
+	unsigned int idle_id;
+	uint8_t mute;
+
+	struct queue *notify;
+	struct queue *pending;
+	struct queue *ready_cbs;
+
+	bt_micp_debug_func_t debug_func;
+	bt_micp_destroy_func_t debug_destroy;
+
+	void *debug_data;
+	void *user_data;
+};
+
+static struct queue *micp_db;
+static struct queue *micp_cbs;
+static struct queue *sessions;
+
+struct bt_micp_cb {
+	unsigned int id;
+	bt_micp_func_t attached;
+	bt_micp_func_t detached;
+	void *user_data;
+};
+
+typedef void (*micp_func_t)(struct bt_micp *micp, bool success,
+				uint8_t att_ecode, const uint8_t *value,
+				uint16_t length, void *user_data);
+
+struct bt_micp_pending {
+	unsigned int id;
+	struct bt_micp *micp;
+	micp_func_t func;
+	void *userdata;
+};
+
+struct bt_micp_ready {
+	unsigned int id;
+	bt_micp_ready_func_t func;
+	bt_micp_destroy_func_t destroy;
+	void *data;
+};
+
+typedef void (*micp_notify_t)(struct bt_micp *micp, uint16_t value_handle,
+				const uint8_t *value, uint16_t length,
+				void *user_data);
+
+struct bt_micp_notify {
+	unsigned int id;
+	struct bt_micp *micp;
+	micp_notify_t func;
+	void *user_data;
+};
+
+static void *iov_pull_mem(struct iovec *iov, size_t len)
+{
+	void *data = iov->iov_base;
+
+	if (iov->iov_len < len)
+		return NULL;
+
+	iov->iov_base += len;
+	iov->iov_len -= len;
+
+	return data;
+}
+
+static struct bt_micp_db *micp_get_mdb(struct bt_micp *micp)
+{
+	if (!micp)
+		return NULL;
+
+	if (micp->ldb)
+		return micp->ldb;
+
+	return NULL;
+}
+
+static uint8_t *mdb_get_mute_state(struct bt_micp_db *vdb)
+{
+	if (!vdb->mics)
+		return NULL;
+
+	return &(vdb->mics->mute_stat);
+}
+
+static struct bt_mics *micp_get_mics(struct bt_micp *micp)
+{
+	if (!micp)
+		return NULL;
+
+	if (micp->rdb->mics)
+		return micp->rdb->mics;
+
+	micp->rdb->mics = new0(struct bt_mics, 1);
+	micp->rdb->mics->mdb = micp->rdb;
+
+	return micp->rdb->mics;
+}
+
+static void micp_detached(void *data, void *user_data)
+{
+	struct bt_micp_cb *cb = data;
+	struct bt_micp *micp = user_data;
+
+	cb->detached(micp, cb->user_data);
+}
+
+void bt_micp_detach(struct bt_micp *micp)
+{
+	if (!queue_remove(sessions, micp))
+		return;
+
+	bt_gatt_client_unref(micp->client);
+	micp->client = NULL;
+
+	queue_foreach(micp_cbs, micp_detached, micp);
+}
+
+static void micp_db_free(void *data)
+{
+	struct bt_micp_db *mdb = data;
+
+	if (!mdb)
+		return;
+
+	gatt_db_unref(mdb->db);
+
+	free(mdb->mics);
+	free(mdb);
+}
+
+static void micp_ready_free(void *data)
+{
+	struct bt_micp_ready *ready = data;
+
+	if (ready->destroy)
+		ready->destroy(ready->data);
+
+	free(ready);
+}
+
+static void micp_free(void *data)
+{
+	struct bt_micp *micp = data;
+
+	bt_micp_detach(micp);
+
+	micp_db_free(micp->rdb);
+
+	queue_destroy(micp->pending, NULL);
+	queue_destroy(micp->ready_cbs, micp_ready_free);
+
+	free(micp);
+}
+
+bool bt_micp_set_user_data(struct bt_micp *micp, void *user_data)
+{
+
+	if (!micp)
+		return false;
+
+	micp->user_data = user_data;
+
+	return true;
+}
+
+static bool micp_db_match(const void *data, const void *match_data)
+{
+	const struct bt_micp_db *mdb = data;
+	const struct gatt_db *db = match_data;
+
+	return (mdb->db == db);
+}
+
+struct bt_att *bt_micp_get_att(struct bt_micp *micp)
+{
+	if (!micp)
+		return NULL;
+
+	if (micp->att)
+		return micp->att;
+
+	return bt_gatt_client_get_att(micp->client);
+}
+
+struct bt_micp *bt_micp_ref(struct bt_micp *micp)
+{
+	if (!micp)
+		return NULL;
+
+	__sync_fetch_and_add(&micp->ref_count, 1);
+
+	return micp;
+}
+
+void bt_micp_unref(struct bt_micp *micp)
+{
+	if (!micp)
+		return;
+
+	if (__sync_sub_and_fetch(&micp->ref_count, 1))
+		return;
+
+	micp_free(micp);
+}
+
+static void micp_debug(struct bt_micp *micp, const char *format, ...)
+{
+	va_list ap;
+
+	if (!micp || !format || !micp->debug_func)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(micp->debug_func, micp->debug_data, format, ap);
+	va_end(ap);
+}
+
+static void micp_disconnected(int err, void *user_data)
+{
+	struct bt_micp *micp = user_data;
+
+	DBG(micp, "micp %p disconnected err %d", micp, err);
+
+	bt_micp_detach(micp);
+}
+
+static struct bt_micp *micp_get_session(struct bt_att *att, struct gatt_db *db)
+{
+	const struct queue_entry *entry;
+	struct bt_micp *micp;
+
+	for (entry = queue_get_entries(sessions); entry; entry = entry->next) {
+		struct bt_micp *micp = entry->data;
+
+		if (att == bt_micp_get_att(micp))
+			return micp;
+	}
+
+	micp = bt_micp_new(db, NULL);
+	micp->att = att;
+
+	bt_att_register_disconnect(att, micp_disconnected, micp, NULL);
+
+	bt_micp_attach(micp, NULL);
+
+	return micp;
+}
+
+static void mics_mute_read(struct gatt_db_attribute *attrib,
+			unsigned int id, uint16_t offset,
+			uint8_t opcode, struct bt_att *att,
+			void *user_data)
+{
+	struct bt_mics *mics = user_data;
+	struct iovec iov;
+
+	iov.iov_base = &mics->mute_stat;
+	iov.iov_len = sizeof(mics->mute_stat);
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
+								  iov.iov_len);
+}
+
+static uint8_t mics_not_muted(struct bt_mics *mics, struct bt_micp *micp,
+							  struct iovec *iov)
+{
+	struct bt_micp_db *mdb;
+	uint8_t *mute_state;
+
+	DBG(micp, "Mute state OP: Not Muted");
+
+	mdb = micp_get_mdb(micp);
+	if (!mdb) {
+		DBG(micp, "error: MDB not available");
+		return 0;
+	}
+
+	mute_state = mdb_get_mute_state(mdb);
+	if (!mute_state) {
+		DBG(micp, "Error : Mute State not available");
+		return 0;
+	}
+
+	*mute_state = MICS_NOT_MUTED;
+
+	gatt_db_attribute_notify(mdb->mics->ms, (void *)mute_state,
+				sizeof(uint8_t), bt_micp_get_att(micp));
+
+	return 0;
+}
+
+static uint8_t mics_muted(struct bt_mics *mics, struct bt_micp *micp,
+						  struct iovec *iov)
+{
+	struct bt_micp_db *mdb;
+	uint8_t *mute_state;
+
+	DBG(micp, "Mute state OP: Muted");
+
+	mdb = micp_get_mdb(micp);
+	if (!mdb) {
+		DBG(micp, "error: MDB not available");
+		return 0;
+	}
+
+	mute_state = mdb_get_mute_state(mdb);
+
+	*mute_state = MICS_MUTED;
+
+	gatt_db_attribute_notify(mdb->mics->ms, (void *)mute_state,
+				sizeof(uint8_t), bt_micp_get_att(micp));
+
+	return 0;
+}
+
+#define MICS_OP(_str, _op, _size, _func) \
+	{                                    \
+		.str = _str,                     \
+		.op = _op,                       \
+		.size = _size,                   \
+		.func = _func,                   \
+	}
+
+struct mics_op_handler {
+	const char *str;
+	uint8_t op;
+	size_t size;
+	uint8_t (*func)(struct bt_mics *mics, struct bt_micp *micp,
+					struct iovec *iov);
+} micp_handlers[] = {
+	MICS_OP("Not Muted", MICS_NOT_MUTED,
+			sizeof(uint8_t), mics_not_muted),
+	MICS_OP("Muted", MICS_MUTED,
+			sizeof(uint8_t), mics_muted),
+	{}};
+
+static void mics_mute_write(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct bt_mics *mics = user_data;
+	struct bt_micp *micp = micp_get_session(att, mics->mdb->db);
+	struct iovec iov = {
+		.iov_base = (void *)value,
+		.iov_len = len,
+	};
+	uint8_t *micp_op, *mute_state;
+	struct mics_op_handler *handler;
+	uint8_t ret = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+	struct bt_micp_db *mdb;
+
+	DBG(micp, "MICS Mute Char write: len: %ld: %ld", len, iov.iov_len);
+
+	if (offset) {
+		DBG(micp, "invalid offset: %d", offset);
+		ret = BT_ATT_ERROR_INVALID_OFFSET;
+		goto respond;
+	}
+
+	if (len < sizeof(*micp_op)) {
+		DBG(micp, "invalid length: %ld < %ld sizeof(param)", len,
+			sizeof(*micp_op));
+		ret = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+		goto respond;
+	}
+
+	micp_op = iov_pull_mem(&iov, sizeof(*micp_op));
+
+	if ((*micp_op == MICS_DISABLED) || (*micp_op != MICS_NOT_MUTED
+		&& *micp_op != MICS_MUTED)) {
+		DBG(micp, "Invalid operation - MICS DISABLED/RFU mics op:%d",
+					micp_op);
+		ret = MICP_ERROR_VALUE_NOT_ALLOWED;
+		goto respond;
+	}
+
+	mdb = micp_get_mdb(micp);
+	if (!mdb) {
+		DBG(micp, "error: MDB not available");
+		goto respond;
+	}
+
+	mute_state = mdb_get_mute_state(mdb);
+	if (*mute_state == MICS_DISABLED) {
+		DBG(micp, "state: MICS DISABLED , can not write value: %d",
+				*micp_op);
+		ret = MICP_ERROR_MUTE_DISABLED;
+		goto respond;
+	}
+
+	for (handler = micp_handlers; handler && handler->str; handler++) {
+		DBG(micp, "handler->op: %d micp_op: %d iov.iov_len: %ld",
+					handler->op, *micp_op, iov.iov_len);
+		if (handler->op != *micp_op)
+			continue;
+
+		if (len < handler->size) {
+			DBG(micp, "invalid len %ld : %ld < %ld handler->size",
+			len, iov.iov_len, handler->size);
+			ret = BT_ATT_ERROR_OPCODE_NOT_SUPPORTED;
+			goto respond;
+		}
+
+		break;
+	}
+
+	if (handler && handler->str) {
+		DBG(micp, "%s", handler->str);
+
+		ret = handler->func(mics, micp, &iov);
+	} else {
+		DBG(micp, "unknown opcode 0x%02x", *micp_op);
+		ret = BT_ATT_ERROR_OPCODE_NOT_SUPPORTED;
+	}
+
+respond:
+	gatt_db_attribute_write_result(attrib, id, ret);
+}
+
+static struct bt_mics *mics_new(struct gatt_db *db)
+{
+	struct bt_mics *mics;
+	bt_uuid_t uuid;
+
+	if (!db)
+		return NULL;
+
+	mics = new0(struct bt_mics, 1);
+
+	mics->mute_stat = MICS_MUTED;
+
+	/* Populate DB with MICS attributes */
+	bt_uuid16_create(&uuid, MICS_UUID);
+	mics->service = gatt_db_add_service(db, &uuid, true, 4);
+
+	bt_uuid16_create(&uuid, MUTE_CHRC_UUID);
+	mics->ms = gatt_db_service_add_characteristic(mics->service,
+				&uuid,
+				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+				BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_WRITE
+				| BT_GATT_CHRC_PROP_NOTIFY,
+				mics_mute_read, mics_mute_write,
+				mics);
+
+	mics->ms_ccc = gatt_db_service_add_ccc(mics->service,
+				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	gatt_db_service_set_active(mics->service, true);
+
+	return mics;
+}
+
+static struct bt_micp_db *micp_db_new(struct gatt_db *db)
+{
+	struct bt_micp_db *mdb;
+
+	if (!db)
+		return NULL;
+
+	mdb = new0(struct bt_micp_db, 1);
+	mdb->db = gatt_db_ref(db);
+
+	if (!micp_db)
+		micp_db = queue_new();
+
+	mdb->mics = mics_new(db);
+	mdb->mics->mdb = mdb;
+
+	queue_push_tail(micp_db, mdb);
+
+	return mdb;
+}
+
+static struct bt_micp_db *micp_get_db(struct gatt_db *db)
+{
+	struct bt_micp_db *mdb;
+
+	mdb = queue_find(micp_db, micp_db_match, db);
+	if (mdb)
+		return mdb;
+
+	return micp_db_new(db);
+}
+
+void bt_micp_add_db(struct gatt_db *db)
+{
+	micp_db_new(db);
+}
+
+bool bt_micp_set_debug(struct bt_micp *micp, bt_micp_debug_func_t func,
+			void *user_data, bt_micp_destroy_func_t destroy)
+{
+	if (!micp)
+		return false;
+
+	if (micp->debug_destroy)
+		micp->debug_destroy(micp->debug_data);
+
+	micp->debug_func = func;
+	micp->debug_destroy = destroy;
+	micp->debug_data = user_data;
+
+	return true;
+}
+
+unsigned int bt_micp_register(bt_micp_func_t attached, bt_micp_func_t detached,
+							  void *user_data)
+{
+	struct bt_micp_cb *cb;
+	static unsigned int id;
+
+	if (!attached && !detached)
+		return 0;
+
+	if (!micp_cbs)
+		micp_cbs = queue_new();
+
+	cb = new0(struct bt_micp_cb, 1);
+	cb->id = ++id ? id : ++id;
+	cb->attached = attached;
+	cb->detached = detached;
+	cb->user_data = user_data;
+
+	queue_push_tail(micp_cbs, cb);
+
+	return cb->id;
+}
+
+static bool match_id(const void *data, const void *match_data)
+{
+	const struct bt_micp_cb *cb = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return (cb->id == id);
+}
+
+bool bt_micp_unregister(unsigned int id)
+{
+	struct bt_micp_cb *cb;
+
+	cb = queue_remove_if(micp_cbs, match_id, UINT_TO_PTR(id));
+	if (!cb)
+		return false;
+
+	free(cb);
+
+	return true;
+}
+
+struct bt_micp *bt_micp_new(struct gatt_db *ldb, struct gatt_db *rdb)
+{
+	struct bt_micp *micp;
+	struct bt_micp_db *mdb;
+
+	if (!ldb)
+		return NULL;
+
+	mdb = micp_get_db(ldb);
+	if (!mdb)
+		return NULL;
+
+	micp = new0(struct bt_micp, 1);
+	micp->ldb = mdb;
+	micp->pending = queue_new();
+	micp->ready_cbs = queue_new();
+
+	if (!rdb)
+		goto done;
+
+	mdb = new0(struct bt_micp_db, 1);
+	mdb->db = gatt_db_ref(rdb);
+
+	micp->rdb = mdb;
+
+done:
+	bt_micp_ref(micp);
+
+	return micp;
+}
+
+static void micp_pending_destroy(void *data)
+{
+	struct bt_micp_pending *pending = data;
+	struct bt_micp *micp = pending->micp;
+
+	if (queue_remove_if(micp->pending, NULL, pending))
+		free(pending);
+}
+
+static void micp_pending_complete(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_micp_pending *pending = user_data;
+
+	if (pending->func)
+		pending->func(pending->micp, success, att_ecode, value, length,
+					  pending->userdata);
+}
+
+static void micp_read_value(struct bt_micp *micp, uint16_t value_handle,
+				micp_func_t func, void *user_data)
+{
+	struct bt_micp_pending *pending;
+
+	pending = new0(struct bt_micp_pending, 1);
+	pending->micp = micp;
+	pending->func = func;
+	pending->userdata = user_data;
+
+	pending->id = bt_gatt_client_read_value(micp->client, value_handle,
+					micp_pending_complete, pending,
+					micp_pending_destroy);
+
+	if (!pending->id) {
+		DBG(micp, "unable to send read request");
+		free(pending);
+		return;
+	}
+
+	queue_push_tail(micp->pending, pending);
+}
+
+static void micp_register(uint16_t att_ecode, void *user_data)
+{
+	struct bt_micp_notify *notify = user_data;
+
+	if (att_ecode)
+		DBG(notify->micp, "MICP register failed 0x%04x", att_ecode);
+}
+
+static void micp_notify(uint16_t value_handle, const uint8_t *value,
+				uint16_t length, void *user_data)
+{
+	struct bt_micp_notify *notify = user_data;
+
+	if (notify->func)
+		notify->func(notify->micp, value_handle, value, length,
+					 notify->user_data);
+}
+
+static void micp_notify_destroy(void *data)
+{
+	struct bt_micp_notify *notify = data;
+	struct bt_micp *micp = notify->micp;
+
+	if (queue_remove_if(micp->notify, NULL, notify))
+		free(notify);
+}
+
+static unsigned int micp_register_notify(struct bt_micp *micp,
+					uint16_t value_handle,
+					micp_notify_t func,
+					void *user_data)
+{
+	struct bt_micp_notify *notify;
+
+	notify = new0(struct bt_micp_notify, 1);
+	notify->micp = micp;
+	notify->func = func;
+	notify->user_data = user_data;
+
+	notify->id = bt_gatt_client_register_notify(micp->client,
+					value_handle, micp_register,
+					micp_notify, notify,
+					micp_notify_destroy);
+	if (!notify->id) {
+		DBG(micp, "Unable to register for notifications");
+		free(notify);
+		return 0;
+	}
+
+	queue_push_tail(micp->notify, notify);
+
+	return notify->id;
+}
+
+static void micp_mute_state_notify(struct bt_micp *micp, uint16_t value_handle,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	uint8_t mute_state;
+
+	memcpy(&mute_state, value, sizeof(mute_state));
+
+	DBG(micp, "Mute state: 0x%x", mute_state);
+}
+
+static void read_mute_state(struct bt_micp *micp, bool success,
+					uint8_t att_ecode, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	uint8_t *mute_state;
+	struct iovec iov = {
+		.iov_base = (void *)value,
+		.iov_len = length,
+	};
+
+	if (!success) {
+		DBG(micp, "Unable to read Mute state: error 0x%02x", att_ecode);
+		return;
+	}
+
+	mute_state = iov_pull_mem(&iov, sizeof(uint8_t));
+	if (mute_state == NULL) {
+		DBG(micp, "Unable to get Mute state");
+		return;
+	}
+
+	DBG(micp, "Mute state: %x", *mute_state);
+}
+
+static void foreach_mics_char(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct bt_micp *micp = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid, uuid_mute;
+	struct bt_mics *mics;
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
+			NULL, NULL, &uuid))
+		return;
+
+	bt_uuid16_create(&uuid_mute, MUTE_CHRC_UUID);
+	if (!bt_uuid_cmp(&uuid, &uuid_mute)) {
+		DBG(micp, "MICS Mute characteristic found: handle 0x%04x",
+				value_handle);
+
+		mics = micp_get_mics(micp);
+		if (!mics || mics->ms)
+			return;
+
+		mics->ms = attr;
+
+		micp_read_value(micp, value_handle, read_mute_state, micp);
+
+		micp->mute_id = micp_register_notify(micp, value_handle,
+						micp_mute_state_notify, NULL);
+	}
+}
+
+static void foreach_mics_service(struct gatt_db_attribute *attr,
+					void *user_data)
+{
+	struct bt_micp *micp = user_data;
+	struct bt_mics *mics = micp_get_mics(micp);
+
+	mics->service = attr;
+
+	gatt_db_service_set_claimed(attr, true);
+	gatt_db_service_foreach_char(attr, foreach_mics_char, micp);
+}
+
+unsigned int bt_micp_ready_register(struct bt_micp *micp,
+				bt_micp_ready_func_t func, void *user_data,
+				bt_micp_destroy_func_t destroy)
+{
+	struct bt_micp_ready *ready;
+	static unsigned int id;
+
+	DBG(micp, "bt_micp_ready_register_Entry\n");
+	if (!micp)
+		return 0;
+
+	ready = new0(struct bt_micp_ready, 1);
+	ready->id = ++id ? id : ++id;
+	ready->func = func;
+	ready->destroy = destroy;
+	ready->data = user_data;
+
+	queue_push_tail(micp->ready_cbs, ready);
+
+	return ready->id;
+}
+
+static bool match_ready_id(const void *data, const void *match_data)
+{
+	const struct bt_micp_ready *ready = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return (ready->id == id);
+}
+
+bool bt_micp_ready_unregister(struct bt_micp *micp, unsigned int id)
+{
+	struct bt_micp_ready *ready;
+
+	ready = queue_remove_if(micp->ready_cbs, match_ready_id,
+						UINT_TO_PTR(id));
+	if (!ready)
+		return false;
+
+	micp_ready_free(ready);
+
+	return true;
+}
+
+static struct bt_micp *bt_micp_ref_safe(struct bt_micp *micp)
+{
+	if (!micp || !micp->ref_count)
+		return NULL;
+
+	return bt_micp_ref(micp);
+}
+
+static void micp_notify_ready(struct bt_micp *micp)
+{
+	const struct queue_entry *entry;
+
+	if (!bt_micp_ref_safe(micp))
+		return;
+
+	for (entry = queue_get_entries(micp->ready_cbs); entry;
+							entry = entry->next) {
+		struct bt_micp_ready *ready = entry->data;
+
+		ready->func(micp, ready->data);
+	}
+
+	bt_micp_unref(micp);
+}
+
+static void micp_idle(void *data)
+{
+	struct bt_micp *micp = data;
+
+	micp->idle_id = 0;
+	micp_notify_ready(micp);
+}
+
+bool bt_micp_attach(struct bt_micp *micp, struct bt_gatt_client *client)
+{
+	bt_uuid_t uuid;
+
+	if (!sessions)
+		sessions = queue_new();
+
+	queue_push_tail(sessions, micp);
+
+	if (!client)
+		return true;
+
+	if (micp->client)
+		return false;
+
+	micp->client = bt_gatt_client_clone(client);
+	if (!micp->client)
+		return false;
+
+	bt_gatt_client_idle_register(micp->client, micp_idle, micp, NULL);
+
+	bt_uuid16_create(&uuid, MICS_UUID);
+	gatt_db_foreach_service(micp->ldb->db, &uuid, foreach_mics_service,
+						micp);
+	return true;
+}
diff --git a/src/shared/micp.h b/src/shared/micp.h
new file mode 100644
index 000000000..b307ac9f4
--- /dev/null
+++ b/src/shared/micp.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2023  NXP Semiconductors. All rights reserved.
+ *
+ */
+#include <stdbool.h>
+#include <inttypes.h>
+
+#include "src/shared/io.h"
+#include "src/shared/gatt-client.h"
+
+struct bt_micp;
+
+typedef void (*bt_micp_ready_func_t)(struct bt_micp *micp, void *user_data);
+typedef void (*bt_micp_destroy_func_t)(void *user_data);
+typedef void (*bt_micp_debug_func_t)(const char *str, void *user_data);
+typedef void (*bt_micp_func_t)(struct bt_micp *micp, void *user_data);
+
+struct bt_micp *bt_micp_ref(struct bt_micp *micp);
+void bt_micp_unref(struct bt_micp *micp);
+
+void bt_micp_add_db(struct gatt_db *db);
+
+bool bt_micp_attach(struct bt_micp *micp, struct bt_gatt_client *client);
+void bt_micp_detach(struct bt_micp *micp);
+
+bool bt_micp_set_debug(struct bt_micp *micp, bt_micp_debug_func_t func,
+		void *user_data, bt_micp_destroy_func_t destroy);
+
+struct bt_att *bt_micp_get_att(struct bt_micp *micp);
+
+bool bt_micp_set_user_data(struct bt_micp *micp, void *user_data);
+
+/* session related functions */
+unsigned int bt_micp_register(bt_micp_func_t attached, bt_micp_func_t detached,
+					void *user_data);
+unsigned int bt_micp_ready_register(struct bt_micp *micp,
+				bt_micp_ready_func_t func, void *user_data,
+				bt_micp_destroy_func_t destroy);
+bool bt_micp_ready_unregister(struct bt_micp *micp, unsigned int id);
+
+bool bt_micp_unregister(unsigned int id);
+struct bt_micp *bt_micp_new(struct gatt_db *ldb, struct gatt_db *rdb);
-- 
2.34.1

