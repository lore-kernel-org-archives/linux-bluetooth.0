Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <A9EA833E-DDDE-46FB-917C-30CF00A70A6C@holtmann.org>
References: <1471058078-5579-1-git-send-email-sre@kernel.org> <A9EA833E-DDDE-46FB-917C-30CF00A70A6C@holtmann.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 16 Aug 2016 15:22:45 -0500
Message-ID: <CAL_JsqJ9FG0KeyDTbwvMwq+bcoVTMusGrcTT52e3jdfmX2j19w@mail.gmail.com>
Subject: Re: [RFC 0/7] Nokia N9xx bluetooth driver
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>,
	=?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-bluetooth@vger.kernel.org,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 16, 2016 at 2:10 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Sebastian,
>
>> This series (based von 4.8-rc1) adds support for bluetooth on the Nokia
>> N9xx devices. It has been tested on the Nokia N950, where it works
>> correctly. On Nokia N900 it currently fails during negotiation
>> (probably related to slightly incorrect serial settings/timings).
>> The N900's bcm2048 correctly answeres to alive check even before
>> negotiation (on N950 it does not work before negotiation), but replies
>> with an Hardware error event to the negotiation packet.
>>
>> Apart from N900 support there are still two "features" missing in the
>> driver:
>>
>> 1. To save energy the bluetooth module can be put into sleep mode via a
>>   GPIO. This gpio should be enabled before sending data via UART and
>>   disabled once the transmission is done. I currently just keep the
>>   GPIO always enabled.
>> 2. It would be nice to have a bluetooth device exposed by the kernel
>>   automatically without having to setup the tty disector first for
>>   proper configurationless out of the box support. I could not find
>>   a nice way to do this from the kernel, though.
>
> currently using the HCI line discipline is the only way to attach a Bluetooth device to a serial line / UART.
>
> However I have been advocating for a serial bus or UART bus for a long time now. It is needed especially for Bluetooth devices which have no business in being exposed as TTYs in the first place.
>
> This is true for the ACPI and DT world actually. Some UARTs should not be exposed as TTY and just be stuck on a bus that can be enumerated and matched by a driver that knows how to handle it.

To add to this, my initial thought has been to split off uart_port ops
for use by the uart bus/subsystem so we can reuse all the uart
drivers. Then driver ports can be registered either with the tty layer
or the uart bus (or perhaps registered with both and claimed by one
later). This is somewhat already done with the serio subsys (see
drivers/tty/serial/sunsu.c). I thought extending serio might be an
option, but it's data handling is pretty limited.

The transmit side seems pretty straightforward. The receive side is a
bit more complex as the buffering is all in the tty layer. It doesn't
seem so straightforward to share the tty buffer handling code. Perhaps
at least initially, a more simple buffering scheme can be used given
the packet oriented nature of the device protocols.

Rob
