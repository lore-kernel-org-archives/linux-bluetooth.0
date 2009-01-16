Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Performance optimizations for sbcenc utility
Date: Fri, 16 Jan 2009 18:12:45 +0200
Cc: "Christian Hoene" <hoene@uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9HLcJIgPrNI4OeL"
Message-Id: <200901161812.45754.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_9HLcJIgPrNI4OeL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

The attached patch improves performance of sbcenc utility. This is not very
useful in general and does not improve the SBC codec itself. But when using
sbcenc utility for benchmarking, an extra unneeded overhead skews the results
a bit and this might be worth fixing.

Before patch:

real    0m14.984s
user    0m12.981s
sys     0m1.924s

After patch:

real    0m12.279s
user    0m11.865s
sys     0m0.360s


Christian, you fixed some bugs in sbcenc a bit earlier. Could you please
also check if all your testcases also work fine with this new patch applied
and it does not break anything?

-- 
Best regards,
Siarhei Siamashka

--Boundary-00=_9HLcJIgPrNI4OeL
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-Performance-optimizations-for-sbcenc-utility.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-Performance-optimizations-for-sbcenc-utility.patch"

>From b6ffabd4f7755ed6c968ecec0c8a0931eb6d7a66 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Fri, 16 Jan 2009 17:23:54 +0200
Subject: [PATCH] Performance optimizations for sbcenc utility

Read and write buffers sizes increased, memmove overhead eliminated.
Nonportable cast from 'unsigned char *' to 'struct au_header *' is
now also resolved as part of the changes.
---
 sbc/sbcenc.c |  122 ++++++++++++++++++++++++----------------------------------
 1 files changed, 50 insertions(+), 72 deletions(-)

diff --git a/sbc/sbcenc.c b/sbc/sbcenc.c
index 9cbfb87..388be2a 100644
--- a/sbc/sbcenc.c
+++ b/sbc/sbcenc.c
@@ -40,45 +40,15 @@
 
 static int verbose = 0;
 
-static ssize_t __read(int fd, void *buf, size_t count)
-{
-	ssize_t len, pos = 0;
-
-	while (count > 0) {
-		len = read(fd, buf + pos, count);
-		if (len <= 0)
-			return pos > len ? pos : len;
-
-		count -= len;
-		pos   += len;
-	}
-
-	return pos;
-}
-
-static ssize_t __write(int fd, const void *buf, size_t count)
-{
-	ssize_t len, pos = 0;
-
-	while (count > 0) {
-		len = write(fd, buf + pos, count);
-		if (len <= 0)
-			return len;
-
-		count -= len;
-		pos   += len;
-	}
-
-	return pos;
-}
+#define BUF_SIZE 32768
+static unsigned char input[BUF_SIZE], output[BUF_SIZE + BUF_SIZE / 4];
 
 static void encode(char *filename, int subbands, int bitpool, int joint,
 					int dualchannel, int snr, int blocks)
 {
-	struct au_header *au_hdr;
-	unsigned char input[2048], output[2048];
+	struct au_header au_hdr;
 	sbc_t sbc;
-	int fd, len, size, count, encoded, srate;
+	int fd, len, size, count, encoded, srate, codesize, nframes;
 
 	if (strcmp(filename, "-")) {
 		fd = open(filename, O_RDONLY);
@@ -90,8 +60,8 @@ static void encode(char *filename, int subbands, int bitpool, int joint,
 	} else
 		fd = fileno(stdin);
 
-	len = __read(fd, input, sizeof(input));
-	if (len < sizeof(*au_hdr)) {
+	len = read(fd, &au_hdr, sizeof(au_hdr));
+	if (len < sizeof(au_hdr)) {
 		if (fd > fileno(stderr))
 			fprintf(stderr, "Can't read header from file %s: %s\n",
 						filename, strerror(errno));
@@ -100,19 +70,17 @@ static void encode(char *filename, int subbands, int bitpool, int joint,
 		goto done;
 	}
 
-	au_hdr = (struct au_header *) input;
-
-	if (au_hdr->magic != AU_MAGIC ||
-			BE_INT(au_hdr->hdr_size) > 128 ||
-			BE_INT(au_hdr->hdr_size) < 24 ||
-			BE_INT(au_hdr->encoding) != AU_FMT_LIN16) {
+	if (au_hdr.magic != AU_MAGIC ||
+			BE_INT(au_hdr.hdr_size) > 128 ||
+			BE_INT(au_hdr.hdr_size) < 24 ||
+			BE_INT(au_hdr.encoding) != AU_FMT_LIN16) {
 		fprintf(stderr, "Not in Sun/NeXT audio S16_BE format\n");
 		goto done;
 	}
 
 	sbc_init(&sbc, 0L);
 
-	switch (BE_INT(au_hdr->sample_rate)) {
+	switch (BE_INT(au_hdr.sample_rate)) {
 	case 16000:
 		sbc.frequency = SBC_FREQ_16000;
 		break;
@@ -127,11 +95,11 @@ static void encode(char *filename, int subbands, int bitpool, int joint,
 		break;
 	}
 
-	srate = BE_INT(au_hdr->sample_rate);
+	srate = BE_INT(au_hdr.sample_rate);
 
 	sbc.subbands = subbands == 4 ? SBC_SB_4 : SBC_SB_8;
 
-	if (BE_INT(au_hdr->channels) == 1) {
+	if (BE_INT(au_hdr.channels) == 1) {
 		sbc.mode = SBC_MODE_MONO;
 		if (joint || dualchannel) {
 			fprintf(stderr, "Audio is mono but joint or "
@@ -151,9 +119,9 @@ static void encode(char *filename, int subbands, int bitpool, int joint,
 	}
 
 	sbc.endian = SBC_BE;
-	count = BE_INT(au_hdr->data_size);
-	size = len - BE_INT(au_hdr->hdr_size);
-	memmove(input, input + BE_INT(au_hdr->hdr_size), size);
+	count = BE_INT(au_hdr.data_size);
+	size = len - BE_INT(au_hdr.hdr_size);
+	memmove(input, input + BE_INT(au_hdr.hdr_size), size);
 
 	sbc.bitpool = bitpool;
 	sbc.allocation = snr ? SBC_AM_SNR : SBC_AM_LOUDNESS;
@@ -172,37 +140,47 @@ static void encode(char *filename, int subbands, int bitpool, int joint,
 						"STEREO" : "JOINTSTEREO");
 	}
 
+	codesize = sbc_get_codesize(&sbc);
+	nframes = sizeof(input) / codesize;
 	while (1) {
-		if (size < sizeof(input)) {
-			len = __read(fd, input + size, sizeof(input) - size);
-			if (len == 0 && size == 0)
-				break;
-
-			if (len < 0) {
-				perror("Can't read audio data");
+		unsigned char *inp, *outp;
+		/* read data for up to 'nframes' frames of input data */
+		size = read(fd, input, codesize * nframes);
+		if (size < 0) {
+			/* Something really bad happened */
+			perror("Can't read audio data");
+			break;
+		}
+		if (size < codesize) {
+			/* Not enough data for encoding even a single frame */
+			break;
+		}
+		/* encode all the data from the input buffer in a loop */
+		inp = input;
+		outp = output;
+		while (size >= codesize) {
+			len = sbc_encode(&sbc, inp, codesize,
+				outp, sizeof(output) - (outp - output),
+				&encoded);
+			if (len != codesize || encoded <= 0) {
+				fprintf(stderr,
+					"sbc_encode fail, len=%d, encoded=%d\n",
+					len, encoded);
 				break;
 			}
-
-			size += len;
+			size -= len;
+			inp += len;
+			outp += encoded;
 		}
-
-		len = sbc_encode(&sbc, input, size,
-					output, sizeof(output), &encoded);
-		if (len <= 0)
-			break;
-		if (len < size)
-			memmove(input, input + len, size - len);
-
-		size -= len;
-
-		len = __write(fileno(stdout), output, encoded);
-		if (len == 0)
-			break;
-
-		if (len < 0 || len != encoded) {
+		len = write(fileno(stdout), output, outp - output);
+		if (len != outp - output) {
 			perror("Can't write SBC output");
 			break;
 		}
+		if (size >= codesize) {
+			/* sbc_encode failure has been detected earlier */
+			break;
+		}
 	}
 
 	sbc_finish(&sbc);
-- 
1.5.6.5


--Boundary-00=_9HLcJIgPrNI4OeL--
