Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] tools/btmgmt: Add option to pass adress type to disconnect command
Date: Wed,  2 Apr 2014 12:29:57 +0200
Message-Id: <1396434598-18361-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed to disconnect LE devices.
---
 tools/btmgmt.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 50c00b5..aee6841 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1186,21 +1186,53 @@ done:
 	mainloop_quit();
 }
 
+static void disconnect_usage(void)
+{
+	printf("Usage: btmgmt disconnect [-t type] <remote address>\n");
+}
+
+static struct option disconnect_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ "type",	1, 0, 't' },
+	{ 0, 0, 0, 0 }
+};
+
 static void cmd_disconnect(struct mgmt *mgmt, uint16_t index, int argc,
 								char **argv)
 {
 	struct mgmt_cp_disconnect cp;
+	uint8_t type = BDADDR_BREDR;
+	int opt;
 
-	if (argc < 2) {
-		printf("Usage: btmgmt %s <address>\n", argv[0]);
-		exit(EXIT_FAILURE);
+	while ((opt = getopt_long(argc, argv, "+t:h", disconnect_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 't':
+			type = strtol(optarg, NULL, 0);
+			break;
+		case 'h':
+		default:
+			disconnect_usage();
+			exit(EXIT_SUCCESS);
+		}
 	}
 
-	str2ba(argv[1], &cp.addr.bdaddr);
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc < 1) {
+		disconnect_usage();
+		exit(EXIT_FAILURE);
+	}
 
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
 
+	memset(&cp, 0, sizeof(cp));
+	str2ba(argv[0], &cp.addr.bdaddr);
+	cp.addr.type = type;
+
 	if (mgmt_send(mgmt, MGMT_OP_DISCONNECT, index, sizeof(cp), &cp,
 					disconnect_rsp, NULL, NULL) == 0) {
 		fprintf(stderr, "Unable to send disconnect cmd\n");
-- 
1.9.1

