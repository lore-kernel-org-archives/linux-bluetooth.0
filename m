Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Clemens Vasters <clemensv@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Device discovery/pairing issue w/ BlueZ on Debian
Date: Fri, 13 Sep 2013 08:50:56 +0200
Message-ID: <3855563.UW2fZNan4k@uw000953>
In-Reply-To: <CAJdJm_PpQoQeJ5SGrzD3RuA+7mOg-mAQgzSx5WV29528hU3stA@mail.gmail.com>
References: <CAGMh8s_RNftv8X32ayf4L-ZjBqSGv3HYxPAR28GthVPWUht-xw@mail.gmail.com> <CAJdJm_PpQoQeJ5SGrzD3RuA+7mOg-mAQgzSx5WV29528hU3stA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> On Tue, Sep 10, 2013 at 2:47 PM, Clemens Vasters <clemensv@gmail.com> wrote:
> > I’ve got a cheap Bluetooth car diagnostics dongle (OBD-2, ELM327) that
> > gets discovered by and pairs with Windows 8, Windows Phone 8, OSX
> > Mountain Lion, iOS 6, and Android Jelly Bean.
> >
> > I can’t get it to be either discovered or paired with BlueZ on Debian
> > Wheezy on my Notebook (bare metal, ThinkPad W510) or Raspbian Wheezy
> > on the Raspberry Pi. On the latter I even went so far to pull the
> > source for BlueZ 5.8 and install it from source. No dice.
> 
> Your description of the problem is a little vague. Which tools did you
> use on BlueZ 5.8 to attempt to discover/pair with the device? Which
> errors did you see (if any)?

Wheezy comes with kernel 3.2 so BlueZ 5 is no option there (at least on stock
kernel).

-- 
BR
Szymon Janc


