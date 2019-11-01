Return-Path: <SRS0=Dn6D=YZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B35CA9ED0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 18:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055E321855
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 18:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfKAS5j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:57:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:29978 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbfKAS5j (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Nov 2019 14:57:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 11:57:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="211833775"
Received: from ingas-nuc1.sea.intel.com ([10.255.230.110])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2019 11:57:38 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 06/10 v2] tools/mesh-cfgclient: Add config menu key commands
Date:   Fri,  1 Nov 2019 11:57:25 -0700
Message-Id: <20191101185729.31661-7-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191101185729.31661-1-inga.stotland@intel.com>
References: <20191101185729.31661-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds implementation for config client commands to add/update
NetKeys and AppKeys on a remote node.
---
 tools/mesh/cfgcli.c | 293 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 221 insertions(+), 72 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 9e83f7b69..bf85a3097 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -34,10 +34,19 @@
 
 #include "tools/mesh/util.h"
 #include "tools/mesh/model.h"
+#include "tools/mesh/keys.h"
+#include "tools/mesh/remote.h"
 #include "tools/mesh/config-model.h"
 #include "tools/mesh/cfgcli.h"
 
 #define MIN_COMPOSITION_LEN 16
+#define NO_RESPONSE 0xFFFFFFFF
+
+struct cfg_cmd {
+	uint32_t opcode;
+	uint32_t resp;
+	const char *desc;
+};
 
 static void *send_data;
 static model_send_msg_func_t send_msg;
@@ -48,6 +57,113 @@ static key_send_func_t send_key_msg;
 static uint16_t target = UNASSIGNED_ADDRESS;
 static uint32_t parms[8];
 
+static struct cfg_cmd cmds[] = {
+	{ OP_APPKEY_ADD, OP_APPKEY_STATUS, "AppKeyAdd" },
+	{ OP_APPKEY_DELETE, OP_APPKEY_STATUS, "AppKeyDelete" },
+	{ OP_APPKEY_GET, OP_APPKEY_LIST, "AppKeyGet"},
+	{ OP_APPKEY_LIST, NO_RESPONSE, "AppKeyList"},
+	{ OP_APPKEY_STATUS, NO_RESPONSE, "AppKeyStatus"},
+	{ OP_APPKEY_UPDATE, OP_APPKEY_STATUS, "AppKeyUpdate" },
+	{ OP_DEV_COMP_GET, OP_DEV_COMP_STATUS, "DeviceCompositionGet" },
+	{ OP_DEV_COMP_STATUS, NO_RESPONSE, "DeviceCompositionStatus" },
+	{ OP_CONFIG_BEACON_GET, OP_CONFIG_BEACON_STATUS, "BeaconGet" },
+	{ OP_CONFIG_BEACON_SET, OP_CONFIG_BEACON_STATUS, "BeaconSet" },
+	{ OP_CONFIG_BEACON_STATUS, NO_RESPONSE, "BeaconStatus" },
+	{ OP_CONFIG_DEFAULT_TTL_GET, OP_CONFIG_DEFAULT_TTL_STATUS,
+							"DefaultTTLGet" },
+	{ OP_CONFIG_DEFAULT_TTL_SET, OP_CONFIG_DEFAULT_TTL_STATUS,
+							"DefaultTTLSet" },
+	{ OP_CONFIG_DEFAULT_TTL_STATUS, NO_RESPONSE, "DefaultTTLStatus" },
+	{ OP_CONFIG_FRIEND_GET, OP_CONFIG_FRIEND_STATUS, "FriendGet" },
+	{ OP_CONFIG_FRIEND_SET, OP_CONFIG_FRIEND_STATUS, "FrienSet" },
+	{ OP_CONFIG_FRIEND_STATUS, NO_RESPONSE, "FriendStatus" },
+	{ OP_CONFIG_PROXY_GET, OP_CONFIG_PROXY_STATUS, "ProxyGet" },
+	{ OP_CONFIG_PROXY_SET, OP_CONFIG_PROXY_STATUS, "ProxySet" },
+	{ OP_CONFIG_PROXY_STATUS, NO_RESPONSE, "ProxyStatus" },
+	{ OP_CONFIG_KEY_REFRESH_PHASE_GET, OP_CONFIG_KEY_REFRESH_PHASE_STATUS,
+							"KeyRefreshPhaseGet" },
+	{ OP_CONFIG_KEY_REFRESH_PHASE_SET, OP_CONFIG_KEY_REFRESH_PHASE_STATUS,
+							"KeyRefreshPhaseSet" },
+	{ OP_CONFIG_KEY_REFRESH_PHASE_STATUS, NO_RESPONSE,
+						"KeyRefreshPhaseStatus" },
+	{ OP_CONFIG_MODEL_PUB_GET, OP_CONFIG_MODEL_PUB_STATUS, "ModelPubGet" },
+	{ OP_CONFIG_MODEL_PUB_SET, OP_CONFIG_MODEL_PUB_STATUS, "ModelPubSet" },
+	{ OP_CONFIG_MODEL_PUB_STATUS, NO_RESPONSE, "ModelPubStatus" },
+	{ OP_CONFIG_MODEL_PUB_VIRT_SET, OP_CONFIG_MODEL_PUB_STATUS,
+							"ModelPubVirtualSet" },
+	{ OP_CONFIG_MODEL_SUB_ADD, OP_CONFIG_MODEL_SUB_STATUS, "ModelSubAdd" },
+	{ OP_CONFIG_MODEL_SUB_DELETE, OP_CONFIG_MODEL_SUB_STATUS,
+							"ModelSubDelete" },
+	{ OP_CONFIG_MODEL_SUB_DELETE_ALL, OP_CONFIG_MODEL_SUB_STATUS,
+							"ModelSubDeleteAll" },
+	{ OP_CONFIG_MODEL_SUB_OVERWRITE, OP_CONFIG_MODEL_SUB_STATUS,
+							"ModelSubOverwrite" },
+	{ OP_CONFIG_MODEL_SUB_STATUS, NO_RESPONSE, "ModelSubStatus" },
+	{ OP_CONFIG_MODEL_SUB_VIRT_ADD, OP_CONFIG_MODEL_SUB_STATUS,
+							"ModelSubVirtAdd" },
+	{ OP_CONFIG_MODEL_SUB_VIRT_DELETE, OP_CONFIG_MODEL_SUB_STATUS,
+							"ModelSubVirtDelete" },
+	{ OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE, OP_CONFIG_MODEL_SUB_STATUS,
+						"ModelSubVirtOverwrite" },
+	{ OP_CONFIG_NETWORK_TRANSMIT_GET, OP_CONFIG_NETWORK_TRANSMIT_STATUS,
+							"NetworkTransmitGet" },
+	{ OP_CONFIG_NETWORK_TRANSMIT_SET, OP_CONFIG_NETWORK_TRANSMIT_STATUS,
+							"NetworkTransmitSet" },
+	{ OP_CONFIG_NETWORK_TRANSMIT_STATUS, NO_RESPONSE,
+						"NetworkTransmitStatus" },
+	{ OP_CONFIG_RELAY_GET, OP_CONFIG_RELAY_STATUS, "RelayGet" },
+	{ OP_CONFIG_RELAY_SET, OP_CONFIG_RELAY_STATUS, "RelaySet" },
+	{ OP_CONFIG_RELAY_STATUS, NO_RESPONSE, "RelayStatus" },
+	{ OP_CONFIG_MODEL_SUB_GET, OP_CONFIG_MODEL_SUB_LIST, "ModelSubGet" },
+	{ OP_CONFIG_MODEL_SUB_LIST, NO_RESPONSE, "ModelSubList" },
+	{ OP_CONFIG_VEND_MODEL_SUB_GET, OP_CONFIG_VEND_MODEL_SUB_LIST,
+							"VendorModelSubGet" },
+	{ OP_CONFIG_VEND_MODEL_SUB_LIST, NO_RESPONSE, "VendorModelSubList" },
+	{ OP_CONFIG_POLL_TIMEOUT_LIST, OP_CONFIG_POLL_TIMEOUT_STATUS,
+							"PollTimeoutList" },
+	{ OP_CONFIG_POLL_TIMEOUT_STATUS, NO_RESPONSE, "PollTimeoutStatus" },
+	{ OP_CONFIG_HEARTBEAT_PUB_GET, OP_CONFIG_HEARTBEAT_PUB_STATUS,
+							"HeartbeatPubGet" },
+	{ OP_CONFIG_HEARTBEAT_PUB_SET, OP_CONFIG_HEARTBEAT_PUB_STATUS,
+							"HeartbeatPubSet" },
+	{ OP_CONFIG_HEARTBEAT_PUB_STATUS, NO_RESPONSE, "HeartbeatPubStatus" },
+	{ OP_CONFIG_HEARTBEAT_SUB_GET, OP_CONFIG_HEARTBEAT_SUB_GET,
+							"HeartbeatSubGet" },
+	{ OP_CONFIG_HEARTBEAT_SUB_SET, OP_CONFIG_HEARTBEAT_SUB_GET,
+							"HeartbeatSubSet" },
+	{ OP_CONFIG_HEARTBEAT_SUB_STATUS, NO_RESPONSE, "HeartbeatSubStatus" },
+	{ OP_MODEL_APP_BIND, OP_MODEL_APP_STATUS, "ModelAppBind" },
+	{ OP_MODEL_APP_STATUS, NO_RESPONSE, "ModelAppStatus" },
+	{ OP_MODEL_APP_UNBIND, OP_MODEL_APP_STATUS, "ModelAppUnbind" },
+	{ OP_NETKEY_ADD, OP_NETKEY_STATUS, "NetKeyAdd" },
+	{ OP_NETKEY_DELETE, OP_NETKEY_STATUS, "NetKeyDelete" },
+	{ OP_NETKEY_GET, OP_NETKEY_LIST, "NetKeyGet" },
+	{ OP_NETKEY_LIST, NO_RESPONSE, "NetKeyList" },
+	{ OP_NETKEY_STATUS, NO_RESPONSE, "NetKeyStatus" },
+	{ OP_NETKEY_UPDATE, OP_NETKEY_STATUS, "NetKeyUpdate" },
+	{ OP_NODE_IDENTITY_GET, OP_NODE_IDENTITY_STATUS, "NodeIdentityGet" },
+	{ OP_NODE_IDENTITY_SET, OP_NODE_IDENTITY_STATUS, "NodeIdentitySet" },
+	{ OP_NODE_IDENTITY_STATUS, NO_RESPONSE, "NodeIdentityStatus" },
+	{ OP_NODE_RESET, OP_NODE_RESET_STATUS, "NodeReset" },
+	{ OP_NODE_RESET_STATUS, NO_RESPONSE, "NodeResetStatus" },
+	{ OP_MODEL_APP_GET, OP_MODEL_APP_LIST, "ModelAppGet" },
+	{ OP_MODEL_APP_LIST, NO_RESPONSE, "ModelAppList" },
+	{ OP_VEND_MODEL_APP_GET, OP_VEND_MODEL_APP_LIST, "VendorModelAppGet" },
+	{ OP_VEND_MODEL_APP_LIST, NO_RESPONSE, "VendorModelAppList" }
+};
+
+static const char *opcode_str(uint32_t opcode)
+{
+	uint32_t n;
+
+	for (n = 0; n < L_ARRAY_SIZE(cmds); n++) {
+		if (opcode == cmds[n].opcode)
+			return cmds[n].desc;
+	}
+
+	return "Unknown";
+}
+
 static uint32_t print_mod_id(uint8_t *data, bool vid, const char *offset)
 {
 	uint32_t mod_id;
@@ -162,6 +278,8 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 	} else
 		return false;
 
+	bt_shell_printf("Received %s\n", opcode_str(opcode));
+
 	switch (opcode & ~OP_UNRELIABLE) {
 	default:
 		return false;
@@ -437,14 +555,20 @@ static void cmd_dst_set(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static bool config_send(uint8_t *buf, uint16_t len)
+static bool config_send(uint8_t *buf, uint16_t len, uint32_t opcode)
 {
+	bool res;
+
 	if (IS_UNASSIGNED(target)) {
 		bt_shell_printf("Destination not set\n");
 		return false;
 	}
 
-	return send_msg(send_data, target, APP_IDX_DEV_REMOTE, buf, len);
+	res = send_msg(send_data, target, APP_IDX_DEV_REMOTE, buf, len);
+	if (!res)
+		bt_shell_printf("Failed to send \"%s\"\n", opcode_str(opcode));
+
+	return res;
 }
 
 static void cmd_default(uint32_t opcode)
@@ -454,11 +578,8 @@ static void cmd_default(uint32_t opcode)
 
 	n = mesh_opcode_set(opcode, msg);
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send command (opcode 0x%x)\n",
-								opcode);
+	if (!config_send(msg, n, opcode))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -473,10 +594,8 @@ static void cmd_composition_get(int argc, char *argv[])
 	/* By default, use page 0 */
 	msg[n++] = (read_input_parameters(argc, argv) == 1) ? parms[0] : 0;
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"GET NODE COMPOSITION\"\n");
+	if (!config_send(msg, n, OP_DEV_COMP_GET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -486,6 +605,11 @@ static void cmd_netkey_del(int argc, char *argv[])
 	uint16_t n;
 	uint8_t msg[32];
 
+	if (IS_UNASSIGNED(target)) {
+		bt_shell_printf("Destination not set\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
 	n = mesh_opcode_set(OP_NETKEY_DELETE, msg);
 
 	if (read_input_parameters(argc, argv) != 1) {
@@ -493,45 +617,98 @@ static void cmd_netkey_del(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	put_le16(target + parms[0], msg + n);
+	put_le16(parms[0], msg + n);
 	n += 2;
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"DEL_NET KEY\"\n");
+	if (!config_send(msg, n, OP_NETKEY_DELETE))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_appkey_del(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	uint16_t app_idx, net_idx;
+
+	if (IS_UNASSIGNED(target)) {
+		bt_shell_printf("Destination not set\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	n = mesh_opcode_set(OP_APPKEY_DELETE, msg);
+
+	if (read_input_parameters(argc, argv) != 1) {
+		bt_shell_printf("Bad arguments %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	app_idx = (uint16_t) parms[0];
+	net_idx = keys_get_bound_key(app_idx);
+
+	/* Pack bound NetKey and AppKey into 3 octets */
+	msg[n] = net_idx;
+	msg[n + 1] = ((net_idx >> 8) & 0xf) | ((app_idx << 4) & 0xf0);
+	msg[n + 2] = app_idx >> 4;
+
+	n += 3;
+
+	if (!config_send(msg, n, OP_APPKEY_DELETE))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_key_add(uint32_t opcode, int argc, char *argv[])
+{
+	uint16_t key_idx;
+	bool is_appkey, update;
+
+	if (IS_UNASSIGNED(target)) {
+		bt_shell_printf("Destination not set\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+	if (!send_key_msg) {
+		bt_shell_printf("Send key callback not set\n");
+		return;
+	}
+
+	if (read_input_parameters(argc, argv) != 1) {
+		bt_shell_printf("Bad arguments %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	key_idx = (uint16_t) parms[0];
+
+	update = (opcode == OP_NETKEY_UPDATE || opcode == OP_APPKEY_UPDATE);
+	is_appkey = (opcode == OP_APPKEY_ADD || opcode == OP_APPKEY_UPDATE);
+
+	if (!send_key_msg(key_data, target, key_idx, is_appkey, update))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_netkey_add(int argc, char *argv[])
 {
-	/*TODO*/
-	bt_shell_printf("Not implemented\n");
+	cmd_key_add(OP_NETKEY_ADD, argc, argv);
 }
 
 static void cmd_netkey_update(int argc, char *argv[])
 {
-	/*TODO*/
-	bt_shell_printf("Not implemented\n");
+	cmd_key_add(OP_NETKEY_UPDATE, argc, argv);
 }
 
 static void cmd_appkey_add(int argc, char *argv[])
 {
-	/*TODO*/
-	bt_shell_printf("Not implemented\n");
+	cmd_key_add(OP_APPKEY_ADD, argc, argv);
 }
 
 static void cmd_appkey_update(int argc, char *argv[])
 {
-	/*TODO*/
-	bt_shell_printf("Not implemented\n");
-}
-
-static void cmd_appkey_del(int argc, char *argv[])
-{
-	/*TODO*/
-	bt_shell_printf("Not implemented\n");
+	cmd_key_add(OP_APPKEY_UPDATE, argc, argv);
 }
 
 static void cmd_bind(int argc, char *argv[])
@@ -548,7 +725,7 @@ static void cmd_bind(int argc, char *argv[])
 
 	n = mesh_opcode_set(OP_MODEL_APP_BIND, msg);
 
-	put_le16(target + parms[0], msg + n);
+	put_le16(parms[0], msg + n);
 	n += 2;
 	put_le16(parms[1], msg + n);
 	n += 2;
@@ -562,10 +739,8 @@ static void cmd_bind(int argc, char *argv[])
 		n += 2;
 	}
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"MODEL APP BIND\"\n");
+	if (!config_send(msg, n, OP_MODEL_APP_BIND))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -586,10 +761,8 @@ static void cmd_beacon_set(int argc, char *argv[])
 
 	msg[n++] = parms[0];
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"SET BEACON\"\n");
-		return;
-	}
+	if (!config_send(msg, n, OP_CONFIG_BEACON_SET))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -617,10 +790,8 @@ static void cmd_ident_set(int argc, char *argv[])
 	n += 2;
 	msg[n++] = parms[1];
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"SET IDENTITY\"\n");
-		return;
-	}
+	if (!config_send(msg, n, OP_NODE_IDENTITY_SET))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -642,10 +813,8 @@ static void cmd_ident_get(int argc, char *argv[])
 	put_le16(parms[0], msg + n);
 	n += 2;
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"GET IDENTITY\"\n");
+	if (!config_send(msg, n, OP_NODE_IDENTITY_GET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -666,10 +835,8 @@ static void cmd_proxy_set(int argc, char *argv[])
 
 	msg[n++] = parms[0];
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"SET PROXY\"\n");
+	if (!config_send(msg, n, OP_CONFIG_PROXY_SET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -696,10 +863,8 @@ static void cmd_relay_set(int argc, char *argv[])
 	msg[n++] = parms[0];
 	msg[n++] = (parms[1] << 5) | parms[2];
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"SET RELAY\"\n");
+	if (!config_send(msg, n, OP_CONFIG_RELAY_SET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -724,10 +889,8 @@ static void cmd_ttl_set(int argc, char *argv[])
 	n = mesh_opcode_set(OP_CONFIG_DEFAULT_TTL_SET, msg);
 	msg[n++] = parms[0];
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"SET_DEFAULT TTL\"\n");
+	if (!config_send(msg, n, OP_CONFIG_DEFAULT_TTL_SET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -771,10 +934,8 @@ static void cmd_pub_set(int argc, char *argv[])
 		n += 2;
 	}
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"SET MODEL PUBLICATION\"\n");
+	if (!config_send(msg, n, OP_CONFIG_MODEL_PUB_SET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -807,10 +968,8 @@ static void cmd_pub_get(int argc, char *argv[])
 		n += 2;
 	}
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"GET MODEL PUBLICATION\"\n");
+	if (!config_send(msg, n, OP_CONFIG_MODEL_PUB_GET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -840,10 +999,8 @@ static void cmd_sub_add(int argc, char *argv[])
 	put_le16(parms[2], msg + n);
 	n += 2;
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"ADD SUBSCRIPTION\"\n");
+	if (!config_send(msg, n, OP_CONFIG_MODEL_SUB_ADD))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -870,10 +1027,8 @@ static void cmd_sub_get(int argc, char *argv[])
 	put_le16(parms[1], msg + n);
 	n += 2;
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"GET SUB GET\"\n");
+	if (!config_send(msg, n, OP_CONFIG_MODEL_SUB_GET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -900,10 +1055,8 @@ static void cmd_mod_appidx_get(int argc, char *argv[])
 	put_le16(parms[1], msg + n);
 	n += 2;
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"GET APP GET\"\n");
+	if (!config_send(msg, n, OP_MODEL_APP_GET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -939,10 +1092,8 @@ static void cmd_hb_pub_set(int argc, char *argv[])
 	put_le16(parms[5], msg + n);
 	n += 2;
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"SET HEARTBEAT PUBLISH\"\n");
+	if (!config_send(msg, n, OP_CONFIG_HEARTBEAT_PUB_SET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -976,10 +1127,8 @@ static void cmd_hb_sub_set(int argc, char *argv[])
 	/* Period log */
 	msg[n++] = parms[2];
 
-	if (!config_send(msg, n)) {
-		bt_shell_printf("Failed to send \"SET HEARTBEAT SUBSCRIBE\"\n");
+	if (!config_send(msg, n, OP_CONFIG_HEARTBEAT_SUB_SET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -1030,7 +1179,7 @@ static const struct bt_shell_menu cfg_menu = {
 				"Add application key"},
 	{"appkey-del", "<app_idx>", cmd_appkey_del,
 				"Delete application key"},
-	{"bind", "<ele_idx> <app_idx> <mod_id> [vendor_id]", cmd_bind,
+	{"bind", "<ele_addr> <app_idx> <mod_id> [vendor_id]", cmd_bind,
 				"Bind app key to a model"},
 	{"mod-appidx-get", "<ele_addr> <model id>", cmd_mod_appidx_get,
 				"Get model app_idx"},
-- 
2.21.0

