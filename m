Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9D0EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 12:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjGLMXx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 08:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjGLMXw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 08:23:52 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619AE134
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 05:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXB+tCf8uqog0S+NJEuC2ZlzoO3N1QytL0VB4KdUR+aoe4xevPt2EKmrqhEbqKmTiNoujvYxWIp1yUuxI669F0UdJUd0AkTKMuAV/VA4lUtNNLLrU6a/7VBRKDbJc4cZ4ztV7fYYmwCvsvwNQXCTreWnMG2igm9/Xcr59yyv1IhFDW1lAkyerQ1/UFTIWXW+R7jcupYLxqc84nccdBJnWXph23PUrM0QyeT3U5UPNWyGHxK+TFgpA1gljmOXDrzjqggTOQkSngFpbfPrvmcI9ihItcIjaNfjNWV8BgkQfgP6fBlXj5lhBmR6Dtvwk1/XxiX/uQBDcU/1sVfofIx81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIYCGA4vTKlT73QdH4yyyNetbnOjjwag1DyqYXZk2CQ=;
 b=HRNPBbvMvEass4jVJ93qq6ghz+gH8A+bX6JAu8VeCM+4y6/43Oe4+KIAln9sfJzIZzAyz9BKBalsSqt/z64h+n3wPdwWZg1XQ3iR4vgTVN+W6mKgsSfN7YeJQHJSWOeNRMcTNSLUhRqmxt1dw3iRgfmzPMfjIBJZUY0j4fRu+kyVY7tgOZD2Ahea3Guza3t/my+f4Vppufd3amBJr7/BSnWTDyTd5bZ0ifgrKE0rT91WK1ZAsds6tnXS9gLG1W9ym+JKL/ofv90YG9j1O2eRbjHedJBXiKHS6/PKXC08wkXWCEStp8lv+7Ynt4Hld4jCF9rNHJWTOiL3yjJ3YeLSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIYCGA4vTKlT73QdH4yyyNetbnOjjwag1DyqYXZk2CQ=;
 b=rs4EHB74gGev/VMie6iKJsd7FgadLhVTPBM2WlimOtOilM1eNrLzWhGIZbGSMAGI83eE44qDuoaLMfG5jBpsc6w4J+dGUoJ8sMAcC9S0lNWxfLmpm2h5c6DBm0pN6sV4BJLd9HeCvLM3CjKLGqDmFR5xUhZjrdrXgVIUVhwKBSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by GVXPR04MB9877.eurprd04.prod.outlook.com (2603:10a6:150:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 12:23:45 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 12:23:45 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v2 1/6] client/main: Add broadcast source discovery
Date:   Wed, 12 Jul 2023 15:21:30 +0300
Message-Id: <20230712122135.7734-2-claudia.rosu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|GVXPR04MB9877:EE_
X-MS-Office365-Filtering-Correlation-Id: 396c2d05-805b-4c13-e3bf-08db82d2d5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EkbFs/wKXgsxc19jOwbrTp5iTb7C4L9dVfIT2x9dqjFhsCHoyxqDYFEVOTMO6YvoAGe/H+44CwIs6nziWetxHISsGXrCEoS8COLP6jTLdR145SC0HD08qTuCoHq/bcMryQyfvLgiolwVGe8qt/8B3js6zmBvbi24pcdy97802gqVRxtFkv+HxaVfDz4rqR1+jfUz2AonkZX4zg3qNArLIgHKOnqQEh3lk0RL7sdrHaAvF8Gb4bP2VABrJwx00SEDF+2JuVYk//0d7spiOTQtqxh/niaixbRFeJVtPXl9iDcGRNFGW344vCwDsHquiamTvS1lVX/1klD9kUZ04B4Ze9m9m6QYqlMWiTBPAsWCRs5aNi9uU+RjAFTxUbpNhlf1vjKxYGHobFr076nR1Zrr0lVCWF238fHFjKvmajRgbuaku4IqyZ3Y0PpTO0hfUr4wwOIMgeIJpjA/qPJi7rnvt1Qoykmu1eUvTcowE0Ir4AZKyFKbzdxPKZ6yAbwajXHuk7/+1Q7WbAQL3lwKzjvFtRzaYtDAldGzi7go/C4+Vwc9ftnOVvS5BLfmQOcFquu3ENiId4R685eyTFx4hH4qcNkY6lLBsZkUTAV8o+bvzR3DglIgauoxUB6qW3Mq+oE+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(478600001)(52116002)(6666004)(6486002)(6506007)(1076003)(26005)(55236004)(6512007)(186003)(66946007)(2906002)(316002)(41300700001)(6916009)(66556008)(4326008)(66476007)(8676002)(38350700002)(8936002)(5660300002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0EOEz+3XlStSCBUx6QzeXJFEbYLAWsSBGuFUrfX8og5gknrOf8VYeffqLG8X?=
 =?us-ascii?Q?ubsWM6R2IhUIL3a1Hewpw3sYCRKzjKFDDa+3G6zgoJkC6NaHJo+m1otVh5cQ?=
 =?us-ascii?Q?IyjOdWwi+dmNHorHTcZ6Qliu/snULSgDfBzR7Tddg5kxg4UkT5QL0RnbjyTx?=
 =?us-ascii?Q?ipHqYOViM9j0lAGrczms+4s+H1opYznlVqmkr4EXUM6D4zBDvjytVkv3nl9I?=
 =?us-ascii?Q?9Ia5WXRNqot2KmeLYlrZFYq64SS944Fd7sQe5Eb5kRuIk4kxYdgbpvvdrz25?=
 =?us-ascii?Q?x97MxEju0PlfK0vWZa0B7s5g79SiYFYeLZ04eX5m+UT0FDTmJKjrG2OEkc46?=
 =?us-ascii?Q?ZGP57fey5AxqVZtISYzObC1IHkLYUhdU23xc/lOLlqVs8Q8of34NqLncfmkv?=
 =?us-ascii?Q?YwpGV4RjJuK8RgAvqDBbAKBYXXVtsoiFNhBKH3qmlrfQpqWqg85kd1Owo7oJ?=
 =?us-ascii?Q?pZCl+SiX5fyGIDu1GAXRfgoqUVU56+h9uPZb5EmNkPXsOSbGrbhTHZhvFKXr?=
 =?us-ascii?Q?6eHgA0xmMZjOVuXKmxUGqH9Tt7dS76y1kwV+XT2puwuNAW4lUJtTlV1yN7hc?=
 =?us-ascii?Q?U7ntQ30yu/TrS0idkZdXa36XGddWdYyZ9FCjsbvzZPKeN7QdyC6QWJllMAv6?=
 =?us-ascii?Q?OiIYvUKgmdLLnkUp8Ll/Y+AUdmzEHq32CB0Oh5v8dwy08zTuwHyax4z/3UkN?=
 =?us-ascii?Q?wrLJ0RvPjvOLiJxU8UTnaSzMAEke+s6O38W1Vtf6XEcQ/aXqHJWnzDRV0xBj?=
 =?us-ascii?Q?DG6a/96Y1HogoCWG6Y0inDjCAyYbIv+0j3Hsn/fRsNHk8p7z8Pm1mcWe1TIk?=
 =?us-ascii?Q?e9+Ogza8Uv7rXLa9fyTkvhGirKCLNQ02wGi9fmGpHOlUdBIvudUvrvvfUrD2?=
 =?us-ascii?Q?6MxJsY0bl9y8//uMrWVbbRPjRRKERbFydp7esHw+BBJEmZ3FBT0ch9uwh139?=
 =?us-ascii?Q?2AO1Q1wKYT3Xliao7P4Qy5ICuu5KlFZdRwV5OO59BvlCLbfJSu9IPe++edha?=
 =?us-ascii?Q?Lqm1JCjv4Lh5RG004OBL8ordYT0STZYO2w+kl/77r6/z56EzlnJLA0wRrnlE?=
 =?us-ascii?Q?bsodKKvb2ipYB4rAlnu1kLqEQNpA7Ar1KcMqnUC8CUN1MvsWg7dBMNcQillI?=
 =?us-ascii?Q?j9NnnS5fTZHRyC9uKGJFFN+CsubWx76VKSl2kfJGzZyJbysHcc9/GxbhyS4+?=
 =?us-ascii?Q?4osKCNb9y5AFKPdnQ9lLCUwTpjOIikRsqmdLtlvp4QF1V9RjrC2Kvga14rX9?=
 =?us-ascii?Q?MJEntqo3Wx+mefmAM9xh/3BGSkc16W6dYpnGWocqKb4Wr1JGObw+Xv50PBHn?=
 =?us-ascii?Q?4EtQ4CKNqvGBud0syABt2V+MV+Cq/+J3oFphQneTSNw0qEsz0c+eRGQla8Ho?=
 =?us-ascii?Q?FAk/uM4a6aQNKt8tLeFFY2cRyY4msOWFaTbX99bGgIqVsU7qN7hcIP7YhDvM?=
 =?us-ascii?Q?ob5fOkKtdnhtBlLUWq+sRqBxNczwmHXPmcv4UVwwmv4m5DTSFzLWJKxnWf/x?=
 =?us-ascii?Q?A2bajhevKuwkimGrCDnUIpYxxbW+gN2GG+f1jNKdqKOGxXgKiieX8JlpaEJ0?=
 =?us-ascii?Q?iMfwROsEJCjSsnVMFHcBeeFtMd4J5ziu3it8NbiEPdvkmuzs0EntYKC4ZrL/?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396c2d05-805b-4c13-e3bf-08db82d2d5fe
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:23:44.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2Tmlbt94unSqKUFtEPzwMbPfRWUHBcGUd6Mb9HP0NRKx3eg452kH4o0f8+7ufYYImRRCqmhDpdGcABBX77IPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9877
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

