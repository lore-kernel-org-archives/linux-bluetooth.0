Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Subject: Re: SBC big endian issues?
Date: Mon, 19 Jan 2009 13:26:07 +0200
Cc: "ext Marcel Holtmann" <marcel@holtmann.org>,
        "ext Brad Midgley" <bmidgley@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <200901051015.20512.siarhei.siamashka@nokia.com> <2d5a2c100901161402t65173745xd6f83e90a2057ffb@mail.gmail.com> <200901172010.05061.siarhei.siamashka@nokia.com>
In-Reply-To: <200901172010.05061.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PNGdJ/8tL8/P5LE"
Message-Id: <200901191326.07133.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_PNGdJ/8tL8/P5LE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 17 January 2009 20:10:04 ext Siarhei Siamashka wrote:
> On Saturday 17 January 2009 00:02:09 ext Luiz Augusto von Dentz wrote:
> > Hi Siarhei,
> >
> > It seems gstreamer does have G_BYTE_ORDER, so you probably don't need
> > those #ifdef. I also notice some unnecessary white spaces in the of a
> > line.
>
> Hi,
>
> I did not verify that patch thoroughly (I only checked that it compiles)
> and also seems like I somehow forgot to pass it through 'checkpatch.pl'.
> Thanks for a good catch.
>
> Regarding G_BYTE_ORDER, you are probably right.  I'm not very familiar with
> gstreamer yet, so somebody else could probably fix this stuff much faster
> than me.
>
> In any case, it probably makes sense to relay all the endian conversion
> related things to gstreamer and ALSA, and use only native byte order in
> SBC. This will simplify the code a bit and will make optimizing it easier.
>
> I'm quite worried about big endian systems, but I have plans to buy a PS3
> home in about a month timeframe unless something extraordinary happens  :)

OK, here is an updated patch.

Now I also tested GStreamer plugin on qemu mips big endian image. It works
fine with this change. Having native byte order and not strictly little endian
is a good idea because all the other gstreamer elements (vorbisdec,
flacdec, ...) produce output in native byte order. Unless sbcenc uses native
byte order on this big endian system, audioconvert element is needed to be
added to gstreamer pipeline and it most likely introduces some extra overhead.

I did not check ALSA part and probably can't even do this with qemu, but
removing _LE suffix should also do the job there (according to ALSA
documentation).

Also an interesting observation is that gstreamer is very slow. Using
gst-launch to encode audio file to SBC is something like 1.5 times slower
than sbcenc utility when benchmarked on x86 system. I wonder if
something could be done about this.


Best regards,
Siarhei Siamashka

--Boundary-00=_PNGdJ/8tL8/P5LE
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="0001-Use-native-byte-order-for-audio-in-GStreamer-and-ALS.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-Use-native-byte-order-for-audio-in-GStreamer-and-ALS.patch"

>From f9afd1641cb22ed93b9f0d0992e9a78810ff8159 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Date: Mon, 19 Jan 2009 10:26:28 +0200
Subject: [PATCH] Use native byte order for audio in GStreamer and ALSA plugins

This fixes endianness inconsistency between default SBC
configuration and GStreamer/ALSA.
---
 audio/gstsbcdec.c     |    2 +-
 audio/gstsbcenc.c     |    2 +-
 audio/pcm_bluetooth.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/audio/gstsbcdec.c b/audio/gstsbcdec.c
index fedc129..00af4fc 100644
--- a/audio/gstsbcdec.c
+++ b/audio/gstsbcdec.c
@@ -50,7 +50,7 @@ static GstStaticPadTemplate sbc_dec_src_factory =
 		GST_STATIC_CAPS("audio/x-raw-int, "
 				"rate = (int) { 16000, 32000, 44100, 48000 }, "
 				"channels = (int) [ 1, 2 ], "
-				"endianness = (int) LITTLE_ENDIAN, "
+				"endianness = (int) BYTE_ORDER, "
 				"signed = (boolean) true, "
 				"width = (int) 16, "
 				"depth = (int) 16"));
diff --git a/audio/gstsbcenc.c b/audio/gstsbcenc.c
index 3ecaacf..789bf78 100644
--- a/audio/gstsbcenc.c
+++ b/audio/gstsbcenc.c
@@ -147,7 +147,7 @@ static GstStaticPadTemplate sbc_enc_sink_factory =
 		GST_STATIC_CAPS("audio/x-raw-int, "
 				"rate = (int) { 16000, 32000, 44100, 48000 }, "
 				"channels = (int) [ 1, 2 ], "
-				"endianness = (int) LITTLE_ENDIAN, "
+				"endianness = (int) BYTE_ORDER, "
 				"signed = (boolean) true, "
 				"width = (int) 16, "
 				"depth = (int) 16"));
diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index bf24206..5dfd778 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -1182,7 +1182,7 @@ static int bluetooth_hsp_hw_constraint(snd_pcm_ioplug_t *io)
 		SND_PCM_ACCESS_MMAP_INTERLEAVED
 	};
 	unsigned int format_list[] = {
-		SND_PCM_FORMAT_S16_LE
+		SND_PCM_FORMAT_S16
 	};
 	int err;
 
@@ -1237,7 +1237,7 @@ static int bluetooth_a2dp_hw_constraint(snd_pcm_ioplug_t *io)
 		SND_PCM_ACCESS_MMAP_INTERLEAVED
 	};
 	unsigned int format_list[] = {
-		SND_PCM_FORMAT_S16_LE
+		SND_PCM_FORMAT_S16
 	};
 	unsigned int rate_list[4];
 	unsigned int rate_count;
-- 
1.5.6.5


--Boundary-00=_PNGdJ/8tL8/P5LE--
