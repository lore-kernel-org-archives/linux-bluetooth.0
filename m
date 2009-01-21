Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Use of -funroll-loops option to improve SBC encoder performance
Date: Wed, 21 Jan 2009 22:36:49 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hd4dJJWMkCXZ9+Q"
Message-Id: <200901212236.49702.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_hd4dJJWMkCXZ9+Q
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

Benchmark of a loop doing './sbcenc big_buck_bunny_480p_stereo.au > /dev/null'
is listed below. The number of iterations was different for ARM and x86, so
absolute times for x86 and ARM can't be directly compared :)

=== ARM Cortex-A8 ===

before:

real    0m 12.51s
user    0m 11.00s
sys     0m 0.58s

after:

real    0m 11.50s
user    0m 10.04s
sys     0m 0.54s

=== Intel Core2 ===

before:

real    0m12.139s
user    0m11.817s
sys     0m0.300s

after:

real    0m10.074s
user    0m9.797s
sys     0m0.256s

===

Overall improvement is more visible on x86, but it is still good for ARM too.
Code size increases quite noticeably, but this seems to pay off anyway.


-- 
Best regards,
Siarhei Siamashka

--Boundary-00=_hd4dJJWMkCXZ9+Q
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-Use-of-funroll-loops-option-to-improve-SBC-encoder.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-Use-of-funroll-loops-option-to-improve-SBC-encoder.patch"

>From 91d800ecc5f48692588ff908ca212d70eef5d0d3 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Wed, 21 Jan 2009 21:08:34 +0200
Subject: [PATCH] Use of -funroll-loops option to improve SBC encoder performance

Added the use of -funroll-loops gcc option for SBC. Also in
order to gain better effect, 'sbc_pack_frame' function
body moved to an inline function, which gets instantiated
for 4 different subbands/channels combinations. So that
'frame_subbands' and 'frame_channels' arguments become compile
time constants and can be better optimized by the compiler.
---
 sbc/Makefile.am      |    3 ++-
 sbc/sbc.c            |   49 +++++++++++++++++++++++++++++++++----------------
 sbc/sbc_primitives.h |    6 ++++++
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/sbc/Makefile.am b/sbc/Makefile.am
index d4ad194..3feb178 100644
--- a/sbc/Makefile.am
+++ b/sbc/Makefile.am
@@ -12,7 +12,8 @@ libsbc_la_SOURCES = sbc.h sbc.c sbc_math.h sbc_tables.h \
 	sbc_primitives.h sbc_primitives_mmx.h sbc_primitives_neon.h \
 	sbc_primitives.c sbc_primitives_mmx.c sbc_primitives_neon.c
 
-libsbc_la_CFLAGS = -finline-functions -funswitch-loops -fgcse-after-reload
+libsbc_la_CFLAGS = -finline-functions -funswitch-loops -fgcse-after-reload \
+	-funroll-loops
 
 noinst_PROGRAMS = sbcinfo sbcdec sbcenc $(sndfile_programs)
 
diff --git a/sbc/sbc.c b/sbc/sbc.c
index 827b731..190ac17 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -731,7 +731,9 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
  * -99 not implemented
  */
 
-static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
+static SBC_ALWAYS_INLINE int sbc_pack_frame_internal(
+	uint8_t *data, struct sbc_frame *frame, size_t len,
+	int frame_subbands, int frame_channels)
 {
 	/* Bitstream writer starts from the fourth byte */
 	uint8_t *data_ptr = data + 4;
@@ -761,7 +763,7 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 
 	data[1] |= (frame->allocation & 0x01) << 1;
 
-	switch (frame->subbands) {
+	switch (frame_subbands) {
 	case 4:
 		/* Nothing to do */
 		break;
@@ -776,11 +778,11 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 	data[2] = frame->bitpool;
 
 	if ((frame->mode == MONO || frame->mode == DUAL_CHANNEL) &&
-			frame->bitpool > frame->subbands << 4)
+			frame->bitpool > frame_subbands << 4)
 		return -5;
 
 	if ((frame->mode == STEREO || frame->mode == JOINT_STEREO) &&
-			frame->bitpool > frame->subbands << 5)
+			frame->bitpool > frame_subbands << 5)
 		return -5;
 
 	/* Can't fill in crc yet */
@@ -789,8 +791,8 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 	crc_header[1] = data[2];
 	crc_pos = 16;
 
-	for (ch = 0; ch < frame->channels; ch++) {
-		for (sb = 0; sb < frame->subbands; sb++) {
+	for (ch = 0; ch < frame_channels; ch++) {
+		for (sb = 0; sb < frame_subbands; sb++) {
 			frame->scale_factor[ch][sb] = 0;
 			scalefactor[ch][sb] = 2 << SCALE_OUT_BITS;
 			for (blk = 0; blk < frame->blocks; blk++) {
@@ -812,7 +814,7 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 		uint8_t joint = 0;
 		frame->joint = 0;
 
-		for (sb = 0; sb < frame->subbands - 1; sb++) {
+		for (sb = 0; sb < frame_subbands - 1; sb++) {
 			scale_factor_j[0] = 0;
 			scalefactor_j[0] = 2 << SCALE_OUT_BITS;
 			scale_factor_j[1] = 0;
@@ -844,7 +846,7 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 					(scale_factor_j[0] +
 					scale_factor_j[1])) {
 				/* use joint stereo for this subband */
-				joint |= 1 << (frame->subbands - 1 - sb);
+				joint |= 1 << (frame_subbands - 1 - sb);
 				frame->joint |= 1 << sb;
 				frame->scale_factor[0][sb] = scale_factor_j[0];
 				frame->scale_factor[1][sb] = scale_factor_j[1];
@@ -858,13 +860,13 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 		}
 
 		PUT_BITS(data_ptr, bits_cache, bits_count,
-			joint, frame->subbands);
+			joint, frame_subbands);
 		crc_header[crc_pos >> 3] = joint;
-		crc_pos += frame->subbands;
+		crc_pos += frame_subbands;
 	}
 
-	for (ch = 0; ch < frame->channels; ch++) {
-		for (sb = 0; sb < frame->subbands; sb++) {
+	for (ch = 0; ch < frame_channels; ch++) {
+		for (sb = 0; sb < frame_subbands; sb++) {
 			PUT_BITS(data_ptr, bits_cache, bits_count,
 				frame->scale_factor[ch][sb] & 0x0F, 4);
 			crc_header[crc_pos >> 3] <<= 4;
@@ -881,8 +883,8 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 
 	sbc_calculate_bits(frame, bits);
 
-	for (ch = 0; ch < frame->channels; ch++) {
-		for (sb = 0; sb < frame->subbands; sb++) {
+	for (ch = 0; ch < frame_channels; ch++) {
+		for (sb = 0; sb < frame_subbands; sb++) {
 			levels[ch][sb] = ((1 << bits[ch][sb]) - 1) <<
 				(32 - (frame->scale_factor[ch][sb] +
 					SCALE_OUT_BITS + 2));
@@ -893,8 +895,8 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 	}
 
 	for (blk = 0; blk < frame->blocks; blk++) {
-		for (ch = 0; ch < frame->channels; ch++) {
-			for (sb = 0; sb < frame->subbands; sb++) {
+		for (ch = 0; ch < frame_channels; ch++) {
+			for (sb = 0; sb < frame_subbands; sb++) {
 
 				if (bits[ch][sb] == 0)
 					continue;
@@ -914,6 +916,21 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 	return data_ptr - data;
 }
 
+static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
+{
+	if (frame->subbands == 4) {
+		if (frame->channels == 1)
+			return sbc_pack_frame_internal(data, frame, len, 4, 1);
+		else
+			return sbc_pack_frame_internal(data, frame, len, 4, 2);
+	} else {
+		if (frame->channels == 1)
+			return sbc_pack_frame_internal(data, frame, len, 8, 1);
+		else
+			return sbc_pack_frame_internal(data, frame, len, 8, 2);
+	}
+}
+
 static void sbc_encoder_init(struct sbc_encoder_state *state,
 				const struct sbc_frame *frame)
 {
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index 91b72ee..a418ed8 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -28,6 +28,12 @@
 
 #define SCALE_OUT_BITS 15
 
+#ifdef __GNUC__
+#define SBC_ALWAYS_INLINE __attribute__((always_inline))
+#else
+#define SBC_ALWAYS_INLINE inline
+#endif
+
 struct sbc_encoder_state {
 	int subbands;
 	int position[2];
-- 
1.5.6.5


--Boundary-00=_hd4dJJWMkCXZ9+Q--
