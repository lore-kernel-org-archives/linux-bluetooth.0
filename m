Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762D6EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 12:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjGLMYr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 08:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjGLMYp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 08:24:45 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2084.outbound.protection.outlook.com [40.107.14.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F079F134
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 05:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSFOgRHxglLg7Ke/lW4VBpvKmklGnAvTiD4DydjIl55+ubsVvNc0A9f6L7LDqcvXM54CUhwWLIPRF72b2Y/jvBaOXx/ksIqfg4Qw33KRudamVP9waxJFQ4Kf22AqK2PuGMQvWHKPvlOXDikkpC/XtIIuWj6RtRn2kZVmnZsmYxns1zF65Ioi406UwdopES53kx3fDY/2/8D8DwcPbdte9temD2d2Sr/hwcj1HyPDLCYATjtsvG7I7b9CGeEMsT8Q4IPZlT+ocWXn8MxP/GOW7TVTfJdSN1dKluAVM+nEi0ujW5Y2VphSJTqOZwiqdbiyHiDopAp8m8DbVtDEtWWujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0N0ZYtO8OeHHsDbmvViYa1abPb6Z1wfDuv1NAo6qi0=;
 b=OsdKqu13pskuaHNAi1rt9rwsLN+agA/IVEaErVJMNIKnzduvJPx6q3/GNWec79Mdm8UQ3giHIqMJWXfmYAVg3Vxr0IpqMHdLQuI0+/d7MNQhQeErveLZ+aFxZn8NRCxlSBeCfb5NKQCmnWy2hTo/6yBlDqmwbAHuser33NBGrBnjZdIUL2T8Ggr6imUKq0wem7ff8iGIl8e6UTs8ilF3si1d6BgFlt+eiNtyK+4KZb9n4Es4mbm931tS9se35GCSCkz0xdSaqR9jh1zV8gpzcZycuJdKtAypsO0a0Xid6FMJpDvHayvI0k1n+xpRuxN8gmQtW8wWfPP7nKVVbQot3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0N0ZYtO8OeHHsDbmvViYa1abPb6Z1wfDuv1NAo6qi0=;
 b=IxqlaWNv67NEXjS0VnbVkiMGlLXYT9l1eOI+gJlzqKFTOjv5r7UNI+HMOwtglI8OabBaF7t1EwUCY0JB4o+Ojykbwe0iVPsLLHJjpYS6yjsz5UDqSHKLEtrVLtDVcO1ckWGPhvOiu1OX3x6RAxk0EKFyTiuxdN2cgvBDa2HUnfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM0PR04MB6835.eurprd04.prod.outlook.com (2603:10a6:208:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 12:24:39 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 12:24:39 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v2 6/6] bap: Add support for BAP broadcast sink
Date:   Wed, 12 Jul 2023 15:21:35 +0300
Message-Id: <20230712122135.7734-7-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712122135.7734-1-claudia.rosu@nxp.com>
References: <20230712122135.7734-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0019.eurprd03.prod.outlook.com
 (2603:10a6:208:14::32) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM0PR04MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e363ef-babc-4387-9659-08db82d2f693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyHnwmo8pquBPnign4DdZQb7ciYQqA/v+UENJr9HAm19xMIJeSA4c3+tl1HrCm+oPzkLAnikefhEHHVBJHa7gRRa6d1my3Hl1ooYqfzOn3U58RSRcqljF3dBOhb8rzMenELhHoOBGrf2xfOR0TCIz6vo0ydKMkRPHiidwWLxuA8YPUm6YaBLG9QYvUeuU0StrYMeqOql97KkK1oA7hA6dtleNvnz/jrHn0FEYukZjy1SujJGKhnLVINLnyhjUmxqejIiqJzpHf4QD17t1CcNGBobAAI+l9Pefyxh6LkOYsckqfb18431wBViG6veC7DHH9XR6jtHHjIozdSDnlZl5hwBpMeDEpUVfwsttkGmL1CCFPIL/tGde27pdQTrousUzVTCAiFyfV9z13GqDr7YNETBEkp0mMHVgmZzctpLwrss3alyJcH8w1BHtwS3CzvAEe/6HwFSz8UzTt0bQlIduz2PlYmBfG31lKG5BMXkk9DvbMxfox+m6SoX5/J+SjbRTYYF6Uc4EH7G9ao6nyRuij/8bvaTfBSjBjnFfXb2UH4KuxrjxACdmCi7GIsLa1UN6b74+JC6OYo0FBoMCOe4iixNSeLGbtnJp9t+pVlKJk6wmo+XUQsIUnlhvl/mzdIj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(8936002)(8676002)(38100700002)(38350700002)(41300700001)(2616005)(2906002)(316002)(5660300002)(30864003)(66476007)(4326008)(6916009)(66556008)(66946007)(6666004)(6486002)(52116002)(6512007)(83380400001)(478600001)(36756003)(1076003)(6506007)(55236004)(186003)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x66i2sNe4ladP+KmrMC5BA2qjz691CHpDGfpgJKZMOtL2UyCzSiETlTeSQtB?=
 =?us-ascii?Q?53S4Pxk8K4cwlCldIgLUdIB8n2KRjjrqYZAUsNBz0WIdyaIDiBDn4AFjjSlq?=
 =?us-ascii?Q?H5mX1Ay1TCKbwLNMBsLSYZaypu9ztPFJUO9TBpF2CBinjxleDwPEnERyfilS?=
 =?us-ascii?Q?a2EzWyY2nYLO63Llrk0ciXVLuSNTZhlQUfceQW70jVLc4E3U70xjkJMAQ7GR?=
 =?us-ascii?Q?Bgq+vNAoWIBozZ2z9dVZyVifzcJ8IAnSnodj27pJhrROhmebqdqJ5oZcnBQE?=
 =?us-ascii?Q?IyzyIOTKDg3Zbd8A8EKNAOq7Tb95bSl+f/zVC6HGvDrLB/fuN1l5nznzVVfZ?=
 =?us-ascii?Q?iaQhDlZmI984ryi3+kSioT904rXJYe/bdeXfJfhAa8asgfAxj1dy3j+KblI8?=
 =?us-ascii?Q?BRUzhLl2xdIzRTN1POEByZHIc0n9lxSSr48ISXucPBMegw7eNy+3OO/OkoAt?=
 =?us-ascii?Q?Io1/s0nZSmTkynWbvBEO4C8qH4TavjTnOUHJI4hxJX8pjZFpXuYYr4aO6BY7?=
 =?us-ascii?Q?3hv+Cvv/K1ZP1y6Jha8FzKDrREZzv3lYXs18BmpN38NUsk9BdXQasUzA2Ejn?=
 =?us-ascii?Q?YBjtgFdAjKFR/f/7jOGxGdqpunkMv0bVXsX/bDytKrMIXjikA8h/v7fl3Fuj?=
 =?us-ascii?Q?NR3bTEdd4pt9ZQiaOaCLKIziarx4KlqigXvGjT2LRHtPxRtUg/vPsfYD8hOL?=
 =?us-ascii?Q?fqy+O4UZXNGKEYEg5t6fOWr8Dh7D8BMF/aXN3oD2ZEHnNKCA2QBpTGtz51RY?=
 =?us-ascii?Q?yMJxoCToSpyqNsxWPK1bGcKNRsVRl0klCZHP34e6xMG+ajW8EpSkpooNltmn?=
 =?us-ascii?Q?xodL0E5FQYgANid3+ICSXjkjwphxw/yqHaFQgjpZ6UQnjBI+/y7rNx729Le8?=
 =?us-ascii?Q?/CnOasvbA4KVf9KGJxK15BdCxrmJguL8D9+YpkkzjUHnj5s0/TSiXFJdcU42?=
 =?us-ascii?Q?Q7s6U2nhRnOptXwfmpeqU1H+yX9oCzldVfHmX1XmLXkceaDbfUY44wwx6mwZ?=
 =?us-ascii?Q?EjwgTOKWd+Bq3U8dc1s3RbTpcoLMcN1zmfYMnW+46mTZQ9ApdP/+XMDD917S?=
 =?us-ascii?Q?xjUmOiXq6VwCSDMzMU9bCC4bAqSAABJnRqlRFMzNOzlXxKvT8cE+DVkYXdqO?=
 =?us-ascii?Q?NmpwIn3n+3m45m6Af765de2abFQ3x2ARzf7CwMQAavQbLqjr9itLAwJSKNCf?=
 =?us-ascii?Q?jhRpKJ73K4Lr9CWTLAr6ailwGeOYOa603OUyNtb6sK5cjKi1/KDSa9MEUWF7?=
 =?us-ascii?Q?RZc9ud4j4Hpl+elkIrGUCgfKYE+D1kSzV9rMxwvfgdbdd3J7FlqyxlI7ZnzK?=
 =?us-ascii?Q?wptL2V2r95W8r0O/h0Tg6JgQ/HU0LXEhiQ3skuj2Vvi/0vpv56kmMj6MVRhg?=
 =?us-ascii?Q?GXm9IMeDu/lNvAUnWpGYjAdNB5NV8z366/VbDNPiNMRLBD324xUEqA17SLKu?=
 =?us-ascii?Q?3bAxNizIt6LCLkJcA6R/iLM+Bt2yac9waxb0KE2cJfgIHDef/tKSVOO3GSWz?=
 =?us-ascii?Q?0AhVPBNjuUgcLnSjJ6zing/4dqg4NW6/rc9UGWNSjGF9YrYylCCk49VenPLU?=
 =?us-ascii?Q?lIkoYltxzT3ckbFtTrPQmuSeXIL3o1zN6/J56nx406QlIX37GmAFmLvcpyAg?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e363ef-babc-4387-9659-08db82d2f693
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:24:39.7139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzMh2Imbzrpj3nA3d1NWlWA9Ii9nP85S4KqMRPsQAtbV7q9rL437c/Y/FnxZdQ9f0dEjeiN/bqNOKXvLm6mBgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6835
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support for BAP broadcast sink, adds a new gdbus method
to synchronize to a given source and sets the QOS and capabilities
of the stream.
This feature was tested using bluetoothctl with the following commands:

[bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] unicast/broadcast (u/b): b
[/local/endpoint/ep0] BIG (auto/value): a
[/local/endpoint/ep0] BIS (auto/value): a

[bluetooth]# scan on

[bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0
/local/endpoint/ep0 16_2_1 <source_address>

---
 profiles/audio/bap.c | 347 ++++++++++++++++++++++++++++++++++++++++---
 src/shared/bap.c     |  50 ++++++-
 src/shared/bap.h     |   4 +-
 3 files changed, 370 insertions(+), 31 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index d7ce9e038..5cb109950 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -34,6 +34,7 @@
 #include "lib/hci.h"
 #include "lib/sdp.h"
 #include "lib/uuid.h"
+#include "lib/iso.h"
 
 #include "src/btd.h"
 #include "src/dbus-common.h"
@@ -185,6 +186,9 @@ static gboolean get_uuid(const GDBusPropertyTable *property,
 		uuid = PAC_SINK_UUID;
 	else if (queue_find(ep->data->srcs, NULL, ep))
 		uuid = PAC_SOURCE_UUID;
+	else if ((queue_find(ep->data->bcast, NULL, ep)
+		&& (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)))
+		uuid = PAC_SINK_UUID;
 	else
 		uuid = BAA_SERVICE_UUID;
 
@@ -232,7 +236,8 @@ static gboolean get_device(const GDBusPropertyTable *property,
 	struct bap_ep *ep = data;
 	const char *path;
 
-	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
+	if ((bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
+			|| (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK))
 		path = adapter_get_path(ep->data->adapter);
 	else
 		path = device_get_path(ep->data->device);
@@ -555,7 +560,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE) {
-		/* Mark CIG and CIS to be auto assigned */
+		/* Mark BIG and BIS to be auto assigned */
 		ep->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
 		ep->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
 	} else {
@@ -576,8 +581,12 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		ep->stream = bt_bap_stream_new(ep->data->bap, ep->lpac,
 						ep->rpac, &ep->qos, ep->caps);
 
-	ep->id = bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
-						config_cb, ep);
+	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
+		ep->id = bt_bap_stream_config(ep->stream, &ep->qos, NULL,
+							config_cb, ep);
+	else
+		ep->id = bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
+							config_cb, ep);
 	if (!ep->id) {
 		DBG("Unable to config stream");
 		free(ep->caps);
@@ -603,14 +612,296 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static void update_bcast_qos(struct bt_iso_qos *qos,
+					struct bt_bap_qos *bap_qos)
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
+				sizeof(qos->bcast.bcode));
+}
+
+static bool match_bcast_stream_qos(const void *data, const void *user_data)
+{
+
+	const struct bt_bap_stream *stream = data;
+	const struct bt_iso_qos *iso_qos = user_data;
+	struct bt_bap_qos *qos;
+
+	qos = bt_bap_stream_get_qos((void *)stream);
+
+	if (iso_qos->bcast.big != qos->bcast.big)
+		return false;
+
+	return iso_qos->bcast.bis == qos->bcast.bis;
+}
+
+static void bap_add_stream(struct bap_data *data,
+				struct bt_bap_stream *stream)
+{
+	DBG("stream pointer %p", stream);
+
+	if (!data->streams)
+		data->streams = queue_new();
+
+	if (!queue_find(data->streams, NULL, stream))
+		queue_push_tail(data->streams, stream);
+}
+
+static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct bt_bap_stream *stream;
+	struct bt_iso_qos qos;
+	struct bt_iso_base base;
+	char address[18];
+	struct queue *queue;
+	struct bap_ep *ep;
+	int fd;
+	struct iovec *base_io;
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
+
+	DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
+					address, qos.bcast.big, qos.bcast.bis);
+
+	queue = data->bcast;
+	ep = queue_pop_head(queue);
+	if (!ep) {
+		DBG("ep not found");
+		return;
+	}
+
+	update_bcast_qos(&qos, &ep->qos);
+
+	base_io = new0(struct iovec, 1);
+	util_iov_memcpy(base_io, base.base, base.base_len);
+
+	ep->id = bt_bap_stream_config(ep->stream, &ep->qos,
+					base_io, NULL, NULL);
+	data->listen_io = io;
+
+	bt_bap_stream_set_user_data(ep->stream, ep->path);
+
+	stream = queue_remove_if(data->streams, match_bcast_stream_qos, &qos);
+	if (!stream) {
+		DBG("stream removed");
+		bap_add_stream(data, ep->stream);
+		stream = ep->stream;
+		fd = g_io_channel_unix_get_fd(io);
+
+		if (bt_bap_stream_set_io(stream, fd)) {
+			bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
+			g_io_channel_set_close_on_unref(io, FALSE);
+			return;
+		}
+	} else
+		DBG("stream not removed");
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
+#define DEFAULT_IO_QOS \
+{ \
+	.interval = 10000, \
+	.latency = 10, \
+	.sdu = 40, \
+	.phy = 0x02, \
+	.rtn = 2, \
+}
+
+static DBusMessage *bcast_sink_create(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct bt_iso_qos qos_bcast;
+	struct sockaddr_iso_bc iso_bc_addr;
+	DBusMessageIter iter, args;
+	const char *key;
+	GIOChannel *io;
+	GError *err = NULL;
+	struct bap_ep *ep = user_data;
+	uint32_t bcastid;
+
+	memset(&qos_bcast, 0, sizeof(struct bt_iso_qos));
+	memset(&iso_bc_addr, 0, sizeof(struct sockaddr_iso_bc));
+
+	DBG("sender %s", dbus_message_get_sender(msg));
+
+	dbus_message_iter_init(msg, &args);
+
+	if ((dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY) ||
+	   (dbus_message_iter_get_element_type(&args) != DBUS_TYPE_DICT_ENTRY))
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&args, &iter);
+
+	while (dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(&iter, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+
+		if (!strcasecmp(key, "SourceAddress")) {
+			const char *str;
+
+			if (var != DBUS_TYPE_STRING)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &str);
+			DBG("SourceAddress %s", str);
+			str2ba(str, &iso_bc_addr.bc_bdaddr);
+		} else if (!strcasecmp(key, "SourceAddressType")) {
+			const char *type;
+
+			if (var != DBUS_TYPE_STRING)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &type);
+
+			if (!strcasecmp(type, "public"))
+				iso_bc_addr.bc_bdaddr_type = BDADDR_LE_PUBLIC;
+			else
+				iso_bc_addr.bc_bdaddr_type = BDADDR_LE_RANDOM;
+
+			DBG("SourceAddressType %d", iso_bc_addr.bc_bdaddr_type);
+		} else if (!strcasecmp(key, "BIS")) {
+			uint8_t bis;
+
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &bis);
+			iso_bc_addr.bc_bis[0] = bis;
+			DBG("BIS %d", iso_bc_addr.bc_bis[0]);
+		} else if (!strcasecmp(key, "NumBis")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+					&iso_bc_addr.bc_num_bis);
+			DBG("NumBis %d", iso_bc_addr.bc_num_bis);
+		} else if (!strcasecmp(key, "BcastID")) {
+			if (var != DBUS_TYPE_UINT32)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &bcastid);
+			DBG("BcastID 0x%4.4x", bcastid);
+		}
+
+		dbus_message_iter_next(&iter);
+	}
+
+	qos_bcast.bcast.big = ep->qos.bcast.big;
+	qos_bcast.bcast.bis = ep->qos.bcast.bis;
+	qos_bcast.bcast.encryption = ep->qos.bcast.encryption;
+	qos_bcast.bcast.framing = ep->qos.bcast.framing;
+	qos_bcast.bcast.mse = ep->qos.bcast.mse;
+	qos_bcast.bcast.options = ep->qos.bcast.options;
+	qos_bcast.bcast.packing = ep->qos.bcast.packing;
+	qos_bcast.bcast.skip = ep->qos.bcast.skip;
+	qos_bcast.bcast.sync_cte_type = ep->qos.bcast.sync_cte_type;
+	qos_bcast.bcast.sync_interval = ep->qos.bcast.sync_interval;
+	qos_bcast.bcast.sync_timeout = ep->qos.bcast.sync_timeout;
+	qos_bcast.bcast.timeout = ep->qos.bcast.timeout;
+	qos_bcast.bcast.in.interval = ep->qos.bcast.io_qos.interval;
+	qos_bcast.bcast.in.phy = ep->qos.bcast.io_qos.phy;
+	qos_bcast.bcast.in.sdu = ep->qos.bcast.io_qos.sdu;
+	qos_bcast.bcast.in.latency = ep->qos.bcast.io_qos.latency;
+	qos_bcast.bcast.in.rtn = ep->qos.bcast.io_qos.rtn;
+
+	io = bt_io_listen(iso_bcast_confirm_cb, NULL, ep->data, NULL, &err,
+			BT_IO_OPT_SOURCE_BDADDR,
+			btd_adapter_get_address(ep->data->adapter),
+			BT_IO_OPT_DEST_BDADDR,
+			&iso_bc_addr.bc_bdaddr,
+			BT_IO_OPT_DEST_TYPE,
+			iso_bc_addr.bc_bdaddr_type,
+			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+			BT_IO_OPT_QOS, &qos_bcast,
+			BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
+			BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
+			BT_IO_OPT_INVALID);
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+		return dbus_message_new_method_return(msg);
+	}
+
+	ep->data->listen_io = io;
+	return dbus_message_new_method_return(msg);
+
+fail:
+	DBG("Failed parsing %s", key);
+	return dbus_message_new_method_return(msg);
+
+}
+
 static const GDBusMethodTable ep_methods[] = {
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("SetConfiguration",
 					GDBUS_ARGS({ "endpoint", "o" },
-						{ "properties", "a{sv}" } ),
+						{ "properties", "a{sv}" }),
 					NULL, set_configuration) },
 	{ },
 };
 
+static const GDBusMethodTable bap_bcast_ep_methods[] = {
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("SetConfiguration",
+					GDBUS_ARGS({ "endpoint", "o" },
+						{ "properties", "a{sv}" }),
+					NULL, set_configuration) },
+
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("BcastSinkCreate",
+					GDBUS_ARGS({ "properties", "a{sv}" }),
+					NULL, bcast_sink_create) },
+	{ },
+};
+
 static void ep_free(void *data)
 {
 	struct bap_ep *ep = data;
@@ -657,6 +948,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 
 	switch (bt_bap_pac_get_type(rpac)) {
 	case BT_BAP_BCAST_SOURCE:
+	case BT_BAP_BCAST_SINK:
 		queue = data->bcast;
 		i = queue_length(data->bcast);
 		suffix = "bcast";
@@ -683,15 +975,24 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 		return NULL;
 	}
 
-	if (g_dbus_register_interface(btd_get_dbus_connection(),
+	if (bt_bap_pac_get_type(rpac) == BT_BAP_BCAST_SOURCE) {
+		if (g_dbus_register_interface(btd_get_dbus_connection(),
+				ep->path, MEDIA_ENDPOINT_INTERFACE,
+				bap_bcast_ep_methods, NULL, NULL,
+				ep, ep_free) == FALSE) {
+			error("Could not register bap bcast interface %s",
+				ep->path);
+		}
+	} else {
+		if (g_dbus_register_interface(btd_get_dbus_connection(),
 				ep->path, MEDIA_ENDPOINT_INTERFACE,
 				ep_methods, NULL, ep_properties,
 				ep, ep_free) == FALSE) {
-		error("Could not register remote ep %s", ep->path);
-		ep_free(ep);
-		return NULL;
+			error("Could not register remote ep %s", ep->path);
+			ep_free(ep);
+			return NULL;
+		}
 	}
-
 	bt_bap_pac_set_user_data(rpac, ep->path);
 
 	DBG("ep %p lpac %p rpac %p path %s", ep, ep->lpac, ep->rpac, ep->path);
@@ -724,6 +1025,12 @@ static struct bap_ep *ep_register(struct btd_service *service,
 		i = queue_length(data->srcs);
 		suffix = "source";
 		break;
+	case BT_BAP_BCAST_SOURCE:
+	case BT_BAP_BCAST_SINK:
+		queue = data->bcast;
+		i = queue_length(data->bcast);
+		suffix = "bcast";
+		break;
 	default:
 		return NULL;
 	}
@@ -823,6 +1130,7 @@ done:
 
 	queue_foreach(ep->data->srcs, bap_config, NULL);
 	queue_foreach(ep->data->snks, bap_config, NULL);
+	queue_foreach(ep->data->bcast, bap_config, NULL);
 }
 
 static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -1416,6 +1724,10 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (ep && !ep->id) {
+			/* For BAP Sink create io when receiving source info */
+			if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
+				return;
+
 			bap_create_io(data, ep, stream, true);
 			if (!ep->io) {
 				error("Unable to create io");
@@ -1423,7 +1735,6 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 				return;
 			}
 
-
 			if (bt_bap_stream_get_type(stream) ==
 					BT_BAP_STREAM_TYPE_UCAST) {
 				/* Wait QoS response to respond */
@@ -1479,7 +1790,9 @@ static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
 
 		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SOURCE,
 						pac_found_bcast, data);
-	}
+	} else if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SINK)
+		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SINK,
+						pac_found_bcast, data);
 }
 
 static bool ep_match_pac(const void *data, const void *match_data)
@@ -1595,14 +1908,6 @@ static bool match_data(const void *data, const void *match_data)
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
@@ -1853,7 +2158,7 @@ static int bap_adapter_probe(struct btd_profile *p,
 
 	bap_data_add(data);
 
-	if (!bt_bap_attach_broadcast(data->bap)) {
+	if (!bt_bap_attach_broadcast(data->bap, BT_BAP_BCAST_SOURCE)) {
 		error("BAP unable to attach");
 		return -EINVAL;
 	}
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 72ce67c08..1f6527b98 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -633,14 +633,15 @@ static struct bt_bap_endpoint *bap_endpoint_new(struct bt_bap_db *bdb,
 	return ep;
 }
 
-static struct bt_bap_endpoint *bap_endpoint_new_broacast(struct bt_bap_db *bdb)
+static struct bt_bap_endpoint *bap_endpoint_new_broacast(struct bt_bap_db *bdb,
+						uint8_t type)
 {
 	struct bt_bap_endpoint *ep;
 
 	ep = new0(struct bt_bap_endpoint, 1);
 	ep->bdb = bdb;
 	ep->attr = NULL;
-	ep->dir = BT_BAP_BCAST_SOURCE;
+	ep->dir = type;
 
 	return ep;
 }
@@ -668,7 +669,7 @@ static struct bt_bap_endpoint *bap_get_endpoint(struct queue *endpoints,
 }
 
 static struct bt_bap_endpoint *bap_get_endpoint_bcast(struct queue *endpoints,
-						struct bt_bap_db *db)
+					struct bt_bap_db *db, uint8_t type)
 {
 	struct bt_bap_endpoint *ep;
 
@@ -682,7 +683,7 @@ static struct bt_bap_endpoint *bap_get_endpoint_bcast(struct queue *endpoints,
 	if (queue_length(endpoints) > 0)
 		return queue_peek_head(endpoints);
 
-	ep = bap_endpoint_new_broacast(db);
+	ep = bap_endpoint_new_broacast(db, type);
 	if (!ep)
 		return NULL;
 
@@ -1348,6 +1349,9 @@ static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
 	ep->old_state = ep->state;
 	ep->state = state;
 
+	if (stream->lpac->type == BT_BAP_BCAST_SINK)
+		goto done;
+
 	if (stream->client)
 		goto done;
 
@@ -2518,7 +2522,7 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					struct iovec *metadata)
 {
 	struct bt_bap_db *bdb;
-	struct bt_bap_pac *pac, *pac_brodcast_sink;
+	struct bt_bap_pac *pac, *pac_brodcast_sink, *pac_brodcast_source;
 	struct bt_bap_codec codec;
 
 	if (!db)
@@ -2551,6 +2555,13 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					data, metadata);
 		bap_add_broadcast_sink(pac_brodcast_sink);
 		break;
+	case BT_BAP_BCAST_SINK:
+		bap_add_broadcast_sink(pac);
+		pac_brodcast_source = bap_pac_new(bdb, name,
+					BT_BAP_BCAST_SOURCE,
+					&codec, qos, data, metadata);
+		bap_add_broadcast_source(pac_brodcast_source);
+		break;
 	default:
 		bap_pac_free(pac);
 		return NULL;
@@ -3996,7 +4007,7 @@ clone:
 	return true;
 }
 
-bool bt_bap_attach_broadcast(struct bt_bap *bap)
+bool bt_bap_attach_broadcast(struct bt_bap *bap, uint8_t type)
 {
 	struct bt_bap_endpoint *ep;
 
@@ -4008,7 +4019,7 @@ bool bt_bap_attach_broadcast(struct bt_bap *bap)
 
 	queue_push_tail(sessions, bap);
 
-	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb);
+	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb, type);
 	if (ep)
 		ep->bap = bap;
 
@@ -4224,6 +4235,10 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
 		return bap_foreach_pac(bap->ldb->broadcast_sources,
 					bap->ldb->broadcast_sinks,
 					func, user_data);
+	case BT_BAP_BCAST_SINK:
+		return bap_foreach_pac(bap->ldb->broadcast_sinks,
+					bap->ldb->broadcast_sources,
+					func, user_data);
 	}
 }
 
@@ -4382,6 +4397,12 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 		return req->id;
 	case BT_BAP_STREAM_TYPE_BCAST:
 		stream->qos = *qos;
+		if (stream->lpac->type == BT_BAP_BCAST_SINK) {
+			if (data)
+				stream_config(stream, data, NULL);
+
+			stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+		}
 		return 1;
 	}
 
@@ -4446,13 +4467,19 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 		if (rpac)
 			type = rpac->type;
 		else if (lpac) {
-			switch(lpac->type) {
+			switch (lpac->type) {
 			case BT_BAP_SINK:
 				type = BT_BAP_SOURCE;
 				break;
 			case BT_BAP_SOURCE:
 				type = BT_BAP_SINK;
 				break;
+			case BT_BAP_BCAST_SOURCE:
+				type = BT_BAP_BCAST_SINK;
+				break;
+			case BT_BAP_BCAST_SINK:
+				type = BT_BAP_BCAST_SOURCE;
+				break;
 			default:
 				return NULL;
 			}
@@ -4913,6 +4940,13 @@ struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream)
 	return io->io;
 }
 
+bool bt_bap_match_bcast_sink_stream(const void *data, const void *user_data)
+{
+	const struct bt_bap_stream *stream = data;
+
+	return stream->lpac->type == BT_BAP_BCAST_SINK;
+}
+
 static bool stream_io_disconnected(struct io *io, void *user_data)
 {
 	struct bt_bap_stream *stream = user_data;
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 50b567663..297ecf0e5 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -186,7 +186,7 @@ struct bt_bap *bt_bap_ref(struct bt_bap *bap);
 void bt_bap_unref(struct bt_bap *bap);
 
 bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client);
-bool bt_bap_attach_broadcast(struct bt_bap *bap);
+bool bt_bap_attach_broadcast(struct bt_bap *bap, uint8_t type);
 void bt_bap_detach(struct bt_bap *bap);
 
 bool bt_bap_set_debug(struct bt_bap *bap, bt_bap_debug_func_t cb,
@@ -289,7 +289,7 @@ struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream);
 struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream);
 
 struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream);
-
+bool bt_bap_match_bcast_sink_stream(const void *data, const void *user_data);
 bool bt_bap_stream_set_io(struct bt_bap_stream *stream, int fd);
 
 int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id);
-- 
2.34.1

