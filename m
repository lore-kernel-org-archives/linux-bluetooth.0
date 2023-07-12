Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD54EEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 09:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjGLJDc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 05:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGLJCk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 05:02:40 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91748E65
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 02:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDaDNHJ6n5araAgLmtbXlHlWoPr+YMqswpQP2EUO6N2BdZCVcNqHRtADQNbwuVM3gyLnmVONzh6xQIa9bfJa1xf5d6S5GUYf81xXCrCq/ZKexkI6r+ByAw0ZYahv9HI85MQLXzXs0hLU5m3KZuYsZs24BDBH3IHtrZ9sFkO+uibXXR1z2ktPmiN6AVNgNDjsRXkTRkKdpeD9JQDRxABNJiyTjtrarpGWTRH/QoQT3wmrXBVXECC6n3lCUdiAHb4KptWqkfNh6y4VCFbmkGGChsy6/Vs+m6vpsMlhUbXeWB23REueNLqoAPEcxEtNiQSAtlQq9mVEqSmglw9UTqsbdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIYCGA4vTKlT73QdH4yyyNetbnOjjwag1DyqYXZk2CQ=;
 b=atqHmrGPZsGILtYp5Rtp+HwaXoXC66kPVJ/uPPwb2M++xUBBBu2w/CHxfvs4vs3XUG5trCOBQENiYGXhQJBmQYlMtVkdeYSxf4rA/Fo7aPDmCAWdORH/fLHi9XccxOyE9UeQXL1FWhsholz86pDl4hR8SjXu6f2LK5xgw+LFsDb15E/SikDD2WGFJ9HlFzucw10+7ThWu+W86D9ukjktQCADcqZIBh94O7uVtzA795rrJhm6vUXpsa0RyMZ2YMvMDI9WA+9bLmNBH5bqys00XpktaNguQoNlurfQQUKnyV7ofj2POPuxrxTnofME0hmWYQlLGNjaZH7XAPh+ZQCrBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIYCGA4vTKlT73QdH4yyyNetbnOjjwag1DyqYXZk2CQ=;
 b=sRjqLYKo2wadMj7wC/Mz9krJju/rBVUBQsQURYZeAjZvDEfx/3GQ3Fagbm5hO38cjj3t/AKYQQ2BFlTC41AArMlpPgSeT2dZoJ+KdY6bcCunAXd6hVY1j25+OTaMpvcicvuBLdBLZAYqWeVa8kDVBRPcHUtPlvzrHOHfYvGR6GI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PAXPR04MB8525.eurprd04.prod.outlook.com (2603:10a6:102:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 12 Jul
 2023 09:01:16 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 09:01:16 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 1/6] client/player: Add broadcast sink endpoint registration and configuration.
Date:   Wed, 12 Jul 2023 11:58:55 +0300
Message-Id: <20230712085900.5423-2-claudia.rosu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 457b96d9-6941-4f3c-4c9c-08db82b68ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c1WlKtm5oGZw55LUhoWBDa5tTl+OIZMrv55wlrRhmGDXs+qIp0/Wf7OFdn7QJq+efmPHPOexkXrLYUyiexDH8xVC0bI7ssJQz3G2w6hwPDemoahvLZOJ3uWRqK5GZLbwpgCaYEdNLTlv9hnKI70GD50xhM0v4D6/DAKFoeTLOe00bPWRgCC1ightncwfjmQ1utboxk+t+wGX8NMdAJ+BZXUisXid8b2gYnSqAZeeu6WdV419BDdBWY21x3HZFxm+3kMBw4vzTprW/WLbC6kwSvw4QQpwtDlgd9E0PERHLac1DqIGLM3LPEhsQzvthO01/lCW0xje4OG+YYheU9h2iSq369+GpR9EpiJ9iWyiKWuh1IpCllpMrBeSXar4K9ml3Nyxwa3QKutL4m5etYBLMZJxty+Tuh5VUfWGQtGPYjhlC73qbgqkjV7MV2y+Z0gXKz+1HXv0fQjoTpJ05VF3tRyL28HNUX12rr43HhNJFIiOBcr5Lqt5/+H02aM5tW/4/X6HvKrOB6E3eECv4Ryu9i7PKbheLmO1xWTSnQyjp3rYCbE5b9ftdVzd7suScxbYt8bvr5phEb6ABfvcHRYkGv2b+C1eSBzyAqZ4Q+Lr3llUZFv6grCWyQ54N+RMoSO9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(55236004)(83380400001)(2616005)(2906002)(36756003)(86362001)(38350700002)(38100700002)(41300700001)(4326008)(52116002)(6916009)(6512007)(316002)(6486002)(5660300002)(8676002)(8936002)(478600001)(66946007)(66476007)(6666004)(66556008)(186003)(26005)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JBu9aZmpS+ZBblnborzHq8Cj4c5wf+Juv4EcJlwrAqpmK3XenbeRWmTnc1uL?=
 =?us-ascii?Q?2kA0k0wFMjb0HkxhEy23vS9aShHjEBAJBwxXamKme+8YcHsgscJXFKtrs9nw?=
 =?us-ascii?Q?4rH4tOqG4z66K6BETASr3EDkIrz4fwekO7E28p2KRcdAp+ynq1I6PU/d11ex?=
 =?us-ascii?Q?61edHkkrQphibNzzYAVOrtUNCWRaIl5ILYM0gF4zHR6f8QLwpdGncs7q6yjZ?=
 =?us-ascii?Q?JbAkDvwCsuLNyJY+x+4JpI093vPgYxDwsdS3jYhPX93U9IvVHzac1pSgRtaJ?=
 =?us-ascii?Q?ygWxFDgFOlzUM1ecATmKcpl/6GKmuO/0XOVv6hGIxSOnmzukXyv6NeruYgdg?=
 =?us-ascii?Q?gBMK+KF4aEXjdxZEstSp6BOj1ogMezpD887A8bGwTH1Q2AUj/+GYlaMWHgdp?=
 =?us-ascii?Q?wOSf5So/xB5bY9iqX1BujxXRirD6F/GEoYFTuVgTnyBAV0YiVtCJAnuh2qRY?=
 =?us-ascii?Q?fwpuMZK/qXeCG7oBpvgTPkoWyGjh99KN5BkzCIR49ChhHTUMiL9hl/qKch3z?=
 =?us-ascii?Q?B8zculpQHwYNDvCdEjTzeEtIZQSKMazdY2dcYtOud7wUp4waDf1rDH7qzmd0?=
 =?us-ascii?Q?MbuN81AHrzKlaWoW2jG6u7SEVGmKg9mXyHiBQzbOqrc4vI10/iFpzNdaNUUm?=
 =?us-ascii?Q?8WrA9SWlT32ClgOqO3/IfHWua+qOdgTOe0EfesiS50y229hZar5umCJPzINC?=
 =?us-ascii?Q?4kFeuVB81A3+hwtqZlerKVV7MHkDOMn99KVzHYUStJIwv12x2Zfx7i0Y2Iv+?=
 =?us-ascii?Q?Q8VTkKKRWS78pHEE1wvhJJWy9Dv4kSGUmQ6a0VVvutYNsGqfkTy6GW1JvETQ?=
 =?us-ascii?Q?PNm6jmuk+FufQkt2K+ovUpaVDRBECwFayT8FH0HMcN7g4ANTfUB49cI7y7jz?=
 =?us-ascii?Q?X08BHafxshk+l37okHwYpidDVxzOy6a7LYzMOt/brr+fp+wTh5jDQe6baxzT?=
 =?us-ascii?Q?vsJUKf2XZghkyI92xpQ7O1jopvP3MXIwbD734DIj0MIWd7DFF6kI2B4zTTzK?=
 =?us-ascii?Q?4APoppkY3Pfmtioj2ETJNZbQVzhgU+coY/3Q501zWpgPZ4pnYwSQAx5YYzu+?=
 =?us-ascii?Q?1AlCDrLix80D0Vb/8ek76gQ7nIs7iAJ5aBduPiEh2AIyANX/vCsKgZQ3/vX7?=
 =?us-ascii?Q?iR40neI517lwM2VNs4mhcGZtTp6HjWlBC4Wei74gXx6zIzTDzz4NTj/+Ce14?=
 =?us-ascii?Q?iyf90k+1zBCThgWnqQj/2B8uKAknABuwVyyH7kcPfoxVRqoV222sl63AFCaJ?=
 =?us-ascii?Q?eHvgfkvkohd2PCXTJXxMC6A1eQx0fzoEt7sQ7Ewb0J5h+djwcYSLBDSSLvVa?=
 =?us-ascii?Q?oN1jRjl+/PuWxU6BG+tXzb8zmAnPE+yeC2evLtSxUNWj7ZPgfzuHGo7Va36f?=
 =?us-ascii?Q?i3GFCqbwyWzqjWUkn1txCzreXyv+uuys58SCkYKmsVPQuyIj/1NHiBcmFP2x?=
 =?us-ascii?Q?+r5pgMG8Vel22DphK3KjQK96q1ZgFpdxWO2XvkG+fkYM1SQGFso7pDaRWSU6?=
 =?us-ascii?Q?JJi0nTrqthb8zSs1X9ZE/WLdHZKdx+ENpWlndy6b7g34nVJCMpP0k6aqmdXn?=
 =?us-ascii?Q?+9fN/jfHBKGqroeZSVpZGt5Bv0qSPdw1640QjPg+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457b96d9-6941-4f3c-4c9c-08db82b68ca4
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:01:15.9687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfi3kIsrv672Hm1aGuVWbcwMH6JiZjR6iLWQhWPoDiFTbg6EIGWkBYU7Hn8rY7y94TtvCjnbGeUqwaH19I8Xog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8525
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Added support for broadcast sink registration using the UUID for PAC sink.
Added support for broadcast source discovery.
Added in the endpoint configuration command a new parameter for
source address that triggers source synchronization and
stream configuration.
To test this feature use the following commands:

[bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] unicast/broadcast (u/b): b
[/local/endpoint/ep0] BIG (auto/value): a
[/local/endpoint/ep0] BIS (auto/value): a

[bluetooth]# scan on
NOTE! in the list of scanned devices, the broadcast source will be
printed in green.
[bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0 
/local/endpoint/ep0 16_2_1 <source_address>

---
 client/player.c | 187 +++++++++++++++++++++++++++++++++++++++++++++---
 client/player.h |   3 +
 2 files changed, 181 insertions(+), 9 deletions(-)

diff --git a/client/player.c b/client/player.c
index e5084967a..fd2c89f0b 100644
--- a/client/player.c
+++ b/client/player.c
@@ -81,6 +81,7 @@ struct endpoint {
 	struct preset *preset;
 	bool broadcast;
 	struct iovec *bcode;
+	struct queue *bcast_sources;
 };
 
 static DBusConnection *dbus_conn;
@@ -94,6 +95,11 @@ static GList *local_endpoints = NULL;
 static GList *transports = NULL;
 static struct queue *ios = NULL;
 
+struct bcast_source {
+	GDBusProxy *proxy;
+	uint32_t bcast_id;
+};
+
 struct transport {
 	GDBusProxy *proxy;
 	int sk;
@@ -2285,6 +2291,9 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
 		bt_shell_hexdump(ep->meta->iov_base, ep->meta->iov_len);
 	}
 
+	g_dbus_dict_append_entry(&dict, "Broadcast", DBUS_TYPE_BOOLEAN,
+				&ep->broadcast);
+
 	dbus_message_iter_close_container(iter, &dict);
 }
 
@@ -2424,6 +2433,28 @@ static void endpoint_iso_group(const char *input, void *user_data)
 			endpoint_iso_stream, ep);
 }
 
+static void endpoint_iso_mode(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+
+	if (!strcasecmp(input, "u") || !strcasecmp(input, "unicast")) {
+		ep->broadcast = false;
+	} else if (!strcasecmp(input, "b") || !strcasecmp(input, "broadcast")) {
+		ep->broadcast = true;
+		ep->bcast_sources = queue_new();
+	} else {
+		bt_shell_printf("Invalid input for Auto Accept\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!ep->broadcast)
+		bt_shell_prompt_input(ep->path, "CIG (auto/value):",
+						endpoint_iso_group, ep);
+	else
+		bt_shell_prompt_input(ep->path, "BIG (auto/value):",
+						endpoint_iso_group, ep);
+}
+
 static void endpoint_max_transports(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
@@ -2445,7 +2476,10 @@ static void endpoint_max_transports(const char *input, void *user_data)
 
 	if (ep->broadcast)
 		bt_shell_prompt_input(ep->path, "BIG (auto/value):",
-			endpoint_iso_group, ep);
+					endpoint_iso_group, ep);
+	else if (!strcmp(ep->uuid, PAC_SINK_UUID))
+		bt_shell_prompt_input(ep->path, "unicast/broadcast (u/b):",
+					endpoint_iso_mode, ep);
 	else
 		bt_shell_prompt_input(ep->path, "CIG (auto/value):",
 			endpoint_iso_group, ep);
@@ -2472,13 +2506,6 @@ static void endpoint_auto_accept(const char *input, void *user_data)
 		bt_shell_printf("Invalid input for Auto Accept\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
-
-	if (ep->broadcast)
-		bt_shell_prompt_input(ep->path, "BIG (auto/value):",
-					endpoint_iso_group, ep);
-	else
-		bt_shell_prompt_input(ep->path, "CIG (auto/value):",
-					endpoint_iso_group, ep);
 }
 
 static void endpoint_set_metadata(const char *input, void *user_data)
@@ -2714,6 +2741,103 @@ static void endpoint_set_config(struct endpoint_config *cfg)
 	}
 }
 
+static void sink_create_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to create broadcast sink: %s\n",
+					error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+struct bcast_sink {
+		uint8_t		bc_sid;
+		uint8_t		bc_num_bis;
+} bcast_sink = {
+		.bc_sid = 1,
+		.bc_num_bis = 1,
+};
+
+static bool match_bcast_source_by_address(
+			const void *data, const void *match_data)
+{
+	const struct bcast_source *source = data;
+	const char *addr = match_data;
+	char *source_addr;
+	DBusMessageIter iter;
+
+	if (!g_dbus_proxy_get_property(source->proxy, "Address", &iter))
+		return false;
+
+	dbus_message_iter_get_basic(&iter, &source_addr);
+
+	if (!strcasecmp(addr, source_addr))
+		return true;
+
+	return false;
+}
+static void sink_create_setup(DBusMessageIter *iter, void *user_data)
+{
+	struct bcast_source *bcast_source = user_data;
+	DBusMessageIter dict, source_iter;
+	const char *source_type, *source_address;
+
+	g_dbus_proxy_get_property(bcast_source->proxy, "Address", &source_iter);
+
+	dbus_message_iter_get_basic(&source_iter, &source_address);
+
+	g_dbus_proxy_get_property(bcast_source->proxy, "AddressType",
+					&source_iter);
+
+	dbus_message_iter_get_basic(&source_iter, &source_type);
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+
+	g_dbus_dict_append_entry(&dict, "SourceAddress", DBUS_TYPE_STRING,
+					&source_address);
+
+	g_dbus_dict_append_entry(&dict, "SourceAddressType", DBUS_TYPE_STRING,
+					&source_type);
+
+	g_dbus_dict_append_entry(&dict, "BIS", DBUS_TYPE_BYTE,
+					&bcast_sink.bc_sid);
+
+	g_dbus_dict_append_entry(&dict, "NumBis", DBUS_TYPE_BYTE,
+					&bcast_sink.bc_num_bis);
+
+	g_dbus_dict_append_entry(&dict, "BcastID", DBUS_TYPE_UINT32,
+					&bcast_source->bcast_id);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+static void endpoint_bcast_sink_sync(struct endpoint_config *cfg, char *source)
+{
+	struct bcast_source *bcast_source = NULL;
+
+	bcast_source = queue_find(cfg->ep->bcast_sources,
+					match_bcast_source_by_address, source);
+
+	if (!bcast_source) {
+		bt_shell_printf("Source not found\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+
+	if (g_dbus_proxy_method_call(cfg->proxy, "BcastSinkCreate",
+			sink_create_setup, sink_create_reply,
+			bcast_source, NULL) == FALSE) {
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void endpoint_config(const char *input, void *user_data)
 {
 	struct endpoint_config *cfg = user_data;
@@ -2771,6 +2895,10 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		cfg->qos = &preset->qos;
 
 		endpoint_set_config(cfg);
+
+		if (argv[4])
+			endpoint_bcast_sink_sync(cfg, argv[4]);
+
 		return;
 	}
 
@@ -3172,7 +3300,7 @@ static const struct bt_shell_menu endpoint_menu = {
 	{ "unregister",   "<UUID/object>", cmd_unregister_endpoint,
 						"Register Endpoint",
 						local_endpoint_generator },
-	{ "config",       "<endpoint> <local endpoint> [preset]",
+	{ "config",       "<endpoint> <local endpoint> [preset] [source]",
 						cmd_config_endpoint,
 						"Configure Endpoint",
 						endpoint_generator },
@@ -4238,3 +4366,44 @@ void player_remove_submenu(void)
 	g_dbus_client_unref(client);
 	queue_destroy(ios, transport_free);
 }
+
+void player_add_bcast_source(GDBusProxy *proxy, uint8_t *service_data, int len)
+{
+	GList *l;
+
+	for (l = local_endpoints; l; l = g_list_next(l)) {
+		struct endpoint *ep = l->data;
+
+		if (ep->broadcast && ep->bcast_sources) {
+			struct bcast_source *bcast_source =
+				new0(struct bcast_source, 1);
+
+			bcast_source->proxy = proxy;
+			bcast_source->bcast_id = get_le24(service_data);
+			queue_push_tail(ep->bcast_sources, bcast_source);
+		}
+	}
+
+}
+static bool match_bcast_source_by_proxy(const void *data,
+			const void *user_data)
+{
+	const struct bcast_source *bcast_source = data;
+
+	if (bcast_source->proxy == user_data)
+		return true;
+
+	return false;
+}
+void player_remove_bcast_source(GDBusProxy *proxy)
+{
+	GList *l;
+
+	for (l = local_endpoints; l; l = g_list_next(l)) {
+		struct endpoint *ep = l->data;
+
+		if (ep->broadcast && ep->bcast_sources)
+			queue_remove_if(ep->bcast_sources,
+				match_bcast_source_by_proxy, proxy);
+	}
+}
diff --git a/client/player.h b/client/player.h
index e7778cb1e..21e73e8ed 100644
--- a/client/player.h
+++ b/client/player.h
@@ -10,3 +10,6 @@
 
 void player_add_submenu(void);
 void player_remove_submenu(void);
+void player_add_bcast_source(GDBusProxy *proxy,
+		uint8_t *service_data, int len);
+void player_remove_bcast_source(GDBusProxy *proxy);
-- 
2.34.1

