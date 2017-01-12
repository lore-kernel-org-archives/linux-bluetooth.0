Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170110214617.GB2053@amd>
References: <20170106162635.19677-1-robh@kernel.org> <20170106162635.19677-8-robh@kernel.org>
 <20170110214617.GB2053@amd>
From: Rob Herring <robh@kernel.org>
Date: Thu, 12 Jan 2017 13:53:15 -0600
Message-ID: <CAL_Jsq+geRqdkDwn6Coukin5EeA2aZreK81KpHx+u0SDkgoJvQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] serdev: Introduce new bus for serial attached devices
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sebastian Reichel <sre@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Dr . H . Nikolaus Schaller" <hns@goldelico.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Loic Poulain <loic.poulain@intel.com>,
        NeilBrown <neil@brown.name>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 10, 2017 at 3:46 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> +static void serdev_ctrl_release(struct device *dev)
>> +{
>> +     struct serdev_controller *ctrl = to_serdev_controller(dev);
>> +     ida_simple_remove(&ctrl_ida, ctrl->nr);
>> +     kfree(ctrl);
>> +}
>
> Would it make sense to do something like to_serdev_controller(dev) =
> NULL; there?

That would be the same as adding "ctrl = NULL;" which would be
pointless. The struct device is embedded into serdev_controller.

Rob
