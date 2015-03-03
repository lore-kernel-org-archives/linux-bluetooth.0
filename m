Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <EC9E947B-7BEA-47D9-B546-F18208D4AE97@holtmann.org>
References: <CAGxYWpZ8cfgtdO8ZX39cPBOs4OZ=PaO5pOHotjBt0u7HsnVXFA@mail.gmail.com>
	<6EDCDCB4-6F4D-4DE6-88DB-88D333FC2CCC@holtmann.org>
	<CAGxYWpY0afTXOW1=jS1dmY7XBg3nR8a8itXiiiXdofKkhkyjKg@mail.gmail.com>
	<EC9E947B-7BEA-47D9-B546-F18208D4AE97@holtmann.org>
Date: Tue, 3 Mar 2015 11:41:31 -0500
Message-ID: <CAGxYWpaaj=_J801VUe1WphQtdEr-MOMzZ10-w_iFWUdjBPkL5Q@mail.gmail.com>
Subject: Re: bt dongle goes awry after too many connections
From: Tim Tisdall <tisdall@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 3, 2015 at 11:19 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> it is only btusb talking to the hardware. In the end it is just a transpo=
rt layer. The real work happens in the Bluetooth core. However that said, w=
e never had a limit on number of LE connections. Nothing there was ever enf=
orced.

I was afraid of that...  I guess that means that there must be
different versions of the dongle.  We're working with many devices and
ordered many dongles over the last 2 years.  It's possible the
manufacturer slipped in some changes over that time.  I'll see if I
can confirm that.

> If you do not need BR/EDR, you can switch that off and it might free the =
radio resources you need for the many LE connections. However a 3.13 is not=
 really getting you there. It might actually work there, but I would only t=
rust a 3.18 or 3.19 kernel here.

Yeah, it's be nice if everyone was on mainline, but unfortunately I'm
stuck using 3.4 for the embedded device I'm using.  How do I shut off
the BR/EDR aspects of the dongle?  I'm not sure if it'd help, but it's
worth trying.
