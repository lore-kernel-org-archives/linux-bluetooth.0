Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160822180254.5c95af7c@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org> <12886761.WF058qtZp8@wuerfel>
 <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
 <2775954.hrE2UdODgU@wuerfel> <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com>
 <20160822180254.5c95af7c@lxorguk.ukuu.org.uk>
From: Rob Herring <robh@kernel.org>
Date: Mon, 22 Aug 2016 12:30:27 -0500
Message-ID: <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>,
	Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>,
	NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 22, 2016 at 12:02 PM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
>> > I think there are two other valuable features provided by serio:
>> >
>> > - an existing set of drivers written to the API
>> > - the implementation of the tty_ldisc
>>
>> True, though I'd expect little of the data flow part of it to be reused.
>
> Then your design is broken.

I'm talking about serio, not my design which I already said the
receive side at least needs work.

The serio API for rx and tx is a single character at a time. I thought
we agreed that's not sufficient for things like BT.

>> - a child of the uart node
>> - a reg property containing the line number if the parent has multiple
>> uarts (I'd expect this to rarely be used).
>
> That surprises me as for current x86 platforms it would be the norm,
> except that we use ACPI.

Exactly, we're talking DT bindings here. Each port will be a separate
node otherwise things like serial aliases and stdout-path won't work
correctly. Compatible strings for 8250 uarts are for a single port.
But if you had h/w such that it has common and per port registers then
it may be a single node. I'm not aware of any example offhand (maybe
PPC CPM). But it doesn't matter as reg can handle this case just fine
if we need to.

>> - baudrate and other line configuration (though I would expect the
>> slave driver to know all this and set it w/o DT. Also, we already have
>> a way to set baudrate in the parent node at least.)
>> - other standard device properties for interrupt, gpios, regulators.
>>
>> Also to consider is whether muxing of multiple slaves is needed. It's
>> not anything I've seen come up, but it's not hard to imagine. I think
>> that can be considered later and shouldn't impact the initial binding
>> or infrastructure.
>
> You can describe the child of the serial device as a mux and the children
> of the mux as whatever so it comes out fine when you get to that point.

Yes, that's what I had in mind.

Rob
