Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22718C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 May 2023 08:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjE2IsZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 May 2023 04:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjE2IsO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 May 2023 04:48:14 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EA5F4
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 01:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0cBxqfgYh4FXbUvyci8JsRa0Od1tUM1HfSbSXfCZhnnKgJdCaraczM6TNabx+CdqoYZvKdwRXvfH7kCkLWImAIC9K3Ji+bcO8mO4AmeYgPwIUXB8Fye904vx8YBjhKVZCsTJ84uIn0V7E7M3ZfK4pJjK9fAsPdIaZdiUdsamnyFau2vGfLEl42j6LsKqCtPES9HBZCMTRATq3lQGeItOQbKGqT3ki51bzRKDj2I4XdMN7YnHKs6Z++2kvJoEASlpCsUL5mM20VGsgQlftFn2VKDVu+Wd6nQ0zJmDxPD5kPciOuT6HYcKQwRpVIyxl5fyUF0GeDyKPAKYwv4nRpFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSApXNBf3ZAUO+jFB8ai1Ox8RziksQVM3hvJ+40P8cY=;
 b=VL9RLgNskp4jvP4hsU6aJpFvFJMFq9/H9JoAMEqHmUMay6Ozx+DAEb7Ex0HSnjwfMv0V4BYAWXMMxVAxts5fyq3GKA1wc008llmqnxmB7uMN5pBC5UeBeWhRfclKi3D/amCz3OhihoXNr3BuvrKw1c8ACjTATzTvN0p8WxNoqp3e+F3hX9Nzon9WIbpCndiHAsmIkCq0GvIEb6++ccirEuVFni6ndcljqCvYLCTwbRuXXLqkGppGExHsY9v3N+lgUEIQf63kaSNjXRrNI80BWU82CtaJA5ifexV5unai5ViGsjLzjZH5uvL/OSbuF/HDrLfkGq1wU0KEKzUbyrBKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSApXNBf3ZAUO+jFB8ai1Ox8RziksQVM3hvJ+40P8cY=;
 b=K+eNuven+ol4JqhsAY4ufjtmea/laqjaFjBV4PnOs3hO20ru3Ll9GsJk6Qknst8/snjVD+hx1bBx1pdXRPmH6soDd1pXFO6vKkqYe1StwQZ0HItD1KssxzpIYGwO6sxChjqLvN7VvYif1lkzB54ffgH0ispH89i/BizlHz4VL80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7074.eurprd04.prod.outlook.com (2603:10a6:208:196::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 08:47:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 08:47:14 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/2] unit: Introduce test-bass
Date:   Mon, 29 May 2023 11:46:50 +0300
Message-Id: <20230529084650.72126-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529084650.72126-1-iulia.tanasescu@nxp.com>
References: <20230529084650.72126-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 262911c8-7a04-4075-38cc-08db60214cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8WhzbQonen+9JQx58QOQPWfN0tX+gy9r1Srd24DY5DLcs3tAUX/XebwLUsYTNi6sleQh/+dAEmpgSxqHISCrJxI+KLY3aIyVA5co2DJPrUB4EwaNXFqSjfAt12sUBYJvNUnK9BXQWMF3r7nmPo0VLgrqFwgU+cSNr2+b5LUnvEHh6vXUaLQouDZrznT4tODU6iNL9aBJwZ9Ufz/G8XG3nSvkVhSaCCPl7f7rothyXE3OJCxjXnT9uwS+EmvlyfNEqE4GHsnl7w2xDNeyJTBs3PXMx3xFcERepBIqpo6kFtRBY/olkKE9pRTsLDmpxc2Ad3/yL1Hbgd9HEsHgUvZcBA3h+QzQtx32vTGy3qZe5Zhdv4ezb62+swSScTbzLELCVcYJx3IBXqCHZDpkHOveTEs1lorxNvMo27aPDKhh3BVzIDYRRyOYToYjwL33zanbH66uws280m6QdICLdrYPIaus5cCW/s9BqiQD+PA2FJiiHHcDQjVn4/MIYaNvrKVFXMIp2ok3w9s1SiQByN4jqXB3Qz0vN9sRgORTqaWeoXoXSbMcpW1MBNCMhUoIOTeHx/k9KjKmLrjgIvoPLX7nm8W/84RQ2ammATaVcyuPcuI+qtEurqQMzhY/Kzo5SwB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(38100700002)(38350700002)(41300700001)(6512007)(316002)(6666004)(6916009)(4326008)(86362001)(30864003)(52116002)(8676002)(8936002)(6486002)(2906002)(2616005)(66946007)(66476007)(66556008)(36756003)(44832011)(6506007)(1076003)(26005)(83380400001)(478600001)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t3i2MjCEDPgaoBUj8apM+xa9jCsO9OkBUuy4TowTzjCZ+O6fOvASS/AmJmg3?=
 =?us-ascii?Q?s5mOGvR+xXf9xBEufGk/k10pZJvL8dfG15sM1rQeEcZkNowXt2xXvq6Krksl?=
 =?us-ascii?Q?YhKjQwjOeBMqv1xMocUsL10r3/H9zsRyvUJOi3Zcpc45oTpVSDmTKsEFTrJo?=
 =?us-ascii?Q?QZrYiURQuEGKskzgwGBpi+36ITSxzhGiRCHM6y5MqVVG7LIo5THu10dsyFKC?=
 =?us-ascii?Q?FOVg2xhcj/XCyBwoVc9f3Bt+GOt/tPLjhwzbL1hdSxaaYsgHmnFHdJI6WWY7?=
 =?us-ascii?Q?pPBRyo3ji08gamX9Ohu1p0w6+VeodDs0+kC7HhB0cI86N4M6obchEKXfIRre?=
 =?us-ascii?Q?uLa3V0uC4rizbdr0Jz5nNDOLJvSVHPS3Uxu37PGs6LJeRDuTmCujFzkHVzqb?=
 =?us-ascii?Q?ZYY3opNWij7YbmdHo9GIIXZVh8/NGym2zNC8HCE68wiLLX4ybiTEW7v6R1ZK?=
 =?us-ascii?Q?4BggHq9BmZiPOucIRhakAOQIwU9IZTGDtDzOZcTtiQ2+TXbG7EjghGSVuLwE?=
 =?us-ascii?Q?/7Hnaw8GhoEI2xOIyXtgqK9oehijl3mNR0Gj9hsNNqAZVS3QV59EFbIkBIrU?=
 =?us-ascii?Q?ZdUxoKOf1t3MgQsARzc5Dkd+DWOnT6FDHpMUZSybrK8ZrbHryo/8VN8/ueJ7?=
 =?us-ascii?Q?DfOuaOiZ6fij3vfxOS9H0Osv+h2s+An4jlL8lzwoqiY/CtO4BrNB+O7zUXBH?=
 =?us-ascii?Q?frzz0Nus0nrnQ1rlEnY6mJsE9krE+xOiQOk5z1V/Mc65/59i7dfe0bR0RPL6?=
 =?us-ascii?Q?FTdZu2KxnffDDBlgisiGvzMM3ZO2fd7zYLcM4VQaKzN6kWVwnyXIAG1sClvx?=
 =?us-ascii?Q?8Ko8s/G8+NwypklUhRLvVW/j9Xr5bAAG0yXkTIo/yK8KBAWNMPP580brTgRY?=
 =?us-ascii?Q?xbjJrAsKFyVlbW1jfXttX7M/E4uiuxQHdcVDqty4E/8Y5FoOvoh3/dY8Qolb?=
 =?us-ascii?Q?5mz4/aYLu9+xQ5rQwxJsEYZo9GDpfJJp+Vi+B22feC/zjbQUTQgZ7TmCaar2?=
 =?us-ascii?Q?6YlISMwqQLnPWyROOj0MKAfdYy3hmHIx1okhCxPw3GJV++LUuqdwQwmKM50L?=
 =?us-ascii?Q?bbl4Qp+XW6gKqedXGWJDj/X3MTAD0xKcxl+h/ytXOir0B9nIAvrhr0FKQ/YW?=
 =?us-ascii?Q?6vcaRJ8eZmLd63Ozd8bVmFAZ019m/6vGMJCvWSnzyllHjtXgfCpLt9BfsvL1?=
 =?us-ascii?Q?nb+UDf4Fq+I28q4i6BoT9vICDDm1DRZC1O9oiD5Ctxy9IS97Lj3yAmxJjCkl?=
 =?us-ascii?Q?NW3NskxEu36XlVGljMdHHmYFEBphZpMUcX8yGKLwrvt0So+tgryMphqpM2/g?=
 =?us-ascii?Q?DpedjUWKZt0jsP7r63Bd0D5zDHKtwodS+rkQF3qndu81fTAPKktikGKRkx1p?=
 =?us-ascii?Q?Awl+fD9q/8NPmKhUdOWMEV1IvyykXQyr18D99tYyn7MjGfcYr5w3SSl2XvAo?=
 =?us-ascii?Q?FiH1gcvOqAUHEC8HhRnoB0A8yHuNH74ybPQiScpD6O/7NAuJX+GP2Nyj6tfq?=
 =?us-ascii?Q?PFYuR5BCboWF+rUM0EoiAsCyG4jnPrCZQbiohCS7k03vfJjUTgxwWRHWRC5C?=
 =?us-ascii?Q?Y7zAzbkyoFy9FmWG1hgmEEU8UWXzIXxz8pkk6hAeZ7EsFxPC9wHckLKayoLl?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262911c8-7a04-4075-38cc-08db60214cab
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 08:47:14.0910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoCon/Rw+oc+UjBVPlj3vWbutB5f3Obwh0w3IfaoFaZPe/WhAWOWsz91O95sygx3hgpc4xzJtQYlwpR2WuPaWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7074
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds 3 unit tests for BASS server, to simulate the
Generic GATT Integrated Test suite for BASS.

Test Summary 
------------
BASS/SR/SGGIT/SER/BV-01-C                            Passed
BASS/SR/SGGIT/CHA/BV-01-C                            Passed
BASS/SR/SGGIT/CHA/BV-02-C                            Passed
Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0

---
 Makefile.am      |   6 +
 unit/test-bass.c | 397 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 403 insertions(+)
 create mode 100644 unit/test-bass.c

diff --git a/Makefile.am b/Makefile.am
index 48f0cefa7..2bd547564 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -578,6 +578,12 @@ unit_test_bap_SOURCES = unit/test-bap.c
 unit_test_bap_LDADD = src/libshared-glib.la \
 				lib/libbluetooth-internal.la $(GLIB_LIBS)
 
+unit_tests += unit/test-bass
+
+unit_test_bass_SOURCES = unit/test-bass.c
+unit_test_bass_LDADD = src/libshared-glib.la \
+				lib/libbluetooth-internal.la $(GLIB_LIBS)
+
 if MIDI
 unit_tests += unit/test-midi
 unit_test_midi_CPPFLAGS = $(AM_CPPFLAGS) $(ALSA_CFLAGS) -DMIDI_TEST
diff --git a/unit/test-bass.c b/unit/test-bass.c
new file mode 100644
index 000000000..8937c9478
--- /dev/null
+++ b/unit/test-bass.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright 2023 NXP
+ *
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
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+#include "src/shared/util.h"
+#include "src/shared/io.h"
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/bass.h"
+
+struct test_data {
+	struct gatt_db *db;
+	struct bt_bass *bass;
+	struct bt_gatt_server *server;
+	struct queue *ccc_states;
+	size_t iovcnt;
+	struct iovec *iov;
+};
+
+struct ccc_state {
+	uint16_t handle;
+	uint16_t value;
+};
+
+/* ATT: Exchange MTU Request (0x02) len 2
+ *   Client RX MTU: 64
+ * ATT: Exchange MTU Response (0x03) len 2
+ *   Server RX MTU: 64
+ */
+#define EXCHANGE_MTU \
+	IOV_DATA(0x02, 0x40, 0x00), \
+	IOV_DATA(0x03, 0x40, 0x00)
+
+/* ATT: Find By Type Value Request (0x06) len 8
+ *   Handle range: 0x0001-0xffff
+ *   Attribute Type(UUID): Primary Service (0x2800)
+ *   Value to find: Broadcast Audio Scan Service (0x184f)
+ * ATT: Find By Type Value Response (0x07) len 4
+ *   Handle range: 0x0001-0x0009
+ * ATT: Find By Type Value Request (0x06) len 8
+ *   Handle range: 0x000a-0xffff
+ *   Attribute Type(UUID): Primary Service (0x2800)
+ *   Value to find: Broadcast Audio Scan Service (0x184f)
+ * ATT: Error Response (0x01) len 4
+ *   Find By Type Value Request (0x06)
+ *   Handle: 0x000a
+ *   Error: Attribute Not Found (0x0a)
+ */
+#define BASS_FIND_BY_TYPE_VALUE \
+	IOV_DATA(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0x4f, 0x18), \
+	IOV_DATA(0x07, 0x01, 0x00, 0x09, 0x00), \
+	IOV_DATA(0x06, 0x0a, 0x00, 0xff, 0xff, 0x00, 0x28, 0x4f, 0x18), \
+	IOV_DATA(0x01, 0x06, 0x0a, 0x00, 0x0a)
+
+/* ATT: Read By Type Request (0x08) len 6
+ *   Handle range: 0x0001-0x0009
+ *   Attribute type: Characteristic (0x2803)
+ * ATT: Read By Type Response (0x09) len 22
+ * Attribute data length: 7
+ * Attribute data list: 3 entries
+ *   Handle: 0x0002
+ *   Value: 120300c82b
+ *   Properties: 0x12
+ *     Read (0x02)
+ *     Notify (0x10)
+ *   Value Handle: 0x0003
+ *   Value UUID: Broadcast Receive State (0x2bc8)
+ *   Handle: 0x0005
+ *   Value: 120600c82b
+ *   Properties: 0x12
+ *     Read (0x02)
+ *     Notify (0x10)
+ *   Value Handle: 0x0006
+ *   Value UUID: Broadcast Receive State (0x2bc8)
+ *   Handle: 0x0008
+ *   Value: 0c0900c72b
+ *   Properties: 0x0c
+ *     Write (0x08)
+ *     Write Without Response (0x04)
+ *   Value Handle: 0x0009
+ *   Value UUID: Broadcast Audio Scan Control Point (0x2bc7)
+ * ATT: Read By Type Request (0x08) len 6
+ *   Handle range: 0x0009-0x0009
+ *   Attribute type: Characteristic (0x2803)
+ * ATT: Error Response (0x01) len 4
+ *   Read By Type Request (0x08)
+ *   Handle: 0x0009
+ *   Error: Attribute Not Found (0x0a)
+ */
+#define DISC_BASS_CHAR \
+	IOV_DATA(0x08, 0x01, 0x00, 0x09, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x09, 0x07, \
+		0x02, 0x00, 0x12, 0x03, 0x00, 0xc8, 0x2b, \
+		0x05, 0x00, 0x12, 0x06, 0x00, 0xc8, 0x2b, \
+		0x08, 0x00, 0x0c, 0x09, 0x00, 0xc7, 0x2b), \
+	IOV_DATA(0x08, 0x09, 0x00, 0x09, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x01, 0x08, 0x09, 0x00, 0x0a)
+
+/* ATT: Read By Group Type Request (0x10) len 6
+ *   Handle range: 0x0001-0xffff
+ *   Attribute group type: Primary Service (0x2800)
+ * ATT: Read By Group Type Response (0x11) len 7
+ *   Attribute data length: 6
+ *   Attribute group list: 1 entry
+ *   Handle range: 0x0001-0x0009
+ *   UUID: Broadcast Audio Scan Service (0x184f)
+ * ATT: Read By Group Type Request (0x10) len 6
+ *   Handle range: 0x000a-0xffff
+ *   Attribute group type: Primary Service (0x2800)
+ * ATT: Error Response (0x01) len 4
+ *   Read By Group Type Request (0x10)
+ *   Handle: 0x000a
+ *   Error: Attribute Not Found (0x0a)
+ */
+#define DISC_BASS_SER \
+	EXCHANGE_MTU,\
+	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28), \
+	IOV_DATA(0x11, 0x06, 0x01, 0x00, 0x09, 0x00, 0x4f, 0x18), \
+	IOV_DATA(0x10, 0x0a, 0x00, 0xff, 0xff, 0x00, 0x28), \
+	IOV_DATA(0x01, 0x10, 0x0a, 0x00, 0x0a), \
+	BASS_FIND_BY_TYPE_VALUE, \
+	DISC_BASS_CHAR
+
+/* ATT: Find Information Request (0x04) len 4
+ *   Handle range: 0x0004-0x0004
+ * ATT: Find Information Response (0x05) len 5
+ *   Format: Handle(s) and 16 bit bluetooth UUID(s) (0x01)
+ *   Handle: 0x0004
+ *   Attribute: Client Characteristic Configuration (0x2902)
+ * ATT: Find Information Request (0x04) len 4
+ *   Handle range: 0x0007-0x0007
+ * ATT: Find Information Response (0x05) len 5
+ *   Format: Handle(s) and 16 bit bluetooth UUID(s) (0x01)
+ *   Handle: 0x0007
+ *   Attribute: Client Characteristic Configuration (0x2902)
+ */
+#define BASS_FIND_INFO \
+	IOV_DATA(0x04, 0x04, 0x00, 0x04, 0x00), \
+	IOV_DATA(0x05, 0x01, 0x04, 0x00, 0x02, 0x29), \
+	IOV_DATA(0x04, 0x07, 0x00, 0x07, 0x00), \
+	IOV_DATA(0x05, 0x01, 0x07, 0x00, 0x02, 0x29)
+
+#define DISC_BCAST_AUDIO_SCAN_CP \
+	BASS_FIND_BY_TYPE_VALUE, \
+	DISC_BASS_CHAR, \
+	BASS_FIND_INFO
+
+/* ATT: Read Request (0x0a) len 2
+ *   Handle: 0x0004 Type: Client Characteristic Configuration (0x2902)
+ * ATT: Read Response (0x0b) len 2
+ *   Value: 0000
+ *   Handle: 0x0004 Type: Client Characteristic Configuration (0x2902)
+ * ATT: Read Request (0x0a) len 2
+ *   Handle: 0x0007 Type: Client Characteristic Configuration (0x2902)
+ * ATT: Read Response (0x0b) len 2
+ *   Value: 0000
+ *   Handle: 0x0007 Type: Client Characteristic Configuration (0x2902)
+ */
+#define BASS_READ_CHAR_DESC \
+	IOV_DATA(0x0a, 0x04, 0x00), \
+	IOV_DATA(0x0b, 0x00, 0x00), \
+	IOV_DATA(0x0a, 0x07, 0x00), \
+	IOV_DATA(0x0b, 0x00, 0x00)
+
+#define DISC_BCAST_RECV_STATE \
+	DISC_BCAST_AUDIO_SCAN_CP, \
+	BASS_READ_CHAR_DESC
+
+#define iov_data(args...) ((const struct iovec[]) { args })
+
+#define define_test(name, function, _cfg, args...)		\
+	do {							\
+		const struct iovec iov[] = { args };		\
+		static struct test_data data;			\
+		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		tester_add(name, &data, NULL, function,	\
+				test_teardown);			\
+	} while (0)
+
+static void test_complete_cb(const void *user_data)
+{
+	tester_test_passed();
+}
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
+	bt_bass_unref(data->bass);
+	bt_gatt_server_unref(data->server);
+	util_iov_free(data->iov, data->iovcnt);
+
+	gatt_db_unref(data->db);
+
+	queue_destroy(data->ccc_states, free);
+
+	tester_teardown_complete();
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
+					NULL, data);
+
+	data->bass = bt_bass_new(data->db, NULL);
+	g_assert(data->bass);
+
+	data->server = bt_gatt_server_new(data->db, att, 64, 0);
+	g_assert(data->server);
+
+	bt_gatt_server_set_debug(data->server, print_debug, "bt_gatt_server:",
+						NULL);
+
+	data->ccc_states = queue_new();
+
+	tester_io_send();
+
+	bt_att_unref(att);
+}
+
+static void test_sggit(void)
+{
+	/* BASS/SR/SGGIT/SER/BV-01-C [Service GGIT - Broadcast Scan]
+	 *
+	 * For each ATT_Read_By_Group_Type_Request, the IUT sends a correctly
+	 * formatted ATT_Read_By_Group_Type_Response reporting BASS to the
+	 * Lower Tester, or an ATT_Error_Response if there is no handle/UUID
+	 * pair matching the request.
+	 *
+	 * For each ATT_Find_By_Type_Value_Request, the IUT sends one
+	 * ATT_Find_By_Type_Value_Response reporting BASS to the Lower Tester,
+	 * or an ATT_Error_Response when there are no more services matching
+	 * the request.
+	 *
+	 * The IUT sends one ATT_Read_By_Type_Response to the Lower Tester for
+	 * each received ATT_Read_By_Type_Request, if it has characteristic
+	 * declarations within the handle range, or an ATT_Error_Response if
+	 * there are no further characteristic declarations within the
+	 * handle range of the request. The IUT reports all BASS
+	 * characteristics.
+	 */
+	define_test("BASS/SR/SGGIT/SER/BV-01-C", test_server, NULL,
+							DISC_BASS_SER);
+
+	/* BASS/SR/SGGIT/CHA/BV-01-C [Service GGIT -
+	 * Broadcast Audio Scan Control Point]
+	 *
+	 * The IUT sends one ATT_Read_By_Type_Response to the Lower Tester for
+	 * each received ATT_Read_By_Type_Request, if it has characteristic
+	 * declarations within the handle range, or an ATT_Error_Response if
+	 * there are no further characteristic declarations within the
+	 * handle range of the request. The IUT reports one instance of the
+	 * Broadcast Audio Scan Control Point characteristic.
+	 */
+	define_test("BASS/SR/SGGIT/CHA/BV-01-C", test_server, NULL,
+						DISC_BCAST_AUDIO_SCAN_CP);
+
+	/* BASS/SR/SGGIT/CHA/BV-02-C [Service GGIT -
+	 * Broadcast Receive State]
+	 *
+	 * The IUT sends one ATT_Read_By_Type_Response to the Lower Tester for
+	 * each received ATT_Read_By_Type_Request, if it has characteristic
+	 * declarations within the handle range, or an ATT_Error_Response if
+	 * there are no further characteristic declarations within the
+	 * handle range of the request. The IUT reports two instances of the
+	 * Broadcast Receive State characteristic.
+	 *
+	 * The IUT sends one ATT_Find_Information_Response to the Lower Tester
+	 * for each received ATT_Find_Information_Request, if it has
+	 * characteristic descriptors within the handle range, or an
+	 * ATT_Error_Response if there are no characteristic descriptors within
+	 * the handle range of the request. For each Broadcast Receive State
+	 * characteristic, the IUT reports one Client Characteristic
+	 * Configuration descriptor.
+	 *
+	 * The IUT sends an ATT_Read_Response to the Lower Tester for each
+	 * ATT_Read_Request.
+	 */
+	define_test("BASS/SR/SGGIT/CHA/BV-02-C", test_server, NULL,
+						DISC_BCAST_RECV_STATE);
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	test_sggit();
+
+	return tester_run();
+}
-- 
2.34.1

