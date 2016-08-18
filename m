Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC PATCH 0/3] UART slave device bus
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20160818111046.GE7427@amd>
Date: Thu, 18 Aug 2016 13:18:25 +0200
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>,
	Sebastian Reichel <sre@kernel.org>,
	Peter Hurley <peter@hurleysoftware.com>,
	NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, herkne@gmx.de
Message-Id: <A8AFECE4-8501-4186-A834-5E08EEE8A0C4@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com> <28DDAF2B-2341-403B-80D8-DA0A63F51FF1@holtmann.org> <20160818105521.GB7031@kroah.com> <20160818111046.GE7427@amd>
To: Pavel Machek <pavel@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> Am 18.08.2016 um 13:10 schrieb Pavel Machek <pavel@ucw.cz>:
> 
> Hi!
> 
>>> I am actually not convinced that GPS should be represented as
>>> /dev/ttyS0 or similar TTY. It think they deserve their own driver
>>> exposing them as simple character devices. That way we can have a
>>> proper DEVTYPE and userspace can find them correctly. We can also
>>> annotate them if needed for special settings.
>> 
>> I would _love_ to see that happen, but what about the GPS line
>> discipline that we have today?  How would that match up with a char
>> device driver?
> 
> ./drivers/usb/serial/garmin_gps.c ?
> 
> Hmm, some cleanups would be welcome there... plus it would be good to
> know what is its interface to userland... it is not easily apparent
> from the code.
> 
> Actually, having some kind of common support for GPSes in the kernel
> would be nice. (Chardev that spits NMEA data?

Yes and no. How do you apply tcsetattr to such a device? More or less
by implementing another tty stack?

> ) For example N900 GPS is
> connected over network (phonet) interface, with userland driver
> translating custom protocol into NMEA. Not very nice from "kernel
> should provide hardware abstraction" point of view.

Indeed. In such a case the translation should be done in the kernel.
But it is not necessary for devices that already provide NEMA over UART.
Still user-space should be able to tcsetattr how it wants to see the records
(mainly CR/LF translations).

BR,
Nikolaus
