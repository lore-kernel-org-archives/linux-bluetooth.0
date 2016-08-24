Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC PATCH 0/3] UART slave device bus
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160824145714.02bbebb3@lxorguk.ukuu.org.uk>
Date: Wed, 24 Aug 2016 10:29:58 -0400
Cc: Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        NeilBrown <neil@brown.name>,
        "Dr . H . Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <A8AA3046-E635-4697-BA01-86FFFBB5B2E0@holtmann.org>
References: <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com> <20160822180254.5c95af7c@lxorguk.ukuu.org.uk> <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com> <20160822183849.6dfdb9d2@lxorguk.ukuu.org.uk> <2D07EA08-1055-4292-96B3-32913EC9BBE1@holtmann.org> <20160822223223.398ee72d@lxorguk.ukuu.org.uk> <20160822220017.GA10689@amd> <20160822235414.4b2f8712@lxorguk.ukuu.org.uk> <20160822235758.gh33xupgyroye5wa@earth> <20160823011521.0ed94283@lxorguk.ukuu.org.uk> <20160823005749.io6x4oi7muttkhfx@earth> <20160824145714.02bbebb3@lxorguk.ukuu.org.uk>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alan,

>> So you mean if I do "hciconfig hci0 down", then the uart-bus should
>> "down" the tty and only on "hciconfig hci0 up" it should "up" the
>> tty? I would expect a uart-bus slave-device takes control of the
>> device ("up" it) on probe. It's hardwired anyway.
> 
> Today you can switch stacks at runtime, you can switch between the kernel
> stack and debug tools at runtime. Breaking that is a regression.

actually that is not true. We have HCI User Channel since a long time that gives you raw access to the devices. And also kernel interfaces to do all vendor / debug tasks.

Regards

Marcel
