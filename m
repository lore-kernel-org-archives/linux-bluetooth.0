Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v9 15/16] sbc: Update sbcinfo for msbc
Date: Mon,  8 Apr 2013 15:24:17 +0200
Message-Id: <1365427458-26911-16-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1365427458-26911-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1365427458-26911-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sbcinfo.c |   54 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/src/sbcinfo.c b/src/sbcinfo.c
index 8cfb54a..81dec65 100644
--- a/src/sbcinfo.c
+++ b/src/sbcinfo.c
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
 #include <libgen.h>
@@ -61,12 +63,11 @@ struct sbc_frame_hdr {
 #error "Unknown byte order"
 #endif
 
-static int calc_frame_len(struct sbc_frame_hdr *hdr)
+static int calc_frame_len(struct sbc_frame_hdr *hdr, int nrof_blocks)
 {
-	int tmp, nrof_subbands, nrof_blocks;
+	int tmp, nrof_subbands;
 
 	nrof_subbands = (hdr->subbands + 1) * 4;
-	nrof_blocks = (hdr->blocks + 1) * 4;
 
 	switch (hdr->channel_mode) {
 	case 0x00:
@@ -89,13 +90,12 @@ static int calc_frame_len(struct sbc_frame_hdr *hdr)
 	return (nrof_subbands + ((tmp + 7) / 8));
 }
 
-static double calc_bit_rate(struct sbc_frame_hdr *hdr)
+static double calc_bit_rate(struct sbc_frame_hdr *hdr, int nrof_blocks)
 {
-	int nrof_subbands, nrof_blocks;
+	int nrof_subbands;
 	double f;
 
 	nrof_subbands = (hdr->subbands + 1) * 4;
-	nrof_blocks = (hdr->blocks + 1) * 4;
 
 	switch (hdr->sampling_frequency) {
 	case 0:
@@ -114,7 +114,7 @@ static double calc_bit_rate(struct sbc_frame_hdr *hdr)
 		return 0;
 	}
 
-	return ((8 * (calc_frame_len(hdr) + 4) * f) /
+	return ((8 * (calc_frame_len(hdr, nrof_blocks) + 4) * f) /
 			(nrof_subbands * nrof_blocks));
 }
 
@@ -176,6 +176,7 @@ static int analyze_file(char *filename)
 	int bitpool[SIZE], frame_len[SIZE];
 	int subbands, blocks, freq, method;
 	int n, p1, p2, fd, size, num;
+	bool msbc;
 	ssize_t len;
 	unsigned int count;
 
@@ -191,17 +192,32 @@ static int analyze_file(char *filename)
 		fd = fileno(stdin);
 
 	len = __read(fd, &hdr, sizeof(hdr));
-	if (len != sizeof(hdr) || hdr.syncword != 0x9c) {
+	if (len == sizeof(hdr) && hdr.syncword == 0x9c) {
+		msbc = false;
+	} else if (len == sizeof(hdr) && hdr.syncword == 0xad) {
+		msbc = true;
+	} else {
 		fprintf(stderr, "Not a SBC audio file\n");
 		return -1;
 	}
 
+	if (msbc) {
+		hdr.subbands = 1; /* 8 */
+		hdr.sampling_frequency = 0x00; /* 16000 */
+		hdr.allocation_method = 0; /* Loudness */
+		hdr.bitpool = 26;
+		hdr.channel_mode = 0x00; /* Mono */
+
+		blocks = 15;
+	} else {
+		blocks = (hdr.blocks + 1) * 4;
+	}
+
 	subbands = (hdr.subbands + 1) * 4;
-	blocks = (hdr.blocks + 1) * 4;
 	freq = hdr.sampling_frequency;
 	method = hdr.allocation_method;
 
-	count = calc_frame_len(&hdr);
+	count = calc_frame_len(&hdr, blocks);
 
 	bitpool[0] = hdr.bitpool;
 	frame_len[0] = count + 4;
@@ -213,7 +229,7 @@ static int analyze_file(char *filename)
 
 	if (lseek(fd, 0, SEEK_SET) < 0) {
 		num = 1;
-		rate = calc_bit_rate(&hdr);
+		rate = calc_bit_rate(&hdr, blocks);
 		while (count) {
 			size = count > sizeof(buf) ? sizeof(buf) : count;
 			len = __read(fd, buf, size);
@@ -237,14 +253,23 @@ static int analyze_file(char *filename)
 		if (len == 0)
 			break;
 
-		if ((size_t) len < sizeof(hdr) || hdr.syncword != 0x9c) {
+		if ((size_t) len < sizeof(hdr) || !(hdr.syncword == 0x9c ||
+				hdr.syncword == 0xad)) {
 			fprintf(stderr, "Corrupted SBC stream "
 					"(len %zd syncword 0x%02x)\n",
 					len, hdr.syncword);
 			break;
 		}
 
-		count = calc_frame_len(&hdr);
+		if (msbc) {
+			hdr.subbands = 1; /* 8 */
+			hdr.sampling_frequency = 0x00; /* 16000 */
+			hdr.allocation_method = 0; /* Loudness */
+			hdr.bitpool = 26;
+			hdr.channel_mode = 0x00; /* Mono */
+		}
+
+		count = calc_frame_len(&hdr, blocks);
 		len = count + 4;
 
 		p1 = -1;
@@ -273,10 +298,11 @@ static int analyze_file(char *filename)
 			count -= len;
 		}
 
-		rate += calc_bit_rate(&hdr);
+		rate += calc_bit_rate(&hdr, blocks);
 		num++;
 	}
 
+	printf("mSBC\t\t\t%d\n", msbc);
 	printf("Subbands\t\t%d\n", subbands);
 	printf("Block length\t\t%d\n", blocks);
 	printf("Sampling frequency\t%s\n", freq2str(freq));
-- 
1.7.9.5

