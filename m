Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] test/agent.c: rename option device into adapter
Date: Thu,  2 Jul 2009 11:14:25 +0200
Message-Id: <1246526068-13364-2-git-send-email-filippo@esaurito.net>
In-Reply-To: <1246526068-13364-1-git-send-email-filippo@esaurito.net>
References: <1246526068-13364-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/agent.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index 64362e8..b9485d2 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -468,12 +468,12 @@ static void usage(void)
 	printf("Bluetooth agent ver %s\n\n", VERSION);
 
 	printf("Usage:\n"
-		"\tagent [--device interface] [--path agent-path] <passkey> [<target_device>]\n"
+		"\tagent [--adapter adapter-path] [--path agent-path] <passkey> [<target_device>]\n"
 		"\n");
 }
 
 static struct option main_options[] = {
-	{ "device",	1, 0, 'i' },
+	{ "adapter",	1, 0, 'a' },
 	{ "path",	1, 0, 'p' },
 	{ "capabilites",1, 0, 'c' },
 	{ "reject",	0, 0, 'r' },
@@ -493,9 +493,9 @@ int main(int argc, char *argv[])
 	snprintf(default_path, sizeof(default_path),
 					"/org/bluez/agent_%d", getpid());
 
-	while ((opt = getopt_long(argc, argv, "+i:p:c:rh", main_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "+a:p:c:rh", main_options, NULL)) != EOF) {
 		switch(opt) {
-		case 'i':
+		case 'a':
 			adapter_id = optarg;
 			break;
 		case 'p':
-- 
1.6.3.3

