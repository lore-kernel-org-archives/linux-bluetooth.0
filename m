Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v8 15/16] sbc: Update sbcenc for msbc
Date: Fri, 29 Mar 2013 16:58:19 +0100
Message-Id: <1364572700-31701-16-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1364572700-31701-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1364572700-31701-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sbcenc.c |  107 +++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 64 insertions(+), 43 deletions(-)

diff --git a/src/sbcenc.c b/src/sbcenc.c
index a723b03..c766767 100644
--- a/src/sbcenc.c
+++ b/src/sbcenc.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2008-2010  Nokia Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2012-2013  Intel Corporation
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -31,6 +32,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <stdint.h>
 #include <string.h>
 #include <getopt.h>
@@ -45,7 +47,7 @@ static int verbose = 0;
 static unsigned char input[BUF_SIZE], output[BUF_SIZE + BUF_SIZE / 4];
 
 static void encode(char *filename, int subbands, int bitpool, int joint,
-					int dualchannel, int snr, int blocks)
+				int dualchannel, int snr, int blocks, bool msbc)
 {
 	struct au_header au_hdr;
 	sbc_t sbc;
@@ -87,57 +89,69 @@ static void encode(char *filename, int subbands, int bitpool, int joint,
 		goto done;
 	}
 
-	sbc_init(&sbc, 0L);
-
-	switch (BE_INT(au_hdr.sample_rate)) {
-	case 16000:
-		sbc.frequency = SBC_FREQ_16000;
-		break;
-	case 32000:
-		sbc.frequency = SBC_FREQ_32000;
-		break;
-	case 44100:
-		sbc.frequency = SBC_FREQ_44100;
-		break;
-	case 48000:
-		sbc.frequency = SBC_FREQ_48000;
-		break;
-	}
+	if (!msbc) {
+		sbc_init(&sbc, 0L);
+
+		switch (BE_INT(au_hdr.sample_rate)) {
+		case 16000:
+			sbc.frequency = SBC_FREQ_16000;
+			break;
+		case 32000:
+			sbc.frequency = SBC_FREQ_32000;
+			break;
+		case 44100:
+			sbc.frequency = SBC_FREQ_44100;
+			break;
+		case 48000:
+			sbc.frequency = SBC_FREQ_48000;
+			break;
+		}
+
+		srate = BE_INT(au_hdr.sample_rate);
 
-	srate = BE_INT(au_hdr.sample_rate);
+		sbc.subbands = subbands == 4 ? SBC_SB_4 : SBC_SB_8;
 
-	sbc.subbands = subbands == 4 ? SBC_SB_4 : SBC_SB_8;
+		if (BE_INT(au_hdr.channels) == 1) {
+			sbc.mode = SBC_MODE_MONO;
+			if (joint || dualchannel) {
+				fprintf(stderr, "Audio is mono but joint or "
+					"dualchannel mode has been specified\n");
+				goto done;
+			}
+		} else if (joint && !dualchannel)
+			sbc.mode = SBC_MODE_JOINT_STEREO;
+		else if (!joint && dualchannel)
+			sbc.mode = SBC_MODE_DUAL_CHANNEL;
+		else if (!joint && !dualchannel)
+			sbc.mode = SBC_MODE_STEREO;
+		else {
+			fprintf(stderr, "Both joint and dualchannel mode have been "
+									"specified\n");
+			goto done;
+		}
 
-	if (BE_INT(au_hdr.channels) == 1) {
-		sbc.mode = SBC_MODE_MONO;
-		if (joint || dualchannel) {
-			fprintf(stderr, "Audio is mono but joint or "
-				"dualchannel mode has been specified\n");
+		sbc.endian = SBC_BE;
+		sbc.bitpool = bitpool;
+		sbc.allocation = snr ? SBC_AM_SNR : SBC_AM_LOUDNESS;
+		sbc.blocks = blocks == 4 ? SBC_BLK_4 :
+				blocks == 8 ? SBC_BLK_8 :
+					blocks == 12 ? SBC_BLK_12 : SBC_BLK_16;
+	} else {
+		if (BE_INT(au_hdr.sample_rate) != 16000 ||
+				BE_INT(au_hdr.channels) != 1 ||
+				BE_INT(au_hdr.channels) != 1) {
+			fprintf(stderr, "mSBC requires 16 bits, 16kHz, mono input\n");
 			goto done;
 		}
-	} else if (joint && !dualchannel)
-		sbc.mode = SBC_MODE_JOINT_STEREO;
-	else if (!joint && dualchannel)
-		sbc.mode = SBC_MODE_DUAL_CHANNEL;
-	else if (!joint && !dualchannel)
-		sbc.mode = SBC_MODE_STEREO;
-	else {
-		fprintf(stderr, "Both joint and dualchannel mode have been "
-								"specified\n");
-		goto done;
+
+		sbc_init_msbc(&sbc, 0);
+		sbc.endian = SBC_BE;
 	}
 
-	sbc.endian = SBC_BE;
 	/* Skip extra bytes of the header if any */
 	if (read(fd, input, BE_INT(au_hdr.hdr_size) - len) < 0)
 		goto done;
 
-	sbc.bitpool = bitpool;
-	sbc.allocation = snr ? SBC_AM_SNR : SBC_AM_LOUDNESS;
-	sbc.blocks = blocks == 4 ? SBC_BLK_4 :
-			blocks == 8 ? SBC_BLK_8 :
-				blocks == 12 ? SBC_BLK_12 : SBC_BLK_16;
-
 	if (verbose) {
 		fprintf(stderr, "encoding %s with rate %d, %d blocks, "
 			"%d subbands, %d bits, allocation method %s, "
@@ -215,6 +229,7 @@ static void usage(void)
 	printf("Options:\n"
 		"\t-h, --help           Display help\n"
 		"\t-v, --verbose        Verbose mode\n"
+		"\t-m, --msbc           mSBC codec\n"
 		"\t-s, --subbands       Number of subbands to use (4 or 8)\n"
 		"\t-b, --bitpool        Bitpool value (default is 32)\n"
 		"\t-j, --joint          Joint stereo\n"
@@ -227,6 +242,7 @@ static void usage(void)
 static struct option main_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "verbose",	0, 0, 'v' },
+	{ "msbc",	0, 0, 'm' },
 	{ "subbands",	1, 0, 's' },
 	{ "bitpool",	1, 0, 'b' },
 	{ "joint",	0, 0, 'j' },
@@ -240,8 +256,9 @@ int main(int argc, char *argv[])
 {
 	int i, opt, subbands = 8, bitpool = 32, joint = 0, dualchannel = 0;
 	int snr = 0, blocks = 16;
+	bool msbc = false;
 
-	while ((opt = getopt_long(argc, argv, "+hvs:b:jdSB:",
+	while ((opt = getopt_long(argc, argv, "+hmvs:b:jdSB:",
 						main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'h':
@@ -252,6 +269,10 @@ int main(int argc, char *argv[])
 			verbose = 1;
 			break;
 
+		case 'm':
+			msbc = true;
+			break;
+
 		case 's':
 			subbands = atoi(optarg);
 			if (subbands != 8 && subbands != 4) {
@@ -302,7 +323,7 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < argc; i++)
 		encode(argv[i], subbands, bitpool, joint, dualchannel,
-								snr, blocks);
+							snr, blocks, msbc);
 
 	return 0;
 }
-- 
1.7.9.5

