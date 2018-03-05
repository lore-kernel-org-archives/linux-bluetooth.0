Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 3/4] ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial
 slave
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAMZdPi8ab7n0B9qYyZaJAGf4qRH8eYXcUJ=B8pyvyLWyaNVX+Q@mail.gmail.com>
Date: Mon, 5 Mar 2018 11:04:00 +0100
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rob Herring <robh+dt@kernel.org>,
        Eric Anholt <eric@anholt.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Elwell <phil@raspberrypi.org>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
        Linux Bluetooth mailing list
        <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Message-Id: <19717EF2-FC8D-4F2B-B198-4D582FD743E8@holtmann.org>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
 <1519567855-26105-4-git-send-email-stefan.wahren@i2se.com>
 <84F7E645-59B4-4618-8C91-A5CD654E16A6@holtmann.org>
 <648118289.71086.1519593373795@email.1und1.de>
 <9D6209F2-5389-4F4E-844D-6A8683044F88@holtmann.org>
 <395166283.280598.1520200683559@email.1und1.de>
 <423BE2B6-2209-4390-B420-FA7267318A09@holtmann.org>
 <1219888621.198216.1520231304685@email.1und1.de>
 <524739BF-BD94-4276-BDAB-31B4944D24C3@holtmann.org>
 <CAMZdPi8ab7n0B9qYyZaJAGf4qRH8eYXcUJ=B8pyvyLWyaNVX+Q@mail.gmail.com>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> > >>
> > >> that is weird since we should be either in a probe context or in hdev->open context and both can sleep as far as I know.
> 
> Yes but this is an explicit warning in gpiolib based on gpio controller capabilities,
> not on current context (WARN_ON(desc->gdev->chip->can_sleep)).
> 
> So, since we are always in process/thread context here, it seems safe to use the _cansleep version.

can someone whip up a patch for it and quickly test it.

Regards

Marcel

