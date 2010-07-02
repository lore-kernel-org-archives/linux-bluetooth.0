Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: [PATCH 4/5] sbc: faster 'sbc_calculate_bits' function
Date: Fri,  2 Jul 2010 15:25:41 +0300
Message-Id: <1278073542-14859-5-git-send-email-siarhei.siamashka@gmail.com>
In-Reply-To: <1278073542-14859-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1278073542-14859-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Siarhei Siamashka <siarhei.siamashka@nokia.com>

By using SBC_ALWAYS_INLINE trick, the implementation of 'sbc_calculate_bits'
function is split into two branches, each having 'subband' variable value
known at compile time. It helps the compiler to generate more optimal code
by saving at least one extra register, and also provides more obvious
opportunities for loops unrolling.

Benchmarked on ARM Cortex-A8:

== Before: ==

$ time ./sbcenc -b53 -s8 -j test.au > /dev/null

real    0m3.989s
user    0m3.602s
sys     0m0.391s

samples  %        image name               symbol name
26057    32.6128  sbcenc                   sbc_pack_frame
20003    25.0357  sbcenc                   sbc_analyze_4b_8s_neon
14220    17.7977  sbcenc                   sbc_calculate_bits
8498     10.6361  no-vmlinux               /no-vmlinux
5300      6.6335  sbcenc                   sbc_calc_scalefactors_j_neon
3235      4.0489  sbcenc                   sbc_enc_process_input_8s_be_neon
2172      2.7185  sbcenc                   sbc_encode

== After: ==

$ time ./sbcenc -b53 -s8 -j test.au > /dev/null

real    0m3.652s
user    0m3.195s
sys     0m0.445s

samples  %        image name               symbol name
26207    36.0095  sbcenc                   sbc_pack_frame
19820    27.2335  sbcenc                   sbc_analyze_4b_8s_neon
8629     11.8566  no-vmlinux               /no-vmlinux
6988      9.6018  sbcenc                   sbc_calculate_bits
5094      6.9994  sbcenc                   sbc_calc_scalefactors_j_neon
3351      4.6044  sbcenc                   sbc_enc_process_input_8s_be_neon
2182      2.9982  sbcenc                   sbc_encode
---
 sbc/sbc.c |   43 ++++++++++++++++++++++++++++---------------
 1 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 1921585..a6391ae 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -160,7 +160,8 @@ static uint8_t sbc_crc8(const uint8_t *data, size_t len)
  * Takes a pointer to the frame in question, a pointer to the bits array and
  * the sampling frequency (as 2 bit integer)
  */
-static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
+static SBC_ALWAYS_INLINE void sbc_calculate_bits_internal(
+		const struct sbc_frame *frame, int (*bits)[8], int subbands)
 {
 	uint8_t sf = frame->frequency;
 
@@ -171,17 +172,17 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
 		for (ch = 0; ch < frame->channels; ch++) {
 			max_bitneed = 0;
 			if (frame->allocation == SNR) {
-				for (sb = 0; sb < frame->subbands; sb++) {
+				for (sb = 0; sb < subbands; sb++) {
 					bitneed[ch][sb] = frame->scale_factor[ch][sb];
 					if (bitneed[ch][sb] > max_bitneed)
 						max_bitneed = bitneed[ch][sb];
 				}
 			} else {
-				for (sb = 0; sb < frame->subbands; sb++) {
+				for (sb = 0; sb < subbands; sb++) {
 					if (frame->scale_factor[ch][sb] == 0)
 						bitneed[ch][sb] = -5;
 					else {
-						if (frame->subbands == 4)
+						if (subbands == 4)
 							loudness = frame->scale_factor[ch][sb] - sbc_offset4[sf][sb];
 						else
 							loudness = frame->scale_factor[ch][sb] - sbc_offset8[sf][sb];
@@ -202,7 +203,7 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
 				bitslice--;
 				bitcount += slicecount;
 				slicecount = 0;
-				for (sb = 0; sb < frame->subbands; sb++) {
+				for (sb = 0; sb < subbands; sb++) {
 					if ((bitneed[ch][sb] > bitslice + 1) && (bitneed[ch][sb] < bitslice + 16))
 						slicecount++;
 					else if (bitneed[ch][sb] == bitslice + 1)
@@ -215,7 +216,7 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
 				bitslice--;
 			}
 
-			for (sb = 0; sb < frame->subbands; sb++) {
+			for (sb = 0; sb < subbands; sb++) {
 				if (bitneed[ch][sb] < bitslice + 2)
 					bits[ch][sb] = 0;
 				else {
@@ -225,7 +226,8 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
 				}
 			}
 
-			for (sb = 0; bitcount < frame->bitpool && sb < frame->subbands; sb++) {
+			for (sb = 0; bitcount < frame->bitpool &&
+							sb < subbands; sb++) {
 				if ((bits[ch][sb] >= 2) && (bits[ch][sb] < 16)) {
 					bits[ch][sb]++;
 					bitcount++;
@@ -235,7 +237,8 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
 				}
 			}
 
-			for (sb = 0; bitcount < frame->bitpool && sb < frame->subbands; sb++) {
+			for (sb = 0; bitcount < frame->bitpool &&
+							sb < subbands; sb++) {
 				if (bits[ch][sb] < 16) {
 					bits[ch][sb]++;
 					bitcount++;
@@ -251,7 +254,7 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
 		max_bitneed = 0;
 		if (frame->allocation == SNR) {
 			for (ch = 0; ch < 2; ch++) {
-				for (sb = 0; sb < frame->subbands; sb++) {
+				for (sb = 0; sb < subbands; sb++) {
 					bitneed[ch][sb] = frame->scale_factor[ch][sb];
 					if (bitneed[ch][sb] > max_bitneed)
 						max_bitneed = bitneed[ch][sb];
@@ -259,11 +262,11 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
 			}
 		} else {
 			for (ch = 0; ch < 2; ch++) {
-				for (sb = 0; sb < frame->subbands; sb++) {
+				for (sb = 0; sb < subbands; sb++) {
 					if (frame->scale_factor[ch][sb] == 0)
 						bitneed[ch][sb] = -5;
 					else {
-						if (frame->subbands == 4)
+						if (subbands == 4)
 							loudness = frame->scale_factor[ch][sb] - sbc_offset4[sf][sb];
 						else
 							loudness = frame->scale_factor[ch][sb] - sbc_offset8[sf][sb];
@@ -286,7 +289,7 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
 			bitcount += slicecount;
 			slicecount = 0;
 			for (ch = 0; ch < 2; ch++) {
-				for (sb = 0; sb < frame->subbands; sb++) {
+				for (sb = 0; sb < subbands; sb++) {
 					if ((bitneed[ch][sb] > bitslice + 1) && (bitneed[ch][sb] < bitslice + 16))
 						slicecount++;
 					else if (bitneed[ch][sb] == bitslice + 1)
@@ -301,7 +304,7 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
 		}
 
 		for (ch = 0; ch < 2; ch++) {
-			for (sb = 0; sb < frame->subbands; sb++) {
+			for (sb = 0; sb < subbands; sb++) {
 				if (bitneed[ch][sb] < bitslice + 2) {
 					bits[ch][sb] = 0;
 				} else {
@@ -325,7 +328,8 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
 			if (ch == 1) {
 				ch = 0;
 				sb++;
-				if (sb >= frame->subbands) break;
+				if (sb >= subbands)
+					break;
 			} else
 				ch = 1;
 		}
@@ -340,7 +344,8 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
 			if (ch == 1) {
 				ch = 0;
 				sb++;
-				if (sb >= frame->subbands) break;
+				if (sb >= subbands)
+					break;
 			} else
 				ch = 1;
 		}
@@ -349,6 +354,14 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
 
 }
 
+static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
+{
+	if (frame->subbands == 4)
+		sbc_calculate_bits_internal(frame, bits, 4);
+	else
+		sbc_calculate_bits_internal(frame, bits, 8);
+}
+
 /*
  * Unpacks a SBC frame at the beginning of the stream in data,
  * which has at most len bytes into frame.
-- 
1.6.4.4

