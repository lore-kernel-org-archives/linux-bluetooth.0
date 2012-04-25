Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH BlueZ 7/7] l2test: Add option to inform the address type
Date: Tue, 24 Apr 2012 22:42:31 -0300
Message-Id: <1335318151-21063-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1335318151-21063-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1335318151-21063-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch adds 'V' option to inform the address type. Possible values
are: "bredr", "le_public", and "le_random".
---
 test/l2test.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index ae81aec..f66486d 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -117,6 +117,7 @@ static int defer_setup = 0;
 static int priority = -1;
 static int rcvbuf = 0;
 static int chan_policy = -1;
+static int bdaddr_type = 0;
 
 struct lookup_table {
 	char	*name;
@@ -141,6 +142,13 @@ static struct lookup_table chan_policies[] = {
 	{ NULL,		0					},
 };
 
+static struct lookup_table bdaddr_types[] = {
+	{ "bredr",	BDADDR_BREDR		},
+	{ "le_public",	BDADDR_LE_PUBLIC	},
+	{ "le_random",	BDADDR_LE_RANDOM	},
+	{ NULL,		0			},
+};
+
 static int get_lookup_flag(struct lookup_table *table, char *name)
 {
 	int i;
@@ -362,6 +370,7 @@ static int do_connect(char *svr)
 	memset(&addr, 0, sizeof(addr));
 	addr.l2_family = AF_BLUETOOTH;
 	str2ba(svr, &addr.l2_bdaddr);
+	addr.l2_bdaddr_type = bdaddr_type;
 	if (cid)
 		addr.l2_cid = htobs(cid);
 	else if (psm)
@@ -1020,6 +1029,7 @@ static void info_request(char *svr)
 	memset(&addr, 0, sizeof(addr));
 	addr.l2_family = AF_BLUETOOTH;
 	str2ba(svr, &addr.l2_bdaddr);
+	addr.l2_bdaddr_type = bdaddr_type;
 
 	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0 ) {
 		perror("Can't connect socket");
@@ -1167,6 +1177,7 @@ static void do_pairing(char *svr)
 	memset(&addr, 0, sizeof(addr));
 	addr.l2_family = AF_BLUETOOTH;
 	str2ba(svr, &addr.l2_bdaddr);
+	addr.l2_bdaddr_type = bdaddr_type;
 
 	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0 ) {
 		perror("Can't connect socket");
@@ -1224,7 +1235,8 @@ static void usage(void)
 		"\t[-E] request encryption\n"
 		"\t[-S] secure connection\n"
 		"\t[-M] become master\n"
-		"\t[-T] enable timestamps\n");
+		"\t[-T] enable timestamps\n"
+		"\t[-V type] address type (help for list, default = bredr)\n");
 }
 
 int main(int argc, char *argv[])
@@ -1235,7 +1247,7 @@ int main(int argc, char *argv[])
 	bacpy(&bdaddr, BDADDR_ANY);
 
 	while ((opt = getopt(argc, argv, "rdscuwmntqxyzpb:a:"
-		"i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:H:K:RUGAESMT")) != EOF) {
+		"i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:H:K:V:RUGAESMT")) != EOF) {
 		switch (opt) {
 		case 'r':
 			mode = RECV;
@@ -1430,6 +1442,17 @@ int main(int argc, char *argv[])
 			rcvbuf = atoi(optarg);
 			break;
 
+		case 'V':
+			bdaddr_type = get_lookup_flag(bdaddr_types, optarg);
+
+			if (bdaddr_type == -1) {
+				print_lookup_values(bdaddr_types,
+						"List Address types:");
+				exit(1);
+			}
+
+			break;
+
 		default:
 			usage();
 			exit(1);
-- 
1.7.8.5

