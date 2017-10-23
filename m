Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 5/8] tools/btmgmt: Replace with common usage function
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Message-ID: <f6857edc-c6ef-5061-331c-cf7c3d659f64@jp.fujitsu.com>
Date: Mon, 23 Oct 2017 17:27:48 +0900
MIME-Version: 1.0
In-Reply-To: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add the common function cmd_usage(), which displays the specified command
name and the argument text in all_cmd corresponded to it, replace each
command specific usage with this function.
---
 tools/btmgmt.c | 227 +++++++++++++++++++++------------------------------------
 1 file changed, 84 insertions(+), 143 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index bcfcb5b..1bc97aa 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1129,6 +1129,8 @@ done:
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void cmd_usage(char *cmd);
+
 static void cmd_version(struct mgmt *mgmt, uint16_t index, int argc,
 								char **argv)
 {
@@ -1822,7 +1824,7 @@ static void cmd_discov(struct mgmt *mgmt, uint16_t index, int argc,
 	struct mgmt_cp_set_discoverable cp;
 
 	if (argc < 2) {
-		print("Usage: %s <yes/no/limited> [timeout]", argv[0]);
+		cmd_usage(argv[0]);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -2006,7 +2008,7 @@ static void cmd_class(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	uint8_t class[2];
 
 	if (argc < 3) {
-		print("Usage: %s <major> <minor>", argv[0]);
+		cmd_usage(argv[0]);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -2051,11 +2053,6 @@ static void disconnect_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void disconnect_usage(void)
-{
-	print("Usage: disconnect [-t type] <remote address>");
-}
-
 static struct option disconnect_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "type",	1, 0, 't' },
@@ -2068,6 +2065,7 @@ static void cmd_disconnect(struct mgmt *mgmt, uint16_t index, int argc,
 	struct mgmt_cp_disconnect cp;
 	uint8_t type = BDADDR_BREDR;
 	int opt;
+	char *cmd = argv[0];
 
 	while ((opt = getopt_long(argc, argv, "+t:h", disconnect_options,
 								NULL)) != -1) {
@@ -2076,11 +2074,11 @@ static void cmd_disconnect(struct mgmt *mgmt, uint16_t index, int argc,
 			type = strtol(optarg, NULL, 0);
 			break;
 		case 'h':
-			disconnect_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
-			disconnect_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
@@ -2091,7 +2089,7 @@ static void cmd_disconnect(struct mgmt *mgmt, uint16_t index, int argc,
 	optind = 0;
 
 	if (argc < 1) {
-		disconnect_usage();
+		cmd_usage(cmd);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -2163,11 +2161,6 @@ static void find_service_rsp(uint8_t status, uint16_t len, const void *param,
 	discovery = true;
 }
 
-static void find_service_usage(void)
-{
-	print("Usage: find-service [-u UUID] [-r RSSI_Threshold] [-l|-b]");
-}
-
 static struct option find_service_options[] = {
 	{ "help",	no_argument, 0, 'h' },
 	{ "le-only",	no_argument, 0, 'l' },
@@ -2201,6 +2194,7 @@ static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc,
 	int8_t rssi;
 	uint16_t count;
 	int opt;
+	char *cmd = argv[0];
 
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
@@ -2209,7 +2203,7 @@ static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc,
 	count = 0;
 
 	if (argc == 1) {
-		find_service_usage();
+		cmd_usage(cmd);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -2246,11 +2240,11 @@ static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc,
 			rssi = atoi(optarg);
 			break;
 		case 'h':
-			find_service_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
-			find_service_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
@@ -2261,7 +2255,7 @@ static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc,
 	optind = 0;
 
 	if (argc > 0) {
-		find_service_usage();
+		cmd_usage(cmd);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -2291,11 +2285,6 @@ static void find_rsp(uint8_t status, uint16_t len, const void *param,
 	discovery = true;
 }
 
-static void find_usage(void)
-{
-	print("Usage: find [-l|-b] [-L]");
-}
-
 static struct option find_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "le-only",	1, 0, 'l' },
@@ -2310,6 +2299,7 @@ static void cmd_find(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	uint8_t op = MGMT_OP_START_DISCOVERY;
 	uint8_t type = SCAN_TYPE_DUAL;
 	int opt;
+	char *cmd = argv[0];
 
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
@@ -2329,11 +2319,11 @@ static void cmd_find(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 			op = MGMT_OP_START_LIMITED_DISCOVERY;
 			break;
 		case 'h':
-			find_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
-			find_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
@@ -2368,11 +2358,6 @@ static void stop_find_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void stop_find_usage(void)
-{
-	print("Usage: stop-find [-l|-b]");
-}
-
 static struct option stop_find_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "le-only",	1, 0, 'l' },
@@ -2386,6 +2371,7 @@ static void cmd_stop_find(struct mgmt *mgmt, uint16_t index, int argc,
 	struct mgmt_cp_stop_discovery cp;
 	uint8_t type = SCAN_TYPE_DUAL;
 	int opt;
+	char *cmd = argv[0];
 
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
@@ -2403,7 +2389,7 @@ static void cmd_stop_find(struct mgmt *mgmt, uint16_t index, int argc,
 			break;
 		case 'h':
 		default:
-			stop_find_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		}
@@ -2438,7 +2424,7 @@ static void cmd_name(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	struct mgmt_cp_set_local_name cp;
 
 	if (argc < 2) {
-		print("Usage: %s <name> [shortname]", argv[0]);
+		cmd_usage(argv[0]);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -2490,11 +2476,6 @@ static void pair_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void pair_usage(void)
-{
-	print("Usage: pair [-c cap] [-t type] <remote address>");
-}
-
 static struct option pair_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "capability",	1, 0, 'c' },
@@ -2509,6 +2490,7 @@ static void cmd_pair(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	uint8_t type = BDADDR_BREDR;
 	char addr[18];
 	int opt;
+	char *cmd = argv[0];
 
 	while ((opt = getopt_long(argc, argv, "+c:t:h", pair_options,
 								NULL)) != -1) {
@@ -2520,11 +2502,11 @@ static void cmd_pair(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 			type = strtol(optarg, NULL, 0);
 			break;
 		case 'h':
-			pair_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
-			pair_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
@@ -2535,7 +2517,7 @@ static void cmd_pair(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	optind = 0;
 
 	if (argc < 1) {
-		pair_usage();
+		cmd_usage(cmd);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -2586,11 +2568,6 @@ static void cancel_pair_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cancel_pair_usage(void)
-{
-	print("Usage: cancelpair [-t type] <remote address>");
-}
-
 static struct option cancel_pair_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "type",	1, 0, 't' },
@@ -2603,6 +2580,7 @@ static void cmd_cancel_pair(struct mgmt *mgmt, uint16_t index, int argc,
 	struct mgmt_addr_info cp;
 	uint8_t type = BDADDR_BREDR;
 	int opt;
+	char *cmd = argv[0];
 
 	while ((opt = getopt_long(argc, argv, "+t:h", cancel_pair_options,
 								NULL)) != -1) {
@@ -2611,11 +2589,11 @@ static void cmd_cancel_pair(struct mgmt *mgmt, uint16_t index, int argc,
 			type = strtol(optarg, NULL, 0);
 			break;
 		case 'h':
-			cancel_pair_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
-			cancel_pair_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
@@ -2626,7 +2604,7 @@ static void cmd_cancel_pair(struct mgmt *mgmt, uint16_t index, int argc,
 	optind = 0;
 
 	if (argc < 1) {
-		cancel_pair_usage();
+		cmd_usage(cmd);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -2672,11 +2650,6 @@ static void unpair_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void unpair_usage(void)
-{
-	print("Usage: unpair [-t type] <remote address>");
-}
-
 static struct option unpair_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "type",	1, 0, 't' },
@@ -2689,6 +2662,7 @@ static void cmd_unpair(struct mgmt *mgmt, uint16_t index, int argc,
 	struct mgmt_cp_unpair_device cp;
 	uint8_t type = BDADDR_BREDR;
 	int opt;
+	char *cmd = argv[0];
 
 	while ((opt = getopt_long(argc, argv, "+t:h", unpair_options,
 								NULL)) != -1) {
@@ -2697,11 +2671,11 @@ static void cmd_unpair(struct mgmt *mgmt, uint16_t index, int argc,
 			type = strtol(optarg, NULL, 0);
 			break;
 		case 'h':
-			unpair_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
-			unpair_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
@@ -2712,7 +2686,7 @@ static void cmd_unpair(struct mgmt *mgmt, uint16_t index, int argc,
 	optind = 0;
 
 	if (argc < 1) {
-		unpair_usage();
+		cmd_usage(cmd);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -2799,11 +2773,6 @@ static void irks_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void irks_usage(void)
-{
-	print("Usage: irks [--local <index>] [--file <file path>]");
-}
-
 static struct option irks_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "local",	1, 0, 'l' },
@@ -2820,6 +2789,7 @@ static void cmd_irks(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	uint16_t count, local_index;
 	char path[PATH_MAX];
 	int opt;
+	char *cmd = argv[0];
 
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
@@ -2865,11 +2835,11 @@ static void cmd_irks(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 			count++;
 			break;
 		case 'h':
-			irks_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
-			irks_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
@@ -2880,7 +2850,7 @@ static void cmd_irks(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	optind = 0;
 
 	if (argc > 0) {
-		irks_usage();
+		cmd_usage(cmd);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -2923,11 +2893,6 @@ static void block_rsp(uint16_t op, uint16_t id, uint8_t status, uint16_t len,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void block_usage(void)
-{
-	print("Usage: block [-t type] <remote address>");
-}
-
 static struct option block_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "type",	1, 0, 't' },
@@ -2939,6 +2904,7 @@ static void cmd_block(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	struct mgmt_cp_block_device cp;
 	uint8_t type = BDADDR_BREDR;
 	int opt;
+	char *cmd = argv[0];
 
 	while ((opt = getopt_long(argc, argv, "+t:h", block_options,
 							NULL)) != -1) {
@@ -2947,11 +2913,11 @@ static void cmd_block(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 			type = strtol(optarg, NULL, 0);
 			break;
 		case 'h':
-			block_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
-			block_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
@@ -2962,7 +2928,7 @@ static void cmd_block(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	optind = 0;
 
 	if (argc < 1) {
-		block_usage();
+		cmd_usage(cmd);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -2980,17 +2946,13 @@ static void cmd_block(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	}
 }
 
-static void unblock_usage(void)
-{
-	print("Usage: unblock [-t type] <remote address>");
-}
-
 static void cmd_unblock(struct mgmt *mgmt, uint16_t index, int argc,
 								char **argv)
 {
 	struct mgmt_cp_unblock_device cp;
 	uint8_t type = BDADDR_BREDR;
 	int opt;
+	char *cmd = argv[0];
 
 	while ((opt = getopt_long(argc, argv, "+t:h", block_options,
 							NULL)) != -1) {
@@ -2999,11 +2961,11 @@ static void cmd_unblock(struct mgmt *mgmt, uint16_t index, int argc,
 			type = strtol(optarg, NULL, 0);
 			break;
 		case 'h':
-			unblock_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
-			unblock_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
@@ -3014,7 +2976,7 @@ static void cmd_unblock(struct mgmt *mgmt, uint16_t index, int argc,
 	optind = 0;
 
 	if (argc < 1) {
-		unblock_usage();
+		cmd_usage(cmd);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -3178,13 +3140,6 @@ static void remote_oob_rsp(uint8_t status, uint16_t len, const void *param,
 	print("Remote OOB data added for %s (%u)", addr, rp->type);
 }
 
-static void remote_oob_usage(void)
-{
-	print("Usage: remote-oob [-t <addr_type>] "
-		"[-r <rand192>] [-h <hash192>] [-R <rand256>] [-H <hash256>] "
-		"<addr>");
-}
-
 static struct option remote_oob_opt[] = {
 	{ "help",	0, 0, '?' },
 	{ "type",	1, 0, 't' },
@@ -3196,6 +3151,7 @@ static void cmd_remote_oob(struct mgmt *mgmt, uint16_t index,
 {
 	struct mgmt_cp_add_remote_oob_data cp;
 	int opt;
+	char *cmd = argv[0];
 
 	memset(&cp, 0, sizeof(cp));
 	cp.addr.type = BDADDR_BREDR;
@@ -3219,7 +3175,7 @@ static void cmd_remote_oob(struct mgmt *mgmt, uint16_t index,
 			hex2bin(optarg, cp.hash256, 16);
 			break;
 		default:
-			remote_oob_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
@@ -3230,7 +3186,7 @@ static void cmd_remote_oob(struct mgmt *mgmt, uint16_t index,
 	optind = 0;
 
 	if (argc < 1) {
-		remote_oob_usage();
+		cmd_usage(cmd);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -3263,7 +3219,7 @@ static void did_rsp(uint8_t status, uint16_t len, const void *param,
 
 static void did_usage(void)
 {
-	print("Usage: did <source>:<vendor>:<product>:<version>");
+	cmd_usage("did");
 	print("       possible source values: bluetooth, usb");
 }
 
@@ -3323,18 +3279,13 @@ static void static_addr_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void static_addr_usage(void)
-{
-	print("Usage: static-addr <address>");
-}
-
 static void cmd_static_addr(struct mgmt *mgmt, uint16_t index,
 							int argc, char **argv)
 {
 	struct mgmt_cp_set_static_address cp;
 
 	if (argc < 2) {
-		static_addr_usage();
+		cmd_usage(argv[0]);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -3379,7 +3330,7 @@ static void cmd_public_addr(struct mgmt *mgmt, uint16_t index,
 	struct mgmt_cp_set_public_address cp;
 
 	if (argc < 2) {
-		print("Usage: public-addr <address>");
+		cmd_usage(argv[0]);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -3460,11 +3411,6 @@ static void conn_info_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void conn_info_usage(void)
-{
-	print("Usage: conn-info [-t type] <remote address>");
-}
-
 static struct option conn_info_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "type",	1, 0, 't' },
@@ -3477,6 +3423,7 @@ static void cmd_conn_info(struct mgmt *mgmt, uint16_t index,
 	struct mgmt_cp_get_conn_info cp;
 	uint8_t type = BDADDR_BREDR;
 	int opt;
+	char *cmd = argv[0];
 
 	while ((opt = getopt_long(argc, argv, "+t:h", conn_info_options,
 								NULL)) != -1) {
@@ -3485,11 +3432,11 @@ static void cmd_conn_info(struct mgmt *mgmt, uint16_t index,
 			type = strtol(optarg, NULL, 0);
 			break;
 		case 'h':
-			conn_info_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
-			conn_info_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
@@ -3500,7 +3447,7 @@ static void cmd_conn_info(struct mgmt *mgmt, uint16_t index,
 	optind = 0;
 
 	if (argc < 1) {
-		conn_info_usage();
+		cmd_usage(cmd);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -3530,11 +3477,6 @@ static void io_cap_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void io_cap_usage(void)
-{
-	print("Usage: io-cap <cap>");
-}
-
 static void cmd_io_cap(struct mgmt *mgmt, uint16_t index,
 						int argc, char **argv)
 {
@@ -3542,7 +3484,7 @@ static void cmd_io_cap(struct mgmt *mgmt, uint16_t index,
 	uint8_t cap;
 
 	if (argc < 2) {
-		io_cap_usage();
+		cmd_usage(argv[0]);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -3572,18 +3514,13 @@ static void scan_params_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void scan_params_usage(void)
-{
-	print("Usage: scan-params <interval> <window>");
-}
-
 static void cmd_scan_params(struct mgmt *mgmt, uint16_t index,
 							int argc, char **argv)
 {
 	struct mgmt_cp_set_scan_params cp;
 
 	if (argc < 3) {
-		scan_params_usage();
+		cmd_usage(argv[0]);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -3652,11 +3589,6 @@ static void add_device_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void add_device_usage(void)
-{
-	print("Usage: add-device [-a action] [-t type] <address>");
-}
-
 static struct option add_device_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "action",	1, 0, 'a' },
@@ -3672,6 +3604,7 @@ static void cmd_add_device(struct mgmt *mgmt, uint16_t index,
 	uint8_t type = BDADDR_BREDR;
 	char addr[18];
 	int opt;
+	char *cmd = argv[0];
 
 	while ((opt = getopt_long(argc, argv, "+a:t:h", add_device_options,
 								NULL)) != -1) {
@@ -3683,11 +3616,11 @@ static void cmd_add_device(struct mgmt *mgmt, uint16_t index,
 			type = strtol(optarg, NULL, 0);
 			break;
 		case 'h':
-			add_device_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
-			add_device_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
@@ -3698,7 +3631,7 @@ static void cmd_add_device(struct mgmt *mgmt, uint16_t index,
 	optind = 0;
 
 	if (argc < 1) {
-		add_device_usage();
+		cmd_usage(cmd);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -3729,11 +3662,6 @@ static void remove_device_rsp(uint8_t status, uint16_t len, const void *param,
 	noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void del_device_usage(void)
-{
-	print("Usage: del-device [-t type] <address>");
-}
-
 static struct option del_device_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "type",	1, 0, 't' },
@@ -3747,6 +3675,7 @@ static void cmd_del_device(struct mgmt *mgmt, uint16_t index,
 	uint8_t type = BDADDR_BREDR;
 	char addr[18];
 	int opt;
+	char *cmd = argv[0];
 
 	while ((opt = getopt_long(argc, argv, "+t:h", del_device_options,
 								NULL)) != -1) {
@@ -3755,11 +3684,11 @@ static void cmd_del_device(struct mgmt *mgmt, uint16_t index,
 			type = strtol(optarg, NULL, 0);
 			break;
 		case 'h':
-			del_device_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
-			del_device_usage();
+			cmd_usage(cmd);
 			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
@@ -3770,7 +3699,7 @@ static void cmd_del_device(struct mgmt *mgmt, uint16_t index,
 	optind = 0;
 
 	if (argc < 1) {
-		del_device_usage();
+		cmd_usage(cmd);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -3969,7 +3898,8 @@ static void adv_size_info_rsp(uint8_t status, uint16_t len, const void *param,
 
 static void advsize_usage(void)
 {
-	print("Usage: advsize [options] <instance_id>\nOptions:\n"
+	cmd_usage("advsize");
+	print("Options:\n"
 		"\t -c, --connectable         \"connectable\" flag\n"
 		"\t -g, --general-discov      \"general-discoverable\" flag\n"
 		"\t -l, --limited-discov      \"limited-discoverable\" flag\n"
@@ -4079,7 +4009,8 @@ static void add_adv_rsp(uint8_t status, uint16_t len, const void *param,
 
 static void add_adv_usage(void)
 {
-	print("Usage: add-adv [options] <instance_id>\nOptions:\n"
+	cmd_usage("add-adv");
+	print("Options:\n"
 		"\t -u, --uuid <uuid>         Service UUID\n"
 		"\t -d, --adv-data <data>     Advertising Data bytes\n"
 		"\t -s, --scan-rsp <data>     Scan Response Data bytes\n"
@@ -4342,18 +4273,13 @@ static void rm_adv_rsp(uint8_t status, uint16_t len, const void *param,
 	return noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void rm_adv_usage(void)
-{
-	print("Usage: rm-adv <instance_id>");
-}
-
 static void cmd_rm_adv(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 {
 	struct mgmt_cp_remove_advertising cp;
 	uint8_t instance;
 
 	if (argc != 2) {
-		rm_adv_usage();
+		cmd_usage(argv[0]);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -4399,7 +4325,7 @@ static void cmd_appearance(struct mgmt *mgmt, uint16_t index, int argc,
 	struct mgmt_cp_set_appearance cp;
 
 	if (argc < 2) {
-		print("Usage: appearance <appearance>");
+		cmd_usage(argv[0]);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -4718,6 +4644,21 @@ static struct cmd_info *find_cmd(const char *cmd, struct cmd_info table[],
 	return NULL;
 }
 
+static void cmd_usage(char *cmd)
+{
+	struct cmd_info *c;
+
+	if (!cmd)
+		return;
+
+	c = find_cmd(cmd, all_cmd, NELEM(all_cmd));
+	if (!c)
+		return;
+
+	print("Usage: %s %s", cmd, c->arg ? : "");
+
+}
+
 static void rl_handler(char *input)
 {
 	struct cmd_info *c;
-- 
2.7.4

