Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BB0C07E8A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 16:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjHHQ3d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjHHQ2S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 12:28:18 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01A711F4E
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 08:50:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiT6MRUdaRbO9Q4sZMoXsRnVnPDQTGso+JyLOpgeJj9D2mFtlWpnqSdIFZzDKq4t7NwLtfWAg/nflogDQTYkkqn3ncsphF09yYEbbwezJvksqw9s3QHf7N0Nb6i31tfetvzl8lYEbMUTu9Rh8aOHodecSglhe7K0Kw4W2wDrAuimomKZKSuja2rcwVWcBpJuEg89teLOna6XJE453JU6zx1OQ7mOXNQ0xgNV+1o5Uk+/XsKVuRR8ffI1xFOgnv8t319Pos+We49/mTFEGD724EGecICB4QSQ5Wwipr382aqGsbx4zplsLQnV60deQstNbfFeAJ8w309QrcIIQB4vOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMZibo8oTTBfrrSl5yHrHjSbPOBpGDQwYeaiIVD8alk=;
 b=nscZVy5hZ165DAcQdiSVXyBW43JRamC3z35nz+VoluIPQz2IZmgmst0x9VPilJ2J8jci+Qy0lUqe9YfQIK0OflxBgqeWT2LszkZ6UHEPREzLBjVLdr21TAdOS4rTJRv4sokilqRb1F+ctjmM/MOCxN0MTWubaidSfQy/T0HCBzCLmEuAsAW7L1WC5vgMtOdwIXGcex+DRsQSDH/7GV9iQuKy+v7sWWf6/TYgwU0VVLllvtzs+w8poEit3cS+UpJLa3HAnhLeJ5zFf85iJ3wRvUi0vcGrefxBM2HDh1kys9kMzNBaw+cSi8JmaOfHasbIqr8+TdYq5DzgvKuYLBi1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMZibo8oTTBfrrSl5yHrHjSbPOBpGDQwYeaiIVD8alk=;
 b=FhT28QKKwQXAIIOKj3HirWM18JIcbt8y+vDrotpS3x3DHQNqNQ8Xy/kmhudkqPUQmUERN1J2tHqkB1jhZL74TDUbaA1ooy+xVc0BOYOfPjS/D6PRqHi28vObulICTJ42d3ls3UFOqwc/mMLvbmYX/Ic5N9495MxwZCKiBFJF1Sk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DUZPR04MB10062.eurprd04.prod.outlook.com (2603:10a6:10:4e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 11:53:18 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6652.021; Tue, 8 Aug 2023
 11:53:18 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v5 7/7] transport: Update transport properties for a broadcast stream
Date:   Tue,  8 Aug 2023 14:50:40 +0300
Message-Id: <20230808115040.4403-8-claudia.rosu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7107bb93-6e8b-4fb0-6b38-08db98060e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B63/7g6GOXiYycd9nr4gzHfHvba3xS45oOpImJXow0hsdtbjh8Oz2TDlPVd6zo6wSOVy4Jz70Tj/nIot1ZwsMb1H0sqdf4liLvf60xQmGtK21cQSZYoOUZLAFlRIkezHyR56NMkgHZ42R+cNQLbiABEMkogfcBPKm4QpNGRrsY0ej3n57kNMrISrQJNwerXdwjbAyT3yHEnLDy90jEvKMv6RMcmAxI372Pp+w5r6XkZSFTsUexF7b2lrjhXchnCS9TrvRMP5GgQc+jR1Bqc0wrsJkgOikGP3YMSxsAE6iYsyBD7iCicRLU6bVPq3LrS3wx6RE3mu3/Lhl89EEP31iunHnTGtyneVZAI5Gm2RbwchmtAAobdbFYGu1r7W3q1xEF8YEKGJUb4hdgn0u1gr9wrZAUGYF9DNleYwQOsN2Y7awuN6b8GlfjXDfO1SPRyRxABiCRyajBKtjrUncxOZFFw2FjBDkZZdMDYvCgZAEjcneg90hAMYdiBnQtepv+F2PUIRoq6WLY4kxwrhz4RMqT1RUh1vqVp8dAuGBPlelfVEatwRRLtspdNVGmN4fqcM/XfVeccmnpc2EGmj433J1EbHzY+mzCm3Fp7BvKvKZ/76Gvntz8dcN2dCaCAUrS74
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(1800799003)(186006)(451199021)(83380400001)(2616005)(52116002)(6916009)(38100700002)(38350700002)(41300700001)(2906002)(4326008)(5660300002)(30864003)(316002)(8676002)(8936002)(66476007)(66946007)(66556008)(6512007)(86362001)(478600001)(6666004)(6486002)(6506007)(36756003)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I+G1kekKvjljIB2Ufh/lFZF0p+Vvm7CrIsJ0L6no3nFVpeerUhyb1j5HOEhB?=
 =?us-ascii?Q?t8T8oc6fgFnAH8xtviQdq3YedAEXuwEUwTyIfzdUnXg9LCvP4Zf8cNNEU47e?=
 =?us-ascii?Q?G6Uk7fdbTMPy1VIIpqBe0Xc1jPqEbaEIkxd3xe3pKUwLveF2eFxs7EYvkPRh?=
 =?us-ascii?Q?OsnEKjigmGl7LAGJZy9V4h1XPifk2T2UhO0n8KCwkChAAq9RHJMWNUdhyMq2?=
 =?us-ascii?Q?92lq727zdsVqC6/gIN3yFQ9/DJMr1x/pehf1W45mLCMtkM232SbysABomW4J?=
 =?us-ascii?Q?LjLDEEgNxYdSwmCB432dBZhYdo8Dx0y6C9sXqC299jtd8yxlhQS2103/1UiY?=
 =?us-ascii?Q?3KjaXTVlSTSgnI38KC6DJ/bp0bi6paA0S28mooFrm5PYrkeQD7ML5uF4BDtt?=
 =?us-ascii?Q?ESKlLB5gnxIiBA9u79SBV3hds63YgXkyBzlgtol5lXGx2N6rv3v/CccSQUrC?=
 =?us-ascii?Q?j3XETOg8KLZFlHA2Chv+58Y8jDVsspTbKcNYkIlVtiHogKh7Ap62sHeepxLD?=
 =?us-ascii?Q?misgLUPi/QXAlCWE6l8gu5xD6AO4xn3wKXrVQxkzwrVhfNj7t+/ivVcRbIb+?=
 =?us-ascii?Q?vHMgYRuGDLDbrWajzxy60rWUW5kXG2acXcc1Vgg2F9SEA1AWASEiR2Bx0uLw?=
 =?us-ascii?Q?56GvvWAXOaRyhtN92bY0zd+0PqsUAutE/DO0wybDPRdOFR3qHO0Q09LuR60l?=
 =?us-ascii?Q?+z024k+DX8wMnETM3w6pAQHAF83lTrrfgdWP8HJAPcLjzlGBBnW7xbW+YLMv?=
 =?us-ascii?Q?mye3pu8FjEbnWHsKA2dRVZI3dmN2xUBWztWLwfTM+RsJy9+Iyxml9PQh4n8Y?=
 =?us-ascii?Q?fFWJoTIGXSyxtF6ICtTjToC6BQMjK9/7+GYWOOcXLhHyl6MAqr78NcJIDhEN?=
 =?us-ascii?Q?jLwqN+nWadJpLRKuQHI7bd3BymoSJrBmEmifk5B1MHlJgSQnvSrI96z9C56l?=
 =?us-ascii?Q?N3XXZVNP6uOUb1dS4QhrS6vb0J56zloTokIp+RtTgkb++sUbnYGPBZbqjkc2?=
 =?us-ascii?Q?GSeYI0wz8mtTkP465OXv/2Oz2GZSMLMjTr3B4E7XqaxOuQW1S4+l1PXXqHJD?=
 =?us-ascii?Q?C/42klsP6/Iz6PUBBCZeITpBVPomENrYw4s3mfehmfrA+xFIzrQrQJI5a2tn?=
 =?us-ascii?Q?11i2WEv0+z4U393VM41oOXe+jiyaDR9KUVmKZXZ6xN8JzQe3G6cRvXvUPYpV?=
 =?us-ascii?Q?aYqpszpTPSwMZKS8LkWhBsBl+ha+8hkuWdZCF9VZSG88Bf9L7PaErAQWODdU?=
 =?us-ascii?Q?osm0W3PtkHoDJBXhFLpGpj/UaMVQxX688HsEINzKwrt+h7if73g/YNmzdJ25?=
 =?us-ascii?Q?qgZjUmGTKs9eQIxvaJunXaA2uy0SboZkGfbRa1E4y9me6ywpevIas9jcX4rN?=
 =?us-ascii?Q?0X2ibRBnfWTDnui5YxPVUkEnebFCFtBL70zR8plwPZiTEyazLrUnpaRILSDu?=
 =?us-ascii?Q?ORjao7fLgw4XHAK1bhbI6Ize25l+kl7ofKNKnuZQZwf8ggrXm6JDg+NUZVR4?=
 =?us-ascii?Q?fIkgsawBcQLE6cLojuOJv0re7c1w471K08gBMxqYGZSqRDqc56CPWq6kYWn1?=
 =?us-ascii?Q?mPS0c6k8wksO/RvcZKzW7/LQg+X9x6dbP1hsoPSA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7107bb93-6e8b-4fb0-6b38-08db98060e83
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 11:53:18.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmavRUxkl5dRvswkU8cGAMuJgE8datcvJZdGSAojWmu52lvmb2tvFq8aFCntWvHLmt8e0WV/iByEm0i9r/SDfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10062
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch gets the QOS broadcast stream parameters and passes them
to upper layers.
---
 profiles/audio/transport.c | 245 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 243 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index cf5662d1d..107339520 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -552,6 +552,8 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	owner = media_owner_create(msg);
 
 	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BAA_SERVICE_UUID)
+		|| !strcmp(media_endpoint_get_uuid(transport->endpoint),
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

