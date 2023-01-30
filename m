Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23C8C6379F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 23:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjA3Xwd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjA3Xw2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 18:52:28 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E562E0CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:27 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jh15so4318867plb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH46ocFCk8kezNiIY8wxOx17wU4aswIas0eNpONaepE=;
        b=kz6XNANRZ00gC67zdI5aL2/ZvDV/W3eI77/rv61c0gKnCWzHn0D3zZ02e4dmz/fx6k
         8HmkMvPFSHkPpfDbTwViawxvDoudfoTjwQkkCCOp8/j4/B9ojeYyuZ2aThsrLVEQqay6
         8CqLPaDGYXf8qUR1QYUDhx/aCHb7G8P5vwqt73dikwNj/keUKmB7CnwEInpKZsb0IG6G
         m2YGHjsOHpgwBeMaKAqXGPH6RWL6V/t8MQMJlsczqJK8QPwIeo5w2XGRUyT17NRIjCCd
         3Q7eadbin2xX573nhtjGNNHqZWaPhoZWpIfVZR8SEmFsKDJKygAoYyQ+Rz7GBp1yqPnV
         AYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TH46ocFCk8kezNiIY8wxOx17wU4aswIas0eNpONaepE=;
        b=7stfblEA/zJU1vwxazJr+XTkavhgUeqquC6HHyKCkVIBM8JhhZKcLMekuxRGYmioD4
         Xs/CbGRRTV9XYskh5NIrN3IBhGpXobTzCLFjOKx9r5JK0nxtyMJN0G5m2PovbFjZpaiV
         QmQt6JLwPE6Dr42aFousSUsIlLu7h1DS6fOKwH5TimDVCzHTkfB/QSWzZVeAzeVi+/BR
         0lpkmibpvv08iWpKBYKx6ofDwoB4z0B4nigSmqbkzqOPPuNh95jLzHEUOGfQw1IT85sX
         5VX4FQL5q4L1SnRaliWZG33g8qVPYod4d7O0Eh4en7etjaMfk2wULksi2JoCH1EDV1Wy
         xdZg==
X-Gm-Message-State: AO0yUKXNYodU6/UyMpWXFX6ivklY16q69g/1+fyCtsBcLUo12ioO73pS
        j7cWQeeKf7NnVC5J3jTb1WIM0iIJxNW5wA==
X-Google-Smtp-Source: AK7set88a8IWRPhJsgeDV7mc41n5/mDQM8tNaOrmckgLbuOKBxhYn2Z4JRuWSEdFPS8hz9tOOD6bBg==
X-Received: by 2002:a05:6a20:6917:b0:bc:caea:6cea with SMTP id q23-20020a056a20691700b000bccaea6ceamr8142754pzj.6.1675122745993;
        Mon, 30 Jan 2023 15:52:25 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm2663948pgd.76.2023.01.30.15.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:52:25 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v5 10/14] tools/mesh: Add support for Mesh Private Beacons
Date:   Mon, 30 Jan 2023 15:52:06 -0800
Message-Id: <20230130235210.94385-11-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130235210.94385-1-brian.gix@gmail.com>
References: <20230130235210.94385-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

This allows generation of Mesh Private Beacon server commands, and
recognition of the resulting Status messages.
---
 tools/mesh-cfgclient.c |  9 ++++--
 tools/mesh/cfgcli.c    | 62 +++++++++++++++++++++++++++++++++++-------
 tools/mesh/util.c      |  3 ++
 3 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index f3e9af8fb..50be82bcf 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -44,6 +44,8 @@
 #define CFG_SRV_MODEL	0x0000
 #define CFG_CLI_MODEL	0x0001
 #define RPR_SVR_MODEL	0xFFFF0004
+#define PRV_BEACON_SVR	0x0008
+#define PRV_BEACON_CLI	0x0009
 
 #define UNPROV_SCAN_MAX_SECS	300
 
@@ -58,7 +60,7 @@
 struct meshcfg_el {
 	const char *path;
 	uint8_t index;
-	uint16_t mods[2];
+	uint16_t mods[4];
 };
 
 struct meshcfg_app {
@@ -143,7 +145,8 @@ static struct meshcfg_app app = {
 	.ele = {
 		.path = "/mesh/cfgclient/ele0",
 		.index = 0,
-		.mods = {CFG_SRV_MODEL, CFG_CLI_MODEL}
+		.mods = {CFG_SRV_MODEL, CFG_CLI_MODEL,
+					PRV_BEACON_SVR, PRV_BEACON_CLI}
 	}
 };
 
@@ -1889,6 +1892,8 @@ static bool mod_getter(struct l_dbus *dbus,
 	l_dbus_message_builder_enter_array(builder, "(qa{sv})");
 	build_model(builder, app.ele.mods[0], false, false);
 	build_model(builder, app.ele.mods[1], false, false);
+	build_model(builder, app.ele.mods[2], false, false);
+	build_model(builder, app.ele.mods[3], false, false);
 	l_dbus_message_builder_leave_array(builder);
 
 	return true;
diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index ad572f694..4f6248e48 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -21,6 +21,7 @@
 #include "src/shared/util.h"
 
 #include "mesh/mesh-defs.h"
+#include "mesh/prv-beacon.h"
 #include "mesh/util.h"
 #include "mesh/crypto.h"
 
@@ -73,9 +74,12 @@ static struct cfg_cmd cmds[] = {
 	{ OP_APPKEY_UPDATE, OP_APPKEY_STATUS, "AppKeyUpdate" },
 	{ OP_DEV_COMP_GET, OP_DEV_COMP_STATUS, "DeviceCompositionGet" },
 	{ OP_DEV_COMP_STATUS, NO_RESPONSE, "DeviceCompositionStatus" },
-	{ OP_CONFIG_BEACON_GET, OP_CONFIG_BEACON_STATUS, "BeaconGet" },
-	{ OP_CONFIG_BEACON_SET, OP_CONFIG_BEACON_STATUS, "BeaconSet" },
-	{ OP_CONFIG_BEACON_STATUS, NO_RESPONSE, "BeaconStatus" },
+	{ OP_CONFIG_BEACON_GET, OP_CONFIG_BEACON_STATUS, "SNBGet" },
+	{ OP_CONFIG_BEACON_SET, OP_CONFIG_BEACON_STATUS, "SNBSet" },
+	{ OP_CONFIG_BEACON_STATUS, NO_RESPONSE, "SNBStatus" },
+	{ OP_PRIVATE_BEACON_GET, OP_PRIVATE_BEACON_STATUS, "MPBGet" },
+	{ OP_PRIVATE_BEACON_SET, OP_PRIVATE_BEACON_STATUS, "MPBSet" },
+	{ OP_PRIVATE_BEACON_STATUS, NO_RESPONSE, "MPBStatus" },
 	{ OP_CONFIG_DEFAULT_TTL_GET, OP_CONFIG_DEFAULT_TTL_STATUS,
 							"DefaultTTLGet" },
 	{ OP_CONFIG_DEFAULT_TTL_SET, OP_CONFIG_DEFAULT_TTL_STATUS,
@@ -617,12 +621,20 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		if (len != 1)
 			return true;
 
-		bt_shell_printf("Node %4.4x: Config Beacon Status 0x%02x\n",
+		bt_shell_printf("Node %4.4x: SecBeacon Status 0x%02x\n",
 				src, data[0]);
 
 		saved = mesh_db_node_set_beacon(src, data[0] != 0);
 		break;
 
+	case OP_PRIVATE_BEACON_STATUS:
+		if (len != 2)
+			return true;
+
+		bt_shell_printf("Node %4.4x: PrivBeacon Status 0x%02x 0x%02x\n",
+				src, data[0], data[1]);
+		break;
+
 	case OP_CONFIG_RELAY_STATUS:
 		if (len != 2)
 			return true;
@@ -1345,7 +1357,7 @@ static void cmd_del_binding(int argc, char *argv[])
 	cmd_bind(OP_MODEL_APP_UNBIND, argc, argv);
 }
 
-static void cmd_beacon_set(int argc, char *argv[])
+static void cmd_snb_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[2 + 1];
@@ -1367,11 +1379,41 @@ static void cmd_beacon_set(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_beacon_get(int argc, char *argv[])
+static void cmd_mpb_set(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[2 + 2];
+	uint32_t parm_cnt;
+
+	n = mesh_opcode_set(OP_PRIVATE_BEACON_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 1  && parm_cnt != 2) {
+		bt_shell_printf("bad arguments\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	msg[n++] = parms[0];
+
+	if (parm_cnt == 2)
+		msg[n++] = parms[1];
+
+	if (!config_send(msg, n, OP_PRIVATE_BEACON_SET))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_snb_get(int argc, char *argv[])
 {
 	cmd_default(OP_CONFIG_BEACON_GET);
 }
 
+static void cmd_mpb_get(int argc, char *argv[])
+{
+	cmd_default(OP_PRIVATE_BEACON_GET);
+}
+
 static void cmd_ident_set(int argc, char *argv[])
 {
 	uint16_t n;
@@ -2077,10 +2119,10 @@ static const struct bt_shell_menu cfg_menu = {
 				"Set node identity state"},
 	{"ident-get", "<net_idx>", cmd_ident_get,
 				"Get node identity state"},
-	{"beacon-set", "<state>", cmd_beacon_set,
-				"Set node identity state"},
-	{"beacon-get", NULL, cmd_beacon_get,
-				"Get node beacon state"},
+	{"snb-set", "<state>", cmd_snb_set, "Set node SNB state"},
+	{"snb-get", NULL, cmd_snb_get, "Get node SNB state"},
+	{"mpb-set", "<state> <period>", cmd_mpb_set, "Set node MPB state"},
+	{"mpb-get", NULL, cmd_mpb_get, "Get node MPB state"},
 	{"relay-set", "<relay> <rexmt count> <rexmt steps>", cmd_relay_set,
 				"Set relay"},
 	{"relay-get", NULL, cmd_relay_get,
diff --git a/tools/mesh/util.c b/tools/mesh/util.c
index 29641439f..d8c47c0e9 100644
--- a/tools/mesh/util.c
+++ b/tools/mesh/util.c
@@ -20,6 +20,7 @@
 #include "src/shared/util.h"
 
 #include "mesh/mesh-defs.h"
+#include "mesh/prv-beacon.h"
 
 #include "tools/mesh/util.h"
 
@@ -137,6 +138,8 @@ const char *sig_model_string(uint16_t sig_model_id)
 	case 0x0001: return "Configuration Client";
 	case 0x0002: return "Health Server";
 	case 0x0003: return "Health Client";
+	case 0x0008: return "Private Beacon Server";
+	case 0x0009: return "Private Beacon Client";
 	case 0x1000: return "Generic OnOff Server";
 	case 0x1001: return "Generic OnOff Client";
 	case 0x1002: return "Generic Level Server";
-- 
2.39.1

