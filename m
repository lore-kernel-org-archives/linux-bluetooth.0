Return-Path: <cyrus@holtmann.org>
Subject: Re: Patch for supporting even more command line parameters in
	sbcenc
From: Christian Hoene <hoene@uni-tuebingen.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1230028921.8047.28.camel@californication>
References: <1230027491.20536.2.camel@hoene-desktop>
	 <1230028921.8047.28.camel@californication>
Content-Type: multipart/mixed; boundary="=-3AJuYzz36hMyupSIXbA8"
Date: Tue, 23 Dec 2008 13:56:20 +0100
Message-Id: <1230036980.20536.5.camel@hoene-desktop>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-3AJuYzz36hMyupSIXbA8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcel,


> can you get me one with proper coding style please. Also the maximum
> width is 80 characters :)

Fixed. Attached the patch.

 Christian




--=-3AJuYzz36hMyupSIXbA8
Content-Disposition: attachment; filename=patch_for_empty_frames_and_more_sbcenc_parameters.diff
Content-Type: text/x-patch; name=patch_for_empty_frames_and_more_sbcenc_parameters.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 5411893..263d46a 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1196,6 +1196,9 @@ int sbc_decode(sbc_t *sbc, void *input, int input_len, void *output,
 	if (written)
 		*written = 0;
 
+	if (framelen<=0)
+		return framelen;
+
 	samples = sbc_synthesize_audio(&priv->dec_state, &priv->frame);
 
 	ptr = output;
diff --git a/sbc/sbcenc.c b/sbc/sbcenc.c
index 74a3434..c595725 100644
--- a/sbc/sbcenc.c
+++ b/sbc/sbcenc.c
@@ -72,8 +72,8 @@ static ssize_t __write(int fd, const void *buf, size_t count)
 	return pos;
 }
 
-static void encode(char *filename, int subbands,
-					int bitpool, int joint, int snr)
+static void encode(char *filename, int subbands, int bitpool, int joint,
+   			int dualchannel, int snr, int blocks)
 {
 	struct au_header *au_hdr;
 	unsigned char input[2048], output[2048];
@@ -131,12 +131,24 @@ static void encode(char *filename, int subbands,
 
 	sbc.subbands = subbands == 4 ? SBC_SB_4 : SBC_SB_8;
 
-	if (BE_INT(au_hdr->channels) == 1)
+	if (BE_INT(au_hdr->channels) == 1) {
 		sbc.mode = SBC_MODE_MONO;
-	else if (joint)
+		if (joint || dualchannel) {
+			fprintf(stderr, "Audio file is mono but joint or"
+				"dualchannel mode has been specified\n");
+			goto done;
+		}
+	} else if (joint && !dualchannel)
 		sbc.mode = SBC_MODE_JOINT_STEREO;
-	else
-		sbc.mode = SBC_MODE_STEREO;
+	else if (!joint && dualchannel)
+    		sbc.mode = SBC_MODE_DUAL_CHANNEL;
+	else if (!joint && !dualchannel)
+    		sbc.mode = SBC_MODE_STEREO;
+	else  {
+		fprintf(stderr, "Both joint and dualchannel mode have been"
+				"specified\n");
+		goto done;
+	}
 
 	sbc.endian = SBC_BE;
 	count = BE_INT(au_hdr->data_size);
@@ -145,15 +157,18 @@ static void encode(char *filename, int subbands,
 
 	sbc.bitpool = bitpool;
 	sbc.allocation = snr ? SBC_AM_SNR : SBC_AM_LOUDNESS;
+	sbc.blocks = blocks / 4;
 
-	if(verbose) {
+	if (verbose) {
 		fprintf(stderr,"encoding %s with rate %d, %d subbands, "
-			"%d bits, allocation method %s and mode %s\n",
+			"%d bits, allocation method %s, mode %s, "
+			"and %d blocks\n",
 			filename, srate, subbands, bitpool,
 			sbc.allocation == SBC_AM_SNR ? "SNR" : "LOUDNESS",
 			sbc.mode == SBC_MODE_MONO ? "MONO" :
 					sbc.mode == SBC_MODE_STEREO ?
-						"STEREO" : "JOINTSTEREO");
+						"STEREO" : "JOINTSTEREO",
+			blocks);
 	}
 
 	while (1) {
@@ -209,7 +224,10 @@ static void usage(void)
 		"\t-s, --subbands       Number of subbands to use (4 or 8)\n"
 		"\t-b, --bitpool        Bitpool value (default is 32)\n"
 		"\t-j, --joint          Joint stereo\n"
+		"\t-d, --dualchannel    Dual channel\n"
 		"\t-S, --snr            Use SNR mode (default is loudness)\n"
+		"\t-B, --blocks         Number of blocks to use (4, 8, 12 "
+			"or 16)\n"
 		"\n");
 }
 
@@ -219,15 +237,18 @@ static struct option main_options[] = {
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
+	int i, opt, subbands = 8, bitpool = 32, joint = 0, dualchannel = 0;
+	int snr = 0, blocks = 16;
 
-	while ((opt = getopt_long(argc, argv, "+hvs:b:jS",
+	while ((opt = getopt_long(argc, argv, "+hvs:b:jdSB:",
 						main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'h':
@@ -255,10 +276,24 @@ int main(int argc, char *argv[])
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
+			if (blocks != 16 && blocks != 12 &&
+				blocks != 8 && blocks != 4) {
+				fprintf(stderr, "Invalid blocks %d!\n",
+					blocks);
+				exit(1);
+			}
+			break;
+
 		default:
 			exit(1);
 		}
@@ -274,7 +309,8 @@ int main(int argc, char *argv[])
 	}
 
 	for (i = 0; i < argc; i++)
-		encode(argv[i], subbands, bitpool, joint, snr);
+	        encode(argv[i], subbands, bitpool, joint, dualchannel,
+		       snr, blocks);
 
 	return 0;
 }

--=-3AJuYzz36hMyupSIXbA8--
