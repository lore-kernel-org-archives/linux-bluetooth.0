Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: Add
 broadcom-bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <4c23bcb6-1b90-c41e-6e47-7d8315e760ae@gmail.com>
Date: Wed, 23 Aug 2017 16:19:56 +0200
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, f.fainelli@gmail.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        devicetree@vger.kernel.org
Message-Id: <9BD5C644-6B89-496C-B442-F276D7A99102@holtmann.org>
References: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com>
 <20170822074726.e424lflqxn6mb4xd@flea.lan>
 <f2fcf522-cd1e-e748-0ee7-ad28bbf8ae5d@i2se.com>
 <4c23bcb6-1b90-c41e-6e47-7d8315e760ae@gmail.com>
To: Loic Poulain <loic.poulain@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

>>> Thanks a lot for working on that, I've made a similar attempt a few
>>> weeks ago but didn't manage to get it to work.
>>> 
>>> The way it's hooked in our boards is a bit more complex though, even
>>> if it could be because we're using a different part.
>>> 
>>> In order to get it running we need:
>>>   - two clocks, called in the broadcom datasheets lpo and tcxo.
>>>   - three GPIOs, device wakeup, host wakeup and a shutdown GPIO (which
>>>     might be the BT_ON you were discussing about)
>>>   - two regulators called vbat and reg-en for us (I guess they're
>>>     meant to power the chip, and its registers >>
>>> Do you know if you're also using those? Or could it be that it's just
>>> hardwired to some non-gatable crystal / regulator on the RPI?
> 
> Not on Pi3, but the three gpios and the clock are pretty common for
> Broadcom bt controller (cf v4 of dt-bindings patch).

once we get the GPIO expander driver upstream, I think we also need this for RPI 3 and Zero W. Right now we can just not do anything about this.

However we can start looking at the PCM setup and see how that one is wired up and see if we can feed that into ALSA or wherever they terminate that.

> This is already partially supported in the hci_bcm driver.
> Today this driver registers a platform_driver(legacy/ACPI) and a
> serdev_device_driver (new/DT).
> 
> The platform driver retrieves the gpios and mainly uses them in pm ops.
> Once the ACPI for serdev will be supported, this plat driver should be
> removed.
> 
> The serdev driver does no support this yet because I used the RPi3
> as dev platform. But this is something we want to have as well.

Making ACPI serdev aware and turning BTH0 into serdev nodes is really the next step. That would allow us to simplify the drivers and remove duplicate code. Do you still have access to ACPI based tablets with Broadcom chips? It would be great if you can take a stab at this.

Regards

Marcel

