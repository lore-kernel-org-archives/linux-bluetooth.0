Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C7BC77B7C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 May 2023 08:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjEEIc3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 May 2023 04:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjEEIcU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 May 2023 04:32:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F08A27D
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 May 2023 01:32:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzTbS4vWtSVYZouqxw5V34foFymQLbTM9egamauY/6ugvdlb+QO4jUPFjf9U0qXqOsac+e14uyCS9mhG1RnP3BPtgAcbiAve+y8ZL3gWJSZyaUWlaaVGUU2dcgyefBQA9H1eGH/dgN2R0xRH2/ywyEgXOHc0SuBvGGprzzaW6Q2e+YvAOkr5j1tbXOo0S5dIQv9VORC9805ZrHRFBxpFQXO+KDA03xJX8JRWrLtvfsL+Ermea4DIuCrTlGya9HmnERJRZqB2H5glrau/G8K3N2/1rztsWDSaWoCs6OUkIxTiay4aQ/Q45kRGhAZF/QOTuHemulAHYcwG7iR7ODakMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRel/F0NwVENSkPF2fzn69Gcc+rRSXASsPZ2W2Iaaik=;
 b=D+IqzRiXNbtqOhl3YhSqL98zpTkJCQ7sFcRYu1RviyFyfuDamcCvFhJz/DYWeoJOsetb2L4L7NB7Gcz1DOinauQwgpWnSxfkyNw3dL9CAmAgHhqxPpoMjLLoM/zKfQ9HxC7zGa9nyg8h7OtnIJj0T8lFNuh9BYOdYfJZYNxGhwHwOdD3TrWfuw6r/2TAALRUiQ4pnONyecFqplC+8EZxjCpjaX5FbapLzS8jLAlGMZzRoeh9h/uWu3GEoTkB/c8uvAj3dJ57ELaxCeHZ6KNTAkQGKWBwlQuqZBsFzYgavTYk7k+ipaAuKFUVWd72zaxmOMCEMlpIN4mAvoWOeIIclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRel/F0NwVENSkPF2fzn69Gcc+rRSXASsPZ2W2Iaaik=;
 b=mc+k/nceCRw2ctnQKwHEp4EDHEShUHvcGmzZA+pm6609DiOS/SizOCagE/i2ZmoHPi8DuBpHuwnHD9M4BRtc6JTLKyUCuJuTnvMsXkclsmBoJM1UWnLxJu87oDP5llsFjGvYtfhYYtEvp5t8H/WIzzIJZhaAEKTNBIcEGRpqTX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8101.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 08:30:41 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 08:30:41 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 5/5] profiles: Add initial code for BASS plugin
Date:   Fri,  5 May 2023 11:29:43 +0300
Message-Id: <20230505082943.92033-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505082943.92033-1-iulia.tanasescu@nxp.com>
References: <20230505082943.92033-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:205:1::49) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd00f49-a368-4926-1995-08db4d43026d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MgqWcDbgRWgim9aQ6CB65hNxZM6PSA23UNWI14/HoMoFGysFl5dpv5l5/4FUWXBWq7LI4S1+kiDdmec3S4NtBWcjqtZHl39Iw8sybJOmCGJO+kjNG8c6bnu8hUUMgVvhUYxMLtB1MnpASxiZWMR9v+JGbGAZpq0ywoUDJ8+wr21Ym4wKfxQYQqisUs6RC4Y+5TQdmqtKTvkiDgWgTvrR7Ny+AoIK63+1JRwj7C7x0TMk59SYHIjZLmlIkvF0ptwIXsgkMIzCPLu+BJrQg4bm7zUEAqj836xntb+WykppVS5sOwTTM/SBDFnE3NgNGhZb+JeAM9wPRxzLveK3H+X9oxsj4zOw4QRq3EpMUEDdxntkI51JlSKBHd6Mzym5g4Zv/oEfRFMzQX5ujFcHQg832tUO1i0ePeXnS/LvnQTMQNIhk9lTZtJsFm69F4RQNIP+tAdD8qFtY4XoiA0Got9H89SP8ifYHCSkB2on3L6ZR4E5ocVSkF1UvgZokycKCIW5sHe4xfCIXKSKMZ3v3/RfCc4TlLiQtyi34BP4h8j2ZcrduZP8tSDN2SM3KnlxstJ3gnqSUVOeumF6ukQZiTph9ItjT7jbdqtgi60We2sp1HmL0YRt6Mw/nxyGCybJULH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(52116002)(6916009)(4326008)(66946007)(66556008)(66476007)(478600001)(316002)(36756003)(86362001)(6486002)(2616005)(55236004)(6506007)(6512007)(1076003)(26005)(8676002)(5660300002)(8936002)(44832011)(2906002)(41300700001)(38100700002)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hXoHllGsnGHApH38lp6e/BfJEb9GVHHshJB/7QuerE6KAG+g/IPuTGT3Awg6?=
 =?us-ascii?Q?o4I+JrzFbrguHaj63904J8H7cUh9ALs8YNLA4M35GEV8Gv3AUqUoZOKBdzhJ?=
 =?us-ascii?Q?1/UydRN/RiI9m/TA4CiFZJkX9mlkl6cduAXDj1rA/LqvhKIJOYugf9wV+//T?=
 =?us-ascii?Q?RVJwNiJZnQtl4sXF7/UVVScpf5KAWFfqURqQv3yI4xFkQxbc8cZ/XQ5nqQjI?=
 =?us-ascii?Q?3mfkDMWjZZqhW/yX74+o1JHh+Nfv5UQrVLsh6ZweMBS/1fnB35M+SoPgs+vd?=
 =?us-ascii?Q?hsfcLv6WflkElNMMTXzKEq+nHI+zyXmiJRQGJ8ODmf1tvISu87k2QHQaFRt1?=
 =?us-ascii?Q?glAdRHtIvPhhOzB2mmNfpFfE7XYwYwzlXH8IgfBv3l1BO+43MWoM/5SYz0wS?=
 =?us-ascii?Q?2PsrtLc6lErrrAs6pOftAcuonV4t9VbMdMd5YqBJTNjgtcH/VpWNrRtOaY8W?=
 =?us-ascii?Q?jE6LwyV21hokzwAYNgBGDjswY2FWATRC2Pytkr3R9VxK4GGrlD2wrT3WBw11?=
 =?us-ascii?Q?/XvAh/PkmXrwIu6niE64lRLruFfFO7o3xC2awOOhZlj3FuuHa1ws4g0DRw1C?=
 =?us-ascii?Q?RMuDWQHweXpScvtSDQ6+MvJx/TVONviTMzpGIBu1ZQ4VzbTRHXpAH6e3oN4T?=
 =?us-ascii?Q?IH0tk95ini6i/KKkfVAM4uEvUEznjDc72AgQeJfiav+/7d7ou5R1baVhjvq0?=
 =?us-ascii?Q?oc6cJuMi18s9XOoR5aPlMtcxMxLvT26S53wKX6RiIaJ1TUx0dkL0MiEhyZ17?=
 =?us-ascii?Q?j5Z8IPwrwcmeUd7iIq2VxyB+/jpXQZP+PTVVSdbFJtRDlneWFMgf9cy12l9Z?=
 =?us-ascii?Q?9pJaP0OJiUpJ8lPY42SNn49YVlR+z2JHhe2O9hxSNAEJ4y8SPPKYaLAGLFdM?=
 =?us-ascii?Q?3cCiq5Ju3VtD40JswSy9TqBa8guMpsm7SsGFRYDgAWNfnNOQaUS+rYFOtEIx?=
 =?us-ascii?Q?KDsKPbzOFodphsVUomj0PELaz5gZ1+sxP3iYN4qnBJXbFTnnPzZxOUhYPbxp?=
 =?us-ascii?Q?658dQfxr2308FfcKD6hLLVUIo5M0TWVbwhXKJyVBNz0KvRa7vL6+Hg6oEaz4?=
 =?us-ascii?Q?soMAPejmX6QoXrsPgT88QbOkoSeO/i+VyoHTljzUizRLa9MNWVTX6c0hlLMi?=
 =?us-ascii?Q?lo+f9+OX2MLSl+fwFs0LD9oTmyiT0ti37SRl2btKYu/RYzH64r5TVuCNyj59?=
 =?us-ascii?Q?QlHx4krkKcNjpKIuv/jgm+E8tA21NbNeb4oCwlnVoUQe1QCRvqmCDV+zm3xo?=
 =?us-ascii?Q?cKuAwO3CmYdHlDIlPMIugTRClD6+muMakJd3ekqxeZKaiYZRR0ifP24TJRXH?=
 =?us-ascii?Q?Z7FOqCEklMIN4DcFrWW6uhhtTmrmdgyHCrWGwdW2F2OXOYsa0a2fowUfg7sf?=
 =?us-ascii?Q?/+BsQVHtpqcqtKAYptMQnCNSBf3CQEJ/v9FXoakrn8QGPrn+MnhouLH2FKEb?=
 =?us-ascii?Q?hxq5v7ZNKB0K0eUDpmvKXcmuq7nzdRKTll56GTEiEg3wMb8JgzudE3MDWOL0?=
 =?us-ascii?Q?koLIl57T2rqhBQK6BrRI8cDv8FNoXKIR7NDH3JLaEpsMy9XWbQZT7MxoQwmq?=
 =?us-ascii?Q?iYntB9zCkDnOQMFFWb91WvP5AgPXXG/5Gfltad0RWL9Q0jn9MyK7O5K54zek?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd00f49-a368-4926-1995-08db4d43026d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:30:41.6248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyZTdVOdZtBHHYCV+TadzsfQ8v0x+/FIUC4mvPIBpY/ar/M4CzgLfef5P4b5Mkx9elKB9/B/G837VU+KLMgcUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8101
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds initial code for BASS plugin.

---
 Makefile.plugins      |   5 +
 configure.ac          |   4 +
 profiles/audio/bass.c | 305 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 314 insertions(+)
 create mode 100644 profiles/audio/bass.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 0f119e871..fc19522e4 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -122,6 +122,11 @@ builtin_modules += bap
 builtin_sources += profiles/audio/bap.c
 endif
 
+if BASS
+builtin_modules += bass
+builtin_sources += profiles/audio/bass.c
+endif
+
 if MCP
 builtin_modules += mcp
 builtin_sources += profiles/audio/mcp.c
diff --git a/configure.ac b/configure.ac
index 6f890110f..c5c5d7f00 100644
--- a/configure.ac
+++ b/configure.ac
@@ -199,6 +199,10 @@ AC_ARG_ENABLE(bap, AS_HELP_STRING([--disable-bap],
 		[disable BAP profile]), [enable_bap=${enableval}])
 AM_CONDITIONAL(BAP, test "${enable_bap}" != "no")
 
+AC_ARG_ENABLE(bass, AS_HELP_STRING([--disable-bass],
+		[disable BASS service]), [enable_bass=${enableval}])
+AM_CONDITIONAL(BASS, test "${enable_bass}" != "no")
+
 AC_ARG_ENABLE(mcp, AS_HELP_STRING([--disable-mcp],
         [disable MCP profile]), [enable_mcp=${enableval}])
 AM_CONDITIONAL(MCP, test "${enable_mcp}" != "no")
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
new file mode 100644
index 000000000..a7fcc9718
--- /dev/null
+++ b/profiles/audio/bass.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright 2023 NXP
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+
+#include <ctype.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <unistd.h>
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
+#include "lib/uuid.h"
+
+#include "src/dbus-common.h"
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/bass.h"
+
+#include "src/plugin.h"
+#include "src/adapter.h"
+#include "src/gatt-database.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/log.h"
+#include "src/error.h"
+
+#define BASS_UUID_STR "0000184f-0000-1000-8000-00805f9b34fb"
+
+struct bass_data {
+	struct btd_device *device;
+	struct btd_service *service;
+	struct bt_bass *bass;
+};
+
+static struct queue *sessions;
+
+static void bass_debug(const char *str, void *user_data)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
+static struct bass_data *bass_data_new(struct btd_device *device)
+{
+	struct bass_data *data;
+
+	data = new0(struct bass_data, 1);
+	data->device = device;
+
+	return data;
+}
+
+static void bass_data_add(struct bass_data *data)
+{
+	DBG("data %p", data);
+
+	if (queue_find(sessions, NULL, data)) {
+		error("data %p already added", data);
+		return;
+	}
+
+	bt_bass_set_debug(data->bass, bass_debug, NULL, NULL);
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
+	const struct bass_data *bdata = data;
+	const struct bt_bass *bass = match_data;
+
+	return bdata->bass == bass;
+}
+
+static void bass_data_free(struct bass_data *data)
+{
+	if (data->service) {
+		btd_service_set_user_data(data->service, NULL);
+		bt_bass_set_user_data(data->bass, NULL);
+	}
+
+	bt_bass_unref(data->bass);
+	free(data);
+}
+
+static void bass_data_remove(struct bass_data *data)
+{
+	DBG("data %p", data);
+
+	if (!queue_remove(sessions, data))
+		return;
+
+	bass_data_free(data);
+
+	if (queue_isempty(sessions)) {
+		queue_destroy(sessions, NULL);
+		sessions = NULL;
+	}
+}
+
+static void bass_detached(struct bt_bass *bass, void *user_data)
+{
+	struct bass_data *data;
+
+	DBG("%p", bass);
+
+	data = queue_find(sessions, match_data, bass);
+	if (!data) {
+		error("Unable to find bass session");
+		return;
+	}
+
+	/* If there is a service it means there is BASS thus we can keep
+	 * instance allocated.
+	 */
+	if (data->service)
+		return;
+
+	bass_data_remove(data);
+}
+
+static void bass_attached(struct bt_bass *bass, void *user_data)
+{
+	struct bass_data *data;
+	struct bt_att *att;
+	struct btd_device *device;
+
+	DBG("%p", bass);
+
+	data = queue_find(sessions, match_data, bass);
+	if (data)
+		return;
+
+	att = bt_bass_get_att(bass);
+	if (!att)
+		return;
+
+	device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
+	if (!device) {
+		error("Unable to find device");
+		return;
+	}
+
+	data = bass_data_new(device);
+	data->bass = bass;
+
+	bass_data_add(data);
+}
+
+static int bass_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct bass_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	/* Ignore, if we were probed for this device already */
+	if (data) {
+		error("Profile probed twice for the same device!");
+		return -EINVAL;
+	}
+
+	data = bass_data_new(device);
+	data->service = service;
+
+	data->bass = bt_bass_new(btd_gatt_database_get_db(database),
+					btd_device_get_gatt_db(device));
+	if (!data->bass) {
+		error("Unable to create BASS instance");
+		free(data);
+		return -EINVAL;
+	}
+
+	bass_data_add(data);
+	bt_bass_set_user_data(data->bass, service);
+
+	return 0;
+}
+
+static void bass_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bass_data *data;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	data = btd_service_get_user_data(service);
+	if (!data) {
+		error("BASS service not handled by profile");
+		return;
+	}
+
+	bass_data_remove(data);
+}
+static int bass_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct bass_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	if (!data) {
+		error("BASS service not handled by profile");
+		return -EINVAL;
+	}
+
+	if (!bt_bass_attach(data->bass, client)) {
+		error("BASS unable to attach");
+		return -EINVAL;
+	}
+
+	btd_service_connecting_complete(service, 0);
+
+	return 0;
+}
+
+static int bass_disconnect(struct btd_service *service)
+{
+	struct bass_data *data = btd_service_get_user_data(service);
+	struct btd_device *device = btd_service_get_device(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	bt_bass_detach(data->bass);
+
+	btd_service_disconnecting_complete(service, 0);
+
+	return 0;
+}
+
+static struct btd_profile bass_service = {
+	.name		= "bass",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.remote_uuid	= BASS_UUID_STR,
+	.device_probe	= bass_probe,
+	.device_remove	= bass_remove,
+	.accept		= bass_accept,
+	.disconnect	= bass_disconnect,
+};
+
+static unsigned int bass_id;
+
+static int bass_init(void)
+{
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+		warn("D-Bus experimental not enabled");
+		return -ENOTSUP;
+	}
+
+	btd_profile_register(&bass_service);
+	bass_id = bt_bass_register(bass_attached, bass_detached, NULL);
+
+	return 0;
+}
+
+static void bass_exit(void)
+{
+	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
+		btd_profile_unregister(&bass_service);
+		bt_bass_unregister(bass_id);
+	}
+}
+
+BLUETOOTH_PLUGIN_DEFINE(bass, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							bass_init, bass_exit)
-- 
2.34.1

