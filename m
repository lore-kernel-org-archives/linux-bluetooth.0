Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Brad Midgley" <bmidgley@gmail.com>
Subject: Re: SBC big endian issues?
Date: Tue, 20 Jan 2009 12:20:06 +0200
Cc: ext Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        ext Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <200901051015.20512.siarhei.siamashka@nokia.com> <200901191326.07133.siarhei.siamashka@nokia.com> <d89ddf300901190702u1c9864acwa69748ed7ca5326c@mail.gmail.com>
In-Reply-To: <d89ddf300901190702u1c9864acwa69748ed7ca5326c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901201220.06623.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 19 January 2009 17:02:03 ext Brad Midgley wrote:
> > Also an interesting observation is that gstreamer is very slow. Using
> > gst-launch to encode audio file to SBC is something like 1.5 times slower
> > than sbcenc utility when benchmarked on x86 system. I wonder if
> > something could be done about this.
>
> I noticed something similar back in 3.x. On an xscale, it went from
> about 15% cpu usage under libalsa to 50% using gst-launch.

By the way, if that XScale chip is IWMMXT capable, it can benefit from SIMD
optimizations too. This should probably reduce CPU usage way below 15%.

Moreover, IWMMXT is essentially an MMX clone for ARM, so x86 MMX code can
be directly converted to it.

> Is there a best practices for gstreamer that the plugin is not following?

I'm not quite familiar with gstreamer yet, but these performance issues might
be really worth investigating...


Best regards,
Siarhei Siamashka
