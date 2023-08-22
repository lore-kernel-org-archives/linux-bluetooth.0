Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D4EEE49AA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 14:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbjHVOcs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 10:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbjHVOcq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 10:32:46 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657651BE
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 07:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUZaYq4coYlnTmURWgVeg4h773MfJPatjEuIfOS11zFRArGl/HGl9TkuXkXbxE5ocSsrJbBbP3Q5+KI6VXRJoLlB6IcCBcefWwViPNp2qoEyjnDDUbiHnCbOt8aK152XaztDNYiGPbzfYQ90bQ7rs/ZZ6IGPAZDw0QfQkyGOOeq36oGWRQSSLelTeeHwm1H571YSPm1WYhsS2wyrjGnwHHmZ+iX2gZMQFMAb00OVr/O/qLRLzchq9atRsq9zZ1XC3q9w0xbjQNBkV2R797BjzLmO/KkQw3j4iBMoFkxxvji+qCAcJp3QQ90cFzwfPEBeePVFQmd/QvMVAL+oA4rIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMFMd8wMyUm02AdJT82b26aGPLvtgO1k3opeHrQU/b4=;
 b=mgYwAz8zG6mhggY5DIc/rdJFd9cKBflmMAKDmkkBX4IGxtO9No7gOa3MsrbaChaV8++bllXG45wBJTdV2DVnO7gHjB7rc5j8+RhPlq+/W6ZCFDKIUJp0/7FoSljhL+bMwkxZcqcAD0/3bp2evA2o/MWd1+9/1yFqrQFkZgDwm0xtfC+RNe1BBULud4g398KNJvnOoy8ZGShbXLsvhdir6OgpUcRWlHBdBGutxsLufvs9q6X6bnpPbIFh1oauhsli6FRSSKyBh7NDO4c11hjzyVLRYzwZmOZy+RU2Oejjy1C00la2wmq7DZMsZAQrCKEzLFA5w5SWUlK2um/2nW1Hsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMFMd8wMyUm02AdJT82b26aGPLvtgO1k3opeHrQU/b4=;
 b=pUSpv1sw6nGfDV6C6Sk/99ILWqtHmnUwEhcDByhOsc9WOc1AFRr8PrN2rT8rgfs5j7R9nzClvj0Mo/ekpCdTucNtAMPKwrE0OLUZHjJJ9Q80SDpo787p59dZIxV/nU+Wr/12VECN3e1Adgo4MKYC6Fo9oNgDP7D6AaohBQantnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 14:31:57 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 14:31:57 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v8 4/6] transport: Update transport properties for a broadcast stream
Date:   Tue, 22 Aug 2023 17:29:33 +0300
Message-Id: <20230822142935.6016-5-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822142935.6016-1-claudia.rosu@nxp.com>
References: <20230822142935.6016-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::15) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS4PR04MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be46d17-a931-42dd-c279-08dba31c89a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G93bWrXwp2trkx1/w2qQlJhJWhs0BMGFHiEDnwS1j7u9p3gCzV7kfnioeN7PxzSPge19zn6NgEU1y5D6uY2XaMOGHHvh+tBOwtjkah66mSSKMTGSWJpgyvc0kbttPwPjQg0LrbZPj2EOAouSPX7opoiJgtWzArVKlK71g9XHqBL21mdiDcqw+iNdUWQRJr9Dh5a1cLy8cytWxAgc9Tf6dUe+jY5VO0YWw078YWde/9b6/fegWlBz5z13UcOHiyYmeKq/WGZJVs27bWI6IOBs2ID1ii/+aLJXvySWos/s1bcMs5HKmAwq0D2y8KMsJQmDplbx3xkyJ4r1G49MTPzfI1O164UgNw+nNhBJhTToDlbR/k++xDuQXXZPKn+bqLLMyyAuBnXwXPTXzHBlFjLiI6RMprbcy/GmRVGDxHZZVKlCB9UmN1Hl+TioaAYAKXYqL+0CzWVT43FBmnJlC6cYN5L50f9IRM2g4M/0V99p5eZrrjlkRCpeJX6fhYDwWQ9uBHcA7zm+V9hnP7IZG2NxcKc2RHKEj93ylHviGCWtFzXmc5AKtCot/EnXSQ0A7IcHK2NHdTvjnNus30Dpyomlof/86Prf9bRVrGogE3zvio7S4eAVdSJ1fcbWwE6Co/RW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(38350700002)(52116002)(6486002)(6506007)(55236004)(83380400001)(30864003)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hcnBgAzD1ZmvlGE/pU2NGrf95uEekQ8Lvp2+DZ6JjYQVuIUUhkE7O4uupDwH?=
 =?us-ascii?Q?XUkxfxY7HLknctlo1NEFBBEZ4YcCSyGoTaT3s7bb1AMw/rG/+Lnnkf8Y/5QQ?=
 =?us-ascii?Q?JfNXJ8r5p1aFaimrPjjPBZhsQ5Kht4BsD0atnZ9HwrW/Ku11WqPKSrpOIDXX?=
 =?us-ascii?Q?fWc70zOaCYqG8aE5KpzVRdBfghxP6MwyPhAdAzv4h3qETBsm7Y1SKr2dYeEn?=
 =?us-ascii?Q?3OmYidaxEarx7/agOyuVDdxjPgc+TfMZSAZfINtEHGbwCk3Ap0n+Nu/EGa98?=
 =?us-ascii?Q?9zBjUOfeyb+5wR7oF6BlQexj7jQCzuZdKKrWPoxFhLT8aNClUYnncLuOv3rL?=
 =?us-ascii?Q?yTG5wat/Bi9he9RL4Iu3IDznGIK33HvXD1ZEb2CGz6itqjGvTHrveifKp4vt?=
 =?us-ascii?Q?7HPtYZoW7GNX2yC9rXdVkpDdi4Yp2swOP12J2rJ+oOOGXveYUyFWENqVDzlu?=
 =?us-ascii?Q?xmdz549AonWbDnKa3shmmHhFYB4CQC7On9uTj1of8kEkM2HHIK5/hzb7wh6Q?=
 =?us-ascii?Q?xz7PbpAVmWpCdpcHZc/nWEaMvmtDbekytsciSazbvs+5DpKI4fifhvtmepEo?=
 =?us-ascii?Q?tPUiO7Y0e9kLMeqNPAfet4YP3F3lNAUjnCWTUFp0NCe430oPYE8pD8EyNcUi?=
 =?us-ascii?Q?S2cSgvL8JWHrvULKQAyXEuiM4+CH0ZTEVZzcMvA/dtJkkwDnzJ3sMFpSPnI1?=
 =?us-ascii?Q?TTtUIaOxGT7nIvq62jPJM6ttOQB60hG622LdasGhNiTfxMerORMslBGpjXvI?=
 =?us-ascii?Q?hbBq6dySF94S7ToEiDpNkejxbf+F80u8wrXfsydLHlOQwQsyYbNGYr8Oxdku?=
 =?us-ascii?Q?0bW1qc6jnSDSvPulfdVtSTLKB8ubQFccmlDlQpWQtWVM/GnOA2s/v7TWyOZo?=
 =?us-ascii?Q?m7nlUaNvbMJIvGvR7E03LCLZxMF/r2zNMWDa0CtFvGhKCT8qnwrMEWVmOq+V?=
 =?us-ascii?Q?DzWnrtI9Z9m79j0QtexKPE3ugY7JX+LiduWCpSXhKhpU5BnrrWvXpiwE7bDu?=
 =?us-ascii?Q?PQNinLMd5bSB3DYdcQ5IXBOGMIPWAqmw5Li2xzYDl/RZkZSgGBb3UzwnPF42?=
 =?us-ascii?Q?kO1HDAs0jSdyFpb/TNnrABrot+LBJmvEjo8s7YeQoJOjpks+Pt5v6kRfUUDl?=
 =?us-ascii?Q?ZAC9w/eMHY/piees2rhtHjDhc5VYV3eHi6n0xb98kETkOUEkII5+9s2DJFJy?=
 =?us-ascii?Q?MFrZ2TG6WEzQsBipt17iwfvc5QZa2/P9x4zHOdiGckiCkNWSENeOLX/WF5mA?=
 =?us-ascii?Q?PEoI9Uk55y+r9wycG0XSEQc8+BgJQVfX+Kw5XtQnhfDECdLk8Wr7SF7rMbVo?=
 =?us-ascii?Q?m6lkQmODaQ/aZU44L7IhbHbCGfhipOzzJkYwNMvofIG6jKzftBnii1OkaKHk?=
 =?us-ascii?Q?0YTE83GMwyZSi3ZJc8wQ1jDQAeDOF13YGfAvzhqEprgVllI9DAaM1+GJIIR4?=
 =?us-ascii?Q?wKNJThaUrMtnTgOK3zfhULRX4QQPxTpijM8sghd6P48ADfhQtuRT7gY3QRy/?=
 =?us-ascii?Q?/9vXvvrVaSjloHMcO5/4OPlNtk1HLtzgf/tVNqiF/W2TOZ/6WDHAev95HFE/?=
 =?us-ascii?Q?OdVc07p2FlZ7BT1oNYMxI+xddjW0L7aWgDomp/yr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be46d17-a931-42dd-c279-08dba31c89a4
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:31:56.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVHBjUUpIaMwmaQ7qIIgaOgOWo2wnWkOx/1EJI99kSNuvi17PqLj44G1l8jeFi9GmjmbNsGBbgtJahLLw9lQ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689
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

