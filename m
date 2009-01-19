Return-Path: <cyrus@holtmann.org>
Subject: Re: SBC big endian issues?
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: ext Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	ext Brad Midgley <bmidgley@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <200901191326.07133.siarhei.siamashka@nokia.com>
References: <200901051015.20512.siarhei.siamashka@nokia.com>
	 <2d5a2c100901161402t65173745xd6f83e90a2057ffb@mail.gmail.com>
	 <200901172010.05061.siarhei.siamashka@nokia.com>
	 <200901191326.07133.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Mon, 19 Jan 2009 13:05:39 +0100
Message-Id: <1232366739.19390.16.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> > I did not verify that patch thoroughly (I only checked that it compiles)
> > and also seems like I somehow forgot to pass it through 'checkpatch.pl'.
> > Thanks for a good catch.
> >
> > Regarding G_BYTE_ORDER, you are probably right.  I'm not very familiar with
> > gstreamer yet, so somebody else could probably fix this stuff much faster
> > than me.
> >
> > In any case, it probably makes sense to relay all the endian conversion
> > related things to gstreamer and ALSA, and use only native byte order in
> > SBC. This will simplify the code a bit and will make optimizing it easier.
> >
> > I'm quite worried about big endian systems, but I have plans to buy a PS3
> > home in about a month timeframe unless something extraordinary happens  :)
> 
> OK, here is an updated patch.
> 
> Now I also tested GStreamer plugin on qemu mips big endian image. It works
> fine with this change. Having native byte order and not strictly little endian
> is a good idea because all the other gstreamer elements (vorbisdec,
> flacdec, ...) produce output in native byte order. Unless sbcenc uses native
> byte order on this big endian system, audioconvert element is needed to be
> added to gstreamer pipeline and it most likely introduces some extra overhead.
> 
> I did not check ALSA part and probably can't even do this with qemu, but
> removing _LE suffix should also do the job there (according to ALSA
> documentation).

patch has been applied. Thanks.

> Also an interesting observation is that gstreamer is very slow. Using
> gst-launch to encode audio file to SBC is something like 1.5 times slower
> than sbcenc utility when benchmarked on x86 system. I wonder if
> something could be done about this.

I suspected GStreamer to be slower because of its GObject overhead, but
1.5 times is a lot. Not sure if GStreamer or GObject is to blame here.

Regards

Marcel


