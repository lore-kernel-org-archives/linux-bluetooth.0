Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH hcidump] Restore --verbose/-V option
Date: Tue, 20 Dec 2011 14:47:13 +0100
Message-ID: <1324388833-28015-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ignore --verbose and -V options instead of printing usage info. This
is for compatibility with hcidump 1.x to not break scripts.
---
 src/hcidump.8 |    3 +++
 src/hcidump.c |    6 +++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/src/hcidump.8 b/src/hcidump.8
index aa91b81..db4b4fc 100644
--- a/src/hcidump.8
+++ b/src/hcidump.8
@@ -102,6 +102,9 @@ Extract PPP traffic with pppdump format.
 .BR -A ", " "\-\^\-audio=" "<file>"
 Extract SCO audio data.
 .TP
+.BR -V ", " "\-\^\-verbose"
+Ignored.
+.TP
 .BR -Y ", " "\-\^\-novendor"
 Don't display any vendor commands or events and don't show any pin code or link key in plain text.
 .TP
diff --git a/src/hcidump.c b/src/hcidump.c
index 0c13360..a738c07 100644
--- a/src/hcidump.c
+++ b/src/hcidump.c
@@ -893,6 +893,7 @@ static struct option main_options[] = {
 	{ "ipv6",		0, 0, '6' },
 	{ "help",		0, 0, 'h' },
 	{ "version",		0, 0, 'v' },
+	{ "verbose",		0, 0, 'V' },
 	{ 0 }
 };
 
@@ -905,7 +906,7 @@ int main(int argc, char *argv[])
 	int defcompid = DEFAULT_COMPID;
 	int opt, pppdump_fd = -1, audio_fd = -1;
 
-	while ((opt=getopt_long(argc, argv, "i:l:p:m:w:r:d:taxXRC:H:O:P:D:A:YZ46hv", main_options, NULL)) != -1) {
+	while ((opt=getopt_long(argc, argv, "i:l:p:m:w:r:d:taxXRC:H:O:P:D:A:YZ46hvV", main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
 			if (strcasecmp(optarg, "none") && strcasecmp(optarg, "system"))
@@ -1005,6 +1006,9 @@ int main(int argc, char *argv[])
 			printf("%s\n", VERSION);
 			exit(0);
 
+		case 'V':
+			break;
+
 		case 'h':
 		default:
 			usage();
-- 
on behalf of ST-Ericsson

