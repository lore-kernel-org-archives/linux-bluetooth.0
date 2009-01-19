Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <200901191326.07133.siarhei.siamashka@nokia.com>
References: <200901051015.20512.siarhei.siamashka@nokia.com>
	 <2d5a2c100901161402t65173745xd6f83e90a2057ffb@mail.gmail.com>
	 <200901172010.05061.siarhei.siamashka@nokia.com>
	 <200901191326.07133.siarhei.siamashka@nokia.com>
Date: Mon, 19 Jan 2009 08:02:03 -0700
Message-ID: <d89ddf300901190702u1c9864acwa69748ed7ca5326c@mail.gmail.com>
Subject: Re: SBC big endian issues?
From: Brad Midgley <bmidgley@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: ext Luiz Augusto von Dentz <luiz.dentz@gmail.com>, ext Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Siarhei

> Also an interesting observation is that gstreamer is very slow. Using
> gst-launch to encode audio file to SBC is something like 1.5 times slower
> than sbcenc utility when benchmarked on x86 system. I wonder if
> something could be done about this.

I noticed something similar back in 3.x. On an xscale, it went from
about 15% cpu usage under libalsa to 50% using gst-launch.

Is there a best practices for gstreamer that the plugin is not following?

-- 
Brad Midgley
