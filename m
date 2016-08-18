Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Date: Thu, 18 Aug 2016 16:15:27 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring
 <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Sebastian Reichel
 <sre@kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>, NeilBrown
 <neil@brown.name>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij
 <linus.walleij@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, herkne@gmx.de
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Message-ID: <20160818161527.4f24bd92@lxorguk.ukuu.org.uk>
In-Reply-To: <951C95FD-35DD-4EC5-A62C-31378B85EF14@holtmann.org>
References: <20160818011445.22726-1-robh@kernel.org>
	<118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com>
	<28DDAF2B-2341-403B-80D8-DA0A63F51FF1@holtmann.org>
	<20160818105521.GB7031@kroah.com>
	<20160818111046.GE7427@amd>
	<A8AFECE4-8501-4186-A834-5E08EEE8A0C4@goldelico.com>
	<951C95FD-35DD-4EC5-A62C-31378B85EF14@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

> > Indeed. In such a case the translation should be done in the kernel.
> > But it is not necessary for devices that already provide NEMA over UART.
> > Still user-space should be able to tcsetattr how it wants to see the records
> > (mainly CR/LF translations).  
> 
> I disagree here. NMEA is a standard and the kernel should just enforce framing of NMEA sentences. It makes no difference what the CR/LF is. Userspace gets full sentences.

GPS drivers for anything that's dumb are binary only. They have to
contain specific checks so that people can't buy them from amazon and
attach them to missles.

Alan
