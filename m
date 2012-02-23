Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] l2test: Clean up lookup table code
Date: Thu, 23 Feb 2012 17:20:17 +0200
Message-Id: <1330010418-2613-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1330010418-2613-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1330010418-2613-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make lookup table code available for others
---
 test/l2test.c |   40 ++++++++++++++++++++++++++--------------
 1 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index c5bc3d3..ce20bb3 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -117,10 +117,12 @@ static int defer_setup = 0;
 static int priority = -1;
 static int rcvbuf = 0;
 
-static struct {
+struct lookup_table {
 	char	*name;
 	int	flag;
-} l2cap_modes[] = {
+};
+
+static struct lookup_table l2cap_modes[] = {
 	{ "basic",	L2CAP_MODE_BASIC	},
 	/* Not implemented
 	{ "flowctl",	L2CAP_MODE_FLOWCTL	},
@@ -131,14 +133,25 @@ static struct {
 	{ 0 }
 };
 
-static void list_l2cap_modes(void)
+static int get_lookup_flag(struct lookup_table *table, char *name)
 {
 	int i;
 
-	printf("l2test - L2CAP testing\n"
-		"List L2CAP modes:\n");
-	for (i=0; l2cap_modes[i].name; i++)
-		printf("\t%s\n", l2cap_modes[i].name);
+	for (i = 0; table[i].name; i++)
+		if (!strcasecmp(table[i].name, name))
+			return table[i].flag;
+
+	return -1;
+}
+
+static void print_lookup_values(struct lookup_table *table, char *header)
+{
+	int i;
+
+	printf("%s\n", header);
+
+	for (i=0; table[i].name; i++)
+		printf("\t%s\n", table[i].name);
 }
 
 static float tv2fl(struct timeval tv)
@@ -1199,7 +1212,7 @@ static void usage(void)
 int main(int argc, char *argv[])
 {
 	struct sigaction sa;
-	int opt, sk, i, mode = RECV, need_addr = 0;
+	int opt, sk, mode = RECV, need_addr = 0;
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
@@ -1321,14 +1334,13 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'X':
-			rfcmode = -1;
+			rfcmode = get_lookup_flag(l2cap_modes, optarg);
+
+			if (rfcmode == -1) {
+				print_lookup_values(l2cap_modes,
+						"List L2CAP modes:");
 
-			for (i = 0; l2cap_modes[i].name; i++)
-				if (!strcasecmp(l2cap_modes[i].name, optarg))
-					rfcmode = l2cap_modes[i].flag;
 
-			if (!strcasecmp(optarg, "help") || rfcmode == -1) {
-				list_l2cap_modes();
 				exit(1);
 			}
 
-- 
1.7.9

