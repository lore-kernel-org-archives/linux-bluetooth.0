Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E896CEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 09:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjGLJDe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 05:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjGLJCk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 05:02:40 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF24A9
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 02:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOgqEH3n4fxRwqjPX/hC2nRKB03GQ+rVqzv4mUqbFPdewDjdypSxL3/qvsInb+JZsRjCguiZsL51dqVPuPBpqOwj+TvBcl1m/g6NL7R5D3sneVitcm3bVn6QQPHNhWCqiLoir5hNh1RaqXc7k9Q4vtBWnVFceLnbDMLMZZ3Tj97EP010xDMQKmP7gouhyoNgfgL+OJjiZVjZCumbdf45c9wh0n/j71seWiaIPXimXmr4GrXHrptpfGO2lbxvC4RRbVLi7hp0FJDKp6PG+dcj74PcrcoKVG8hXWvxPOnLkE00WHxVWlXfVR4xBoeAy/M8h+S9InfmShDVS4ngjqxCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBO3i7KxxUyhz6uM2auvsfSTOk8uXDuKvkpCnYNZ1No=;
 b=frnPZnIUGu8zADBNGSFMnH4xxw2E4kIxx8i/GkzqBbmQBZIFkjF6Dt844J4qGzR46+QWXryGuEZsZoDRbqkxZeZ8dt+F+3qjViJMZ2Dd4/amNlyE2XiXVIgB4e+oITVWORxNDO0rkvVffhJwGhALYz05/tsX+CsA4h11alBQXoKhkiOf8Q8JSKRR3mpjyN+4lMPfsIAFKiplEHgSYQot2CcopyT8VbbdROuw1wV/Z0kt27LDYKOwt7K6BsIkBSbLQZzgJOMtlCL0DwCERbRATv2amb3iyPw7pAgDg6oN/OKY0jklPi3LY5fTF10kIWi7GigYBFrIhD3Ck/WeDqEpaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBO3i7KxxUyhz6uM2auvsfSTOk8uXDuKvkpCnYNZ1No=;
 b=nZ6CEWCfZdrNlWTn4UHR9hf/giB9DIJZRM7otC2LWQgWT+2RSJsuG/XvMUdoMm5olbGyD9zotn9iQeXyHZQTgGEP8jKYOyeAc1q6/aqKtHcwcN0xpEDQl5SazYRrBl3zEXsEeFYn+Ua9gbB9Gqm6Y9SV1ZJ4WyOG6X/brshDh4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by VI1PR04MB6830.eurprd04.prod.outlook.com (2603:10a6:803:132::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 09:01:18 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 09:01:18 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 2/6] client/main: Add broadcast source discovery
Date:   Wed, 12 Jul 2023 11:58:56 +0300
Message-Id: <20230712085900.5423-3-claudia.rosu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|VI1PR04MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 4572a259-4ee8-41b9-c73c-08db82b68e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnaK5KbdVeHduqRArEe32Q0MzM4vunMNrnb1cEibtzPIl9qpE5ig0EBBHhjoYZ7xQOiFTbQio0G6lbeWAWKa6mVaig09lDWx7jZyl68mCdnzKjdXK9PhmOmW6CGPIcG470LA790Lj5qxFqsRW3Q7MbxWoLCod1DWn5viUnpCl1OB+l+3eycGngPIax2xmhzFkp5jkji3QtpGnppyU4GZI37CVn0CoiBqefFXFDYLvxndlPoKlhnnw9qAo0rSBQYyLFKzg3evy82FK8Cp7IYLQq/9ptYC9O4W5VHkkJLSZ6m9PfsafXk92ZEevzuP4S7KXwJqUXvKBEJTcUGMbNrPNsxNFLtTh8OWnUnCkUY0iwe8umJxYZenFkX4fNxyqDcFa9u07RGOj6ck/vXmhrUt3HTwhZatF0h5/8hsecdBKF2lXsN/5kTYeG735eOIjZrqvjrikwVDovDBO/+kBN7SGcyG0BABxSqIQtktS7AlK/QDT7NT7Tjm6OQuoog7vx3BhUQGwkioQBSnPFU3J+xagEds/LafvqCwkoTy8IAvMpUmOir1yIfWeydIPY3hLdv14cxsps824Z/EDdxUHqfZm//yE7AnboK3QnzoPGD9bddj0LetncSWO7kCG6hX4zr8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(38350700002)(86362001)(38100700002)(36756003)(6666004)(6486002)(52116002)(55236004)(26005)(6506007)(1076003)(186003)(6512007)(478600001)(2616005)(2906002)(316002)(5660300002)(66556008)(66946007)(6916009)(66476007)(8936002)(8676002)(83380400001)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wSE+R/4iTY0CLLDBny8A4RN2WmmujN3pqhUWCDAXQ4IYVdhg2g96kWvj3s4l?=
 =?us-ascii?Q?Xx4kuXYS+1W5nSYRdXrJX/JOjqCdVMtMIg2q+dh7l6JadxaZu6vGCSP5GAXa?=
 =?us-ascii?Q?0XVVuE2WWALux2My/2tiwFiKAK+y0DPWM2up4clTwSjixAy2OWHSd2F+/v7S?=
 =?us-ascii?Q?2EktZfcZuSNosRYU8oRhDG8paqfmTlKrm87FmC2FsF3guSY9weumunRLcptI?=
 =?us-ascii?Q?A86hFWWDAac+q7fvYxq+l0THVJay9ODUqg0FaYEz2vowApPq04vkiBR4AfiR?=
 =?us-ascii?Q?kYcq/3cMEI8/VoCA2EGDUt15yK15h92iHvO4G1DzDeeVVQIEuXLaG97hxhRp?=
 =?us-ascii?Q?dB4vGeauBbzYzkjuLNHnSE7mG5PLDkkkhu/vuJFtq+syhggX58bDQlxWH8nJ?=
 =?us-ascii?Q?/vZOuofJvg5XqGjGDBexxD2RJMtDRzkgoCNmQlp6LXJ/xkpNrxM2jSX0ujEn?=
 =?us-ascii?Q?pylN3a9L7E/7ZpPtZW4UwNg2WEFuDCCC6FEnu0vTetdDU7YGC4QxBTe72lfE?=
 =?us-ascii?Q?ia3qeJvzc8ZjXKH4i6jOeYM3nfXXAzdXQdVYUNvhfcVwhYQXskumwdv7nf8Q?=
 =?us-ascii?Q?AT6vWW308VexBMn0IQTS/Z4Bu0wUZDp2g62j8uTuNCbYzDVIv5RZ5ZrQpkQA?=
 =?us-ascii?Q?2zbYfSMcVemhX1VGM6q56w3oupX3p2P/1L97Kyhvq6fy6IS+gELlbxLUoH8C?=
 =?us-ascii?Q?F+23zfRNFkgJmeu7cmEa65JuSImR8feWk0BHIpRtYB9qOnI8Ocjnm1KSSjn+?=
 =?us-ascii?Q?xQPcf+78UtQduQzUcff76t25fC9eKX2YW7qU2jJ+ofc12niUneggIglzwcm3?=
 =?us-ascii?Q?RH//KBBrnoBWzduTRz3gcus9xKd2ubj9jEyZmpyLQp9MUPcXWWnOO3MOPeUE?=
 =?us-ascii?Q?KU/yxq+Jp2MCtUZ00Fr5yLpuGrXj2HKnv/k/XOF4kR7+FkTbSdtwT5cmWxYO?=
 =?us-ascii?Q?DkoWRZPpT3bq/X3+6kklrfLLQL/OgdQybBYS9du/PCKvGYWY4rzN1tds/TAs?=
 =?us-ascii?Q?l8rNHjZds56yAU4lSQASGL0Bh93kDs8yQOHpEEbVOs80pqZyeXNFXxDRQjBQ?=
 =?us-ascii?Q?C/jjUY1fI4lskFdg3UxLvlMHQUme1IOGm7uL7icfY030PcVTj/3hYXv/nxmR?=
 =?us-ascii?Q?RrhY5f6X9yViQmLAqLZl0wbTsND3BTwmdFsItvAgcqYjnRr+KV/5r600TnIv?=
 =?us-ascii?Q?Vi8MrNyfECn2e6/p07A2HK5IuOLBqpo4PvMUO6g5xdxU8BddXpOnDKiEp5hV?=
 =?us-ascii?Q?p2wuK3wqau75uA+WbBX3837fMC5zKm9z5YKRzpTLE4QxQ1h7O14NGXmBjCXX?=
 =?us-ascii?Q?NpSBUAb4bjO9bat+CiC7mjTsPB9BdVLS/JHGHG56AeQCiIb0poqyj8pAyl7B?=
 =?us-ascii?Q?del72W8S90ANbdJ+35eQal8PYHq+DbJKvEj1Is7NqG+fDdD1C9OTIH//JHkt?=
 =?us-ascii?Q?SQltT8JrvapYxhUFMdHFZjjLUKvTD5wbR9dgnK8gUfuU6SG26ckqmu3EvKE9?=
 =?us-ascii?Q?MqAFPRae5+a1DLqmYvLD4F9NYJgJioWxq/RV5xvmDtotklexN6/OZZ5xf7bz?=
 =?us-ascii?Q?YgsBKqGb+FGnLk/wLE/GyVXK8R93ZisGUHe2Lh3E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4572a259-4ee8-41b9-c73c-08db82b68e15
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:01:18.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAdnxxIrkvT1qBfFpbxLfaCDJokIyMNZBe+aqcZJMZv2wiYtrQcv5+sBC28gCmkYoCsTfJzGq/jD+AmyPFl2fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6830
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

