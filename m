Return-Path: <charles@bueche.ch>
Subject: Re: [Bluez-devel] The future of Bluetooth HID
From: Charles Bueche <charles@bueche.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1070482368.24159.110.camel@pegasus>
References: <1070482368.24159.110.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1070526591.8282.9.camel@bluez.bueche.ch>
Mime-Version: 1.0
Date: Thu, 04 Dec 2003 09:29:51 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel and bluetooth users,

after being only a few days into Bluetooth, I'm very happy with Marcel's
work and the high quality of this list. I have now my Logitech MX900
almost working.

I will therefore donate 20¤ or 20$ to Marcel for helping buying the
missing hardware he needs to complete his implementation. If some among
you do the same effort, Marcel will be able to purchase the hardware
needed. Please participate !

Marcel, please let us say how you want the money delivered (which
currency, wheter paypal is OK, or note in an envelope, etc).

Thanks a lot for your work,
Charles

On Wed, 2003-12-03 at 21:12, Marcel Holtmann wrote:
> Hi Folks,
> 
> I spent the last few days in hacking on the Bluetooth HID implementation
> and my current results make me very happy. The current bthid code that
> can be found in the utils2 CVS repository depends on my modifications to
> the HID parser from the USB subsystem, but this code never got more than
> a quick and dirty hack. My conclusion was that it will be a full time
> job to rewrite the current USB HID code. And after Marcelo said that he
> is not going to accept new patches or drivers after 2.4.25 I decided to
> skip this project. Maybe someone pick it up again for 2.7. As already
> pointed out some times, the fake.o driver from Peter Klausler is also
> only a quick hack. So we need something else and the the answer is the
> user level driver support for the input subsystem (uinput) that is
> already merged into Linux 2.6. I have sent a backport to Marcelo for
> inclusion of the uinput driver into 2.4.24 and I hope he will merge it
> very soon. Edd Dumbill has posted a patch for Peter's HID implementation
> to use the uinput driver from 2.6 and so I started to look again at my
> code.
> 
> My current code in CVS and the code from Peter uses forking to have an
> own process for every connection. After some extensive testing I came to
> the conclusion that such code is not very easy to handle and that this
> can also be the problem of the stalled ACL links. We don't need an own
> process for every device and so I started to write some event loop code.
> This event code is mostly tested and finished. And it can be reused for
> some other Bluetooth programs like the new Bluetooth manager. An early
> version is already in the CVS and I will update it as soon as possible.
> I have now rewritten my bthid to use the event loop instead of forking
> and it is working perfect. No stalled connections or other problems so
> far. It is tested with the Microsoft and Logitech diNovo desktops.
> 
> If we don't reuse the HID parser from the USB subsystem we have to write
> our own one. From my point it is not a good idea to maintain two HID
> parser implementations for Linux, because it is double work. However at
> the moment I don't see any other way to get Bluetooth HID working with
> 2.4 and 2.6 and Peter has already done this for his implementation. So I
> decided to take his code and remove all unneeded stuff and hacks. After
> some additional modifications I got it working as expected and I am now
> writing this email with my diNovo Bluetooth keyboard ;)
> 
> At the moment I am cleaning up my new code. This should take only one or
> two days and I will put it into CVS after I am finished. I also like to
> test my code with the Apple keyboard and mouse, but I don't want to buy
> another Bluetooth desktop. I will never us a wireless keyboard, because
> I like my old Microsoft Natural Keyboard that is now over ten years old
> and have seen its fifth desktop machine. So is there anyone who likes to
> sponsor me the Apple Bluetooth solution?
> 
> Regards
> 
> Marcel
