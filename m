Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Date: Thu, 18 Aug 2016 16:16:36 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Sebastian
 Reichel <sre@kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij
 <linus.walleij@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, herkne@gmx.de
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Message-ID: <20160818161636.0ef634a7@lxorguk.ukuu.org.uk>
In-Reply-To: <FC7E1385-941F-4CC5-BE3C-A80828370A58@holtmann.org>
References: <20160818011445.22726-1-robh@kernel.org>
	<118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com>
	<28DDAF2B-2341-403B-80D8-DA0A63F51FF1@holtmann.org>
	<20160818105521.GB7031@kroah.com>
	<20160818111046.GE7427@amd>
	<FC7E1385-941F-4CC5-BE3C-A80828370A58@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 18 Aug 2016 13:47:44 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Pavel,
> 
> >>> I am actually not convinced that GPS should be represented as
> >>> /dev/ttyS0 or similar TTY. It think they deserve their own driver
> >>> exposing them as simple character devices. That way we can have a
> >>> proper DEVTYPE and userspace can find them correctly. We can also
> >>> annotate them if needed for special settings.  
> >> 
> >> I would _love_ to see that happen, but what about the GPS line
> >> discipline that we have today?  How would that match up with a char
> >> device driver?  
> > 
> > ./drivers/usb/serial/garmin_gps.c ?
> > 
> > Hmm, some cleanups would be welcome there... plus it would be good to
> > know what is its interface to userland... it is not easily apparent
> > from the code.  
> 
> however that driver is not a line discipline. That is just an USB driver. But I agree if we create a GPS driver framework / subsystem, then this one should be converted into using it.

You can't convert it - you can duplicate it or pipe the data into an
additional driver, but converting it would break back compatibility for
existing configurations and violate Linus no regressions rule.

Alan
