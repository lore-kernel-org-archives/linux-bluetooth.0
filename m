Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC 0/7] Nokia N9xx bluetooth driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1471058078-5579-1-git-send-email-sre@kernel.org>
Date: Tue, 16 Aug 2016 09:10:54 +0200
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>,
	=?utf-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Pavel Machek <pavel@ucw.cz>,
	=?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
	ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <A9EA833E-DDDE-46FB-917C-30CF00A70A6C@holtmann.org>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

> This series (based von 4.8-rc1) adds support for bluetooth on the Nokia
> N9xx devices. It has been tested on the Nokia N950, where it works
> correctly. On Nokia N900 it currently fails during negotiation
> (probably related to slightly incorrect serial settings/timings).
> The N900's bcm2048 correctly answeres to alive check even before
> negotiation (on N950 it does not work before negotiation), but replies
> with an Hardware error event to the negotiation packet.
> 
> Apart from N900 support there are still two "features" missing in the
> driver:
> 
> 1. To save energy the bluetooth module can be put into sleep mode via a
>   GPIO. This gpio should be enabled before sending data via UART and
>   disabled once the transmission is done. I currently just keep the
>   GPIO always enabled.
> 2. It would be nice to have a bluetooth device exposed by the kernel
>   automatically without having to setup the tty disector first for
>   proper configurationless out of the box support. I could not find
>   a nice way to do this from the kernel, though.

currently using the HCI line discipline is the only way to attach a Bluetooth device to a serial line / UART.

However I have been advocating for a serial bus or UART bus for a long time now. It is needed especially for Bluetooth devices which have no business in being exposed as TTYs in the first place.

This is true for the ACPI and DT world actually. Some UARTs should not be exposed as TTY and just be stuck on a bus that can be enumerated and matched by a driver that knows how to handle it.

This goes along with the weird fetish to expose certain Bluetooth GPIOs as RFKILL switches. They are not that either since they just power the UART. They have nothing to do with a radio RFKILL switch. We fixed the Intel and Broadcom ones to be mapped into the driver. Having a proper bus would make this one also a lot easier.

Regards

Marcel
