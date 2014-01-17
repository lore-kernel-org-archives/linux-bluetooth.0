Return-Path: <cyrus@holtmann.org>
Message-ID: <ad05002fcc8e067d1f4a14321cddbc83.squirrel@mungewell.org>
In-Reply-To: <CANq1E4TaM-eG5rBU8X2T9ux8fMgTCyaXpxF2ydZU=71QsX0UBQ@mail.gmail.com>
References: <8ccf0ad88f16335719c367ed69c90a3e.squirrel@mungewell.org>
    <CANq1E4TaM-eG5rBU8X2T9ux8fMgTCyaXpxF2ydZU=71QsX0UBQ@mail.gmail.com>
Date: Fri, 17 Jan 2014 15:17:36 -0500
Subject: Re: Dualshock4 - 'HIDP: Handshake: Unsupported request' after
 'unplug virtual cable'.
From: simon@mungewell.org
To: "David Herrmann" <dh.herrmann@gmail.com>
Cc: "Simon Wood" <simon@mungewell.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Frank Praznik" <frank.praznik@oh.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> So the problem is, your host refuses the HIDP connection from the
> device. This is intentional, as we don't want *any* remote Bluetooth
> device to be allowed to provide HID services. This could be used for
> very subtle attacks. The code responsible for that is
> ./profiles/input/server.c in bluez.

I note that there is now some DS3/SixAxis specfic stuff in there:
http://git.kernel.org/cgit/bluetooth/bluez.git/tree/profiles/input/server.c#n167

> Now, there are two ways to go on:
>  - try to initiate the HIDP connection from the host instead of the
> device. Simply use "bluetoothctl" and then "connect <bdaddr>"
>  - add the remote device to the list of known devices so incoming
> connections are not blocked. You can do this by triggering the
> ->device_probe() callback of the input device. I'm not sure how this
> is done, but I think a simple "connect <bdaddr>" should trigger it on
> *all* available services.

Thanks for your suggestions, I'll try to get some logs early next week.

Cheers,
Simon

