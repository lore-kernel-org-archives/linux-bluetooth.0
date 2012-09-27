Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 3/5] update sbcdec for msbc
Date: Thu, 27 Sep 2012 16:44:26 +0200
Message-Id: <1348757068-31048-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1348757068-31048-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1348757068-31048-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sbcdec.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/src/sbcdec.c b/src/sbcdec.c
index 0077a82..37d2e98 100644
--- a/src/sbcdec.c
+++ b/src/sbcdec.c
@@ -44,7 +44,7 @@
 
 static int verbose = 0;
 
-static void decode(char *filename, char *output, int tofile)
+static void decode(char *filename, char *output, int tofile, int msbc)
 {
 	unsigned char buf[BUF_SIZE], *stream;
 	struct stat st;
@@ -98,7 +98,7 @@ static void decode(char *filename, char *output, int tofile)
 		goto free;
 	}
 
-	sbc_init(&sbc, 0L);
+	sbc_init(&sbc, msbc ? SBC_MSBC : 0L);
 	sbc.endian = SBC_BE;
 
 	framelen = sbc_decode(&sbc, stream, streamlen, buf, sizeof(buf), &len);
@@ -228,14 +228,16 @@ static void usage(void)
 
 	printf("Options:\n"
 		"\t-h, --help           Display help\n"
-		"\t-v, --verbose        Verbose mode\n"
 		"\t-d, --device <dsp>   Sound device\n"
+		"\t-v, --verbose        Verbose mode\n"
+		"\t-m, --msbc           mSBC codec\n"
 		"\t-f, --file <file>    Decode to a file\n"
 		"\n");
 }
 
 static struct option main_options[] = {
 	{ "help",	0, 0, 'h' },
+	{ "msbc",	0, 0, 'm' },
 	{ "device",	1, 0, 'd' },
 	{ "verbose",	0, 0, 'v' },
 	{ "file",	1, 0, 'f' },
@@ -246,8 +248,9 @@ int main(int argc, char *argv[])
 {
 	char *output = NULL;
 	int i, opt, tofile = 0;
+	int msbc = 0;
 
-	while ((opt = getopt_long(argc, argv, "+hvd:f:",
+	while ((opt = getopt_long(argc, argv, "+hmvd:f:",
 						main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'h':
@@ -258,6 +261,10 @@ int main(int argc, char *argv[])
 			verbose = 1;
 			break;
 
+		case 'm':
+			msbc = 1;
+			break;
+
 		case 'd':
 			free(output);
 			output = strdup(optarg);
@@ -285,7 +292,7 @@ int main(int argc, char *argv[])
 	}
 
 	for (i = 0; i < argc; i++)
-		decode(argv[i], output ? output : "/dev/dsp", tofile);
+		decode(argv[i], output ? output : "/dev/dsp", tofile, msbc);
 
 	free(output);
 
-- 
1.7.9.5

