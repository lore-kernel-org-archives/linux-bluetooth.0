Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A492C04A6A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 13:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjHBNZ5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 09:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjHBNZ4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 09:25:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B11DA
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 06:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hf9srrJVNlXWfrMF2RodjBMPcbjvibe23T0gwYdxuf2I8OqSrK294vYuKA27xJLGKkwdYFx9TjgwS6otIK8dATFMzindLA3MYgF/KlvJKkwdbL8+6d6pHyBTvwzWn9KrBg2uzi5P4L+L87Cb50gLfpvkdhsipQnKCJ6KiWhuOvAJ4Tq139BVfqUSWVLkwYrF6RcVOCyumqugCA41hyHNHvkJX/H92Pdsjgvz7yd8MBJPngyZ2yZNENCu5q6UoVPOKIIMfRYR2eBbSImi02F2oPgDv1oo0hbYRbynqDKhmQmxo46nfjYprsMW6SIVZubSo4Eg7dQYlfaADFbaGkA4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oY+xZPrqsqIaUQOLZK2UcZgv8MQLra9GUE9X0JkM3E=;
 b=Gu9oxF820J7oGBWldMFBAihe9qx5a1RQMwExg+9IDIBoMlge70oR5H7gQRcRNg7/oUKo5sFfKj1UsTor+kgtPkeNBvS+v87BFp2C82/BbSUIbKZC7zEHqoCqRUZpRtWlzBjXb8M2Sz3h1gLRabxdQtipPmZqCUujWNGYQ1x+9jah7yHvxoananEXNFYEIbwLKIdrQWpeDr/l+ZkuLoEU0soEY9vtFVQ+X2t0mlwBiEknZWyUjXHkDwPadlWiS2Koeg6veQTaO9/pCnYPFK27Nk/4wY5o2QdEasNIWtc3tC6q2q/Kd/82FNEpD9/C82GaVcS+++tl8HqLESs5nF8xqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oY+xZPrqsqIaUQOLZK2UcZgv8MQLra9GUE9X0JkM3E=;
 b=KkXI28mCoRIVQslNiA/dTSFAns6+U1IsNY/JI0HsjPZXQteCuMgb7HpYHgekdPasNTflCEBOLbVuNITkFX1C95GpbCmQbdjfnm7t3j00KzWvovzDl1mCd1/gjtExD0OioPtYqzIdrjcKBcMcpmp2hXxXZHrz0uk9LBl4ncegaWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB8613.eurprd04.prod.outlook.com (2603:10a6:10:2d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 13:25:29 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 13:25:29 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v4 6/6] transport: Update transport properties for a broadcast stream
Date:   Wed,  2 Aug 2023 16:23:55 +0300
Message-Id: <20230802132355.4953-7-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802132355.4953-1-claudia.rosu@nxp.com>
References: <20230802132355.4953-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::19) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c0634e-00e5-4bd7-5cb5-08db935bf09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sG5Nnbh2h4Bz7HCP6ZW4UuanGmlBNJIMfo6srHb5uJRpyMMLP/TViykLTqcdDpE8HY8Ond47Aubfh0dPAmX4tvtRCDCf9slIhuVFnmTBEp8ck1tHJoZoH0upItSVkmYmkNXgCAzlPIx5KnS0jMSb8Z50j6CYN3HIFwBVeoX7oFKXP93sV32sDoDdyJ+8/3C3Yy2umq+/CVLY2Ln1Vh6ukf311LHS/3HTXx9K7KVu0qz3VZgsJd3xIy0pwNU6rUIR8f0T0mNTHamIhUnC9rHB5c4ebHVZ66GFjmgS/jDyl2y/RJ9z0ngJYsLUHdp/gu6ESiuGAoWESzZXuOUS1PwAuLsrCv0cPHP3SzaRV/2EtkZWI9QytWlDvPVeyK1NwBprKMQkYn3/lO5OMDGc68uUJYOlpEYqrBeFcHy+xjtGYM5NJUw8iKb6HF7X+w9seAn326AB/twO8m6ma0Bycwp3ywGwi3bSAv/awbBUgk8K4BxeZAs+/0OfrsgEvwaDT716ePt/dE6xIKLbMFz1dY5u2J0rKyV/Dc+T4KSD9U+XswL/jEqiADK3VajOL2GjfwlI/Hj/envuYul3SfqU/tJNNm6YQnLA+klfQvn1mowQrBeqfSuMrfXxtruVTsFQGID9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(86362001)(36756003)(66556008)(52116002)(478600001)(38350700002)(38100700002)(83380400001)(186003)(2616005)(1076003)(6506007)(26005)(8676002)(8936002)(41300700001)(6666004)(6512007)(6486002)(316002)(30864003)(5660300002)(6916009)(4326008)(66946007)(2906002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0e5vDYZGhge4GOchLiFRwgC1mrgJLgdnk5e2NyD3p1sIhB0Pnea0z1wVet9r?=
 =?us-ascii?Q?zxdZxI5hL2VzPExzO9adUa/IFQSxzZfeKEQve7Ba5l6V9AsUJFBgKkWRXdJv?=
 =?us-ascii?Q?OC5UgsZQhRacrH0S6Ktz82h7jvfz0W/lsQdfRZc+S6KyfaDx1dhFEkUX5TE7?=
 =?us-ascii?Q?JQfa0JyDN7EsPMw6BfDwyg8TEYtQRgMvGLEZ8akHMDBpWhSPe+P4lg7PPWtO?=
 =?us-ascii?Q?2fBNId5Z1NBgGWZsAVze169yKMEoOrPqB+uSCa3b+1p92P3Eq6eDhwYfwcdV?=
 =?us-ascii?Q?UOsLpLVyB0DFVjXp6pkX9tCJ/hpP1+SUpstWw+5udgNAb/Z8iG9vfslpNbQn?=
 =?us-ascii?Q?LEUOu21MkTWqnfFETj0kWoy0paHdRtQHnZ2/uPaqbdqoavrbKB/lgNS8ZctG?=
 =?us-ascii?Q?+9TrTRe3WR6VZsUshQFCBnM01Z5M9RrRHGtzWmEYnpD9bMYI16R++kMIIRVv?=
 =?us-ascii?Q?Ph4PRnHPSIosHC4oPOKgMOi/+6SYasqNjtSedV6FNPt5yTVvflf20huYrNtZ?=
 =?us-ascii?Q?Fo0mFllm5hxPpDLzWrU6oUqmcGWDRJjAidX8JPo7tJd47XrShb3t/Pf+wqhd?=
 =?us-ascii?Q?Gxjk5JXg9+JUAutSOiX5hmiG8BcTTM7mhJEnmOSn4NeB7rPglgiMSMK6YpGZ?=
 =?us-ascii?Q?HHwLJxTugKtMUVkBlJXhDgPmxNFjKhs2zSPVJ6aSESnyuNzDjI+3KhQ390+N?=
 =?us-ascii?Q?PazA8czDVChg4ATZLpus7BK2IA7QiAK9xVYC84OPFFoENQFB0Sy7cP7K0A4P?=
 =?us-ascii?Q?4Fw4U1bCcdT1Fiv/xzGZ7gADlQ4BmNowQ7wVGT67lWHDm9FsqTxoWRJyntX3?=
 =?us-ascii?Q?M6mJfstFKhgwXGo8VpNA7fL86x5FR0N6euWPAwlcVO6jCQPWs1/I3Ma6tL6M?=
 =?us-ascii?Q?hxsWfxTOlBJQnHh8Xg4DC/zduMtQT4QRanIoYBHheLeP5GPIWZcUJzqH8JP6?=
 =?us-ascii?Q?0kdPXhvQ8OLEV2tNQlhO1Uc8siZX3TMCmzxYNFCg1k26Enakgmbk/y0dHEuZ?=
 =?us-ascii?Q?f1Md+JvRVidnJv+92DLTR2o3TOLPCSpC0iWLUJILubpqD2s/PxHCDOQdNzrD?=
 =?us-ascii?Q?FcpDVnXJzEp4FHNf7CC70jU++meWS1qcieqdsi4ayG82cAO3ghOs6RC/FzVo?=
 =?us-ascii?Q?1SDBnc3zVTUrPdHqq7sja8TUs2yDMu2PV2bqwHtUaP4RcRDmh7HJOaJ4LKD6?=
 =?us-ascii?Q?fe6/eiQ6o37p8JTMHwn2WHIKVcwyHn+4lXfAgvPzXMfn4IURzg8z71rASVB+?=
 =?us-ascii?Q?12rYaAA7TtSDpcA2GjYlMhOAKbgPNMK7icQfjZDdjHub/l4uCLCR1EGS/ZzI?=
 =?us-ascii?Q?+pqO2kSnGAOznaPJe23sWcFm0N/tP8ORSYEls0MBVeqDC/6MM/DofMO4GaQT?=
 =?us-ascii?Q?ft5tREfMaVxLgelRC90eauxmtn/O9adlIPqH8LacE+vecn94ON5h9TCgPaRv?=
 =?us-ascii?Q?b6wUug5MsfDrHyquiqdB8TL8l1hdk7hlPCXcpspYgJFiEape04Wj6Cw+bLIn?=
 =?us-ascii?Q?yC91kZHI1qTU0k282TNlmhjkAY2aRYVzVWVeWTgb81eJhZ7guyjAu6VTbsbq?=
 =?us-ascii?Q?dsq5YOXqHSoWbsEwSQz79mrGuJ7F9GGEiyuvlT5D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c0634e-00e5-4bd7-5cb5-08db935bf09d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 13:25:29.5135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OQ4dVuFykUyrMkn7RsRP4HawI+Mgqo5hLpOgwALHVdNie4kyZ7fkA2bxyhWUtVzV89cloDxHMf+r0kFxASy/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8613
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

