Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABax29WFvAXH9g8CnOtEDAqfmKmURnt4eYY58fi+P9zBa5Ji1A@mail.gmail.com>
References: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
	<CACY+gR3t4RXuhUEi9486qsP+p0GCYArHW+PO5QfBfEUfnd=xEg@mail.gmail.com>
	<CABax29X1tFt8Am_i7y5nZsjs_D2QY9pbv19316Wn6RVq7ksEDA@mail.gmail.com>
	<CACY+gR2DeQE2UaYwD8AQonNxtZ+=uZm7qY+BaqgjBQKoZSZHYA@mail.gmail.com>
	<CABax29U8N2nOge34tr=G2f-fZvowCHPf3V=N2an-vC+x=UBdiQ@mail.gmail.com>
	<CACY+gR2PkP76J2Dw9xobpeGsU2HKhsOYvU6Wcx8WCcq1opihiA@mail.gmail.com>
	<CABax29VadeA+6WZWRDiZZUhpRqk2Nk35__b0Cjfz8HO12Tq4vQ@mail.gmail.com>
	<CACY+gR0DJfbOgfSGHrsAj5vk00v4-_+KYwR+SF+0BRRs2oYBkw@mail.gmail.com>
	<CABax29X+ke_PO9obAxbEJjdx68g8JW4ZZn7vS7mYpE7+00iYng@mail.gmail.com>
	<CABax29WFvAXH9g8CnOtEDAqfmKmURnt4eYY58fi+P9zBa5Ji1A@mail.gmail.com>
Date: Mon, 26 Mar 2012 12:44:17 +0300
Message-ID: <CACY+gR3pqj6xoJ-G-pt5QTY6BjuyUNXTZRzsQmmutcSNBzY3qQ@mail.gmail.com>
Subject: Re: [PATCH] Re: A2DP quality (bluetooth-alsa)
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: qduaty <qduaty@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Mar 25, 2012 at 5:51 AM, qduaty <qduaty@gmail.com> wrote:
> Hello,
>
> I found that floating point processing eliminates all the quality
> issues that were mentioned here. So I added a floating point mode to
> SBC, which can be enabled with an #ifdef in sbc_tables.h, along with a
> code for minimizing quantization errors. It reduces noise by several
> dB and greatly improves the reproduction of higher bands.

Out of curiosity, how do you measure noise reduction?

Regarding your changes:

! #ifdef SBC_FLOAT
! #define SBC_PROTO_SCALE_FIXED4(x) x;
! 	/* rounding coefficient */
! 	t1[0] = t1[1] = t1[2] = t1[3] = 1;

This does not look right. For the fixed point code, rounding
coefficient is needed because we are shifting results after the first
multiplication pass. Simply right shifting the data would discard the
lowest bits, effectively doing rounding down. Introducing rounding
coefficient allows rounding to nearest: "(x + (1 <<
(SBC_PROTO_FIXED4_SCALE - 1))) >> SBC_PROTO_FIXED4_SCALE"
Floating point code does not need any rounding coefficient.

! #ifdef SBC_FLOAT
! 	/* Tries to redistribute quantization errors so that exactly half of them
! 	 * is positive. This reduces overall distortion, especially in high bands
! 	 * and increases chances for clipping, hence the ANTICLIP coefficient. */
! 	double accumError = 0;
! 	for (i = 0; i < 4; i++){
! 		t1[i] *= (1 << SCALE_OUT_BITS) * ANTICLIP;
! 		accumError += t1[i] - (int32_t)t1[i];
! 	}
! 	for (i = 0; i < 4; i++)
! 		out[i] = t1[i] + accumError / 4;

I find it hard to believe that this accumError would make any
noticeable difference on the output (neither good nor bad).

The analysis filter produces fixed point values with SCALE_OUT_BITS
fractional bits (selected to be 15 currently). So the output is in
17.15 fixed point format. 15 extra bits have been selected just
because we can, and this allows to use full range of 32-bit variables.
If we further divide it by 2 as needed on quantization step later,
then we actually have 16.16 format. These extra bits are needed to
avoid precision loss on normalization. If quantized value is for
example in [-127, 127] range, then it needs to be stored as 8 bits or
[0, 255] range in the bitstream, which gives a rather nasty 255/256
scale ratio and this is a potential source of rounding errors unless
we preserve as many bits as possible. From A2DP spec:
    "levels[ch][sb] = pow(2.0, bits[ch][sb]) - 1"
    "scalefactor[ch][ sb] = pow(2.0, (scale_factor[ch][sb] + 1))"
    "quantized_sb_sample[blk][ch][sb] = ((sb_sample[blk][ch][sb] /
scalefactor[ch][sb] + 1.0) * levels[ch][sb]) / 2.0"
"quantized_sb_sample" is rounded towards minus infinity, "levels" are
powers of two minus one and scalefactor is a power of two.

But even less than 15 extra bits for SCALE_OUT_BITS seems to be also
fine in practice (you can do some experiments with reducing it),
assuming that the values are quantized even a little bit. With your
change, you are only messing around the lowest bit in the extra
fractional part.

Scaling down the input with ANTICLIP should get rid of clipping (on
the decoder side) with heavily compressed audio sources as expected,
but this is not anything new.

> There is room for further improvements, such as adaptive clipping
> prevention and high resolution input format, but with current code
> base, they are somewhat hard to implement.

If you have any questions about the current code, just ask.

> The attached patch may cause some trouble because of one part being
> rejected. I hope this will not prevent those who are interested, from
> applying it and testing.

Could you please at least use unified diff (-u option)? And the best
would be to use "git commit" and then "git format-patch".

In any case, the ability to reduce the audio volume as part of SBC
encoding process looks like a useful improvement to me (and maybe it's
a good idea to even have it used by default). This should help to
workaround the audio quality problems with some A2DP headsets.

-- 
Best regards,
Siarhei Siamashka
