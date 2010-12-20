Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 2/3] Fix tools UI to avoid program launch mistakes.
Date: Mon, 20 Dec 2010 11:13:48 +0100
Message-ID: <1292840029-27770-3-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1292840029-27770-1-git-send-email-michal.labedzki@tieto.com>
References: <1292840029-27770-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hciconfig: warrning user on unknown commands
hcitool: return error on unknown command in hcitool
fix length size in comparision to avoid ambiguity commands
check if command number of arguments is correct
---
 tools/hciconfig.c |   10 ++-
 tools/hcitool.c   |  201 ++++++++++++++++------------------------------------
 2 files changed, 70 insertions(+), 141 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index e8b0c69..0a3668e 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -1805,7 +1805,7 @@ static void usage(void)
 	printf("hciconfig - HCI device configuration utility\n");
 	printf("Usage:\n"
 		"\thciconfig\n"
-		"\thciconfig [-a] hciX [command]\n");
+		"\thciconfig [-a] hciX [command ...]\n");
 	printf("Commands:\n");
 	for (i=0; command[i].cmd; i++)
 		printf("\t%-10s %-8s\t%s\n", command[i].cmd,
@@ -1869,7 +1869,8 @@ int main(int argc, char *argv[])
 
 	while (argc > 0) {
 		for (i = 0; command[i].cmd; i++) {
-			if (strncmp(command[i].cmd, *argv, 5))
+			if (strncmp(command[i].cmd,
+					*argv, strlen(command[i].cmd)))
 				continue;
 
 			if (command[i].opt) {
@@ -1880,6 +1881,11 @@ int main(int argc, char *argv[])
 			cmd = 1;
 			break;
 		}
+
+		if (command[i].cmd == 0)
+			fprintf(stderr, "Warning: unknown command - \"%s\"\n",
+					*argv);
+
 		argc--; argv++;
 	}
 
diff --git a/tools/hcitool.c b/tools/hcitool.c
index dace674..847bf1b 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -66,6 +66,31 @@ static int dev_info(int s, int dev_id, long arg)
 	return 0;
 }
 
+static void helper_arg(int min_num_arg, int max_num_arg, int *argc,
+			char ***argv, const char *usage)
+{
+	*argc -= optind;
+	/* too many arguments, but when "max_num_arg < min_num_arg" then no
+		 limiting (prefer "max_num_arg=-1" to gen infinity)
+	*/
+	if ( (*argc > max_num_arg) && (max_num_arg >= min_num_arg ) ) {
+		fprintf(stderr, "%s: too many arguments (maximal: %i)\n",
+				*argv[0], max_num_arg);
+		printf("%s", usage);
+		exit(1);
+	}
+
+	/* print usage */
+	if (*argc < min_num_arg) {
+		fprintf(stderr, "%s: too few arguments (minimal: %i)\n",
+				*argv[0], min_num_arg);
+		printf("%s", usage);
+		exit(0);
+	}
+
+	*argv += optind;
+}
+
 static char *type2str(uint8_t type)
 {
 	switch (type) {
@@ -396,6 +421,7 @@ static void cmd_dev(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
+	helper_arg(0, 0, &argc, &argv, dev_help);
 
 	printf("Devices:\n");
 
@@ -466,6 +492,7 @@ static void cmd_inq(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
+	helper_arg(0, 0, &argc, &argv, inq_help);
 
 	printf("Inquiring ...\n");
 
@@ -581,6 +608,7 @@ static void cmd_scan(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
+	helper_arg(0, 0, &argc, &argv, scan_help);
 
 	if (dev_id < 0) {
 		dev_id = hci_get_route(NULL);
@@ -790,13 +818,7 @@ static void cmd_name(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", name_help);
-		return;
-	}
+	helper_arg(1, 1, &argc, &argv, name_help);
 
 	str2ba(argv[0], &bdaddr);
 
@@ -849,13 +871,7 @@ static void cmd_info(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", info_help);
-		return;
-	}
+	helper_arg(1, 1, &argc, &argv, info_help);
 
 	str2ba(argv[0], &bdaddr);
 
@@ -991,6 +1007,7 @@ static void cmd_spinq(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
+	helper_arg(0, 0, &argc, &argv, spinq_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -1031,7 +1048,7 @@ static struct option epinq_options[] = {
 
 static const char *epinq_help =
 	"Usage:\n"
-	"\tspinq\n";
+	"\tepinq\n";
 
 static void cmd_epinq(int dev_id, int argc, char **argv)
 {
@@ -1044,6 +1061,7 @@ static void cmd_epinq(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
+	helper_arg(0, 0, &argc, &argv, epinq_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -1092,13 +1110,7 @@ static void cmd_cmd(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 2) {
-		printf("%s", cmd_help);
-		return;
-	}
+	helper_arg(2, -1, &argc, &argv, cmd_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -1175,6 +1187,7 @@ static void cmd_con(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
+	helper_arg(0, 0, &argc, &argv, con_help);
 
 	printf("Connections:\n");
 
@@ -1223,13 +1236,7 @@ static void cmd_cc(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", cc_help);
-		return;
-	}
+	helper_arg(1, 1, &argc, &argv, cc_help);
 
 	str2ba(argv[0], &bdaddr);
 
@@ -1279,13 +1286,7 @@ static void cmd_dc(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", dc_help);
-		return;
-	}
+	helper_arg(1, 2, &argc, &argv, dc_help);
 
 	str2ba(argv[0], &bdaddr);
 	reason = (argc > 1) ? atoi(argv[1]) : HCI_OE_USER_ENDED_CONNECTION;
@@ -1350,13 +1351,7 @@ static void cmd_sr(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 2) {
-		printf("%s", sr_help);
-		return;
-	}
+	helper_arg(2, 2, &argc, &argv, sr_help);
 
 	str2ba(argv[0], &bdaddr);
 	switch (argv[1][0]) {
@@ -1418,13 +1413,7 @@ static void cmd_rssi(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", rssi_help);
-		return;
-	}
+	helper_arg(1, 1, &argc, &argv, rssi_help);
 
 	str2ba(argv[0], &bdaddr);
 
@@ -1492,13 +1481,7 @@ static void cmd_lq(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", lq_help);
-		return;
-	}
+	helper_arg(1, 1, &argc, &argv, lq_help);
 
 	str2ba(argv[0], &bdaddr);
 
@@ -1567,13 +1550,7 @@ static void cmd_tpl(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", tpl_help);
-		return;
-	}
+	helper_arg(1, 2, &argc, &argv, tpl_help);
 
 	str2ba(argv[0], &bdaddr);
 	type = (argc > 1) ? atoi(argv[1]) : 0;
@@ -1644,13 +1621,7 @@ static void cmd_afh(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", afh_help);
-		return;
-	}
+	helper_arg(1, 1, &argc, &argv, afh_help);
 
 	str2ba(argv[0], &bdaddr);
 
@@ -1730,13 +1701,7 @@ static void cmd_cpt(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 2) {
-		printf("%s", cpt_help);
-		return;
-	}
+	helper_arg(2, 2, &argc, &argv, cpt_help);
 
 	str2ba(argv[0], &bdaddr);
 	hci_strtoptype(argv[1], &ptype);
@@ -1815,13 +1780,7 @@ static void cmd_lp(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", lp_help);
-		return;
-	}
+	helper_arg(1, 2, &argc, &argv, lp_help);
 
 	str2ba(argv[0], &bdaddr);
 
@@ -1914,13 +1873,7 @@ static void cmd_lst(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", lst_help);
-		return;
-	}
+	helper_arg(1, 2, &argc, &argv, lst_help);
 
 	str2ba(argv[0], &bdaddr);
 
@@ -2004,13 +1957,7 @@ static void cmd_auth(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", auth_help);
-		return;
-	}
+	helper_arg(1, 1, &argc, &argv, auth_help);
 
 	str2ba(argv[0], &bdaddr);
 
@@ -2076,13 +2023,7 @@ static void cmd_enc(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", enc_help);
-		return;
-	}
+	helper_arg(1, 2, &argc, &argv, enc_help);
 
 	str2ba(argv[0], &bdaddr);
 
@@ -2149,13 +2090,7 @@ static void cmd_key(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", key_help);
-		return;
-	}
+	helper_arg(1, 1, &argc, &argv, key_help);
 
 	str2ba(argv[0], &bdaddr);
 
@@ -2221,13 +2156,7 @@ static void cmd_clkoff(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", clkoff_help);
-		return;
-	}
+	helper_arg(1, 1, &argc, &argv, clkoff_help);
 
 	str2ba(argv[0], &bdaddr);
 
@@ -2297,8 +2226,7 @@ static void cmd_clock(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	argc -= optind;
-	argv += optind;
+	helper_arg(0, 2, &argc, &argv, clock_help);
 
 	if (argc > 0)
 		str2ba(argv[0], &bdaddr);
@@ -2439,6 +2367,7 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
+	helper_arg(0, 0, &argc, &argv, lescan_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2503,14 +2432,7 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", lecc_help);
-		return;
-	}
+	helper_arg(1, 1, &argc, &argv, lecc_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2571,14 +2493,7 @@ static void cmd_ledc(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-
-	argc -= optind;
-	argv += optind;
-
-	if (argc < 1) {
-		printf("%s", ledc_help);
-		return;
-	}
+	helper_arg(1, 2, &argc, &argv, ledc_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2699,10 +2614,18 @@ int main(int argc, char *argv[])
 	}
 
 	for (i = 0; command[i].cmd; i++) {
-		if (strncmp(command[i].cmd, argv[0], 3))
+		if (strncmp(command[i].cmd,
+				argv[0], strlen(command[i].cmd)))
 			continue;
+
 		command[i].func(dev_id, argc, argv);
 		break;
 	}
+
+	if (command[i].cmd == 0) {
+		fprintf(stderr, "Unknown command - \"%s\"\n", *argv);
+		exit(1);
+	}
+
 	return 0;
 }
-- 
1.7.0.4

