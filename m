Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A5FC004D4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 23:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjASX6T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjASX6Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Jan 2023 18:58:16 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E85A1036
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:07 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v23so3894688plo.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgnGtpNAPZHuXGRbi4LSJ+gCQPr1Lk1i650kyfeNFJM=;
        b=OWvlM4Eln4aCnp157qJ4H9MF8u17D3nDmo+rp4fmHws5vLwO7Ov4wLiBPL2zsuNOJt
         dELzGrjtmMTrfpFE/FplZd0ZFY/w8VhUkMkE/QUV1Gpyrlk0F8G0FjWZnmzt1ELLNEpk
         RE+3q3MpSlYjqHfjzacHiH9bFjRpGg/fpguMO6BrqZz4uH00w+uQsCvdOUh1rEfPcvBV
         XlHCIJ4SShBKK25W99pVnGyjB9RUPgzo1RFQK4w4LQOHcjM+3kI2pOztY1uwRBAKlG9D
         a/eUBH1+JYm4X/8wQ8kwof/FiUwJjx/RN+yiP0CA6qRPoQtHJlEZeOopGdASxjrkOds5
         Lmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgnGtpNAPZHuXGRbi4LSJ+gCQPr1Lk1i650kyfeNFJM=;
        b=E1rfcYE7YLZ1AaxemTolXAWQsZFhOFTzFjSnbkDJeVJEB6ICmDj8IuOGdPJCu3a0G/
         nVLK3aYtXdMzmwfGaTTwUyenzZ7ekSQMtWlTTY0qMeDq3moDV8zF38YKqKHyFwGz/scN
         b5mKw25tFozxg+LwtaPbzZ80lupBezmNImAI2hL6g58kHN9SSZ4VcRZYGx3I0/gZcyku
         hHs0WYmTMbXf17f7UuqNUsVZ0XXsMtx9JSSeNi9GzyGVNHqE0xRu1P0L9DO89kPk8B6j
         fbl1yiMAdkn1APsi/CjasmWsno85bLvq2FndrKowdpaRWPAKzrAV2ZLBeAPY3Oth7NsW
         7oJQ==
X-Gm-Message-State: AFqh2koOwtFey1riuMHZa2fGjeTQfdzPMMXExC6uHJ5XoZ2m+JFbnM8E
        G69ulRi19XW0QEqRD8aK52CPTHsF8Gdhnw==
X-Google-Smtp-Source: AMrXdXv8y48+5Ylu3DemfXK4JBsRaqqugafBZ/p4eIfe3wVaAesxfbvPrN+7wFcp2Y+eJ9rx8FQX/w==
X-Received: by 2002:a17:902:eac5:b0:192:cd8a:f358 with SMTP id p5-20020a170902eac500b00192cd8af358mr13089540pld.69.1674172686364;
        Thu, 19 Jan 2023 15:58:06 -0800 (PST)
Received: from fedora.. (97-113-173-242.tukw.qwest.net. [97.113.173.242])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b0019460c34839sm14826373plc.185.2023.01.19.15.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:05 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 03/12] tools/mesh: Optimize for multiple RPR servers and NPPI
Date:   Thu, 19 Jan 2023 15:57:46 -0800
Message-Id: <20230119235755.46002-4-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235755.46002-1-brian.gix@gmail.com>
References: <20230119235755.46002-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

These changes allow the mesh-cfgclient tool to request remote node
compositions from page 128. Depending on the differences between
there and what is stored in the local configuration database, it may
recomend reprovisioning with NPPI-1 (Address Refresh) or NPPI-2
(Composition Refresh).

Additionally, NPPI-0 may be performed to refresh the Device Key only.
---
 tools/mesh-cfgclient.c | 479 ++++++++++++++++++++++++++++++++++-------
 tools/mesh/cfgcli.c    |  37 +++-
 tools/mesh/mesh-db.c   |  36 +++-
 tools/mesh/mesh-db.h   |   1 +
 tools/mesh/remote.c    | 122 +++++++++++
 tools/mesh/remote.h    |   9 +
 6 files changed, 598 insertions(+), 86 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 237afbb5f..f3e9af8fb 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -43,6 +43,7 @@
 
 #define CFG_SRV_MODEL	0x0000
 #define CFG_CLI_MODEL	0x0001
+#define RPR_SVR_MODEL	0xFFFF0004
 
 #define UNPROV_SCAN_MAX_SECS	300
 
@@ -83,8 +84,12 @@ struct meshcfg_node {
 
 struct unprov_device {
 	time_t last_seen;
-	int16_t rssi;
+	int id;
+	uint32_t uri_hash;
 	uint8_t uuid[16];
+	int16_t rssi;
+	uint16_t server;
+	uint16_t oob_info;
 };
 
 struct generic_request {
@@ -96,8 +101,16 @@ struct generic_request {
 	const char *str;
 };
 
+struct scan_data {
+	uint16_t dst;
+	uint16_t secs;
+};
+
+static void *finalized = L_UINT_TO_PTR(-1);
+
 static struct l_dbus *dbus;
 
+static struct l_timeout *scan_timeout;
 static struct l_queue *node_proxies;
 static struct l_dbus_proxy *net_proxy;
 static struct meshcfg_node *local;
@@ -197,23 +210,57 @@ static bool parse_argument_on_off(int argc, char *argv[], bool *value)
 static bool match_device_uuid(const void *a, const void *b)
 {
 	const struct unprov_device *dev = a;
-	const uint8_t *uuid = b;
 
-	return (memcmp(dev->uuid, uuid, 16) == 0);
+	if (a == finalized)
+		return false;
+
+	return memcmp(dev->uuid, b, 16) == 0;
 }
 
-static void print_device(void *a, void *b)
+static bool match_by_id(const void *a, const void *b)
 {
 	const struct unprov_device *dev = a;
-	struct tm *tm = localtime(&dev->last_seen);
+	int id = L_PTR_TO_UINT(b);
+
+	if (a == finalized)
+		return false;
+
+	l_info("test %d %d", dev->id, id);
+	return dev->id == id;
+}
+
+static bool match_by_srv_uuid(const void *a, const void *b)
+{
+	const struct unprov_device *dev = a;
+	const struct unprov_device *new_dev = b;
+
+	if (a == finalized)
+		return false;
+
+	return (dev->server == new_dev->server) &&
+				(memcmp(dev->uuid, new_dev->uuid, 16) == 0);
+}
+
+static void print_device(void *a, void *b)
+{
+	struct unprov_device *dev = a;
+	int *cnt = b;
+	struct tm *tm;
 	char buf[80];
 	char *str;
 
+	if (a == finalized)
+		return;
+
+	tm = localtime(&dev->last_seen);
 	assert(strftime(buf, sizeof(buf), "%c", tm));
+	(*cnt)++;
 
+	dev->id = *cnt;
 	str = l_util_hexstring_upper(dev->uuid, sizeof(dev->uuid));
-	bt_shell_printf("UUID: %s, RSSI %d, Seen: %s\n",
-			str, dev->rssi, buf);
+	bt_shell_printf(COLOR_YELLOW "#%d" COLOR_OFF
+			" UUID: %s, RSSI %d, Server: %4.4x\n Seen: %s\n",
+			*cnt, str, dev->rssi, dev->server, buf);
 
 	l_free(str);
 }
@@ -794,15 +841,56 @@ static void scan_reply(struct l_dbus_proxy *proxy, struct l_dbus_message *msg,
 
 static void scan_setup(struct l_dbus_message *msg, void *user_data)
 {
-	uint16_t secs = (uint16_t) L_PTR_TO_UINT(user_data);
+	struct scan_data *data = user_data;
 	struct l_dbus_message_builder *builder;
 
 	builder = l_dbus_message_builder_new(msg);
 	l_dbus_message_builder_enter_array(builder, "{sv}");
-	append_dict_entry_basic(builder, "Seconds", "q", &secs);
+	append_dict_entry_basic(builder, "Seconds", "q", &data->secs);
+	append_dict_entry_basic(builder, "Server", "q", &data->dst);
 	l_dbus_message_builder_leave_array(builder);
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
+
+	/* Destination info not needed after call */
+	l_free(data);
+}
+
+static void scan_start(void *user_data, uint16_t dst, uint32_t model)
+{
+	struct scan_data *data;
+
+	if (model != RPR_SVR_MODEL)
+		return;
+
+	data = l_malloc(sizeof(struct scan_data));
+	data->secs = L_PTR_TO_UINT(user_data);
+	data->dst = dst;
+
+	if (!l_dbus_proxy_method_call(local->mgmt_proxy, "UnprovisionedScan",
+					scan_setup, scan_reply, data, NULL))
+		l_free(data);
+}
+
+static void scan_to(struct l_timeout *timeout, void *user_data)
+{
+	int cnt = 0;
+
+	if (l_queue_peek_head(devices) != finalized)
+		l_queue_push_head(devices, finalized);
+
+	l_timeout_remove(timeout);
+	scan_timeout = NULL;
+	bt_shell_printf(COLOR_YELLOW "Unprovisioned devices:\n" COLOR_OFF);
+	l_queue_foreach(devices, print_device, &cnt);
+}
+
+static void free_devices(void *a)
+{
+	if (a == finalized)
+		return;
+
+	l_free(a);
 }
 
 static void cmd_scan_unprov(int argc, char *argv[])
@@ -820,21 +908,28 @@ static void cmd_scan_unprov(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (argc == 3)
+	if (argc == 3) {
 		sscanf(argv[2], "%u", &secs);
 
-	if (secs > UNPROV_SCAN_MAX_SECS)
-		secs = UNPROV_SCAN_MAX_SECS;
+		if (secs > UNPROV_SCAN_MAX_SECS)
+			secs = UNPROV_SCAN_MAX_SECS;
+	} else
+		secs = 60;
 
-	if (enable)
-		l_dbus_proxy_method_call(local->mgmt_proxy, "UnprovisionedScan",
-						scan_setup, scan_reply,
-						L_UINT_TO_PTR(secs), NULL);
-	else
+	l_timeout_remove(scan_timeout);
+	scan_timeout = NULL;
+
+	if (enable) {
+		l_queue_clear(devices, free_devices);
+		remote_foreach_model(scan_start, L_UINT_TO_PTR(secs));
+		scan_timeout = l_timeout_create(secs, scan_to, NULL, NULL);
+	} else {
+		/* Mark devices queue as finalized */
+		l_queue_push_head(devices, finalized);
 		l_dbus_proxy_method_call(local->mgmt_proxy,
 						"UnprovisionedScanCancel",
 						NULL, NULL, NULL, NULL);
-
+	}
 }
 
 static uint8_t *parse_key(struct l_dbus_message_iter *iter, uint16_t id,
@@ -1030,8 +1125,10 @@ static void cmd_export_db(int argc, char *argv[])
 
 static void cmd_list_unprov(int argc, char *argv[])
 {
+	int cnt = 0;
+
 	bt_shell_printf(COLOR_YELLOW "Unprovisioned devices:\n" COLOR_OFF);
-	l_queue_foreach(devices, print_device, NULL);
+	l_queue_foreach(devices, print_device, &cnt);
 }
 
 static void cmd_list_nodes(int argc, char *argv[])
@@ -1505,32 +1602,56 @@ static void add_node_reply(struct l_dbus_proxy *proxy,
 	bt_shell_printf("Provisioning started\n");
 }
 
-static void add_node_setup(struct l_dbus_message *msg, void *user_data)
+static void reprov_reply(struct l_dbus_proxy *proxy,
+				struct l_dbus_message *msg, void *user_data)
 {
-	char *str = user_data;
-	size_t sz;
-	unsigned char *uuid;
-	struct l_dbus_message_builder *builder;
+	if (l_dbus_message_is_error(msg)) {
+		const char *name;
 
-	uuid = l_util_from_hexstring(str, &sz);
-	if (!uuid || sz != 16 || !l_uuid_is_valid(uuid)) {
-		l_error("Failed to generate UUID array from %s", str);
+		prov_in_progress = false;
+		l_dbus_message_get_error(msg, &name, NULL);
+		l_error("Failed to start provisioning: %s", name);
 		return;
 	}
 
+	bt_shell_printf("Reprovisioning started\n");
+}
+
+static void reprovision_setup(struct l_dbus_message *msg, void *user_data)
+{
+	uint16_t target = L_PTR_TO_UINT(user_data);
+	uint8_t nppi = L_PTR_TO_UINT(user_data) >> 16;
+	struct l_dbus_message_builder *builder;
+
 	builder = l_dbus_message_builder_new(msg);
-	append_byte_array(builder, uuid, 16);
+	l_dbus_message_builder_append_basic(builder, 'q', &target);
 	l_dbus_message_builder_enter_array(builder, "{sv}");
 	/* TODO: populate with options when defined */
+	append_dict_entry_basic(builder, "NPPI", "y", &nppi);
 	l_dbus_message_builder_leave_array(builder);
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
+}
 
-	l_free(uuid);
+static void add_node_setup(struct l_dbus_message *msg, void *user_data)
+{
+	struct unprov_device *dev = user_data;
+	struct l_dbus_message_builder *builder;
+
+	builder = l_dbus_message_builder_new(msg);
+	append_byte_array(builder, dev->uuid, 16);
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	/* TODO: populate with options when defined */
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
 }
 
 static void cmd_start_prov(int argc, char *argv[])
 {
+	struct unprov_device *dev = NULL;
+	int id;
+
 	if (!local || !local->proxy || !local->mgmt_proxy) {
 		bt_shell_printf("Node is not attached\n");
 		return;
@@ -1541,14 +1662,96 @@ static void cmd_start_prov(int argc, char *argv[])
 		return;
 	}
 
-	if (!argv[1] || (strlen(argv[1]) != 32)) {
+	if (!argv[1]) {
+		bt_shell_printf(COLOR_RED "Requires UUID\n" COLOR_RED);
+		return;
+	}
+
+	if (*(argv[1]) == '#') {
+		if (sscanf(argv[1] + 1, "%d", &id) == 1)
+			dev = l_queue_find(devices, match_by_id,
+							L_UINT_TO_PTR(id));
+
+		if (!dev) {
+			bt_shell_printf(COLOR_RED "unknown id\n" COLOR_RED);
+			return;
+		}
+	} else if (strlen(argv[1]) == 32) {
+		size_t sz;
+		uint8_t *uuid = l_util_from_hexstring(argv[1], &sz);
+
+		if (sz != 16) {
+			bt_shell_printf(COLOR_RED "Invalid UUID\n" COLOR_RED);
+			return;
+		}
+
+		dev = l_queue_find(devices, match_device_uuid, uuid);
+
+		if (!dev) {
+			dev = l_new(struct unprov_device, 1);
+			memcpy(dev->uuid, uuid, 16);
+			l_queue_push_tail(devices, dev);
+		}
+
+		l_free(uuid);
+
+	} else {
 		bt_shell_printf(COLOR_RED "Requires UUID\n" COLOR_RED);
 		return;
 	}
 
 	if (l_dbus_proxy_method_call(local->mgmt_proxy, "AddNode",
 						add_node_setup, add_node_reply,
-						argv[1], NULL))
+						dev, NULL))
+		prov_in_progress = true;
+}
+
+static void cmd_start_reprov(int argc, char *argv[])
+{
+	uint16_t target = 0;
+	uint8_t nppi = 0;
+
+	if (!local || !local->proxy || !local->mgmt_proxy) {
+		bt_shell_printf("Node is not attached\n");
+		return;
+	}
+
+	if (prov_in_progress) {
+		bt_shell_printf("Provisioning is already in progress\n");
+		return;
+	}
+
+	if (!argv[1]) {
+		bt_shell_printf(COLOR_RED "Requires Unicast\n" COLOR_RED);
+		return;
+	}
+
+	if (argv[2]) {
+		char *end;
+
+		nppi = strtol(argv[2], &end, 16);
+	}
+
+	if (strlen(argv[1]) == 4) {
+		char *end;
+
+		target = strtol(argv[1], &end, 16);
+
+		if (end != (argv[1] + 4)) {
+			bt_shell_printf(COLOR_RED "Invalid Unicast\n"
+								COLOR_RED);
+			return;
+		}
+
+	} else {
+		bt_shell_printf(COLOR_RED "Requires Unicast\n" COLOR_RED);
+		return;
+	}
+
+	if (l_dbus_proxy_method_call(local->mgmt_proxy, "Reprovision",
+					reprovision_setup, reprov_reply,
+					L_UINT_TO_PTR(target + (nppi << 16)),
+					NULL))
 		prov_in_progress = true;
 }
 
@@ -1581,6 +1784,8 @@ static const struct bt_shell_menu main_menu = {
 			"List unprovisioned devices" },
 	{ "provision", "<uuid>", cmd_start_prov,
 			"Initiate provisioning"},
+	{ "reprovision", "<unicast> [0|1|2]", cmd_start_reprov,
+			"Refresh Device Key"},
 	{ "node-import", "<uuid> <net_idx> <primary> <ele_count> <dev_key>",
 			cmd_import_node,
 			"Import an externally provisioned remote node"},
@@ -1758,18 +1963,34 @@ static void setup_ele_iface(struct l_dbus_interface *iface)
 	/* TODO: Other methods */
 }
 
+static int sort_rssi(const void *a, const void *b, void *user_data)
+{
+	const struct unprov_device *new_dev = a;
+	const struct unprov_device *dev = b;
+
+	if (b == finalized)
+		return 1;
+
+	return dev->rssi - new_dev->rssi;
+}
+
 static struct l_dbus_message *scan_result_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
-	struct l_dbus_message_iter iter, opts;
+	struct l_dbus_message_iter iter, opts, var;
+	struct unprov_device result, *dev;
 	int16_t rssi;
+	uint16_t server = 0;
 	uint32_t n;
 	uint8_t *prov_data;
-	char *str;
-	struct unprov_device *dev;
+	const char *key;
 	const char *sig = "naya{sv}";
 
+	if (finalized == l_queue_peek_head(devices))
+		goto done;
+
+
 	if (!l_dbus_message_get_arguments(msg, sig, &rssi, &iter, &opts)) {
 		l_error("Cannot parse scan results");
 		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
@@ -1781,42 +2002,72 @@ static struct l_dbus_message *scan_result_call(struct l_dbus *dbus,
 		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
 	}
 
-	bt_shell_printf("Scan result:\n");
-	bt_shell_printf("\t" COLOR_GREEN "rssi = %d\n" COLOR_OFF, rssi);
-	str = l_util_hexstring_upper(prov_data, 16);
-	bt_shell_printf("\t" COLOR_GREEN "UUID = %s\n" COLOR_OFF, str);
-	l_free(str);
-
-	if (n >= 18) {
-		str = l_util_hexstring_upper(prov_data + 16, 2);
-		bt_shell_printf("\t" COLOR_GREEN "OOB = %s\n" COLOR_OFF, str);
-		l_free(str);
+	while (l_dbus_message_iter_next_entry(&opts, &key, &var)) {
+		if (!strcmp(key, "Server"))
+			l_dbus_message_iter_get_variant(&var, "q", &server);
 	}
 
-	if (n >= 22) {
-		str = l_util_hexstring_upper(prov_data + 18, 4);
-		bt_shell_printf("\t" COLOR_GREEN "URI Hash = %s\n" COLOR_OFF,
-									str);
-		l_free(str);
-	}
+	memcpy(result.uuid, prov_data, 16);
+	result.server = server;
+	result.rssi = rssi;
+	result.id = 0;
 
-	/* TODO: Handle the rest of provisioning data if present */
+	if (n > 16 && n <= 18)
+		result.oob_info = l_get_be16(prov_data + 16);
+	else
+		result.oob_info = 0;
+
+	if (n > 18 && n <= 22)
+		result.uri_hash = l_get_be32(prov_data + 18);
+	else
+		result.uri_hash = 0;
+
+	dev = l_queue_remove_if(devices, match_by_srv_uuid, &result);
 
-	dev = l_queue_find(devices, match_device_uuid, prov_data);
 	if (!dev) {
-		dev = l_new(struct unprov_device, 1);
-		memcpy(dev->uuid, prov_data, sizeof(dev->uuid));
-		/* TODO: timed self-destructor */
-		l_queue_push_tail(devices, dev);
-	}
+		bt_shell_printf("\r" COLOR_YELLOW "Results = %d\n" COLOR_OFF,
+						l_queue_length(devices) + 1);
+		dev = l_malloc(sizeof(struct unprov_device));
+		*dev = result;
+
+	} else if (dev->rssi < result.rssi)
+		*dev = result;
 
-	/* Update with the latest rssi */
-	dev->rssi = rssi;
 	dev->last_seen = time(NULL);
 
+	l_queue_insert(devices, dev, sort_rssi, NULL);
+
+done:
 	return l_dbus_message_new_method_return(msg);
 }
 
+static struct l_dbus_message *req_reprov_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint8_t cnt;
+	uint16_t unicast, original;
+	struct l_dbus_message *reply;
+
+
+	if (!l_dbus_message_get_arguments(msg, "qy", &original, &cnt) ||
+							!IS_UNICAST(original)) {
+		l_error("Cannot parse request for reprov data");
+		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
+
+	}
+
+	unicast = remote_get_next_unicast(low_addr, high_addr, cnt);
+
+	bt_shell_printf("Assign addresses for %u elements\n", cnt);
+	bt_shell_printf("Original: %4.4x New: %4.4x\n", original, unicast);
+
+	reply = l_dbus_message_new_method_return(msg);
+	l_dbus_message_set_arguments(reply, "q", unicast);
+
+	return reply;
+}
+
 static struct l_dbus_message *req_prov_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
@@ -1825,6 +2076,7 @@ static struct l_dbus_message *req_prov_call(struct l_dbus *dbus,
 	uint16_t unicast;
 	struct l_dbus_message *reply;
 
+	/* Both calls handled identicaly except for parameter list */
 	if (!l_dbus_message_get_arguments(msg, "y", &cnt)) {
 		l_error("Cannot parse request for prov data");
 		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
@@ -1833,14 +2085,14 @@ static struct l_dbus_message *req_prov_call(struct l_dbus *dbus,
 
 	unicast = remote_get_next_unicast(low_addr, high_addr, cnt);
 
-	if (unicast == 0) {
+	if (!IS_UNICAST(unicast)) {
 		l_error("Failed to allocate addresses for %u elements\n", cnt);
 		return l_dbus_message_new_error(msg,
 					"org.freedesktop.DBus.Error."
 					"Failed to allocate address", NULL);
 	}
 
-	bt_shell_printf("Assign addresses for %u elements\n", cnt);
+	bt_shell_printf("Assign addresses: %4.4x (cnt: %d)\n", unicast, cnt);
 
 	reply = l_dbus_message_new_method_return(msg);
 	l_dbus_message_set_arguments(reply, "qq", prov_net_idx, unicast);
@@ -1852,11 +2104,13 @@ static void remove_device(uint8_t *uuid)
 {
 	struct unprov_device *dev;
 
-	dev = l_queue_remove_if(devices, match_device_uuid, uuid);
-	l_free(dev);
+	do {
+		dev = l_queue_remove_if(devices, match_device_uuid, uuid);
+		l_free(dev);
+	} while (dev);
 }
 
-static struct l_dbus_message *add_node_cmplt_call(struct l_dbus *dbus,
+static struct l_dbus_message *prov_cmplt_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
@@ -1866,6 +2120,7 @@ static struct l_dbus_message *add_node_cmplt_call(struct l_dbus *dbus,
 	uint32_t n;
 	uint8_t *uuid;
 
+	l_debug("ProvComplete");
 	if (!prov_in_progress)
 		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
 
@@ -1896,7 +2151,49 @@ static struct l_dbus_message *add_node_cmplt_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
-static struct l_dbus_message *add_node_fail_call(struct l_dbus *dbus,
+static struct l_dbus_message *reprov_cmplt_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint16_t unicast, original;
+	uint8_t old_cnt, cnt, nppi;
+
+	l_debug("ReprovComplete");
+	if (!prov_in_progress)
+		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
+
+	prov_in_progress = false;
+
+	if (!l_dbus_message_get_arguments(msg, "qyqy", &original, &nppi,
+							&unicast, &cnt)) {
+		l_error("Cannot parse reprov complete message");
+		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
+
+	}
+
+	l_debug("ReprovComplete org: %4.4x, nppi: %d, new: %4.4x, cnt: %d",
+						original, nppi, unicast, cnt);
+	old_cnt = remote_ele_cnt(original);
+
+	if (nppi != 1 && (original != unicast || cnt != old_cnt)) {
+		l_error("Invalid reprov complete message (NPPI == %d)", nppi);
+		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
+	}
+
+	if (nppi)
+		remote_reset_node(original, unicast, cnt,
+						mesh_db_get_iv_index());
+
+	bt_shell_printf("Reprovisioning done (nppi: %d):\n", nppi);
+	remote_print_node(unicast);
+
+	if (!mesh_db_reset_node(original, unicast, cnt))
+		l_error("Failed to reset remote node");
+
+	return l_dbus_message_new_method_return(msg);
+}
+
+static struct l_dbus_message *prov_fail_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
@@ -1911,24 +2208,49 @@ static struct l_dbus_message *add_node_fail_call(struct l_dbus *dbus,
 	prov_in_progress = false;
 
 	if (!l_dbus_message_get_arguments(msg, "ays", &iter, &reason)) {
-		l_error("Cannot parse add node failed message");
+		l_error("Cannot parse failed message");
 		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
-
 	}
 
-	if (!l_dbus_message_iter_get_fixed_array(&iter, &uuid, &n) ||
-								n != 16) {
-		l_error("Cannot parse add node failed message: uuid");
+	if (!l_dbus_message_iter_get_fixed_array(&iter, &uuid, &n) || n != 16) {
+		l_error("Cannot parse failed message: uuid");
 		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
 	}
 
 	bt_shell_printf("Provisioning failed:\n");
+
 	str = l_util_hexstring_upper(uuid, 16);
 	bt_shell_printf("\t" COLOR_RED "UUID = %s\n" COLOR_OFF, str);
 	l_free(str);
+	remove_device(uuid);
 	bt_shell_printf("\t" COLOR_RED "%s\n" COLOR_OFF, reason);
 
-	remove_device(uuid);
+	return l_dbus_message_new_method_return(msg);
+}
+
+static struct l_dbus_message *reprov_fail_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct l_dbus_message_iter iter;
+	uint16_t original = UNASSIGNED_ADDRESS;
+	char *reason;
+
+	if (!prov_in_progress)
+		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
+
+	prov_in_progress = false;
+
+	if (!l_dbus_message_get_arguments(msg, "qs", &iter, &reason) ||
+							!IS_UNICAST(original)) {
+
+		l_error("Cannot parse Reprov failed message");
+		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
+	}
+
+	bt_shell_printf("Reprovisioning failed:\n");
+	bt_shell_printf("\t" COLOR_RED "UNICAST = %4.4x\n" COLOR_OFF, original);
+	bt_shell_printf("\t" COLOR_RED "%s\n" COLOR_OFF, reason);
 
 	return l_dbus_message_new_method_return(msg);
 }
@@ -1941,12 +2263,23 @@ static void setup_prov_iface(struct l_dbus_interface *iface)
 	l_dbus_interface_method(iface, "RequestProvData", 0, req_prov_call,
 				"qq", "y", "net_index", "unicast", "count");
 
+	l_dbus_interface_method(iface, "RequestReprovData", 0, req_reprov_call,
+					"q", "qy", "unicast",
+					"original", "count");
+
 	l_dbus_interface_method(iface, "AddNodeComplete", 0,
-					add_node_cmplt_call, "", "ayqy",
+					prov_cmplt_call, "", "ayqy",
 					"uuid", "unicast", "count");
 
-	l_dbus_interface_method(iface, "AddNodeFailed", 0, add_node_fail_call,
+	l_dbus_interface_method(iface, "ReprovComplete", 0,
+					reprov_cmplt_call, "", "qyqy",
+					"original", "nppi", "unicast", "count");
+
+	l_dbus_interface_method(iface, "AddNodeFailed", 0, prov_fail_call,
 					"", "ays", "uuid", "reason");
+
+	l_dbus_interface_method(iface, "ReprovFailed", 0, reprov_fail_call,
+					"", "qs", "unicast", "reason");
 }
 
 static bool cid_getter(struct l_dbus *dbus,
diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index a48eace74..ad572f694 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -266,14 +266,21 @@ static uint32_t print_mod_id(uint8_t *data, bool vendor, const char *offset)
 	return mod_id;
 }
 
-static void print_composition(uint8_t *data, uint16_t len)
+static uint8_t print_composition(uint8_t *data, uint16_t len)
 {
 	uint16_t features;
 	int i = 0;
+	bool nppi = false;
 
-	bt_shell_printf("Received composion:\n");
+	bt_shell_printf("Received composition:\n");
+
+	/* We only support Pages 0 && 128 */
+	if (*data == 128) {
+		bt_shell_printf("Dev Key Refresh (NPPI) required\n");
+		nppi = true;
+	} else if (*data != 0)
+		return 0;
 
-	/* skip page -- We only support Page Zero */
 	data++;
 	len--;
 
@@ -328,6 +335,11 @@ static void print_composition(uint8_t *data, uint16_t len)
 
 		i++;
 	}
+
+	if (nppi)
+		return (uint8_t) i;
+	else
+		return 0;
 }
 
 static void print_pub(uint16_t ele_addr, uint32_t mod_id,
@@ -402,6 +414,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 	const struct cfg_cmd *cmd;
 	uint16_t app_idx, net_idx, addr, ele_addr, features;
 	struct mesh_group *grp;
+	uint8_t page128_cnt;
 	struct model_pub pub;
 	int n;
 	struct pending_req *req;
@@ -431,7 +444,19 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		if (len < MIN_COMPOSITION_LEN)
 			return true;
 
-		print_composition(data, len);
+		page128_cnt = print_composition(data, len);
+		if (page128_cnt) {
+			if (page128_cnt != remote_ele_cnt(src)) {
+				bt_shell_printf("Ele count was %d, now %d\n",
+					remote_ele_cnt(src), page128_cnt);
+				bt_shell_printf("Reprovision with NPPI-1\n");
+			} else {
+				bt_shell_printf("Models or Features changed\n");
+				bt_shell_printf("Reprovision with NPPI-2\n");
+			}
+
+			break;
+		}
 
 		saved = mesh_db_node_set_composition(src, data, len);
 		if (saved)
@@ -1051,8 +1076,8 @@ static void cmd_composition_get(int argc, char *argv[])
 
 	n = mesh_opcode_set(OP_DEV_COMP_GET, msg);
 
-	/* By default, use page 0 */
-	msg[n++] = (read_input_parameters(argc, argv) == 1) ? parms[0] : 0;
+	/* By default, use page 128 */
+	msg[n++] = (read_input_parameters(argc, argv) == 1) ? parms[0] : 128;
 
 	if (!config_send(msg, n, OP_DEV_COMP_GET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 896ff722c..71060e7b1 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -1702,6 +1702,29 @@ static json_object *init_elements(uint8_t num_els)
 	return jelements;
 }
 
+bool mesh_db_reset_node(uint16_t original, uint16_t unicast, uint8_t num_els)
+{
+	json_object *jnode, *jelements;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(cfg->jcfg, original);
+	if (!jnode) {
+		l_error("Node %4.4x does not exist", original);
+		return false;
+	}
+
+	if (!write_uint16_hex(jnode, "unicastAddress", unicast))
+		return false;
+
+	json_object_object_del(jnode, "elements");
+	jelements = init_elements(num_els);
+	json_object_object_add(jnode, "elements", jelements);
+
+	return save_config();
+}
+
 bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
 							uint16_t net_idx)
 {
@@ -1864,13 +1887,11 @@ bool mesh_db_node_set_composition(uint16_t unicast, uint8_t *data, uint16_t len)
 	if (!jnode)
 		return false;
 
-	/* skip page -- We only support Page Zero */
-	data++;
-	len--;
+	/* This is for page-0 only */
+	if (*data++ != 0)
+		return false;
 
-	/* If "crpl" property is present, composition is already recorded */
-	if (json_object_object_get_ex(jnode, "crpl", &jobj))
-		return true;
+	len--;
 
 	if (!write_uint16_hex(jnode, "cid", l_get_le16(&data[0])))
 		return false;
@@ -1984,7 +2005,8 @@ bool mesh_db_node_set_composition(uint16_t unicast, uint8_t *data, uint16_t len)
 fail:
 	/* Reset elements array */
 	json_object_object_del(jnode, "elements");
-	init_elements(sz);
+	jelements = init_elements(sz);
+	json_object_object_add(jnode, "elements", jelements);
 
 	return false;
 }
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index 4b6b2adb3..0e45112b7 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -29,6 +29,7 @@ bool mesh_db_del_app_key(uint16_t app_idx);
 bool mesh_db_get_addr_range(uint16_t *low, uint16_t *high);
 bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
 							uint16_t net_idx);
+bool mesh_db_reset_node(uint16_t original, uint16_t unicast, uint8_t num_els);
 bool mesh_db_del_node(uint16_t unicast);
 bool mesh_db_node_set_composition(uint16_t unicast, uint8_t *data,
 								uint16_t len);
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index 6ec220a6f..cee711dec 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -30,6 +30,12 @@ struct remote_key {
 	bool updated;
 };
 
+struct foreach_data {
+	remote_foreach_t each;
+	void *user_data;
+	uint16_t dst;
+};
+
 struct remote_node {
 	uint16_t unicast;
 	struct l_queue *net_keys;
@@ -138,6 +144,40 @@ uint8_t remote_del_node(uint16_t unicast)
 	return num_ele;
 }
 
+bool remote_reset_node(uint16_t original, uint16_t unicast, uint8_t ele_cnt,
+							uint32_t iv_index)
+{
+	struct remote_node *rmt;
+	bool reject = true;
+	int i;
+
+	rmt = l_queue_remove_if(nodes, match_node_addr,
+						L_UINT_TO_PTR(original));
+	if (!rmt)
+		return false;
+
+	if (unicast == rmt->unicast)
+		reject = false;
+
+	for (i = 0; i < rmt->num_ele; ++i) {
+		l_queue_destroy(rmt->els[i], NULL);
+		if (reject)
+			remote_add_rejected_address(rmt->unicast + i,
+								iv_index, true);
+	}
+
+	if (ele_cnt != rmt->num_ele) {
+		l_free(rmt->els);
+		rmt->els = l_new(struct l_queue *, ele_cnt);
+	} else
+		memset(rmt->els, 0, sizeof(struct l_queue *) * ele_cnt);
+
+	rmt->unicast = unicast;
+	rmt->num_ele = ele_cnt;
+	l_queue_insert(nodes, rmt, compare_unicast, NULL);
+	return true;
+}
+
 bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 					uint8_t ele_cnt, uint16_t net_idx)
 {
@@ -526,6 +566,76 @@ void remote_print_all(void)
 	l_queue_foreach(nodes, print_node, NULL);
 }
 
+static void each_node(void *rmt, void *user_data)
+{
+	struct remote_node *node = rmt;
+	struct foreach_data *data = user_data;
+
+	data->each(data->user_data, node->unicast, (uint32_t) -1);
+}
+
+static void each_addr(void *rmt, void *user_data)
+{
+	struct remote_node *node = rmt;
+	struct foreach_data *data = user_data;
+	uint16_t cnt;
+
+	for (cnt = 0; cnt <= node->num_ele; cnt++)
+		data->each(data->user_data, node->unicast + cnt, (uint32_t) -1);
+}
+
+static void parse_model(void *model, void *user_data)
+{
+	struct foreach_data *data = user_data;
+
+	data->each(data->user_data, data->dst, L_PTR_TO_UINT(model));
+}
+
+static void each_model(void *rmt, void *user_data)
+{
+	struct remote_node *node = rmt;
+	struct foreach_data *data = user_data;
+	uint16_t cnt;
+
+	for (cnt = 0; cnt < node->num_ele; cnt++) {
+		data->dst = node->unicast + cnt;
+		l_queue_foreach(node->els[cnt], parse_model, data);
+	}
+}
+
+void remote_foreach(remote_foreach_t each, void *user_data)
+{
+	struct foreach_data data = {
+		.each = each,
+		.user_data = user_data
+	};
+
+	if (each)
+		l_queue_foreach(nodes, each_node, &data);
+}
+
+void remote_foreach_unicast(remote_foreach_t each, void *user_data)
+{
+	struct foreach_data data = {
+		.each = each,
+		.user_data = user_data
+	};
+
+	if (each)
+		l_queue_foreach(nodes, each_addr, &data);
+}
+
+void remote_foreach_model(remote_foreach_t each, void *user_data)
+{
+	struct foreach_data data = {
+		.each = each,
+		.user_data = user_data
+	};
+
+	if (each)
+		l_queue_foreach(nodes, each_model, &data);
+}
+
 uint16_t remote_get_next_unicast(uint16_t low, uint16_t high, uint8_t ele_cnt)
 {
 	struct remote_node *rmt;
@@ -598,3 +708,15 @@ void remote_clear_rejected_addresses(uint32_t iv_index)
 
 	mesh_db_clear_rejected(iv_index);
 }
+
+uint8_t remote_ele_cnt(uint16_t unicast)
+{
+	struct remote_node *rmt;
+
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(unicast));
+
+	if (rmt)
+		return rmt->num_ele;
+
+	return 0;
+}
diff --git a/tools/mesh/remote.h b/tools/mesh/remote.h
index 66457237e..2a3947b58 100644
--- a/tools/mesh/remote.h
+++ b/tools/mesh/remote.h
@@ -8,8 +8,13 @@
  *
  */
 
+typedef void (*remote_foreach_t)(void *user_data, uint16_t dst,
+								uint32_t model);
+
 bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 					uint8_t ele_cnt, uint16_t net_idx);
+bool remote_reset_node(uint16_t original, uint16_t unicast, uint8_t ele_cnt,
+							uint32_t iv_index);
 uint8_t remote_del_node(uint16_t unicast);
 bool remote_set_model(uint16_t unicast, uint8_t ele_idx, uint32_t mod_id,
 								bool vendor);
@@ -30,3 +35,7 @@ bool remote_has_composition(uint16_t addr);
 uint16_t remote_get_subnet_idx(uint16_t addr);
 void remote_print_node(uint16_t addr);
 void remote_print_all(void);
+void remote_foreach(remote_foreach_t each, void *user_data);
+void remote_foreach_unicast(remote_foreach_t each, void *user_data);
+void remote_foreach_model(remote_foreach_t each, void *user_data);
+uint8_t remote_ele_cnt(uint16_t unicast);
-- 
2.39.0

