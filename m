Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C831EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 09:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjGLJDg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjGLJCl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 05:02:41 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0773B10CB
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 02:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQUmlhpVdpD+JRRTyXXPV1MtjAL+0Erfv+3M8YunsiThBRf0HIDa4OxOkwaPmxbTX9LCnH9ZHAk7Bf10bhwgtZsx6qFhLRZkgxKXmVf7+YwazIWLadE27lLySnOzuuUOxKxJVPIYIKe41LoWPVCnI2rqPvdbVrcOvlCEL931v76r0utlp9yDSB+aB1SEhGWYWc8kfjU2MpsaGQz/S0ONtaFHux7lx4c3usTF6QpgGnTYMjuuJaUKQH4eex5F3uc1YaiUrJfBXtTEMAZpnnR4cAcWWZtNUl4c6PdH+K53v6u93Wozkzc1Q67X4UDlIfPDjfbkZXBQbN4dZsZsiTQN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np+k1+XHKqWhywiSFetxV6QYJVW8tl7zRthk1kwVeAM=;
 b=FBmk76FFyZTA7XT/9f9R9DrhdOSnPv3D+YOEIusEXXmgxyX3ihZCq02OomAA6AlpWRvBKFua0LkLSFFcWj8iBDF0hDMR0PadbZwTUFaJwcBqVbKZocB/+fOVOEf7AkazNxe9lM9yaEqIIvldtGlZj9LABsBGQmL8IN8Y3KouAkBeh6TdxW8FY1b076KJOC0o3PLM/4UEbJgznW5nWDQPYVtcUCJCrSMqnjY3YZ7skjW5lT87U7PeX4dZCEM6E97FwVuvR/lKfTt/uwqKsiYfN7WTaKJ4AywzoX+jpqKOcRwAGE5xVqav37b4bRoUcGnCfAu7oqZ+1UXq3dJI4fN7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np+k1+XHKqWhywiSFetxV6QYJVW8tl7zRthk1kwVeAM=;
 b=FnlVA0bqIysR8seaR+eHf9vz1WoWY0a9x5YNEpOAKI6mWDkVdCek0VYf4NxLlNsnIJu73FGZKiSFa2e0JlW5hOtltvOuEnB9S4q3DG9Lon/k9OD4XyzZVF+z0D6xnBeHg/LK7c0x7Qwl9Ofq2WQnj9aa8QrJ7We1qBWcm/SBXhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PAXPR04MB8525.eurprd04.prod.outlook.com (2603:10a6:102:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 12 Jul
 2023 09:01:21 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 09:01:21 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 3/6] media: Add support for a broadcast sink media endpoint
Date:   Wed, 12 Jul 2023 11:58:57 +0300
Message-Id: <20230712085900.5423-4-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712085900.5423-1-claudia.rosu@nxp.com>
References: <20230712085900.5423-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0004.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::12) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|PAXPR04MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: b23d01c3-5aad-4154-748a-08db82b68fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: igC1vP+hVrUtWHEsvMDEZP0NQHlQj3kawu9p17ZslQhMW4lVv6EaactsM7pXixQCiNpdDkBO5DHJhHN0QBKGvT4MyNZama8e4P/kDNTQlmRnSvvYHEYIeyRCpM+PSlu5LcJkuyM/uJRjvU43Fn3bLZAFsnTb0LdRlFCywwTM/ngKjbZPdek/11pNlTK+K2FBvpfnJp5RhEyj/6i4pArBiqcYKhwIherkk5i2alxrZVwdfynMSK7ru7GfgOJq8FnjrbN3gXhJ5FjKl3xeM00hB8Oupc84WPC/xFnqzu1O0XJ8j23YZo0XnFHi2AYm83RBlYJGSm7dzasJmcVDy492+sspA0DaGGuKCxiBNTYWE07d3UfYMbfT2S2seS+PErj0lHh1SGfDVRFLq+PeP4yRivb8m1RwyOOjNHEOkJrTUTgrIPBl5uz/Qj32UASoPn3YoJBc72A+o16q8DXOPEX+gr8qUoBGrWguVrBfpFEOPBFDCRhcQtObnSREmBiTe1f/LHaXFreOG+Yrk1RlExPSRUZ/SwUhCQ+TrI123HuSOt2FeCkF5nbCVPJS6PHgAOl+YRF3sJFj43sOQf0XbZ6gPTV7jQ3GsLptdecRCJ8gc/wzmOHf1ZifBalhWkpyy9q1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(55236004)(83380400001)(2616005)(2906002)(36756003)(86362001)(38350700002)(38100700002)(41300700001)(4326008)(52116002)(6916009)(6512007)(316002)(6486002)(5660300002)(8676002)(8936002)(478600001)(66946007)(66476007)(6666004)(66556008)(186003)(26005)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j43OH+WkYjBSvfUfw0Ta/NneMY+fasbPoapM3pOnfci3e7GjjKXUaye/IP3s?=
 =?us-ascii?Q?7GwcNE9tCc25zpoBGfxJ+1dHoDxFT4KAW1NNT5o98+NWhIG2I1I6hlEyus9I?=
 =?us-ascii?Q?WMRyTRMdlc+3fyRlkNgG3f5PzIBvWGYJ1jewVCO/KWcJVnhI1X9PZP0mi4/A?=
 =?us-ascii?Q?wuwwMVJ00OvvIo5/HHtu6so41RXGYRaEtIA8VFNVsDe067JUSRLQanH0ifhv?=
 =?us-ascii?Q?N9X0wqoyesjW72weESv8/HhZo4Dky7LSwSxjkpvFyxCkU8areIbI6iNmlATH?=
 =?us-ascii?Q?UbFNb+kjlxr798QG5Eyy9FRjuxvv92tO/8Zd4qbdHq2wi1IsHy3Z8Z2wWS5l?=
 =?us-ascii?Q?OcCnh8YpbFMP8Dh0wWojoVTDlEmAGav8DNnsT3qzRrsFPfjzJjqZwOnqjTar?=
 =?us-ascii?Q?kHvGMjlOSKyPNGjT4ObMoLJTJCZf0CZfVDWHRsaPR9jKu5/y4rvx+NvwhxIB?=
 =?us-ascii?Q?EaQokAfaroSLBvoJelHqpMFH3aqVctIOcg7oNWpnMkDYfx3b9UV9HUstSVG0?=
 =?us-ascii?Q?z8Sp23xIaWJibRzNJM6L4vUK7ADnH0aT5fd8ETiyZvZcDd+YOHLk0ZcHTMsx?=
 =?us-ascii?Q?Y6V7jL/pblXag7m+yfgz7ye0GpGexcLSFcrRslgGMNPMyR94lmERFXGnYVdE?=
 =?us-ascii?Q?K9x88szrI74VliFRhjesjQf1AcfKcaVIrsrbuIMeb4asO2VX2quXsCS3Hj0k?=
 =?us-ascii?Q?WVtGj2Ah0XnhIOWrz2vYyUtdnMyRZGkZlqVpbUX5teFOVyJW46DBUtNXizno?=
 =?us-ascii?Q?PA/T+1LHZG87jUaCrtkvn5C059vVZelsdTbZViZgVuvFr+z5ImRaKNiDTZvG?=
 =?us-ascii?Q?bYU1Sg7jgPeCYg1e1j2puLs7gHZfziA01Gh3ZD2rGb1HgZfyyubIg07bqRMK?=
 =?us-ascii?Q?xEK1GH/OQp8+IizpvGQc/ZQIJMpb045aitCKDnUMXBQsljOyAdE9JSDsF1QX?=
 =?us-ascii?Q?HNXzCCoc9OYDt7sy6ZE86EVLXJ+pnz2JAj7R2xsmmixa506lXs9dEsK0h0nT?=
 =?us-ascii?Q?aZznqQ6CxIBXgpuoHEgLKO1GSkvteltqLy0lyTA2XmTT6MGf4brAgo1OWnRI?=
 =?us-ascii?Q?6LKHmyhFbMBZf4o9Y7WqD0aVOr8oKJY09zYZ7FRP7e++dkswXr//e/JPMQS9?=
 =?us-ascii?Q?PTUu8bKBj5IherJaqoy2Tcw2A1DpD7Ig7WBsZVjLvRnMC6DIYxhJaq8QFQGY?=
 =?us-ascii?Q?qa/ErYjSX+SkN+98xaseeQZEDsUMrgN5g2Dcz/+5N3/YByQUulsvqq294eNi?=
 =?us-ascii?Q?dhyHgHzKK3eGqVSPx6FmeCp3lSBtQHKj7z1PNDJV6ZbPKkHEUxJJrvr3D7h6?=
 =?us-ascii?Q?/f/4U3WnyLYav4dapIwhuE/ySJhcPWv/1519M8SobHoa9LqQQ32O4GU4+8Jw?=
 =?us-ascii?Q?kEI+FgvcUmDzT4eHyY9lQ1Klo9nsytm67C/5TmB8ZNLCgF+RQ0qCAX/1hHBL?=
 =?us-ascii?Q?3oelN8AWMoHRf8KVR/fe5sTdpI4VWOWBKo29cTJdR9hS16pf5V1ug6cubsvg?=
 =?us-ascii?Q?6XYz/IcyWXDnuiE0kzicID57decKlLSN2MVnIaH479dVfLKuP8IsJeWDhYHZ?=
 =?us-ascii?Q?Fi3++TS/fuuKKRhRWuaY1d5m264e/N3p+V9gKPny?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23d01c3-5aad-4154-748a-08db82b68fdf
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:01:21.4556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FT4edPSoNCmi5gL+Y2/zI+vqn9cECzTzOdtM6pqtD6Lw5dmpmAZQgmuZI08l+psKujcyqzivjYp2i70And09uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8525
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the possibility to register a broadcast sink 
media endpoint if the controller has support for ISO Sync Receiver.

---
 profiles/audio/media.c | 35 ++++++++++++++++++++++++++++-------
 profiles/audio/media.h |  2 +-
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index bcf4eae26..d529a4f60 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -105,6 +105,7 @@ struct media_endpoint {
 	GSList			*requests;
 	struct media_adapter	*adapter;
 	GSList			*transports;
+	bool			broadcast;
 };
 
 struct media_player {
@@ -1224,6 +1225,9 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 
 static bool endpoint_init_pac_sink(struct media_endpoint *endpoint, int *err)
 {
+	if (endpoint->broadcast)
+		return endpoint_init_pac(endpoint, BT_BAP_BCAST_SINK, err);
+
 	return endpoint_init_pac(endpoint, BT_BAP_SINK, err);
 }
 
@@ -1333,8 +1337,10 @@ static bool experimental_endpoint_supported(struct btd_adapter *adapter)
 	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET))
 		return false;
 
-	if (!btd_adapter_has_settings(adapter, MGMT_SETTING_CIS_CENTRAL |
+	if ((!btd_adapter_has_settings(adapter, MGMT_SETTING_CIS_CENTRAL |
 					MGMT_SETTING_CIS_PERIPHERAL))
+		&& (!btd_adapter_has_settings(adapter,
+					MGMT_SETTING_ISO_SYNC_RECEIVER)))
 		return false;
 
 	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
@@ -1382,6 +1388,7 @@ media_endpoint_create(struct media_adapter *adapter,
 						int size,
 						uint8_t *metadata,
 						int metadata_size,
+						bool broadcast,
 						int *err)
 {
 	struct media_endpoint *endpoint;
@@ -1397,6 +1404,7 @@ media_endpoint_create(struct media_adapter *adapter,
 	endpoint->cid = cid;
 	endpoint->vid = vid;
 	endpoint->delay_reporting = delay_reporting;
+	endpoint->broadcast = broadcast;
 
 	if (qos)
 		endpoint->qos = *qos;
@@ -1462,7 +1470,8 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 				uint16_t *cid, uint16_t *vid,
 				struct bt_bap_pac_qos *qos,
 				uint8_t **capabilities, int *size,
-				uint8_t **metadata, int *metadata_size)
+				uint8_t **metadata, int *metadata_size,
+				bool *broadcast)
 {
 	gboolean has_uuid = FALSE;
 	gboolean has_codec = FALSE;
@@ -1546,6 +1555,10 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 			if (var != DBUS_TYPE_UINT16)
 				return -EINVAL;
 			dbus_message_iter_get_basic(&value, &qos->ppd_max);
+		} else if (strcasecmp(key, "Broadcast") == 0) {
+			if (var != DBUS_TYPE_BOOLEAN)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, broadcast);
 		}
 
 		dbus_message_iter_next(props);
@@ -1569,6 +1582,7 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	uint8_t *metadata = NULL;
 	int size = 0;
 	int metadata_size = 0;
+	bool broadcast = false;
 	int err;
 
 	sender = dbus_message_get_sender(msg);
@@ -1587,13 +1601,13 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 
 	if (parse_properties(&props, &uuid, &delay_reporting, &codec, &cid,
 			&vid, &qos, &capabilities, &size, &metadata,
-			&metadata_size) < 0)
+			&metadata_size, &broadcast) < 0)
 		return btd_error_invalid_args(msg);
 
 	if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
-					codec, cid, vid, &qos, capabilities,
-					size, metadata, metadata_size,
-					&err) == NULL) {
+				codec, cid, vid, &qos, capabilities,
+				size, metadata, metadata_size, broadcast,
+				&err) == NULL) {
 		if (err == -EPROTONOSUPPORT)
 			return btd_error_not_supported(msg);
 		else
@@ -2627,6 +2641,7 @@ static void app_register_endpoint(void *data, void *user_data)
 	int metadata_size = 0;
 	DBusMessageIter iter, array;
 	struct media_endpoint *endpoint;
+	bool broadcast = false;
 
 	if (app->err)
 		return;
@@ -2741,7 +2756,7 @@ static void app_register_endpoint(void *data, void *user_data)
 						vendor.cid, vendor.vid, &qos,
 						capabilities, size,
 						metadata, metadata_size,
-						&app->err);
+						broadcast, &app->err);
 	if (!endpoint) {
 		error("Unable to register endpoint %s:%s: %s", app->sender,
 						path, strerror(-app->err));
@@ -3245,3 +3260,9 @@ struct btd_adapter *media_endpoint_get_btd_adapter(
 {
 	return endpoint->adapter->btd_adapter;
 }
+
+bool media_endpoint_is_broadcast(
+	struct media_endpoint *endpoint)
+{
+	return endpoint->broadcast;
+}
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 1de84a8ff..2b579877b 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -22,5 +22,5 @@ const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
 struct btd_adapter *media_endpoint_get_btd_adapter(
 					struct media_endpoint *endpoint);
-
+bool media_endpoint_is_broadcast(struct media_endpoint *endpoint);
 int8_t media_player_get_device_volume(struct btd_device *device);
-- 
2.34.1

