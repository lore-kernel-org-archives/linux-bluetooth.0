Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH 2/3] mesh: meshctl: Conform command and function names
Date: Mon,  5 Feb 2018 16:28:47 -0500
Message-Id: <20180205212848.27856-2-sbrown@cortland.com>
In-Reply-To: <20180205212848.27856-1-sbrown@cortland.com>
References: <20180205212848.27856-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also improve readability of commands descriptions
---
 mesh/config-client.c | 78 ++++++++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index bf91aa5de..a0c8fa494 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -371,7 +371,7 @@ static uint32_t read_input_parameters(int argc, char *argv[])
 	return i;
 }
 
-static void cmd_set_node(int argc, char *argv[])
+static void cmd_node_set(int argc, char *argv[])
 {
 	uint32_t dst;
 	char *end;
@@ -425,7 +425,7 @@ static void cmd_default(uint32_t opcode)
 								opcode);
 }
 
-static void cmd_get_composition(int argc, char *argv[])
+static void cmd_composition_get(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
@@ -512,12 +512,12 @@ static void cmd_net_key(int argc, char *argv[], uint32_t opcode)
 
 }
 
-static void cmd_add_net_key(int argc, char *argv[])
+static void cmd_netkey_add(int argc, char *argv[])
 {
 	cmd_net_key(argc, argv, OP_NETKEY_ADD);
 }
 
-static void cmd_del_net_key(int argc, char *argv[])
+static void cmd_netkey_del(int argc, char *argv[])
 {
 	cmd_net_key(argc, argv, OP_NETKEY_DELETE);
 }
@@ -589,12 +589,12 @@ static void cmd_app_key(int argc, char *argv[], uint32_t opcode)
 	}
 }
 
-static void cmd_add_app_key(int argc, char *argv[])
+static void cmd_appkey_add(int argc, char *argv[])
 {
 	cmd_app_key(argc, argv, OP_APPKEY_ADD);
 }
 
-static void cmd_del_app_key(int argc, char *argv[])
+static void cmd_appkey_del(int argc, char *argv[])
 {
 	cmd_app_key(argc, argv, OP_APPKEY_DELETE);
 }
@@ -656,7 +656,7 @@ static void cmd_bind(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"MODEL APP BIND\"\n");
 }
 
-static void cmd_set_ident(int argc, char *argv[])
+static void cmd_ident_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[2 + 3 + 4];
@@ -681,7 +681,7 @@ static void cmd_set_ident(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"SET IDENTITY\"\n");
 }
 
-static void cmd_get_ident(int argc, char *argv[])
+static void cmd_ident_get(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[2 + 2 + 4];
@@ -705,7 +705,7 @@ static void cmd_get_ident(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"GET IDENTITY\"\n");
 }
 
-static void cmd_set_proxy(int argc, char *argv[])
+static void cmd_proxy_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[2 + 1 + 4];
@@ -729,12 +729,12 @@ static void cmd_set_proxy(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"SET PROXY\"\n");
 }
 
-static void cmd_get_proxy(int argc, char *argv[])
+static void cmd_proxy_get(int argc, char *argv[])
 {
 	cmd_default(OP_CONFIG_PROXY_GET);
 }
 
-static void cmd_set_relay(int argc, char *argv[])
+static void cmd_relay_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[2 + 2 + 4];
@@ -758,12 +758,12 @@ static void cmd_set_relay(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"SET RELAY\"\n");
 }
 
-static void cmd_get_relay(int argc, char *argv[])
+static void cmd_relay_get(int argc, char *argv[])
 {
 	cmd_default(OP_CONFIG_RELAY_GET);
 }
 
-static void cmd_set_ttl(int argc, char *argv[])
+static void cmd_ttl_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
@@ -789,7 +789,7 @@ static void cmd_set_ttl(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"SET_DEFAULT TTL\"\n");
 }
 
-static void cmd_set_pub(int argc, char *argv[])
+static void cmd_pub_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
@@ -834,7 +834,7 @@ static void cmd_set_pub(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"SET MODEL PUBLICATION\"\n");
 }
 
-static void cmd_get_pub(int argc, char *argv[])
+static void cmd_pub_get(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
@@ -935,7 +935,7 @@ static void cmd_sub_get(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"GET SUB GET\"\n");
 }
 
-static void cmd_get_app(int argc, char *argv[])
+static void cmd_mod_appidx_get(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
@@ -1049,7 +1049,7 @@ static void cmd_hb_sub_get(int argc, char *argv[])
 	cmd_default(OP_CONFIG_HEARTBEAT_SUB_GET);
 }
 
-static void cmd_get_ttl(int argc, char *argv[])
+static void cmd_ttl_get(int argc, char *argv[])
 {
 	cmd_default(OP_CONFIG_DEFAULT_TTL_GET);
 }
@@ -1058,42 +1058,44 @@ static const struct bt_shell_menu cfg_menu = {
 	.name = "config",
 	.desc = "Configuration Model Submenu",
 	.entries = {
-	{"target",		"<unicast>",		cmd_set_node,
+	{"target",		"<unicast>",		cmd_node_set,
 						"Set target node to configure"},
-	{"composition-get",	"[page_num]",		cmd_get_composition,
-						"Get Composition Data"},
-	{"netkey-add",		"<net_idx>",		cmd_add_net_key,
+	{"composition-get",	"[page_num]",		cmd_composition_get,
+						"Get composition data"},
+	{"netkey-add",		"<net_idx>",		cmd_netkey_add,
 						"Add network key"},
-	{"netkey-del",		"<net_idx>",		cmd_del_net_key,
+	{"netkey-del",		"<net_idx>",		cmd_netkey_del,
 						"Delete network key"},
-	{"appkey-add",		"<app_idx>",		cmd_add_app_key,
+	{"appkey-add",		"<app_idx>",		cmd_appkey_add,
 						"Add application key"},
-	{"appkey-del",		"<app_idx>",		cmd_del_app_key,
+	{"appkey-del",		"<app_idx>",		cmd_appkey_del,
 						"Delete application key"},
 	{"bind",		"<ele_idx> <app_idx> <mod_id> [cid]",
 				cmd_bind,	"Bind app key to a model"},
-	{"ttl-set",		"<ttl>",		cmd_set_ttl,
+	{"mod-appidx-get", "<ele_addr> <model id>",
+				cmd_mod_appidx_get,    "Get model app_idx"},
+	{"ttl-set",		"<ttl>",		cmd_ttl_set,
 						"Set default TTL"},
-	{"ttl-get",		NULL,			cmd_get_ttl,
+	{"ttl-get",		NULL,			cmd_ttl_get,
 						"Get default TTL"},
 	{"pub-set", "<ele_addr> <pub_addr> <app_idx> "
 			"<per (step|res)> <re-xmt (cnt|per)> <mod id> "
 			"[cid]",
-			cmd_set_pub,	"\n\t\t\t\t\t\t  Set publication"},
-	{"pub-get", "<ele_addr> <model>",               cmd_get_pub,
+			cmd_pub_set,	"\n\t\t\t\t\t\t  Set publication"},
+	{"pub-get", "<ele_addr> <model>",               cmd_pub_get,
 						"Get publication"},
-	{"proxy-set",           "<proxy>",              cmd_set_proxy,
+	{"proxy-set",           "<proxy>",              cmd_proxy_set,
 						"Set proxy state"},
-	{"proxy-get",           NULL,                   cmd_get_proxy,
+	{"proxy-get",           NULL,                   cmd_proxy_get,
 						"Get proxy state"},
-	{"ident-set",           "<net_idx> <state>",    cmd_set_ident,
+	{"ident-set",           "<net_idx> <state>",    cmd_ident_set,
 						"Set node identity state"},
-	{"ident-get",           "<net_idx>",            cmd_get_ident,
+	{"ident-get",           "<net_idx>",            cmd_ident_get,
 						"Get node identity state"},
 	{"relay-set",           "<relay> <rexmt count> <rexmt steps>",
-						cmd_set_relay,
+						cmd_relay_set,
 						"Set relay"},
-	{"relay-get",           NULL,                   cmd_get_relay,
+	{"relay-get",           NULL,                   cmd_relay_get,
 						"Get relay"},
 	{"hb-pub-set", "<pub_addr> <count> <period> <features> <net_idx>",
 				cmd_hb_pub_set,     "Set heartbeat publish"},
@@ -1104,11 +1106,9 @@ static const struct bt_shell_menu cfg_menu = {
 	{"hb-sub-get",           NULL,                   cmd_hb_sub_get,
 						"Get heartbeat subscribe"},
 	{"sub-add", "<ele_addr> <sub_addr> <model id>",
-				cmd_sub_add,    "Subscription add"},
+				cmd_sub_add,    "Add subscription"},
 	{"sub-get", "<ele_addr> <model id>",
-				cmd_sub_get,    "Subscription get"},
-	{"app-get", "<ele_addr> <model id>",
-				cmd_get_app,    "Get App Keys"},
+				cmd_sub_get,    "Get subscription"},
 	{} },
 };
 
@@ -1117,7 +1117,7 @@ void config_client_get_composition(uint32_t dst)
 	uint32_t tmp = target;
 
 	target = dst;
-	cmd_get_composition(0, NULL);
+	cmd_composition_get(0, NULL);
 	target = tmp;
 }
 
-- 
2.14.1

