Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
Date: Fri, 2 Jan 2009 18:33:13 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812311803.45279.siarhei.siamashka@nokia.com> <2d5a2c100812311255p2d10b74crc31ff3211ca1939d@mail.gmail.com>
In-Reply-To: <2d5a2c100812311255p2d10b74crc31ff3211ca1939d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901021833.13342.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 31 December 2008 22:55:24 ext Luiz Augusto von Dentz wrote:
> I wonder why don't we use liboil
> (http://liboil.freedesktop.org/wiki/).

Can you clarify your proposal a bit? Which functions/implementations from
liboil do you suggest for use in bluez sbc?

> Since we can't keep implementing, or don't want to, optimization code for
> each instruction extension around.

Or do you suggest to submit the sbc analysis filter function to liboil, add it
as sbc dependency and hope that somebody would translate the code to the
instruction sets of other architectures? Will it turn out to be beneficial?
IMHO It may easily become just an unnecessary burden and wasted effort too.

> Liboil detects which implementation is 
> faster at runtime and there are many other codec implementations that depend
> on it, it actually makes a lot of sense to gstream and PulseAudio which
> already uses liboil. I know that means adding another dependency to
> BlueZ, or perhaps it is time to make libsbc a real library?

I had a quick look at liboil and it did not impress me that much yet.


Best regards,
Siarhei Siamashka
