Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5050F5A9.5090401@butterbrot.org>
References: <5050F5A9.5090401@butterbrot.org>
Date: Wed, 12 Sep 2012 23:10:45 +0200
Message-ID: <CANq1E4RYuVy2b1GD2E4MsErbkGZgD6gnDaYeDmyWyYnKaze0Jg@mail.gmail.com>
Subject: Re: Wii Balance Board vs. bluez
From: David Herrmann <dh.herrmann@googlemail.com>
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian

On Wed, Sep 12, 2012 at 10:50 PM, Florian Echtler <floe@butterbrot.org> wrote:
> Hello everyone,
>
> I'm having some issues getting the Wii Balance Board to work with a recent
> Linux Bluetooth stack (Ubuntu 12.04, Kernel 3.2, bluez-4.101).
>
> After some minor patching [1], I've successfully paired the board with my
> machine. Automatic reconnect (when hitting the large front button) is also
> working.

Awesome. Automatic reconnect was a horrible mess to get working under
Linux but great to hear it works for others, too.

> However, the hid-wiimote driver, even the one I "backported" from kernel
> 3.5, apparently doesn't really support the balance board so far. I do get 5
> new device nodes as /dev/input/event*, but none of them actually report any
> data from the weight sensors.

"backported"? Why would you backport the hid-wiimote driver? Or do you
mean "forwardport"? Anyway, the hid-wiimote driver does not have
support for the wii-balance board as I do not have access to them.
However, if you are willing to test it, I will send some patches which
will implement it.

> Alternatively, I've tried the cwiid userspace library. This does work,
> however, I have to un-pair the board from bluetoothd first and put it into
> discoverable mode using the button on the bottom side, which is pretty
> inconvenient. If I keep the pairing active, the board will reconnect to
> bluetoothd itself and cwiid can't open a second L2CAP connection, AFAICT.

Yes, cwiid includes support for it but it is horribly written and a
3rd party application which doesn't utilize the kernel HID or bluez
infrastructure.

> So, my two questions are:
>
> - Is anybody currently working on integrating the balance board into
> hid-wiimote?

I am maintaining the hid-wiimote driver, but I am not particularly
working on balance-board support, yet. I am willing to do that, though
;)

> - Is there a way to retrieve the existing automatic connection from
> bluetoothd and pass it to a second userspace process (i.e., cwiid)?

No. No way. This is why I have written hid-wiimote.

>
> [1] https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/1049266

Ouh, I see. I will send a patch fixing this to the BlueZ mailing list.
I will put you on CC if you don't mind.

Thanks for the report!
David
