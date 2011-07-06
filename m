Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/2] Bluez: l2test: enhance L2CAP mode option
Date: Wed,  6 Jul 2011 10:48:36 +0300
Message-Id: <1309938516-510-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1309938516-510-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1309938516-510-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 test/l2test.c |   43 +++++++++++++++++++++++++++++++++++++------
 1 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 3b606d2..e719c65 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -112,6 +112,30 @@ static int reliable = 0;
 static int timestamp = 0;
 static int defer_setup = 0;
 
+static struct {
+	char	*name;
+	int	flag;
+} l2cap_modes[] = {
+	{ "basic",	L2CAP_MODE_BASIC	},
+	/* Not implemented
+	{ "flowctl",	L2CAP_MODE_FLOWCTL	},
+	{ "retrans",	L2CAP_MODE_RETRANS	},
+	*/
+	{ "ertm",	L2CAP_MODE_ERTM		},
+	{ "streaming",	L2CAP_MODE_STREAMING	},
+	{ 0 }
+};
+
+static void list_l2cap_modes(void)
+{
+	int i;
+
+	printf("l2test - L2CAP testing\n"
+		"List L2CAP modes:\n");
+	for (i=0; l2cap_modes[i].name; i++)
+		printf("\t%s\n", l2cap_modes[i].name);
+}
+
 static float tv2fl(struct timeval tv)
 {
 	return (float)tv.tv_sec + (float)(tv.tv_usec/1000000.0);
@@ -1083,7 +1107,7 @@ static void usage(void)
 		"\t[-N num] send num frames (default = infinite)\n"
 		"\t[-C num] send num frames before delay (default = 1)\n"
 		"\t[-D milliseconds] delay after sending num frames (default = 0)\n"
-		"\t[-X mode] select retransmission/flow-control mode\n"
+		"\t[-X mode] l2cap mode (help for list, default = basic)\n"
 		"\t[-F fcs] use CRC16 check (default = 1)\n"
 		"\t[-Q num] Max Transmit value (default = 3)\n"
 		"\t[-Z size] Transmission Window size (default = 63)\n"
@@ -1100,7 +1124,7 @@ static void usage(void)
 int main(int argc, char *argv[])
 {
 	struct sigaction sa;
-	int opt, sk, mode = RECV, need_addr = 0;
+	int opt, sk, i, mode = RECV, need_addr = 0;
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
@@ -1218,10 +1242,17 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'X':
-			if (strcasecmp(optarg, "ertm") == 0)
-				rfcmode = L2CAP_MODE_ERTM;
-			else
-				rfcmode = atoi(optarg);
+			rfcmode = -1;
+
+			for (i = 0; l2cap_modes[i].name; i++)
+				if (!strcasecmp(l2cap_modes[i].name, optarg))
+					rfcmode = l2cap_modes[i].flag;
+			
+			if (!strcasecmp(optarg, "help") || rfcmode == -1) {
+				list_l2cap_modes();
+				exit(1);
+			}
+
 			break;
 
 		case 'F':
-- 
1.7.4.1

