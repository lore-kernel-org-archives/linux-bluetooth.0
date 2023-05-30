Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB37C7EE31
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 14:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjE3OPj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 10:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjE3OPh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 10:15:37 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2045.outbound.protection.outlook.com [40.107.13.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C56102
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 07:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjYroOB8vhDyR0rZ0eyN9Ctu5uD9t6WBKi6BF9bd2e17ELvqg3ARZqib6NG76+6WcSXUcG8mxg5GPtJaSiEy2Gu9Htc29eHmzlSnBfo+KWunT4kXKfYnj5AypH+MS4YJt9nOIWz99c6tF48n4qQDCJic7LL0aB+cLUOcI7WlYbCA/Lx0CLhWV+jVzNmLVimzhTlsWIr6w8e7lCOadzJvxNDzpguAFLH/nKB17bG40ElKYVveOR94zDUB+o+/ImPcjUe4UqUIAAx/I5ly0lXGiIPZopAaUAbi/vU7L7M7F62HLlnckkHSxhGCEnqQFX2Dk4MyNZKshUo4M2yuw6w5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jHE0/7x1oj43W1g6+zf2Y/KKbUhBn5veuy6zbmt6fM=;
 b=VWbtUBUff7CghWp3UbErCRyjdVCC5GQ6hMW4J5gKcYkbbx0kRorHhsVwsZh3iU7G/CdsZ/MFzqgC+YLYzeHowQb60bSzec74mg5gThTD25Qs1cmYXpwxAaQ4apJ7G2gi9VCLYRYSphXGTSmXpIqd7XCPy7xJrGcLXdT55BRKEsJqXYWhf8i3xzvWAAoqqOOPYKjFksVFXlx81aPRYLCsNYSKxiFhYxDRmOD5Is00dTNIue2djjPv3nVu6I8w6KMlTZl5cu068ecZyvUgVDuew4BwU4KOSmst1lF6JYPyPz0uwaPTKiEW+nnKCWwDvO+TNm147fAlCjvFhgVsPMpVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jHE0/7x1oj43W1g6+zf2Y/KKbUhBn5veuy6zbmt6fM=;
 b=og8+La70TB1FQYX+9fdHGHERrArELm7fqZ+UzN/2m0Ew/SSx7SJnV5tJ2lgGnQXMjJMr+OZvqSFGG0k9qi1BtQlV3V9tlw7jMNmpHPqtS7Ds04JsskPjyQpUhKG52yF7/lS08IPDB2f/y/YAxE7JGF4ew+d/LZ9418DX0Iwnvo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DBBPR04MB7913.eurprd04.prod.outlook.com (2603:10a6:10:1ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:14:02 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cedb:51d6:a774:f81a]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cedb:51d6:a774:f81a%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 14:14:02 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH BlueZ v3 1/4] Split bt_bap_qos structure into unicast and broadcast structures
Date:   Tue, 30 May 2023 17:13:36 +0300
Message-Id: <20230530141339.100733-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530141339.100733-1-silviu.barbulescu@nxp.com>
References: <20230530141339.100733-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0021.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::34) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DBBPR04MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 884a1bc8-36b7-40f8-957f-08db61181ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHLYKnJCRhoe70wrvNNy0ymta8QyCiqSH3jKv7a1VG00u0olsNgXu9L+STQvGTR7vZ9oDeVP6hQpd1F+lZisxmes9E28r1JbZDe9piNoJ0+yeJNTnojTelpeYYCaeSrcVjDYMO40TY9NjshtoOtPV7ITcwpgqyKheKZinqZQKJrpX7vjqFHktswbp+9ptN55W2X+Vplot7BAog8Q7zOIKxRYpHlc+zHcfevOVmHuolwy5Ii7P6JtiL0HwmMFzM8X3JABmkFFD2v68W5DU3htcG5Im4Ch2X3XvD5FfATKT4i8Ttu0iRBzJWtc2IgDlgiP9tQowFGERtiJCYV5G/14WzNGhkADIowF9J7qGi5iJYnkq7aRyS3hUHp0PHIVGmjtxrw/rpplotYfBSmQ8BN7c2W7jKtevCgi2StQ3grxu9hYtGY0WW3M6z9EvwwT9OTNg1pcWwAgc781bHeZJehAe4DE+gm65OpPJyaVaL7Q/Yp/UBlsDIpLaS+4mHGG7ZKxia31rQuXBOoVlEpkUiaOclklNm2oZRlcBg6aW1U57HPqnHzMRgpRfEwRdDBpScIfdv44y0wHl3ls7RrJedkmjurpePKIzsQZ/tZqxofsZSJIxzY8qDAyLGWDyeSTQ/ZU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(478600001)(38100700002)(38350700002)(66556008)(66476007)(66946007)(41300700001)(52116002)(6486002)(8676002)(5660300002)(86362001)(8936002)(26005)(2906002)(30864003)(1076003)(186003)(6512007)(6506007)(83380400001)(4326008)(6916009)(316002)(6666004)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dN801EirF4W0uKsXlZyY8JB1SUqRhls7SStoGIkBmfbDnUFFGecMv7TK7URP?=
 =?us-ascii?Q?GAPPExmLqMN1WFS9E74OYIu/Gr9kwvFDXGlKk0uv2D4BoivKjbSVb9AqVQlc?=
 =?us-ascii?Q?zvAhlU1xX24S5RE0ZWVz8emrj3nO171JlcoyflyDgNVF0ZRcH7Shk2jo+0i0?=
 =?us-ascii?Q?NTjKThXzqymnIlFazpz3h4q4kq9fHaOI9qDhmuDdu2rltUiXZExDbvqpnZHt?=
 =?us-ascii?Q?3Rb+ZoOAvQl3B+qaPomCATLex80oXklQABhP3hBFinmh50R4RuOCAXdvvsB/?=
 =?us-ascii?Q?OBVWpLlAJB6tdUVFWLiKCCAM3qEuKeboGz1mqX8VeDbseHYmWqYsfX2kr68b?=
 =?us-ascii?Q?paLwqyXSk4xuT9XaWyFMhy4azqC9dd8OzpkTLcM3gYxwy/HseBT5mV9R/GlS?=
 =?us-ascii?Q?g9bJXNOF19pTA1GaSBCifSaZZVYY6U3zEdkR4N47SZlzYteqzuPF9CJJ+9Ir?=
 =?us-ascii?Q?Vsm62SJ3MBp6bVLlXvfvP8RtjKigpNUg3gT30EjcVIEn+wEbo3godNGvU1yq?=
 =?us-ascii?Q?gWmeJMgaEcPNKzKFEfTlU4R0NYbbjO343KQH3o9OjWRMOxnJuoMNjeZpKAFl?=
 =?us-ascii?Q?+l8KgfDk+7C6QkvKAa0aaZCqPMoFNm9gRlGtheQ1OIGUZq4dV7UOBVhDykgf?=
 =?us-ascii?Q?WKlpEQQzTUd/Txls6IECnPJeBMKvRFPPqmBCwCO1O915DoKVkBzApFiM1vqV?=
 =?us-ascii?Q?Q0cyO3PHihtpsX3Y01EUJM+KlhS27+cPdIRiH187unTG3u8HgZ7uD4Sfz5nk?=
 =?us-ascii?Q?0i1cfSl9NHvGT1zE+3KZXaFfYZT84Km360ybQiqhbrW3FJ2ij904OiADMCUV?=
 =?us-ascii?Q?U0/moBXXPbycckz2t1ZC+Lp4VldryYbiWKU2zn0SwImv72nG9x33ps6+X987?=
 =?us-ascii?Q?jJR01IvCJodgDdCKZBLRCL1gIKJjw26Q4+REN7SKzF2kVxk+KJOBGUqHGNdS?=
 =?us-ascii?Q?yuG1peYZo5ISAcvSGM+o6Pvitb6FIb7fMMZ9Nm7mRrEiTxlQyNFuyKO57NZu?=
 =?us-ascii?Q?V9LpAqt/1cCp84CGnIvymLApJSJMF17Vau7NQCWyohSb6YuwONIOL++yJQlY?=
 =?us-ascii?Q?AYhJdAnAxOm297MMy6NTL2LAb9sVsavg9ZHyUmjvtKKRYAbH/V2gjKSVOX8V?=
 =?us-ascii?Q?d90888uzil7pqRHO89YzDr7Gz8/uAHrI4RkmVbCKNv0ZOTl6HE50jUe6jwFJ?=
 =?us-ascii?Q?2uSeAUaVFTowZteqduySF/7ZZCugxmjhIxCFs/kaOgybs/pJb7Hq4t+RXPfu?=
 =?us-ascii?Q?NryPx9xtUr3fVqc6+lEGyiULdBb6/upeNFcVoYQo/eQaacyHXg/g0Z2dzwL4?=
 =?us-ascii?Q?KdMVAvD9eOd6xhQp/JoTQeuJJm4yIK3Uzfsj/+t7D/yCoFKsb432vgITUWGm?=
 =?us-ascii?Q?6wSf+5L5UKkkdWEfEOMsYPUMt3Pqtf5vm0LPP3sU+5q2vNurBHM/DSYye9s+?=
 =?us-ascii?Q?VHplnzHIMvX8YKnTvOQPdDtVnyrD9vyI/f7qlK+n35mJ5t5OI5D30kj5T4FO?=
 =?us-ascii?Q?J7HCRLGxaMThEkAYqZ0gSS1jBYhrEb643Y20/Wj3x4xe7zJ/2nVEzO7ibM9h?=
 =?us-ascii?Q?H+WHNxAXnbvNZzDCK/pB7QFwkCbzNc3ttkzXOb+zNKcGh7iz0ZfLgPnyKe8L?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884a1bc8-36b7-40f8-957f-08db61181ea8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:14:02.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/PXWq7LBV5cXGaaEZ2BWcZWemxL1+ztdYrIXl8N/oXcyzD2ltkPrLGtITypDwGGqNms9A46peJz3Qwmyrp1ayCbdWHPvLjWhcJ5WsixaDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7913
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This splits bt_bap_qos structure into unicast and broadcast structures

---
 profiles/audio/bap.c       | 58 +++++++++++++-----------
 profiles/audio/media.c     | 33 ++++++++------
 profiles/audio/transport.c | 25 ++++++-----
 src/shared/bap.c           | 92 ++++++++++++++++++++------------------
 src/shared/bap.h           | 42 ++++++++++++++---
 unit/test-bap.c            | 75 ++++++++++++++++---------------
 6 files changed, 188 insertions(+), 137 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 1a543a9ce..cbaf705c0 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -253,6 +253,7 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 				struct iovec **metadata, struct bt_bap_qos *qos)
 {
 	const char *key;
+	struct bt_bap_io_qos io_qos;
 
 	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter value, entry;
@@ -282,17 +283,17 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->cig_id);
+			dbus_message_iter_get_basic(&value, &qos->ucast.cig_id);
 		} else if (!strcasecmp(key, "CIS")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->cis_id);
+			dbus_message_iter_get_basic(&value, &qos->ucast.cis_id);
 		} else if (!strcasecmp(key, "Interval")) {
 			if (var != DBUS_TYPE_UINT32)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->interval);
+			dbus_message_iter_get_basic(&value, &io_qos.interval);
 		} else if (!strcasecmp(key, "Framing")) {
 			dbus_bool_t val;
 
@@ -301,7 +302,7 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 
 			dbus_message_iter_get_basic(&value, &val);
 
-			qos->framing = val;
+			qos->ucast.framing = val;
 		} else if (!strcasecmp(key, "PHY")) {
 			const char *str;
 
@@ -311,42 +312,43 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 			dbus_message_iter_get_basic(&value, &str);
 
 			if (!strcasecmp(str, "1M"))
-				qos->phy = 0x01;
+				io_qos.phy = 0x01;
 			else if (!strcasecmp(str, "2M"))
-				qos->phy = 0x02;
+				io_qos.phy = 0x02;
 			else
 				goto fail;
 		} else if (!strcasecmp(key, "SDU")) {
 			if (var != DBUS_TYPE_UINT16)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->sdu);
+			dbus_message_iter_get_basic(&value, &io_qos.sdu);
 		} else if (!strcasecmp(key, "Retransmissions")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->rtn);
+			dbus_message_iter_get_basic(&value, &io_qos.rtn);
 		} else if (!strcasecmp(key, "Latency")) {
 			if (var != DBUS_TYPE_UINT16)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->latency);
+			dbus_message_iter_get_basic(&value, &io_qos.latency);
 		} else if (!strcasecmp(key, "Delay")) {
 			if (var != DBUS_TYPE_UINT32)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->delay);
+			dbus_message_iter_get_basic(&value, &qos->ucast.delay);
 		} else if (!strcasecmp(key, "TargetLatency")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
 			dbus_message_iter_get_basic(&value,
-							&qos->target_latency);
+					&qos->ucast.target_latency);
 		}
 
 		dbus_message_iter_next(props);
 	}
 
+	memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
 	return 0;
 
 fail:
@@ -456,8 +458,8 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	/* Mark CIG and CIS to be auto assigned */
-	ep->qos.cig_id = BT_ISO_QOS_CIG_UNSET;
-	ep->qos.cis_id = BT_ISO_QOS_CIS_UNSET;
+	ep->qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
+	ep->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 
 	if (parse_properties(&props, &ep->caps, &ep->metadata, &ep->qos) < 0) {
 		DBG("Unable to parse properties");
@@ -734,11 +736,11 @@ static void bap_iso_qos(struct bt_bap_qos *qos, struct bt_iso_io_qos *io)
 	if (!qos)
 		return;
 
-	io->interval = qos->interval;
-	io->latency = qos->latency;
-	io->sdu = qos->sdu;
-	io->phy = qos->phy;
-	io->rtn = qos->rtn;
+	io->interval = qos->ucast.io_qos.interval;
+	io->latency = qos->ucast.io_qos.latency;
+	io->sdu = qos->ucast.io_qos.sdu;
+	io->phy = qos->ucast.io_qos.phy;
+	io->rtn = qos->ucast.io_qos.rtn;
 }
 
 static bool match_stream_qos(const void *data, const void *user_data)
@@ -749,10 +751,10 @@ static bool match_stream_qos(const void *data, const void *user_data)
 
 	qos = bt_bap_stream_get_qos((void *)stream);
 
-	if (iso_qos->ucast.cig != qos->cig_id)
+	if (iso_qos->ucast.cig != qos->ucast.cig_id)
 		return false;
 
-	return iso_qos->ucast.cis == qos->cis_id;
+	return iso_qos->ucast.cis == qos->ucast.cis_id;
 }
 
 static void iso_confirm_cb(GIOChannel *io, void *user_data)
@@ -993,8 +995,10 @@ static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
 	}
 
 	memset(&iso_qos, 0, sizeof(iso_qos));
-	iso_qos.ucast.cig = qos[0] ? qos[0]->cig_id : qos[1]->cig_id;
-	iso_qos.ucast.cis = qos[0] ? qos[0]->cis_id : qos[1]->cis_id;
+	iso_qos.ucast.cig = qos[0] ? qos[0]->ucast.cig_id :
+						qos[1]->ucast.cig_id;
+	iso_qos.ucast.cis = qos[0] ? qos[0]->ucast.cis_id :
+						qos[1]->ucast.cis_id;
 
 	bap_iso_qos(qos[0], &iso_qos.ucast.in);
 	bap_iso_qos(qos[1], &iso_qos.ucast.out);
@@ -1179,8 +1183,8 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 	g_io_channel_set_close_on_unref(io, FALSE);
 
 	/* Attempt to get CIG/CIS if they have not been set */
-	if (ep->qos.cig_id == BT_ISO_QOS_CIG_UNSET ||
-				ep->qos.cis_id == BT_ISO_QOS_CIS_UNSET) {
+	if (ep->qos.ucast.cig_id == BT_ISO_QOS_CIG_UNSET ||
+				ep->qos.ucast.cis_id == BT_ISO_QOS_CIS_UNSET) {
 		struct bt_iso_qos qos;
 		GError *err = NULL;
 
@@ -1192,12 +1196,12 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 			return;
 		}
 
-		ep->qos.cig_id = qos.ucast.cig;
-		ep->qos.cis_id = qos.ucast.cis;
+		ep->qos.ucast.cig_id = qos.ucast.cig;
+		ep->qos.ucast.cis_id = qos.ucast.cis;
 	}
 
 	DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
-					ep->qos.cig_id, ep->qos.cis_id);
+				ep->qos.ucast.cig_id, ep->qos.ucast.cis_id);
 }
 
 static void bap_attached(struct bt_bap *bap, void *user_data)
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 6ce668e31..515263af3 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -6,7 +6,7 @@
  *  Copyright (C) 2006-2007  Nokia Corporation
  *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
- *
+ *  Copyright 2023 NXP
  *
  */
 
@@ -748,7 +748,10 @@ static int parse_select_properties(DBusMessageIter *props, struct iovec *caps,
 					struct bt_bap_qos *qos)
 {
 	const char *key;
+	struct bt_bap_io_qos io_qos;
+	uint8_t framing = 0;
 
+	memset(&io_qos, 0, sizeof(io_qos));
 	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter value, entry;
 		int var;
@@ -777,17 +780,17 @@ static int parse_select_properties(DBusMessageIter *props, struct iovec *caps,
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->cig_id);
+			dbus_message_iter_get_basic(&value, &qos->ucast.cig_id);
 		} else if (!strcasecmp(key, "CIS")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->cis_id);
+			dbus_message_iter_get_basic(&value, &qos->ucast.cis_id);
 		} else if (!strcasecmp(key, "Interval")) {
 			if (var != DBUS_TYPE_UINT32)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->interval);
+			dbus_message_iter_get_basic(&value, &io_qos.interval);
 		} else if (!strcasecmp(key, "Framing")) {
 			dbus_bool_t val;
 
@@ -796,7 +799,7 @@ static int parse_select_properties(DBusMessageIter *props, struct iovec *caps,
 
 			dbus_message_iter_get_basic(&value, &val);
 
-			qos->framing = val;
+			framing = val;
 		} else if (!strcasecmp(key, "PHY")) {
 			const char *str;
 
@@ -806,42 +809,44 @@ static int parse_select_properties(DBusMessageIter *props, struct iovec *caps,
 			dbus_message_iter_get_basic(&value, &str);
 
 			if (!strcasecmp(str, "1M"))
-				qos->phy = 0x01;
+				io_qos.phy = 0x01;
 			else if (!strcasecmp(str, "2M"))
-				qos->phy = 0x02;
+				io_qos.phy = 0x02;
 			else
 				goto fail;
 		} else if (!strcasecmp(key, "SDU")) {
 			if (var != DBUS_TYPE_UINT16)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->sdu);
+			dbus_message_iter_get_basic(&value, &io_qos.sdu);
 		} else if (!strcasecmp(key, "Retransmissions")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->rtn);
+			dbus_message_iter_get_basic(&value, &io_qos.rtn);
 		} else if (!strcasecmp(key, "Latency")) {
 			if (var != DBUS_TYPE_UINT16)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->latency);
+			dbus_message_iter_get_basic(&value, &io_qos.latency);
 		} else if (!strcasecmp(key, "Delay")) {
 			if (var != DBUS_TYPE_UINT32)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->delay);
+			dbus_message_iter_get_basic(&value, &qos->ucast.delay);
 		} else if (!strcasecmp(key, "TargetLatency")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
 			dbus_message_iter_get_basic(&value,
-							&qos->target_latency);
+						&qos->ucast.target_latency);
 		}
 
 		dbus_message_iter_next(props);
 	}
 
+	memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
+	qos->ucast.framing = framing;
 	return 0;
 
 fail:
@@ -875,8 +880,8 @@ static void pac_select_cb(struct media_endpoint *endpoint, void *ret, int size,
 	memset(&qos, 0, sizeof(qos));
 
 	/* Mark CIG and CIS to be auto assigned */
-	qos.cig_id = BT_ISO_QOS_CIG_UNSET;
-	qos.cis_id = BT_ISO_QOS_CIS_UNSET;
+	qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
+	qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 
 	memset(&caps, 0, sizeof(caps));
 	memset(&meta, 0, sizeof(meta));
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 9172d167e..82f5fa6fe 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2006-2007  Nokia Corporation
  *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -828,7 +829,7 @@ static gboolean qos_exists(const GDBusPropertyTable *property, void *data)
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	return bap->qos.phy != 0x00;
+	return bap->qos.ucast.io_qos.phy != 0x00;
 }
 
 static gboolean get_cig(const GDBusPropertyTable *property,
@@ -838,7 +839,7 @@ static gboolean get_cig(const GDBusPropertyTable *property,
 	struct bap_transport *bap = transport->data;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-							&bap->qos.cig_id);
+							&bap->qos.ucast.cig_id);
 
 	return TRUE;
 }
@@ -850,7 +851,7 @@ static gboolean get_cis(const GDBusPropertyTable *property,
 	struct bap_transport *bap = transport->data;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-							&bap->qos.cis_id);
+							&bap->qos.ucast.cis_id);
 
 	return TRUE;
 }
@@ -862,7 +863,7 @@ static gboolean get_interval(const GDBusPropertyTable *property,
 	struct bap_transport *bap = transport->data;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
-							&bap->qos.interval);
+					&bap->qos.ucast.io_qos.interval);
 
 	return TRUE;
 }
@@ -872,7 +873,7 @@ static gboolean get_framing(const GDBusPropertyTable *property,
 {
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
-	dbus_bool_t val = bap->qos.framing;
+	dbus_bool_t val = bap->qos.ucast.framing;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
 
@@ -885,7 +886,8 @@ static gboolean get_phy(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.phy);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&bap->qos.ucast.io_qos.phy);
 
 	return TRUE;
 }
@@ -896,7 +898,8 @@ static gboolean get_sdu(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &bap->qos.sdu);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&bap->qos.ucast.io_qos.sdu);
 
 	return TRUE;
 }
@@ -907,7 +910,8 @@ static gboolean get_retransmissions(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.rtn);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&bap->qos.ucast.io_qos.rtn);
 
 	return TRUE;
 }
@@ -919,7 +923,7 @@ static gboolean get_latency(const GDBusPropertyTable *property,
 	struct bap_transport *bap = transport->data;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
-							&bap->qos.latency);
+					&bap->qos.ucast.io_qos.latency);
 
 	return TRUE;
 }
@@ -930,7 +934,8 @@ static gboolean get_delay(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &bap->qos.delay);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
+						&bap->qos.ucast.delay);
 
 	return TRUE;
 }
diff --git a/src/shared/bap.c b/src/shared/bap.c
index f194f466f..dd9eb797a 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *  Copyright 2023 NXP
  *
  */
 
@@ -861,15 +862,15 @@ static void stream_notify_qos(struct bt_bap_stream *stream)
 	status->state = ep->state;
 
 	qos = (void *)status->params;
-	qos->cis_id = stream->qos.cis_id;
-	qos->cig_id = stream->qos.cig_id;
-	put_le24(stream->qos.interval, qos->interval);
-	qos->framing = stream->qos.framing;
-	qos->phy = stream->qos.phy;
-	qos->sdu = cpu_to_le16(stream->qos.sdu);
-	qos->rtn = stream->qos.rtn;
-	qos->latency = cpu_to_le16(stream->qos.latency);
-	put_le24(stream->qos.delay, qos->pd);
+	qos->cis_id = stream->qos.ucast.cis_id;
+	qos->cig_id = stream->qos.ucast.cig_id;
+	put_le24(stream->qos.ucast.io_qos.interval, qos->interval);
+	qos->framing = stream->qos.ucast.framing;
+	qos->phy = stream->qos.ucast.io_qos.phy;
+	qos->sdu = cpu_to_le16(stream->qos.ucast.io_qos.sdu);
+	qos->rtn = stream->qos.ucast.io_qos.rtn;
+	qos->latency = cpu_to_le16(stream->qos.ucast.io_qos.latency);
+	put_le24(stream->qos.ucast.delay, qos->pd);
 
 	gatt_db_attribute_notify(ep->attr, (void *) status, len,
 					bt_bap_get_att(stream->bap));
@@ -898,8 +899,8 @@ static void stream_notify_metadata(struct bt_bap_stream *stream)
 	status->state = ep->state;
 
 	meta = (void *)status->params;
-	meta->cis_id = stream->qos.cis_id;
-	meta->cig_id = stream->qos.cig_id;
+	meta->cis_id = stream->qos.ucast.cis_id;
+	meta->cig_id = stream->qos.ucast.cig_id;
 
 	if (stream->meta) {
 		meta->len = stream->meta->iov_len;
@@ -1575,20 +1576,22 @@ static uint8_t ascs_qos(struct bt_ascs *ascs, struct bt_bap *bap,
 
 	memset(&qos, 0, sizeof(qos));
 
-	qos.cig_id = req->cig;
-	qos.cis_id = req->cis;
-	qos.interval = get_le24(req->interval);
-	qos.framing = req->framing;
-	qos.phy = req->phy;
-	qos.sdu = le16_to_cpu(req->sdu);
-	qos.rtn = req->rtn;
-	qos.latency = le16_to_cpu(req->latency);
-	qos.delay = get_le24(req->pd);
+	qos.ucast.cig_id = req->cig;
+	qos.ucast.cis_id = req->cis;
+	qos.ucast.io_qos.interval = get_le24(req->interval);
+	qos.ucast.framing = req->framing;
+	qos.ucast.io_qos.phy = req->phy;
+	qos.ucast.io_qos.sdu = le16_to_cpu(req->sdu);
+	qos.ucast.io_qos.rtn = req->rtn;
+	qos.ucast.io_qos.latency = le16_to_cpu(req->latency);
+	qos.ucast.delay = get_le24(req->pd);
 
 	DBG(bap, "CIG 0x%02x CIS 0x%02x interval %u framing 0x%02x "
 			"phy 0x%02x SDU %u rtn %u latency %u pd %u",
-			req->cig, req->cis, qos.interval, qos.framing, qos.phy,
-			qos.sdu, qos.rtn, qos.latency, qos.delay);
+			req->cig, req->cis, qos.ucast.io_qos.interval,
+			qos.ucast.framing, qos.ucast.io_qos.phy,
+			qos.ucast.io_qos.sdu, qos.ucast.io_qos.rtn,
+			qos.ucast.io_qos.latency, qos.ucast.delay);
 
 	ep = bap_get_local_endpoint_id(bap, req->ase);
 	if (!ep) {
@@ -3295,13 +3298,13 @@ static void ep_status_qos(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 	if (!ep->stream)
 		return;
 
-	ep->stream->qos.interval = interval;
-	ep->stream->qos.framing = qos->framing;
-	ep->stream->qos.phy = qos->phy;
-	ep->stream->qos.sdu = sdu;
-	ep->stream->qos.rtn = qos->rtn;
-	ep->stream->qos.latency = latency;
-	ep->stream->qos.delay = pd;
+	ep->stream->qos.ucast.io_qos.interval = interval;
+	ep->stream->qos.ucast.framing = qos->framing;
+	ep->stream->qos.ucast.io_qos.phy = qos->phy;
+	ep->stream->qos.ucast.io_qos.sdu = sdu;
+	ep->stream->qos.ucast.io_qos.rtn = qos->rtn;
+	ep->stream->qos.ucast.io_qos.latency = latency;
+	ep->stream->qos.ucast.delay = pd;
 
 	if (ep->old_state == BT_ASCS_ASE_STATE_CONFIG)
 		bap_stream_config_cfm(ep->stream);
@@ -4201,8 +4204,8 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 	memset(&config, 0, sizeof(config));
 
 	config.ase = stream->ep->id;
-	config.latency = qos->target_latency;
-	config.phy = qos->phy;
+	config.latency = qos->ucast.target_latency;
+	config.phy = qos->ucast.io_qos.phy;
 	config.codec = stream->rpac->codec;
 
 	iov[0].iov_base = &config;
@@ -4384,15 +4387,15 @@ unsigned int bt_bap_stream_qos(struct bt_bap_stream *stream,
 
 	/* TODO: Figure out how to pass these values around */
 	qos.ase = stream->ep->id;
-	qos.cig = data->cig_id;
-	qos.cis = data->cis_id;
-	put_le24(data->interval, qos.interval);
-	qos.framing = data->framing;
-	qos.phy = data->phy;
-	qos.sdu = cpu_to_le16(data->sdu);
-	qos.rtn = data->rtn;
-	qos.latency = cpu_to_le16(data->latency);
-	put_le24(data->delay, qos.pd);
+	qos.cig = data->ucast.cig_id;
+	qos.cis = data->ucast.cis_id;
+	put_le24(data->ucast.io_qos.interval, qos.interval);
+	qos.framing = data->ucast.framing;
+	qos.phy = data->ucast.io_qos.phy;
+	qos.sdu = cpu_to_le16(data->ucast.io_qos.sdu);
+	qos.rtn = data->ucast.io_qos.rtn;
+	qos.latency = cpu_to_le16(data->ucast.io_qos.latency);
+	put_le24(data->ucast.delay, qos.pd);
 
 	iov.iov_base = &qos;
 	iov.iov_len = sizeof(qos);
@@ -4796,8 +4799,8 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 		return -EALREADY;
 
 	if (stream->client != link->client ||
-			stream->qos.cig_id != link->qos.cig_id ||
-			stream->qos.cis_id != link->qos.cis_id)
+			stream->qos.ucast.cig_id != link->qos.ucast.cig_id ||
+			stream->qos.ucast.cis_id != link->qos.ucast.cis_id)
 		return -EINVAL;
 
 	if (!stream->links)
@@ -4834,7 +4837,7 @@ static void bap_stream_get_in_qos(void *data, void *user_data)
 	struct bt_bap_qos **qos = user_data;
 
 	if (!qos || *qos || stream->ep->dir != BT_BAP_SOURCE ||
-						!stream->qos.sdu)
+				!stream->qos.ucast.io_qos.sdu)
 		return;
 
 	*qos = &stream->qos;
@@ -4845,7 +4848,8 @@ static void bap_stream_get_out_qos(void *data, void *user_data)
 	struct bt_bap_stream *stream = data;
 	struct bt_bap_qos **qos = user_data;
 
-	if (!qos || *qos || stream->ep->dir != BT_BAP_SINK || !stream->qos.sdu)
+	if (!qos || *qos || stream->ep->dir != BT_BAP_SINK ||
+				!stream->qos.ucast.io_qos.sdu)
 		return;
 
 	*qos = &stream->qos;
diff --git a/src/shared/bap.h b/src/shared/bap.h
index e9f769d0e..0c42e730f 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *  Copyright 2023 NXP
  *
  */
 
@@ -49,17 +50,46 @@ struct bt_ltv {
 	uint8_t  value[0];
 } __packed;
 
-struct bt_bap_qos {
+struct bt_bap_io_qos {
+	uint32_t interval;	/* Frame interval */
+	uint16_t latency;	/* Transport Latency */
+	uint16_t sdu;		/* Maximum SDU Size */
+	uint8_t  phy;		/* PHY */
+	uint8_t  rtn;		/* Retransmission Effort */
+};
+
+struct bt_bap_ucast_qos {
 	uint8_t  cig_id;
 	uint8_t  cis_id;
-	uint32_t interval;		/* Frame interval */
 	uint8_t  framing;		/* Frame framing */
-	uint8_t  phy;			/* PHY */
-	uint16_t sdu;			/* Maximum SDU Size */
-	uint8_t  rtn;			/* Retransmission Effort */
-	uint16_t latency;		/* Transport Latency */
 	uint32_t delay;			/* Presentation Delay */
 	uint8_t  target_latency;	/* Target Latency */
+	struct bt_bap_io_qos io_qos;
+};
+
+struct bt_bap_bcast_qos {
+	uint8_t  big;
+	uint8_t  bis;
+	uint8_t  sync_interval;
+	uint8_t  packing;
+	uint8_t  framing;
+	uint8_t  encryption;
+	struct iovec bcode;
+	uint8_t  options;
+	uint16_t skip;
+	uint16_t sync_timeout;
+	uint8_t  sync_cte_type;
+	uint8_t  mse;
+	uint16_t timeout;
+	uint8_t  pa_sync;
+	struct bt_bap_io_qos io_qos;
+};
+
+struct bt_bap_qos {
+	union {
+			struct bt_bap_ucast_qos ucast;
+			struct bt_bap_bcast_qos bcast;
+		};
 };
 
 typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data);
diff --git a/unit/test-bap.c b/unit/test-bap.c
index bf525742d..adade07db 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -712,12 +712,15 @@ static void test_disc(void)
 #define QOS_BALANCED_2M \
 	{ \
 		.target_latency = BT_BAP_CONFIG_LATENCY_BALANCED, \
-		.phy = BT_BAP_CONFIG_PHY_2M, \
+		.io_qos.phy = BT_BAP_CONFIG_PHY_2M, \
 	}
-
+#define QOS_UCAST \
+{\
+	.ucast = QOS_BALANCED_2M, \
+}
 static struct test_config cfg_snk_8_1 = {
 	.cc = LC3_CONFIG_8_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -727,7 +730,7 @@ static struct test_config cfg_snk_8_1 = {
 
 static struct test_config cfg_snk_8_2 = {
 	.cc = LC3_CONFIG_8_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -737,7 +740,7 @@ static struct test_config cfg_snk_8_2 = {
 
 static struct test_config cfg_snk_16_1 = {
 	.cc = LC3_CONFIG_16_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -747,7 +750,7 @@ static struct test_config cfg_snk_16_1 = {
 
 static struct test_config cfg_snk_16_2 = {
 	.cc = LC3_CONFIG_16_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -757,7 +760,7 @@ static struct test_config cfg_snk_16_2 = {
 
 static struct test_config cfg_snk_24_1 = {
 	.cc = LC3_CONFIG_24_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -767,7 +770,7 @@ static struct test_config cfg_snk_24_1 = {
 
 static struct test_config cfg_snk_24_2 = {
 	.cc = LC3_CONFIG_24_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -777,7 +780,7 @@ static struct test_config cfg_snk_24_2 = {
 
 static struct test_config cfg_snk_32_1 = {
 	.cc = LC3_CONFIG_32_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -787,7 +790,7 @@ static struct test_config cfg_snk_32_1 = {
 
 static struct test_config cfg_snk_32_2 = {
 	.cc = LC3_CONFIG_32_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -797,7 +800,7 @@ static struct test_config cfg_snk_32_2 = {
 
 static struct test_config cfg_snk_44_1 = {
 	.cc = LC3_CONFIG_44_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -807,7 +810,7 @@ static struct test_config cfg_snk_44_1 = {
 
 static struct test_config cfg_snk_44_2 = {
 	.cc = LC3_CONFIG_44_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -817,7 +820,7 @@ static struct test_config cfg_snk_44_2 = {
 
 static struct test_config cfg_snk_48_1 = {
 	.cc = LC3_CONFIG_48_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -827,7 +830,7 @@ static struct test_config cfg_snk_48_1 = {
 
 static struct test_config cfg_snk_48_2 = {
 	.cc = LC3_CONFIG_48_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -837,7 +840,7 @@ static struct test_config cfg_snk_48_2 = {
 
 static struct test_config cfg_snk_48_3 = {
 	.cc = LC3_CONFIG_48_3,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -847,7 +850,7 @@ static struct test_config cfg_snk_48_3 = {
 
 static struct test_config cfg_snk_48_4 = {
 	.cc = LC3_CONFIG_48_4,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -857,7 +860,7 @@ static struct test_config cfg_snk_48_4 = {
 
 static struct test_config cfg_snk_48_5 = {
 	.cc = LC3_CONFIG_48_5,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -867,7 +870,7 @@ static struct test_config cfg_snk_48_5 = {
 
 static struct test_config cfg_snk_48_6 = {
 	.cc = LC3_CONFIG_48_6,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -899,7 +902,7 @@ static struct test_config cfg_snk_48_6 = {
 
 static struct test_config cfg_src_8_1 = {
 	.cc = LC3_CONFIG_8_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -909,7 +912,7 @@ static struct test_config cfg_src_8_1 = {
 
 static struct test_config cfg_src_8_2 = {
 	.cc = LC3_CONFIG_8_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -919,7 +922,7 @@ static struct test_config cfg_src_8_2 = {
 
 static struct test_config cfg_src_16_1 = {
 	.cc = LC3_CONFIG_16_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -929,7 +932,7 @@ static struct test_config cfg_src_16_1 = {
 
 static struct test_config cfg_src_16_2 = {
 	.cc = LC3_CONFIG_16_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -939,7 +942,7 @@ static struct test_config cfg_src_16_2 = {
 
 static struct test_config cfg_src_24_1 = {
 	.cc = LC3_CONFIG_24_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -949,7 +952,7 @@ static struct test_config cfg_src_24_1 = {
 
 static struct test_config cfg_src_24_2 = {
 	.cc = LC3_CONFIG_24_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -959,7 +962,7 @@ static struct test_config cfg_src_24_2 = {
 
 static struct test_config cfg_src_32_1 = {
 	.cc = LC3_CONFIG_32_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -969,7 +972,7 @@ static struct test_config cfg_src_32_1 = {
 
 static struct test_config cfg_src_32_2 = {
 	.cc = LC3_CONFIG_32_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -979,7 +982,7 @@ static struct test_config cfg_src_32_2 = {
 
 static struct test_config cfg_src_44_1 = {
 	.cc = LC3_CONFIG_44_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -989,7 +992,7 @@ static struct test_config cfg_src_44_1 = {
 
 static struct test_config cfg_src_44_2 = {
 	.cc = LC3_CONFIG_44_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -999,7 +1002,7 @@ static struct test_config cfg_src_44_2 = {
 
 static struct test_config cfg_src_48_1 = {
 	.cc = LC3_CONFIG_48_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -1009,7 +1012,7 @@ static struct test_config cfg_src_48_1 = {
 
 static struct test_config cfg_src_48_2 = {
 	.cc = LC3_CONFIG_48_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -1019,7 +1022,7 @@ static struct test_config cfg_src_48_2 = {
 
 static struct test_config cfg_src_48_3 = {
 	.cc = LC3_CONFIG_48_3,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -1029,7 +1032,7 @@ static struct test_config cfg_src_48_3 = {
 
 static struct test_config cfg_src_48_4 = {
 	.cc = LC3_CONFIG_48_4,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -1039,7 +1042,7 @@ static struct test_config cfg_src_48_4 = {
 
 static struct test_config cfg_src_48_5 = {
 	.cc = LC3_CONFIG_48_5,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -1049,7 +1052,7 @@ static struct test_config cfg_src_48_5 = {
 
 static struct test_config cfg_src_48_6 = {
 	.cc = LC3_CONFIG_48_6,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -1141,7 +1144,7 @@ static void test_scc_cc_lc3(void)
 
 static struct test_config cfg_snk_vs = {
 	.cc = IOV_NULL,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 	.vs = true,
 };
@@ -1155,7 +1158,7 @@ static struct test_config cfg_snk_vs = {
 
 static struct test_config cfg_src_vs = {
 	.cc = IOV_NULL,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 	.vs = true,
 };
-- 
2.34.1

