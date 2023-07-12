Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B40CEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 12:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjGLMYk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 08:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjGLMYi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 08:24:38 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426E01993
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 05:24:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMDSqPt5Cfrrxi9LzKBmggJwexaX/hGjZ70PFpI61gJEk92h5zvVd2LcmesS3XgCpKI1uVVJ7x9rCDAsoBSri2HRSqmtnSzD8Ipzgj7Lde5D78d+sWm9yybu6vj0icuBblkrttTqaHU1VUT9Bbbz/SJM6PbxzafYmPPiL4A/gioKvh6WaAeXl7yfTDU3SNyKdcygtEwrt3e5F2Q8kMRLhjCaHF0iBZlBmQNYIV6DAmHHLpicnlUSaNgMmaAYhdDvQflHqsckEyuVZdaZFDtfbXw0ITRrTNTwVplOS4LcT5ZIYcLyILyfaHpBMzuLTI13pkG7AcIaVSGMtm6lDmuAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnlVnDTXYHd5IQpCKTicqkBWS3QA9gQp/s5E3zwfSRM=;
 b=mZl8fp63TNur8zamhw+Hn/srzNOMDVE20m2yfUY8ivA8XsV8jVe0ZdGgDzc4YfnPFlDj1sPI0/HRl0YGaWPRi84XUayYXWe6aoM1Nxf+JQ0XOmOUUlUiYBKhQS7aIlVSX5tB3uMYCaA4/gBRebvBh9zK13MqhOBpiUMknxmk6HF664Ffk2PRy5NBFvp7glbb+h9x5myM9UXgRpsbcw/xmLwR323VfNwzyS1qYoiTU7lLkJYCRpfUQf73/QWwoVLc6FBjfyx8Cq3CGytayM1QKsTaoNSgLovTSHWPjC7V6s9mBkC3zQgk3ECD0mzdLs8MkthAZYmrGIxVENPDzGiNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnlVnDTXYHd5IQpCKTicqkBWS3QA9gQp/s5E3zwfSRM=;
 b=cYlAIUmpiXYeKXvW6valXUlAimNXxvfKvd8qquQfwxdPNzl+X7+GAH/7nsVIdSyxSv2DBBoym2++/++wP8BPM6D/StlITJx+tLTTZSJAlT4aRmGw0h1lLJyZFPr7TMKEHnSib8gWiOT13hehMzLlgn3gWx+d8WpoWBJSV5z4m+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM0PR04MB6835.eurprd04.prod.outlook.com (2603:10a6:208:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 12:24:30 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 12:24:30 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v2 4/6] transport: Update transport properties for a broadcast stream
Date:   Wed, 12 Jul 2023 15:21:33 +0300
Message-Id: <20230712122135.7734-5-claudia.rosu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a1d048e8-6703-4364-7951-08db82d2f142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dv2TLybUEXSRMYaHC/RKKxfSf6Pl1XavcCjWKVUduUkjK0fGRuotTNQ2HOvFuHrOZnLeqk9pgvBIg9SQuf/1A2ySSfnuuod+FSHWCG0QINyqGU6OsTMCOJ1DQIsMNXVdVPFHT3yfJ5W+aWNKi4h8AaoDtj4bMP95ThXLKL2TLTpdMsgd83K2iwq9V4SQZeOqRV1jdmkg4Ppc/9TDFfa8cJxp3vB4MuaqbHGqQ3yVxPPHiTK6BFAkUk5sGWSnA74u3eSN9eETejaNosXwZYmso1WVC+5wVzXFOWq+v78DZeac2kVGiRz48jzs2A5881jhGauBhmDYLHe7z1YplnD1Vac2B+wgoVg+Y+t4ZVQFMj4PbtvGbx8X94on+eC2KyZyPvEB55MEElmfvPZb1DXBYSqNxTKrihLSlIlF7WknEmyxgyDaqwoMS51stahA6uxEp9S9eYXCRT4d+Jkupng9TAmYxVJ7xP4SjHykyblniQBrzQ1Wc26/IxjcE7itpYizXhxa12DwOBTLZmHDjoGgcZY7i4/YUMgq6uWxlMKBGJ1lB1jhf41JxtgNR7Fr6Dw8O+ggJoIXuyIxte1Wm1lii0hxbBtOmvzxQy9TSQaw5IKPW32Kok2JVUBP67/9ZtD4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(8936002)(8676002)(38100700002)(38350700002)(41300700001)(2616005)(2906002)(316002)(5660300002)(30864003)(66476007)(4326008)(6916009)(66556008)(66946007)(6486002)(52116002)(6512007)(83380400001)(478600001)(36756003)(1076003)(6506007)(55236004)(186003)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/BsqvK3dSQ5WT8GSBaDAEM8kRumNbP0pDtPsRKbRYFZ5mKNbfw9WzTtYKCS6?=
 =?us-ascii?Q?Lm0mPnrKZ9WvBu0A4LiObm7ydHlY0D8pLnJlKl00GD7WAdDwGeJEcL5gO8Np?=
 =?us-ascii?Q?MIfDkMaAoxqShMj8x6AK/FXyGvuD1dtsdT9aOE1kYF5+PLXd44z/DpZntFxk?=
 =?us-ascii?Q?6ledG/8iJCAqgR8Q6LT/UHI+9nOWvJRsaxI/VXSi/j3ZqtjgO4D7c9fLux++?=
 =?us-ascii?Q?7mKjOYlAEPdm+RTdwM47Wr4Vw48uLCgpYlqV7JnKkmxc+C0cKkvTX8gjRCt4?=
 =?us-ascii?Q?fF7VT3l4YbJESIvrebdjH//5CrQOyYEtXT36LaLCzwMmaHlw+nKqh34Q9Pr1?=
 =?us-ascii?Q?f2h+nqkgsSn9QruRcucioKS/jO2tTxoyoaCmekMa6UwWlGb3HmhD0UV65u8J?=
 =?us-ascii?Q?ESpffaQ7qej35mBf53esvZqvRPAfiaBGjtdG410TYMlPeEPQIrgEwEmKygFD?=
 =?us-ascii?Q?5mjFFc26HPd8DIMd2Q9ofeGtaj5pkMGQ9Pssuz+OWqp9Ga6/T1gEfgW2esKk?=
 =?us-ascii?Q?KcUpM1nu+2TB2yY+DzttAR7WxsYfJVUI5J+MOpPzcGok6w7R8Xu7m8Utente?=
 =?us-ascii?Q?1yi4YFcC7wSn9AMlVVpwZm2I+WIl2i34E48vebVsS0YavGOTxEkvXqvlPOwq?=
 =?us-ascii?Q?Yfe+n661S6Lv3+j9kV93o/M5mrwFM07fuOTShMbN/JKXT1wdUgCsDuWN1Qb7?=
 =?us-ascii?Q?hbtOFOa10ghVF5uIwqIme7xkXR2UMSksx+2QU3JlN7Eew0obR9CNIz626U6k?=
 =?us-ascii?Q?rj81XPnH96v4mCtTTHsgyWA54bUhm+BOYko14Ib+SD2G27yM5/yQcCoglSZ6?=
 =?us-ascii?Q?jCad1qfYTYC25Bu/9WpItT6xTXxo21oLoRd9mRbmTqHS27eZdoc07qiBELw+?=
 =?us-ascii?Q?LVbKREkQfhvDkGehc0lWYhYTKlcUk9VW7eYNDxIsHB88BhialKcjdbuCEzU2?=
 =?us-ascii?Q?ivI8KkXJFfQPofCk/KAK0CES2tZYeGHQSSAJ/h9O9VaErSZHb90XZE3KgVu7?=
 =?us-ascii?Q?JtEI9IfKsxP6BHPTcUjqCT2lHZzKRnhTQuEG86D2bmvB+VrVvW1NDJiEGrWf?=
 =?us-ascii?Q?Elwrg3OSWVCREwveYvKJUcs92RCgCSzbrBH/2QNtHbzXk2YGy9MJf2ZVt6wQ?=
 =?us-ascii?Q?I8GPIAUhDcvR2jePyFIZNieIdzrmSGu3aYrDtFyPhHjIQBrdj68gR4/PUlEe?=
 =?us-ascii?Q?5qVWB0rEs/SlItG1KkRps6HQPh6RPsOt1amOauR0U4dxTcAspzVeBD6rie4X?=
 =?us-ascii?Q?kCB6M/5eOnhHe2rb6AYVd5x7MYR1wUREVqV8l3QW2eT7UGZWYUUzDRL/amDB?=
 =?us-ascii?Q?cz2uaDps33DswkEH8aYWGZDlyXOmE2M++EPFFJtm/VMSP3xnhfE1USaLL47F?=
 =?us-ascii?Q?xrZwaCHdgldeK592E8tYBW1zt4snXY7GzeaK1lyv/3trJ7oQCwuNmCVs4Kti?=
 =?us-ascii?Q?taxInaDWq2268W5qRIMct8TfM4g6QR2ewtfka1obx8Os6ifCl/lDtINfsBGB?=
 =?us-ascii?Q?x0ggWuLRBGM9EVgwvKPoL4rRyQbjc7Mx62vfiFnYVHF4twIEc8f5k0eYHHsI?=
 =?us-ascii?Q?PSiL/DeqKKSUw8R87vH7l0bO7r9zUZjDKslcDVOsW9YWCsiggzkoZReyVfyK?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d048e8-6703-4364-7951-08db82d2f142
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:24:30.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEatzjiyaY2sMlXNQ21Wn3cXxJXttDhTlgQc3otUdnia8w1/R9Zk9PK3nr1JbnYaggNEAMuwk0fJ2URjWRGwUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6835
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch gets the QOS broadcast stream parameters and passes them
to upper layers.

---
 profiles/audio/transport.c | 244 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 241 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index aa3a718b0..e7f21ff9c 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -551,8 +551,8 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 
 	owner = media_owner_create(msg);
 
-	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
-						BAA_SERVICE_UUID)) {
+	if (bt_bap_stream_get_type(get_stream_bap(transport)) ==
+				BT_BAP_STREAM_TYPE_BCAST) {
 		req = media_request_create(msg, 0x00);
 		media_owner_add(owner, req);
 		media_transport_set_owner(transport, owner);
@@ -853,6 +853,9 @@ static gboolean qos_exists(const GDBusPropertyTable *property, void *data)
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
+	if (media_endpoint_is_broadcast(transport->endpoint))
+		return bap->qos.bcast.io_qos.sdu != 0x00;
+
 	return bap->qos.ucast.io_qos.phy != 0x00;
 }
 
@@ -868,6 +871,18 @@ static gboolean get_cig(const GDBusPropertyTable *property,
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
@@ -880,6 +895,18 @@ static gboolean get_cis(const GDBusPropertyTable *property,
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
@@ -899,6 +926,9 @@ static gboolean get_framing(const GDBusPropertyTable *property,
 	struct bap_transport *bap = transport->data;
 	dbus_bool_t val = bap->qos.ucast.framing;
 
+	if (media_endpoint_is_broadcast(transport->endpoint))
+		val = bap->qos.bcast.framing;
+
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
 
 	return TRUE;
@@ -910,6 +940,12 @@ static gboolean get_phy(const GDBusPropertyTable *property,
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
 
@@ -922,6 +958,12 @@ static gboolean get_sdu(const GDBusPropertyTable *property,
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
 
@@ -1040,6 +1082,121 @@ static gboolean get_links(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_sync_interval(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+				&bap->qos.bcast.sync_interval);
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
+				&bap->qos.bcast.packing);
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
+					&bap->qos.bcast.bcode->iov_base,
+					bap->qos.bcast.bcode->iov_len);
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
@@ -1059,6 +1216,17 @@ static const GDBusPropertyTable bap_properties[] = {
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
 
@@ -1341,6 +1509,71 @@ static gboolean bap_resume_wait_cb(void *data)
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
@@ -1493,7 +1726,10 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
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
@@ -1503,6 +1739,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			return;
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+			bap_update_bcast_qos(transport);
 		break;
 	}
 
-- 
2.34.1

