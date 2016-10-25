Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161025215521.5a5uxjpujmoatgor@earth>
References: <20160824232437.9446-1-robh@kernel.org> <20161025215521.5a5uxjpujmoatgor@earth>
From: Rob Herring <robh@kernel.org>
Date: Tue, 25 Oct 2016 17:02:23 -0500
Message-ID: <CAL_JsqJQqkyz99SY=RcQ22ZzsQSuCjFkjEPLdEqLmJU-usBf-g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] UART slave devices using serio
To: Sebastian Reichel <sre@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>,
	Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	"Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>,
	Linus Walleij <linus.walleij@linaro.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 25, 2016 at 4:55 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Wed, Aug 24, 2016 at 06:24:30PM -0500, Rob Herring wrote:
>> This is a new approach to supporting UART slave devices using the
>> existing serio bus. After Arnd's proding, I took another look at serio
>> and decided extending it does make sense. Using serio primarily requires
>> adding DT based device matching and supporting buffer based write and
>> receive.
>>
>> Currently, I'm using the existing serio serport ldisc for testing. This
>> requires using inputattach to open the tty and set the ldisc which in
>> turn registers a serio port with the serio core:
>>
>> inputattach -bare /dev/ttyAMA1
>>
>> Once a tty_port based serio port driver is in place, this step will not
>> be needed. Supporting cases like a USB UART will also work if the USB
>> UART is described in DT. If not described in DT, I'm not sure if the
>> existing serio manual binding is sufficient (Need to figure out how that
>> works). Slave drivers also need other ways to specify additional data
>> using module params perhaps. Getting DT overlays to work for
>> non-discoverable devices behind discoverable buses (i.e. detached from
>> a base DT) is another option, but that's not yet supported in general.
>>
>> I've done all the serio changes in place, but ultimately I think at
>> least the core of serio should be moved out of drivers/input/. I don't
>> think it belongs under drivers/tty/ or drivers/tty/serial/, so
>> drivers/serio/?
>>
>> BT is working under QEMU to the point a slave driver can bind to a
>> serio port device via DT, register as a BT device, start sending out
>> initial packets and receive data (typed at a terminal). Now I need to
>> find a real device.
>
> I had a more detailed look at the series during the last two weeks.
> For me the approach looks ok and it should work for the nokia bluetooth
> use case. Actually my work on that driver is more or less stalled until
> this is solved, so it would be nice to get this forward. Whose feedback
> is this waiting from? I guess

I think it is mainly waiting for me to spend more time on it and get
the tty port part done. I could use help especially for converting the
BT part properly.

>  * Alan & Greg for the serial parts
>  * Marcel for the bluetooth parts
>  * Dmitry for the serio parts
>
> Maybe you can try to find some minutes at the Kernel Summit to talk
> about this?

Still waiting for my invite...

But I will be at Plumbers if folks want to discuss this.

Rob
