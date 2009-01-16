Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: SBC big endian issues?
Date: Fri, 16 Jan 2009 19:23:04 +0200
Cc: ext Brad Midgley <bmidgley@gmail.com>, linux-bluetooth@vger.kernel.org
References: <200901051015.20512.siarhei.siamashka@nokia.com> <200901071440.01872.siarhei.siamashka@nokia.com> <1231335837.5298.0.camel@californication>
In-Reply-To: <1231335837.5298.0.camel@californication>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4JMcJPyvsUDmMbG"
Message-Id: <200901161923.04676.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_4JMcJPyvsUDmMbG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 07 January 2009 15:43:57 ext Marcel Holtmann wrote:
> Hi Siarhei,
>
> > > The messy part here is we let the caller specify the byte order of the
> > > array. It would simplify a lot to standardize on host endian. I don't
> > > remember what the reasoning was against this.
> > >
> > > > Let's suppose that we have the following two bytes in memory:
> > > >
> > > > 0x12 0x34
> > > >
> > > > This equals to 0x1234 for big endian systems or 0x3412 for little
> > > > endian systems if you read data via int16_t * pointer.
> > >
> > > if sbc->endian is set to the same as the host endian, then this could
> > > be done with a memcopy or skipped (zero copy).
> > >
> > > I believe sbc->endian is always set to little endian the way it works
> > > now, meaning the array is storing data little endian regardless of the
> > > architecture. The patch I wrote made a copy of the memory, swapping
> > > bytes, if sbc->endian didn't match host endian. The way we use the
> > > code, this swapping only happens on big endian machines.
> >
> > Well, having no other option to verify this big endian bug, I used this
> > MIPS big endian QEMU image for testing:
> > http://people.debian.org/~aurel32/qemu/mips/
> >
> > The current code is indeed broken on big endian systems. The attached
> > patch makes it work correct. Of course this part needs heavy performance
> > optimizations (as discussed above), but even just fixing it may be a good
> > idea at the moment.
>
> patch has been applied. Thanks.

Thanks, though seems like there are some problems.

By default, SBC codec uses native byte order now (configured
by 'sbc_set_defaults' function, which is called from 'sbc_init').

But SBC gstreamer elements ('gstsbcdec.c', 'gstsbcenc.c') specify
endianness as little endian: "endianness = (int) LITTLE_ENDIAN, ".
So now after the patch got applied, "sbcenc/sbcdec" utilites got fixed,
but gstreamer elements may have problems on big endian systems
instead. Another concern is about 'pcm_bluetooth.c'. It does not specifically
configure endianness in any way, so SBC codec is used with the native byte
order as well. And there the supported format is also specified as
SND_PCM_FORMAT_S16_LE.

Looks like this was the case of double errors which were cancelling each other
or misleading constant names. In any case, SBC has been always treating data
by default as little endian before regardless of the host native byte order.

So in order to get gstreamer and pcm_bluetooth working right again, the
default configuration of SBC codec can be changed to SBC_LE (this way all the
old clients which did not change the default configuration will continue to
work just like before). A variant of patch with this kind of solution is
attached.

Alternatively, gstreamer elements and ALSA plugin could try to use native byte
order (and this can be probably good for the performance as with the strictly
little endian support for the data, big endian systems may actually have to do
the conversion twice - first in the gstreamer in order to provide the data to
the element in little endian format, and then in SBC codec itself to convert
it back to native format to use it in number crunching). This variant of patch
is also attached (but untested because I don't have a big endian system).


Some kind of fix needs to be used (and the attached patches are mutually
exclusive), as apparently 4.26 release does not work right on big endian
systems :(


Best regards,
Siarhei Siamashka

--Boundary-00=_4JMcJPyvsUDmMbG
Content-Type: text/x-diff;
  charset="utf-8";
  name="0001-Change-of-SBC-default-configutation-to-little-endian.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-Change-of-SBC-default-configutation-to-little-endian.patch"

>From 4a4669b0e6cf75e4c36802b8e90b3c369804aaf0 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Fri, 16 Jan 2009 18:54:31 +0200
Subject: [PATCH] Change of SBC default configutation to little endian

ALSA plugin and gstreamer elements assume little endian byte order
for the audio data. The problem is that they also rely on the
default SBC configuration to be "right", which is not what they
expect after commit 8bbfdf782dd1633a1f78a26584ff81b858df4a61
---
 sbc/sbc.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 0699ae0..4da130a 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -927,13 +927,7 @@ static void sbc_set_defaults(sbc_t *sbc, unsigned long flags)
 	sbc->subbands = SBC_SB_8;
 	sbc->blocks = SBC_BLK_16;
 	sbc->bitpool = 32;
-#if __BYTE_ORDER == __LITTLE_ENDIAN
 	sbc->endian = SBC_LE;
-#elif __BYTE_ORDER == __BIG_ENDIAN
-	sbc->endian = SBC_BE;
-#else
-#error "Unknown byte order"
-#endif
 }
 
 int sbc_init(sbc_t *sbc, unsigned long flags)
-- 
1.5.6.5


--Boundary-00=_4JMcJPyvsUDmMbG
Content-Type: text/x-diff;
  charset="utf-8";
  name="0001-Use-advertise-native-byte-order-for-audio-in-gstream.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-Use-advertise-native-byte-order-for-audio-in-gstream.patch"

>From 1132592f98a919f22534657fef63a06880472293 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Fri, 16 Jan 2009 19:15:34 +0200
Subject: [PATCH] Use/advertise native byte order for audio in gstreamer and ALSA plugins

---
 audio/gstsbcdec.c     |    6 ++++++
 audio/gstsbcenc.c     |    6 ++++++
 audio/pcm_bluetooth.c |   12 ++++++++++++
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/audio/gstsbcdec.c b/audio/gstsbcdec.c
index fedc129..35a3297 100644
--- a/audio/gstsbcdec.c
+++ b/audio/gstsbcdec.c
@@ -50,7 +50,13 @@ static GstStaticPadTemplate sbc_dec_src_factory =
 		GST_STATIC_CAPS("audio/x-raw-int, "
 				"rate = (int) { 16000, 32000, 44100, 48000 }, "
 				"channels = (int) [ 1, 2 ], "
+#if __BYTE_ORDER == __LITTLE_ENDIAN
 				"endianness = (int) LITTLE_ENDIAN, "
+#elif __BYTE_ORDER == __BIG_ENDIAN
+				"endianness = (int) BIG_ENDIAN, "
+#else
+#error "Unknown byte order"
+#endif				
 				"signed = (boolean) true, "
 				"width = (int) 16, "
 				"depth = (int) 16"));
diff --git a/audio/gstsbcenc.c b/audio/gstsbcenc.c
index 3ecaacf..f083a9b 100644
--- a/audio/gstsbcenc.c
+++ b/audio/gstsbcenc.c
@@ -147,7 +147,13 @@ static GstStaticPadTemplate sbc_enc_sink_factory =
 		GST_STATIC_CAPS("audio/x-raw-int, "
 				"rate = (int) { 16000, 32000, 44100, 48000 }, "
 				"channels = (int) [ 1, 2 ], "
+#if __BYTE_ORDER == __LITTLE_ENDIAN
 				"endianness = (int) LITTLE_ENDIAN, "
+#elif __BYTE_ORDER == __BIG_ENDIAN
+				"endianness = (int) BIG_ENDIAN, "
+#else
+#error "Unknown byte order"
+#endif
 				"signed = (boolean) true, "
 				"width = (int) 16, "
 				"depth = (int) 16"));
diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index bf24206..43b648e 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -1182,7 +1182,13 @@ static int bluetooth_hsp_hw_constraint(snd_pcm_ioplug_t *io)
 		SND_PCM_ACCESS_MMAP_INTERLEAVED
 	};
 	unsigned int format_list[] = {
+#if __BYTE_ORDER == __LITTLE_ENDIAN
 		SND_PCM_FORMAT_S16_LE
+#elif __BYTE_ORDER == __BIG_ENDIAN
+		SND_PCM_FORMAT_S16_BE
+#else
+#error "Unknown byte order"
+#endif
 	};
 	int err;
 
@@ -1237,7 +1243,13 @@ static int bluetooth_a2dp_hw_constraint(snd_pcm_ioplug_t *io)
 		SND_PCM_ACCESS_MMAP_INTERLEAVED
 	};
 	unsigned int format_list[] = {
+#if __BYTE_ORDER == __LITTLE_ENDIAN
 		SND_PCM_FORMAT_S16_LE
+#elif __BYTE_ORDER == __BIG_ENDIAN
+		SND_PCM_FORMAT_S16_BE
+#else
+#error "Unknown byte order"
+#endif
 	};
 	unsigned int rate_list[4];
 	unsigned int rate_count;
-- 
1.5.6.5


--Boundary-00=_4JMcJPyvsUDmMbG--
