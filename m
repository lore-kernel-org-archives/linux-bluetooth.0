Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4082DEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 12:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjGLMX4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 08:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjGLMXz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 08:23:55 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F4710D4
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 05:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0+0kw5lfDYfs9NUsUNekWQaT8ABLmtyT4QRQPEzXGG1yZUiDC2X4gX8WgWWnIoglXkcKd79emhoBUCHXZF4CRsvu5b2+Lkn8nWUCUDDKha1nLW0DOdgjwinh4DCkSayhdWzfM6vuJtJ+RtQOiIfw41kfftqBl/3GqTbeSBsd2QGoLX55QJn09aTeR8ukhHhMw71DjhqVnY7t4yOcRufAxiPaRfh1RoRhgmR4egYV2Bs2e2Ox/DHxs3wL2kBVqGe/RTMEbCgV38H0sSztLOKyDKdYUElLQyrAUcqauy7C9h6q8nUmoKVNqsSjb/2OJ1DrilyUtDaV4Z6UvVSrh9sSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASSiC0WdiZzy0QmsAq6WzXQDgjFT1RlUZdmBINPv2WM=;
 b=DxkQpAbmKmG1dTAfInU0umsz8/BESSx2RVfNixvN3kKP/QvOHf5QxFr90mJ+QDYlNhZ8LBRZrpUO/KMDAzR1+vIpV2ERdvuds+Kr8mZXE8z4/PR6e7K9wsQm7TRIP8YUmUrkd3nHBUCDqp7iNgQlXnlbex2hC9U8p2qbsBjrsFv6VjvXNEvaGLfzcbnjkZkRRZS3zPa/hYfYxlR6aA/49/V0H0duZ5ewninBU0ZK5JwW7+XuqXAgEk1qwGNQlpIebaDsomeq/INnc4FmUsvc2nSTKjpbDBAD7Q8t9w0Gpfq154sXUL9EUYATSz6cKrQQ/GWkQvX9oG+oEPyNjAxomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASSiC0WdiZzy0QmsAq6WzXQDgjFT1RlUZdmBINPv2WM=;
 b=ezLN0Wobh6oofKgthWUL0dapmi/0UW312cjFKNd9b3H4QOX4XICl+0QZPxcRoBNrLebc8Kkp1y2ZYVlah1CRu2XfZu4M+mB9oZho87EzSYqho58xKCAZnv3JDcjM35cwCFsr6kF6nUSJZRqlC+/LHKR4Rv5lN4mfAI1SXQzNdNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM0PR04MB6835.eurprd04.prod.outlook.com (2603:10a6:208:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 12:23:50 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 12:23:49 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v2 2/6] client/main: Add broadcast source discovery
Date:   Wed, 12 Jul 2023 15:21:31 +0300
Message-Id: <20230712122135.7734-3-claudia.rosu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e05eb12-bf52-42c9-2c75-08db82d2d8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DeB2vomD3tPY+HGFoAVND4PwJqLrPJfPFQEN2Wyd3oJJEAsWbzWXA5lFg1c4nSa2zotYXGD+qv6BUlW2luHZk6zJSF+nVgp3kYI10pvv1pYz/7tIS+uvLSi8nU8KiK2dgh5cnCEHH6FmVt4VliurprVW1Sdi2CwOCYzPUANrL2nwEHTMFNa6yyNKuAfYJ2MmyGtBsPp1TGjr69FiB04OmhmuKaf3MkLg04N+nhaEjd1QKlMQhC+cdpLmdtDbMpYU7RzmLRxAGxydo9dbKy4CcfUXccsOf18Exb47Kvgzo1tdRuI2z1ZNi8RLoCQrz1PPMfxmtn6/CfOw54ucz2R9f5vETJjXesyt59Ty8IcW8SRvZGiF5aeHQnNWPlf/mm5f60q2DinkukLIgOVrqm2qe0dlElc7ZMtVyMymc7dINdKqLDuVyVU2pkP0xXCTsv0muxpe05TBsgBIK8ahhkVxzUm0MEoDX47wztNIgLvDNLWFk1HZ6CIKyAd6BouPxttL28sz2PP/UWcUdjpydYcmVXVAOtja6yCPJ3ttwwB+qtASyf6EvWJo+WhSHogoI8VUFOH28hslsyE42Q3IqiAoV+CJET3l0FMoPG0XvQ0mGsOut9DPI8wRtI48f99t431
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(8936002)(8676002)(38100700002)(38350700002)(41300700001)(2616005)(2906002)(316002)(5660300002)(66476007)(4326008)(6916009)(66556008)(66946007)(6666004)(6486002)(52116002)(6512007)(83380400001)(478600001)(36756003)(1076003)(6506007)(55236004)(186003)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ti/E/sqpqDSyS/l375rg15Ulpz7z64YGb8jEStcE4hHbj5So/aej/QHBXAgh?=
 =?us-ascii?Q?UxMVftM3EZfHcdOp68ZzFFdEUKcDlsb6waeK0r4DQyNVHHNKVRZ6Oi6Mm8fE?=
 =?us-ascii?Q?aRS08V/FMEWlWlBya5/Ozv8dXKfZwKYZFoj4ZFBq9Sbi28JYcmuaF61Hh4Kg?=
 =?us-ascii?Q?L5Se08RDDrnjrVZemi9D11e/zI0v1MwG5gbYEK4hDwZ41BujiHpSCtenLzTg?=
 =?us-ascii?Q?FPs71HEQuj6C8A/P5yNUVSIV/xXnnSq+K41gBAfUr95RmMi3EdVhPsZvJByh?=
 =?us-ascii?Q?8ZuOV9tBh+T88gBDikD6hrSefPXoxUZqJOr0sIYnfuV812XUVlZHOiBq9658?=
 =?us-ascii?Q?nPPy9N8O7srX5v/XgjEaSk+x0QSLA8GU7mZiUu4kIcgpY3OQPZk9eJLZerxf?=
 =?us-ascii?Q?O2wQgYq0+ySe+miz76GCuvrYF2jSsXYjW86b/PZP2dLXj/G33nDQu5ltuzLK?=
 =?us-ascii?Q?W7wfQXsP629cdPvO+Vd9qdeX/gqXvPj4S1ASajKwfShJWat9qBbUNuGE+jAl?=
 =?us-ascii?Q?Ddf49Uk/pbfKrvHtlzwwfuGvcYC7SkBUC98qN1QqLs3eV23aetYDIgDZ56q/?=
 =?us-ascii?Q?x3QJdCMV6rIpyu9+qlt/GdhYaAtAg2yLEczuvnZy7ZKEYohzzyzCu7gw7FRh?=
 =?us-ascii?Q?QomMniIXEbIIjPm/c7PKmYunzCAQnuEaI2JdFBVDVhcjh9RLctThrllYuEXz?=
 =?us-ascii?Q?9Q02qsPIz7gpjaV50dnjZtuNGXK9oOpOIjodNDuSx8U1sqtiu+YopyzmSxGf?=
 =?us-ascii?Q?Yw39jAq2u5fVYD4lc4B4+son9GvuDsnu3qxSgQu6BA902FpIq5cqv2rQik7R?=
 =?us-ascii?Q?+bpZR4DoDBvd8Djxxichs8GRDid0lY3J5WsG4ryNabFRxncjjivv0JTgsqFu?=
 =?us-ascii?Q?DX8lYcPPsz6VdKIoWU13//Jr/k6pxdABJx9tUr3JOnp3CkyvK+Klg/FP3j3R?=
 =?us-ascii?Q?Z6+KdHAjtqJ9t97a1PfiELdwO3wps3456ACiW6PQC9DB/JRa1swhhKzdTKvC?=
 =?us-ascii?Q?qcsrTcHALP77/6Ynrelf5Q4i0xnCxmBae10Ox45YTTNVs8OtDhSQh6WjzePF?=
 =?us-ascii?Q?Vhg/pIQI5o8Gtuq/9CC6USfAQRc380kwxPVBA5Arsb+DjAulR7B2c9IZrdwa?=
 =?us-ascii?Q?E1JZd4RUvbLDZi/M9KtJL4ZB91c8Tb+ea2WAEg5/kZrF23vDAooP9jfhcMVZ?=
 =?us-ascii?Q?P7HMhAEyjosWmACPKMJapSuXJyakEcjWeigMWWOlfxvUAb90MU3NTdXkVVGX?=
 =?us-ascii?Q?clc8bZsJSprRry10Zg5Z7hsL7jbjqyoFcrbqNjAL7toxlMg/mBmAz6VvhrTO?=
 =?us-ascii?Q?YNK+G4RxX8ZosnlAr80qTPWgj1XautZRoph9NLTMHy9Kttj6cupujKB4ehgE?=
 =?us-ascii?Q?ErzogxJXxt4Vz69JzGnkv3+YDhamzBGKCr6K2jLmcS11IbcFDeH7P4HrbGsN?=
 =?us-ascii?Q?atB3ZRt7Rj8nsacrwdYEI1DSCj+aUd1OfMboPKrQcow+6rRYeJ3sqpNGnrsq?=
 =?us-ascii?Q?Myhwikv78nJuTaVteYN+Y17ScAD1nHFavhXKnvKLgaXRCmzUT4knnqoWpYMI?=
 =?us-ascii?Q?mB7RhkhpR8a7P0+kPNtFB5bIEVvbOc2mxf6NttPVM3/boj0CnjPiFO7qJhrW?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e05eb12-bf52-42c9-2c75-08db82d2d8b2
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:23:49.5267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28b9b+ECtUYLMG2Hg8U68gFE07O6RY4uzERBD5mbtyoAmHFK6DvKNkT9SU+iW346FQXomozMUyA0uBkiaZ1H3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6835
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This checks if the scanned device advertises the
Broadcast Audio Announcement service.
If it does, the device will be added to a list of broadcast sources
to which the adapter can synchronize.

To test this feature use the following commands:

[bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] unicast/broadcast (u/b): b
[/local/endpoint/ep0] BIG (auto/value): a
[/local/endpoint/ep0] BIS (auto/value): a

[bluetooth]# scan on

[bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0
/local/endpoint/ep0 16_2_1 <source_address>

---
 client/main.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index b433a2200..8fe537f34 100644
--- a/client/main.c
+++ b/client/main.c
@@ -198,7 +198,7 @@ static void print_device(GDBusProxy *proxy, const char *description)
 		if (filter.discoverable)
 			return;
 
-		bt_shell_printf("%s%s%s" COLOR_BOLDGRAY "Device %s %s"
+		bt_shell_printf("%s%s%s" COLOR_GREEN "Device %s %s"
 					COLOR_OFF "\n",
 					description ? "[" : "",
 					description ? : "",
@@ -304,6 +304,57 @@ static gboolean proxy_is_child(GDBusProxy *device, GDBusProxy *parent)
 	return FALSE;
 }
 
+static bool parse_service_data(GDBusProxy *proxy)
+{
+	DBusMessageIter iter, entries;
+
+	if (!g_dbus_proxy_get_property(proxy, "ServiceData", &iter))
+		return false;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return false;
+
+	dbus_message_iter_recurse(&iter, &entries);
+
+	while (dbus_message_iter_get_arg_type(&entries)
+						== DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter value, entry, array;
+		const char *uuid_str;
+		uint8_t *service_data;
+		int len;
+
+		dbus_message_iter_recurse(&entries, &entry);
+		dbus_message_iter_get_basic(&entry, &uuid_str);
+
+		dbus_message_iter_next(&entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_VARIANT)
+			goto fail;
+
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_ARRAY)
+			goto fail;
+
+		dbus_message_iter_recurse(&value, &array);
+
+		if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_BYTE)
+			goto fail;
+
+		dbus_message_iter_get_fixed_array(&array, &service_data, &len);
+
+		if (!strcmp(uuid_str, BAA_SERVICE_UUID)) {
+			player_add_bcast_source(proxy, service_data, len);
+			return true;
+		}
+
+		dbus_message_iter_next(&entries);
+	}
+
+fail:
+	return false;
+}
+
 static gboolean service_is_child(GDBusProxy *service)
 {
 	DBusMessageIter iter;
@@ -399,6 +450,8 @@ static void device_added(GDBusProxy *proxy)
 		if (connected)
 			set_default_device(proxy, NULL);
 	}
+
+	parse_service_data(proxy);
 }
 
 static struct adapter *find_ctrl(GList *source, const char *path);
@@ -531,6 +584,8 @@ static void device_removed(GDBusProxy *proxy)
 		/* TODO: Error */
 		return;
 	}
+	/* Check if it was a broadcast source and remove it */
+	player_remove_bcast_source(proxy);
 
 	adapter->devices = g_list_remove(adapter->devices, proxy);
 
-- 
2.34.1

