Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D42C04FE1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 16:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344900AbjHPQrB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 12:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbjHPQqi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 12:46:38 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2048.outbound.protection.outlook.com [40.107.241.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3151A1BF8
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 09:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X72ItkZXdip3D3FG3nBWxxKq8ooFX1i4/zoe6eC7AqFv5i2JWm2slCAze5BfIf/H9rckkczXrUCPjpUtLWdML4ZzD2rzNdM5ucCz2zV8KHXIZZSYnnvmx6tUAWAHsvFNM7Fp3ct32AFqBZuOssPTMSdA8rg2cxzKyFEzvtiT4dClMxrUPoMy4RGj+OCb5v2taYyTzHgZq3RMkPaCjwoCDavbw+305VfaZBThEos7I7l766bDE6bJxmdE0it8PAICySheQkI1I1tilnU0VMHNHonE3/VukpeS2mS6xVYcjEZQwlgBQwwIphLiBYf97d/JkhdJMMO51ZHoKg5Ee4VVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lfoXCKm4PEewWvh3Jtf3gJ04VVxfTQiLj25E3S0A/g=;
 b=DS+oKXvS8USKA3I++jvHGk/BXIDkTkiiPXJwe6soBfg8dBL7Obhqv57wCKGOYkDzQqcWe5DkXH4uRbu7a7kXRLvWxoocs/l1SIYCh7l9xg+UHPI1xinug+4VCBag2K/ZMnWBveDgPMjNn4uxVNJ/nXHShDMAqhHkVRzf5DAn+IkhLdC5EmUxaeIArlNRaGUC/ebfxDc3/IN7cPRbfQroSbkhLEcn87+jWgKNpV5tG0uq5GqKQszm+S+xXBrJb/vQeS4Um1xldlq2HZAoAh7Rv1PESFNDaaxGvCWCSssiNA2/zpyI8bryQ+SEbgZ0chWUW2hJmLxzZNrZjuFYDaHawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lfoXCKm4PEewWvh3Jtf3gJ04VVxfTQiLj25E3S0A/g=;
 b=RIlhXjG5agrGZtUvUkeTE0nM0oPSYC5FU/FHlLf4JmgeWDKXj1rmMpsnX/ZRCC8jBQ/ykYvxS4/j4UOvQZOBvsB3VOk7AoAnkx2CpjqvZewb7axbr0snhpsUCfLKkYXOdzKMeap18jlL36cJtJmvUaSTpKKKD+c5t2fKQLhsOBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 16:45:20 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 16:45:20 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v6 4/7] transport: Update transport properties for a broadcast stream
Date:   Wed, 16 Aug 2023 19:44:32 +0300
Message-Id: <20230816164435.5149-5-claudia.rosu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd2f4c63-0c64-4d89-27e7-08db9e782dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QuwF9EQEyovqNjMHBqM2jkF0DJEV26mipLATRisdwzDFezkQBOveEYyKz/1ztOpLC97plvb86C9LoJxLmUUyZsiRXLl229Yp71qVXGjTqbZd1sIhhp+kHZroa8ZMPKmWU1uPcd3EWRNsp/Y8bVujhyWoQK/i7V+9Q6M6Sb9Iy32NV4C61CaCf++3SGSV1Ls/yPUnTRCv+LvuGAhWciMUhkEe5ENUDaTR1gWfdTX1/597qri6WzawuE4TWumhFYQzgmToNnpVYwug4a6xvaYSL3+kZmFPMi+fmM9SUgFDryxnTKSadORPxib1R4yov02bTzFjE3PyKtb2EaKrWXANf7H5LOt1ecBz2A3ht/Os29GChGtXrDSp4oUVylfO7845D18TPm/sLphPk6o4ptsW0Tr8WIbwW/6o31bYFoFD6uPRtqXpfUo82YvTADDMvXoJRO4DNpHPraQryHlFg7bmk2MumVCTXGqhfrJfOu8AFknU1mTaJTRYstmv8a9ACunQ9026Gns9M66RfLIiK6GuOQRZ5sg1x0d6gaDPuz8Se/FCI3Ft3E0Z8H8EabD/BKNV3XJYI+vRRvcfeDyDrQDhaYcs2Dk3FQ1J5pwPYpCK8UHpCvx8gfAQUQB9UtPJ4EIM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38350700002)(38100700002)(8676002)(4326008)(8936002)(30864003)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(6506007)(36756003)(6666004)(1076003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7g/+zZjCKn5+ygmwLZBs22O46ELmmxg72zPEIm/U+W8GIWVvrAjNMyQw97uR?=
 =?us-ascii?Q?l8XBcrcH3myVyEeQG28MnV9YXqL6dRMiAjdqI66GhbijRlzLdE+7gCzVj4H/?=
 =?us-ascii?Q?kGakUgqpvXoDlZ1tbNcJJfOXet1mHYSWSXef8/HV/vsvLr37KKgcmCRVfAkf?=
 =?us-ascii?Q?PsYeV/+htCkdIQlXm2bmqiKEjHoKooVd2jkM/ofB3vuM3wt8d7QZ9aaypJLo?=
 =?us-ascii?Q?TXtsdBpDTVUcNd53dVqjOIdpmKRTkFXQCq/7BkCcPLkazV2DUNCCfzvF8gXD?=
 =?us-ascii?Q?5aMdV6XGEktDV//bIWOTRpT1iCK3p06akmDIg9Lw8X1zYUmRyWH0wwVZ8ebi?=
 =?us-ascii?Q?5E/cPIDq/9ay07KbHqSZ7JgsD+B8YRSznzAIsrmczHtKXHAnYTcuDFdNqDhQ?=
 =?us-ascii?Q?Nj1y+PvGW0r+HcJmBZ0rnSPed0VjA0fkSM2aYJYPriDsVBGXKbWMUtN1k/HQ?=
 =?us-ascii?Q?Z69YvoN5clrCkTgbiAfWx4FivlKOsdl0fVBBuGkXwFF9JrBc/RNdVIPlsu7U?=
 =?us-ascii?Q?GnDuUo+ibgh9DqMvvJnio5P32FH2UpzzPIno+ECmAnWDO9RSyWozkp0JA8OA?=
 =?us-ascii?Q?Qoc1qtQK37korb7pb3Oh+k2DcD2fbMpZEb7d7zOr56ggb9/rHmg6oOnI0rLH?=
 =?us-ascii?Q?81t0RqPupqPfA5ZTYXsgLTI6LUNIsafPjiaTyWJhaYTIrkoWISx8Ley5hLPL?=
 =?us-ascii?Q?rRVOn+MmzZXZ2dcvICnlXd37qMhWntu3dIHCUVQZVysX/4CfxcFnT7JQTrau?=
 =?us-ascii?Q?qRkwuw6I5x0dmueGU0tqHHM13kxE5/L1bwH78jC+UGFh4PfieplsQtvtREl3?=
 =?us-ascii?Q?kgVq8apOP/TaZP9wh6b3tY6BCgt+E8OrA8hi+6Bv+4xzx7zkU5gI7hJzzuOJ?=
 =?us-ascii?Q?bwYtIRCcW2Ifbvgc0VGMped6ew6Twk7liNUO5Nx3egFOXU+Urc7qmTYXvLKm?=
 =?us-ascii?Q?PJEtecayqQweBKVYsAJ8V+h/OmAD40obPts/ds1A2HuYpKDtRM8FDW83pmm3?=
 =?us-ascii?Q?Drt0JAfBh1i/DEwyzkXX4RHaz/8IDjGTn0Sd0P90S59dHzP4HgLoSQxfJdCL?=
 =?us-ascii?Q?5dYexIEDZE8ou8v3jzcRTWOnxCaH1eFnI1tWQFY7bjUphuXgJh5neXbUE73M?=
 =?us-ascii?Q?njKmZlHD9ZiD6wEa+hiol+a+RgZYRCwfFsL7mcI8liFXh+zlyuepVK6+Yfzc?=
 =?us-ascii?Q?tkBNJfSTfSQXAtbyK6+WVpS1OL1o1gpjHPiBtpo5PtBRtB3Qf4qhQT2ulmPO?=
 =?us-ascii?Q?UDlI1gGHaDMZj1J8w0F3UFU8ajWUZUo8qRN/IxO85y0gDRdATsZls5fab/D4?=
 =?us-ascii?Q?Zek6w+8DwXJrS731ThwB2TV49aiZN08DKPfWXq8vz5uq1jwjIgdVwKfsYDb0?=
 =?us-ascii?Q?gdYDWrxgFcJUGQJkz3L03t675t5hHbijK1KUpgBJqzxSqGvKImz1VP6NkXae?=
 =?us-ascii?Q?W6wuJzS1w9SlVfQ9srT070s8S6bfjLdTSz/VxddnR9aqb/YVEACfPVx77PTS?=
 =?us-ascii?Q?Wsoq71Me9Nwzg0M0ma3f+vUzLtgzTLJ5GMTZ2rdw+rkiwq1u/7D0EEdIbOqP?=
 =?us-ascii?Q?GkQGwl1GUeP/tVllHUgzXNgMXz/rHB55+qQNLrNL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2f4c63-0c64-4d89-27e7-08db9e782dac
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 16:45:20.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpUJchIdnSCnc3D3mJpRog9AvOva6Z0Fu37buWFRfRKtQjmpTiIOusYZXrXzePls0sySpvuThrJ7xw4YfCIxvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch gets the QOS broadcast stream parameters and passes them
to upper layers.
---
 profiles/audio/transport.c | 251 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 249 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index cf5662d1d..f7a29ca83 100644
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
 
@@ -1341,6 +1511,77 @@ static gboolean bap_resume_wait_cb(void *data)
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
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Codec");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Configuration");
+}
+
 static guint resume_bap(struct media_transport *transport,
 				struct media_owner *owner)
 {
@@ -1493,7 +1734,10 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
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
@@ -1503,6 +1747,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			return;
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+			bap_update_bcast_qos(transport);
 		break;
 	}
 
@@ -1631,7 +1877,8 @@ struct media_transport *media_transport_create(struct btd_device *device,
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

