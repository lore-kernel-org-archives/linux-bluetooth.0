Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816F3C54E94
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 20:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjAXU0y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjAXU0j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 15:26:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D747B4ABCF
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:30 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y3-20020a17090a390300b00229add7bb36so15168213pjb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH46ocFCk8kezNiIY8wxOx17wU4aswIas0eNpONaepE=;
        b=IGtMQru1m42wIKxC3mm0BhH77v4NQ9xQ1oiaPP+Z43egt9ZcQkWsNoVFb90350sMfC
         40RILffGQm88Xqzeq6NnN5vr1+iiko6Q41Ov5Eo84s+83P/y72e5EhTPSzo+1NKjhecs
         3/pGSwGcUDM+/LSaagJxjPYc66D4w1A4ATM0u13wVJr7WfLuZj7VPYDREs56iN3TKAxY
         VRlX22rGcqn6GcVSxg9CfGQoTgQvlho+QkjXDyIf2B7fNO71a0/eALsWQSG/uXXKn2VN
         0EPyH8AlKPZALs9By2WhUaB9LDOyP3UxWXEZVT+kv2NltkhMy19YYEXOiSx93tWSQvCu
         1MGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TH46ocFCk8kezNiIY8wxOx17wU4aswIas0eNpONaepE=;
        b=au+Vlt4gr+d7ERGhJLu16x9l2uPQ+ImsZVhdgKEgJka4NoMYAhVRXhoptV4lj1SQC9
         Ou1/v5qaJLMR6aEmYRroSpru0sdnVmog7tnaej8/IhNa+qdAqjOl3T4dSL6J16Iedt/I
         TG4gpIvDnor/hT3odoa7XJAiVRcBxHBM7ykmSKQ+2ydpbEkEDvzv8zXMHpPSwQsLwQQB
         Xq/gPgyMc1uutucoHi879kL1r3f3Gz+BxQ0aYPLxY2TK3dbBu2c06s3gJCzfi+4yIbkp
         jJoLjcUAihkX5GsmtwHwozwKakKeLB7inuRhzjElQxDwvGYtxo48CL88jx6NPmEQFntR
         5lrg==
X-Gm-Message-State: AO0yUKX2a3uzlD9/yXWD2ZGFIz8kWSPBvXxXTFigWDOXeDgEf8fv46rF
        qzUvdCJXVgZVnjfURRqjraf/156eDfnWeg==
X-Google-Smtp-Source: AK7set+mOif9ka5GhSM9dONfmucFq8LZu6tC+c7YnEnQaM4TmXU0zBvSEb9vmJIrrzO6PGSvZEzHTw==
X-Received: by 2002:a17:902:c40b:b0:196:15ad:91ea with SMTP id k11-20020a170902c40b00b0019615ad91eamr3777863plk.63.1674591989841;
        Tue, 24 Jan 2023 12:26:29 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id ju21-20020a170903429500b0019600b78487sm2108099plb.33.2023.01.24.12.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:26:29 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v4 10/13] tools/mesh: Add support for Mesh Private Beacons
Date:   Tue, 24 Jan 2023 12:26:13 -0800
Message-Id: <20230124202616.310544-11-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124202616.310544-1-brian.gix@gmail.com>
References: <20230124202616.310544-1-brian.gix@gmail.com>
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

