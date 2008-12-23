Return-Path: <cyrus@holtmann.org>
Subject: Patch for supporting even more command line parameters in sbcenc
From: Christian Hoene <hoene@uni-tuebingen.de>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-uufauC/DiG7NopbUFr56"
Date: Tue, 23 Dec 2008 11:18:11 +0100
Message-Id: <1230027491.20536.2.camel@hoene-desktop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-uufauC/DiG7NopbUFr56
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

in order to test the performance of SBC, I needed to add some more
parameter options to "sbcenc".
Attached the patch.

Greetings
 Christian


--=-uufauC/DiG7NopbUFr56
Content-Disposition: attachment; filename=adding.even.more.parameters.to.sbcenc.diff
Content-Type: text/x-patch; name=adding.even.more.parameters.to.sbcenc.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/sbc/sbcenc.c b/sbc/sbcenc.c
index 74a3434..e786c70 100644
--- a/sbc/sbcenc.c
+++ b/sbc/sbcenc.c
@@ -73,7 +73,7 @@ static ssize_t __write(int fd, const void *buf, size_t count)
 }
 
 static void encode(char *filename, int subbands,
-					int bitpool, int joint, int snr)
+					int bitpool, int joint, int dualchannel, int snr, int blocks)
 {
 	struct au_header *au_hdr;
 	unsigned char input[2048], output[2048];
@@ -131,4 +131,4 @@ static void encode(char *filename, int subbands,
 
 	sbc.subbands = subbands == 4 ? SBC_SB_4 : SBC_SB_8;
 
-	if (BE_INT(au_hdr->channels) == 1)
+	if (BE_INT(au_hdr->channels) == 1) {
		sbc.mode = SBC_MODE_MONO;
-	else if (joint)
+		if(joint || dualchannel) {
+			fprintf(stderr, "Audio file is mono but joint or dualchannel mode has been specified\n");
+			goto done;
+		}
+	}
+	else if (joint && !dualchannel)
 		sbc.mode = SBC_MODE_JOINT_STEREO;
-	else
-		sbc.mode = SBC_MODE_STEREO;
-
+	else if(!joint && dualchannel)
+    		sbc.mode = SBC_MODE_DUAL_CHANNEL;
+	else if(!joint && !dualchannel)
+    		sbc.mode = SBC_MODE_STEREO;
+	else  {
+		fprintf(stderr, "Both joint and dualchannel mode have been specified\n");
+		goto done;
+	}
+	    
 	sbc.endian = SBC_BE;
 	count = BE_INT(au_hdr->data_size);
 	size = len - BE_INT(au_hdr->hdr_size);
@@ -145,15 +156,17 @@ static void encode(char *filename, int subbands,
 
 	sbc.bitpool = bitpool;
 	sbc.allocation = snr ? SBC_AM_SNR : SBC_AM_LOUDNESS;
+	sbc.blocks = blocks / 4;
 
 	if(verbose) {
 		fprintf(stderr,"encoding %s with rate %d, %d subbands, "
-			"%d bits, allocation method %s and mode %s\n",
+			"%d bits, allocation method %s, mode %s, and %d blocks\n",
 			filename, srate, subbands, bitpool,
 			sbc.allocation == SBC_AM_SNR ? "SNR" : "LOUDNESS",
 			sbc.mode == SBC_MODE_MONO ? "MONO" :
 					sbc.mode == SBC_MODE_STEREO ?
-						"STEREO" : "JOINTSTEREO");
+						"STEREO" : "JOINTSTEREO",
+			blocks);
 	}
 
 	while (1) {
@@ -209,7 +222,9 @@ static void usage(void)
 		"\t-s, --subbands       Number of subbands to use (4 or 8)\n"
 		"\t-b, --bitpool        Bitpool value (default is 32)\n"
 		"\t-j, --joint          Joint stereo\n"
+		"\t-d, --dualchannel    Dual channel\n"
 		"\t-S, --snr            Use SNR mode (default is loudness)\n"
+	        "\t-B, --blocks         Number of blocks to use (4, 8, 12 or 16)\n"
 		"\n");
 }
 
@@ -219,15 +234,17 @@ static struct option main_options[] = {
 	{ "subbands",	1, 0, 's' },
 	{ "bitpool",	1, 0, 'b' },
 	{ "joint",	0, 0, 'j' },
+	{ "dualchannel",0, 0, 'd' },
 	{ "snr",	0, 0, 'S' },
+	{ "blocks",	1, 0, 'B' },
 	{ 0, 0, 0, 0 }
 };
 
 int main(int argc, char *argv[])
 {
-	int i, opt, subbands = 8, bitpool = 32, joint = 0, snr= 0;
+	int i, opt, subbands = 8, bitpool = 32, joint = 0, dualchannel = 0, snr = 0, blocks = 16;
 
-	while ((opt = getopt_long(argc, argv, "+hvs:b:jS",
+	while ((opt = getopt_long(argc, argv, "+hvs:b:jdSB:",
 						main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'h':
@@ -255,10 +272,23 @@ int main(int argc, char *argv[])
 			joint = 1;
 			break;
 
+		case 'd':
+			dualchannel = 1;
+			break;
+
 		case 'S':
 			snr = 1;
 			break;
 
+		case 'B':
+    		        blocks = atoi(optarg);
+			if (blocks != 16 && blocks != 12 && blocks != 8 && blocks != 4) {
+				fprintf(stderr, "Invalid blocks %d!\n",
+					blocks);
+				exit(1);
+			}
+			break;
+
 		default:
 			exit(1);
 		}
@@ -274,7 +304,7 @@ int main(int argc, char *argv[])
 	}
 
 	for (i = 0; i < argc; i++)
-		encode(argv[i], subbands, bitpool, joint, snr);
+	        encode(argv[i], subbands, bitpool, joint, dualchannel, snr, blocks);
 
 	return 0;
 }

--=-uufauC/DiG7NopbUFr56--

