Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 08/10] sbc: Update sbcenc for msbc
Date: Fri, 26 Oct 2012 19:20:34 +0200
Message-Id: <1351272036-4875-9-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sbcenc.c |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/src/sbcenc.c b/src/sbcenc.c
index a723b03..71ad6bb 100644
--- a/src/sbcenc.c
+++ b/src/sbcenc.c
@@ -45,7 +45,7 @@ static int verbose = 0;
 static unsigned char input[BUF_SIZE], output[BUF_SIZE + BUF_SIZE / 4];
 
 static void encode(char *filename, int subbands, int bitpool, int joint,
-					int dualchannel, int snr, int blocks)
+				int dualchannel, int snr, int blocks, int msbc)
 {
 	struct au_header au_hdr;
 	sbc_t sbc;
@@ -87,7 +87,7 @@ static void encode(char *filename, int subbands, int bitpool, int joint,
 		goto done;
 	}
 
-	sbc_init(&sbc, 0L);
+	sbc_init(&sbc, msbc ? SBC_MSBC : 0L);
 
 	switch (BE_INT(au_hdr.sample_rate)) {
 	case 16000:
@@ -215,6 +215,7 @@ static void usage(void)
 	printf("Options:\n"
 		"\t-h, --help           Display help\n"
 		"\t-v, --verbose        Verbose mode\n"
+		"\t-m, --msbc           mSBC codec\n"
 		"\t-s, --subbands       Number of subbands to use (4 or 8)\n"
 		"\t-b, --bitpool        Bitpool value (default is 32)\n"
 		"\t-j, --joint          Joint stereo\n"
@@ -227,6 +228,7 @@ static void usage(void)
 static struct option main_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "verbose",	0, 0, 'v' },
+	{ "msbc",	0, 0, 'm' },
 	{ "subbands",	1, 0, 's' },
 	{ "bitpool",	1, 0, 'b' },
 	{ "joint",	0, 0, 'j' },
@@ -239,9 +241,9 @@ static struct option main_options[] = {
 int main(int argc, char *argv[])
 {
 	int i, opt, subbands = 8, bitpool = 32, joint = 0, dualchannel = 0;
-	int snr = 0, blocks = 16;
+	int snr = 0, blocks = 16, msbc = 0;
 
-	while ((opt = getopt_long(argc, argv, "+hvs:b:jdSB:",
+	while ((opt = getopt_long(argc, argv, "+hmvs:b:jdSB:",
 						main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'h':
@@ -252,6 +254,10 @@ int main(int argc, char *argv[])
 			verbose = 1;
 			break;
 
+		case 'm':
+			msbc = 1;
+			break;
+
 		case 's':
 			subbands = atoi(optarg);
 			if (subbands != 8 && subbands != 4) {
@@ -300,9 +306,18 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	if (msbc) {
+		subbands = 8;
+		bitpool = 26;
+		joint = 0;
+		dualchannel = 0;
+		snr = 0;
+		blocks = 15;
+	}
+
 	for (i = 0; i < argc; i++)
 		encode(argv[i], subbands, bitpool, joint, dualchannel,
-								snr, blocks);
+							snr, blocks, msbc);
 
 	return 0;
 }
-- 
1.7.9.5

