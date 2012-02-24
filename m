Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/3] l2test: Add BT Channel Policy option
Date: Fri, 24 Feb 2012 10:44:25 +0200
Message-Id: <1330073065-8188-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1330073065-8188-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1330073065-8188-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make l2test able to set channel policy socket option.
---
 test/l2test.c |   32 ++++++++++++++++++++++++++++++--
 1 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 3705fdc..9f615a2 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -116,6 +116,7 @@ static int timestamp = 0;
 static int defer_setup = 0;
 static int priority = -1;
 static int rcvbuf = 0;
+static int chan_policy;
 
 struct lookup_table {
 	char	*name;
@@ -133,6 +134,13 @@ static struct lookup_table l2cap_modes[] = {
 	{ 0 }
 };
 
+static struct lookup_table chan_policies[] = {
+	{ "bredr",	BT_CHANNEL_POLICY_BREDR_ONLY		},
+	{ "bredr_pref",	BT_CHANNEL_POLICY_BREDR_PREFERRED	},
+	{ "amp_pref",	BT_CHANNEL_POLICY_AMP_PREFERRED		},
+	{ NULL,		0					},
+};
+
 static int get_lookup_flag(struct lookup_table *table, char *name)
 {
 	int i;
@@ -296,6 +304,15 @@ static int do_connect(char *svr)
 	}
 #endif
 
+	if (chan_policy != -1) {
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_CHANNEL_POLICY,
+				&chan_policy, sizeof(chan_policy)) < 0) {
+			syslog(LOG_ERR, "Can't enable chan policy : %s (%d)",
+							strerror(errno), errno);
+			goto error;
+		}
+	}
+
 	/* Enable SO_LINGER */
 	if (linger) {
 		struct linger l = { .l_onoff = 1, .l_linger = linger };
@@ -1194,6 +1211,7 @@ static void usage(void)
 		"\t[-D milliseconds] delay after sending num frames (default = 0)\n"
 		"\t[-K milliseconds] delay before receiving (default = 0)\n"
 		"\t[-X mode] l2cap mode (help for list, default = basic)\n"
+		"\t[-a policy] chan policy (help for list, default = bredr)\n"
 		"\t[-F fcs] use CRC16 check (default = 1)\n"
 		"\t[-Q num] Max Transmit value (default = 3)\n"
 		"\t[-Z size] Transmission Window size (default = 63)\n"
@@ -1216,8 +1234,9 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:H:K:RUGAESMT")) != EOF) {
-		switch(opt) {
+	while ((opt = getopt(argc, argv, "rdscuwmntqxyzpb:a:"
+		"i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:H:K:RUGAESMT")) != EOF) {
+		switch (opt) {
 		case 'r':
 			mode = RECV;
 			break;
@@ -1339,8 +1358,17 @@ int main(int argc, char *argv[])
 			if (rfcmode == -1) {
 				print_lookup_values(l2cap_modes,
 						"List L2CAP modes:");
+				exit(1);
+			}
+
+			break;
 
+		case 'a':
+			chan_policy = get_lookup_flag(chan_policies, optarg);
 
+			if (chan_policy == -1) {
+				print_lookup_values(chan_policies,
+						"List L2CAP chan policies:");
 				exit(1);
 			}
 
-- 
1.7.9

