Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <431E6A62.4000900@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed;
 boundary="------------060302000307000600030608"
Subject: [Bluez-devel] a2play/rtc and sbc/decode
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 06 Sep 2005 22:19:46 -0600

This is a multi-part message in MIME format.
--------------060302000307000600030608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hey

I found out how to use the rtc value that read() provides... no docs
anywhere covered it so I had to dig into the source. Now we at least use
this properly in a2play but the timing was always wrong... using the 
frame timing info from libsbc may not be the right way to go about it.

I also was simplifying and preparing to unroll the decoder.
Unfortunately, the decoder state array is getting walked on, apparently
outside the decoder function (whether it's in libsbc or sbcdec isn't clear)

The patch attached tries to run both the 8 subband decoder that does
massive copies along with the no-copy version but the no-copy version
quickly goes out of sync.

Brad

--------------060302000307000600030608
Content-Type: text/x-patch;
 name="sbc-decode1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sbc-decode1.patch"

? .deps
? Makefile
? Makefile.in
? a2play
? a2recv
? aclocal.m4
? autom4te.cache
? btsco
? btsco2
? charm.sbc
? config.h
? config.h.in
? config.log
? config.status
? configure
? go
? install-sh
? missing
? mkinstalldirs
? soon.sbc
? stamp-h1
? avdtp/Makefile
? avdtp/Makefile.in
? avdtp/avtest
? bt/.deps
? bt/.libs
? bt/libasound_module_pcm_a2dp.la
? bt/out
? bt/pcm_a2dp.lo
? kernel/.btsco.o.cmd
? kernel/.snd-bt-sco.ko.cmd
? kernel/.snd-bt-sco.mod.o.cmd
? kernel/.snd-bt-sco.o.cmd
? kernel/.tmp_versions
? kernel/snd-bt-sco.ko
? kernel/snd-bt-sco.mod.c
? sbc/Makefile
? sbc/Makefile.in
? sbc/a.out
? sbc/gen_fixed
? sbc/rcplay
? sbc/sbcdec
? sbc/sbcenc
? sbc/sbcinfo
? sbc/t1.au
? sbc/t1.sbc
? sbc/unroll.c
Index: sbc/sbc.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/sbc/sbc.c,v
retrieving revision 1.59
diff -u -b -B -w -p -r1.59 sbc.c
--- sbc/sbc.c	6 Sep 2005 21:27:35 -0000	1.59
+++ sbc/sbc.c	7 Sep 2005 04:09:51 -0000
@@ -97,6 +97,9 @@ struct sbc_decoder_state {
 	int subbands;
 	float X[2][8];				/* Audio samples */
 	float V[2][160];	/* Vectors */
+	float X2[2][8];
+	float V2[2][160];
+	int offset;
 };
 
 struct sbc_encoder_state {
@@ -567,6 +570,9 @@ static void sbc_decoder_init(struct sbc_
 	memset(&state->X, 0, sizeof(state->X));
 	memset(&state->V, 0, sizeof(state->V));
 	state->subbands = frame->subbands;
+	state->offset = 0;
+	memset(&state->X2, 0, sizeof(state->X2));
+	memset(&state->V2, 0, sizeof(state->V2));
 }
 
 static inline void sbc_synthesize_four(struct sbc_decoder_state *state,
@@ -612,18 +618,50 @@ static inline void sbc_synthesize_eight(
 				struct sbc_frame *frame, int ch, int blk)
 {
 	int i, j, k, idx;
+	float delta;
+
+	// now compare
+	for(k = 0; k < 160; k++) 
+		if(state->V[ch][k] != state->V2[ch][(k + state->offset)%160]) {
+			printf("v[] mismatch ON RETURN!! v(%2.2f) v2(%2.2f) %d (v2 %d with offset=%d)\n[", state->V[ch][k], state->V2[ch][(k + state->offset)%160], k, (k + state->offset)%160, state->offset);
+			for(i = 0; i < 160; i++) printf("%2.2f%c", state->V[ch][i], i%16==15?'\n':',');
+			printf("]\n[");
+			for(i = 0; i < 160; i++) printf("%2.2f%c", state->V2[ch][(i + state->offset)%160], i%16==15?'\n':',');
+			printf("]\n");
+			exit(0);
+		}
 
 	/* Shifting */
 	for (i = 159; i >= 16; i--) {
 		state->V[ch][i] = state->V[ch][i - 16];
 	}
 
+	/* Shifting (virtual) */
+
+	state->offset = (state->offset + 144) % 160;
+
 	/* Matrixing */
 	for (k = 0; k < 16; k++) {
 		state->V[ch][k] = 0;
+		state->V2[ch][k + state->offset] = 0;
 		for (i = 0; i < 8; i++) {
-			state->V[ch][k] += synmatrix8[k][i] * frame->sb_sample[blk][ch][i];
-		}
+			delta = synmatrix8[k][i] * frame->sb_sample[blk][ch][i];
+			state->V[ch][k] += delta;
+			state->V2[ch][k + state->offset] += delta;
+		}
+		if(k==0) printf("v1[%d] = %2.2f\nv2[%d] = %2.2f\n", k, state->V[ch][k], 
+				k+state->offset, state->V2[ch][k + state->offset]);
+	}
+
+	// now compare
+	for(k = 0; k < 160; k++) 
+		if(state->V[ch][k] != state->V2[ch][(k + state->offset)%160]) {
+			printf("v[] mismatch after matrixing  v(%2.2f) v2(%2.2f) %d (v2 %d with offset=%d)\n[", state->V[ch][k], state->V2[ch][(k + state->offset)%160], k, (k + state->offset)%160, state->offset);
+			for(i = 0; i < 160; i++) printf("%2.2f%c", state->V[ch][i], i%16==15?'\n':',');
+			printf("]\n[");
+			for(i = 0; i < 160; i++) printf("%2.2f%c", state->V2[ch][(i + state->offset)%160], i%16==15?'\n':',');
+			printf("]\n");
+			exit(0);
 	}
 
 	/* Calculate 8 audio samples */
@@ -632,6 +670,10 @@ static inline void sbc_synthesize_eight(
 		state->X[ch][j] = 0;
 	}
 
+	for (j = 0; j < 8; j++) {
+		state->X2[ch][j] = 0;
+	}
+
 	for (i = 0; i <= 4; i++) {
 		idx = i*16;
 		for (j = 0; j < 8; j++, idx++) {
@@ -641,10 +683,30 @@ static inline void sbc_synthesize_eight(
 		}
 	}
 
+	for (i = 0; i <= 4; i++) {
+		idx = i*16;
+		for (j = 0; j < 8; j++, idx++) {
+			state->X2[ch][j] += 
+				state->V2[ch][(i * 32 + j + state->offset)%160] * sbc_proto_8_80m[idx] +
+				state->V2[ch][(i * 32 + j + 24 + state->offset)%160] * sbc_proto_8_80m[idx + 8];
+		}
+	}
+
 	/* Ouput 8 reconstructed Audio Samples */
 	for (i = 0; i < 8; i++) {
 		frame->pcm_sample[ch][blk * 8 + i] = (int16_t)state->X[ch][i];
 	}
+
+	// now compare
+	for(k = 0; k < 160; k++) 
+		if(state->V[ch][k] != state->V2[ch][(k + state->offset)%160]) {
+			printf("v[] mismatch  v(%2.2f) v2(%2.2f) %d (v2 %d with offset=%d)\n[", state->V[ch][k], state->V2[ch][(k + state->offset)%160], k, (k + state->offset)%160, state->offset);
+			for(i = 0; i < 160; i++) printf("%2.2f%c", state->V[ch][i], i%16==15?'\n':',');
+			printf("]\n[");
+			for(i = 0; i < 160; i++) printf("%2.2f%c", state->V2[ch][(i + state->offset)%160], i%16==15?'\n':',');
+			printf("]\n");
+			exit(0);
+		}
 }
 
 static int sbc_synthesize_audio(struct sbc_decoder_state *state, struct sbc_frame *frame)
@@ -665,9 +727,11 @@ static int sbc_synthesize_audio(struct s
 
 	case 8:
 		for (ch = 0; ch < frame->channels; ch++) {
+#if 0
+			// can't we skip this? everything will be reinitialized in decoder
 			memset(frame->pcm_sample[ch], 0,
 				sizeof(frame->pcm_sample[ch]));
-
+#endif
 			for (blk = 0; blk < frame->blocks; blk++)
 				sbc_synthesize_eight(state, frame, ch, blk);
 		}

--------------060302000307000600030608--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
