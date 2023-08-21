Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72540EE49AA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 15:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbjHUPvm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbjHUPvl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 11:51:41 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0F9F1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 08:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb9oIlLwfjUKq3FqrHO8qnUoJdW4jGUP13DjszdeDNX+bRQCxjG1MtyE9mjjcNsF+Fz1VllrjlUOiA2rzcVvflnoJQi2mF2uZ6N8Bulk72+ZrfzPNh7TxcjQFLa43z0JlAwc3aD2sNzJwVhCwMGUW3J5uNSHhZxlo4XaEbfM8bChaZgUilt1gJoLn4ZChwFH2AqCCdk2voG4wS1ZhoPifDPIjddN4W5EgNziDx5MDE9cQtdXVhR5U41nX/XrzORzuyzKNQKWGUzG3hf6h4WcSD58ZxfOXeDfvjE6FoLvznPMWHcMLIsAqKhR9/OzXplTiJl6EM+H7vzRb//eWTmDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UsPKt6Zv5B0rP9rpjOnZ3FPsObhSZASkjFInhC92CU=;
 b=YMekDocWflDhEng2tOCFcpOTgbk0V88LcieppXH2J6Ex+9vWJs6rw7aT4K1uw/0cpa/y0AmsieJm1cpeElvUX8PGlIbY9Rq9qRzPbA/kNcwbu+4BXz5s+IELZRa/99/7RGIE7FxCyL/T1PZ2BkO5faHkwaTPsq7LWQTxjtoaHuJT6pjZqFxQhuBSlZlGp0l2U4BnTiYrKciHY4YeKQi9oQWQ9xA0vD3woWoYmKDFVLHZGK078zFKzGkUc7zB7lLF9lbLY2tsYIQKSnphasg2Ujt7MnyL+j9N4XX2yhlxO+31Y97UbE/ahp/DRmkFBcFyWX1k99xYoSyzRADfDz5PIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UsPKt6Zv5B0rP9rpjOnZ3FPsObhSZASkjFInhC92CU=;
 b=j0arvLOA31Znl5Qfv1bQNqbpJaMuvfjT7Xi4JDl9sMQkdpQRazg5yMUbeMqAdip+rvQbb+3FrsAC/HE3cDfpJOinzenFtroGd7SQt9RfYyH3EJXLxu+xPDCyJat3GINxqozTWKBqPLCUgjyTgRqMsqYBJQ++S2wGhRssdK6W4Mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by GVXPR04MB9952.eurprd04.prod.outlook.com (2603:10a6:150:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 15:51:36 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 15:51:35 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v7 2/6] bap: Add support for BAP broadcast sink
Date:   Mon, 21 Aug 2023 18:51:00 +0300
Message-Id: <20230821155104.86954-3-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821155104.86954-1-claudia.rosu@nxp.com>
References: <20230821155104.86954-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:208:55::32) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|GVXPR04MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e007588-d7a4-4afd-a876-08dba25e7fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qgf1L9bp4fMW/XRoDVjhJrUk5Ky/rMLLCp/Zuw8odp+lb2wtYHpKz80U+So4AWALuc6swzsooEctCN0Vc93xOE5McIGe8Z7tXsZ6S0a9nVyCqR547zH8XcVuQEuV/9nabLB5LVeGAH3HE8XTJgJqYbOfguzRv+QpL4Tr2Jw8hFR3IKACR8hiyexjf1E31iX+AwFhMys0LtLZ8yy56bM25Tjm4RHuTCfSj/5IGMd2SQ9MGwJqR63Z/brmEmpE+mQ3oI4p8/gPI4oou0ybg/sSwFd2CQpoO/VQCtjV+WP64iZeHCE9wZxsovTre2VA82JX0x/F7cnlpEvHMtv79uynjw6B1CLtRWG7mLpBu0i/MT8CgoG+peQllPHmD2IzJEsPvvSOMYzwvb+nqHC6u0vzOhWAfKQnnAUM5/Y4UIBt5e112hF/8EHjbRMeuo0fjBH09GCPbhzRz2pMpJqO2hToVdqVLQVgvLscf+7dHCey62/tTffMG7nnEyOtP7/b1HVy1+QiM0ZnOdHzk+3cJTRLpxr6okdd++f907pdFkJq3L8kBDYqzNr4HulD4DBMRNjfz3O/Chs7jKfAmDZ/FoFHGTx9rGLlRcimalGFs0xAGqlH1/spGgy6mWn1qSqtl1D/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(30864003)(52116002)(38350700002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gbGOSEkq93wQK9s/pnnbN1CF/I9sYzVFpWluIuRJrcc1TQtQdGQ3tsFJCQE3?=
 =?us-ascii?Q?C6EjIdrltUWlWoXa+RKJKZKeXGvsys2s6QmIo8JgMN4PqrWoH1XsCZXIdGfZ?=
 =?us-ascii?Q?lfTBQcg8FT8ycsUa/IfTrpVAoZ+R5Ce4ks5bFd3tlmrLyUEdG4B/bdltbErQ?=
 =?us-ascii?Q?dvOJ12fUGdcAB31F6a0Muz7TpZBfaQGaZwVSnswdzH9m3xBL6QphcNCyDFW3?=
 =?us-ascii?Q?Ozd4idWFHu8CQmLJ/mdPscm8QjENV5gASeCMvF+gsKLnhU/an/pu/c1dsVSf?=
 =?us-ascii?Q?0aZdi5SKIMYR+khHeTiPSVOouR+kZHlTGGypncrflhX/C6IiYH92+aRYVYmJ?=
 =?us-ascii?Q?z7pG4elN/2doMyvC7gZSs4LsU3P7dlt5QIVS1IDVRZKnu4OGCGpk9SIv9ZfG?=
 =?us-ascii?Q?X2U8hKw3o3qXhC2NbKmube6Af5oRA0zRBZfgxYWMPJnMIVnFjnzVclzfq/TX?=
 =?us-ascii?Q?YWqsLinYygfck+mwhQaY6kze4F6tDSs9Z4wESbc1z7EfhdB8XmiQUi8xDrQ1?=
 =?us-ascii?Q?r/ACp303Ob0NYwjRlId/TbVV/v/fBFQT8Fri7447WXuHkRGVDhWtb2aLN+oU?=
 =?us-ascii?Q?cmkjyAOtX/0veZqtQ3lVqmXWwR8u8cCgb00gz0r3aItDVl+0wz8IcjX5UTe6?=
 =?us-ascii?Q?yuMShKkfosbJy+AqrviTK/K87NMpuqg5QArDBYx6a1M5qGE8U18hu6pKYt7K?=
 =?us-ascii?Q?xNTrCOSqRouiswsUMw/tzOmPRgPqrycvC3ru6B3hOdV++vBuxCmamA/RBsFy?=
 =?us-ascii?Q?9pCpY5i8ofvh0FxbbiHOx4/N/bWaRnXt6enSkmjLAuhZ8YH421CNYXHf90eY?=
 =?us-ascii?Q?ZHwoUBVPdlLo2Li2jjK40l/gNFowKnzle3jkQZwEou+dJ+ptWsd5JCSpc/k0?=
 =?us-ascii?Q?LAgc9Pz5oh79icby+EfRTsPQJ+MKl7qQY3nUDAw8ok+RUpf05dEMtUwoS/W5?=
 =?us-ascii?Q?wfrJH0FVDzSoseHv4n33752XsesiUR6CXFwHuNwZ1E9asMvC8qhDMd2QxdKz?=
 =?us-ascii?Q?IxveJM4Wa6jdIg9ByXHpDuBqT2j4X2IMOddihYuHTdHGIs6ObokGCqfYAgc3?=
 =?us-ascii?Q?QEKvoqwqdPI+wQNcCglkmEp1dVKTOJlrmnMPlCsmX/YmGUBxDNbzC1rpzyLP?=
 =?us-ascii?Q?P/4F8dgbtuH37gTwh9ibfREa03fyKNrt/eNszoBice+71csbRGhm3X6RqT1p?=
 =?us-ascii?Q?ebMjHEonZveAe1dpGx8BjqY6L6T3WWNrWRplnPIYb692kv4G3fvxwxiOYDRB?=
 =?us-ascii?Q?Yy7Xx8O6TCvEo53ybSexjTBXPDwBwAXmCdrs4pvJgXoN0pXS70yv6bhCKdDT?=
 =?us-ascii?Q?7UJFdjfUtT9FWrmIq7RBmOi1sAT/z0yQda1mhq5cAfdfFDXH2+w6c0DEL4b3?=
 =?us-ascii?Q?7JNFmm7IUDJCuFpDvctdwDptYovm35o2IIH4gMw6gF6ER/h6UvT0dBTbUBxH?=
 =?us-ascii?Q?oh92ZYwLkHmsYS6GNJ1dKhCVfNNUFm3HfwfUO+7wxcO/4GKxCKtgQquH38mM?=
 =?us-ascii?Q?vR7k/h+rp6Kd1Eh6sggyussU5SuZAYwFEG2iZebHx9jpwfPJDjVRJRi7s9vX?=
 =?us-ascii?Q?N0kk4QOvcR5/ugm+XzYlcSZarTejgwdxR4AM04Ed?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e007588-d7a4-4afd-a876-08dba25e7fbf
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:51:35.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCg0wcpc0ZQFs2zzZ3UB9bTmEjGixueZwJeESXd2gZ5F3E9+pm3KOiKI3OQrsJ2VhL2z8eiH/4iz5S58lPOZxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9952
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support for BAP broadcast sink, creates a remote endpoint when a
broadcast source is discovered and synchronizes with the source upon
endpoint configuration.
This feature was tested using bluetoothctl with the following commands:

[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[bluetooth]# scan on
[NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
[bluetooth]# endpoint.config
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
/local/endpoint/ep0 16_2_1

---
 profiles/audio/bap.c | 312 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 286 insertions(+), 26 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 922eac50d..187140232 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -34,6 +34,7 @@
 #include "lib/hci.h"
 #include "lib/sdp.h"
 #include "lib/uuid.h"
+#include "lib/iso.h"
 
 #include "src/btd.h"
 #include "src/dbus-common.h"
@@ -57,7 +58,9 @@
 
 #define ISO_SOCKET_UUID "6fbaf188-05e0-496a-9885-d6ddfdb4e03e"
 #define PACS_UUID_STR "00001850-0000-1000-8000-00805f9b34fb"
+#define BCAAS_UUID_STR "00001852-0000-1000-8000-00805f9b34fb"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
+#define MEDIA_INTERFACE "org.bluez.Media1"
 
 struct bap_ep {
 	char *path;
@@ -186,6 +189,9 @@ static gboolean get_uuid(const GDBusPropertyTable *property,
 		uuid = PAC_SINK_UUID;
 	else if (queue_find(ep->data->srcs, NULL, ep))
 		uuid = PAC_SOURCE_UUID;
+	else if ((queue_find(ep->data->bcast, NULL, ep)
+		&& (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)))
+		uuid = BCAA_SERVICE_UUID;
 	else
 		uuid = BAA_SERVICE_UUID;
 
@@ -207,6 +213,19 @@ static gboolean get_codec(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean has_capabilities(const GDBusPropertyTable *property, void *data)
+{
+	struct bap_ep *ep = data;
+	struct iovec *d = NULL;
+
+	bt_bap_pac_get_codec(ep->rpac, NULL, &d, NULL);
+
+	if (d)
+		return TRUE;
+
+	return FALSE;
+}
+
 static gboolean get_capabilities(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -248,7 +267,7 @@ static const GDBusPropertyTable ep_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Codec", "y", get_codec, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Capabilities", "ay", get_capabilities, NULL, NULL,
+	{ "Capabilities", "ay", get_capabilities, NULL, has_capabilities,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Device", "o", get_device, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
@@ -556,7 +575,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE) {
-		/* Mark CIG and CIS to be auto assigned */
+		/* Mark BIG and BIS to be auto assigned */
 		ep->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
 		ep->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
 	} else {
@@ -597,13 +616,126 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
 		/* No message sent over the air for broadcast */
-		ep->id = 0;
+		if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
+			ep->msg = dbus_message_ref(msg);
+		else
+			ep->id = 0;
+
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 	}
 
 	return NULL;
 }
 
+static void update_bcast_qos(struct bt_iso_qos *qos,
+			struct bt_bap_qos *bap_qos)
+{
+	bap_qos->bcast.big = qos->bcast.big;
+	bap_qos->bcast.bis = qos->bcast.bis;
+	bap_qos->bcast.sync_interval = qos->bcast.sync_interval;
+	bap_qos->bcast.packing = qos->bcast.packing;
+	bap_qos->bcast.framing = qos->bcast.framing;
+	bap_qos->bcast.encryption = qos->bcast.encryption;
+	bap_qos->bcast.options = qos->bcast.options;
+	bap_qos->bcast.skip = qos->bcast.skip;
+	bap_qos->bcast.sync_timeout = qos->bcast.sync_timeout;
+	bap_qos->bcast.sync_cte_type = qos->bcast.sync_cte_type;
+	bap_qos->bcast.mse = qos->bcast.mse;
+	bap_qos->bcast.timeout = qos->bcast.timeout;
+	bap_qos->bcast.io_qos.interval = qos->bcast.in.interval;
+	bap_qos->bcast.io_qos.latency = qos->bcast.in.latency;
+	bap_qos->bcast.io_qos.phy = qos->bcast.in.phy;
+	bap_qos->bcast.io_qos.sdu = qos->bcast.in.sdu;
+	bap_qos->bcast.io_qos.rtn = qos->bcast.in.rtn;
+
+	bap_qos->bcast.bcode = new0(struct iovec, 1);
+	util_iov_memcpy(bap_qos->bcast.bcode, qos->bcast.bcode,
+		sizeof(qos->bcast.bcode));
+}
+
+static bool match_ep_type(const void *data, const void *user_data)
+{
+	const struct bap_ep *ep = data;
+
+	return (bt_bap_pac_get_type(ep->lpac) == PTR_TO_INT(user_data));
+}
+
+static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct bt_iso_qos qos;
+	struct bt_iso_base base;
+	char address[18];
+	struct bap_ep *ep;
+	int fd;
+	struct iovec *base_io;
+	uint32_t presDelay;
+	uint8_t numSubgroups;
+	uint8_t numBis;
+	struct bt_bap_codec codec;
+
+	bt_io_get(io, &err,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_QOS, &qos,
+			BT_IO_OPT_BASE, &base,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	g_io_channel_ref(io);
+	btd_service_connecting_complete(data->service, 0);
+	DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
+					address, qos.bcast.big, qos.bcast.bis);
+
+	ep = queue_find(data->bcast, match_ep_type,
+			INT_TO_PTR(BT_BAP_BCAST_SINK));
+	if (!ep)
+		return;
+
+	update_bcast_qos(&qos, &ep->qos);
+
+	base_io = new0(struct iovec, 1);
+	util_iov_memcpy(base_io, base.base, base.base_len);
+
+	bap_parse_base(base_io->iov_base, base_io->iov_len, bap_debug,
+			&presDelay, &numSubgroups, &numBis,
+			&codec, &ep->caps, &ep->metadata);
+
+	/* Update pac with BASE information */
+	bt_bap_update_bcast_source(ep->rpac, &codec, ep->caps, ep->metadata);
+	ep->id = bt_bap_stream_config(ep->stream, &ep->qos,
+					ep->caps, NULL, NULL);
+	data->listen_io = io;
+
+	bt_bap_stream_set_user_data(ep->stream, ep->path);
+
+	fd = g_io_channel_unix_get_fd(io);
+
+	if (bt_bap_stream_set_io(ep->stream, fd)) {
+		bt_bap_stream_enable(ep->stream, true, NULL, NULL, NULL);
+		g_io_channel_set_close_on_unref(io, FALSE);
+		return;
+	}
+
+
+	return;
+
+drop:
+	g_io_channel_shutdown(io, TRUE, NULL);
+
+}
+
+static bool match_data_bap_data(const void *data, const void *match_data)
+{
+	const struct bap_data *bdata = data;
+	const struct btd_adapter *adapter = match_data;
+
+	return bdata->user_data == adapter;
+}
+
 static const GDBusMethodTable ep_methods[] = {
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("SetConfiguration",
 					GDBUS_ARGS({ "endpoint", "o" },
@@ -649,15 +781,17 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac)
 {
-	struct btd_adapter *adapter = data->user_data;
+	struct btd_adapter *adapter = data->adapter;
+	struct btd_device *device = data->device;
 	struct bap_ep *ep;
 	struct queue *queue;
-	int i, err;
+	int i, err = 0;
 	const char *suffix;
 	struct match_ep match = { lpac, rpac };
 
 	switch (bt_bap_pac_get_type(rpac)) {
 	case BT_BAP_BCAST_SOURCE:
+	case BT_BAP_BCAST_SINK:
 		queue = data->bcast;
 		i = queue_length(data->bcast);
 		suffix = "bcast";
@@ -675,8 +809,20 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	ep->lpac = lpac;
 	ep->rpac = rpac;
 
-	err = asprintf(&ep->path, "%s/pac_%s%d", adapter_get_path(adapter),
-		       suffix, i);
+	if (device)
+		ep->data->device = device;
+
+	switch (bt_bap_pac_get_type(rpac)) {
+	case BT_BAP_BCAST_SINK:
+		err = asprintf(&ep->path, "%s/pac_%s%d",
+			adapter_get_path(adapter), suffix, i);
+		break;
+	case BT_BAP_BCAST_SOURCE:
+		err = asprintf(&ep->path, "%s/pac_%s%d",
+				device_get_path(device), suffix, i);
+		break;
+	}
+
 	if (err < 0) {
 		error("Could not allocate path for remote pac %s/pac%d",
 				adapter_get_path(adapter), i);
@@ -685,14 +831,13 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	}
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
-				ep->path, MEDIA_ENDPOINT_INTERFACE,
-				ep_methods, NULL, ep_properties,
-				ep, ep_free) == FALSE) {
+			ep->path, MEDIA_ENDPOINT_INTERFACE,
+			ep_methods, NULL, ep_properties,
+			ep, ep_free) == FALSE) {
 		error("Could not register remote ep %s", ep->path);
 		ep_free(ep);
 		return NULL;
 	}
-
 	bt_bap_pac_set_user_data(rpac, ep->path);
 
 	DBG("ep %p lpac %p rpac %p path %s", ep, ep->lpac, ep->rpac, ep->path);
@@ -824,6 +969,7 @@ done:
 
 	queue_foreach(ep->data->srcs, bap_config, NULL);
 	queue_foreach(ep->data->snks, bap_config, NULL);
+	queue_foreach(ep->data->bcast, bap_config, NULL);
 }
 
 static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -1310,6 +1456,45 @@ static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 	data->listen_io = io;
 }
 
+static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
+			struct bt_bap_stream *stream, struct bt_iso_qos *qos)
+{
+	GIOChannel *io;
+	GError *err = NULL;
+	struct sockaddr_iso_bc iso_bc_addr;
+
+	iso_bc_addr.bc_bdaddr_type = btd_device_get_bdaddr_type(data->device);
+	memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
+			sizeof(bdaddr_t));
+	iso_bc_addr.bc_bis[0] = 1;
+	iso_bc_addr.bc_num_bis = 1;
+
+	DBG("stream %p", stream);
+
+	/* If IO already set skip creating it again */
+	if (bt_bap_stream_get_io(stream) || data->listen_io)
+		return;
+
+	io = bt_io_listen(iso_bcast_confirm_cb, NULL, ep->data, NULL, &err,
+			BT_IO_OPT_SOURCE_BDADDR,
+			btd_adapter_get_address(ep->data->adapter),
+			BT_IO_OPT_DEST_BDADDR,
+			device_get_address(data->device),
+			BT_IO_OPT_DEST_TYPE,
+			btd_device_get_bdaddr_type(data->device),
+			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+			BT_IO_OPT_QOS, &qos->bcast,
+			BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
+			BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
+			BT_IO_OPT_INVALID);
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+	}
+
+	ep->data->listen_io = io;
+
+}
 static void bap_create_ucast_io(struct bap_data *data, struct bap_ep *ep,
 				struct bt_bap_stream *stream, int defer)
 {
@@ -1364,10 +1549,10 @@ static void bap_create_bcast_io(struct bap_data *data, struct bap_ep *ep,
 	memcpy(&iso_qos.bcast.out, &ep->qos.bcast.io_qos,
 				sizeof(struct bt_iso_io_qos));
 done:
-	if (ep)
+	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
 		bap_connect_io_broadcast(data, ep, stream, &iso_qos);
 	else
-		bap_listen_io(data, stream, &iso_qos);
+		bap_listen_io_broadcast(data, ep, stream, &iso_qos);
 }
 
 static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
@@ -1417,6 +1602,11 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (ep && !ep->id) {
+			if
+			(bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK) {
+				bap_create_bcast_io(data, ep, stream, true);
+				return;
+			}
 			bap_create_io(data, ep, stream, true);
 			if (!ep->io) {
 				error("Unable to create io");
@@ -1424,7 +1614,6 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 				return;
 			}
 
-
 			if (bt_bap_stream_get_type(stream) ==
 					BT_BAP_STREAM_TYPE_UCAST) {
 				/* Wait QoS response to respond */
@@ -1475,12 +1664,12 @@ static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
 {
 	struct bap_data *data = user_data;
 
-	if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE) {
-		DBG("pac %p", pac);
-
+	if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE)
 		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SOURCE,
 						pac_found_bcast, data);
-	}
+	else if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SINK)
+		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SINK,
+						pac_found_bcast, data);
 }
 
 static bool ep_match_pac(const void *data, const void *match_data)
@@ -1596,14 +1785,6 @@ static bool match_data(const void *data, const void *match_data)
 	return bdata->bap == bap;
 }
 
-static bool match_data_bap_data(const void *data, const void *match_data)
-{
-	const struct bap_data *bdata = data;
-	const struct btd_adapter *adapter = match_data;
-
-	return bdata->user_data == adapter;
-}
-
 static bool io_get_qos(GIOChannel *io, struct bt_iso_qos *qos)
 {
 	GError *err = NULL;
@@ -1733,6 +1914,71 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 	bap_data_remove(data);
 }
 
+static int bap_bcast_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct bap_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+
+	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
+		error("BAP requires ISO Socket which is not enabled");
+		return -ENOTSUP;
+	}
+
+	/* Ignore, if we were probed for this device already */
+	if (data) {
+		error("Profile probed twice for the same device!");
+		return -EINVAL;
+	}
+
+	data = bap_data_new(device);
+	data->service = service;
+	data->adapter = adapter;
+	data->device = device;
+
+	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
+			btd_gatt_database_get_db(database));
+	if (!data->bap) {
+		error("Unable to create BAP instance");
+		free(data);
+		return -EINVAL;
+	}
+
+	bap_data_add(data);
+
+	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
+								NULL);
+	data->state_id = bt_bap_state_register(data->bap, bap_state,
+						bap_connecting, data, NULL);
+	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
+				 pac_removed_broadcast, data, NULL);
+
+	bt_bap_set_user_data(data->bap, service);
+
+	bt_bap_new_bcast_source(data->bap, device_get_path(device));
+	return 0;
+}
+
+static void bap_bcast_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bap_data *data;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	data = btd_service_get_user_data(service);
+	if (!data) {
+		error("BAP service not handled by profile");
+		return;
+	}
+}
+
 static int bap_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -1901,6 +2147,16 @@ static struct btd_profile bap_profile = {
 	.experimental	= true,
 };
 
+static struct btd_profile bap_bcast_profile = {
+	.name		= "bcaa",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.remote_uuid	= BCAAS_UUID_STR,
+	.device_probe	= bap_bcast_probe,
+	.device_remove	= bap_bcast_remove,
+	.auto_connect	= false,
+	.experimental	= true,
+};
+
 static unsigned int bap_id = 0;
 
 static int bap_init(void)
@@ -1911,6 +2167,10 @@ static int bap_init(void)
 	if (err)
 		return err;
 
+	err = btd_profile_register(&bap_bcast_profile);
+	if (err)
+		return err;
+
 	bap_id = bt_bap_register(bap_attached, bap_detached, NULL);
 
 	return 0;
-- 
2.34.1

