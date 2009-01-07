Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Brad Midgley" <bmidgley@gmail.com>
Subject: Re: SBC big endian issues?
Date: Wed, 7 Jan 2009 14:40:01 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200901051015.20512.siarhei.siamashka@nokia.com> <200901052019.15656.siarhei.siamashka@nokia.com> <d89ddf300901051126g3f8c8dadq8effa23e0a7bf73f@mail.gmail.com>
In-Reply-To: <d89ddf300901051126g3f8c8dadq8effa23e0a7bf73f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hKKZJez5KaE7lsS"
Message-Id: <200901071440.01872.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_hKKZJez5KaE7lsS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 05 January 2009 21:26:17 ext Brad Midgley wrote:
> Siarhei
>
> The copy is inefficient but it would be even better if we didn't have
> to do it at all. I was investigating zero copy here and came up with a
> patch but it was too complicated to be accepted.

Yes, it is possible to reduce the number of data copies. Having
both 'sbc_encoder_state->X' and 'sbc_frame->pcm_sample' arrays
is obviously redundant and only one of them should remain.

But eliminating any kind of data copies completely is hardly possible. The
encoder needs to always have data for the 72 or 36 previous samples, so
they need to be stored somewhere between the calls to frame encode
function. And frame encode function will probably get data in small chunks
if having low latency is desired. So at least this part of data will need to
be moved around. Additionally, SIMD optimizations require input data
permutation, so they can't work directly with the input buffer.

Preserving the input samples 'history' is currently achieved by having 
'sbc_encoder_state->X' array which works as some kind of ring buffer.
If this buffer had infinite size, we would not have to duplicate information
in the lower and higher halves of this buffer. But this is of course not
possible due to the need to keep memory use reasonable and also in order to
efficiently use data cache. Anyway, increasing 'sbc_encoder_state->X' size
to some reasonable value may help to reduce extra overhead. One of the
variants is to have space in X buffer for all the input data of a frame plus
these 72/36 samples from the previous frame, copy the previous 72/36 samples
to it, and then perform "endian conversion + channels deinterleaving + do SIMD
permutation" in one pass directly into the X buffer from the buffer provided
by the user at the entry of the frame packing function. Increasing X buffer
more may allow to copy the previous 72/36 samples only once per 2 frames, once
per 3 frames or whatever.

This is not complicated at all, but is indeed a bit intrusive in the sense
that it will touch quite a large part of code. But we are ready to do it now,
am I right?

> The messy part here is we let the caller specify the byte order of the
> array. It would simplify a lot to standardize on host endian. I don't
> remember what the reasoning was against this.
>
> > Let's suppose that we have the following two bytes in memory:
> >
> > 0x12 0x34
> >
> > This equals to 0x1234 for big endian systems or 0x3412 for little endian
> > systems if you read data via int16_t * pointer.
>
> if sbc->endian is set to the same as the host endian, then this could
> be done with a memcopy or skipped (zero copy).
>
> I believe sbc->endian is always set to little endian the way it works
> now, meaning the array is storing data little endian regardless of the
> architecture. The patch I wrote made a copy of the memory, swapping
> bytes, if sbc->endian didn't match host endian. The way we use the
> code, this swapping only happens on big endian machines.

Well, having no other option to verify this big endian bug, I used this MIPS
big endian QEMU image for testing: 
http://people.debian.org/~aurel32/qemu/mips/

The current code is indeed broken on big endian systems. The attached
patch makes it work correct. Of course this part needs heavy performance
optimizations (as discussed above), but even just fixing it may be a good
idea at the moment.

There is one more suspicious part of code which may cause problems:
> 	unsigned char input[2048], output[2048];
> ...
> 	au_hdr = (struct au_header *) input;
> 	if (au_hdr->magic != AU_MAGIC ||
> 			BE_INT(au_hdr->hdr_size) > 128 ||
> 			BE_INT(au_hdr->hdr_size) < 24 ||
> 			BE_INT(au_hdr->encoding) != AU_FMT_LIN16) {
> 		fprintf(stderr, "Not in Sun/NeXT audio S16_BE format\n");
> 		goto done;
> 	}

As 'input' array is only guaranteed to have byte alignment and the code later
accesses 32-bit au_hdr data, it may cause problems and the compiler
rightfully issues a warning about it.


Best regards,
Siarhei Siamashka

--Boundary-00=_hKKZJez5KaE7lsS
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="0001-Fix-for-big-endian-problems-in-SBC-codec.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-Fix-for-big-endian-problems-in-SBC-codec.patch"

>From 0ee38e8976bd728e16fa4523f53d7b8400754294 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Wed, 7 Jan 2009 14:28:48 +0200
Subject: [PATCH] Fix for big endian problems in SBC codec

---
 sbc/sbc.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 8fff277..651981f 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1157,13 +1157,7 @@ int sbc_decode(sbc_t *sbc, void *input, int input_len, void *output,
 			int16_t s;
 			s = priv->frame.pcm_sample[ch][i];
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
 			if (sbc->endian == SBC_BE) {
-#elif __BYTE_ORDER == __BIG_ENDIAN
-			if (sbc->endian == SBC_LE) {
-#else
-#error "Unknown byte order"
-#endif
 				*ptr++ = (s & 0xff00) >> 8;
 				*ptr++ = (s & 0x00ff);
 			} else {
@@ -1224,13 +1218,7 @@ int sbc_encode(sbc_t *sbc, void *input, int input_len, void *output,
 	for (i = 0; i < priv->frame.subbands * priv->frame.blocks; i++) {
 		for (ch = 0; ch < priv->frame.channels; ch++) {
 			int16_t s;
-#if __BYTE_ORDER == __LITTLE_ENDIAN
 			if (sbc->endian == SBC_BE)
-#elif __BYTE_ORDER == __BIG_ENDIAN
-			if (sbc->endian == SBC_LE)
-#else
-#error "Unknown byte order"
-#endif
 				s = (ptr[0] & 0xff) << 8 | (ptr[1] & 0xff);
 			else
 				s = (ptr[0] & 0xff) | (ptr[1] & 0xff) << 8;
-- 
1.5.6.5


--Boundary-00=_hKKZJez5KaE7lsS--
