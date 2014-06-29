Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Jun 2014 08:14:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ryan Press <ryan@presslab.us>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: LE mouse reconnect problem
Message-ID: <20140629051442.GA31085@t440s.P-661HNU-F1>
References: <CABx3TkUE_qFJggDNw8wUCcQzrdo6L5p3Ag3djpiUewwk_uJu5Q@mail.gmail.com>
 <CABBYNZLhONv81vAN8OAFX1dK5UCm44AYb2sZLyUp2gRQ4CywcA@mail.gmail.com>
 <CABx3TkVgs6J1UR8Z5Rbyd2e90p74RfggpzsvnxzgWGgN9c2Epg@mail.gmail.com>
 <CABx3TkUbD+svVpNW+0vjWS3pujZsECTOO0XxJmUQY6wOEkkZQw@mail.gmail.com>
 <CABBYNZKyd_jgSO-NpzbMhVo=Y1ZzWC29bX4q1YBQd73Mm4HWaQ@mail.gmail.com>
 <CABx3TkW-PhVeD2=Nr2pj5iL2uUm8T0B+w+WFB2EwaeW7OtChtQ@mail.gmail.com>
 <CABBYNZK2v-US-kOh6v28EKnqsLyjXrDUGpNJE6Wcfqv3YBwm9A@mail.gmail.com>
 <CABx3TkU+JvmekRYBS1iYuriJaprMznH=g6vw2MVYi+2Vqc7Y5w@mail.gmail.com>
 <CABx3TkXsRXUNG4RudXnYifyN4Tq4MssVGXZE6uQtPtxU34bw7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABx3TkXsRXUNG4RudXnYifyN4Tq4MssVGXZE6uQtPtxU34bw7A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ryan,

On Sat, Jun 28, 2014, Ryan Press wrote:
> > It looks like Bluez is using random address and hcitool lescan is
> > using public address.  I don't know why to use random or public.
> >
> > hcitool lescan:
> >     own address: 0x00 (Public) policy: All
> > bluetoothd:
> >     own address: 0x01 (Random) policy: All
> >
> > And the advertise address from the mouse is the same.
> >
> > hcitool:
> >     bdaddr C5:8C:97:E9:9C:81 (Random)
> > bluetoothctl:
> > [NEW] Device C5:8C:97:E9:9C:81 Arc Touch Mouse SE
> >
> >
> > Thanks.
> > Ryan
> 
> Hi Luiz,
> 
> I realized that 3.15+ kernel had the LE Privacy support, so I tried
> 3.14 and my mouse reconnects just fine.  So somehow my mouse does not
> work with the new LE Privacy in the kernel.
> 
> I couldn't find any way to disable this.  It seems that bluetoothd
> just uses the default setting which is LE Privacy enabled.  And I
> couldn't find any way in the kernel to disable it via a module option
> or sysfs.  Is there some other way I can disable this?

What the kernel does is it actually uses a non-resolvable private
address when doing active scanning. You should still be able to get
advertising indications even though you don't get scan responses (as the
remote can only choose to not send you the latter based on your
address). So it's a bit strange you just get complete silence when doing
active scanning with a non-resolvable private address.

It'd be interesting to know whether passive scanning discovers the
device (it should). This is what we should be using, but as the kernel
interface for it is not yet ready we're reusing the Start Discovery mgmt
command which uses active instead of passive scanning.

Btw, it would be *much* better if you used btmon instead of hcidump for
your investigation. It has much more complete decoding of all the
various commands and events. Now we have to guess part of the parameters
that you posted since hcidump doesn't show them.

Johan
