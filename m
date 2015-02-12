Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 3/5] tools/btmgmt: Rewrite interactive mode on top of client code
Date: Thu, 12 Feb 2015 18:52:11 +0100
Message-Id: <1423763533-15071-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423763533-15071-1-git-send-email-szymon.janc@tieto.com>
References: <1423763533-15071-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move direct readline dependency out of btmgmt and use common
interactive code.
---
 tools/btmgmt.c | 739 ++++++++++++++++-----------------------------------------
 1 file changed, 198 insertions(+), 541 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index abc2fd0..b02af35 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -37,10 +37,7 @@
 #include <poll.h>
 #include <getopt.h>
 #include <stdbool.h>
-#include <wordexp.h>
-
-#include <readline/readline.h>
-#include <readline/history.h>
+#include <ctype.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -64,9 +61,6 @@ static bool discovery = false;
 static bool resolve_names = true;
 static bool interactive = false;
 
-static char *saved_prompt = NULL;
-static int saved_point = 0;
-
 static struct {
 	uint16_t index;
 	uint16_t req;
@@ -83,6 +77,14 @@ static int pending_index = 0;
 
 #define PROMPT_ON	COLOR_BLUE "[mgmt]" COLOR_OFF "# "
 
+static int get_index(void)
+{
+	if (mgmt_index == MGMT_INDEX_NONE)
+		return 0;
+
+	return mgmt_index;
+}
+
 static void update_prompt(uint16_t index)
 {
 	char str[32];
@@ -94,13 +96,7 @@ static void update_prompt(uint16_t index)
 		snprintf(str, sizeof(str),
 				COLOR_BLUE "[hci%u]" COLOR_OFF "# ", index);
 
-	if (saved_prompt) {
-		free(saved_prompt);
-		saved_prompt = strdup(str);
-		return;
-	}
-
-	rl_set_prompt(str);
+	interactive_update_prompt(str);
 }
 
 static void noninteractive_quit(int status)
@@ -383,19 +379,7 @@ static void release_prompt(void)
 	memset(&prompt, 0, sizeof(prompt));
 	prompt.index = MGMT_INDEX_NONE;
 
-	if (!saved_prompt)
-		return;
-
-	/* This will cause rl_expand_prompt to re-run over the last prompt,
-	 * but our prompt doesn't expand anyway.
-	 */
-	rl_set_prompt(saved_prompt);
-	rl_replace_line("", 0);
-	rl_point = saved_point;
-	rl_redisplay();
-
-	free(saved_prompt);
-	saved_prompt = NULL;
+	interactive_release_prompt();
 }
 
 static void disconnected(uint16_t index, uint16_t len, const void *param,
@@ -801,26 +785,6 @@ static bool prompt_input(const char *input)
 	return true;
 }
 
-static void btmgmt_interactive_prompt(const char *msg)
-{
-	if (saved_prompt)
-		return;
-
-	saved_prompt = strdup(rl_prompt);
-	if (!saved_prompt)
-		return;
-
-	saved_point = rl_point;
-
-	rl_set_prompt("");
-	rl_redisplay();
-
-	rl_set_prompt(msg);
-
-	rl_replace_line("", 0);
-	rl_redisplay();
-}
-
 static size_t get_input(char *buf, size_t buf_len)
 {
 	size_t len;
@@ -856,7 +820,7 @@ static void ask(uint16_t index, uint16_t req, const struct mgmt_addr_info *addr,
 					COLOR_BOLDGRAY ">>" COLOR_OFF);
 
 	if (interactive) {
-		btmgmt_interactive_prompt(msg);
+		interactive_prompt(msg);
 		va_end(ap);
 		return;
 	}
@@ -972,8 +936,7 @@ done:
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_version(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_version(int argc, char **argv)
 {
 	if (mgmt_send(mgmt, MGMT_OP_READ_VERSION, MGMT_INDEX_NONE,
 				0, NULL, version_rsp, NULL, NULL) == 0) {
@@ -1032,8 +995,7 @@ done:
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_commands(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_commands(int argc, char **argv)
 {
 	if (mgmt_send(mgmt, MGMT_OP_READ_COMMANDS, MGMT_INDEX_NONE,
 				0, NULL, commands_rsp, NULL, NULL) == 0) {
@@ -1112,11 +1074,11 @@ done:
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_config(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_config(int argc, char **argv)
 {
 	void *data;
 
-	if (index == MGMT_INDEX_NONE) {
+	if (mgmt_index == MGMT_INDEX_NONE) {
 		if (mgmt_send(mgmt, MGMT_OP_READ_UNCONF_INDEX_LIST,
 					MGMT_INDEX_NONE, 0, NULL,
 					unconf_index_rsp, mgmt, NULL) == 0) {
@@ -1127,9 +1089,9 @@ static void cmd_config(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 		return;
 	}
 
-	data = UINT_TO_PTR(index);
+	data = UINT_TO_PTR(mgmt_index);
 
-	if (mgmt_send(mgmt, MGMT_OP_READ_CONFIG_INFO, index, 0, NULL,
+	if (mgmt_send(mgmt, MGMT_OP_READ_CONFIG_INFO, mgmt_index, 0, NULL,
 					config_info_rsp, data, NULL) == 0) {
 		error("Unable to send read_config_info cmd");
 		return noninteractive_quit(EXIT_FAILURE);
@@ -1228,11 +1190,11 @@ static void index_rsp(uint8_t status, uint16_t len, const void *param,
 		noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_info(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_info(int argc, char **argv)
 {
 	void *data;
 
-	if (index == MGMT_INDEX_NONE) {
+	if (mgmt_index == MGMT_INDEX_NONE) {
 		if (mgmt_send(mgmt, MGMT_OP_READ_INDEX_LIST,
 					MGMT_INDEX_NONE, 0, NULL,
 					index_rsp, mgmt, NULL) == 0) {
@@ -1243,9 +1205,9 @@ static void cmd_info(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 		return;
 	}
 
-	data = UINT_TO_PTR(index);
+	data = UINT_TO_PTR(mgmt_index);
 
-	if (mgmt_send(mgmt, MGMT_OP_READ_INFO, index, 0, NULL, info_rsp,
+	if (mgmt_send(mgmt, MGMT_OP_READ_INFO, mgmt_index, 0, NULL, info_rsp,
 							data, NULL) == 0) {
 		error("Unable to send read_info cmd");
 		return noninteractive_quit(EXIT_FAILURE);
@@ -1333,24 +1295,21 @@ static void cmd_setting(struct mgmt *mgmt, uint16_t index, uint16_t op,
 	else
 		val = atoi(argv[1]);
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	if (send_cmd(mgmt, op, index, sizeof(val), &val, setting_rsp) == 0) {
 		error("Unable to send %s cmd", mgmt_opstr(op));
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
-static void cmd_power(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_power(int argc, char **argv)
 {
-	cmd_setting(mgmt, index, MGMT_OP_SET_POWERED, argc, argv);
+	cmd_setting(mgmt, get_index(), MGMT_OP_SET_POWERED, argc, argv);
 }
 
-static void cmd_discov(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_discov(int argc, char **argv)
 {
 	struct mgmt_cp_set_discoverable cp;
+	int index;
 
 	if (argc < 2) {
 		print("Usage: btmgmt %s <yes/no/limited> [timeout]", argv[0]);
@@ -1371,8 +1330,7 @@ static void cmd_discov(struct mgmt *mgmt, uint16_t index, int argc,
 	if (argc > 2)
 		cp.timeout = htobs(atoi(argv[2]));
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
+	index = get_index();
 
 	if (send_cmd(mgmt, MGMT_OP_SET_DISCOVERABLE, index, sizeof(cp), &cp,
 							setting_rsp) == 0) {
@@ -1381,36 +1339,33 @@ static void cmd_discov(struct mgmt *mgmt, uint16_t index, int argc,
 	}
 }
 
-static void cmd_connectable(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_connectable(int argc, char **argv)
 {
-	cmd_setting(mgmt, index, MGMT_OP_SET_CONNECTABLE, argc, argv);
+	cmd_setting(mgmt, get_index(), MGMT_OP_SET_CONNECTABLE, argc, argv);
 }
 
-static void cmd_fast_conn(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_fast_conn(int argc, char **argv)
 {
-	cmd_setting(mgmt, index, MGMT_OP_SET_FAST_CONNECTABLE, argc, argv);
+	cmd_setting(mgmt, get_index(), MGMT_OP_SET_FAST_CONNECTABLE, argc,
+									argv);
 }
 
-static void cmd_bondable(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_bondable(int argc, char **argv)
 {
-	cmd_setting(mgmt, index, MGMT_OP_SET_BONDABLE, argc, argv);
+	cmd_setting(mgmt, get_index(), MGMT_OP_SET_BONDABLE, argc, argv);
 }
 
-static void cmd_linksec(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_linksec(int argc, char **argv)
 {
-	cmd_setting(mgmt, index, MGMT_OP_SET_LINK_SECURITY, argc, argv);
+	cmd_setting(mgmt, get_index(), MGMT_OP_SET_LINK_SECURITY, argc, argv);
 }
 
-static void cmd_ssp(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_ssp(int argc, char **argv)
 {
-	cmd_setting(mgmt, index, MGMT_OP_SET_SSP, argc, argv);
+	cmd_setting(mgmt, get_index(), MGMT_OP_SET_SSP, argc, argv);
 }
 
-static void cmd_sc(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_sc(int argc, char **argv)
 {
 	uint8_t val;
 
@@ -1428,39 +1383,35 @@ static void cmd_sc(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	else
 		val = atoi(argv[1]);
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
-	if (send_cmd(mgmt, MGMT_OP_SET_SECURE_CONN, index,
+	if (send_cmd(mgmt, MGMT_OP_SET_SECURE_CONN, get_index(),
 					sizeof(val), &val, setting_rsp) == 0) {
 		error("Unable to send set_secure_conn cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
-static void cmd_hs(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_hs(int argc, char **argv)
 {
-	cmd_setting(mgmt, index, MGMT_OP_SET_HS, argc, argv);
+
+	cmd_setting(mgmt, get_index(), MGMT_OP_SET_HS, argc, argv);
 }
 
-static void cmd_le(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_le(int argc, char **argv)
 {
-	cmd_setting(mgmt, index, MGMT_OP_SET_LE, argc, argv);
+	cmd_setting(mgmt, get_index(), MGMT_OP_SET_LE, argc, argv);
 }
 
-static void cmd_advertising(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_advertising(int argc, char **argv)
 {
-	cmd_setting(mgmt, index, MGMT_OP_SET_ADVERTISING, argc, argv);
+	cmd_setting(mgmt, get_index(), MGMT_OP_SET_ADVERTISING, argc, argv);
 }
 
-static void cmd_bredr(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_bredr(int argc, char **argv)
 {
-	cmd_setting(mgmt, index, MGMT_OP_SET_BREDR, argc, argv);
+	cmd_setting(mgmt, get_index(), MGMT_OP_SET_BREDR, argc, argv);
 }
 
-static void cmd_privacy(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_privacy(int argc, char **argv)
 {
 	struct mgmt_cp_set_privacy cp;
 
@@ -1476,9 +1427,6 @@ static void cmd_privacy(struct mgmt *mgmt, uint16_t index, int argc,
 	else
 		cp.privacy = atoi(argv[1]);
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	if (argc > 2) {
 		if (convert_hexstr(argv[2], cp.irk,
 					sizeof(cp.irk)) != sizeof(cp.irk)) {
@@ -1503,7 +1451,7 @@ static void cmd_privacy(struct mgmt *mgmt, uint16_t index, int argc,
 		close(fd);
 	}
 
-	if (send_cmd(mgmt, MGMT_OP_SET_PRIVACY, index, sizeof(cp), &cp,
+	if (send_cmd(mgmt, MGMT_OP_SET_PRIVACY, get_index(), sizeof(cp), &cp,
 							setting_rsp) == 0) {
 		error("Unable to send Set Privacy command");
 		return noninteractive_quit(EXIT_FAILURE);
@@ -1532,7 +1480,7 @@ static void class_rsp(uint16_t op, uint16_t id, uint8_t status, uint16_t len,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_class(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_class(int argc, char **argv)
 {
 	uint8_t class[2];
 
@@ -1544,11 +1492,8 @@ static void cmd_class(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	class[0] = atoi(argv[1]);
 	class[1] = atoi(argv[2]);
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
-	if (send_cmd(mgmt, MGMT_OP_SET_DEV_CLASS, index, sizeof(class), class,
-							class_rsp) == 0) {
+	if (send_cmd(mgmt, MGMT_OP_SET_DEV_CLASS, get_index(),
+				sizeof(class), class, class_rsp) == 0) {
 		error("Unable to send set_dev_class cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
@@ -1593,8 +1538,7 @@ static struct option disconnect_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static void cmd_disconnect(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_disconnect(int argc, char **argv)
 {
 	struct mgmt_cp_disconnect cp;
 	uint8_t type = BDADDR_BREDR;
@@ -1624,14 +1568,11 @@ static void cmd_disconnect(struct mgmt *mgmt, uint16_t index, int argc,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	memset(&cp, 0, sizeof(cp));
 	str2ba(argv[0], &cp.addr.bdaddr);
 	cp.addr.type = type;
 
-	if (mgmt_send(mgmt, MGMT_OP_DISCONNECT, index, sizeof(cp), &cp,
+	if (mgmt_send(mgmt, MGMT_OP_DISCONNECT, get_index(), sizeof(cp), &cp,
 					disconnect_rsp, NULL, NULL) == 0) {
 		error("Unable to send disconnect cmd");
 		return noninteractive_quit(EXIT_FAILURE);
@@ -1667,12 +1608,9 @@ static void con_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_con(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_con(int argc, char **argv)
 {
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
-	if (mgmt_send(mgmt, MGMT_OP_GET_CONNECTIONS, index, 0, NULL,
+	if (mgmt_send(mgmt, MGMT_OP_GET_CONNECTIONS, get_index(), 0, NULL,
 						con_rsp, NULL, NULL) == 0) {
 		error("Unable to send get_connections cmd");
 		return noninteractive_quit(EXIT_FAILURE);
@@ -1718,8 +1656,7 @@ static void uuid_to_uuid128(uuid_t *uuid128, const uuid_t *uuid)
 
 #define MAX_UUIDS 4
 
-static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc,
-			     char **argv)
+static void cmd_find_service(int argc, char **argv)
 {
 	struct mgmt_cp_start_service_discovery *cp;
 	uint8_t buf[sizeof(*cp) + 16 * MAX_UUIDS];
@@ -1731,9 +1668,6 @@ static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc,
 	uint16_t count;
 	int opt;
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	type = 0;
 	type |= (1 << BDADDR_BREDR);
 	type |= (1 << BDADDR_LE_PUBLIC);
@@ -1801,7 +1735,7 @@ static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc,
 	cp->rssi = rssi;
 	cp->uuid_count = cpu_to_le16(count);
 
-	if (mgmt_send(mgmt, MGMT_OP_START_SERVICE_DISCOVERY, index,
+	if (mgmt_send(mgmt, MGMT_OP_START_SERVICE_DISCOVERY, get_index(),
 				sizeof(*cp) + count * 16, cp,
 				find_service_rsp, NULL, NULL) == 0) {
 		error("Unable to send start_service_discovery cmd");
@@ -1834,15 +1768,12 @@ static struct option find_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static void cmd_find(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_find(int argc, char **argv)
 {
 	struct mgmt_cp_start_discovery cp;
 	uint8_t type;
 	int opt;
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	type = 0;
 	type |= (1 << BDADDR_BREDR);
 	type |= (1 << BDADDR_LE_PUBLIC);
@@ -1877,8 +1808,8 @@ static void cmd_find(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	memset(&cp, 0, sizeof(cp));
 	cp.type = type;
 
-	if (mgmt_send(mgmt, MGMT_OP_START_DISCOVERY, index, sizeof(cp), &cp,
-						find_rsp, NULL, NULL) == 0) {
+	if (mgmt_send(mgmt, MGMT_OP_START_DISCOVERY, get_index(),
+				sizeof(cp), &cp, find_rsp, NULL, NULL) == 0) {
 		error("Unable to send start_discovery cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
@@ -1894,7 +1825,7 @@ static void name_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_name(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_name(int argc, char **argv)
 {
 	struct mgmt_cp_set_local_name cp;
 
@@ -1903,17 +1834,14 @@ static void cmd_name(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	memset(&cp, 0, sizeof(cp));
 	strncpy((char *) cp.name, argv[1], HCI_MAX_NAME_LENGTH);
 	if (argc > 2)
 		strncpy((char *) cp.short_name, argv[2],
 					MGMT_MAX_SHORT_NAME_LENGTH);
 
-	if (mgmt_send(mgmt, MGMT_OP_SET_LOCAL_NAME, index, sizeof(cp), &cp,
-						name_rsp, NULL, NULL) == 0) {
+	if (mgmt_send(mgmt, MGMT_OP_SET_LOCAL_NAME, get_index(),
+				sizeof(cp), &cp, name_rsp, NULL, NULL) == 0) {
 		error("Unable to send set_name cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
@@ -1963,7 +1891,7 @@ static struct option pair_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static void cmd_pair(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_pair(int argc, char **argv)
 {
 	struct mgmt_cp_pair_device cp;
 	uint8_t cap = 0x01;
@@ -1998,9 +1926,6 @@ static void cmd_pair(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	memset(&cp, 0, sizeof(cp));
 	str2ba(argv[0], &cp.addr.bdaddr);
 	cp.addr.type = type;
@@ -2009,7 +1934,7 @@ static void cmd_pair(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	ba2str(&cp.addr.bdaddr, addr);
 	print("Pairing with %s (%s)", addr, typestr(cp.addr.type));
 
-	if (mgmt_send(mgmt, MGMT_OP_PAIR_DEVICE, index, sizeof(cp), &cp,
+	if (mgmt_send(mgmt, MGMT_OP_PAIR_DEVICE, get_index(), sizeof(cp), &cp,
 						pair_rsp, NULL, NULL) == 0) {
 		error("Unable to send pair_device cmd");
 		return noninteractive_quit(EXIT_FAILURE);
@@ -2056,8 +1981,7 @@ static struct option cancel_pair_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static void cmd_cancel_pair(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_cancel_pair(int argc, char **argv)
 {
 	struct mgmt_addr_info cp;
 	uint8_t type = BDADDR_BREDR;
@@ -2087,15 +2011,12 @@ static void cmd_cancel_pair(struct mgmt *mgmt, uint16_t index, int argc,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	memset(&cp, 0, sizeof(cp));
 	str2ba(argv[0], &cp.bdaddr);
 	cp.type = type;
 
-	if (mgmt_send(mgmt, MGMT_OP_CANCEL_PAIR_DEVICE, index, sizeof(cp), &cp,
-					cancel_pair_rsp, NULL, NULL) == 0) {
+	if (mgmt_send(mgmt, MGMT_OP_CANCEL_PAIR_DEVICE, get_index(), sizeof(cp),
+				&cp, cancel_pair_rsp, NULL, NULL) == 0) {
 		error("Unable to send cancel_pair_device cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
@@ -2140,8 +2061,7 @@ static struct option unpair_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static void cmd_unpair(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_unpair(int argc, char **argv)
 {
 	struct mgmt_cp_unpair_device cp;
 	uint8_t type = BDADDR_BREDR;
@@ -2171,15 +2091,12 @@ static void cmd_unpair(struct mgmt *mgmt, uint16_t index, int argc,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	memset(&cp, 0, sizeof(cp));
 	str2ba(argv[0], &cp.addr.bdaddr);
 	cp.addr.type = type;
 	cp.disconnect = 1;
 
-	if (mgmt_send(mgmt, MGMT_OP_UNPAIR_DEVICE, index, sizeof(cp), &cp,
+	if (mgmt_send(mgmt, MGMT_OP_UNPAIR_DEVICE, get_index(), sizeof(cp), &cp,
 						unpair_rsp, NULL, NULL) == 0) {
 		error("Unable to send unpair_device cmd");
 		return noninteractive_quit(EXIT_FAILURE);
@@ -2198,17 +2115,14 @@ static void keys_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_keys(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_keys(int argc, char **argv)
 {
 	struct mgmt_cp_load_link_keys cp;
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	memset(&cp, 0, sizeof(cp));
 
-	if (mgmt_send(mgmt, MGMT_OP_LOAD_LINK_KEYS, index, sizeof(cp), &cp,
-						keys_rsp, NULL, NULL) == 0) {
+	if (mgmt_send(mgmt, MGMT_OP_LOAD_LINK_KEYS, get_index(), sizeof(cp),
+					&cp, keys_rsp, NULL, NULL) == 0) {
 		error("Unable to send load_keys cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
@@ -2226,17 +2140,14 @@ static void ltks_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_ltks(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_ltks(int argc, char **argv)
 {
 	struct mgmt_cp_load_long_term_keys cp;
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	memset(&cp, 0, sizeof(cp));
 
-	if (mgmt_send(mgmt, MGMT_OP_LOAD_LONG_TERM_KEYS, index, sizeof(cp), &cp,
-						ltks_rsp, NULL, NULL) == 0) {
+	if (mgmt_send(mgmt, MGMT_OP_LOAD_LONG_TERM_KEYS, get_index(),
+				sizeof(cp), &cp, ltks_rsp, NULL, NULL) == 0) {
 		error("Unable to send load_ltks cmd");
 		return noninteractive_quit(EXIT_SUCCESS);
 	}
@@ -2267,16 +2178,13 @@ static struct option irks_options[] = {
 
 #define MAX_IRKS 4
 
-static void cmd_irks(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_irks(int argc, char **argv)
 {
 	struct mgmt_cp_load_irks *cp;
 	uint8_t buf[sizeof(*cp) + 23 * MAX_IRKS];
 	uint16_t count, local_index;
 	int opt;
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	cp = (void *) buf;
 	count = 0;
 
@@ -2319,7 +2227,7 @@ static void cmd_irks(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 
 	cp->irk_count = cpu_to_le16(count);
 
-	if (mgmt_send(mgmt, MGMT_OP_LOAD_IRKS, index,
+	if (mgmt_send(mgmt, MGMT_OP_LOAD_IRKS, get_index(),
 					sizeof(*cp) + count * 23, cp,
 					irks_rsp, NULL, NULL) == 0) {
 		error("Unable to send load_irks cmd");
@@ -2367,7 +2275,7 @@ static struct option block_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static void cmd_block(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_block(int argc, char **argv)
 {
 	struct mgmt_cp_block_device cp;
 	uint8_t type = BDADDR_BREDR;
@@ -2397,14 +2305,11 @@ static void cmd_block(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	memset(&cp, 0, sizeof(cp));
 	str2ba(argv[0], &cp.addr.bdaddr);
 	cp.addr.type = type;
 
-	if (send_cmd(mgmt, MGMT_OP_BLOCK_DEVICE, index, sizeof(cp), &cp,
+	if (send_cmd(mgmt, MGMT_OP_BLOCK_DEVICE, get_index(), sizeof(cp), &cp,
 							block_rsp) == 0) {
 		error("Unable to send block_device cmd");
 		return noninteractive_quit(EXIT_FAILURE);
@@ -2416,8 +2321,7 @@ static void unblock_usage(void)
 	print("Usage: btmgmt unblock [-t type] <remote address>");
 }
 
-static void cmd_unblock(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_unblock(int argc, char **argv)
 {
 	struct mgmt_cp_unblock_device cp;
 	uint8_t type = BDADDR_BREDR;
@@ -2447,22 +2351,18 @@ static void cmd_unblock(struct mgmt *mgmt, uint16_t index, int argc,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	memset(&cp, 0, sizeof(cp));
 	str2ba(argv[0], &cp.addr.bdaddr);
 	cp.addr.type = type;
 
-	if (send_cmd(mgmt, MGMT_OP_UNBLOCK_DEVICE, index, sizeof(cp), &cp,
+	if (send_cmd(mgmt, MGMT_OP_UNBLOCK_DEVICE, get_index(), sizeof(cp), &cp,
 							block_rsp) == 0) {
 		error("Unable to send unblock_device cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
-static void cmd_add_uuid(struct mgmt *mgmt, uint16_t index, int argc,
-							char **argv)
+static void cmd_add_uuid(int argc, char **argv)
 {
 	struct mgmt_cp_add_uuid cp;
 	uint128_t uint128;
@@ -2473,9 +2373,6 @@ static void cmd_add_uuid(struct mgmt *mgmt, uint16_t index, int argc,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	if (bt_string2uuid(&uuid, argv[1]) < 0) {
 		print("Invalid UUID: %s", argv[1]);
 		return noninteractive_quit(EXIT_FAILURE);
@@ -2489,15 +2386,14 @@ static void cmd_add_uuid(struct mgmt *mgmt, uint16_t index, int argc,
 
 	cp.svc_hint = atoi(argv[2]);
 
-	if (send_cmd(mgmt, MGMT_OP_ADD_UUID, index, sizeof(cp), &cp,
+	if (send_cmd(mgmt, MGMT_OP_ADD_UUID, get_index(), sizeof(cp), &cp,
 							class_rsp) == 0) {
 		error("Unable to send add_uuid cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
-static void cmd_remove_uuid(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_remove_uuid(int argc, char **argv)
 {
 	struct mgmt_cp_remove_uuid cp;
 	uint128_t uint128;
@@ -2508,9 +2404,6 @@ static void cmd_remove_uuid(struct mgmt *mgmt, uint16_t index, int argc,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	if (bt_string2uuid(&uuid, argv[1]) < 0) {
 		print("Invalid UUID: %s", argv[1]);
 		return noninteractive_quit(EXIT_FAILURE);
@@ -2522,20 +2415,19 @@ static void cmd_remove_uuid(struct mgmt *mgmt, uint16_t index, int argc,
 	ntoh128((uint128_t *) uuid128.value.uuid128.data, &uint128);
 	htob128(&uint128, (uint128_t *) cp.uuid);
 
-	if (send_cmd(mgmt, MGMT_OP_REMOVE_UUID, index, sizeof(cp), &cp,
+	if (send_cmd(mgmt, MGMT_OP_REMOVE_UUID, get_index(), sizeof(cp), &cp,
 							class_rsp) == 0) {
 		error("Unable to send remove_uuid cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
-static void cmd_clr_uuids(struct mgmt *mgmt, uint16_t index, int argc,
-								char **argv)
+static void cmd_clr_uuids(int argc, char **argv)
 {
 	char *uuid_any = "00000000-0000-0000-0000-000000000000";
 	char *rm_argv[] = { "rm-uuid", uuid_any, NULL };
 
-	cmd_remove_uuid(mgmt, index, 2, rm_argv);
+	cmd_remove_uuid(2, rm_argv);
 }
 
 static void local_oob_rsp(uint8_t status, uint16_t len, const void *param,
@@ -2582,13 +2474,9 @@ static void local_oob_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_local_oob(struct mgmt *mgmt, uint16_t index,
-						int argc, char **argv)
+static void cmd_local_oob(int argc, char **argv)
 {
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
-	if (mgmt_send(mgmt, MGMT_OP_READ_LOCAL_OOB_DATA, index, 0, NULL,
+	if (mgmt_send(mgmt, MGMT_OP_READ_LOCAL_OOB_DATA, get_index(), 0, NULL,
 					local_oob_rsp, NULL, NULL) == 0) {
 		error("Unable to send read_local_oob cmd");
 		return noninteractive_quit(EXIT_FAILURE);
@@ -2629,8 +2517,7 @@ static struct option remote_oob_opt[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static void cmd_remote_oob(struct mgmt *mgmt, uint16_t index,
-						int argc, char **argv)
+static void cmd_remote_oob(int argc, char **argv)
 {
 	struct mgmt_cp_add_remote_oob_data cp;
 	int opt;
@@ -2671,14 +2558,11 @@ static void cmd_remote_oob(struct mgmt *mgmt, uint16_t index,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	str2ba(argv[0], &cp.addr.bdaddr);
 
 	print("Adding OOB data for %s (%s)", argv[0], typestr(cp.addr.type));
 
-	if (mgmt_send(mgmt, MGMT_OP_ADD_REMOTE_OOB_DATA, index,
+	if (mgmt_send(mgmt, MGMT_OP_ADD_REMOTE_OOB_DATA, get_index(),
 				sizeof(cp), &cp, remote_oob_rsp,
 				NULL, NULL) == 0) {
 		error("Unable to send add_remote_oob cmd");
@@ -2704,7 +2588,7 @@ static void did_usage(void)
 	print("       possible source values: bluetooth, usb");
 }
 
-static void cmd_did(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+static void cmd_did(int argc, char **argv)
 {
 	struct mgmt_cp_set_device_id cp;
 	uint16_t vendor, product, version , source;
@@ -2733,15 +2617,12 @@ static void cmd_did(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	return noninteractive_quit(EXIT_FAILURE);
 
 done:
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	cp.source = htobs(source);
 	cp.vendor = htobs(vendor);
 	cp.product = htobs(product);
 	cp.version = htobs(version);
 
-	if (mgmt_send(mgmt, MGMT_OP_SET_DEVICE_ID, index, sizeof(cp), &cp,
+	if (mgmt_send(mgmt, MGMT_OP_SET_DEVICE_ID, get_index(), sizeof(cp), &cp,
 						did_rsp, NULL, NULL) == 0) {
 		error("Unable to send set_device_id cmd");
 		return noninteractive_quit(EXIT_FAILURE);
@@ -2765,8 +2646,7 @@ static void static_addr_usage(void)
 	print("Usage: btmgmt static-addr <address>");
 }
 
-static void cmd_static_addr(struct mgmt *mgmt, uint16_t index,
-							int argc, char **argv)
+static void cmd_static_addr(int argc, char **argv)
 {
 	struct mgmt_cp_set_static_address cp;
 
@@ -2775,13 +2655,10 @@ static void cmd_static_addr(struct mgmt *mgmt, uint16_t index,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	str2ba(argv[1], &cp.bdaddr);
 
-	if (mgmt_send(mgmt, MGMT_OP_SET_STATIC_ADDRESS, index, sizeof(cp), &cp,
-					static_addr_rsp, NULL, NULL) == 0) {
+	if (mgmt_send(mgmt, MGMT_OP_SET_STATIC_ADDRESS, get_index(),
+			sizeof(cp), &cp, static_addr_rsp, NULL, NULL) == 0) {
 		error("Unable to send set_static_address cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
@@ -2810,8 +2687,7 @@ static void options_rsp(uint16_t op, uint16_t id, uint8_t status,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_public_addr(struct mgmt *mgmt, uint16_t index,
-						int argc, char **argv)
+static void cmd_public_addr(int argc, char **argv)
 {
 	struct mgmt_cp_set_public_address cp;
 
@@ -2820,20 +2696,16 @@ static void cmd_public_addr(struct mgmt *mgmt, uint16_t index,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	str2ba(argv[1], &cp.bdaddr);
 
-	if (send_cmd(mgmt, MGMT_OP_SET_PUBLIC_ADDRESS, index, sizeof(cp), &cp,
-							options_rsp) == 0) {
+	if (send_cmd(mgmt, MGMT_OP_SET_PUBLIC_ADDRESS, get_index(),
+					sizeof(cp), &cp, options_rsp) == 0) {
 		error("Unable to send Set Public Address cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
-static void cmd_ext_config(struct mgmt *mgmt, uint16_t index,
-						int argc, char **argv)
+static void cmd_ext_config(int argc, char **argv)
 {
 	struct mgmt_cp_set_external_config cp;
 
@@ -2849,20 +2721,16 @@ static void cmd_ext_config(struct mgmt *mgmt, uint16_t index,
 	else
 		cp.config = atoi(argv[1]);
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
-	if (send_cmd(mgmt, MGMT_OP_SET_EXTERNAL_CONFIG, index, sizeof(cp), &cp,
-							options_rsp) == 0) {
+	if (send_cmd(mgmt, MGMT_OP_SET_EXTERNAL_CONFIG, get_index(),
+					sizeof(cp), &cp, options_rsp) == 0) {
 		error("Unable to send Set External Config cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
-static void cmd_debug_keys(struct mgmt *mgmt, uint16_t index,
-						int argc, char **argv)
+static void cmd_debug_keys(int argc, char **argv)
 {
-	cmd_setting(mgmt, index, MGMT_OP_SET_DEBUG_KEYS, argc, argv);
+	cmd_setting(mgmt, get_index(), MGMT_OP_SET_DEBUG_KEYS, argc, argv);
 }
 
 static void conn_info_rsp(uint8_t status, uint16_t len, const void *param,
@@ -2908,8 +2776,7 @@ static struct option conn_info_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static void cmd_conn_info(struct mgmt *mgmt, uint16_t index,
-						int argc, char **argv)
+static void cmd_conn_info(int argc, char **argv)
 {
 	struct mgmt_cp_get_conn_info cp;
 	uint8_t type = BDADDR_BREDR;
@@ -2939,14 +2806,11 @@ static void cmd_conn_info(struct mgmt *mgmt, uint16_t index,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	memset(&cp, 0, sizeof(cp));
 	str2ba(argv[0], &cp.addr.bdaddr);
 	cp.addr.type = type;
 
-	if (mgmt_send(mgmt, MGMT_OP_GET_CONN_INFO, index, sizeof(cp), &cp,
+	if (mgmt_send(mgmt, MGMT_OP_GET_CONN_INFO, get_index(), sizeof(cp), &cp,
 					conn_info_rsp, NULL, NULL) == 0) {
 		error("Unable to send get_conn_info cmd");
 		return noninteractive_quit(EXIT_FAILURE);
@@ -2970,8 +2834,7 @@ static void io_cap_usage(void)
 	print("Usage: btmgmt io-cap <cap>");
 }
 
-static void cmd_io_cap(struct mgmt *mgmt, uint16_t index,
-						int argc, char **argv)
+static void cmd_io_cap(int argc, char **argv)
 {
 	struct mgmt_cp_set_io_capability cp;
 	uint8_t cap;
@@ -2981,15 +2844,12 @@ static void cmd_io_cap(struct mgmt *mgmt, uint16_t index,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	cap = strtol(argv[1], NULL, 0);
 	memset(&cp, 0, sizeof(cp));
 	cp.io_capability = cap;
 
-	if (mgmt_send(mgmt, MGMT_OP_SET_IO_CAPABILITY, index, sizeof(cp), &cp,
-					io_cap_rsp, NULL, NULL) == 0) {
+	if (mgmt_send(mgmt, MGMT_OP_SET_IO_CAPABILITY, get_index(),
+			sizeof(cp), &cp, io_cap_rsp, NULL, NULL) == 0) {
 		error("Unable to send set-io-cap cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
@@ -3012,8 +2872,7 @@ static void scan_params_usage(void)
 	print("Usage: btmgmt scan-params <interval> <window>");
 }
 
-static void cmd_scan_params(struct mgmt *mgmt, uint16_t index,
-							int argc, char **argv)
+static void cmd_scan_params(int argc, char **argv)
 {
 	struct mgmt_cp_set_scan_params cp;
 
@@ -3022,14 +2881,11 @@ static void cmd_scan_params(struct mgmt *mgmt, uint16_t index,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	cp.interval = strtol(argv[1], NULL, 0);
 	cp.window = strtol(argv[2], NULL, 0);
 
-	if (mgmt_send(mgmt, MGMT_OP_SET_SCAN_PARAMS, index, sizeof(cp), &cp,
-					scan_params_rsp, NULL, NULL) == 0) {
+	if (mgmt_send(mgmt, MGMT_OP_SET_SCAN_PARAMS, get_index(),
+			sizeof(cp), &cp, scan_params_rsp, NULL, NULL) == 0) {
 		error("Unable to send set_scan_params cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
@@ -3058,21 +2914,17 @@ static void clock_info_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_clock_info(struct mgmt *mgmt, uint16_t index,
-							int argc, char **argv)
+static void cmd_clock_info(int argc, char **argv)
 {
 	struct mgmt_cp_get_clock_info cp;
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	memset(&cp, 0, sizeof(cp));
 
 	if (argc > 1)
 		str2ba(argv[1], &cp.addr.bdaddr);
 
-	if (mgmt_send(mgmt, MGMT_OP_GET_CLOCK_INFO, index, sizeof(cp), &cp,
-					clock_info_rsp, NULL, NULL) == 0) {
+	if (mgmt_send(mgmt, MGMT_OP_GET_CLOCK_INFO, get_index(),
+			sizeof(cp), &cp, clock_info_rsp, NULL, NULL) == 0) {
 		error("Unable to send get_clock_info cmd");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
@@ -3099,8 +2951,7 @@ static struct option add_device_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static void cmd_add_device(struct mgmt *mgmt, uint16_t index,
-						int argc, char **argv)
+static void cmd_add_device(int argc, char **argv)
 {
 	struct mgmt_cp_add_device cp;
 	uint8_t action = 0x00;
@@ -3135,9 +2986,6 @@ static void cmd_add_device(struct mgmt *mgmt, uint16_t index,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	memset(&cp, 0, sizeof(cp));
 	str2ba(argv[0], &cp.addr.bdaddr);
 	cp.addr.type = type;
@@ -3146,7 +2994,7 @@ static void cmd_add_device(struct mgmt *mgmt, uint16_t index,
 	ba2str(&cp.addr.bdaddr, addr);
 	print("Adding device with %s (%s)", addr, typestr(cp.addr.type));
 
-	if (mgmt_send(mgmt, MGMT_OP_ADD_DEVICE, index, sizeof(cp), &cp,
+	if (mgmt_send(mgmt, MGMT_OP_ADD_DEVICE, get_index(), sizeof(cp), &cp,
 					add_device_rsp, NULL, NULL) == 0) {
 		error("Unable to send add device command");
 		return noninteractive_quit(EXIT_FAILURE);
@@ -3173,8 +3021,7 @@ static struct option del_device_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static void cmd_del_device(struct mgmt *mgmt, uint16_t index,
-						int argc, char **argv)
+static void cmd_del_device(int argc, char **argv)
 {
 	struct mgmt_cp_remove_device cp;
 	uint8_t type = BDADDR_BREDR;
@@ -3205,9 +3052,6 @@ static void cmd_del_device(struct mgmt *mgmt, uint16_t index,
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (index == MGMT_INDEX_NONE)
-		index = 0;
-
 	memset(&cp, 0, sizeof(cp));
 	str2ba(argv[0], &cp.addr.bdaddr);
 	cp.addr.type = type;
@@ -3215,87 +3059,19 @@ static void cmd_del_device(struct mgmt *mgmt, uint16_t index,
 	ba2str(&cp.addr.bdaddr, addr);
 	print("Removing device with %s (%s)", addr, typestr(cp.addr.type));
 
-	if (mgmt_send(mgmt, MGMT_OP_REMOVE_DEVICE, index, sizeof(cp), &cp,
+	if (mgmt_send(mgmt, MGMT_OP_REMOVE_DEVICE, get_index(), sizeof(cp), &cp,
 					remove_device_rsp, NULL, NULL) == 0) {
 		error("Unable to send remove device command");
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
-static void cmd_clr_devices(struct mgmt *mgmt, uint16_t index,
-						int argc, char **argv)
+static void cmd_clr_devices(int argc, char **argv)
 {
 	char *bdaddr_any = "00:00:00:00:00:00";
 	char *rm_argv[] = { "del-device", bdaddr_any, NULL };
 
-	cmd_del_device(mgmt, index, 2, rm_argv);
-}
-
-struct cmd_info {
-	char *cmd;
-	void (*func)(struct mgmt *mgmt, uint16_t index, int argc, char **argv);
-	char *doc;
-	char * (*gen) (const char *text, int state);
-	void (*disp) (char **matches, int num_matches, int max_length);
-};
-
-static struct cmd_info all_cmd[] = {
-	{ "version",	cmd_version,	"Get the MGMT Version"		},
-	{ "commands",	cmd_commands,	"List supported commands"	},
-	{ "config",	cmd_config,	"Show configuration info"	},
-	{ "info",	cmd_info,	"Show controller info"		},
-	{ "power",	cmd_power,	"Toggle powered state"		},
-	{ "discov",	cmd_discov,	"Toggle discoverable state"	},
-	{ "connectable",cmd_connectable,"Toggle connectable state"	},
-	{ "fast-conn",	cmd_fast_conn,	"Toggle fast connectable state"	},
-	{ "bondable",	cmd_bondable,	"Toggle bondable state"		},
-	{ "pairable",	cmd_bondable,	"Toggle bondable state"		},
-	{ "linksec",	cmd_linksec,	"Toggle link level security"	},
-	{ "ssp",	cmd_ssp,	"Toggle SSP mode"		},
-	{ "sc",		cmd_sc,		"Toogle SC support"		},
-	{ "hs",		cmd_hs,		"Toggle HS support"		},
-	{ "le",		cmd_le,		"Toggle LE support"		},
-	{ "advertising",cmd_advertising,"Toggle LE advertising",	},
-	{ "bredr",	cmd_bredr,	"Toggle BR/EDR support",	},
-	{ "privacy",	cmd_privacy,	"Toggle privacy support"	},
-	{ "class",	cmd_class,	"Set device major/minor class"	},
-	{ "disconnect", cmd_disconnect, "Disconnect device"		},
-	{ "con",	cmd_con,	"List connections"		},
-	{ "find",	cmd_find,	"Discover nearby devices"	},
-	{ "find-service", cmd_find_service, "Discover nearby service"	},
-	{ "name",	cmd_name,	"Set local name"		},
-	{ "pair",	cmd_pair,	"Pair with a remote device"	},
-	{ "cancelpair",	cmd_cancel_pair,"Cancel pairing"		},
-	{ "unpair",	cmd_unpair,	"Unpair device"			},
-	{ "keys",	cmd_keys,	"Load Link Keys"		},
-	{ "ltks",	cmd_ltks,	"Load Long Term Keys"		},
-	{ "irks",	cmd_irks,	"Load Identity Resolving Keys"	},
-	{ "block",	cmd_block,	"Block Device"			},
-	{ "unblock",	cmd_unblock,	"Unblock Device"		},
-	{ "add-uuid",	cmd_add_uuid,	"Add UUID"			},
-	{ "rm-uuid",	cmd_remove_uuid,"Remove UUID"			},
-	{ "clr-uuids",	cmd_clr_uuids,	"Clear UUIDs"			},
-	{ "local-oob",	cmd_local_oob,	"Local OOB data"		},
-	{ "remote-oob",	cmd_remote_oob,	"Remote OOB data"		},
-	{ "did",	cmd_did,	"Set Device ID"			},
-	{ "static-addr",cmd_static_addr,"Set static address"		},
-	{ "public-addr",cmd_public_addr,"Set public address"		},
-	{ "ext-config",	cmd_ext_config,	"External configuration"	},
-	{ "debug-keys",	cmd_debug_keys,	"Toogle debug keys"		},
-	{ "conn-info",	cmd_conn_info,	"Get connection information"	},
-	{ "io-cap",	cmd_io_cap,	"Set IO Capability"		},
-	{ "scan-params",cmd_scan_params,"Set Scan Parameters"		},
-	{ "get-clock",	cmd_clock_info,	"Get Clock Information"		},
-	{ "add-device", cmd_add_device, "Add Device"			},
-	{ "del-device", cmd_del_device, "Remove Device"			},
-	{ "clr-devices",cmd_clr_devices,"Clear Devices"			},
-	{ }
-};
-
-static void cmd_quit(struct mgmt *mgmt, uint16_t index,
-						int argc, char **argv)
-{
-	mainloop_exit_success();
+	cmd_del_device(2, rm_argv);
 }
 
 static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
@@ -3338,11 +3114,9 @@ static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
 					unconf_index_removed, NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_NEW_CONFIG_OPTIONS, index,
 					new_config_options, NULL, NULL);
-
 }
 
-static void cmd_select(struct mgmt *mgmt, uint16_t index,
-						int argc, char **argv)
+static void cmd_select(int argc, char **argv)
 {
 	if (argc != 2) {
 		error("Usage: select <index>");
@@ -3367,155 +3141,71 @@ static void cmd_select(struct mgmt *mgmt, uint16_t index,
 	update_prompt(mgmt_index);
 }
 
-static struct cmd_info interactive_cmd[] = {
+static struct interactive_command all_cmd[] = {
+	{ "version",	cmd_version,	"Get the MGMT Version"		},
+	{ "commands",	cmd_commands,	"List supported commands"	},
+	{ "config",	cmd_config,	"Show configuration info"	},
+	{ "info",	cmd_info,	"Show controller info"		},
+	{ "power",	cmd_power,	"Toggle powered state"		},
+	{ "discov",	cmd_discov,	"Toggle discoverable state"	},
+	{ "connectable", cmd_connectable, "Toggle connectable state"	},
+	{ "fast-conn",	cmd_fast_conn,	"Toggle fast connectable state"	},
+	{ "bondable",	cmd_bondable,	"Toggle bondable state"		},
+	{ "pairable",	cmd_bondable,	"Toggle bondable state"		},
+	{ "linksec",	cmd_linksec,	"Toggle link level security"	},
+	{ "ssp",	cmd_ssp,	"Toggle SSP mode"		},
+	{ "sc",		cmd_sc,		"Toogle SC support"		},
+	{ "hs",		cmd_hs,		"Toggle HS support"		},
+	{ "le",		cmd_le,		"Toggle LE support"		},
+	{ "advertising", cmd_advertising, "Toggle LE advertising",	},
+	{ "bredr",	cmd_bredr,	"Toggle BR/EDR support",	},
+	{ "privacy",	cmd_privacy,	"Toggle privacy support"	},
+	{ "class",	cmd_class,	"Set device major/minor class"	},
+	{ "disconnect", cmd_disconnect, "Disconnect device"		},
+	{ "con",	cmd_con,	"List connections"		},
+	{ "find",	cmd_find,	"Discover nearby devices"	},
+	{ "find-service", cmd_find_service, "Discover nearby service"	},
+	{ "name",	cmd_name,	"Set local name"		},
+	{ "pair",	cmd_pair,	"Pair with a remote device"	},
+	{ "cancelpair",	cmd_cancel_pair, "Cancel pairing"		},
+	{ "unpair",	cmd_unpair,	"Unpair device"			},
+	{ "keys",	cmd_keys,	"Load Link Keys"		},
+	{ "ltks",	cmd_ltks,	"Load Long Term Keys"		},
+	{ "irks",	cmd_irks,	"Load Identity Resolving Keys"	},
+	{ "block",	cmd_block,	"Block Device"			},
+	{ "unblock",	cmd_unblock,	"Unblock Device"		},
+	{ "add-uuid",	cmd_add_uuid,	"Add UUID"			},
+	{ "rm-uuid",	cmd_remove_uuid, "Remove UUID"			},
+	{ "clr-uuids",	cmd_clr_uuids,	"Clear UUIDs"			},
+	{ "local-oob",	cmd_local_oob,	"Local OOB data"		},
+	{ "remote-oob",	cmd_remote_oob,	"Remote OOB data"		},
+	{ "did",	cmd_did,	"Set Device ID"			},
+	{ "static-addr", cmd_static_addr, "Set static address"		},
+	{ "public-addr", cmd_public_addr, "Set public address"		},
+	{ "ext-config",	cmd_ext_config,	"External configuration"	},
+	{ "debug-keys",	cmd_debug_keys,	"Toogle debug keys"		},
+	{ "conn-info",	cmd_conn_info,	"Get connection information"	},
+	{ "io-cap",	cmd_io_cap,	"Set IO Capability"		},
+	{ "scan-params", cmd_scan_params, "Set Scan Parameters"		},
+	{ "get-clock",	cmd_clock_info,	"Get Clock Information"		},
+	{ "add-device", cmd_add_device, "Add Device"			},
+	{ "del-device", cmd_del_device, "Remove Device"			},
+	{ "clr-devices", cmd_clr_devices, "Clear Devices"		},
 	{ "select",	cmd_select,	"Select a different index"	},
-	{ "quit",	cmd_quit,	"Exit program"			},
-	{ "exit",	cmd_quit,	"Exit program"			},
-	{ "help",	NULL,		"List supported commands"	},
+	{ },
 	{ }
 };
 
-static char *cmd_generator(const char *text, int state)
-{
-	static int i, j, len;
-	const char *cmd;
-
-	if (!state) {
-		i = 0;
-		j = 0;
-		len = strlen(text);
-	}
-
-	while ((cmd = all_cmd[i].cmd)) {
-		i++;
-
-		if (!strncmp(cmd, text, len))
-			return strdup(cmd);
-	}
-
-	while ((cmd = interactive_cmd[j].cmd)) {
-		j++;
-
-		if (!strncmp(cmd, text, len))
-			return strdup(cmd);
-	}
-
-	return NULL;
-}
-
-static char **cmd_completion(const char *text, int start, int end)
-{
-	char **matches = NULL;
-
-	if (start > 0) {
-		int i;
-
-		for (i = 0; all_cmd[i].cmd; i++) {
-			struct cmd_info *c = &all_cmd[i];
-
-			if (strncmp(c->cmd, rl_line_buffer, start - 1))
-				continue;
-
-			if (!c->gen)
-				continue;
-
-			rl_completion_display_matches_hook = c->disp;
-			matches = rl_completion_matches(text, c->gen);
-			break;
-		}
-	} else {
-		rl_completion_display_matches_hook = NULL;
-		matches = rl_completion_matches(text, cmd_generator);
-	}
-
-	if (!matches)
-		rl_attempted_completion_over = 1;
-
-	return matches;
-}
-
-static struct cmd_info *find_cmd(const char *cmd, struct cmd_info table[])
+static const struct interactive_command *find_cmd(const char *cmd)
 {
 	int i;
 
-	for (i = 0; table[i].cmd; i++) {
-		if (!strcmp(table[i].cmd, cmd))
-			return &table[i];
-	}
-
-	return NULL;
-}
-
-static void rl_handler(char *input)
-{
-	struct cmd_info *c;
-	wordexp_t w;
-	char *cmd, **argv;
-	size_t argc, i;
-
-	if (!input) {
-		rl_insert_text("quit");
-		rl_redisplay();
-		rl_crlf();
-		mainloop_quit();
-		return;
-	}
-
-	if (!strlen(input))
-		goto done;
-
-	if (prompt_input(input))
-		goto done;
-
-	add_history(input);
-
-	if (wordexp(input, &w, WRDE_NOCMD))
-		goto done;
-
-	if (w.we_wordc == 0)
-		goto free_we;
-
-	cmd = w.we_wordv[0];
-	argv = w.we_wordv;
-	argc = w.we_wordc;
-
-	c = find_cmd(cmd, all_cmd);
-	if (!c && interactive)
-		c = find_cmd(cmd, interactive_cmd);
-
-	if (c && c->func) {
-		c->func(mgmt, mgmt_index, argc, argv);
-		goto free_we;
-	}
-
-	if (strcmp(cmd, "help")) {
-		print("Invalid command");
-		goto free_we;
-	}
-
-	print("Available commands:");
-
 	for (i = 0; all_cmd[i].cmd; i++) {
-		c = &all_cmd[i];
-		if (c->doc)
-			print("  %s %-*s %s", c->cmd,
-				(int)(25 - strlen(c->cmd)), "", c->doc ? : "");
-	}
-
-	if (!interactive)
-		goto free_we;
-
-	for (i = 0; interactive_cmd[i].cmd; i++) {
-		c = &interactive_cmd[i];
-		if (c->doc)
-			print("  %s %-*s %s", c->cmd,
-				(int)(25 - strlen(c->cmd)), "", c->doc ? : "");
+		if (!strcmp(all_cmd[i].cmd, cmd))
+			return &all_cmd[i];
 	}
 
-free_we:
-	wordfree(&w);
-done:
-	free(input);
+	return NULL;
 }
 
 static void usage(void)
@@ -3547,29 +3237,8 @@ static struct option main_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static bool prompt_read(struct io *io, void *user_data)
-{
-	rl_callback_read_char();
-	return true;
-}
-
-static struct io *setup_stdin(void)
-{
-	struct io *io;
-
-	io = io_new(STDIN_FILENO);
-	if (!io)
-		return io;
-
-	io_set_read_handler(io, prompt_read, NULL, NULL);
-
-	return io;
-}
-
 int main(int argc, char *argv[])
 {
-	struct io *input;
-	uint16_t index = MGMT_INDEX_NONE;
 	int status, opt;
 
 	while ((opt = getopt_long(argc, argv, "+hi:",
@@ -3578,9 +3247,9 @@ int main(int argc, char *argv[])
 		case 'i':
 			if (strlen(optarg) > 3 &&
 					strncasecmp(optarg, "hci", 3) == 0)
-				index = atoi(optarg + 3);
+				mgmt_index = atoi(optarg + 3);
 			else
-				index = atoi(optarg);
+				mgmt_index = atoi(optarg);
 			break;
 		case 'h':
 		default:
@@ -3602,49 +3271,37 @@ int main(int argc, char *argv[])
 	}
 
 	if (argc > 0) {
-		struct cmd_info *c;
+		const struct interactive_command *c;
 
-		c = find_cmd(argv[0], all_cmd);
+		c = find_cmd(argv[0]);
 		if (!c) {
 			fprintf(stderr, "Unknown command: %s\n", argv[0]);
 			mgmt_unref(mgmt);
 			return EXIT_FAILURE;
 		}
 
-		c->func(mgmt, index, argc, argv);
+		c->func(argc, argv);
 	}
 
-	register_mgmt_callbacks(mgmt, index);
+	register_mgmt_callbacks(mgmt, mgmt_index);
 
 	/* Interactive mode */
-	if (!argc)
-		input = setup_stdin();
-	else
-		input = NULL;
-
-	if (input) {
-		interactive = true;
-
-		rl_attempted_completion_function = cmd_completion;
-
-		rl_erase_empty_line = 1;
-		rl_callback_handler_install(NULL, rl_handler);
-
-		update_prompt(index);
-		rl_redisplay();
+	if (!argc) {
+		interactive = interactive_init(PROMPT_ON, prompt_input,
+								all_cmd);
+		if (!interactive) {
+			fprintf(stderr, "Failed to setup interactive mode\n");
+			status = EXIT_FAILURE;
+			goto failed;
+		}
 	}
 
-	mgmt_index = index;
-
 	status = mainloop_run();
 
-	if (input) {
-		io_destroy(input);
-
-		rl_message("");
-		rl_callback_handler_remove();
-	}
+	if (interactive)
+		interactive_cleanup();
 
+failed:
 	mgmt_cancel_all(mgmt);
 	mgmt_unregister_all(mgmt);
 	mgmt_unref(mgmt);
-- 
1.9.3

