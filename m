Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2178CDB465
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 15:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjJPPtW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 11:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjJPPtV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 11:49:21 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC39AB
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 08:49:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XToQ6f+KL+/vrABaDpB3bgB6W2ESJmh60cL+1ANpPWzf5wh01pk5FLAGh2JGxXPl3DQeeqmLgU7xTBjF1lvT4enSDAoLJr65Lpbn8q6gPx7OmUMJztP0lYIL8yNIJ7wQTv/fCuYbi10rT+USLAPqM4BphxCPnjnSiAQhwEs7v6pQHsghCPI+zPZo2oA0e3OZ7I2xDdegyEDC0azf7xnRq3Q5aqILtR1CILqF+wc20sxM4cpZekHHmIw9hOIVKsvZxPVKht0VkZKTaQcJYLc3LAmUMSu5YDV0aaJWXPqQIdpPQFPCwO5ut2QxmU6VaEgwAoi8r+88i0sZ0JzufDw55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxDEy7QzjgfLJ8MMNyJBSiKoXHpjrym6a+uRYUneKgM=;
 b=XrD6guSWydH8QMsQ9ePyXiqJZqPEcmHyxKbi76gHvDW8QO+YdkalbgI+kt8H791NvyZnZGCTfw+7jWEAI6m97XIs0xe0heb7XJRtQGIlnqvVL/H0XAT7VjE43ougIHUUAJrWVW7QCVi+SCb1JhBVPcai/SXODC11v5QFrHygDI6ShiMFO8OsynDCzWJk5ReYsQHQEy8J6KlfJ1r+2xVqbWmOJ0OU9dku7SY5uL/ocuXx8nuJwR6KAOfpB6a6yC2rhBevPG5MWBqgxV+yVRyHcllysL6AVp1LkE4GbrLY4gIUWB9uV42LBKZsbNQ6QtQnFX1WfPbfyNyR74/4qHfEBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxDEy7QzjgfLJ8MMNyJBSiKoXHpjrym6a+uRYUneKgM=;
 b=GITPdFdpPtV//BQH/XYEJCSgRENgI6+HfpBmyn5Tfwl1k+KF6sdfBlJ8Pc+zDil1F/HBCqgzndcWT5SeBl4BwhphrAkRCIV8EWo83hw4FjELD7yVxG07s0LL5wNXykCPiwTq+KSP1DyVD/qh7EltTyQHzZpMewG90lEOGjv4q6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB9049.eurprd04.prod.outlook.com (2603:10a6:10:2e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 15:49:15 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 15:49:15 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/4] btio: Allow binding a bcast listener before accept
Date:   Mon, 16 Oct 2023 18:48:59 +0300
Message-Id: <20231016154900.3094-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016154900.3094-1-iulia.tanasescu@nxp.com>
References: <20231016154900.3094-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0135.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::28) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e07dc35-bf3e-447a-1b9a-08dbce5f72f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGSJk8Vd3jil1WOtgLn+/83cKEnP+QYb0lBr5MuBSpci0NQRHHTidUdG+rqi/Z+knNivDb0zocEF4pXRFfX68tpxnN7gjl+xtFJgiNaje0aUkt0/qBiNzLeANg9uXy+P/vbTVN/73SJFx3m66HB9MsFpTPZViB43LIVOJSvHzMf6gkGXb0tlPJZbv2HMW51R9eLMdobRzpfNxo7ull9FtnY3HLL0IpyDKJPYs4GITdY9vUfLJbaoAPKBxn18yCp2yEe5hxx92b69I8va2P1jFPf/DwXXwMCfv2D3FtKf8mhS/UzDHoNyQNNQOxPRkuk0AIrCdKmn2XxkErv76vZ9QaKHeKhfeMEAq6ZPS5j2vDUFRIpGiga4K19wblfEMFEajeonhZqIC7i+2cFpYP/e7IddYbrn6xNZ+Of0E8eEpwc7Z7STQO8jOXMRMiKD/t/C+jicDuZ24PiODXwZRH0tObSEGn2V5qlmHXk64o62akNhQHQjFLus/qz/c2lHYXoisvlC6ev0T4zl4f8YeTVTSX22xJd959IiArIpKVrXqlLki0fXV5n+rjNTB6K3rD2srV2/zzj/Ndtf5S2syVmKN5YpsCw78ELLI3KtPITJ8/G7elFzbW9K9Fodlrp8qkLz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2013699003)(6486002)(38100700002)(478600001)(2906002)(6512007)(6506007)(6666004)(316002)(66946007)(66476007)(66556008)(6916009)(4326008)(5660300002)(41300700001)(8936002)(44832011)(8676002)(83380400001)(1076003)(26005)(2616005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UMpq4K0Hc1uz7wfyQImFf6qTgpPlNCz+rCbggb4I0bdIYNbqta+VdPJjjSYD?=
 =?us-ascii?Q?dAwIJzpvyXytAy20N1unKM2pnZOBIy1BHkIVSgNaNU7bxzukYaj7B7iKkpLs?=
 =?us-ascii?Q?dE7I2ouIGvZYGcGVlef5PBkx/ax/LQx6wTuejuNZ2BOQu34NI47OAMzD3V8/?=
 =?us-ascii?Q?tlLWKl8GzWUdAIl3pgiJmKLPCzazRSw9ndI2FDDqChFl7ryVx4a5tqZ9axvY?=
 =?us-ascii?Q?LjAJeBmLX29NIvHn5GSd26UzL5DU0islXlABxGnSSzkau5nmWpDtEdNuax/s?=
 =?us-ascii?Q?NeJd+T32tAohKYACsqPp+QLTs6VCEJWK1a08hLZRF1ykxcTCpXFDtN7u5kkD?=
 =?us-ascii?Q?xAt72XvPFyQMGbMGaZ+TGZOTDOuVMUyR4IIRYmIAWaWHProqiDw2X63R/91O?=
 =?us-ascii?Q?uhNr5DK52ywgn90UPWO+qgH/9Y8nVuo2Zyh/EEdI281WeSeuPu1GIOXauynd?=
 =?us-ascii?Q?8KsY9CbVRdDpxS+/7xuYqfwzrsgfpaC/GdRhLtRev4IyGJQPNAy/Q7Z0Zw8y?=
 =?us-ascii?Q?em9jDl6pxkpfud7asf0MNImMT+1M3N7Ia0QfEhSlksp/cr5ELNwzdb0azWWx?=
 =?us-ascii?Q?S+wNdC384Wc++FolHAW+s+BW4PpEBPLxG5Kw7gq89k7A8aKxvCsH5kww0/Dn?=
 =?us-ascii?Q?3HxfwnFYSBEmYz8+1leMzjZ3vgU0yesaaADkaZoBFMQO63fu0y8lhjjTIxgJ?=
 =?us-ascii?Q?uVSO+ZWCntkCl4FS+vLSafW3eAGgTxD2dQzzRX8d/vaUtXrEsAPjo9Rk98gz?=
 =?us-ascii?Q?O9LhroG9GOaEWgtqC1zMEa2Pqn/U1mo+hps7qgqnoU9hN+Gmij7VfyMeYU7M?=
 =?us-ascii?Q?Zg5xj5m7eGTvnjZHVMMiJbpalDoUm98ETO+I8bwCUyKXJbaMZYoBK27gXUHm?=
 =?us-ascii?Q?NeR6euKZT7RDx1Ll2BkiykP2AIYLfIMtzPhFbkiTV/jz/sLD5jr3pQQEiC3N?=
 =?us-ascii?Q?WkIw87ABdVxz9ahCyC/yCJwomujy0bSCnundOvS0V4SwpixwJ7gRbkmKCDfY?=
 =?us-ascii?Q?nnK+je1TD4VMXgy+Nm8WJSSkgZh+yF5rZtsfNmwYWjXGSZICbeDAxHQ7GhI8?=
 =?us-ascii?Q?N6lNW+xBsO96L/yulyQLQ99JHqEoR6e1mTPopb88TuAXxThmG0I9AvcTIhpH?=
 =?us-ascii?Q?P7a1a5EX7qJLn+srpZQlr7HNi9YT5i7nouFXPbuH2iomyJcOg8AZgokoDYnf?=
 =?us-ascii?Q?mcMeGVbFWd5Mtu5+Z7em+iPG1bFbZiP2i3VsL2E3/I4TYvvKqdVsHxlFYAju?=
 =?us-ascii?Q?teNTfv9CmxUf7AEtHzbYhWFqFKjqUxz3EkwyJ67SL7ltRbkpr2yuPmy7ehAM?=
 =?us-ascii?Q?as/SiP5AqL0WObiU5hArL7x5cSWNxUHcGShDH/8mlVQLfdsa6AZkx5AFrbiJ?=
 =?us-ascii?Q?vs1tRwCTvJ66tLWSYYzjKPQk6XkbVxOKhUVd2GQg0isgOFVgkJlr8tyImBwU?=
 =?us-ascii?Q?HkIimZVQQSJfPR3moU0cj5jdm9ipvnr7s0V1GDd3bnEGEe/5578GV5FOCjd6?=
 =?us-ascii?Q?oFev3W7j9BJrJYyBgtJgCDnDIfze2pfVeNXMrSMp7VjZPqcZ31I8i8A62wSR?=
 =?us-ascii?Q?eYEdXcgsJ1S09kE7zbU0hxGDLRFQoJQoefNxxIXY2trsq/tTsuptprrleD6Y?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e07dc35-bf3e-447a-1b9a-08dbce5f72f7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:49:15.0531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92Wz+U02N2caXyznLEa2sWJVmeDGRP3Hu/tvaSiDXULFA7EOIVUzsDrIJpzDxafa2PV75u5Ox5Jch1NsFNYR/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9049
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds btio support for binding a PA sync io to a number of BISes,
before proceeding with BIG Create Sync

---
 btio/btio.c          | 51 +++++++++++++++++++++++++++++++++++++++++++-
 btio/btio.h          |  2 +-
 profiles/audio/bap.c |  2 +-
 src/shared/bass.c    |  9 ++++----
 4 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index c63a6d1df..338f24916 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1797,14 +1797,63 @@ gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 
 gboolean bt_io_bcast_accept(GIOChannel *io, BtIOConnect connect,
 				gpointer user_data, GDestroyNotify destroy,
-				GError * *err)
+				GError * *err, BtIOOption opt1, ...)
 {
 	int sock;
 	char c;
 	struct pollfd pfd;
+	va_list args;
+	struct sockaddr_iso *addr = NULL;
+	uint8_t bc_num_bis = 0;
+	uint8_t bc_bis[ISO_MAX_NUM_BIS] = {0};
+	BtIOOption opt = opt1;
+
+	va_start(args, opt1);
+
+	while (opt != BT_IO_OPT_INVALID) {
+		if (opt == BT_IO_OPT_ISO_BC_NUM_BIS)  {
+			bc_num_bis = va_arg(args, int);
+		} else if (opt == BT_IO_OPT_ISO_BC_BIS) {
+			memcpy(bc_bis, va_arg(args, uint8_t *),
+					bc_num_bis);
+		} else {
+			g_set_error(err, BT_IO_ERROR, EINVAL,
+					"Invalid option %d", opt);
+			break;
+		}
+
+		opt = va_arg(args, int);
+	}
+
+	va_end(args);
+
+	if (*err)
+		return FALSE;
 
 	sock = g_io_channel_unix_get_fd(io);
 
+	if (bc_num_bis) {
+		addr = malloc(sizeof(*addr) + sizeof(*addr->iso_bc));
+
+		if (!addr) {
+			ERROR_FAILED(err, "poll", ENOMEM);
+			return FALSE;
+		}
+
+		memset(addr, 0, sizeof(*addr) + sizeof(*addr->iso_bc));
+		addr->iso_family = AF_BLUETOOTH;
+
+		addr->iso_bc->bc_num_bis = bc_num_bis;
+		memcpy(addr->iso_bc->bc_bis, bc_bis,
+			addr->iso_bc->bc_num_bis);
+
+		if (bind(sock, (struct sockaddr *)addr,
+			sizeof(*addr) + sizeof(*addr->iso_bc)) < 0) {
+			ERROR_FAILED(err, "bind", errno);
+			return FALSE;
+		}
+	}
+
 	memset(&pfd, 0, sizeof(pfd));
 	pfd.fd = sock;
 	pfd.events = POLLOUT;
diff --git a/btio/btio.h b/btio/btio.h
index 3169bebf3..3e69092b1 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -77,7 +77,7 @@ gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 
 gboolean bt_io_bcast_accept(GIOChannel *io, BtIOConnect connect,
 				gpointer user_data, GDestroyNotify destroy,
-				GError **err);
+				GError **err, BtIOOption opt1, ...);
 
 gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...);
 
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index fa5cf1f54..b74498c4c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -981,7 +981,7 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	GError *err = NULL;
 
 	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
-				user_data, NULL, &err)) {
+				user_data, NULL, &err, BT_IO_OPT_INVALID)) {
 		error("bt_io_bcast_accept: %s", err->message);
 		g_error_free(err);
 		g_io_channel_shutdown(io, TRUE, NULL);
diff --git a/src/shared/bass.c b/src/shared/bass.c
index 78103d463..326ce6dae 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -774,8 +774,9 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 
 		if (bass_trigger_big_sync(bcast_src)) {
 			if (!bt_io_bcast_accept(bcast_src->pa_sync_io,
-				connect_cb, bcast_src, NULL, &gerr)) {
-				DBG(bcast_src->bass, "bt_io_accept: %s",
+				connect_cb, bcast_src, NULL, &gerr,
+				BT_IO_OPT_INVALID)) {
+				DBG(bcast_src->bass, "bt_io_bcast_accept: %s",
 				gerr->message);
 				g_error_free(gerr);
 			}
@@ -1178,8 +1179,8 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 	}
 
 	if (!bt_io_bcast_accept(bcast_src->pa_sync_io, connect_cb,
-		bcast_src, NULL, &gerr)) {
-		DBG(bcast_src->bass, "bt_io_accept: %s", gerr->message);
+		bcast_src, NULL, &gerr,  BT_IO_OPT_INVALID)) {
+		DBG(bcast_src->bass, "bt_io_bcast_accept: %s", gerr->message);
 		g_error_free(gerr);
 	}
 }
-- 
2.39.2

