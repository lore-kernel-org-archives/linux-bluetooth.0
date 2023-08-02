Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD15C001DE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 08:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjHBImL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 04:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjHBImJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 04:42:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE16E61
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 01:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErPkds7PMdjOpvQriH36oUssIBYaJO+3i3UzHWNcmwBPqdtgS8BwYidlEybsJmFL2WYeXoCti64+d1YzrmQgk2e3CR3KUA9blRzfg22Y2/NoGAc21F7zc532xVeqDp+nbZT50aLtTHkgAaLXjY2rh86b06wVJ8gsZo3yEZMVX1xpM5NUzZ7yjECqwrZMDy8gVFpLqFe4s6uZuDPIkFZwJyS0ogqI8lEsUQYfQ3j9pcCkg8AOC8HtjG1rTQM2p2ahBQvKNv0NbM7thv1Xo08qMY4A3s8J7YHcLs7P6F3XCSR6sQAImgkmH5e2GBBlyLdiQHyfwcg8kBrqobBQjedmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oY+xZPrqsqIaUQOLZK2UcZgv8MQLra9GUE9X0JkM3E=;
 b=Zd30X4GN5+rPLeOExP01FHITgFZvg8br/yZEHi1SObKmsJEXjxF8QeR6PUdOkYBA8QTTxNsyh7ukm1Bj4lJufLIMWWxaPGVwx/VKQ4VUkoelSuheWAMmIOvCrJMrdNO9Rx8XQSRcREZLrCxpM9Fml1TPA8wftObR6ysqFz975hGcab7XPdkeHZKuvCNKwYYWg67kQphC8I2nNRzBfnDSFZkFjEKGCdDQlAByrOljCHH9Y2UfUiWWgfBw/lmlmH329xpWB9T5tCznbK2PkkweJzUC3WpTkwqXGfH42hL974gNpxBUAqdze3mVuUnYBHPjHji5DVoCSD6MYkVBSFF1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oY+xZPrqsqIaUQOLZK2UcZgv8MQLra9GUE9X0JkM3E=;
 b=O41v6Ie5uQKOBizRCpqdkTGSEg/2IvWu/l7iChhabkPXFkKpJvgYAiYKrRQaHokNLOrcKwFGCJ6NyT9uAmabA5FUBxLxW1V3mbznto0oeIpyj4yp8DtFiyQQJbr3/wh7T0yilUgKyNL5XrQ5k+oy+JRFVyeyssu7r1XFDlJX+zM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB8503.eurprd04.prod.outlook.com (2603:10a6:10:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:42:05 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 08:42:03 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v3 3/6] transport: Update transport properties for a broadcast stream
Date:   Wed,  2 Aug 2023 11:41:37 +0300
Message-Id: <20230802084140.51105-4-claudia.rosu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 5746c741-f7f4-482d-a46a-08db93345878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x58UNHauHKUD5abRZNmG98MP38CLG1H0PIPbb6+HTNtSL/2DsmlI1X/EjgeTmOatgTKBL6ecHnNMk2do8XfBSomHlff/cxNnLOrey7M/tMxQks41AbYtW4+kCxPoIx9TicrLGOVFh+1DMljQGGBbqpRcUXJ84c44l4Vw9JEYy2iqjv+dSY3URpLz+p/3rzcdq4Uo0gFYBb5Nv+r5Svw9O9PcT53OVgyESSDeH6t4P2xgbp+SKhfYhpy7L20oFwsGbm2svDdfZBBiHxt3C1RvhQ3CMnkqhM57OrvigwGYjNxUUbp5ejn/5YNu3k7Ja+bLewO3IgKVlDBst4k9FzXvQixPFV+L7iAFIRlZekekLtkZEMJ0Fci4EZ9yIRWf7LdwUbePML5elzqNDB4m5mDPu0e2Nyk0/Ge15FCiGhdd03NgD4gQDui6xpKmWi09WpvP8KV3oHjBjvcWs13dL2vfH5vf2gp7PYiN7K6qICmEheS7IdfC/fyXlGz9bEqP+MLn3Cv5IjYXp15g4/X1VRY4f5WD1AtSHU5hcLsdJLwpeOumOdXTWPVJbuEiHWBuRNtHR+YmazJb8trvRX0ZdtC0Rv3lyefxzwlN+6suS0ZWrsZM9zQrhqPIaZmOXUP1TtlT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(66476007)(66946007)(4326008)(6916009)(66556008)(316002)(6512007)(83380400001)(2906002)(86362001)(186003)(26005)(1076003)(5660300002)(6506007)(36756003)(30864003)(2616005)(38100700002)(38350700002)(41300700001)(8936002)(8676002)(6486002)(52116002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a7XCTOv2blM8j/Q/X1EbaAXKv9HhCGqfj4l+jsz6mIerulyvMu2nR153nbAG?=
 =?us-ascii?Q?Z/CEzZ7TMi+Gc7cQS9Gpfj9MbatPqyrOxdoVbw5UvhTkA8odrMp6GxiYo1dr?=
 =?us-ascii?Q?UKAWaQw5FfXH5A1LxVkuiIC37sY1Fmy57ipz4UDeBexCU9Lhew16CnqBX9iQ?=
 =?us-ascii?Q?q+YhZDmjqWXIxcVPmQIxzYgQqPDRpFf8Kl+UDeyloohXlemmrq7VmXKx1LRq?=
 =?us-ascii?Q?pbZ1q93beVQfOw8LW59owL9D0y9PBmETUlqAJmreDdawV24hPSW4dYkmBMbr?=
 =?us-ascii?Q?KTgCk5fyR9PQuTUSIylFVUQWeoEJ2bt700Suc80DWeYTIPs2gSXFpi+7I5dT?=
 =?us-ascii?Q?02jYvv64x/eXla+t4ywRi/2ulxnHf3ODnKpfTtlavjdUE/TI34d9KifnDPER?=
 =?us-ascii?Q?prBG8EEPn9uzpd3fmOHMU54Z9M2zPYJyC5qKzq3tItvVpQ3AfS96Wu+vv43n?=
 =?us-ascii?Q?Kv6xwiAVpH9agPFDwYDYndD8fdcDR0cAsSSXwLn6oiJZ/3Nx7jcv9SARnBGi?=
 =?us-ascii?Q?DaSHhqYgnz2WjO6fyCf8r75Njm8nsaghX08NKs0dEkcvzMahfgGS/A3UXGXD?=
 =?us-ascii?Q?7UJ2BR4Gx23bmsCZa5mplRkG3LsRY0QAgJEBy5wktgqwPGRCk/hAfVtaM4nc?=
 =?us-ascii?Q?VNcq5i6lFQNBrynY9k3GA7fq27oC39K+HKte5THw8bS4DfRZu1IWXqfpGm6L?=
 =?us-ascii?Q?jdvn9jyxmGvinTZ8kN48FAU1yfM0AlgOZeDJgNFGpcBB0J1ggUpui1Og9K03?=
 =?us-ascii?Q?lJRKiSc71PTmkJhoFWI574hxcS2TCvA3+9dJCALVhPjQeUwcOrMW2qeuCHIg?=
 =?us-ascii?Q?zno77D0bg2dCDIpPufjnyV0PsVD2VPXF7BO+gAnyFnLHhP742zBfS/qR4s2A?=
 =?us-ascii?Q?yzoHBpwKw3Rpt+8Y9U0TD2tsSGkRrioUUg1CQBb64UaG9ePa55BVDF+x369I?=
 =?us-ascii?Q?gfRXzMtYmgjKFRqFNN27aw77/Fm0ImO9vfllqqm+ZX9+UqJcFos1rxcmiCGJ?=
 =?us-ascii?Q?N641Tz+hwxdshgAmDT4+945ncMIAVeGUerc4HfRNwQflurFLHOsJOm9coUOy?=
 =?us-ascii?Q?QWt37UjHuWgpiOujwx9LoIMqIrveJFSR8PuCDoLTwARjOJyZQljmVzBuWrir?=
 =?us-ascii?Q?gnIXA3S0K90yhcdVKM7PYbiLQlIni0o/wh3oBX2gsP0TkBKM8Mvo75ZYMRnu?=
 =?us-ascii?Q?ttiHMQgtdI9H9Fyk9kJ3d21CmWZlWSt3kKjhOPgqR29yjjwbQCEaUkWjulHV?=
 =?us-ascii?Q?f8DcOs1AcqeXgQLNU0p/+m23aRknDxQZRWhPvF95VdWfTV2JOToZ9V+herV0?=
 =?us-ascii?Q?o+V34QqWWL61TX5xCP/fId4lqTWD5MGQTmnxHaZIIaXx+XlgEjqFdtM1nEW2?=
 =?us-ascii?Q?bkT9SNuU1as2k/xDz7aIT3m9xWJsEjImQEZYVoet54Z+U4iaKSBH8d7mG/6R?=
 =?us-ascii?Q?cKS/n5nh2dt8PVOT/cKMbL3TpNMlwEWk2IeW1Ml0lOolRwn4AzMtkY0UzUWl?=
 =?us-ascii?Q?UiEFKzeuOukiNDkT6ZA71ppk8sw0FzW0xUDgAVA4BeMLPDD+GSa+HLD4VwYY?=
 =?us-ascii?Q?JGPJUKEpnjhDwHfz+R/9uIGiaVARIgKh3heNOpL3ltpUXx9L3erkmnu8tzz2?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5746c741-f7f4-482d-a46a-08db93345878
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:42:03.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkmYNG+SYh0GedP96jvU4gTvkIHaBSg3s9fdGEXKJAnuX5UUkhX/HQLMY+Ctbr8eHEc9DfMtnq0MX1NoaP0ozg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8503
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch gets the QOS broadcast stream parameters and passes them
to upper layers.

---
 profiles/audio/transport.c | 245 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 243 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index cf5662d1d..aa2fa4397 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -552,6 +552,8 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	owner = media_owner_create(msg);
 
 	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BAA_SERVICE_UUID)
+		&& !strcmp(media_endpoint_get_uuid(transport->endpoint),
 						BCAA_SERVICE_UUID)) {
 		req = media_request_create(msg, 0x00);
 		media_owner_add(owner, req);
@@ -853,6 +855,9 @@ static gboolean qos_exists(const GDBusPropertyTable *property, void *data)
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
+	if (media_endpoint_is_broadcast(transport->endpoint))
+		return bap->qos.bcast.io_qos.sdu != 0x00;
+
 	return bap->qos.ucast.io_qos.phy != 0x00;
 }
 
@@ -868,6 +873,18 @@ static gboolean get_cig(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_big(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+							&bap->qos.bcast.big);
+
+	return TRUE;
+}
+
 static gboolean get_cis(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -880,6 +897,18 @@ static gboolean get_cis(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_bis(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+							&bap->qos.bcast.bis);
+
+	return TRUE;
+}
+
 static gboolean get_interval(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -899,6 +928,9 @@ static gboolean get_framing(const GDBusPropertyTable *property,
 	struct bap_transport *bap = transport->data;
 	dbus_bool_t val = bap->qos.ucast.framing;
 
+	if (media_endpoint_is_broadcast(transport->endpoint))
+		val = bap->qos.bcast.framing;
+
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
 
 	return TRUE;
@@ -910,6 +942,12 @@ static gboolean get_phy(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
+	if (media_endpoint_is_broadcast(transport->endpoint)) {
+		dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&bap->qos.bcast.io_qos.phy);
+		return TRUE;
+	}
+
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
 					&bap->qos.ucast.io_qos.phy);
 
@@ -922,6 +960,12 @@ static gboolean get_sdu(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
+	if (media_endpoint_is_broadcast(transport->endpoint)) {
+		dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&bap->qos.bcast.io_qos.sdu);
+		return TRUE;
+	}
+
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
 					&bap->qos.ucast.io_qos.sdu);
 
@@ -1040,6 +1084,121 @@ static gboolean get_links(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_sync_interval(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+						&bap->qos.bcast.sync_interval);
+
+	return TRUE;
+}
+
+static gboolean get_packing(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+						&bap->qos.bcast.packing);
+
+	return TRUE;
+}
+
+static gboolean get_bcode(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	if (bap->qos.bcast.bcode && bap->qos.bcast.bcode->iov_len)
+		dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&bap->qos.bcast.bcode->iov_base,
+						bap->qos.bcast.bcode->iov_len);
+
+	dbus_message_iter_close_container(iter, &array);
+	return TRUE;
+}
+
+static gboolean get_options(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&bap->qos.bcast.options);
+
+	return TRUE;
+}
+
+static gboolean get_skip(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&bap->qos.bcast.skip);
+
+	return TRUE;
+}
+
+static gboolean get_sync_timeout(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&bap->qos.bcast.sync_timeout);
+
+	return TRUE;
+}
+
+static gboolean get_sync_cte_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&bap->qos.bcast.sync_cte_type);
+
+	return TRUE;
+}
+
+static gboolean get_mse(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&bap->qos.bcast.mse);
+
+	return TRUE;
+}
+
+static gboolean get_timeout(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&bap->qos.bcast.timeout);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable bap_properties[] = {
 	{ "Device", "o", get_device },
 	{ "UUID", "s", get_uuid },
@@ -1059,6 +1218,17 @@ static const GDBusPropertyTable bap_properties[] = {
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
 	{ "Links", "ao", get_links, NULL, links_exists },
+	{ "BIG", "y", get_big, NULL, qos_exists },
+	{ "BIS", "y", get_bis, NULL, qos_exists },
+	{ "SyncInterval", "y", get_sync_interval, NULL, qos_exists },
+	{ "Packing", "y", get_packing, NULL, qos_exists },
+	{ "BCode", "ay", get_bcode, NULL, qos_exists },
+	{ "Options", "y", get_options, NULL, qos_exists },
+	{ "Skip", "q", get_skip, NULL, qos_exists },
+	{ "SyncTimeout", "q", get_sync_timeout, NULL, qos_exists },
+	{ "SyncCteType", "y", get_sync_cte_type, NULL, qos_exists },
+	{ "MSE", "y", get_mse, NULL, qos_exists },
+	{ "Timeout", "q", get_timeout, NULL, qos_exists },
 	{ }
 };
 
@@ -1341,6 +1511,71 @@ static gboolean bap_resume_wait_cb(void *data)
 	return FALSE;
 }
 
+static void bap_update_bcast_qos(const struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	struct bt_bap_qos *qos;
+
+	qos = bt_bap_stream_get_qos(bap->stream);
+
+	if (!memcmp(qos, &bap->qos, sizeof(struct bt_bap_qos)))
+		return;
+
+	bap->qos = *qos;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"BIG");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"BIS");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"SyncInterval");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Packing");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Framing");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"BCode");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Options");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Skip");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"SyncTimeout");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"SyncCteType");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"MSE");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Timeout");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Interval");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Latency");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"PHY");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"SDU");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"RTN");
+}
+
 static guint resume_bap(struct media_transport *transport,
 				struct media_owner *owner)
 {
@@ -1493,7 +1728,10 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 		if (owner && owner->pending)
 			return;
 		bap_update_links(transport);
-		bap_update_qos(transport);
+		if (!media_endpoint_is_broadcast(transport->endpoint))
+			bap_update_qos(transport);
+		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
+			bap_update_bcast_qos(transport);
 		transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
@@ -1503,6 +1741,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			return;
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+			bap_update_bcast_qos(transport);
 		break;
 	}
 
@@ -1631,7 +1871,8 @@ struct media_transport *media_transport_create(struct btd_device *device,
 		properties = a2dp_properties;
 	} else if (!strcasecmp(uuid, PAC_SINK_UUID) ||
 				!strcasecmp(uuid, PAC_SOURCE_UUID) ||
-				!strcasecmp(uuid, BCAA_SERVICE_UUID)) {
+				!strcasecmp(uuid, BCAA_SERVICE_UUID) ||
+				!strcasecmp(uuid, BAA_SERVICE_UUID)) {
 		if (media_transport_init_bap(transport, stream) < 0)
 			goto fail;
 		properties = bap_properties;
-- 
2.34.1

