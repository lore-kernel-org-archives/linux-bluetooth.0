Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7497C001DE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 08:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjHBImT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 04:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjHBImR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 04:42:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB90269E
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 01:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWF9DOVNGJcGPDP/Pl/DVGssY+/r+XRX8miNu4psN0P7pCyQHUZc7pZv+IEEso85FH/HCDmLCHRFIW9V9Lb5c85vbugEb1D72aqo6AfYHMX4rLGEmb0bOfEvKNkNGBJn3snKdjgOPRKmBQ/rk230XeuF7YI8PSKmTAwdxfLGzPsjXEbhEz96syj+3Uia64qsN/o+vymvWOApvEgAsRQM0zIB4wg10EAzc9U1cqOsEVRdKwjjPgnBED+hnOz67UQm9fxG9Sz35SuyClyXeLUC08zM0PvNpFmuJMpaADN+azZmuAm6u3pM7u6yZotUnYNjua60gfeSPd4RP4ofVEumpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctYEuIXNY32ZcwHVBkVD9um6Pt3ZWL4hHSelmkX3SHU=;
 b=j4GGfOIoj6s6gvCszhyPRkQD3sNkUDQPeJqGr+e8KfMtKZuZaCr4IaTTtYeeEhz/jBB7YhWe2xlHLENJA1wvSAATyzZHFYAj4SRpbSpTs9hGV/RR2E9LexlFDWLB/hpv4J08no9kbGOtuXOqT0WD5hH+vbijGreolHRxGuAIwh8hBOOtbTJy7+u+hcaKDx+G7BVnEoeQfR1coQ6byPrhvvcQS5NJmXOdFMYrrLnevKc0OvdjCU1jYPgA9JtetET0fl56nnes3ci/9T7s36ME0R/tL1qE7jngxS7WoUxAn4RcHMAsB4d9AkX1SRsILJY5o1ZAeXWALbM1ZZ1NzbPngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctYEuIXNY32ZcwHVBkVD9um6Pt3ZWL4hHSelmkX3SHU=;
 b=SEMeSSYwgGthHiWDxhn7qjr6LwFXSwNqcR5IKJmv0WcNXU48mZb00wP4l7wOj463LnNY06V4d9rfQ7WqhNKYpSEZLX1rgu1eFXfJsum/EuZJ2Sqr2m2WZQV7LjSa0VQll6V3T1byLMDBNiaDNYI/7kPMH9lzcngX1trUaNoegMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DB8PR04MB7162.eurprd04.prod.outlook.com (2603:10a6:10:12c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:42:08 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 08:42:08 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v3 5/6] bap: Add support for BAP broadcast sink
Date:   Wed,  2 Aug 2023 11:41:39 +0300
Message-Id: <20230802084140.51105-6-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802084140.51105-1-claudia.rosu@nxp.com>
References: <20230802084140.51105-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::16) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DB8PR04MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 9868da03-5a96-4590-b79c-08db93345af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlKtuOGGc3XmGIRtc4CuTLfBdDQManqEyyZjVl934qbIemYLGRNTerm9kVFnGV+85lpCVO3hqIDMWNCfMJPyRnfSJ22YccINI+53i6AwBwyoauCivC+9BBLisv9qUFj4mJldG59JG1/5uWDRGEk8OlWES7zvTSzsb0/yh8RlW8fjBSuWgYTBvI1i9VZ+uW9PFG3l4Zob/xyUEoGro4/KSxIYu6B+Avk8IM3yIdH00xKoNX58VtjtLAzLtraIetuU8LzW0rQWlZ353+kHEs9eMCcRKHJFuXD4dWZl/NEyXe12/JgP7c6lVanHuf+fK0J1BI+V/cX3Wp1y6w82ZxqYzqeJwse5fjxkNAXxHAtqmf5AsH2hgTogBY6bmlKKlywzi8PbkBd64wc6YV5Jv0sM7dccUR+vvZE0Cq7b8QCTMtJ9MaUZHMsWcoAq3oxPlt/GiNCmfc8lnSODdKknPwg//mqgopPnaHMTLtMxAhYScHn5UPtxASVBqwqE3rSxX+uxh6q9Cwrwh8SnuCiQIROEiSk4+/D5IM2IkVXNEcLEViJfnjFVvtDstJTnqjWaEV4ipUfJuGCvQDaa9xS+wKcn6LECQTGOlpjHH5lyRDgkrC2P8/TlleFxtvUrS8RENIex
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(2616005)(36756003)(6512007)(316002)(478600001)(86362001)(38350700002)(38100700002)(66946007)(66556008)(6666004)(66476007)(6486002)(52116002)(6916009)(4326008)(1076003)(6506007)(41300700001)(26005)(186003)(83380400001)(8676002)(8936002)(5660300002)(30864003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?go8N9yLiN1bvEpWzAnYGsI+QbqGRDgtK0bDpIQafxukBOQcpFmMAgPpVmS5v?=
 =?us-ascii?Q?KRDqBfJFnxWOyXeNZ9hzdYXkZVv+V/OXgdVZvDB9/NKicDFYUK03IYRA/2NQ?=
 =?us-ascii?Q?N1+gwoYETMXWzxyp/K0FIqDs/NRjQ86rGzoLLhCY+3gfLmmr15ppV4fSMtTq?=
 =?us-ascii?Q?Ml2RAwsZKPgKnMSbRAVV9DDNVAcOlVji4pbJFsY4XFrNLMMI5AMHkUL3er2b?=
 =?us-ascii?Q?xRpzsBAdG55GLRs5pg2WT1SsEHacC5KpGiLILDCRcrrU6GMYPFolKRx8YkGS?=
 =?us-ascii?Q?J4IpFllCiYfg61QD7ZjflvGgu245zBXKDYV5NsKj8gmXzU4SCaEDa+pQ2KPn?=
 =?us-ascii?Q?h60xKCQ1swG/eJOkWDAU1AptRKHHVVFAcdosOfwVBNG14ntivHnJTXzx2901?=
 =?us-ascii?Q?dDaC521cFkmPcr2RmJKkySalGkK0So9fn+VQ3GIE/OHBXZMHDrSzp06btbBf?=
 =?us-ascii?Q?AN0hYhpk1yZXt1b4hFsftZfdUVvRGKofgX/6O+H0PchgnTaabMiCwY0IO4Mc?=
 =?us-ascii?Q?DVEFBpJvXHQYJCuX4uJgPDftBZczGbKjjW2HLCN1BfrdfElR32WxhdtKrKQt?=
 =?us-ascii?Q?FJdv3YEqJ6WumSMHX6InN28IlC1xtI6ThvDfQJOFeVidouiRTLEKFyO0oSul?=
 =?us-ascii?Q?vbX6FsTy+n+d89lIq1q5liHvKTnNvVmQtKZsf1TrmlEp0ikpfXB71aXbC0xx?=
 =?us-ascii?Q?3lXvXEMEq4RdWL1CzxILseXeuMBoIsOvspxF6uaUpTIGa3Ad3lhPgseiJhRC?=
 =?us-ascii?Q?ZvfQ1oIfySwPztrd/O7+KAQ0j2NnUbfKGxkkArTPy+XcpMoHk945Tcw0x3nE?=
 =?us-ascii?Q?b4bAXHLTwJ18pMLOmHYOLOG4N1qYsKUibC7prtyHcyT1IVpldRqDwpRPqew4?=
 =?us-ascii?Q?LaJnXh3wu03v4ZziJOUkwDzMkDTDiIhbKHJg+1WIDuHQQvu5w6dOQ2yqZ9w/?=
 =?us-ascii?Q?CDToAVLT0BoiTGFBI0hlChZZDRLVq2WoqCAax8Yk7U8JE0kkkrepVXbn4Ca8?=
 =?us-ascii?Q?Q7TEgoT+Yh++bjjpYVAK4S5knB1au8kjFU+bN4xTdwQCa9Qm8o/gP3ivlzBM?=
 =?us-ascii?Q?QSYhg8rh9UiEmkGUyDBSM1tNS/JKjfYmsCl7zkepYSwnRoLHRStdJ0YBgQIH?=
 =?us-ascii?Q?rw0OEJ/rzgwF+wz8W5UJ2hJW2Fe3IIzSy6MaetzvkiXobJ8ikriaoXy9qYAp?=
 =?us-ascii?Q?yQmZ43+01WFjcgUKP9dAfdOYag/4z+kZuEGjerGe1+4XzhfFPDvaWKP8ySeY?=
 =?us-ascii?Q?Bx4JcfoV3D1lfJq2yQoOW3LGiuhiJHyLbPOD23lkqB9hEwhXXI0VBtu4jFuo?=
 =?us-ascii?Q?WdgfAn36vM8exvl5EE81uUlWHZkTBEAioXFN11AwKIsFM8nsfm1dH1622pQl?=
 =?us-ascii?Q?h4Z4q3RZUlxtg+Oz/j+hFa28Fv1c8E6ZmZbA/upZnCzGwVJjYKw4tQJoL66T?=
 =?us-ascii?Q?JNEyXS4SgH1Ui+yPMSd4g9I70pL8qA2HTnecIZWZYeu5+ZyOqTvorhD7wAZ2?=
 =?us-ascii?Q?CUIcZm7EQxUkvfRE3dynfer1M6e0QQkm2JZYJ5Hran06Dh5sddwVuDydHhS4?=
 =?us-ascii?Q?bgee3I9RgpQcw2zIuVSv9/z8l6/j1RHpXPkT6ZTp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9868da03-5a96-4590-b79c-08db93345af2
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:42:08.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Me5k2k9dzDcCmtZen+xehJof9DuhPn1Mj2vpck7veDqhBcLrr4UIOSMZ4dk4F9ebhiakO/4azPdsQahOo2m6CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7162
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
 profiles/audio/bap.c | 300 ++++++++++++++++++++++++++++++++++++++-----
 src/shared/bap.c     | 153 +++++++++++++++++++---
 src/shared/bap.h     |  11 +-
 3 files changed, 410 insertions(+), 54 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8cbb238ef..112e0673d 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -34,6 +34,7 @@
 #include "lib/hci.h"
 #include "lib/sdp.h"
 #include "lib/uuid.h"
+#include "lib/iso.h"
 
 #include "src/btd.h"
 #include "src/dbus-common.h"
@@ -58,6 +59,7 @@
 #define ISO_SOCKET_UUID "6fbaf188-05e0-496a-9885-d6ddfdb4e03e"
 #define PACS_UUID_STR "00001850-0000-1000-8000-00805f9b34fb"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
+#define MEDIA_INTERFACE "org.bluez.Media1"
 
 struct bap_ep {
 	char *path;
@@ -186,8 +188,11 @@ static gboolean get_uuid(const GDBusPropertyTable *property,
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
 
@@ -341,15 +346,18 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
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
@@ -556,7 +564,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE) {
-		/* Mark CIG and CIS to be auto assigned */
+		/* Mark BIG and BIS to be auto assigned */
 		ep->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
 		ep->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
 	} else {
@@ -577,8 +585,12 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
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
@@ -597,13 +609,120 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
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
+
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
@@ -650,14 +769,23 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 					struct bt_bap_pac *rpac)
 {
 	struct btd_adapter *adapter = data->user_data;
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
+		device = btd_adapter_find_device_by_path(adapter,
+					bt_bap_pac_get_name(rpac));
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
@@ -1854,7 +2038,7 @@ static int bap_adapter_probe(struct btd_profile *p,
 
 	bap_data_add(data);
 
-	if (!bt_bap_attach_broadcast(data->bap)) {
+	if (!bt_bap_attach_broadcast(data->bap, BT_BAP_BCAST_SOURCE)) {
 		error("BAP unable to attach");
 		return -EINVAL;
 	}
@@ -1901,12 +2085,62 @@ static struct btd_profile bap_profile = {
 	.experimental	= true,
 };
 
+static GDBusProxy *media;
+
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, MEDIA_INTERFACE)) {
+		DBG("proxy added %s ", g_dbus_proxy_get_path(proxy));
+		media = proxy;
+	}
+}
+
+static int bcast_server_probe(struct btd_adapter *adapter)
+{
+	static GDBusClient *client;
+
+	client = g_dbus_client_new(btd_get_dbus_connection(),
+			"org.bluez", "/org/bluez");
+
+	g_dbus_client_set_proxy_handlers(client, proxy_added, NULL,
+							NULL, NULL);
+
+	return 0;
+}
+
+static void bcast_server_remove(struct btd_adapter *adapter)
+{
+	DBG("path %s", adapter_get_path(adapter));
+}
+
+static void bcast_new_source(struct btd_adapter *adapter,
+				struct btd_device *device)
+{
+	struct bap_data *data = queue_find(sessions, match_data_bap_data,
+						adapter);
+
+	bt_bap_new_bcast_source(data->bap, device_get_path(device), 0x06);
+}
+
+static struct btd_adapter_driver bcast_driver = {
+	.name			= "bcast",
+	.probe			= bcast_server_probe,
+	.remove			= bcast_server_remove,
+	.device_discovered	= bcast_new_source,
+	.experimental		= true,
+};
+
 static unsigned int bap_id = 0;
 
 static int bap_init(void)
 {
 	int err;
 
+	btd_register_adapter_driver(&bcast_driver);
 	err = btd_profile_register(&bap_profile);
 	if (err)
 		return err;
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 72ce67c08..ae3f64730 100644
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
@@ -2579,6 +2605,14 @@ uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
 	return pac->type;
 }
 
+char *bt_bap_pac_get_name(struct bt_bap_pac *pac)
+{
+	if (!pac)
+		return NULL;
+
+	return pac->name;
+}
+
 uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac)
 {
 	struct bt_pacs *pacs = pac->bdb->pacs;
@@ -3996,7 +4030,7 @@ clone:
 	return true;
 }
 
-bool bt_bap_attach_broadcast(struct bt_bap *bap)
+bool bt_bap_attach_broadcast(struct bt_bap *bap, uint8_t type)
 {
 	struct bt_bap_endpoint *ep;
 
@@ -4008,7 +4042,7 @@ bool bt_bap_attach_broadcast(struct bt_bap *bap)
 
 	queue_push_tail(sessions, bap);
 
-	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb);
+	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb, type);
 	if (ep)
 		ep->bap = bap;
 
@@ -4221,9 +4255,19 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
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
 
@@ -4382,6 +4426,11 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
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
 
@@ -4446,13 +4495,19 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
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
@@ -4913,6 +4968,18 @@ struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream)
 	return io->io;
 }
 
+char *bt_bap_stream_get_remote_name(struct bt_bap_stream *stream)
+{
+	return bt_bap_pac_get_name(stream->rpac);
+}
+
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
@@ -4944,6 +5011,14 @@ static bool match_req_id(const void *data, const void *match_data)
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
@@ -5132,3 +5207,43 @@ bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd)
 
 	return io->connecting;
 }
+
+bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name,
+					uint8_t codec)
+{
+	struct bt_bap_endpoint *ep;
+	struct bt_bap_pac *pac_broadcast_source, *local_sink;
+	struct bt_bap_codec bap_codec;
+
+	bap_codec.id = codec;
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
index 50b567663..cf98ec8b7 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -163,6 +163,8 @@ bool bt_bap_remove_pac(struct bt_bap_pac *pac);
 
 uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac);
 
+char *bt_bap_pac_get_name(struct bt_bap_pac *pac);
+
 uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac);
 
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
@@ -186,7 +188,7 @@ struct bt_bap *bt_bap_ref(struct bt_bap *bap);
 void bt_bap_unref(struct bt_bap *bap);
 
 bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client);
-bool bt_bap_attach_broadcast(struct bt_bap *bap);
+bool bt_bap_attach_broadcast(struct bt_bap *bap, uint8_t type);
 void bt_bap_detach(struct bt_bap *bap);
 
 bool bt_bap_set_debug(struct bt_bap *bap, bt_bap_debug_func_t cb,
@@ -289,7 +291,7 @@ struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream);
 struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream);
 
 struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream);
-
+bool bt_bap_match_bcast_sink_stream(const void *data, const void *user_data);
 bool bt_bap_stream_set_io(struct bt_bap_stream *stream, int fd);
 
 int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id);
@@ -305,3 +307,8 @@ uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream);
 
 int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd);
 bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd);
+
+bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name,
+					uint8_t codec);
+
+char *bt_bap_stream_get_remote_name(struct bt_bap_stream *stream);
-- 
2.34.1

