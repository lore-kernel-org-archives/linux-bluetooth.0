Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <431AAF30.304@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] unrolling sbc decoder
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
Date: Sun, 04 Sep 2005 02:24:16 -0600

Hey

I thought I had this nailed after some careful unrolling/simplifying 
work but there may still be something I missed. I'm finding I get choppy 
audio, but then I reverted and it was still choppy... can someone try 
this in sbc.c with a2recv by transmit 8-subband audio to it from some 
other device?

Brad

static inline void sbc_synthesize_eight(struct sbc_decoder_state *state,
				struct sbc_frame *frame, int ch, int blk)
{
	int i, j, k, idx, offset;
	static int off1[] = {0, 16, 32, 48, 64, 80, 96, 112, 0, 16, 32, 48, 64, 
80, 96};
	static int off2[] = {24, 40, 56, 72, 88, 104, 120, 8, 24, 40, 56, 72, 
88, 104, 120};
	static int pass = 0;
	int window = pass*16;

	/* Matrixing */
	for (k = 0; k < 16; k++) {
		state->V[ch][window+k] = 0;
		for (i = 0; i < 8; i++) {
			state->V[ch][window+k] += synmatrix8[k][i] * 
frame->sb_sample[blk][ch][i];
		}
	}

	for (j = 0; j < 8; j++) {
		state->X[ch][j] = 0;
	}

	/* Calculate 8 audio samples */
	for (i = 0; i <= 4; i++) {
		offset = (i*2) + pass;
		idx = i*16;
		for (j = 0; j < 8; j++, idx++) {
			state->X[ch][j] +=
				state->V[ch][off1[offset] + j] * sbc_proto_8_80[idx] +
				state->V[ch][off2[offset] + j] * sbc_proto_8_80[idx+8];
		}
	}

	/* Ouput 8 reconstructed Audio Samples */
	for (i = 0; i < 8; i++) {
		frame->pcm_sample[ch][blk * 8 + i] = (int16_t)(-8.0 * state->X[ch][i]);
	}

	pass = (pass+1) & 0x7;
}


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
