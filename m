Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Nov 2009 23:57:39 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: bluetooth cf slow (10KB/sec), lots of dmesg spam
Message-ID: <20091130235739.6dfa3d66@lxorguk.ukuu.org.uk>
In-Reply-To: <20091129164450.GA1438@ucw.cz>
References: <20091129155801.GA1634@ucw.cz>
	<20091130153915.0a6910e3@lxorguk.ukuu.org.uk>
	<20091129164450.GA1438@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

> ioctl(3, SNDCTL_TMR_START or TCSETS, {B921600 -opost -isig -icanon -echo ...}) = 0

It's certainly trying
> 
> ...set 921K using TCSETS/B921600... and kernel says ok, but ...

Careful: termios is one of those "gotcha" ioctls. It returns 0 to say
"stuff happened" and returns a termios struct which contains the results
- which may not be what you requested.

So a set to an unsupported rate (too high for the chip clock) will
produce a response of 0 and return the baud rate you actually got given.

> ...we are still at 115200... I wonder if 921600 is the right speed to
> use after all? Any other speeds I should try? (and can 400MHz arm
> handle 921K on serial line?)

It's pushing it on an x86 with a 16550A. You've got about 14 character
times of worst case latency permitted and 14 x 10 bits isn't a lot at
that rate. Some of the clones have much bigger FIFOs so it may depend
what you actually have.

Alan
