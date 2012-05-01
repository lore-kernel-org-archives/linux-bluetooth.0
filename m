Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 May 2012 07:37:11 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Weird bluetooth keyboard regression - just me?
Message-ID: <20120501073711.028d31d6@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Life has not been conducive to frivolities like trying new kernels, but I
finally gave 3.4-rc5 a go yesterday.  I'm seeing some decidedly weird
keyboard behavior; it seems surprising that nobody else has complained.

I have a logitech Dinovo Edge bluetooth keyboard that I've used for
years.  With 3.4 kernels, the keyboard generates no input until I've
banged on it for a couple of seconds.  If I continually hit characters,
they make it through; as soon as I stop for even a brief period (even
somebody as verbose as me has to come up for air occasionally), it goes
back to sleep.

It's almost as if some sort of aggressive power management were knocking
things out at every chance.  Wired USB keyboards do not show this
behavior.  Neither does my bluetooth mouse (which is on a different
adapter).

3.3 works, 3.4-rc1 appears not to.  This should be a straightforward
bisection and I'm happy to begin that process, but I thought I'd ask if
anybody had any ideas first...?

Thanks,

jon
