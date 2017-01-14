Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170110220445.GC2053@amd>
References: <20170106162635.19677-1-robh@kernel.org> <20170106162635.19677-9-robh@kernel.org>
 <20170110220445.GC2053@amd>
From: Rob Herring <robh@kernel.org>
Date: Fri, 13 Jan 2017 20:54:59 -0600
Message-ID: <CAL_JsqKFL_19p9rsXAuc=c2SpHZK0zGW4zkqwLUX+uA81c8iXQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] serdev: add a tty port controller driver
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>,
	Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Loic Poulain <loic.poulain@intel.com>, NeilBrown <neil@brown.name>,
	Linus Walleij <linus.walleij@linaro.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 10, 2017 at 4:04 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> +MODULE_AUTHOR("Rob Herring <robh@kernel.org");
>
> Missing ">".

Actually, this I should drop because this driver can not be a module.
The bus can be though.

Rob
