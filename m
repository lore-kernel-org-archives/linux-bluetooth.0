Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Oct 2011 11:23:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: Re: [PATCH] sbc: overflow bugfix and audio decoding quality
 improvement
Message-ID: <20111019082301.GA4297@fusion.localdomain>
References: <1318814678-25640-1-git-send-email-siarhei.siamashka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318814678-25640-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

On Mon, Oct 17, 2011, Siarhei Siamashka wrote:
> The "(((audio_sample << 1) | 1) << frame->scale_factor[ch][sb])"
> part of expression
>     "frame->sb_sample[blk][ch][sb] =
>         (((audio_sample << 1) | 1) << frame->scale_factor[ch][sb]) /
>         levels[ch][sb] - (1 << frame->scale_factor[ch][sb])"
> in "sbc_unpack_frame" function can sometimes overflow 32-bit signed int.
> This problem can be reproduced by first using bitpool 128 and encoding
> some random noise data, and then feeding it to sbc decoder. The obvious
> thing to do would be to change "audio_sample" variable type to uint32_t.
> 
> However the problem is a little bit more complicated. According
> to the section "12.6.2 Scale Factors" of A2DP spec:
>     scalefactor[ch][sb] = pow(2.0, (scale_factor[ch][sb] + 1))
> 
> And according to "12.6.4 Reconstruction of the Subband Samples":
>     sb_sample[blk][ch][sb] = scalefactor[ch][sb] *
>         ((audio_sample[blk][ch][sb]*2.0+1.0) / levels[ch][sb]-1.0);
> 
> Hence the current code for calculating "sb_sample[blk][ch][sb]" is
> not quite correct, because it loses one least significant bit of
> sample data and passes twice smaller sample values to the synthesis
> filter (the filter also deviates from the spec to compensate this).
> This all has quite a noticeable impact on audio quality. Moreover,
> it makes sense to keep a few extra bits of precision here in order
> to minimize rounding errors. So the proposed patch introduces a new
> SBCDEC_FIXED_EXTRA_BITS constant and uses uint64_t data type
> for intermediate calculations in order to safeguard against
> overflows. This patch intentionally addresses only the quality
> issue, but performance can be also improved later (like replacing
> division with multiplication by reciprocal).
> 
> Test for the difference of sbc encoding/decoding roundtrip vs.
> the original audio file for joint stereo, bitpool 128, 8 subbands
> and http://media.xiph.org/sintel/sintel-master-st.flac sample
> demonstrates some quality improvement:
> 
> === before ===
>     --- comparing original / sbc_encoder.exe + sbcdec ---
>     stddev:    4.64 PSNR: 82.97 bytes:170495708/170496000
> === after ===
>     --- comparing original / sbc_encoder.exe + sbcdec ---
>     stddev:    1.95 PSNR: 90.50 bytes:170495708/170496000
> ---
>  sbc/sbc.c        |   11 +++++++----
>  sbc/sbc_tables.h |    6 ++++--
>  2 files changed, 11 insertions(+), 6 deletions(-)

Applied. Thanks!

Additionally I pushed another patch to try to reduce the massive
indentation in the nested for-loops. In general whenever you've got the
following kind of pattern in a loop:

	if (some condition) {
		lots
		of
		stuff
		...
	} else
		just_a_single_statement;

You can avoid indentation for the larger branch by changing this to:

	if (inverted condition) {
		just_a_single_statement;
		continue;
	}

	lots
	of
	stuff
	...

And if you just have a long if-branch without an else part at all it
becomes even simpler:

	if (inverted condition)
		continue;

	<what used to be within a long if-branch>

Johan
