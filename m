Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12747C41513
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 16:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjHHQqR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjHHQpW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 12:45:22 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB724444D
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 08:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMtZQSaR0UQZKdRWLo+Eqm5qJRzxa7hqm+9YcCue+AUWyj7tvfW5pMufylvdmM4+K0BiymW2ioQIhVtZH78TSGvySYx7qtXRTq6cN0XqXtdBdEjeSAOfaf3j/2qFX3kjEYcdQcu6hBeg3eFMA/lxJKyWVXth43dMbTz0EgdvHLkSb7p2+qSNwdFMNpbt3lV2e5sI8VhyZ4i6uNsj/532Z8nfPcfZ58WSs18XyTJLREZcz36u/5udG5XSvmepNyHA2KGfiU4b4DnGt/wtasaWibBhVnCxmdtxVI/ifoK2+dBbPFBfJgDvFmHuSFjXFTP1D4JJmDTIz6BMDZrJU4xBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VRw6SfC8dBjk4f4k5FAMDWrIhNSRIRyky8IF1zy9r0=;
 b=eBdhVWsUi6xwOQl+tchrAgPsKsKs2vixle3h8fFhgps8A23Z2P0m1MZG1U0jAy06SaaPJJYhXYZr5RwY0TdbhpZ8iIce5dfX5mrFqqiS4JWWQ19WHEw+RTvSUMvdhARtZ5C7igo53h9+bN1lICev7V3DXKOEo1OZS6Ntq8DxCvKQzD6nx0ZhSJ6wOxFdTrWjRR5977PlvH50SZVBTeCVmXI9FlxlACLOXF/zh/rlc6JWTDFg0A149lhARjWxtWgaukjCPF/Mt9W7aNLBFFg9Yczyqp5qyfzJOd7694Zkbj8wTLqSfSOZZzq8/OnhZzK0wBJGNTaw8k956mCdPBd7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VRw6SfC8dBjk4f4k5FAMDWrIhNSRIRyky8IF1zy9r0=;
 b=BwvvKtGWtDgsWfMVzeYIsRF0fBkSJ56ZnO+YYgRtNh/danr13UCSUJGFH9hptK8is9JCQHAJCMoGXU8E5tO+IlJ57E54bnE4k9oK2aJbFzAOfdUlWePbF3bXGzA8KvnK4xwvvaQuaUri4+ABpTNGJ3BSWczVT71THaNTf6XqOwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DUZPR04MB10062.eurprd04.prod.outlook.com (2603:10a6:10:4e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 11:53:11 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6652.021; Tue, 8 Aug 2023
 11:53:11 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v5 5/7] bap: Add support for BAP broadcast sink
Date:   Tue,  8 Aug 2023 14:50:38 +0300
Message-Id: <20230808115040.4403-6-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808115040.4403-1-claudia.rosu@nxp.com>
References: <20230808115040.4403-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::6) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DUZPR04MB10062:EE_
X-MS-Office365-Filtering-Correlation-Id: 7518b616-9eb0-4b60-3941-08db98060a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MkRwgwmt6Cp+aRXD2VNTh6uwtxuhA3Njd4ZQ+9bd3tRp7mKepOe6yV80/C9/4cDf6KnIrAHYZfPiSk++TT6kG7IXYamr9LMAsQQDbH0Je1Ef8UCy8BzuMerAnctvNtpIhu2sVDQpgyZLh1LNOjn7rBfOZqnbziMAUxAvpyW1C3kv2c1KV/jFFSqIIhfnzegn2w2D1FtoZc9hy24A2rjyWz0CXyL6lnIOqTyGjXxdbW5xd1O7jPJaUzmj9EBz7pUt6MdvIx6Mh8N4O7yixlFzKhhqt/tIvDnBLrjq6y2bQhcoXGttDBCkiX3EUPaAPmfkpAWGgLm1g1yyRnbA5ZRcffk3BTUznym7QvYp4K5vWZwx6jHwikcM0usbbzKhYp1izptPtAEdAaL2YCNyk7jcLYPHWbL1LK/Nb3o/AVE1HFAmhByYHq8Lnf5r+fm/t/Cus6ZQLDC9RNagnoJG3bQ/9VU+tozlfBItC2WVphzwe+Qri0HvuUpozKyW541odv6ERfgimI1qY31mTwOeq0daEte3g8FZS+g/MtcpiZ5xHu2+6+EnJYTWjp95tOv0HF9wAjxGHdhjI/vXLWavvwhEvJJvKDPva4Zdq7zTBrmgCbtnHryUU4qdGwADPuH33vPP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(1800799003)(186006)(451199021)(83380400001)(2616005)(52116002)(6916009)(38100700002)(38350700002)(41300700001)(2906002)(4326008)(5660300002)(30864003)(316002)(8676002)(8936002)(66476007)(66946007)(66556008)(6512007)(86362001)(478600001)(6666004)(6486002)(6506007)(36756003)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sWRq+6G25HyUuvBVIDOgYwl2sXDl2EUHVF0nWhg29gKDBje0/57M7X2PoipK?=
 =?us-ascii?Q?oqewCJDiLeNZpmep9Jpd3iuf/dsRpMf6xXo8Cq7CXsFkAy1lhADouHcazvAI?=
 =?us-ascii?Q?QZKkrxREHjVWpJyeJMCGfkfCxWNEYyOf00uLP5IaHptO8NTDyanIHpnByqKx?=
 =?us-ascii?Q?LQacH7j6GMLSZFsgFSDFfbM1pnhaJ6IYCiYeg+xlbCKOO6is++7Icm9TxFql?=
 =?us-ascii?Q?8YnhnbNJ2g2N1o4cyahLlNE4SfbwFmK4ioUauDWbG213H3+s7yK1VPrD48hP?=
 =?us-ascii?Q?E7peUdH7YQkLHn0FJ7QBKuvzd+pcxjFidrgE72qAHD2MRhz1ipn0YugLOzXb?=
 =?us-ascii?Q?s9kd/6ZpWmQk4/lZKHgAm0QK5nrwWZmJ7FOHVIqMBxF/PBatOBPq82gEKqze?=
 =?us-ascii?Q?P90gVEFKv6N8bGuRywK16zX0XnQj7nR4Axaveck22cSLklGMHTCtWBXeX/ff?=
 =?us-ascii?Q?JK7M3C8sTB2sweOLrJREDgheq6jBVvUkuNpEZgbprQ0feLh5CRVoziN7EpLP?=
 =?us-ascii?Q?b82TwRYTDQ8KgdqXuTXi11rfjxmPmL0pK9GfF/TJuAEFFNVey9yjBcQw+uvg?=
 =?us-ascii?Q?ylBw5zndmY8ZtCr/6oAG0B8CdbjT6m8LK4mAqKPleuNO3gApvNSNSWFtJGTX?=
 =?us-ascii?Q?C5X3wwhg+jExXv7MDTBBw72TbBjm8rXlPo8ih8wDJ2j2vht/pNASRsKMoExY?=
 =?us-ascii?Q?z2oQkyTX5RjjQTl5vWsyJxL+QKdgxH4la7XSITgQpg5NX453zZiotoQ+dUZ5?=
 =?us-ascii?Q?wyzSf3VNnmu1SPWzM0baskLgeZUFTTlJIX9BZpRPaSwNd3Wu8MmBKS6lUCQU?=
 =?us-ascii?Q?q8NvjRd2IQ1VrM+RNQLVpgPBWUa9CP/XcVzDtmDHuSis6o2SYZMunYU2wULh?=
 =?us-ascii?Q?WpyJHUbU4hWath9oYe+H01LHAuEogin0oUNlQZUbjUelUzdKCY1LmbjFqN5g?=
 =?us-ascii?Q?nK+zpdkAjYFeZNhQIQ1RcXHzgYfUGzS5EF7JOKID5XK4SR36hPLKH2LSS6ce?=
 =?us-ascii?Q?D8cz4Lx/Aou3COFCZh6yFuOBhXWjbeT8Ivgpysdgpx20cKIDf2sFImq01c/t?=
 =?us-ascii?Q?WT/sQoMZJThNy+H1QtUAQ5D3SzjUsn1TlKBgcSwnLuXfNQlaivsato5+57/h?=
 =?us-ascii?Q?edfevaV6YIrGhuo0XMpgcEgn7frJG6dzBIT3G/EbCc3uXIGy1CQS1Uwjw95l?=
 =?us-ascii?Q?EtknoBkXggGXmStAc0b/0kbrdIJ7uIY4Aa9S1lJQeojlVfqnjihXb51ZGcPq?=
 =?us-ascii?Q?wqiXGBi+B5ZIm7zQbhb/CJriEUV4y93rm3rTCx7WdacxwqUaW8dgvwUSuF23?=
 =?us-ascii?Q?k4Z26Dk9U726LBaPaN6AUxFDpmngLVIItjFg4OzoQlLvzg6p+sJ1pQMPZBxE?=
 =?us-ascii?Q?4tKtS1Eml1yKl6n0NEqEIq+v4ZIClXf9t8zH9tn2CcK7UhLXID4YtL/bMifv?=
 =?us-ascii?Q?mnPKNAbinWeDeCx3H1L7SQS128FbFUW5OAPCesd7sRqWW0TSzRxFiGPXQfex?=
 =?us-ascii?Q?wF1FX7k8GaBDbSKTGv+jvw69sdZPqA4/WjHRnHj5PSiGIcoid9hpBOH3SQwb?=
 =?us-ascii?Q?I31T1M4FtAxn3FbzOuqwtkCBNqL6L5EihXehSNF8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7518b616-9eb0-4b60-3941-08db98060a0b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 11:53:11.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMqN+D84gxynMDGD4K0VV1LRBQdXdWmF5OITRlXLLaH1Gxc+3HojlOembxtg5Eb0g0XODgeOdrQVWkuThFu/rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10062
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
 profiles/audio/bap.c | 334 ++++++++++++++++++++++++++++++++++++++-----
 src/shared/bap.c     | 139 +++++++++++++++---
 src/shared/bap.h     |   6 +-
 3 files changed, 424 insertions(+), 55 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8cbb238ef..a0ac642f3 100644
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
@@ -186,8 +189,11 @@ static gboolean get_uuid(const GDBusPropertyTable *property,
 		uuid = PAC_SINK_UUID;
 	else if (queue_find(ep->data->srcs, NULL, ep))
 		uuid = PAC_SOURCE_UUID;
-	else
+	else if ((queue_find(ep->data->bcast, NULL, ep)
+		&& (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)))
 		uuid = BAA_SERVICE_UUID;
+	else
+		uuid = BCAA_SERVICE_UUID;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
 
@@ -341,15 +347,18 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 		} else if (!strcasecmp(key, "PHY")) {
 			const char *str;
 
-			if (var != DBUS_TYPE_STRING)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &str);
-
-			if (!strcasecmp(str, "1M"))
-				io_qos.phy = 0x01;
-			else if (!strcasecmp(str, "2M"))
-				io_qos.phy = 0x02;
+			if (var == DBUS_TYPE_STRING) {
+				dbus_message_iter_get_basic(&value, &str);
+
+				if (!strcasecmp(str, "1M"))
+					io_qos.phy = 0x01;
+				else if (!strcasecmp(str, "2M"))
+					io_qos.phy = 0x02;
+				else
+					goto fail;
+			} else if (var == DBUS_TYPE_BYTE)
+				dbus_message_iter_get_basic(&value,
+						 &io_qos.phy);
 			else
 				goto fail;
 		} else if (!strcasecmp(key, "SDU")) {
@@ -556,7 +565,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE) {
-		/* Mark CIG and CIS to be auto assigned */
+		/* Mark BIG and BIS to be auto assigned */
 		ep->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
 		ep->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
 	} else {
@@ -577,8 +586,12 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
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
@@ -597,13 +610,120 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
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
+	if (ep->stream == NULL)
+		DBG("stream is null");
+	ep->id = bt_bap_stream_config(ep->stream, &ep->qos,
+					base_io, NULL, NULL);
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
@@ -649,15 +769,23 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
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
 
+	if (!adapter)
+		DBG("adapter is null");
+
+	if (!device)
+		DBG("device is null");
+
 	switch (bt_bap_pac_get_type(rpac)) {
 	case BT_BAP_BCAST_SOURCE:
+	case BT_BAP_BCAST_SINK:
 		queue = data->bcast;
 		i = queue_length(data->bcast);
 		suffix = "bcast";
@@ -675,8 +803,24 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	ep->lpac = lpac;
 	ep->rpac = rpac;
 
-	err = asprintf(&ep->path, "%s/pac_%s%d", adapter_get_path(adapter),
-		       suffix, i);
+	if (device)
+		ep->data->device = device;
+
+	switch (bt_bap_pac_get_type(rpac)) {
+	case BT_BAP_BCAST_SINK:
+		DBG("sink");
+		err = asprintf(&ep->path, "%s/pac_%s%d",
+			adapter_get_path(adapter), suffix, i);
+		DBG("sink path %s", ep->path);
+		break;
+	case BT_BAP_BCAST_SOURCE:
+		DBG("source");
+		err = asprintf(&ep->path, "%s/pac_%s%d",
+				device_get_path(device), suffix, i);
+		DBG("source path %s", ep->path);
+		break;
+	}
+
 	if (err < 0) {
 		error("Could not allocate path for remote pac %s/pac%d",
 				adapter_get_path(adapter), i);
@@ -685,14 +829,13 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
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
@@ -824,6 +967,7 @@ done:
 
 	queue_foreach(ep->data->srcs, bap_config, NULL);
 	queue_foreach(ep->data->snks, bap_config, NULL);
+	queue_foreach(ep->data->bcast, bap_config, NULL);
 }
 
 static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -1310,6 +1454,46 @@ static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
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
+	} else
+		DBG("io created");
+
+	ep->data->listen_io = io;
+
+}
 static void bap_create_ucast_io(struct bap_data *data, struct bap_ep *ep,
 				struct bt_bap_stream *stream, int defer)
 {
@@ -1364,10 +1548,10 @@ static void bap_create_bcast_io(struct bap_data *data, struct bap_ep *ep,
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
@@ -1417,6 +1601,11 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
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
@@ -1424,7 +1613,6 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 				return;
 			}
 
-
 			if (bt_bap_stream_get_type(stream) ==
 					BT_BAP_STREAM_TYPE_UCAST) {
 				/* Wait QoS response to respond */
@@ -1480,6 +1668,10 @@ static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
 
 		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SOURCE,
 						pac_found_bcast, data);
+	} else if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SINK) {
+		DBG("sink pac %p", pac);
+		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SINK,
+						pac_found_bcast, data);
 	}
 }
 
@@ -1596,14 +1788,6 @@ static bool match_data(const void *data, const void *match_data)
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
@@ -1733,6 +1917,73 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
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
+	DBG("Device %s is a BAP broadcast source", addr);
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
+
+	bap_data_remove(data);
+}
+
 static int bap_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -1854,7 +2105,7 @@ static int bap_adapter_probe(struct btd_profile *p,
 
 	bap_data_add(data);
 
-	if (!bt_bap_attach_broadcast(data->bap)) {
+	if (!bt_bap_attach_broadcast(data->bap, BT_BAP_BCAST_SOURCE)) {
 		error("BAP unable to attach");
 		return -EINVAL;
 	}
@@ -1901,6 +2152,17 @@ static struct btd_profile bap_profile = {
 	.experimental	= true,
 };
 
+static struct btd_profile bap_bcast_profile = {
+	.name		= "bapbcast",
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
@@ -1911,6 +2173,10 @@ static int bap_init(void)
 	if (err)
 		return err;
 
+	err = btd_profile_register(&bap_bcast_profile);
+	if (err)
+		return err;
+
 	bap_id = bt_bap_register(bap_attached, bap_detached, NULL);
 
 	return 0;
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 72ce67c08..ebeb713d5 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -633,14 +633,18 @@ static struct bt_bap_endpoint *bap_endpoint_new(struct bt_bap_db *bdb,
 	return ep;
 }
 
-static struct bt_bap_endpoint *bap_endpoint_new_broacast(struct bt_bap_db *bdb)
+static struct bt_bap_endpoint *bap_endpoint_new_broadcast(struct bt_bap_db *bdb,
+								uint8_t type)
 {
 	struct bt_bap_endpoint *ep;
 
 	ep = new0(struct bt_bap_endpoint, 1);
 	ep->bdb = bdb;
 	ep->attr = NULL;
-	ep->dir = BT_BAP_BCAST_SOURCE;
+	if (type == BT_BAP_BCAST_SINK)
+		ep->dir = BT_BAP_BCAST_SOURCE;
+	else
+		ep->dir = BT_BAP_BCAST_SINK;
 
 	return ep;
 }
@@ -667,22 +671,27 @@ static struct bt_bap_endpoint *bap_get_endpoint(struct queue *endpoints,
 	return ep;
 }
 
+static bool match_ep_type(const void *data, const void *match_data)
+{
+	const struct bt_bap_endpoint *ep = data;
+	const uint8_t type = PTR_TO_INT(match_data);
+
+	return (ep->dir == type);
+}
+
 static struct bt_bap_endpoint *bap_get_endpoint_bcast(struct queue *endpoints,
-						struct bt_bap_db *db)
+					struct bt_bap_db *db, uint8_t type)
 {
 	struct bt_bap_endpoint *ep;
 
 	if (!db)
 		return NULL;
-	/*
-	 * We have support for only one stream so we will have
-	 * only one endpoint.
-	 * TO DO add support for more then one stream
-	 */
-	if (queue_length(endpoints) > 0)
-		return queue_peek_head(endpoints);
 
-	ep = bap_endpoint_new_broacast(db);
+	ep = queue_find(endpoints, match_ep_type, INT_TO_PTR(type));
+	if (ep)
+		return ep;
+
+	ep = bap_endpoint_new_broadcast(db, type);
 	if (!ep)
 		return NULL;
 
@@ -1317,6 +1326,8 @@ static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 	struct bt_bap *bap = stream->bap;
 	const struct queue_entry *entry;
 
+	if (ep->old_state == state)
+		return;
 	ep->old_state = ep->state;
 	ep->state = state;
 
@@ -1348,6 +1359,9 @@ static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
 	ep->old_state = ep->state;
 	ep->state = state;
 
+	if (stream->lpac->type == BT_BAP_BCAST_SINK)
+		goto done;
+
 	if (stream->client)
 		goto done;
 
@@ -2379,6 +2393,10 @@ static struct bt_bap_pac *bap_pac_find(struct bt_bap_db *bdb, uint8_t type,
 		return queue_find(bdb->sources, match_codec, codec);
 	case BT_BAP_SINK:
 		return queue_find(bdb->sinks, match_codec, codec);
+	case BT_BAP_BCAST_SOURCE:
+		return queue_find(bdb->broadcast_sources, match_codec, codec);
+	case BT_BAP_BCAST_SINK:
+		return queue_find(bdb->broadcast_sinks, match_codec, codec);
 	}
 
 	return NULL;
@@ -2518,7 +2536,7 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					struct iovec *metadata)
 {
 	struct bt_bap_db *bdb;
-	struct bt_bap_pac *pac, *pac_brodcast_sink;
+	struct bt_bap_pac *pac, *pac_broadcast_sink;
 	struct bt_bap_codec codec;
 
 	if (!db)
@@ -2545,11 +2563,19 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 		bap_add_source(pac);
 		break;
 	case BT_BAP_BCAST_SOURCE:
-		// For broadcast add local pac and remote pac
 		bap_add_broadcast_source(pac);
-		pac_brodcast_sink = bap_pac_new(bdb, name, type, &codec, qos,
+		if (queue_isempty(bdb->broadcast_sinks)) {
+			/* When adding a local broadcast source, add also a
+			 * local broadcast sink
+			 */
+			pac_broadcast_sink = bap_pac_new(bdb, name,
+					BT_BAP_BCAST_SINK, &codec, qos,
 					data, metadata);
-		bap_add_broadcast_sink(pac_brodcast_sink);
+			bap_add_broadcast_sink(pac_broadcast_sink);
+		}
+		break;
+	case BT_BAP_BCAST_SINK:
+		bap_add_broadcast_sink(pac);
 		break;
 	default:
 		bap_pac_free(pac);
@@ -3996,7 +4022,7 @@ clone:
 	return true;
 }
 
-bool bt_bap_attach_broadcast(struct bt_bap *bap)
+bool bt_bap_attach_broadcast(struct bt_bap *bap, uint8_t type)
 {
 	struct bt_bap_endpoint *ep;
 
@@ -4008,7 +4034,7 @@ bool bt_bap_attach_broadcast(struct bt_bap *bap)
 
 	queue_push_tail(sessions, bap);
 
-	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb);
+	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb, type);
 	if (ep)
 		ep->bap = bap;
 
@@ -4221,9 +4247,19 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
 		return bap_foreach_pac(bap->ldb->sinks, bap->rdb->sources,
 							   func, user_data);
 	case BT_BAP_BCAST_SOURCE:
-		return bap_foreach_pac(bap->ldb->broadcast_sources,
+		if (queue_isempty(bap->rdb->broadcast_sources)
+			&& queue_isempty(bap->rdb->broadcast_sinks))
+			return bap_foreach_pac(bap->ldb->broadcast_sources,
 					bap->ldb->broadcast_sinks,
 					func, user_data);
+
+		return bap_foreach_pac(bap->ldb->broadcast_sinks,
+					bap->rdb->broadcast_sources,
+					func, user_data);
+	case BT_BAP_BCAST_SINK:
+		return bap_foreach_pac(bap->ldb->broadcast_sinks,
+					bap->rdb->broadcast_sources,
+					func, user_data);
 	}
 }
 
@@ -4382,6 +4418,11 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 		return req->id;
 	case BT_BAP_STREAM_TYPE_BCAST:
 		stream->qos = *qos;
+		if (stream->lpac->type == BT_BAP_BCAST_SINK) {
+			if (data)
+				stream_config(stream, data, NULL);
+			stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+		}
 		return 1;
 	}
 
@@ -4446,13 +4487,19 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
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
@@ -4913,6 +4960,13 @@ struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream)
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
@@ -4944,6 +4998,14 @@ static bool match_req_id(const void *data, const void *match_data)
 	return (req->id == id);
 }
 
+static bool match_name(const void *data, const void *match_data)
+{
+	const struct bt_bap_pac *pac = data;
+	const char *name = match_data;
+
+	return (!strcmp(pac->name, name));
+}
+
 int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id)
 {
 	struct bt_bap_req *req;
@@ -5132,3 +5194,42 @@ bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd)
 
 	return io->connecting;
 }
+
+bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name)
+{
+	struct bt_bap_endpoint *ep;
+	struct bt_bap_pac *pac_broadcast_source, *local_sink;
+	struct bt_bap_codec bap_codec;
+
+	bap_codec.id = 0x06;
+	bap_codec.cid = 0;
+	bap_codec.vid = 0;
+
+	/* Add remote source endpoint */
+	if (!bap->rdb->broadcast_sources)
+		bap->rdb->broadcast_sources = queue_new();
+
+	if (queue_find(bap->rdb->broadcast_sources, match_name, name)) {
+		DBG(bap, "broadcast source already registered");
+		return true;
+	}
+
+	local_sink = queue_peek_head(bap->ldb->broadcast_sinks);
+	pac_broadcast_source = bap_pac_new(bap->rdb, name, BT_BAP_BCAST_SOURCE,
+			&bap_codec, NULL, local_sink->data, NULL);
+	queue_push_tail(bap->rdb->broadcast_sources, pac_broadcast_source);
+
+	if (!pac_broadcast_source) {
+		DBG(bap, "No broadcast source could be created");
+		return false;
+	}
+	queue_foreach(bap->pac_cbs, notify_pac_added, pac_broadcast_source);
+
+	/* Push remote endpoint with direction sink */
+	ep = bap_endpoint_new_broadcast(bap->rdb, BT_BAP_BCAST_SINK);
+
+	if (ep)
+		queue_push_tail(bap->remote_eps, ep);
+
+	return true;
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 50b567663..fcacfcbed 100644
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
@@ -305,3 +305,5 @@ uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream);
 
 int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd);
 bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd);
+
+bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name);
-- 
2.34.1

