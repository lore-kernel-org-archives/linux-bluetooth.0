Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F672C04FDF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 16:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344887AbjHPQqa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 12:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344954AbjHPQqY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 12:46:24 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2048.outbound.protection.outlook.com [40.107.241.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F90730D1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 09:45:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSJw/FRXAO+M4N/1prcgV0F0yoy/6JoAEd0fvdWVKXjKAbiRL0SQkyW1mJv3bYYJpoDRrBTYHDsnZf3fO+l3HzDAz5wzPYw76izsfJ7OirOeR7pOHkRneFumZ7lJIx4oNudtGy+nr/j8y9v/Jbn5F/COi6uI5Tq9opz5hFA+hixFTArAMKZqOu6BbPq73Z4CYCGneJcgXTxVAuPxsWH2x95MN0L9J1EvQKms7JHwl3Rq4ifIc/lCs7SmVi3BcKWHlh5cctiGXaq06efpvMCZm80Qthe1p59MpvKAw8xIrk41VHK37+w9guqQVyKmBRW94Ch4Ch2soWtsq5s+HYyN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3vel0GjJILZCC8X8CYF3E09fErftPgol2Pbm6Ug+Wg=;
 b=ZHCsKH827pPMKIDhnItCGr44niC83FXxwjOU/TSadKMUWZJGS84lBm3tWGtyMgLe4F8STqed/e731qgrKOYLRB0k5U72j9H5q8f3XvZyVhgSE+gQ7ClDqXzq2dxTUnsxzNAhF2T9d1gve2yXyTvQO50nNRUOc6mxAGSx20Dqnotf3Asm8tr3QQSN02vqO8JQGZEzp6TxdRZGZKRqWDP8dOAO+aHoLJiNlOooSYSWxStuIbypjWan/rpafK39bGTCDMTDqJsgRHsNox3V8ggHBLNFs2e/iWJjbsvpRO4deI+uiLRoYl7U334G1RUL+mSuu5GkbYIQpSrCDlpAgCmqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3vel0GjJILZCC8X8CYF3E09fErftPgol2Pbm6Ug+Wg=;
 b=YAV8/+d+Tra8+pluk6TbyhgatkEgf7QkO5OLzUPBpsBnGDhoh4ZGCB+B6bKr/LmPYIAPMIvDICIqQncStJ/nURGJUom3jPi5swosjYoDFyMOk9Hj4QYzwk6asRmauzojHKEg/yNBDHeY5TvvTL9vUTjj2Pf/RzJ4Qh0fQHmjjA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 16:45:15 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 16:45:15 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v6 2/7] bap: Add support for BAP broadcast sink
Date:   Wed, 16 Aug 2023 19:44:30 +0300
Message-Id: <20230816164435.5149-3-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816164435.5149-1-claudia.rosu@nxp.com>
References: <20230816164435.5149-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:118::36) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM7PR04MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ec2164-f464-43b7-dbac-08db9e782a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SMPCeYQ+blVz0lGy9DNzloYjPgT7Pz0msTWASEA+BoBUFvqmiVC9qpIlMINXL9Gcvt+Sd1TCRGW59mfPi98ZYTNQ2mngheaa/dujZuZnsbuCBSFIv9wzqFJmaZxsCMl2fm8XQ3cGoDL0SMM55X+4+M1vqfS9lASGF8M7tahSpW0JbLi6SDOrpo9Qityd7HsiN269RLDZGC4GLAjP1cNWBBwfE1UUaZwrXIp/X9PxnyQKbVTzLdD2DjRr832+vZpAQFzE38W8JjK+yG+kue1iLNqRqcgjqX86QMWxB661bK60tSJrS82I9vhNPVwNYRUbsjvgkaDvmf/DcHubM9ss/BcxGT5DqtLfpzaRcpcg5aKMXzAF5jNaz/2QHEYfO5csfZ7ShZujTHbVGIhNZ45PqHWYtQn+oTcjUfv/Q6UqYDMyFpZs6Knmv/ogx26h81aVovikMxRqE8bU6aaexKFx9p4Hpj1SJ90hoebYAl+daCt8L68odpB0l7QDxr5WMeHaV83f8lFVFqMxvSuyBBYSrjR5UAbT+z3RnDDA9Oab8oDdQhCRuzWJa+rNzPjMQbmqTclSKxbNvhxj2P/NxWtX3al1iEZOlSyOCCFgwtSGmyDJJVpuHpADTa6FWCn1b5g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38350700002)(38100700002)(8676002)(4326008)(8936002)(30864003)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(6506007)(36756003)(6666004)(1076003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zLC0klOy+0oAo00NKd1CPWWQGC9Im7Bj6VD7ZpTiwGeNYXaER6NvUkVh9GmC?=
 =?us-ascii?Q?Gk7Uvyua2t/giuSRiKttoNg1GeahSf+d/vaHAb4gyqpqaLCOsxDvkQEdcgyB?=
 =?us-ascii?Q?7rtnH5dr+WFlkNt4QNdqkyddBbAAxY+FEFnrIv+aFI3ljJ5/vXsvz80YSNFB?=
 =?us-ascii?Q?Wkhqa9XN0W1xB7ks1kDxED3UcJgolLSqQmeoEglARpK+qDp5ClxPjLJ/QuGe?=
 =?us-ascii?Q?jh37PnmqqzGzqmJhXBY0Ibcn1kRNnYQCalh+pSMDZPBZ2c78wKNCm63HdzzB?=
 =?us-ascii?Q?nTW81i/n37jrZJiFDHlEVHkd8XDktSftWA6ZoS6nF30xsvv1bG0c8uRTGnQj?=
 =?us-ascii?Q?h84QeBZ3Q5O6xTxkQxs0lObRWH7W1F/+bayfzHBLpBOaJ8k8t59NWvHIWy1e?=
 =?us-ascii?Q?SZwSQLOl0le3iN6dOz17IU+PWQPpmGknlJIe36HQz3hr7qOf7AyzRGHxlrPv?=
 =?us-ascii?Q?y65LVoTSl5JjyH/QgElhiMjhPjwaLt0lt87OH1necs1ywXm0b/P7x+A+ZwFM?=
 =?us-ascii?Q?p9WRl43p68M5JhEJxoMlm0ek22FHF5/d5NDciIZw3vSG5oWbnaRcWu/kJvNT?=
 =?us-ascii?Q?955BsTBciNtD8t8yRMiHvm0Xg8ywJVsTVN+wGwb9jKKBekzHs631ny8TaImB?=
 =?us-ascii?Q?DSlAv1XZ9z7YA2jUkCpTXzIg6NzboZMkxXaJh58BaAQn19v7AWsphKW2yw67?=
 =?us-ascii?Q?mGQLm1nDNts2T41/U1TmVkX6RJ+0SkE1HvHQVMYX5hpOSoOGPY2uHE+TfnEw?=
 =?us-ascii?Q?4TaEEtgSogmHkqdirOmQ3Tn9flk9ZW24rfxdyIOJkVNlHMFxYzhk7kWhqjbF?=
 =?us-ascii?Q?1lFkFaTPeSeSA6f05H+Xjlzhn759DOSURYGSfqcVRzTjmjeBtZc5jfJbU4S9?=
 =?us-ascii?Q?Y8xNcbdpB6YLNYqmtcL1vxLk9/I4fegmcFPowf+qi9qULDaVhyvlZ4KHjcWZ?=
 =?us-ascii?Q?fAjONhWgjrhRlpwhf39eEwV41Wb/grR8T8R6pJX6E1qhigPbbRLCGhehqq+x?=
 =?us-ascii?Q?r1KNruSKIHRMvz/7gSZ5yO00q1j6heMeIXEFy+9bv2aF8GqE0DhYHOYC7yjH?=
 =?us-ascii?Q?aWEJwYeLchhd1sXcRlU/4XbWMv0lE9xXUYahdTvEC65cmZGjPs8YcRtJw6v9?=
 =?us-ascii?Q?Uyw0sR7jNQ7bYibBEkil3oSvaFi+Sr+4d5VQf3UxacQQRP5TUnImKHpITxPZ?=
 =?us-ascii?Q?jYGQYuWB1SW0ttW3RE2aYiafHCM08JZKpd4AGPpwqQKgrKagTimfH8KhLD+P?=
 =?us-ascii?Q?rOAV5av3mGBhIMj0E6MfMQ5Moc0rglYZbotBolBJtNKZzxJ2oVEA6fm+RZe4?=
 =?us-ascii?Q?Flcd3ydLWfkSf7/Ull3/gecz9i21/UHoKX9fQuZoHLQvD09EZSVkibNDyAC6?=
 =?us-ascii?Q?fPA1jQNIFFI807YcabW4uxjm7VcIQ/Q2OeKPqK0oivBsgE7xMgviHRA1BxG4?=
 =?us-ascii?Q?RQ6Zzb/XNL++M+zfUOzxJt7WRvPd8KXMTzxlQOYz0jmHkTZt9FtVnaGKgzy5?=
 =?us-ascii?Q?pc8claFOFx+zbBR0MorUvyepTu2AIscdhe0+qBgefvkXaTJba2Iz+I6JMZAa?=
 =?us-ascii?Q?BSS9MjUWKyVdc4oAvy/H7QluD4wzgCkqP+LBU6+r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ec2164-f464-43b7-dbac-08db9e782a4a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 16:45:14.9257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCUusjrmAMxrTPij4jLj2WJgRv3vXTlafmi4AHtGiNZVLBEEnkve8gkKS0mKf9rk6lcVz72gpeTH0WDpGfRo5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997
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
 profiles/audio/bap.c | 313 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 287 insertions(+), 26 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8cbb238ef..5e84e0c27 100644
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
@@ -1901,6 +2147,17 @@ static struct btd_profile bap_profile = {
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
+	.probe_on_discover = true,
+};
+
 static unsigned int bap_id = 0;
 
 static int bap_init(void)
@@ -1911,6 +2168,10 @@ static int bap_init(void)
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

