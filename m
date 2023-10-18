Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC5EC41513
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 14:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjJROj0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjJROjZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 10:39:25 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA1F112
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 07:39:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9K8wD+DPT80h7KxdvguWDGU+9khM0D1XNA9IaNIM5EL8w/QFaM7wwPoIrgFZ5cTGl6hoDnxZ6pKIxv5fQLxfrW4qNW2CoZ9QOyQTx8mjHJ4F2OXNijvsZjBvxdM/5yoRHbjtZSWIB4SYb6TL52of3Ut5UTXbtHG0btQgAzo9Hqon3NVybhSxCVXPVy9Ae5zYE+gTgX/PcW654oxntZADd2R2CwbJqxkz3ExZII0rnAYYdbyFcSPVTenmEO9DEWQTKQ1nFLaWbk/p7jSowRqxHjeHzF3Px1oEz0JKPHreBBBIG9n4O463+2Oy/7g+huNpiug44fyFeQmPb7upYFnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5F3exIt1NNug3569BaJExehriZ3HMY0s5P+raRw6aM=;
 b=X7bjR0UeNCAC5QKhMqnuETQZa046V/8IQzn1Q01xHXxReNjdjfDL9f996NxYzVlzjRBSWY9/wMQdio5lgoDxIwXu0d154fj5feUMkvwyEI0ZcocpPimp0iQyJpUBiKAfzx5zYgayWLBwQq5orzh0YIKOmqc1l68kK4ijC/xrIAiogRXUbjq9s1U7Xn2zbLWuKXm82yRfy7wzyNSxha8Rb3Dt5++xHmBf+OFNl6/30YlPg2oxVsADD2qNYq2XjVdIZA3Pf8hu3WbsR6C3YZSsj1irS6IUrbolMbODIqYZGdF6i2cZ+DQsE/ZojZf/YAKLcnV9SVUoJ9mJpM8BPJjTyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5F3exIt1NNug3569BaJExehriZ3HMY0s5P+raRw6aM=;
 b=IMbVQGZThqnLJ/i7pWI9kX97zAn2Bt0saHi9xKc+jsxJ4wqVPb74zxxEurQf4kOpDP9f6pElMZbe72AeLWXHIdIdfzYZtZQcVLL6DoiJvbtBgT/Glcrn9dKHzzyGBkx8Wim7MCAB4mr3IP9VVURg3I/DmsbwqgTzdstX+fJrbRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAWPR04MB9909.eurprd04.prod.outlook.com (2603:10a6:102:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 14:39:21 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 14:39:21 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] btio: Allow binding a bcast listener before accept
Date:   Wed, 18 Oct 2023 17:39:12 +0300
Message-Id: <20231018143912.12284-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018143912.12284-1-iulia.tanasescu@nxp.com>
References: <20231018143912.12284-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0233.eurprd08.prod.outlook.com
 (2603:10a6:802:15::42) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAWPR04MB9909:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f99bbfd-4dba-49dd-f05a-08dbcfe80411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufD6u4dK5TCeucVhWFKK0K+KOHxxQuQHgJxjQl4KH1a+JZAriEzusLzGJ3ESrCgWQUfIf60LoRqra/gOp+UPTkYbMfTYrsGg/6jgLxFFcD+q5tnz2StC2QzX6MvMoAVyjH2u9ZfEeOkKO8xlXnLN2xp9m+Uoi1lyX2pOE3jobnH6yKVx60S5hlOl7ZKX9Te4nuomo1QhIb2UGic18sNMjY5wRtkf9GfIgEhgMXySGcvnb56YmPHZF56X8bP/pU9lbJkbXI9oo5p/R3TcLNMF8wQyqSxRrvKp4O7T8nQRZP3IinPN46gHyJIUwhjAdGMB1KgeNY6JnchIbFB452pIf+tIuNimb3ZLPVO1pGYSXhxy0oaRJ9juAbHPpVwvGuUv+mhCQWxfJdOwKfdn0t7N6OujOwC3M6c9Z1tKbCF3f6sKkc7LGKmP6AaVe5mx79Q+S/4S8uru3v+DPn06NZP2tHWT6U0iGTma9ClLTEjIF9NkEJ+6YVY9igeUHqfneEu7FuaqW9cl5qV4fSrXfSHYaVT7pmnLR2ql/ychscGeC/RI9L4JMLfIHp/0WR8z9veUNDAbde/NbxfVe7jxN7bIj05an+8KydyzVNwwD4zy9NciSIx104WoPCgRALoe7eyg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2013699003)(83380400001)(2906002)(8936002)(5660300002)(8676002)(36756003)(38100700002)(26005)(44832011)(2616005)(1076003)(4326008)(41300700001)(86362001)(6506007)(6512007)(6666004)(478600001)(316002)(6486002)(66476007)(6916009)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ff9uSo1NIbKUHLMaefbZIuBEVoVJiutfUJtxErCMGB0Q5zVFX8g5h9eqIlhZ?=
 =?us-ascii?Q?BWqj9yDw9ARoKiAJFK612wnfAlTSY2ZyVh5J+SJBjCb+a6k0bV404Xz2F5dd?=
 =?us-ascii?Q?ewe3JNVKwmA1DqxkqIDz8kg+Cj+8X6/qgR2tJiRPdNih9SXvo0vnR6FxS/a+?=
 =?us-ascii?Q?AEIhnb/3bwESNhGYKjxVxbQ7V97ugo86C3GnmX0IgoyB64N51VUsJto1m/9Y?=
 =?us-ascii?Q?Rs7pImBVfY7/CWI/V6n3BQfLSOH8Osr5Fhz57C1IN7lHhDSrxSgXEIOUPZwV?=
 =?us-ascii?Q?EjYgyg2V0GCj789OXiXsbOlUoZffFbAWr2bQgnXDx0QqZD4h/9QgZOi2tBNR?=
 =?us-ascii?Q?sMVkBRJ8swH7QRToM/gudBCZVCdTZoBOAPa5oeKE/awbfm+RpGd4XyWKrYyp?=
 =?us-ascii?Q?XSUb43lOLQ2PS4LzHE0wfLJrxl1SNfk9qGsj1aAvxIQsEd/QpsS15Iw5Xs8s?=
 =?us-ascii?Q?1QYddSAAprX9aSQAhPyU02R63zqzI6DD5x2CnICijEXqmVNY2MbWcpiGYBwV?=
 =?us-ascii?Q?RAXm6bk6Y3GxnJX5DE9492sAOIJKS7C3ry5TFxSV9E/Tsd4lDRPyEDYnaX6t?=
 =?us-ascii?Q?39Q85W7L9+LLoBPdegWA0VUtju103IE3hVOfVKJLeg5pPNVIk0oq5Q4irLfr?=
 =?us-ascii?Q?+eu6w+LwdRaPh1vPYv2Zw315o7lte6i9MJ/EZzmtINS29Caa8rr7YzHi44RT?=
 =?us-ascii?Q?wkqalnpP8OjinQfABFCWeNVvlnIEYOS+wi+7upz3h1mktOqMWRHvq6IATx+l?=
 =?us-ascii?Q?J1t7MuUXDZ82NyZBc5oN31/yZVa1v9kp33AQGTjm6lLws0p0hjhGwxQCYc3j?=
 =?us-ascii?Q?zwPBFZbnXCQuXmYk2wALAeTGHebW9Db/MsWToLP8Wbce/NIFT/kEgZ7WljZm?=
 =?us-ascii?Q?pytca46k8YFTDWtu+BbZMKbevafEvJz1cHFFP8QSoF1qinpclqVtxGYkenFw?=
 =?us-ascii?Q?jfLvrtrRa9M9M8WzD0d51IHyn8Mjs5PVUR/X5omgjHS7JinW5FN+ZtsRiyNP?=
 =?us-ascii?Q?P+sutOSLaLyva7MSFBQX9pM98njtjD83ok+3knZx5eBREI35osbM0tN/IokT?=
 =?us-ascii?Q?JM5n14mdVXekJ34gU/cSHaN5z2IqLpem7Gk4Yn2UkwqNLW1sZvA1UCOThLQB?=
 =?us-ascii?Q?omsgfMJEqY/m1J4326IY4pfm7C/Ku11AYdpzEnp1P+rvsBr7izFr2jnMBgtO?=
 =?us-ascii?Q?MGuB7lgmOG9ddjMebeMJeJ0Xfl0GspKSrO7SeQtCwps0zNWMRTGtibdonzod?=
 =?us-ascii?Q?LvR2/gaXvbYLE3jTsSiMOR43/UabuZoIUpPs+XsRgUgnfdYWMkJADil6QUo7?=
 =?us-ascii?Q?hRmfw/wHIsmqgpos1Nfl4oh7XYBWHhJJMoHE/RFPYi10wWln5IUEdOt4w6fe?=
 =?us-ascii?Q?5seT5Z0cQb9moUPC9L/5+pt/7PmyTGOKN54Ro0ggAub+GcDUdCWYtt5CEiF3?=
 =?us-ascii?Q?mUAIwqgcA2czMuBP/mut7JJd6pBapH201L1XC2CXqRBMLfpbwb11IcNTxA97?=
 =?us-ascii?Q?YdA0V4tPgJ0FKQMgshfUOMf9HoszFVE76q8azbnCFu0lEYl3/zFadoJN68HF?=
 =?us-ascii?Q?p6mFQSU79TmeqsM+Oi8eKE8ztp5cNRGvjD1I/Kn1F1tOWCE/Jp4c0wbUwB7L?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f99bbfd-4dba-49dd-f05a-08dbcfe80411
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:39:21.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWontg8/TAy9EwbOwngKjd9bwUv6euPUIbpldurdrUWuWpr+1SlHQSkfbDAdWU/2pYnTTwaWJ1dm8zk8cI9qHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9909
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds btio support for binding a PA sync io to a number of BISes,
before proceeding with BIG Create Sync.

---
 btio/btio.c          | 51 +++++++++++++++++++++++++++++++++++++++++++-
 btio/btio.h          |  2 +-
 profiles/audio/bap.c |  2 +-
 src/shared/bass.c    |  9 ++++----
 4 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index d45b8240d..82b45c152 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1796,14 +1796,63 @@ gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 
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
index 0ee3187d1..ce8b239f3 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -743,8 +743,9 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 
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
@@ -1129,8 +1130,8 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
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

