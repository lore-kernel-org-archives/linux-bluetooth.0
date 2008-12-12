Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH] sbc: bitstream packing optimization for encoder.
Date: Fri, 12 Dec 2008 11:37:17 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812112227.07170.siarhei.siamashka@nokia.com> <1229045974.22285.18.camel@violet.holtmann.net>
In-Reply-To: <1229045974.22285.18.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200812121137.18041.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 12 December 2008 03:39:34 ext Marcel Holtmann wrote:
> Hi Siarhei,
>
> > Appears that bitstream packing is also one of the most CPU hungry
> > operations in SBC encoder, which did not get proper attention yet.
> > Could somebody review this patch and provide feedback/comments?
>
> again thanks for working on this. I am actually willing to include your
> patches quickly in one of the next releases to get more wider testing
> audience.

Thanks. Are the contributors of the last SBC-related modifications reachable
nowadays? They could probably help with the review of our patches.

SBC code still can be improved in many ways from the performance point of
view. The current implementation follows SBC specification pretty much
literally. But rearranging the code a bit and getting rid of multidimentional
arrays can provide identical output, but work noticeably faster. Also SBC
can benefit from ARM assembly optimizations (for ARM11 and Cortex-A8),
so these could be applied a bit later once all the high level stuff is in
place.

Current implementation only needs to be checked to ensure that it is correct
and fully adheres to the specification before applying large scale
optimizations.

> One comment from my side is that this should work with little-endian and
> big-endian as input streams. Please keep that in mind.

Yes, it should work fine on both big and little endian systems, though I did
not test it on big-endian hardware myself. Actually SBC bitstream packer
favors big-endian systems, because the following part...

+               if (bits_count >= 16) {\
+                       bits_count -= 8;\
+                       *data_ptr++ = (uint8_t)(bits_cache >> bits_count);\
+                       bits_count -= 8;\
+                       *data_ptr++ = (uint8_t)(bits_cache >> bits_count);\
+               }\

...could be implemented as something like this for big-endian systems
(provided that we additionally take care of alignment and convert 'data_ptr'
into a pointer to uint16_t):

+               if (bits_count >= 16) {\
+                       bits_count -= 16;\
+                       *data_ptr++ = (uint16_t)(bits_cache >> bits_count);\
+               }\

But for little endian-systems and also to ensure endian neutrality, data
writes are done one byte at a time.


And Just an additional comment about portability, there are also systems where
uint8_t data type is not supported (and CHAR_BIT is different from 8). For
example, there is a port SBC encoder from bluez to C55x DSP [1].  I'm in no
way involved in this project, but they could probably want to submit some
changes to mainline SBC code to make it usable on such systems with a bit
less tweaks.

1. https://garage.maemo.org/projects/dsp-sbc


Best regards,
Siarhei Siamashka
